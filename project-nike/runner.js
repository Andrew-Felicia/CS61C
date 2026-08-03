"use strict";

import spawn from "@npmcli/promise-spawn";
import fs from "fs/promises";
import path from "path";
import url from "url";

const MAX_OUTPUT_HEAD_LEN = 512;
const MAX_OUTPUT_TAIL_LEN = 512;

const __dirname = url.fileURLToPath(new URL(".", import.meta.url));
const hiveTestSource = `${process.env.HOME}/su25/lab08/autograder/tests`;


async function exists(path) {
  return await fs
    .stat(path)
    .then(() => true)
    .catch(() => false);
}

async function runTestIter(
  logger,
  test,
  runDir,
  timeout,
  checkCorrectness = true
) {
  await spawn(
    "bash",
    [
      path.join(__dirname, "..", "tools", "delete_output.sh"),
      path.join(runDir, "tests", test.input_name),
    ],
    {
      cwd: runDir,
      stdio: ["ignore", "pipe", "pipe"],
      stdioString: true,
      timeout: 10000,
    }
  );

  const execCmd = [
    "setarch",
    "x86_64",
    "-R",
    "bash",
    path.join(__dirname, "..", "tools", "run_test.sh"),
    ...([]),
    `./convolve_${test.coordinator}_${test.compute}`,
    path.join(runDir, "tests", test.input_name, "input.txt"),
  ];
  let execResult;
  try {
    execResult = await spawn(execCmd.shift(), execCmd, {
      cwd: runDir,
      env: {
        ...process.env,
        OMP_THREAD_LIMIT: "4",
        OMP_PLACES: "cores",
        OMP_PROC_BIND: "true",
      },
      stdio: ["ignore", "pipe", "pipe"],
      stdioString: true,
      timeout: timeout,
    });
  } catch (err) {
    if (err.signal === "SIGTERM" || err.code === 143) {
      return {
        correct: false,
        timed_out: true,
      };
    }
    throw err;
  }

  const runtime = parseInt(
    execResult.stdout
      .trim()
      .split("\n")
      .pop()
      .match(/Time elapsed: (\d+)ms/)?.[1]
  );

  if (checkCorrectness) {
    try {
      await spawn(
        "bash",
        [
          path.join(__dirname, "..", "tools", "check_output.sh"),
          path.join(runDir, "tests", test.input_name),
          path.join(hiveTestSource, test.input_name),
        ],
        {
          cwd: runDir,
          stdio: ["ignore", "pipe", "pipe"],
          stdioString: true,
          timeout: 120000,
        }
      );
    } catch (err) {
      if (err.code === 61) {
        return {
          correct: false,
          timed_out: false,
          error: {
            stdout: cleanOutputStr(err.stdout),
            stderr: cleanOutputStr(err.stderr),
            code: err.code,
            error: "output does not match reference",
            public_error: "Output file does not match reference!",
          },
        };
      } else if (err.code === 62) {
        return {
          correct: false,
          timed_out: false,
          error: {
            stdout: cleanOutputStr(err.stdout),
            stderr: cleanOutputStr(err.stderr),
            code: err.code,
            error: "output does not match reference",
            public_error: "Output file not found!",
          },
        };
      }
      throw err;
    }
  }

  return {
    correct: true,
    timed_out: false,
    runtime,
  };
}

async function runTest(logger, test, runDir) {
  logger.info(`[runner/${test.slug}] starting test`);

  const testResults = { error: {}, data: {} };

  // compile
  try {
    await spawn("make", {
      cwd: runDir,
      env: {
        ...process.env,
        COORDINATOR: test.coordinator,
        COMPUTE: test.compute,
      },
      stdio: ["ignore", "pipe", "pipe"],
      stdioString: true,
      timeout: 20000,
    });
  } catch (err) {
    logger.info(`[runner/${test.slug}] test errored during compilation`);
    testResults.error.error = "test errored during compilation";
    testResults.error.public_error = "We were unable to compile your program.";
    if (err.message === "command failed") {
      testResults.error.code = err.code;
      testResults.error.signal = err.signal;
      testResults.error.stdout = cleanOutputStr(err.stdout);
      testResults.error.stderr = cleanOutputStr(err.stderr);
    } else {
      console.error(err);
      testResults.error.stack = err.stack;
    }
    return testResults;
  }

  const runtimes = [];
  let timeLeft = test.timeout * 1000;
  for (let i = 0; i < test.iterations; i++) {
    logger.debug(
      `[runner/${test.slug}] running iter ${i + 1}/${test.iterations}`
    );
    try {
      const result = await runTestIter(logger, test, runDir, timeLeft, i === 0);
      logger.debug(
        `[runner/${test.slug}] iter ${i + 1} completed (correct: ${
          i === 0 ? result.correct : "skipped"
        }, timed out: ${result.timed_out}, runtime ${result.runtime})`
      );

      if (result.timed_out) break;
      if (!result.correct) {
        testResults.data.correct = false;
        testResults.data.timed_out = false;
        testResults.data.runtime = [];
        testResults.error = result.error;
        return testResults;
      }
      runtimes.push(result.runtime);
      timeLeft -= result.runtime;
      if (timeLeft < result.runtime * 0.75) break;
    } catch (err) {
      logger.info(`[runner/${test.slug}] test runner errored in iter ${i + 1}`);
      testResults.error.error = `test runner errored in iter ${i + 1}`;
      testResults.error.public_error = `Your program returned a non-zero exit code!`;
      if (err.message === "command failed") {
        testResults.error.error = `program returned non-zero exit code in iter ${
          i + 1
        }`;
        testResults.error.public_error = `Your program returned a non-zero exit code!`;
        testResults.error.code = err.code;
        testResults.error.signal = err.signal;
        testResults.error.stdout = cleanOutputStr(err.stdout);
        testResults.error.stderr = cleanOutputStr(err.stderr);
      } else if (err.signal === "SIGTERM") {
        testResults.error.error = `test runner timed out in iter ${i + 1}`;
        testResults.error.public_error = `The autograder timed out while running your program!`;
        testResults.error.stdout = cleanOutputStr(err.stdout);
        testResults.error.stderr = cleanOutputStr(err.stderr);
      } else {
        console.error(err);
        testResults.error.error = `test runner returned non-zero exit code in iter ${
          i + 1
        }`;
        testResults.error.stack = err.stack;
      }
      return testResults;
    }
  }

  testResults.data.correct = true;
  testResults.data.timed_out = runtimes.length === 0;
  testResults.data.runtimes = runtimes;

  logger.info(
    `[runner/${test.slug}] finished ${testResults.data.runtimes.length} iterations`
  );

  return testResults;
}

async function runJob(logger, job, jobDir) {
  const jobResults = { meta: {}, data: {}, preserve_workdir: false };
  let nikeInputs;

  try {
    nikeInputs = JSON.parse(
      await fs.readFile(path.join(jobDir, "submission", "nike_inputs.json"))
    );
  } catch (err) {
    if (!jobResults.meta.error) {
      jobResults.meta.error = "could not read nike_inputs.json";
      jobResults.meta.stderr = err.stack ?? err.toString();
    }
    return jobResults;
  }

  logger.info(`[runner] setting up rundir`);

  const jobRunDir = path.join(jobDir, "rundir");
  if (await exists(jobRunDir)) await fs.rm(jobRunDir, { recursive: true });
  await fs.mkdir(jobRunDir, { recursive: true });

  try {
    await fs.cp(path.join(__dirname, "..", "starter"), jobRunDir, {
      recursive: true,
    });
  } catch (err) {
    if (!jobResults.meta.error) {
      logger.info(`[runner] could not copy starter files`);
      jobResults.meta.error = "could not copy starter files";
      jobResults.meta.stderr = err.stack ?? err.toString();
    }
    return jobResults;
  }

  try {
    await fs.cp(path.join(jobDir, "submission"), jobRunDir, {
      recursive: true,
      force: true,
    });
  } catch (err) {
    if (!jobResults.meta.error) {
      logger.info(`[runner] could not copy submission files`);
      jobResults.meta.error = "could not copy submission files";
      jobResults.meta.stderr = err.stack ?? err.toString();
    }
    return jobResults;
  }

  logger.info(`[runner] copying tests`);

  const testDir = path.join(jobRunDir, "tests");
  if (await exists(testDir)) await fs.rmdir(testDir);
  await fs.mkdir(testDir, { recursive: true });

  try {
    await fs.cp(hiveTestSource, testDir, {
      recursive: true,
    });
  } catch (err) {
    if (!jobResults.meta.error) {
      logger.info(`[runner] could not copy test input files`);
      jobResults.meta.error = "could not copy test input files";
      jobResults.meta.stderr = err.stack ?? err.toString();
    }
    return jobResults;
  }

  for (const test of nikeInputs.tests) {
    try {
      jobResults.data[test.slug] = await runTest(logger, test, jobRunDir);
    } catch (err) {
      if (!jobResults.meta.error) {
        logger.info(`[runner] could not run test ${test.slug}`);
        jobResults.meta.error = `could not run test ${test.slug}`;
        jobResults.meta.stderr = err.stack ?? err.toString();
      }
      return jobResults;
    }
  }

  return jobResults;
}

export default async function run(logger, job, jobDir) {
  logger.info(`[runner] starting job`, job.getLogInfo());
  const results = await runJob(logger, job, jobDir);
  logger.info(`[runner] completed job`, job.getLogInfo());

  await fs.writeFile(
    path.join(jobDir, "nike_results.json"),
    JSON.stringify(results)
  );

  return results;
}

function cleanOutputStr(str) {
  if (str.length > MAX_OUTPUT_HEAD_LEN + MAX_OUTPUT_TAIL_LEN) {
    str = `${str.substring(
      0,
      MAX_OUTPUT_HEAD_LEN
    )}\n# TRUNCATED #\n${str.substring(str.length - MAX_OUTPUT_TAIL_LEN)}`;
  }
  return str;
}

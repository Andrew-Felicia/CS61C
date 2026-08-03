"use strict";

import dotenv from "dotenv";
dotenv.config();

import fs from "fs/promises";
import path from "path";
import { fetch } from "undici";

const { AUTH_TOKEN, COORDINATOR_ENDPOINT } = process.env;

async function submit(metaFilePath, type, baseDir, filePaths) {
  const files = [];
  for (const filePath of filePaths) {
    try {
      const relativePath = path.relative(baseDir, filePath);
      if (relativePath.includes("..")) {
        console.error(`File is not in base dir: ${filePath}`);
        process.exit(1);
      }
      const file = await fs.readFile(filePath);
      files.push({
        path: relativePath,
        data: file.toString("base64"),
      });
    } catch (err) {
      if (err.code === "ENOENT") {
        console.error(`File not found: ${filePath}`);
        process.exit(1);
      }
      console.error(err);
      process.exit(1);
    }
  }

  const meta = JSON.parse(await fs.readFile(metaFilePath, "utf-8"));

  const submitJobRes = await request("/jobs", {
    method: "POST",
    body: {
      meta: meta,
      files: files,
      type: type,
    },
    retries: 300,
  });
  const submitJobData = await submitJobRes.json();
  const jobID = submitJobData.id;

  let jobData = null;
  // eslint-disable-next-line no-constant-condition
  while (true) {
    const getJobRes = await request(`/jobs/${jobID}`, {
      retries: 300,
    });
    jobData = await getJobRes.json();
    if (jobData.results && jobData.results.data) break;
    await sleep(5000);
  }

  return jobData;
}

async function request(url, options = {}) {
  const headers = Object.assign(
    {
      Authorization: AUTH_TOKEN,
    },
    options.headers
  );
  delete options.headers;

  const originalOptions = options;
  options = Object.assign(
    {
      headers: headers,
    },
    originalOptions
  );
  if (
    options.method === "PATCH" ||
    options.method === "POST" ||
    options.method === "PUT"
  ) {
    options.body = Buffer.from(JSON.stringify(options.body));
    headers["Content-Length"] = String(options.body.length);
    headers["Content-Type"] = "application/json";
  }

  url = new URL(url, COORDINATOR_ENDPOINT);
  try {
    const res = await fetch(url, options);
    if (res.ok) return res;
    const body = res.text();
    if (!originalOptions.retries)
      throw new Error(
        `${options.method} ${url}: HTTP ${res.status} (${JSON.stringify(body)})`
      );
    console.error(
      `${options.method} ${url}: HTTP ${res.status} (${JSON.stringify(body)})`
    );
  } catch (err) {
    if (err.code !== "ECONNRESET" && err.code !== "ECONNREFUSED") throw err;
    if (!originalOptions.retries) throw err;
    console.error(`${options.method} ${url}: ${err.code}`);
  }

  await sleep(1000);
  return request(
    url,
    Object.assign(originalOptions, {
      headers: headers,
      retries: originalOptions.retries - 1,
    })
  );
}
async function sleep(ms) {
  return new Promise((res) => setTimeout(res, ms));
}

(async function init() {
  if (process.argv.length < 6) {
    console.error(
      `Usage: node submit.js <job_type> <meta_file> <base_dir> <file ...>`
    );
    process.exit(1);
  }

  const jobType = process.argv[2];
  const metaFilePath = process.argv[3];
  const baseDir = process.argv[4];
  const filePaths = process.argv.slice(5);
  const response = await submit(metaFilePath, jobType, baseDir, filePaths);
  console.log(JSON.stringify(response));
})().catch(console.error);

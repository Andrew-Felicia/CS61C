from typing import Callable, List
from GradescopeBase import (
    Autograder,
    AutograderTest,
    Test,
    Setup,
)
from GradescopeBase.Utils import root_dir, submission_dir
from pathlib import Path
import json
import math
import os
import re
import subprocess
import shutil
from .utils import (
    TestSuite,
    CorrectnessTest,
    PerformanceTest,
    submit_perf,
    Test as UtilTest,
)

from .config import FEEDBACK_FORM_URL

base_dir = Path("/tmp")
run_dir = base_dir / "run"
submission_dir = Path(submission_dir()) / "lab08"
starter_dir = Path(root_dir()) / "lab08" / "starter-dev"


# Find C files' headers
def find_included_headers(filepath):
    try:
        includes = subprocess.check_output(
            ["gcc", "-I/usr/include/python3.6", "-M", filepath],
            timeout=30,
        ).decode("utf-8")
    except subprocess.SubprocessError:
        import traceback

        traceback.print_exc()
        return set()
    return set(
        filter(lambda x: x.startswith("/usr/"), includes.replace("\\", " ").split())
    )


@Setup("Checking Imports")
def check_imports(ag: Autograder):
    passed = True
    # Check if files are present
    if not os.path.exists(submission_dir / "src" / "compute_naive.c"):
        ag.print("ERROR: Could not find the file compute_naive.c in your submission!")
        passed = False
    if not os.path.exists(submission_dir / "src" / "compute_optimized.c"):
        ag.print(
            "ERROR: Could not find the file compute_optimized.c in your submission!"
        )
        passed = False

    if not passed:
        return False

    print("Validating header imports...")
    # Check for imports
    try:
        expected_compute_naive_imports = find_included_headers(
            starter_dir / "src" / "compute_naive.c"
        )
        expected_compute_optimized_imports = find_included_headers(
            starter_dir / "src" / "compute_optimized.c"
        )

        student_compute_naive_imports = find_included_headers(
            submission_dir / "src" / "compute_naive.c"
        )
        student_compute_optimized_imports = find_included_headers(
            submission_dir / "src" / "compute_optimized.c"
        )
    except subprocess.CalledProcessError:
        import traceback

        traceback.print_exc()
        ag.print("ERROR: Failed to check for valid imports!")

    # Check no extra imports
    no_extra_imports = True
    if student_compute_naive_imports.difference(expected_compute_naive_imports):
        ag.print(
            "ERROR: Your compute_naive.c file has extra imports! You should not have any extra #includes in your code!"
        )
        no_extra_imports = False

    if student_compute_optimized_imports.difference(expected_compute_optimized_imports):
        ag.print(
            "ERROR: Your compute_optimized.c file has extra imports! You should not have any extra #includes in your code!"
        )
        no_extra_imports = False

    if not no_extra_imports:
        return False

    print("Setup - Checking Imports: complete")
    return True


def check_compilation(compute: str, coordinator: str):
    log_tag = f"{coordinator}/{compute}"
    env = os.environ.copy()
    env["COORDINATOR"] = coordinator
    env["COMPUTE"] = compute
    compile_result = subprocess.run(
        ["make"],
        shell=True,
        env=env,
        cwd=run_dir,
        encoding="utf-8",
        capture_output=True,
    )

    print(f"[{log_tag}] compiler returned code {compile_result.returncode}")
    if compile_result.stdout.strip():
        print(f"[{log_tag}] compiler stdout:\n{compile_result.stdout}")
    if compile_result.stderr.strip():
        print(f"[{log_tag}] compiler stderr:\n{compile_result.stderr}")

    if not compile_result or compile_result.returncode != 0:
        print(f"[{log_tag}] error compiling files")
        return False

    return True


banned_apps_regex = "|".join(["gcc", "GCC"])

banned_regexes = [
    re.compile(
        rf'_Pragma\s*\("(?:{banned_apps_regex}).*?"\)|#pragma\s+(?:{banned_apps_regex}).*$',
        re.MULTILINE,
    ),
    re.compile(
        r'__attribute__\s?\(\s?\(\s?optimize\s?\(\s?".*?"\s?\)\s?\)\s?\)', re.MULTILINE
    ),
]


def check_banned_regex(path: Path):
    for regex in banned_regexes:
        file_contents = path.read_text("utf-8")
        if regex.search(file_contents):
            print(f"{path} matches banned regex {regex.pattern}")
            return False
    return True


@Setup("Compilation")
def compilation(ag: Autograder):
    # Make directory
    os.makedirs(base_dir, exist_ok=True)
    os.makedirs(run_dir, exist_ok=True)

    print("Checking that files compile...")
    try:
        shutil.copytree(starter_dir, run_dir, dirs_exist_ok=True)
        shutil.copy2(submission_dir / "src" / "compute_naive.c", run_dir / "src")
        shutil.copy2(submission_dir / "src" / "compute_optimized.c", run_dir / "src")

        if not check_compilation("naive", "naive"):
            ag.print("There was an issue compiling the files!")
            return False
        if not check_compilation("optimized", "naive"):
            ag.print("There was an issue compiling the files!")
            return False

        if (
            not check_banned_regex(submission_dir / "src" / "compute_naive.c")
            or not check_banned_regex(submission_dir / "src" / "compute_optimized.c")
        ):
            ag.print("Your code contains banned statements. Please remove them.")
            return False
        print("Setup - Compilation: completed")
        return True
    except:
        return False


def log_score_fn(goal: float) -> Callable[[float], float]:
    return lambda speedup: min(1, max(0, math.log(speedup) / math.log(goal)))


# commented out all naive
# fmt: off
# Calculation: naive time / staff sol time * 0.9
tests: List[TestSuite] = [
    # TestSuite("Random - Naive",     "naive", "naive",         "test_ag_random", timeout = 30, correctness_test=CorrectnessTest(15), iterations = 1),
    TestSuite("Random - Optimized", "naive", "optimized",     "test_ag_random", timeout = 30, correctness_test=CorrectnessTest(0.1), performance_test=PerformanceTest(0.1, 2900, log_score_fn(7.25)), iterations = 15, leaderboard = True),

    # TestSuite("Increasing - Naive",     "naive", "naive",         "test_ag_increasing", timeout = 45, correctness_test=CorrectnessTest(10), iterations = 1),
    TestSuite("Increasing - Optimized", "naive", "optimized",     "test_ag_increasing", timeout = 45, correctness_test=CorrectnessTest(0.1), performance_test=PerformanceTest(0.1, 5300, log_score_fn(7.14)), iterations = 15),

    # TestSuite("Decreasing - Naive",     "naive", "naive",         "test_ag_decreasing", timeout = 45, correctness_test=CorrectnessTest(10), iterations = 1),
    TestSuite("Decreasing - Optimized", "naive", "optimized",     "test_ag_decreasing", timeout = 45, correctness_test=CorrectnessTest(0.1), performance_test=PerformanceTest(0.1, 4400, log_score_fn(7.70)), iterations = 15),

    # TestSuite("Big and Small - Naive",     "naive", "naive",         "test_ag_big_and_small", timeout = 30, correctness_test=CorrectnessTest(7), iterations = 1),

    # TestSuite("Edge - 1D - Naive",     "naive", "naive",         "test_ag_edge_1d", timeout = 3, correctness_test=CorrectnessTest(2), iterations = 1),
    TestSuite("Edge - 1D - Optimized", "naive", "optimized",     "test_ag_edge_1d", timeout = 3, correctness_test=CorrectnessTest(0.05), iterations = 1),

    # TestSuite("Edge - 1D Matrix B - Naive",     "naive", "naive",         "test_ag_edge_1d_matrix_b", timeout = 3, correctness_test=CorrectnessTest(2), iterations = 1),
    TestSuite("Edge - 1D Matrix B - Optimized", "naive", "optimized",     "test_ag_edge_1d_matrix_b", timeout = 3, correctness_test=CorrectnessTest(0.05), iterations = 1),

    # TestSuite("Edge - 1x1 - Naive",     "naive", "naive",         "test_ag_edge_1x1", timeout = 3, correctness_test=CorrectnessTest(2), iterations = 1),
    TestSuite("Edge - 1x1 - Optimized", "naive", "optimized",     "test_ag_edge_1x1", timeout = 3, correctness_test=CorrectnessTest(0.05), iterations = 1),

    # TestSuite("Edge - 1x1 Matrix B - Naive",     "naive", "naive",         "test_ag_edge_1x1_matrix_b", timeout = 3, correctness_test=CorrectnessTest(2), iterations = 1),
    TestSuite("Edge - 1x1 Matrix B - Optimized", "naive", "optimized",     "test_ag_edge_1x1_matrix_b", timeout = 3, correctness_test=CorrectnessTest(0.05), iterations = 1),
]
# fmt: on


@Setup("Leaderboard Prep")
def check_imports(ag: Autograder):
    for test in tests:
        if test.leaderboard:
            ag.leaderboard.add_item(test.name, -1)

    return True

@Test("Ex 1 Naive Convolutions", 0.1, floor=False)
def filtered_form(ag: Autograder, test: AutograderTest):
    metadata = ag.metadata
    user = metadata["users"][0]
    email = user["email"]

    client_id = "lab-autograder"
    client_secret = "KZJP4BXLMK2LWIWAYYII0JLQE4B11NUVPW57154M945MKIF8CGID33W2J0WM93WL"

    import requests

    r = requests.post(
        "https://auth.apps.cs61a.org/google/read_spreadsheet",
        json={
            "url": FEEDBACK_FORM_URL,  # <--- CHANGE THIS
            "sheet_name": "Lab 8 Ex1 Filtered",  # <--- CHANGE THIS if needed
            "client_name": client_id,
            "secret": client_secret,
        },
    )
    rawData = r.json()

    headerRow = rawData.pop(0)
    emailColName = "Email Address"

    if emailColName not in headerRow:
        test.print(
            "Error: Internal error checking filtered form submissions. Please contact course staff."
        )
        print(f"  Column not found: {emailColName}")
        return -0.1

    entries = {}
    for rawRow in rawData:
        row = {}
        for i in range(len(headerRow)):
            row[headerRow[i]] = rawRow[i] if i < len(rawRow) else None
        entries[row[emailColName]] = row

    if not email:
        test.print("Error: Couldn't find `user.email`. Is this submission active?")
        print("  Error: Couldn't find `user.email`. Is this submission active?")
        return False

    entry = entries.get(email, None)
    if not entry:
        test.print(
            f"Error: Couldn't find your filtered form submission (Gradescope email: '{email}')."
        )
        print(
            f"  Error: Couldn't find your filtered form submission (Gradescope email: '{email}')."
        )
        return False

    test.print("Found your filtered form submission!")
    return True

@Setup("Running Nike")
def run_perf(ag: Autograder):
    print("Running Nike...")

    # Write to perf_inputs.json
    nike_inputs = {"tests": []}
    for test in tests:
        nike_inputs["tests"].append(
            {
                "slug": test.slug,
                "coordinator": test.coordinator,
                "compute": test.compute,
                "input_name": test.input_name,
                "timeout": test.timeout,
                "iterations": test.iterations,
            }
        )
    nike_inputs_path = submission_dir / "nike_inputs.json"
    with open(nike_inputs_path, "w+") as f:
        json.dump(nike_inputs, f)

    succeeded, results = submit_perf(
        "/autograder/submission_metadata.json",
        submission_dir,
        [
            submission_dir / "src" / "compute_naive.c",
            submission_dir / "src" / "compute_optimized.c",
            submission_dir / "nike_inputs.json",
        ],
    )

    print("Fetched nike results")
    print(results)
    if not succeeded:
        print("### Autograder Error ###")
        print("Error:", results.get("error"))
        if results.get("stdout"):
            print("### STDOUT ###")
            print(results.get("stdout"))
        if results.get("stderr"):
            print("### STDERR ###")
            print(results.get("stderr"))
        print("")
        ag.print("An error occured when submitting your submission to the test runner!")
        return False

    job_meta = results.get("meta")
    if job_meta and job_meta.get("error"):
        print("### Autograder Error ###")
        print("Error:", job_meta.get("error"))
        if job_meta.get("stdout"):
            print("### STDOUT ###")
            print(job_meta.get("stdout"))
        if job_meta.get("stderr"):
            print("### STDERR ###")
            print(job_meta.get("stderr"))
        print("")
        ag.print("An error occured when running your submission on the test runner!")
        return False

    all_test_results = results.get("data")
    if not all_test_results:
        print("The test runner did not return any data!")
        ag.print("The test runner did not return any data!")
        return False

    for test in tests:
        if test.slug not in all_test_results:
            print(f"Could not find nike results for {test.slug}")
            ag.print(
                "An error occured when running your submission on the test runner!"
            )
            return False
        test_result = all_test_results[test.slug]
        test_result_error = test_result.get("error")
        test_result_data = test_result.get("data")
        if test_result_error:
            test.nike_error = test_result_error
            continue
        if test_result_data:
            test.nike_data = test_result_data
            continue

        print(f"Could not find nike data for {test.slug}")
        ag.print("An error occured when running your submission on the test runner!")
        return False

    return True


for tst in tests:

    def f(t: TestSuite):
        @Test(t.name, t.points, visibility=t.visibility)
        def test_fn(ag: Autograder, ag_test: AutograderTest):
            print(f"Printing results for {t.name}")

            if t.leaderboard:
                ag.leaderboard.add_item(t.name, 0)

            if t.nike_error:
                print("### Autograder Error ###")
                print("Error:", t.nike_error.get("error"))
                if t.nike_error.get("stdout"):
                    print("### STDOUT ###")
                    print(t.nike_error.get("stdout"))
                if t.nike_error.get("stderr"):
                    print("### STDERR ###")
                    print(t.nike_error.get("stderr"))
                print("")
                if t.nike_error.get("public_error"):
                    ag_test.print(t.nike_error.get("public_error"))
                else:
                    ag_test.print("An error occured when running this test!")
                return 0

            if t.nike_data.get("timed_out", False):
                ag_test.print("Test timed out while running")
                return 0

            suite_tests: List[UtilTest] = [
                x for x in [t.correctness_test, t.performance_test] if x
            ]

            score = 0
            outputs = []
            for suite_test in suite_tests:
                t_score, t_output = suite_test.get_output(t.nike_data)
                score += t_score
                outputs.append(t_output)

            ag_test.print("\n\n".join(outputs))

            if t.leaderboard:
                ag.leaderboard.add_item(t.name, t.performance_test.speedup(t.nike_data))

            return score

    f(tst)


@Test("Feedback Form", 0.1, floor=False) # edited to match lab 8
def feedback_form(ag: Autograder, test: AutograderTest):
    metadata = ag.metadata
    user = metadata["users"][0]
    email = user["email"]

    client_id = "lab-autograder"
    client_secret = "KZJP4BXLMK2LWIWAYYII0JLQE4B11NUVPW57154M945MKIF8CGID33W2J0WM93WL"

    import requests

    r = requests.post(
        "https://auth.apps.cs61a.org/google/read_spreadsheet",
        json={
            "url": FEEDBACK_FORM_URL,
            "sheet_name": "Lab 8",
            "client_name": client_id,
            "secret": client_secret,
        },
    )
    rawData = r.json()

    headerRow = rawData.pop(0)
    emailColName = "Email Address"

    if emailColName not in headerRow:
        test.print(
            "Error: Internal error checking form submissions. Please contact course staff"
        )
        print(f"  Column not found: {emailColName}")
        return -0.1

    entries = {}
    for rawRow in rawData:
        row = {}
        for i in range(len(headerRow)):
            row[headerRow[i]] = rawRow[i] if i < len(rawRow) else None
        entries[row[emailColName]] = row

    if not email:
        test.print("Error: Couldn't find `user.email`. Is this submission active?")
        print("  Error: Couldn't find `user.email`. Is this submission active?")
        return False

    entry = entries.get(email, None)
    if not entry:
        test.print(
            f"Error: Couldn't find your form submission (Gradescope email: '{email}')"
        )
        print(
            f"  Error: Couldn't find your form submission (Gradescope email: '{email}')"
        )
        return False

    test.print("Found your form submission!")
    return True

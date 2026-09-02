from GradescopeBase import Visibility
from GradescopeBase.Utils import root_dir
import json
import subprocess
import traceback
import os
from typing import Callable, List, Tuple
import numpy as np

from .config import NIKE_JOB_TYPE


def z_scores(arr):
    amean = np.mean(arr)
    astd = np.std(arr)
    return np.array([(elm - amean) / astd for elm in arr])


def remove_outliers(arr):
    if len(arr) < 3:
        return arr
    narr = np.array(arr)
    z = np.abs(z_scores(narr))
    return list(narr[z < 2])


def avg_runtime(runtimes: List[float]) -> float:
    if not runtimes:
        return float("inf")
    return (sum(runtimes) or float("inf")) / len(runtimes)


class Test:
    def __init__(self, name: str, points: float):
        self.name = name
        self.points = points

    def score(self, data) -> float:
        return round(self.score_perc(data) * self.points, 4)

    def score_perc(self, data) -> float:
        raise NotImplementedError()

    def score_message(self, data) -> str:
        raise NotImplementedError()

    def extra_messages(self, data) -> List[str]:
        return []

    def get_output(self, data) -> Tuple[int, str]:
        score = self.score(data)
        return score, "\n".join(
            [
                f"{self.name}: {self.score_message(data)}",
                f"  Score: {score}/{self.points}",
                *self.extra_messages(data),
            ]
        )


class CorrectnessTest(Test):
    def __init__(self, points: float):
        super().__init__("Correctness", points)

    def score_perc(self, data) -> float:
        return int(data.get("correct", False))

    def score_message(self, data) -> float:
        return str(data.get("correct", False)).lower()


class PerformanceTest(Test):
    def __init__(
        self,
        points: float,
        base_speed: float,
        score_fn: Callable[[float], float],
    ):
        super().__init__("Performance", points)
        self.base_speed = base_speed
        self.score_fn = score_fn

    def speedup(self, data) -> float:
        raw_runtimes = sorted(data.get("runtimes", []))
        cleaned_runtimes = remove_outliers(raw_runtimes)
        cleaned_runtime = avg_runtime(cleaned_runtimes)
        return round(self.base_speed / cleaned_runtime, 4)

    def score_perc(self, data) -> float:
        if not data.get("correct", False):
            return 0
        return self.score_fn(self.speedup(data))

    def score_message(self, data) -> float:
        if not data.get("correct", False):
            return "did not run"
        return f"{self.speedup(data)}x speedup"

    def extra_messages(self, data) -> List[str]:
        if data.get("correct", False):
            raw_runtimes = sorted(data.get("runtimes", []))
            raw_runtime = avg_runtime(raw_runtimes)
            print(f"Raw runtime: {round(raw_runtime, 4)} ({raw_runtimes})")

            cleaned_runtimes = remove_outliers(raw_runtimes)
            cleaned_runtime = avg_runtime(cleaned_runtimes)
            print(f"Cleaned runtime: {round(cleaned_runtime, 4)} ({cleaned_runtimes})")

        return []


class TestSuite:
    def __init__(
        self,
        name: str,
        coordinator,
        compute,
        input_name: str,
        correctness_test: CorrectnessTest = None,
        performance_test: PerformanceTest = None,
        timeout: int = 20,
        iterations: int = 1,
        visibility: Visibility = Visibility.visible,
        leaderboard=False,
    ):
        self.name = name
        self.coordinator = coordinator
        self.compute = compute
        self.input_name = input_name
        self.slug = f"{coordinator}/{compute}/{input_name}"
        self.correctness_test = correctness_test
        self.performance_test = performance_test
        self.timeout = timeout
        self.iterations = iterations
        self.visibility = visibility
        self.leaderboard = leaderboard and self.performance_test is not None

        self.nike_error = None
        self.nike_data = None

        self.points = 0
        if self.correctness_test:
            self.points += self.correctness_test.points
        if self.performance_test:
            self.points += self.performance_test.points


def submit_perf(meta_path, base_dir_path, file_paths):
    try:
        nike_env = {
            "AUTH_TOKEN": "correct horse battery staple",
            "COORDINATOR_ENDPOINT": "https://nike.cs61c.org",
        }
        proc = subprocess.run(
            [
                "node",
                "submit.js",
                NIKE_JOB_TYPE,
                str(meta_path),
                str(base_dir_path),
            ]
            + [str(file_path) for file_path in file_paths],
            cwd=f"{root_dir()}/proj4/autograder/project-nike/",
            stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            env={**os.environ, **nike_env},
        )
    except subprocess.SubprocessError as ex:
        traceback.print_exc()
        return False, {
            "error": ex.message,
            "stdout": ex.stdout.decode("utf-8"),
            "stderr": ex.stderr.decode("utf-8"),
        }
    try:
        job_data = json.loads(proc.stdout)
        res = job_data.get("results")
    except:
        traceback.print_exc()
        return False, {
            "error": "submit returned invalid json",
            "stdout": proc.stdout.decode("utf-8"),
            "stderr": proc.stderr.decode("utf-8"),
        }

    print(f"Job ID: {job_data.get('id')}")
    print(f"Job worker ID: {res.get('worker_id')}")
    return True, res

from GradescopeBase import Autograder, RateLimit, global_tests
rate_limit = False
try:
    rlim = None
    if rate_limit:
        rlim = RateLimit(4, hours=2, reset_time="2021-01-01T12:00:00")
    ag = Autograder(rate_limit=rlim)
    # ag.print("We are currently performing maintenance on the autograder so test may suddenly break. Thank you for your patients!")
    print("Trying to import: tests/tests.py")
    ag.import_tests(test_files="tests/tests.py")
    ag.run()
except Exception as exc:
    print("Failed to run the autograder")
    print(exc)

import json
from GradescopeBase import Utils

FEEDBACK_FORM_URL = "https://docs.google.com/spreadsheets/d/15vx7s82IbTGNrJ_TvqHcOujs6LwEUC53OaR8bEHGNgc/edit" # changed to match su25
NIKE_JOB_TYPE = "kachow-su25"

with open(Utils.submission_metadata_dir(), "r") as f:
    sub_data = json.load(f)
    assignment_title = sub_data["assignment"]["title"]
    if "dev" in assignment_title.lower():
        NIKE_JOB_TYPE += "-dev"
            

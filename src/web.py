from flask import Flask, jsonify
from flask import request, redirect
from flask_cors import CORS, cross_origin
from core import *
from connection import *

# Flask app
app = Flask(__name__)
cors = CORS(app);
#CORS(app, supports_credentials = True)
app.config['CORS_HEADERS'] = 'Content-Type'

# Home route
@app.route("/", methods=["GET"])
@cross_origin()
def home():
    return jsonify({"message": "ERP Home"})
 
# Student Registration
@app.route("/register", methods = ["POST", "GET"])
@cross_origin(supports_credentials = True)
def register():
    if request.method == "GET":
        return "Please provide a Name(limit 40 chars) and a Unique Username(limit 20 chars) for your account."
    else:
        content = request.get_json()
        username = content['Username'] # type: ignore
        name = content['Name']         # type: ignore
        try:
            InsertHandler.student(name, username)
            ERP_DB.execute_command(f'SELECT id FROM student WHERE username = "{username}"')
            return jsonify({"id": ((ERP_DB.return_results())[0][0])}) # type: ignore
        except ProgERROR as err:
            return jsonify({"id": -1, "message": err.msg})

# Student Login
@app.route("/login", methods = ["POST", "GET"])
@cross_origin()
def login():
    if request.method == "GET":
        return "Please provide your Username(limit 20 chars) and Password(Your ID) for login."
    else:
        content = request.get_json()
        username = content['Username'] # type: ignore
        id = content['Password']       # type: ignore
        try:
            ERP_DB.execute_command(f'SELECT id FROM student WHERE username = "{username}" AND id = {id}')
            res = ERP_DB.return_results()
            id = (res[0][0]) if len(res) == 1 else (-1) # type: ignore
            return jsonify({"id": id})
        except ProgERROR as err:
            return jsonify({"id": -1, "message": err.msg})

# Student's courses
@app.route("/mycourses/<id>", methods = ["GET"])
@cross_origin(supports_credentials = True)
def mycourses(id):
    res = []
    ERP_DB.execute_command(f'SELECT * FROM myCourses WHERE student_id = {id};')
    db_res = ERP_DB.return_results()
    for course in db_res:
        res.append({"id": course[0], "name": course[1], "IC_ID": course[2], "IC_name": course[3], "capacity": int(course[4])})
    return jsonify(res)

# Details of a singular course
@app.route("/course_detail", methods = ["POST"])
@cross_origin(supports_credentials = True)
def courseDetails():
    id = request.get_json()['course_id'] # type: ignore
    ERP_DB.execute_command(f'SELECT * FROM course WHERE id = {id};')
    db_res = ERP_DB.return_results()
    ERP_DB.execute_command(f'SELECT name FROM teacher WHERE id = {db_res[0][4]}') # type: ignore
    ic_name = ERP_DB.return_results()[0][0] # type: ignore
    return jsonify({
        "id": db_res[0][0], "name": db_res[0][1], "IC_id": db_res[0][4], "capacity": int(db_res[0][2]), "seats_left": int(db_res[0][3]), "IC_name": ic_name}) # type: ignore

# Student withdrawal path
@app.route("/mywithdrawals/<id>", methods = ["GET", "POST"])
@cross_origin(supports_credentials = True)
def mywithdrawals(id):
    if request.method == "GET":
        res = []
        ERP_DB.execute_command(f'SELECT * FROM myWithdrawals WHERE student_id = {id}')
        db_res = ERP_DB.return_results()
        for course in db_res:
            res.append({"id": course[0], "name": course[1], "seats_left": int(course[2]), "status": course[4]})
        return jsonify(res)
    else:
        try:
            content = request.get_json()
            course_id = content['course_id'] # type: ignore
            InsertHandler.withdraw_course(id, course_id)
            ERP_DB.execute_command(f'SELECT * FROM myWithdrawals WHERE student_id = {id} AND course_id = {course_id};')
            db_res = ERP_DB.return_results()
            print(db_res)
            res = 1 if len(db_res) == 1 else (-1) # type: ignore
            return jsonify({"message": str(res)})
        except:
            return jsonify({"message": "-1"})

# Student's addition requests
@app.route("/myadditions/<id>", methods = ["GET", "POST"])
@cross_origin(supports_credentials = True)
def myadditions(id):
    if request.method == "GET":
        res = []
        ERP_DB.execute_command(f'SELECT * FROM myAdditions WHERE student_id = {id}')
        db_res = ERP_DB.return_results()
        for course in db_res:
            res.append({"id": course[0], "name": course[1], "seats_left": int(course[2]), "status": course[4]})
        return jsonify(res)
    else:
        try:
            content = request.get_json()
            course_id = content['course_id'] # type: ignore
            InsertHandler.addn_course(id, course_id)
            ERP_DB.execute_command(f'SELECT * FROM myAdditions WHERE student_id = {id} AND course_id = {course_id};')
            db_res = ERP_DB.return_results()
            res = 1 if len(db_res) == 1 else (-1) # type: ignore
            return jsonify({"message": str(res)})
        except:
            return jsonify({"message": "-1"})

# Student's substitution requests
@app.route("/mysubstitutions/<id>", methods = ["GET", "POST"])
@cross_origin(supports_credentials = True)
def mysubstitutions(id):
    if request.method == "GET":
        res = []
        ERP_DB.execute_command(f'SELECT * FROM mySubstitutions WHERE student_id = {id}')
        db_res = ERP_DB.return_results()
        for course in db_res:
            res.append({"current_course": {"id": course[0], "name": course[1], "seats_left": int(course[2])}, 
                           "sub_course": {"id": course[3], "name": course[4], "seats_left": int(course[5])}, "status": course[7]})
        return jsonify(res)
    else:
        try:
            content = request.get_json()
            curr_course_id = content['curr_course_id'] # type: ignore
            subn_course_id = content['subn_course_id'] # type: ignore
            InsertHandler.subn_course(id, curr_course_id, subn_course_id)
            ERP_DB.execute_command(f'SELECT * FROM mySubstitutions WHERE student_id = {id} AND curr_course_id = {curr_course_id} AND subn_course_id = {subn_course_id};')
            db_res = ERP_DB.return_results()
            res = 1 if len(db_res) == 1 else (-1) # type: ignore
            return jsonify({"message": str(res)})
        except:
            return jsonify({"message": "-1"})

# Resolve all requests of all students
@app.route("/resolve", methods = ["GET"])
@cross_origin(supports_credentials = True)
def resolve():
    try:
        # First resolve all withdrawal requests
        ResolvementHandler.withdrawals()
        # Second resolve all substitutions requests
        ResolvementHandler.substitutions()
        # Lastly resolve all additions requests
        ResolvementHandler.additions()
        return jsonify({"message": "All requests for all students are successfully resolved."})
    except:
        return jsonify({"message": "Resolvement for requests of students could not be completed."})


# ADMINISTRATOR URLS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Teacher Registration
@app.route("/teacher", methods = ["POST", "GET"])
@cross_origin(supports_credentials = True)
def teacher():
    if request.method == "GET":
        return "Please provide a Name(limit 40 chars) and a Unique Username(limit 20 chars) for your account."
    else:
        name = request.form["Name"]
        username = request.form["Username"]
        InsertHandler.teacher(name, username)
        try:
            ERP_DB.execute_command(f'SELECT id FROM teacher WHERE username = "{username}"')
            return str((ERP_DB.return_results())[0][0]) # type: ignore
        except ProgERROR as err:
            # print(err.msg)
            return str(-1)


# Auto run flask app
if __name__ == "__main__":
    app.run()

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
        #name = request.form["Name"]
        #username = request.form["Username"]
        try:
            InsertHandler.student(name, username)
            ERP_DB.execute_command(f'SELECT id FROM student WHERE username = "{username}"')
            return jsonify({"id": ((ERP_DB.return_results())[0][0])}) # type: ignore
        except ProgERROR as err:
            # print(err.msg)
            return jsonify({"id": -1})

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
            return jsonify({"id": -1})

# Student's courses
@app.route("/mycourses/<id>", methods = ["GET"])
@cross_origin(supports_credentials = True)
def mycourses(id):
    res = []
    ERP_DB.execute_command(f'SELECT c.id, c.name, c.IC_id, c.capacity FROM course c JOIN takes t ON c.id = t.course_id AND t.student_id = {id}')
    db_res = ERP_DB.return_results()
    for course in db_res:
        ERP_DB.execute_command(f'SELECT name FROM teacher WHERE id = {course[2]}')
        ic_name = ERP_DB.return_results()[0][0] # type: ignore
        res.append({"id": course[0], "name": course[1], "IC_ID": course[2], "IC_name": ic_name, "capacity": course[3]})
    return jsonify(res)

# Student withdrawal path
@app.route("/withdraw/<id>", methods = ["POST", "GET"])
@cross_origin(supports_credentials = True)
def withdraw(id):
    if request.method == "GET":
        return "Please provide course id to withdraw from."
    else:
        course_id = request.form["Course"]
        try:
            ERP_DB.execute_command(f'SELECT * FROM takes WHERE student_id = {id} AND course_id = {course_id}')
            result = ERP_DB.return_results()
            result = result[0][0] if len(result) == 1 else -1 # type: ignore
            DeleteHandler.genByConds("takes", student_id = id, course_id = course_id)
            return jsonify({"result": result})
        except:
            return jsonify({"result": -1})

# Student's addition requests
@app.route("/myadditions/<id>", methods = ["GET"])
@cross_origin(supports_credentials = True)
def myadditions(id):
    res = []
    ERP_DB.execute_command(f'SELECT c.id, c.name FROM add_course a INNER JOIN student s INNER JOIN course c ON a.student_id = {id} AND s.id = {id} AND a.course_id = c.id')
    db_res = ERP_DB.return_results()
    print(db_res)
    for course in db_res:
        res.append({"id": course[0], "name": course[1]})
    return jsonify(res)

# Student's substitution requests
@app.route("/mysubstitutions/<id>", methods = ["GET"])
@cross_origin(supports_credentials = True)
def mysubstitutions(id):
    res = []
    ERP_DB.execute_command(f'SELECT curr_course_id, subn_course_id FROM sub_course WHERE student_id = {id}')
    db_res = ERP_DB.return_results()
    for course in db_res:
        ERP_DB.execute_command(f'SELECT name FROM course WHERE id = {course[0]}')
        curr_course_name = ERP_DB.return_results()
        curr_course_name = curr_course_name[0][0] # type: ignore
        ERP_DB.execute_command(f'SELECT name FROM course WHERE id = {course[1]}')
        subn_course_name = ERP_DB.return_results()
        subn_course_name = subn_course_name[0][0] # type: ignore
        res.append({"current_course": {"id": course[0], "name": curr_course_name}, "sub_course": {"id": course[1], "name": subn_course_name}})
    return jsonify(res)
 

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

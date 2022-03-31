from flask import Flask
from flask import request
from core import *
from connection import *

# Flask app
app = Flask(__name__)


# Home route
@app.route("/", methods=["GET"])
def home():
    return "ERP Home"
 
# Student Registration
@app.route("/register", methods = ["POST", "GET"])
def register():
    if request.method == "GET":
        return "Please provide a Name(limit 40 chars) and a Unique Username(limit 20 chars) for your account."
    else:
        name = request.form["Name"]
        username = request.form["Username"]
        try:
            InsertHandler.student(name, username)
            ERP_DB.execute_command(f'SELECT id FROM student WHERE username = "{username}"')
            return str((ERP_DB.return_results())[0][0]) # type: ignore
        except ProgERROR as err:
            # print(err.msg)
            return str(-1)

# Student Login
@app.route("/login", methods = ["POST", "GET"])
def login():
    if request.method == "GET":
        return "Please provide your Username(limit 20 chars) and Password(Your ID) for login."
    else:
        username = request.form["Username"]
        id = request.form["Password"]
        try:
            ERP_DB.execute_command(f'SELECT id FROM student WHERE username = "{username}" AND id = {id}')
            res = ERP_DB.return_results()
            return str(res[0][0]) if len(res) == 1 else str(-1) # type: ignore
        except ProgERROR as err:
            return str(-1)

# Student's courses
@app.route("/mycourses/<id>", methods = ["GET"])
def mycourses(id):
    res = []
    ERP_DB.execute_command(f'SELECT c.name FROM course c JOIN takes t ON c.id = t.course_id AND t.student_id = {id}')
    db_res = ERP_DB.return_results()
    for course in db_res:
        res.append(course[0])
    return str(res)

# Student withdrawal path
@app.route("/withdraw/<id>", methods = ["POST", "GET"])
def withdraw(id):
    if request.method == "GET":
        return "Please provide course is to withdraw from."
    else:
        course_id = request.form["Course"]
        try:
            DeleteHandler.genByConds("takes", student_id = id, course_id = course_id)
            return str(1)
        except:
            return str(-1)

# Student's addition requests
@app.route("/myadditions/<id>", methods = ["GET"])
def myadditions(id):
    res = []
    ERP_DB.execute_command(f'SELECT c.name FROM add_course a INNER JOIN student s INNER JOIN course c ON a.student_id = {id} AND s.id = {id} AND a.course_id = c.id')
    db_res = ERP_DB.return_results()
    print(db_res)
    for course in db_res:
        res.append(course[0])
    return str(res)

# Student's addition requests
# @app.route("/mysubstitutions/<id>", methods = ["GET"])
# def mysubstitutions(id):
#     res = []
#     ERP_DB.execute_command(f'SELECT c.curr FROM sub_course a INNER JOIN student s INNER JOIN course c ON a.student_id = {id} AND s.id = {id} AND a.course_id = c.id')
#     db_res = ERP_DB.return_results()
#     print(db_res)
#     for course in db_res:
#         res.append(course[0])
#     return str(res)
 

# ADMINISTRATOR URLS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Teacher Registration
@app.route("/teacher", methods = ["POST", "GET"])
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

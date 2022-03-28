from core import *
from connection import *


# Class to handle all requests from GUI
class Request():
    def register(self, name, username) -> int:
        InsertHandler.student(name, username)
        ERP_DB.execute_command(f'SELECT id FROM student WHERE name = "{name}"')
        return (ERP_DB.return_results())[0][0] # type: ignore

    def myCourses(self, id) -> set:
        ERP_DB.execute_command(f'SELECT * FROM course c JOIN takes t ON c.id = t.course_id AND t.student_id = {id}')
        return ERP_DB.return_results()

    def my_addition(self, id) -> set:
        ERP_DB.execute_command(f'SELECT * FROM add_course a INNER JOIN student s ON a.student_id = {id} AND s.id = {id}')
        return ERP_DB.return_results()

    def add_addition(self, id, course_id) -> set:
        InsertHandler.addn_course(id, course_id)
        return self.my_addition(id)

    def my_substitution(self, id) -> set:
        ERP_DB.execute_command(f'SELECT * FROM sub_course a INNER JOIN student s ON a.student_id = {id} AND s.id = {id}')
        return ERP_DB.return_results()

    def add_substitution(self, id, course_id) -> set:
        InsertHandler.subn_course(id, course_id)
        return self.my_substitution(id)

    def withdraw(self, id, course_id) -> set:
        DeleteHandler.genByConds("takes", student_id = id, course_id = course_id)
        return self.myCourses(id)


# Test executions ---------------------------
# req = Request()
# x = int(req.register("'Mohi'", "'usr1'"))
# print(req.myCourses(x))
# # print(req.withdraw(10, 3))
# print(req.my_substitution(x))
# print(req.my_addition(x))
# print(req.addition(x, 5))
# print(x)
# --------------- ---------------------------

# Close connection
ERP_DB.exit()

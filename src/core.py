from connection import *

# Test executions ---------------------------
# ERP_DB.execute_command("SHOW TABLES;")
# ERP_DB.print_results()
# --------------- ---------------------------

# Class handling updations to db
class UpdateIn():
    def genByConds(self, table, col, val, **kwargs) -> None:
        """:param1 table :params Variable no of key-value pair conditions"""
        condition = f"UPDATE {table} SET {col} = {val} WHERE "
        cond_keys = list(kwargs.keys())
        last = cond_keys.pop(len(cond_keys) - 1) if len(cond_keys) > 0 else None
        for x in cond_keys:
            condition += f"{x} = {kwargs[x]} AND "
        if last != None:
            condition += f"{last} = {kwargs[str(last)]};"
        else:
            raise ProgERROR(f"Attempting to Update Table {table}!")
        ERP_DB.execute_command(condition)


# Class handling deletions to db
class DeleteFrom():
    def genByConds(self, table, **kwargs) -> None:
        """:param1 table :params Variable no of key-value pair conditions"""
        condition = f"DELETE FROM {table} WHERE "
        cond_keys = list(kwargs.keys())
        last = cond_keys.pop(len(cond_keys) - 1) if len(cond_keys) > 0 else None
        for x in cond_keys:
            condition += f"{x} = {kwargs[x]} AND "
        if last != None:
            condition += f"{last} = {kwargs[str(last)]};"
        else:
            raise ProgERROR(f"Attempting to Erase Table {table}!")
        ERP_DB.execute_command(condition)


# Class handling all additions to db
class InsertIn():
    def student(self, name, username) -> None:
        """:param1 name :param2 username"""
        # Check value limits of name
        if len(name) > 40:
            raise ProgERROR(f"Name(student) crosses len limit 40: {name}")
        ERP_DB.execute_command(f'SELECT * FROM student WHERE username = "{username}"')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Student. name {name} username {username}!")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO student(name, username) VALUES ("{name}", "{username}");'   
        # )
        ERP_DB.DB_CURSOR.callproc("addStudent", [name, username])

    def teacher(self, name, username) -> None:
        """:param1 name :param2 username"""
        # Check value limits of name
        if len(name) > 40:
            raise ProgERROR(f"Name(teacher) crosses len limit 40: {name}")
        ERP_DB.execute_command(f'SELECT * FROM teacher WHERE username = "{username}"')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Teacher. name {name} username {username}!")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO teacher(name, username) VALUES ("{name}", "{username}");'   
        # )
        ERP_DB.DB_CURSOR.callproc("addTeacher", [name, username])

    def course(self, name, IC_id = "NULL", capacity = 50) -> None:
        """:param1 name :param2 IC_id :param3(Optional) capacity"""
        # Check if a teacher of IC_id exists raise error if not
        if IC_id != "NULL":
            ERP_DB.execute_command(f'SELECT * FROM teacher where id = {IC_id};')
            if len(ERP_DB.return_results()) == 0:
                raise ProgERROR(f"No IC. Teacher of id {IC_id} exists!")
        # Check value limits of name and capacity
        if len(name) > 40:
            raise ProgERROR(f"Name(course) crosses len limit 40: {name}")
        if capacity > 99:
            raise ProgERROR(f"Capacity(course) crosses limit 99: {capacity}")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO course(name, capacity, seats_left, IC_id) VALUES ("{name}", "{capacity}", {capacity}, {IC_id});'
        # )
        ERP_DB.DB_CURSOR.callproc("addCourse", [name, IC_id, capacity])

    def assists(self, teacher_id, course_id):
        """:param1 teacher_id :param2 course_id"""
        # Check if a teacher of IC_id exists raise error if not
        ERP_DB.execute_command(f'SELECT * FROM teacher where id = {teacher_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Assist. Teacher of id {teacher_id} exists!")
        # Check if a course of course_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM course where id = {course_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Assist. Course of id {course_id} exists!")
        ERP_DB.execute_command(f'SELECT * FROM assists where teacher_id = {teacher_id} and course_id = {course_id};')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Assist. Teacherid {teacher_id} Courseid {course_id}!")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO assists(teacher_id, course_id) VALUES ("{teacher_id}", "{course_id}");'
        # )
        ERP_DB.DB_CURSOR.callproc("addAssists", [teacher_id, course_id])

    def takes(self, student_id, course_id):
        """:param1 student_id :param2 course_id"""
        # Check if a student of student_id exists raise error if not
        ERP_DB.execute_command(f'SELECT * FROM student where id = {student_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Takes. Student of id {student_id} exists!")
        # Check if a course of course_id exists raise error if not
        ERP_DB.execute_command(f'SELECT * FROM course where id = {course_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Takes. Course of id {course_id} exists!")
        ERP_DB.execute_command(f'SELECT seats_left FROM course WHERE id = {course_id}')
        if ERP_DB.return_results()[0][0] == 0: # type: ignore
            raise ProgERROR(f'No Seats left in Course {course_id} for takes. Studentid {student_id} Courseid {course_id}')
        ERP_DB.execute_command(f'SELECT * FROM takes where student_id = {student_id} and course_id = {course_id};')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Takes. Studentid {student_id} Courseid {course_id}!")
        # USE TRANSACTIONS HERE ATOMIC
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO takes(student_id, course_id) VALUES ("{student_id}", "{course_id}");'
        # )
        # ERP_DB.execute_command(
        #     f'UPDATE course SET seats_left = seats_left - 1 WHERE id = {course_id}'
        # )
        ERP_DB.DB_CURSOR.callproc("addTakes", [student_id, course_id])

        # NOTE: we gotta have a status field or remove row if addition performed
    def addn_course(self, student_id, course_id):
        """:param1 student_id :param2 course_id"""
        # Check if a student of student_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM student where id = {student_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Add_course. Student of id {student_id} exists!")
        # Check if a course of course_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM course where id = {course_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Add_course. Course of id {course_id} exists!")
        ERP_DB.execute_command(f'SELECT * FROM takes WHERE student_id = {student_id} AND course_id = {course_id};')
        if len(ERP_DB.return_results()) > 0:
            raise ProgERROR(f"Course {course_id} is already a taken course of student {student_id}")
        ERP_DB.execute_command( f'SELECT * FROM add_course where student_id = {student_id} and course_id = {course_id};')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Add_course. Studentid {student_id} Courseid {course_id}!")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO add_course(student_id, course_id) VALUES ("{student_id}", "{course_id}");'
        # )
        ERP_DB.DB_CURSOR.callproc("addAdditions", [student_id, course_id])

    def withdraw_course(self, student_id, course_id):
        """:param1 student_id :param2 course_id"""
        # Check if a student of student_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM student where id = {student_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Withdraw_course. Student of id {student_id} exists!")
        # Check if a course of course_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM course where id = {course_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Withdraw_Course. Course of id {course_id} exists!")
        ERP_DB.execute_command(f'SELECT * FROM takes WHERE student_id = {student_id} AND course_id = {course_id}')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"Student {student_id} does not already take the course {course_id} to withdraw")
        ERP_DB.execute_command( f'SELECT * FROM withdraw_course where student_id = {student_id} and course_id = {course_id};')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Withdraw_course. Studentid {student_id} Courseid {course_id}!")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO withdraw_course(student_id, course_id) VALUES ("{student_id}", "{course_id}");'
        # )
        ERP_DB.DB_CURSOR.callproc("addWithdraw", [student_id, course_id])

    def subn_course(self, student_id, curr_course_id, subn_course_id):
        """:param1 student_id :param2 course_id"""
        # Check if a student of student_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM student where id = {student_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Sub_course. Student of id {student_id} exists!")
        # Check if a course of course_id exists raise error if not
        ERP_DB.execute_command( f'SELECT * FROM course where id = {curr_course_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Sub_course. Course of id {curr_course_id} exists!")
        ERP_DB.execute_command( f'SELECT * FROM course where id = {subn_course_id};')
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"No Sub_course. Course of id {subn_course_id} exists!")
        ERP_DB.execute_command( f'SELECT * FROM sub_course where student_id = {student_id} and curr_course_id = {curr_course_id} AND subn_course_id = {subn_course_id};')
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Duplicate insertion into Sub_course. Studentid {student_id} CurrCourseid {curr_course_id} SubnCourseid {subn_course_id}!")
        ERP_DB.execute_command(f"SELECT * FROM takes WHERE student_id = {student_id} AND course_id = {curr_course_id}")
        if len(ERP_DB.return_results()) == 0:
            raise ProgERROR(f"Curr Course id {curr_course_id} is not among student {student_id}'s registered courses!")
        ERP_DB.execute_command(f"SELECT * FROM takes WHERE student_id = {student_id} AND course_id = {subn_course_id}")
        if len(ERP_DB.return_results()) != 0:
            raise ProgERROR(f"Subn Course id {subn_course_id} is already among student {student_id}'s registered courses!")
        # Final Execution
        # ERP_DB.execute_command(
        #     f'INSERT INTO sub_course(student_id, curr_course_id, subn_course_id) VALUES ("{student_id}", "{curr_course_id}", "{subn_course_id}");'
        # )
        ERP_DB.DB_CURSOR.callproc("addSubstitutions", [student_id, curr_course_id, subn_course_id])


class ResolvementOf:
    def withdrawals(self):
        print("\n   Resolving Withdrawals > > > > > > > > > > > > > > > > > > > > > > > >\n")
        ERP_DB.execute_command(f'SELECT * FROM withdraw_course;')
        withdrawal_requests = ERP_DB.return_results()
        for request in withdrawal_requests:
            print(f"c {request[0]} s {request[1]} st {request[2]}")
            # ERP_DB.execute_command(f'CALL resolveWithdrawals({request[1]}, {request[0]})')
            ERP_DB.DB_CURSOR.callproc("resolveWithdrawals", [request[1], request[0]])
            ERP_DB.print_results()
            ERP_DB.restart()
        print("\n   Resolved Withdrawals < < < < < < < < < < < < < < < < < < < < < < < <\n")

    def substitutions(self):
        print("\n   Resolving Substitutions > > > > > > > > > > > > > > > > > > > > > > > >\n")
        ERP_DB.execute_command(f'SELECT * from sub_course;')
        substitution_requests = ERP_DB.return_results()
        for request in substitution_requests:
            print(f"cr {request[0]} sn {request[1]} s {request[2]} st {request[3]}")
            ERP_DB.DB_CURSOR.callproc("resolveSubstitutions", [request[2], request[0], request[1]])
            ERP_DB.print_results()
            ERP_DB.restart()
        print("\n   Resolved Substitutions < < < < < < < < < < < < < < < < < < < < < < < <\n")

    def additions(self):
        print("\n   Resolving Additions > > > > > > > > > > > > > > > > > > > > > > > >\n")
        ERP_DB.execute_command(f'SELECT * from add_course;')
        addition_requests = ERP_DB.return_results()
        for request in addition_requests:
            print(f"c {request[0]} s {request[1]} st {request[2]}")
            ERP_DB.DB_CURSOR.callproc("resolveAdditions", [request[1], request[0]])
            ERP_DB.print_results()
            ERP_DB.restart()
        print("\n   Resolved Additions < < < < < < < < < < < < < < < < < < < < < < < <\n")


# Instantiate handlers
InsertHandler = InsertIn()
DeleteHandler = DeleteFrom()
UpdateHandler = UpdateIn()
ResolvementHandler = ResolvementOf()


# Test executions ---------------------------
# InsertHandler.student("Tstssssssssssssssssss", "usssssssssssssssr")
# ERP_DB.DB_CURSOR.callproc('addStudent', ["heyte", "heyshere"])
# ERP_DB.print_results()
# ResolvementHandler.withdrawals()
# ResolvementHandler.substitutions()
# ResolvementHandler.additions()
# InsertHandler.course("Tst", 1)
# InsertHandler.subn_course(100, 1, 4)
# DeleteHandler.genByConds("course", id = 2)
# DeleteHandler.genByConds("add_course", student_id = 1, course_id = 2)
# UpdateHandler.genByConds("course", "name", "'check'", id = 1, capacity = 40)
# UpdateHandler.genByConds("course", "name", "'check'", name = "'newtest'")
# --------------- ---------------------------

from core import *
from config import *
from faker import Faker
from faker.providers import DynamicProvider
from faker.providers import job

class FakeData():
    # Instantiate faker class with providers
    def __init__(self):
        # create instance of faker class
        self.fake = Faker()
        # custom courses provider
        courses_provider = DynamicProvider(
            provider_name="courses",
            elements=["Math", "Physics", "Chemistry", "Electrical", "Comp Science", 
                "Metallurgy", "English", "Sanskrit", "Mechanical", "Robotics", 
                "Deep learning", "Cybersecurity", "Algebra"],
            generator=self.fake
        )
        self.fake.add_provider(job)

    # ERP Database wide fake
    def fake_database(self):
        print("\n Starting Faking DB Wide Data (Ensure that the erp DB is completely empty as of now, with only the schema loaded) . . . . . . . . . .\n")
        self.fake_teachers()
        self.fake_students()
        self.fake_courses()
        self.fake_assists()
        self.fake_takes()
        self.fake_addn_courses()
        self.fake_subn_courses()
        print("\n Successfully completed faking of data, erp DB is complete with Dummy data !")

    # Teachers
    def fake_teachers(self):
        print("\n   Generating Fake Teachers > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.TEACHERS):
            name = self.fake.name()
            print(f"FAKE TEACHER: ID {i} Name {name}")
            InsertHandler.teacher(
                name[:DB_ATTRS.NAME_LIM], name[:DB_ATTRS.USERNAME_LIM])
        print(f"\n   Generated {DB_WIDE_FAKE.TEACHERS} Teachers < < < < < < < < < < < < < < < < < < < < < < < <\n")

    # Students
    def fake_students(self):
        print("\n   Generating Fake Students > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.STUDENTS):
            name = self.fake.name()
            print(f"FAKE STUDENT: Id {i} Name {name}")
            InsertHandler.student(
                name[:DB_ATTRS.NAME_LIM], name[:DB_ATTRS.USERNAME_LIM])
        print(f"\n   Generated {DB_WIDE_FAKE.STUDENTS} Students < < < < < < < < < < < < < < < < < < < < < < < <\n")

    # Courses
    def fake_courses(self):
        print("\n   Generating Fake Courses > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.COURSES):
            name = self.fake.job()
            id = self.fake.random_int(
                min = DB_ATTRS.FIRST_ID, max = DB_WIDE_FAKE.TEACHERS)
            cap = self.fake.random_int(min = 10, max = 99)
            print(f"FAKE COURSE: CourseId {i} Name {name} StudentId {id} Capacity {cap}")
            InsertHandler.course(
                name[:DB_ATTRS.NAME_LIM], id, cap)
        print(f"\n   Generated {DB_WIDE_FAKE.COURSES} Courses < < < < < < < < < < < < < < < < < < < < < < < <\n")

    # Takes
    def fake_takes(self):
        print("\n   Generating Fake Takes > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.STUDENTS):
            course_id_list = set(self.fake.unique.random_int(
                min = DB_ATTRS.FIRST_ID, max = DB_WIDE_FAKE.COURSES)
                for j in range(DB_WIDE_FAKE.TAKES))
            self.fake.unique.clear()
            for course_id in course_id_list:
                id = i + 1
                print(f"FAKE TAKE: CourseId {i} StudentId {id}")
                InsertHandler.takes(id, course_id)
        print(f"\n   Generated {DB_WIDE_FAKE.TAKES} Takes < < < < < <\n")

    # Assists
    def fake_assists(self):
        print("\n   Generating Fake Assists > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.COURSES):
            teacher_id_list = set(self.fake.unique.random_int(
                min = DB_ATTRS.FIRST_ID, max = DB_WIDE_FAKE.TEACHERS) 
                for i in range(DB_WIDE_FAKE.ASSISTS_LIM))
            self.fake.unique.clear()
            for teacher_id in teacher_id_list:
                id = i + 1
                print(f"FAKE ASSIST: CourseId {id} TeacherId {teacher_id}")
                InsertHandler.assists(teacher_id, id)
        print(f"\n   Generated {DB_WIDE_FAKE.ASSISTS_LIM} Assists as Max Lim < < < < < < < < < < < < < < < < < < < < < < < <\n")

    # Addition Courses
    def fake_addn_courses(self):
        print("\n   Generating Fake Additions > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.STUDENTS):
            total = self.fake.random_int(min = 0, max = DB_WIDE_FAKE.ADDN_LIM) 
            ERP_DB.execute_command(
                f"SELECT course_id FROM takes WHERE student_id = {i + 1}")
            course_id_list = ERP_DB.return_results()
            course_id_list = [course_id[0] for course_id in course_id_list]
            add_courses = [x for x in range(
                DB_ATTRS.FIRST_ID, DB_WIDE_FAKE.COURSES + 1) 
                if x not in course_id_list]
            add_index_list = list(self.fake.unique.random_int(
                min = 0, max = DB_WIDE_FAKE.COURSES - DB_WIDE_FAKE.CURR_COURSES - 1)
                for j in range(total))
            self.fake.unique.clear()
            for course_id in add_index_list:
                id = i + 1
                print(f"FAKE ADDITION: StudentId {id} CourseId {add_courses[course_id]}")
                InsertHandler.addn_course(id, add_courses[course_id])
        print(f"\n   Generated {DB_WIDE_FAKE.ADDN_LIM} Additions as Max Lim < < < < < < < < < < < < < < < < < < < < < < < <\n")

    # Substitution Courses
    def fake_subn_courses(self):
        print("\n   Generating Fake Substitution > > > > > > > > > > > > > > > > > > > > > > > >\n")
        for i in range(DB_WIDE_FAKE.STUDENTS):
            total = self.fake.random_int(min = 0, max = DB_WIDE_FAKE.SUBN_LIM)
            ERP_DB.execute_command(
                f"SELECT course_id FROM takes WHERE student_id = {i + 1}")
            course_id_list = ERP_DB.return_results()
            course_id_list = [course_id[0] for course_id in course_id_list]
            sub_courses = [x for x in range(
                DB_ATTRS.FIRST_ID, DB_WIDE_FAKE.COURSES + 1) 
                if x not in course_id_list]
            course_index_list = list(self.fake.unique.random_int(
                min = 0, max = DB_WIDE_FAKE.CURR_COURSES - 1)
                for j in range(total))
            sub_index_list = list(self.fake.unique.random_int(
                min = 0, max = DB_WIDE_FAKE.COURSES - DB_WIDE_FAKE.CURR_COURSES - 1) 
                for j in range(total))
            for k in range(total):
                print(f"FAKE ADDITION: StudentId {i + 1} CurrCourseId {course_id_list[course_index_list[k]]} SubCourseId {sub_courses[sub_index_list[k]]}")
                InsertHandler.subn_course(
                    i + 1, course_id_list[course_index_list[k]], sub_courses[sub_index_list[k]])
            self.fake.unique.clear()
        print(f"\n   Generated {DB_WIDE_FAKE.SUBN_LIM} Substitutions as Max Lim < < < < < < < < < < < < < < < < < < < < < < < <\n")


# Instantiate faker class for erp
Fake_ERP_DB = FakeData()
Fake_ERP_DB.fake_database()

# Close connection
ERP_DB.exit()

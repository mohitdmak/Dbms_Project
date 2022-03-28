from core import *
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
            elements=["Math", "Physics", "Chemistry", "Electrical", "Comp Science", "Metallurgy", "English", "Sanskrit", "Mechanical", "Robotics", "Deep learning", "Cybersecurity", "Algebra"],
            generator=self.fake
        )
        self.fake.add_provider(job)

    # ERP Database wide fake
    def fake_database(self):
        self.fake_teachers()
        self.fake_students()
        self.fake_courses()
        self.fake_assists()
        self.fake_takes()
        self.fake_addn_courses()
        self.fake_subn_courses()

    # Teachers
    def fake_teachers(self):
        for i in range(15):
            name = self.fake.name()
            print(f"i {i} name {name}")
            InsertHandler.teacher(name[:40], name[:20])

    # Students
    def fake_students(self):
        for i in range(100):
            name = self.fake.name()
            print(f"i {i} name {name}")
            InsertHandler.student(name[:40], name[:20])

    # Courses
    def fake_courses(self):
        for i in range(15):
            name = self.fake.job()
            id = self.fake.random_int(min = 1, max = 15)
            cap = self.fake.random_int(min = 10, max = 99)
            print(f"i {i} name {name} id {id} cap {cap}")
            InsertHandler.course(name[:40], id, cap)

    # Takes
    def fake_takes(self):
        for i in range(1, 101):
            course_id_list = set(self.fake.unique.random_int(min = 1, max = 15) for i in range(8))
            self.fake.unique.clear()
            for course_id in course_id_list:
                id = i
                InsertHandler.takes(id, course_id)

    # Assists
    def fake_assists(self):
        for i in range(1, 16):
            teacher_id_list = set(self.fake.unique.random_int(min = 1, max = 15) for i in range(2))
            self.fake.unique.clear()
            for teacher_id in teacher_id_list:
                id = i
                InsertHandler.assists(teacher_id, id)

    # Addition Courses
    def fake_addn_courses(self):
        for i in range(1, 101):
            total = self.fake.random_int(min = 0, max = 2) 
            ERP_DB.execute_command(f"SELECT course_id FROM takes WHERE student_id = {i}")
            course_id_list = ERP_DB.return_results()
            course_id_list = [course_id[0] for course_id in course_id_list]
            add_courses = [x for x in range(1, 16) if x not in course_id_list]
            add_index_list = list(self.fake.unique.random_int(min = 0, max = 6) for j in range(total))
            self.fake.unique.clear()
            for course_id in add_index_list:
                id = i
                InsertHandler.addn_course(id, add_courses[course_id])

    # Substitution Courses
    def fake_subn_courses(self):
        for i in range(1, 101):
            total = self.fake.random_int(min = 0, max = 2)
            ERP_DB.execute_command(f"SELECT course_id FROM takes WHERE student_id = {i}")
            course_id_list = ERP_DB.return_results()
            course_id_list = [course_id[0] for course_id in course_id_list]
            sub_courses = [x for x in range(1, 16) if x not in course_id_list]
            course_index_list = list(self.fake.unique.random_int(min = 0, max = 7) for j in range(total))
            sub_index_list = list(self.fake.unique.random_int(min = 0, max = 6) for j in range(total))
            for k in range(total):
                InsertHandler.subn_course(i, course_id_list[course_index_list[k]], sub_courses[sub_index_list[k]])
            self.fake.unique.clear()


# Instantiate faker class for erp
Fake_ERP_DB = FakeData()
Fake_ERP_DB.fake_database()

# Close connection
ERP_DB.exit()

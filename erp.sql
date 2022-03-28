DROP TABLE IF EXISTS `teacher`;
CREATE TABLE teacher(
	id        INT                           NOT NULL AUTO_INCREMENT,
	name      VARCHAR(20) DEFAULT 'Teacher' NOT NULL,
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `course`;
CREATE TABLE course(
	id       INT                           NOT NULL AUTO_INCREMENT,
	name     VARCHAR(20)  DEFAULT 'Course' NOT NULL,
	capacity FLOAT(2,0)   DEFAULT 50       NOT NULL,
	IC_id    INT,
	PRIMARY KEY (id),
    FOREIGN KEY (IC_id) REFERENCES teacher(id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS `assists`;
CREATE TABLE assists(
    teacher_id INT,   
    course_id  INT,
    PRIMARY KEY (teacher_id, course_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES course(id)  ON DELETE CASCADE
);

DROP TABLE IF EXISTS `student`;
CREATE TABLE student(
	id   INT                           NOT NULL AUTO_INCREMENT,
	name VARCHAR(20) DEFAULT 'Student' NOT NULL,
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `takes`;
CREATE TABLE takes(
    student_id INT NOT NULL,
    course_id  INT NOT NULL,
	PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES course(id)  ON DELETE CASCADE
);

DROP TABLE IF EXISTS `add_course`;
CREATE TABLE add_course(
    course_id  INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES course(id)  ON DELETE CASCADE
);

DROP TABLE IF EXISTS `sub_course`;
CREATE TABLE sub_course(
    course_id  INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES course(id)  ON DELETE CASCADE
);

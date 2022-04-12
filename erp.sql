/* > > > > > > > > > > > > > CREATING TABLES > > > > > > > > > > > > > */
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE teacher(
	id       INT                           NOT NULL AUTO_INCREMENT,
	name     VARCHAR(40) DEFAULT 'Teacher' NOT NULL,
    username VARCHAR(20) UNIQUE            NOT NULL,
	PRIMARY KEY (id)
) AUTO_INCREMENT = 0;

DROP TABLE IF EXISTS `course`;
CREATE TABLE course(
	id         INT                           NOT NULL AUTO_INCREMENT,
	name       VARCHAR(40)  DEFAULT 'Course' NOT NULL,
	capacity   FLOAT(2,0)   DEFAULT 20       NOT NULL,
    seats_left FLOAT(2,0)   DEFAULT 20       NOT NULL,
	IC_id      INT,
	PRIMARY KEY (id),
    FOREIGN KEY (IC_id) REFERENCES teacher(id) ON DELETE SET NULL
) AUTO_INCREMENT = 0;

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
	id       INT                           NOT NULL AUTO_INCREMENT,
	name     VARCHAR(40) DEFAULT 'Student' NOT NULL,
    username VARCHAR(20) UNIQUE            NOT NULL,
	PRIMARY KEY (id)
) AUTO_INCREMENT = 0;

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
    curr_course_id  INT NOT NULL,
    subn_course_id  INT NOT NULL,
    student_id      INT NOT NULL,
    PRIMARY KEY (student_id, curr_course_id, subn_course_id),
    FOREIGN KEY (student_id)      REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (curr_course_id)  REFERENCES course(id)  ON DELETE CASCADE,
    FOREIGN KEY (subn_course_id)  REFERENCES course(id)  ON DELETE CASCADE
);

DROP TABLE IF EXISTS `withdraw_course`;
CREATE TABLE withdraw_course(
    course_id  INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES course(id) ON DELETE CASCADE
);
/* > > > > > > > > > > > > > CREATED TABLES > > > > > > > > > > > > > */


/* > > > > > > > > > > > > > CREATING PROCEDURES > > > > > > > > > > > > > */
SET AUTOCOMMIT = 0;

DROP PROCEDURE IF EXISTS `addStudent`;
DELIMITER $$
CREATE PROCEDURE `addStudent` (IN name VARCHAR(40), IN username VARCHAR(20))
    MODIFIES SQL DATA
    COMMENT 'Add student with unique username'
    BEGIN
    START TRANSACTION;
    IF LENGTH(name) <= 40 AND LENGTH(username) <= 20 THEN
        IF NOT EXISTS(SELECT * FROM student WHERE 'username' = username) THEN
            INSERT INTO student(`name`, `username`) VALUES (name, username);
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `addTeacher`;
DELIMITER $$
CREATE PROCEDURE `addTeacher` (IN name VARCHAR(40), IN username VARCHAR(20))
    MODIFIES SQL DATA
    COMMENT 'Add teacher with unique username'
    BEGIN
    START TRANSACTION;
    IF LENGTH(name) <= 40 AND LENGTH(username) <= 20 THEN
        IF NOT EXISTS(SELECT * FROM teacher WHERE 'username' = username) THEN
            INSERT INTO teacher(`name`, `username`) VALUES (name, username);
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;
    
DROP PROCEDURE IF EXISTS `addCourse`;
DELIMITER $$
CREATE PROCEDURE `addCourse` (IN name VARCHAR(40), IN IC_id INT, IN capacity FLOAT(2,0))
    MODIFIES SQL DATA
    COMMENT 'Add a new course'
    BEGIN
    START TRANSACTION;
    IF LENGTH(name) <= 40 AND capacity < 100 THEN
        SELECT IC_id;
        SELECT ISNULL(IC_id);
        SELECT * FROM teacher WHERE id = IC_id;
        IF (NOT ISNULL(IC_id) AND EXISTS(SELECT * FROM teacher WHERE id = IC_id)) OR (ISNULL(IC_id)) THEN 
            INSERT INTO course(`name`, `capacity`, `seats_left`, `IC_id`) VALUES (name, capacity, capacity, IC_id);
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `addTakes`;
DELIMITER $$
CREATE PROCEDURE `addTakes` (IN student_id INT, IN course_id INT)
    MODIFIES SQL DATA
    COMMENT 'Add a new takes relation between student and course'
    BEGIN
    START TRANSACTION;
    IF EXISTS(SELECT * FROM student WHERE id = student_id) AND EXISTS(SELECT * FROM course WHERE id = course_id) THEN
        IF (SELECT seats_left FROM course WHERE id = course_id) > 0 THEN
            IF NOT EXISTS(SELECT * FROM takes WHERE 'student_id' = student_id AND 'course_id' = course_id) THEN
                INSERT INTO takes(`student_id`, `course_id`) VALUES (student_id, course_id);
                UPDATE course SET seats_left = seats_left - 1 WHERE id = course_id;
                COMMIT;
            ELSE 
                ROLLBACK;
            END IF;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `addAssists`;
DELIMITER $$
CREATE PROCEDURE `addAssists` (IN teacher_id INT, IN course_id INT)
    MODIFIES SQL DATA
    COMMENT 'Add a new assistant teacher and course relation'
    BEGIN
    START TRANSACTION;
    IF EXISTS(SELECT * FROM teacher WHERE id = teacher_id) AND EXISTS(SELECT * FROM course WHERE id = course_id) THEN
        IF NOT EXISTS(SELECT * FROM assists WHERE 'teacher_id' = teacher_id AND 'course_id' = course_id) THEN
            INSERT INTO assists(`teacher_id`, `course_id`) VALUES (teacher_id, course_id);            
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `addAdditions`;
DELIMITER $$
CREATE PROCEDURE `addAdditions` (IN student_id INT, IN course_id INT)
    MODIFIES SQL DATA
    COMMENT 'Adds a new addition request for a student'
    BEGIN
    START TRANSACTION;
    IF EXISTS(SELECT * FROM student where id = student_id) AND EXISTS(SELECT * FROM course WHERE id = course_id) THEN
        IF NOT EXISTS(SELECT * FROM takes WHERE 'student_id' = student_id AND 'course_id' = course_id) THEN
            IF NOT EXISTS(SELECT * FROM add_course WHERE 'student_id' = student_id AND 'course_id' = course_id) THEN
                INSERT INTO add_course(student_id, course_id) VALUES (student_id, course_id); 
                COMMIT;
            ELSE
                ROLLBACK;
            END IF;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `addSubstitutions`;
DELIMITER $$
CREATE PROCEDURE `addSubstitutions` (IN student_id INT, IN curr_course_id INT, IN subn_course_id INT)
    MODIFIES SQL DATA
    COMMENT 'Adds a new substitution request for a student'
    BEGIN
    START TRANSACTION;
    IF EXISTS(SELECT * FROM student where id = student_id) AND EXISTS(SELECT * FROM course WHERE id = curr_course_id) AND EXISTS(SELECT * FROM course WHERE id = subn_course_id) THEN
        IF EXISTS(SELECT * FROM takes t WHERE t.student_id = student_id AND t.course_id = curr_course_id) AND NOT EXISTS(SELECT * FROM takes t WHERE t.student_id = student_id AND t.course_id = subn_course_id)THEN
            IF NOT EXISTS(SELECT * FROM sub_course s WHERE s.student_id = student_id AND s.curr_course_id = curr_course_id AND s.subn_course_id = subn_course_id) THEN
                INSERT INTO sub_course(student_id, curr_course_id, subn_course_id) VALUES (student_id, curr_course_id, subn_course_id);
                COMMIT;
            ELSE
                ROLLBACK;
            END IF;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `addWithdraw`;
DELIMITER $$
CREATE PROCEDURE `addWithdraw` (IN student_id INT, IN course_id INT)
    MODIFIES SQL DATA
    COMMENT 'Add a new takes relation between student and course'
BEGIN
    START TRANSACTION;
    IF EXISTS(SELECT * FROM student WHERE id = student_id) AND EXISTS(SELECT * FROM course WHERE id = course_id) THEN
        IF EXISTS(SELECT * FROM takes t WHERE t.student_id = student_id AND t.course_id = course_id) THEN
            IF NOT EXISTS(SELECT * FROM withdraw_course w WHERE w.student_id = student_id AND w.course_id = course_id) THEN
                INSERT INTO withdraw_course(student_id, course_id) VALUES (student_id, course_id);
                COMMIT;
            ELSE 
                ROLLBACK;
            END IF;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;
/* > > > > > > > > > > > > > CREATED PROCEDURES > > > > > > > > > > > > > */


/* > > > > > > > > > > > > > CREATING VIEWS > > > > > > > > > > > > > */
DROP VIEW IF EXISTS `myCourses`;
CREATE VIEW myCourses AS
    SELECT c.id AS course_id, c.name AS course_name,
        (SELECT name FROM teacher where id = c.IC_id) AS course_IC,
        c.capacity AS course_capacity, t.student_id AS student_id
    FROM course c JOIN takes t
    ON c.id = t.course_id;

DROP VIEW IF EXISTS `myAdditions`;
CREATE VIEW myAdditions AS
    SELECT c.id AS course_id, c.name AS course_name, s.id AS student_id
    FROM add_course a INNER JOIN student s 
    INNER JOIN course c 
    ON a.student_id = s.id AND a.course_id = c.id;

DROP VIEW IF EXISTS `mySubstitutions`;
CREATE VIEW mySubstitutions AS
    SELECT curr_course_id as curr_course_id, 
    (SELECT name FROM course WHERE id = curr_course_id) AS curr_course_name,
    subn_course_id as subn_course_id,
    (SELECT name FROM course WHERE id = subn_course_id) AS subn_course_name,
    student_id
    FROM sub_course;
/* > > > > > > > > > > > > > CREATED VIEWS > > > > > > > > > > > > > */

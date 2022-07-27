create database STUDENT_DB
GO 
USE STUDENT_DB
GO
CREATE TABLE Location
(
Locid NUMERIC(5) CONSTRAINT location_locid_pk PRIMARY KEY,
Room NVARCHAR(6) NOT NULL,
Capacity NUMERIC(5)
);

CREATE TABLE Faculty
(
Fid NUMERIC(4) CONSTRAINT faculty_fid_pk PRIMARY KEY,
Flname NVARCHAR(25) NOT NULL,
Ffname NVARCHAR(25) NOT NULL,
Fphone NUMERIC(10)
);

CREATE TABLE Student
(
Sid NUMERIC(5) CONSTRAINT student_sid_pk PRIMARY KEY,
Slname NVARCHAR(25) NOT NULL,
Sfname VARCHAR(25) NOT NULL,
Saddr NVARCHAR(30),
Scity NVARCHAR(30),
Sstate CHAR(2) DEFAULT 'WI',
Szip NUMERIC(9),
Sphone NUMERIC(10) NOT NULL,
Sclass CHAR(2) DEFAULT 'FR',
Sdob DATE NOT NULL,
Fid NUMERIC(4) 
);

ALTER TABLE Student
ADD CONSTRAINT student_fid_fk FOREIGN KEY (Fid)
REFERENCES Faculty;

ALTER TABLE Student
ADD CONSTRAINT student_Sclass_cc
CHECK (Sclass in ('FR', 'SO', 'JR', 'SR', 'GR'));

CREATE TABLE Term
(
Termid NUMERIC(5) CONSTRAINT term_termid_pk PRIMARY KEY,
Tdesc VARCHAR(20) NOT NULL,
Status VARCHAR(20) NOT NULL
);

ALTER TABLE Term
ADD CONSTRAINT term_Status_cc
CHECK (Status in ('OPEN', 'CLOSED'));

CREATE TABLE Course
(
Cid NUMERIC(6) CONSTRAINT course_cid_pk PRIMARY KEY,
Callid NVARCHAR(10) NOT NULL,
Cname NVARCHAR(30) NOT NULL,
Ccredit NUMERIC(2) DEFAULT '3'
);

CREATE TABLE Course_Section
(
Csecid NUMERIC(8) CONSTRAINT coursesection_csecid_pk PRIMARY KEY,
Cid NUMERIC(6) NOT NULL,
Termid NUMERIC(5) NOT NULL,
Secnum NUMERIC(2) NOT NULL,
Fid NUMERIC(4),
Locid NUMERIC(5),
Maxenrl NUMERIC(4) NOT NULL,
Currenrl NUMERIC(4) NOT NULL
);

ALTER TABLE Course_Section
ADD CONSTRAINT coursesection_cid_fk FOREIGN KEY (Cid)
REFERENCES Course;

ALTER TABLE Course_Section
ADD CONSTRAINT coursesection_termid_fk FOREIGN KEY (Termid)
REFERENCES Term;

ALTER TABLE Course_Section
ADD CONSTRAINT coursesection_fid_fk FOREIGN KEY (Fid)
REFERENCES Faculty;

ALTER TABLE Course_Section
ADD CONSTRAINT coursesection_locid_fk FOREIGN KEY (Locid)
REFERENCES Location;

CREATE TABLE Enrollment
(
Sid NUMERIC(5),
Csecid NUMERIC(8),
Grade CHAR(1),
CONSTRAINT enrollment_sid_csecid_pk PRIMARY KEY (Sid, Csecid)
);

ALTER TABLE Enrollment
ADD CONSTRAINT enrollment_sid_fk FOREIGN KEY (Sid)
REFERENCES Student;

ALTER TABLE Enrollment
ADD CONSTRAINT enrollment_csecid_fk FOREIGN KEY (Csecid)
REFERENCES Course_Section;

ALTER TABLE Enrollment
ADD CONSTRAINT enrollment_Grade_cc
CHECK (Grade in ('A', 'B', 'C', 'D', 'F', 'I', 'W'));

INSERT INTO Location
VALUES(53, '424', 45);

INSERT INTO Location
VALUES(54, '402', 35);

INSERT INTO Location
VALUES(55, '433', 100);

INSERT INTO Location
VALUES(56, '434', 100);


INSERT INTO Faculty
VALUES(10, 'Cox', 'Kim', 7155551234);

INSERT INTO Faculty
VALUES(11, 'Blanchard', 'Frank', 7155559087);

INSERT INTO Faculty
VALUES(12, 'McClure', 'William', 7155556409);


INSERT INTO Student
VALUES(100, 'McClure', 'Sarah', '144 Windridge Blvd.', 'Eau Claire', 'WI', 54703, 7155559876, 'SR', '14-JUL-1979', 10);

INSERT INTO Student
VALUES(101, 'Bowie', 'Jim', '454 St. John Street', 'Eau Claire', 'WI', 54702, 7155552345, 'SR', '19-AUG-1979', 11);

INSERT INTO Student
VALUES(102, 'Boone', 'Daniel', '8921 Circle Drive', 'Bloomer', 'WI', 54715, 7155553907, 'JR', '10-OCT-1977', 11);

INSERT INTO Student
VALUES(103, 'Jame', 'Bond', '8935 Circle Drive', 'El Paso', 'TX', 79835, 8907788982, 'GR', '20-OCT-1979', 11);


INSERT INTO Term
VALUES(1, 'Spring 2004', 'CLOSED');

INSERT INTO Term
VALUES(2, 'Summer 2004', 'OPEN');


INSERT INTO Course
VALUES(1, 'MIS101', 'Intro. to Info. Systems', 3);

INSERT INTO Course
VALUES(2, 'MIS321', 'Systems Analysis and Design', 3);

INSERT INTO Course
VALUES(3, 'MIS349', 'Intro to Database Management', 3);


INSERT INTO Course_Section
VALUES(1000, 1, 2, 1, 12, 55, 100, 35);

INSERT INTO Course_Section
VALUES(1001, 1, 2, 2, 10, 54, 45, 35);

INSERT INTO Course_Section
VALUES(1002, 2, 2, 3, 10, 53, 35, 32);

INSERT INTO Course_Section
VALUES(1003, 3, 2, 1, 11, 54, 45, 35);


INSERT INTO Enrollment
VALUES(100, 1000, 'A');

INSERT INTO Enrollment
VALUES(100, 1003, 'A');

INSERT INTO Enrollment
VALUES(101, 1000, 'C');

INSERT INTO Enrollment
VALUES(102, 1000, 'C');

INSERT INTO Enrollment
VALUES(102, 1001, NULL);

INSERT INTO Enrollment
VALUES(102, 1003, 'I');

SELECT * FROM Location;

SELECT * FROM Faculty;

SELECT * FROM Student;

SELECT * FROM Term;

SELECT * FROM Course;

SELECT * FROM Course_Section;

SELECT * FROM Enrollment;
--1. Write a query that displays a list of all students.
Select *
From Student
--2. Write a query that displays a list of all faculties showing the faculty Flname, Ffname, Fphone
Select Flname , Ffname , Fphone
From Faculty
--3. Write a query that displays each student name as a single field in the format 'firstname lastname' with a heading of Student, along with their phone number with a heading of Phone.
Select Flname+ ' '+Ffname as 'firstname lastname',Fphone as 'Phone'
From Faculty
--4. Write a query that displays a list of all courses showing the course Callid, Cname, and Ccredit. Sort the results by course name.
Select Callid , Cname , Ccredit
From Course
--5. Write a query that displays a list of all students showing the student Slname, Sfname, Scity. Only display students in 'Eau Claire' city.
Select Slname,Sfname,Scity
From Student
Where Scity='Eau Claire'
--6. Write a query that displays the student Slname, Sfname, Szip, and Scity from the student table. Use the LIKE operator to only display students that reside in any zipcode ending with 02.
Select Slname, Sfname,Szip,Scity
From Student
Where Szip Like '%_02'
--7. Write a query that displays the student Slname, Sfname, Saddr, and Scity from the student table who do not live in Bloomer city.
Select Slname, Sfname,Saddr,Scity
From Student 
Except
Select Slname, Sfname,Saddr,Scity
From Student 
Where Scity='Bloomer'
--8. Write a query that displays a list of all students were born in 1979
Select *
From Student
Where Year(Sdob)='1979'
--9. Write a query that displays a list of all students were born on Aug. 19, 1979
Select *
From Student
Where Month(Sdob)=8 and Day(Sdob)='19' and Year(Sdob)='1979'
--10. Write a query that displays a list of all students were born in Oct 1977
Select *
From Student
Where Month(Sdob)=10 and Year(Sdob)='1979'
--11. Write a query to display the student Slname, Sfname, and Saddr but only display those students that have a faculty.
Select Slname, Sfname, Saddr,f.Fid
From Student s join Faculty f on s.Fid=f.Fid
--12. Use the JOIN ON syntax to write a query to display the course Callid, Cname, Ccredit, and course session id (Csecid) for section having currenrl=35
Select Callid,Cname,Csecid
From Course co Join Course_Section se on co.Cid=se.Cid
Where currenrl=35
--13. Use the JOIN syntax to display the faculty Flname, Ffname, Fphone, and Course session id (Csecid), Locid for locid at 53, 54.
Select Flname,Ffname,Fphone,Csecid
From Faculty f join Course_Section se on f.Fid=se.Fid
Where Locid='53'
Union
Select Flname,Ffname,Fphone,Csecid
From Faculty f join Course_Section se on f.Fid=se.Fid
Where Locid='54'
--14. List the course Callid, Cname, Ccredit for any courses opening in term 2 (Status='OPEN, Termid=2).
Select Callid,Cname,Ccredit
From Course co join Course_Section se on co.Cid=se.Cid join Term te on se.Termid=te.Termid
Where Status='OPEN' and te.Termid=2
--15. List the student Sid, Slname, Sfname, Saddr, Sdob for students were born in 1979 and enrolling course MIS101 (Callid='MIS101')
Select s.Sid,Slname,Sfname,Saddr,Sdob
From Student s,Enrollment en,Course_Section se,Course co
Where s.Sid=en.Sid and en.Csecid=se.Csecid and se.Cid=co.Cid and Callid='MIS101'
--16. Write a query to list the Slname, Sfname, Scity of ONLY the students that have grade A. Only list each student once.
Select Distinct Slname,Sfname,Scity
From Student s join Enrollment en on s.Sid=en.Sid
Where Grade='A'
--17. Write a query to list the Locid, Room, Capacity of all locations that have been occupated by course MIS101 (Callid='MIS101') in term Summer 2004.
Select se.Locid,Room,Capacity
From Course_Section se join Location lo on se.Locid=lo.Locid join Term te on se.Termid=te.Termid join Course co on se.Cid=co.Cid
Where Callid='MIS101' and Tdesc='Summer 2004'
--18. Write a query to display the student Sid, Slname, Sfname, Scity, and course section Csecid for all ENROLLED students had no grade (Grade is null).
Select s.Sid,Slname,Sfname,Scity,Csecid
From Student s join Enrollment en on s.Sid=en.Sid
Where Grade is Null
--19. Write a query to display the student who did not enroll for any course section. (Use LEFT JOIN)
Select *
From Course_Section se Left Join Enrollment en on se.Csecid=en.Csecid
Where en.Csecid is Null
--20. Write a query that displays the Fid for all faculties that teach at location 54 (locid=54) but did not teach at location 53 (locid=53) (use the EXCEPT operator)
Select Fid
From Course_Section se join Location lo on se.Locid=lo.Locid
Where se.Locid='54'
Except
Select Fid
From Course_Section se join Location lo on se.Locid=lo.Locid
Where se.Locid='53'
--21. Write a query that displays the faculties (Fid, Flname, Ffname, Fphone) that teach at location 54 (locid=54) but did not teach at location 53 (locid=53)
Select se.Fid,Flname,Ffname,Fphone
From Course_Section se join Location lo on se.Locid=lo.Locid join Faculty f on se.Fid=f.Fid
Where se.Locid='54'
Except
Select se.Fid,Flname,Ffname,Fphone
From Course_Section se join Location lo on se.Locid=lo.Locid join Faculty f on se.Fid=f.Fid
Where se.Locid='53'
--22. Write a query that displays the Fid for all faculties that teach at both location 54 and 53. (Use INTERSECT operator).
Select Fid
From Course_Section se join Location lo on se.Locid=lo.Locid
Where se.Locid='54'
Intersect
Select Fid
From Course_Section se join Location lo on se.Locid=lo.Locid
Where se.Locid='53'
--23. Write a query that displays Sid of all Students that live in city 'Eau Claire' or students enrolled course but had no grade. (Use Union operator).
Select Sid
From Student 
Where Scity='Eau Claire'
Union
Select s.Sid
From Student s join Enrollment en on s.Sid=en.Sid
Where Grade is Null
-- ==========================================
-- Student Management System (SMS) - SQL Script
-- ==========================================

-- 📌 Step 3: Create Database
CREATE DATABASE IF NOT EXISTS StudentManagement;
USE StudentManagement;

-- 📌 Step 4: Create Tables

-- 1. Students Table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- 2. Courses Table
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);

-- 3. Teachers Table
CREATE TABLE IF NOT EXISTS Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    subject VARCHAR(100)
);

-- 4. Enrollments Table
CREATE TABLE IF NOT EXISTS Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- 5. Marks Table
CREATE TABLE IF NOT EXISTS Marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- 6. Attendance Table
CREATE TABLE IF NOT EXISTS Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- ==========================================
-- 🔹 Insert Sample Data
-- ==========================================

-- Insert Student
INSERT INTO Students (name, age, gender, email, phone)
VALUES ('Harika', 20, 'Female', 'harika@gmail.com', '9876543210');

-- Insert Courses
INSERT INTO Courses (course_name, credits)
VALUES ('SQL', 3), ('Python', 4);

-- Enroll Student (Assuming course_id 1 is SQL)
INSERT INTO Enrollments (student_id, course_id)
VALUES (1, 1);

-- Insert Marks
INSERT INTO Marks (student_id, course_id, marks)
VALUES (1, 1, 95);

-- Insert Attendance
INSERT INTO Attendance (student_id, course_id, date, status)
VALUES (1, 1, '2023-10-01', 'Present');

-- ==========================================
-- 🔹 Retrieve Data (Sample Queries)
-- ==========================================

-- View Student with Courses
SELECT s.name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Get Student Marks
SELECT s.name, c.course_name, m.marks
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Courses c ON m.course_id = c.course_id;

-- Get Attendance Report
SELECT s.name, c.course_name, a.date, a.status
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN Courses c ON a.course_id = c.course_id;

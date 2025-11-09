-- 🧾 Employee Management System SQL Project (FINAL CLEAN VERSION)
-- ✅ Run this if running for the first time (no drop table errors)

CREATE DATABASE IF NOT EXISTS Employee_Management_DB;
USE Employee_Management_DB;
DROP TABLE IF EXISTS Employee_Training, Training, Payroll, Attendance, Employee_Project, Projects, Employee_Designation, Designation, Employees, Department;


-- Step 3: Create Tables
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50),
    Gender VARCHAR(10),
    DeptID INT,
    Salary DECIMAL(10,2),
    JoiningDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Designation (
    DesigID INT PRIMARY KEY AUTO_INCREMENT,
    DesigName VARCHAR(50)
);

CREATE TABLE Employee_Designation (
    EmpID INT,
    DesigID INT,
    PRIMARY KEY (EmpID, DesigID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (DesigID) REFERENCES Designation(DesigID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(100),
    DeptID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Employee_Project (
    EmpID INT,
    ProjectID INT,
    Role VARCHAR(50),
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

CREATE TABLE Attendance (
    AttendID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    AttendDate DATE,
    Status VARCHAR(10),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    BasicPay DECIMAL(10,2),
    HRA DECIMAL(10,2),
    Allowances DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    NetPay DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

CREATE TABLE Training (
    TrainingID INT PRIMARY KEY AUTO_INCREMENT,
    TrainingName VARCHAR(100),
    DurationDays INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Employee_Training (
    EmpID INT,
    TrainingID INT,
    CompletionStatus VARCHAR(20),
    PRIMARY KEY (EmpID, TrainingID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (TrainingID) REFERENCES Training(TrainingID)
);

-- ✅ Step 4: Insert Data (same as before)
INSERT INTO Department (DeptName, Location) VALUES
('HR', 'Delhi'),
('IT', 'Mumbai'),
('Finance', 'Pune'),
('Sales', 'Chennai'),
('Marketing', 'Bangalore');

INSERT INTO Employees (EmpName, Gender, DeptID, Salary, JoiningDate) VALUES
('Amit Kumar', 'Male', 1, 40000, '2021-05-10'),
('Priya Sharma', 'Female', 2, 60000, '2020-03-15'),
('Rahul Verma', 'Male', 3, 45000, '2019-12-10'),
('Neha Singh', 'Female', 2, 70000, '2022-07-01'),
('Karan Patel', 'Male', 4, 38000, '2021-02-05'),
('Sneha Das', 'Female', 1, 42000, '2023-01-12'),
('Rohit Mehta', 'Male', 2, 55000, '2022-09-23');

INSERT INTO Designation (DesigName) VALUES
('Manager'),('Team Lead'),('Developer'),('HR Executive'),('Accountant');

INSERT INTO Employee_Designation VALUES
(1,4),(2,3),(3,5),(4,2),(5,1),(6,4),(7,3);

INSERT INTO Projects (ProjectName, DeptID, StartDate, EndDate) VALUES
('Payroll System', 2, '2022-01-01', '2022-08-01'),
('Recruitment Portal', 1, '2023-02-01', '2023-06-01'),
('Sales Tracker', 4, '2021-03-01', '2021-10-01'),
('Finance Dashboard', 3, '2022-09-01', '2023-03-01');

INSERT INTO Employee_Project VALUES
(1,2,'Coordinator'),(2,1,'Developer'),(3,4,'Accountant'),
(4,1,'Team Lead'),(5,3,'Sales Head'),(7,1,'Tester');

INSERT INTO Attendance (EmpID, AttendDate, Status) VALUES
(1,'2025-10-01','Present'),(2,'2025-10-01','Present'),
(3,'2025-10-01','Absent'),(4,'2025-10-01','Present'),
(5,'2025-10-01','Present'),(6,'2025-10-01','Present'),
(7,'2025-10-01','Absent');

INSERT INTO Payroll (EmpID, BasicPay, HRA, Allowances, Deductions, NetPay) VALUES
(1,30000,5000,2000,1000,36000),(2,45000,8000,3000,2000,54000),
(3,35000,6000,2500,1500,42000),(4,50000,10000,4000,2000,62000),
(6,32000,5000,1500,1000,37500),(7,40000,7000,3000,1500,48500);

INSERT INTO Training (TrainingName, DurationDays, DeptID) VALUES
('Communication Skills', 5, 1),('Python Programming', 10, 2),
('Finance Reporting', 7, 3),('Sales Pitching', 4, 4),('Digital Marketing', 6, 5);

INSERT INTO Employee_Training VALUES
(1,1,'Completed'),(2,2,'Completed'),(3,3,'Pending'),
(4,2,'Completed'),(5,4,'Completed'),(6,1,'Pending'),(7,2,'Completed');

-- ✅ Step 5: Final Master Query (single combined output)
SELECT 
    e.EmpName,
    d.DeptName,
    des.DesigName,
    p.ProjectName,
    t.TrainingName,
    et.CompletionStatus,
    e.Salary,
    pr.NetPay,
    a.Status AS AttendanceStatus
FROM Employees e
LEFT JOIN Department d ON e.DeptID = d.DeptID
LEFT JOIN Employee_Designation ed ON e.EmpID = ed.EmpID
LEFT JOIN Designation des ON ed.DesigID = des.DesigID
LEFT JOIN Employee_Project ep ON e.EmpID = ep.EmpID
LEFT JOIN Projects p ON ep.ProjectID = p.ProjectID
LEFT JOIN Employee_Training et ON e.EmpID = et.EmpID
LEFT JOIN Training t ON et.TrainingID = t.TrainingID
LEFT JOIN Payroll pr ON e.EmpID = pr.EmpID
LEFT JOIN Attendance a ON e.EmpID = a.EmpID
ORDER BY e.EmpName;

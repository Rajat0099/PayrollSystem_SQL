# PayrollSystem_SQL
Overview
This project is a Payroll Management System (PMS) built using SQL, designed to manage the payroll processes for a company. It includes tables for departments, employees, payroll records, and employee benefits.

Tables in the PMS:

1. Departments:
Holds department names and identifiers.Columns: DepartmentID (Primary Key), DepartmentName

2. Employees:
Stores employee information including their personal details, job title, department, and salary.
Columns: EmployeeID (Primary Key), FirstName, LastName, DateOfBirth, HireDate, JobTitle, DepartmentID (Foreign Key), Salary

3. Payroll:
Tracks the payroll of employees, including gross pay, deductions, and net pay.
Columns: PayrollID (Primary Key), EmployeeID (Foreign Key), PayPeriodStart, PayPeriodEnd, GrossPay, Deductions, NetPay

4. Benefits:
Records the benefits given to employees.
Columns: BenefitID (Primary Key), EmployeeID (Foreign Key), BenefitType, BenefitAmount

# Getting Started

To run this SQL script:

1. Set up an SQL server (MySQL, SQL Server, or any relational database).
2. Execute the SQL script to create the required tables.
3. Use INSERT statements to add employee and payroll data.

# License
This project is open-source and available for free.


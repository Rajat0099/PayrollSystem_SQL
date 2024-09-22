-- Step 1: Create Tables
-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100)
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    HireDate DATE,
    JobTitle VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Payroll Table
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    PayPeriodStart DATE,
    PayPeriodEnd DATE,
    GrossPay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    NetPay DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Benefits Table
CREATE TABLE Benefits (
    BenefitID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    BenefitType VARCHAR(50),
    BenefitAmount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Taxes Table
CREATE TABLE Taxes (
    TaxID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    TaxType VARCHAR(50),
    TaxAmount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Step 2: Insert Departments
INSERT INTO Departments (DepartmentName) 
VALUES 
('IT'), 
('HR'), 
('Finance'),
('Marketing'),
('Sales'),
('Operations');

-- Predefined lists of first and last names
DECLARE @FirstNames TABLE (Name VARCHAR(50));
INSERT INTO @FirstNames (Name) VALUES
('John'), ('Jane'), ('Michael'), ('Sarah'), ('David'), ('Laura'), 
('Chris'), ('Lisa'), ('James'), ('Emily'), ('Robert'), ('Jessica');

DECLARE @LastNames TABLE (Name VARCHAR(50));
INSERT INTO @LastNames (Name) VALUES
('Smith'), ('Johnson'), ('Williams'), ('Jones'), ('Brown'), 
('Davis'), ('Miller'), ('Wilson'), ('Moore'), ('Taylor');

-- Step 3: Generate Employees, Payroll, Benefits, and Taxes
DECLARE @i INT = 1;

WHILE @i <= 5000
BEGIN
    -- Randomly select first and last names
    DECLARE @FirstName VARCHAR(50) = (SELECT TOP 1 Name FROM @FirstNames ORDER BY NEWID());
    DECLARE @LastName VARCHAR(50) = (SELECT TOP 1 Name FROM @LastNames ORDER BY NEWID());

    -- Random dates
    DECLARE @DateOfBirth DATE = DATEADD(YEAR, -RAND()*30, GETDATE());
    DECLARE @HireDate DATE = DATEADD(DAY, -RAND()*365, GETDATE());

    -- Insert Employee
    INSERT INTO Employees (FirstName, LastName, DateOfBirth, HireDate, JobTitle, DepartmentID, Salary)
    VALUES (
        @FirstName, 
        @LastName, 
        @DateOfBirth, 
        @HireDate, 
        CASE 
            WHEN @i % 6 = 0 THEN 'Software Developer'
            WHEN @i % 6 = 1 THEN 'HR Specialist'
            WHEN @i % 6 = 2 THEN 'Financial Analyst'
            WHEN @i % 6 = 3 THEN 'Marketing Coordinator'
            WHEN @i % 6 = 4 THEN 'Sales Representative'
            ELSE 'Operations Manager'
        END,
        (SELECT TOP 1 DepartmentID FROM Departments ORDER BY NEWID()),
        ROUND(RAND() * (100000 - 40000) + 40000, 2)
    );

    DECLARE @EmployeeID INT = SCOPE_IDENTITY(); -- Get the last inserted EmployeeID

    -- Insert Payroll Data
    INSERT INTO Payroll (EmployeeID, PayPeriodStart, PayPeriodEnd, GrossPay, Deductions, NetPay)
    VALUES (
        @EmployeeID,
        DATEADD(MONTH, -FLOOR(RAND() * 12), GETDATE()),  -- Random month for pay period start
        GETDATE(),
        ROUND(RAND() * 3000 + 2000, 2),
        ROUND(RAND() * 300 + 100, 2),
        ROUND((ROUND(RAND() * 3000 + 2000, 2) - ROUND(RAND() * 300 + 100, 2)), 2)
    );

    -- Insert Benefits Data
    INSERT INTO Benefits (EmployeeID, BenefitType, BenefitAmount)
    VALUES (
        @EmployeeID,
        CASE 
            WHEN @i % 3 = 0 THEN 'Health Insurance'
            WHEN @i % 3 = 1 THEN 'Retirement Plan'
            ELSE 'Paid Leave'
        END,
        ROUND(RAND() * 500 + 100, 2)
    );

    -- Insert Taxes Data
    INSERT INTO Taxes (EmployeeID, TaxType, TaxAmount)
    VALUES (
        @EmployeeID,
        CASE 
            WHEN @i % 2 = 0 THEN 'Federal Tax'
            ELSE 'State Tax'
        END,
        ROUND(RAND() * 300 + 100, 2)
    );

    SET @i = @i + 1;
END
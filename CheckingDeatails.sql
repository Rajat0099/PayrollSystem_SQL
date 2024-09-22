DECLARE @EmployeeID INT;
SET @EmployeeID = 5000; --Insert the EmployeeID from the 1 to 5000

-- Fetch employee details, department, payroll, benefits, and taxes
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.DateOfBirth,
    e.HireDate,
    e.JobTitle,
    d.DepartmentName,
    e.Salary,
    p.PayPeriodStart,
    p.PayPeriodEnd,
    p.GrossPay,
    p.Deductions,
    p.NetPay,
    b.BenefitType,
    b.BenefitAmount,
    t.TaxType,
    t.TaxAmount
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN 
    Payroll p ON e.EmployeeID = p.EmployeeID
LEFT JOIN 
    Benefits b ON e.EmployeeID = b.EmployeeID
LEFT JOIN 
    Taxes t ON e.EmployeeID = t.EmployeeID
WHERE 
    e.EmployeeID = @EmployeeID;


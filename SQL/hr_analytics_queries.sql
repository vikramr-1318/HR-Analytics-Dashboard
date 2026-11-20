-- ==============================================================================
-- HR ANALYTICS & EMPLOYEE ATTRITION DATABASE QUERIES
-- Database Dialect: ANSI SQL / MySQL / PostgreSQL / SQL Server
-- Dataset: IBM HR Analytics Employee Attrition & Performance
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. TABLE DEFINITION & SCHEMA CREATION
-- ------------------------------------------------------------------------------
CREATE TABLE hr_employee_attrition (
    Age INT,
    Attrition VARCHAR(10),                 -- 'Yes' or 'No'
    BusinessTravel VARCHAR(50),            -- 'Travel_Rarely', 'Travel_Frequently', 'Non-Travel'
    Department VARCHAR(100),               -- 'Sales', 'Research & Development', 'Human Resources'
    DistanceFromHome INT,
    Education INT,                         -- 1: Below College, 2: College, 3: Bachelor, 4: Master, 5: Doctor
    EducationField VARCHAR(100),           -- 'Life Sciences', 'Medical', 'Marketing', etc.
    EnvironmentSatisfaction INT,           -- 1-4 scale
    Gender VARCHAR(20),                    -- 'Male', 'Female'
    JobInvolvement INT,                    -- 1-4 scale
    JobLevel INT,                          -- 1-5 scale
    JobRole VARCHAR(100),                  -- 'Sales Executive', 'Research Scientist', etc.
    JobSatisfaction INT,                   -- 1-4 scale
    MaritalStatus VARCHAR(50),             -- 'Single', 'Married', 'Divorced'
    MonthlyIncome DECIMAL(10,2),           -- Measured in USD ($)
    NumCompaniesWorked INT,
    OverTime VARCHAR(10),                  -- 'Yes' or 'No'
    PercentSalaryHike DECIMAL(5,2),
    PerformanceRating INT,                 -- 3: Excellent, 4: Outstanding
    RelationshipSatisfaction INT,          -- 1-4 scale
    StockOptionLevel INT,                  -- 0-3 scale
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,                   -- 1: Bad, 2: Good, 3: Better, 4: Best
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,
    Age_Bracket VARCHAR(20),               -- '18-20', '21-30', '31-40', '41-50', '51-60'
    Salary_Band VARCHAR(20)                -- 'Low', 'Medium', 'High'
);

-- ------------------------------------------------------------------------------
-- 2. EXECUTIVE WORKFORCE & ATTRITION KPIS
-- ------------------------------------------------------------------------------

-- Total Workforce, Active Employees, Attrition Headcount, and Overall Attrition Rate
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS active_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income_usd,
    ROUND(AVG(Age), 1) AS avg_workforce_age,
    ROUND(AVG(YearsAtCompany), 1) AS avg_tenure_years
FROM hr_employee_attrition;

-- ------------------------------------------------------------------------------
-- 3. DEPARTMENTAL & DEMOGRAPHIC ATTRITION BREAKDOWN
-- ------------------------------------------------------------------------------

-- Attrition Rate by Department
SELECT 
    Department,
    COUNT(*) AS total_headcount,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS department_attrition,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct,
    ROUND(AVG(MonthlyIncome), 2) AS avg_department_salary_usd
FROM hr_employee_attrition
GROUP BY Department
ORDER BY attrition_rate_pct DESC;

-- Attrition by Gender & Marital Status
SELECT 
    Gender,
    MaritalStatus,
    COUNT(*) AS headcount,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY Gender, MaritalStatus
ORDER BY Gender, attrition_rate_pct DESC;

-- Attrition by Age Bracket
SELECT 
    Age_Bracket,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY Age_Bracket
ORDER BY Age_Bracket ASC;

-- ------------------------------------------------------------------------------
-- 4. JOB ROLE & COMPENSATION VULNERABILITY ANALYSIS
-- ------------------------------------------------------------------------------

-- Highest Risk Job Roles by Attrition Rate
SELECT 
    JobRole,
    COUNT(*) AS total_role_headcount,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS role_attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS role_attrition_rate_pct,
    ROUND(AVG(MonthlyIncome), 2) AS avg_role_income_usd
FROM hr_employee_attrition
GROUP BY JobRole
ORDER BY role_attrition_rate_pct DESC;

-- Attrition across Salary Bands (Low: <=$5K, Medium: $5K-$10K, High: >$10K)
SELECT 
    Salary_Band,
    COUNT(*) AS employees_in_band,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct,
    ROUND(AVG(MonthlyIncome), 2) AS avg_band_income_usd
FROM hr_employee_attrition
GROUP BY Salary_Band
ORDER BY CASE Salary_Band WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;

-- ------------------------------------------------------------------------------
-- 5. WORK ENVIRONMENT, OVERTIME & RETENTION DRIVERS
-- ------------------------------------------------------------------------------

-- Overtime vs Attrition Impact
SELECT 
    OverTime,
    COUNT(*) AS employee_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY OverTime;

-- Job Satisfaction & Work-Life Balance Correlation with Turnover
SELECT 
    JobSatisfaction,
    WorkLifeBalance,
    COUNT(*) AS employee_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY JobSatisfaction, WorkLifeBalance
ORDER BY JobSatisfaction ASC, WorkLifeBalance ASC;

-- Tenure Vulnerability: Years at Company vs Attrition
SELECT 
    CASE 
        WHEN YearsAtCompany <= 1 THEN '0-1 Years (Early Career)'
        WHEN YearsAtCompany <= 5 THEN '2-5 Years (Growth Phase)'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years (Mid Career)'
        ELSE '10+ Years (Tenured)'
    END AS tenure_tier,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY 
    CASE 
        WHEN YearsAtCompany <= 1 THEN '0-1 Years (Early Career)'
        WHEN YearsAtCompany <= 5 THEN '2-5 Years (Growth Phase)'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years (Mid Career)'
        ELSE '10+ Years (Tenured)'
    END
ORDER BY MIN(YearsAtCompany) ASC;

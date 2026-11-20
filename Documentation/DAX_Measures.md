# 👥 HR Analytics & Employee Attrition — DAX Measures Reference Guide

This document catalogs the verified DAX calculations used in the **HR Analytics Dashboard** (`HR Analytics Dashboard.pbix`).

---

## 📐 Measure Catalog

### 1. Total Employees
* **DAX Formula:**
  ```dax
  Total Employees = COUNTROWS(HR_Data_cleaned)
  ```
* **Business Definition:** Total headcount of employees evaluated in the workforce dataset.
* **Calculation Logic:** Row count of the cleaned workforce table.
* **Interpretation:** Current organizational sample size is **1,470 employees**.
* **Use Case:** Overall workforce denominator across all department and demographic splits.

---

### 2. Active Employees
* **DAX Formula:**
  ```dax
  Active Employees = 
  CALCULATE(
      COUNTROWS(HR_Data_cleaned),
      HR_Data_cleaned[Attrition] = "No"
  )
  ```
* **Business Definition:** Count of currently employed individuals who remain with the organization.
* **Calculation Logic:** Filtered count where `Attrition = "No"`.
* **Interpretation:** **1,233 employees** are currently retained (**83.88%** retention rate).
* **Use Case:** Headcount monitoring, workforce planning, and staffing targets.

---

### 3. Employees Left (Attrition Headcount)
* **DAX Formula:**
  ```dax
  Employees Left = 
  CALCULATE(
      COUNTROWS(HR_Data_cleaned),
      HR_Data_cleaned[Attrition] = "Yes"
  )
  ```
* **Business Definition:** Total volume of voluntary or involuntary employee departures during the observation window.
* **Calculation Logic:** Filtered count where `Attrition = "Yes"`.
* **Interpretation:** **237 employees** departed the company.
* **Use Case:** Turnover impact assessment, exit interview tracking, and replacement cost estimation.

---

### 4. Attrition Rate %
* **DAX Formula:**
  ```dax
  Attrition Rate = DIVIDE([Employees Left], [Total Employees], 0)
  ```
* **Business Definition:** Percentage of total workforce that left the company.
* **Calculation Logic:** Attrition headcount divided by Total Headcount with safe zero-division handling.
* **Interpretation:** Organizational attrition rate is **16.12%** (Industry benchmark: ~12-15%).
* **Use Case:** Primary HR health KPI, executive compensation scorecards, and departmental retention targets.

---

### 5. Average Monthly Income
* **DAX Formula:**
  ```dax
  Avg Monthly Income = AVERAGE(HR_Data_cleaned[MonthlyIncome])
  ```
* **Business Definition:** Mean gross monthly compensation per employee.
* **Currency Standard:** **USD ($)** — based on the official IBM HR benchmark data.
* **Calculation Logic:** Arithmetic mean over `MonthlyIncome`.
* **Interpretation:** Average monthly salary is **$6,503 / month** (~$78,000 annualized).
* **Use Case:** Pay equity audits, compensation benchmarking, and salary band design.

---

### 6. Overtime Attrition Rate
* **DAX Formula:**
  ```dax
  Overtime Attrition Rate = 
  DIVIDE(
      CALCULATE(COUNTROWS(HR_Data_cleaned), HR_Data_cleaned[Attrition] = "Yes", HR_Data_cleaned[OverTime] = "Yes"),
      CALCULATE(COUNTROWS(HR_Data_cleaned), HR_Data_cleaned[OverTime] = "Yes"),
      0
  )
  ```
* **Business Definition:** Attrition rate specifically among employees working mandatory or regular overtime.
* **Calculation Logic:** Overtime departures divided by total overtime staff.
* **Interpretation:** Attrition among overtime staff spikes to **30.53%** vs **10.44%** for non-overtime staff (nearly 3x higher turnover).
* **Use Case:** Burnout prevention, workload redistribution, and wellness program justifications.

---

### 7. Average Workforce Age
* **DAX Formula:**
  ```dax
  Avg Age = AVERAGE(HR_Data_cleaned[Age])
  ```
* **Business Definition:** Mean age in years across the employee population.
* **Interpretation:** Average age is **36.92 years**.
* **Use Case:** Demographic trend analysis, succession planning, and pension/benefit structuring.

---

### 8. Average Company Tenure
* **DAX Formula:**
  ```dax
  Avg Tenure = AVERAGE(HR_Data_cleaned[YearsAtCompany])
  ```
* **Business Definition:** Mean number of completed years of service with the current organization.
* **Interpretation:** Average organizational tenure is **7.01 years**.
* **Use Case:** Institutional memory retention, loyalty incentives, and promotion velocity tracking.

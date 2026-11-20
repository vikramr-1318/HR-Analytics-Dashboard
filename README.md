# 👥 HR Analytics & Employee Attrition Dashboard

> **Project Status:** Completed (September 05, 2024) | **Maintainer:** R Vikram

## 1. Project Title & Overview
**HR Analytics & Employee Attrition Intelligence** is an enterprise workforce analytics project built to uncover the demographic, financial, and organizational root causes of employee turnover. Analyzing 1,470 employee records from IBM's benchmark dataset, the project equips People Operations teams with diagnostic dashboards and SQL models to prevent voluntary turnover.

---

## 2. Business Problem
Employee turnover imposes massive financial penalties on enterprise organizations—costing between 50% and 150% of an employee's annual salary in recruitment, onboarding, and productivity downtime. Executive leadership required data-driven clarity on:
1. Which specific departments and job roles suffer from the highest turnover?
2. Does mandatory or regular overtime directly correlate with attrition spikes?
3. What compensation threshold represents the "inflection point" where employee turnover stabilizes?
4. How do age, career stage, and work-life balance influence voluntary resignation?

---

## 3. Project Objectives
* Standardize dirty workforce records, encode categorical brackets, and eliminate non-informative constant columns.
* Build a reproducible Python ETL pipeline using relative file references.
* Author production-grade analytical SQL queries (`SQL/hr_analytics_queries.sql`) to validate workforce metrics.
* Design a high-contrast dark-mode Power BI dashboard with a custom radial neon-glow theme.
* Document verified attrition drivers and construct actionable retention strategies.

---

## 4. Dataset Description
* **Source:** [Kaggle - IBM HR Analytics Employee Attrition](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
* **Sample Size:** 1,470 full-time employee records.
* **Attributes:** 30 cleaned attributes (Demographics, Satisfaction Scores, Compensation, Tenure, Job Role).
* **Currency Standard:** **USD ($)** — Monthly compensation is measured in United States Dollars ($6,503 / mo average).

---

## 5. Tools & Technologies
* **Power BI Desktop:** Interactive dark-mode dashboard, Star Schema modeling, KPI scorecards.
* **DAX:** 8 validated workforce measures (`CALCULATE`, `DIVIDE`, `COUNTROWS`).
* **Python (Pandas, Pillow):** Data cleaning, categorical binning, and 1920x1080 Gaussian-blurred radial background synthesis.
* **SQL (ANSI SQL / PostgreSQL / MySQL):** Table schemas, demographic aggregation, and attrition correlation queries.

---

## 6. Data Architecture
The data model centers on the primary analytical fact table `HR_Data_cleaned`:
* **Demographic Dimensions:** Age Bracket, Gender, Marital Status, Education Field.
* **Operational Dimensions:** Department, Job Role, Business Travel, OverTime.
* **Compensation Metrics:** Monthly Income (USD), Percent Salary Hike, Stock Option Level, Salary Band.
* **Survey Metrics:** Job Satisfaction, Environment Satisfaction, Work-Life Balance.

---

## 7. Data Cleaning Methodology
Data processing is automated via [process_hr_data.py](process_hr_data.py):
1. **Redundant Column Removal:** Dropped non-varying constant fields (`EmployeeCount`, `StandardHours`, `Over18`) and row indexes (`EmployeeNumber`).
2. **Age Bracket Engineering:** Created categorical bands: `18-20`, `21-30`, `31-40`, `41-50`, `51-60`.
3. **Salary Band Engineering:** Structured monthly income into:
   * *Low:* <= $5,000 / month USD
   * *Medium:* $5,001 – $10,000 / month USD
   * *High:* > $10,000 / month USD
4. **Path Reliability:** Built using `pathlib` relative paths to execute reliably across environments.

---

## 8. SQL Analysis
The project includes a complete analytical SQL suite in [SQL/hr_analytics_queries.sql](SQL/hr_analytics_queries.sql):
* Table DDL schemas with strict data typing.
* Overall workforce headcount, active workforce, and attrition rate calculations.
* Departmental turnover rankings and gender/marital status splits.
* Overtime impact analysis and satisfaction rating correlations.

---

## 9. Python Implementation
* **[process_hr_data.py](process_hr_data.py):** Cleans raw input data, validates file availability, and exports cleaned CSV.
* **[generate_hr_bg.py](generate_hr_bg.py):** Synthesizes a 1920x1080 canvas with Workforce Blue and Attrition Orange Gaussian radial glows.

---

## 10. Power BI Dashboard
The dashboard [HR Analytics Dashboard.pbix](HR%20Analytics%20Dashboard.pbix) provides 4 distinct views:
1. **Workforce Overview:** Total headcount, demographic distribution, and department share.
2. **Attrition Dashboard:** Departmental and role-level attrition rates, turnover counts, and gender breakdowns.
3. **Salary Analysis:** Income distribution across job roles, salary bands, and compensation disparity vs attrition.
4. **Employee Insights:** Overtime impact, work-life balance scores, and tenure risk curves.

---

## 11. Dashboard Screenshots
Dashboard preview assets are located in the [Screenshots/](Screenshots/) directory:

![Dashboard Canvas Theme Preview](Screenshots/01_dashboard_canvas_theme.png)

*The complete interactive dashboard can be explored via [HR Analytics Dashboard.pbix](HR%20Analytics%20Dashboard.pbix).*

---

## 12. Key Performance Indicators (KPIs)
| KPI | Value | Business Significance |
|:---|:---:|:---|
| **Total Headcount** | 1,470 | Total employee base evaluated |
| **Active Employees** | 1,233 | Retained workforce (83.88% retention rate) |
| **Attrition Count** | 237 | Voluntary / involuntary departures |
| **Attrition Rate %** | 16.12% | Baseline organizational turnover rate |
| **Average Monthly Income** | $6,503 USD | Mean monthly compensation per employee |
| **Average Workforce Age** | 36.92 yrs | Mean employee age |
| **Average Tenure** | 7.01 yrs | Average completed years of service |
| **Overtime Attrition Rate** | 30.53% | Turnover rate among overtime workers |

---

## 13. Business Insights
*Detailed analytical findings available in [Documentation/HR_Analytics_Insights.md](Documentation/HR_Analytics_Insights.md).*
* **Overtime Burnout:** Employees working overtime suffer a **30.53% attrition rate** compared to **10.44%** for non-overtime peers (2.92x risk multiplier).
* **High-Risk Roles:** Sales Representatives exhibit an alarming **39.76% attrition rate**, followed by Laboratory Technicians (**23.94%**).
* **Compensation Cliff:** Employees earning under $5,000/month experience **21.76% attrition**. Once compensation crosses $5,000, turnover drops by more than half to **10.23%**.

---

## 14. Strategic Recommendations
1. **Overtime Mitigation Policy:** Implement automated workload alerts when an employee logs >15 hours of overtime in consecutive weeks.
2. **Sales Representative Career Ladder:** Restructure base compensation for early-career sales representatives to stabilize early turnover.
3. **Targeted Stay Interviews:** Conduct proactive quarterly retention interviews for employees in years 1–3 within technical and sales roles.

---

## 15. Project Folder Structure
```
HR Analytics Dashboard/
│
├── HR Analytics Dashboard.pbix          # Interactive Power BI report
├── HR_Analytics_Theme.json              # Custom visual palette theme
├── HR_Analytics_Background.png          # High-res canvas background
├── HR_Data_cleaned.csv                  # Cleaned workforce dataset
├── process_hr_data.py                   # Automated data cleaning pipeline
├── generate_hr_bg.py                    # Background generation script
├── requirements.txt                     # Python dependencies
├── SQL/
│   └── hr_analytics_queries.sql         # Production SQL query suite
├── Documentation/
│   ├── DAX_Measures.md                  # Comprehensive DAX catalog
│   └── HR_Analytics_Insights.md         # In-depth analytical findings
└── Screenshots/
    └── 01_dashboard_canvas_theme.png    # Canvas theme preview
```

---

## 16. Installation Instructions
```bash
# Clone the repository
git clone https://github.com/vikramr-1318/Data-Analyst-Portfolio.git
cd "Data-Analyst-Portfolio/HR Analytics Dashboard"

# Install Python dependencies
pip install -r requirements.txt
```

---

## 17. Execution Instructions
```bash
# Execute data cleaning pipeline:
python process_hr_data.py

# Regenerate neon background:
python generate_hr_bg.py
```

---

## 18. Dataset Download Instructions
The raw IBM dataset (`WA_Fn-UseC_-HR-Employee-Attrition.csv`) can be downloaded from [Kaggle - IBM HR Analytics](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset). Place the CSV into the project folder and run `python process_hr_data.py`.

---

## 19. Limitations & Future Work
* **Survey Recency:** Dataset provides cross-sectional snapshot data rather than longitudinal time-series sentiment.
* **Future Work:** Train predictive churn classification models (Logistic Regression / XGBoost) to generate real-time flight-risk probability scores.

---

## 20. Contact & Maintainer
* **Developer & Maintainer:** R Vikram
* **GitHub:** [vikramr-1318](https://github.com/vikramr-1318)
* **Email:** `rv367629@gmail.com`

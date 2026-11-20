"""
HR Analytics & Employee Attrition - Data Cleaning Pipeline
Cleans and standardizes raw IBM HR Analytics Employee Attrition dataset.
Preserves existing business logic, handles categorical bins, and produces HR_Data_cleaned.csv.
"""

import os
from pathlib import Path
import pandas as pd


def clean_hr_data():
    # Resolve paths relative to this script file
    base_dir = Path(__file__).resolve().parent
    source_file = base_dir / "WA_Fn-UseC_-HR-Employee-Attrition.csv"
    dest_file = base_dir / "HR_Data_cleaned.csv"

    print("=" * 60)
    print("HR ANALYTICS DATA CLEANING & TRANSFORMATION PIPELINE")
    print("=" * 60)
    print(f"Working Directory: {base_dir}")

    # Validate raw source file existence
    if not source_file.exists():
        print(f"\n[INFO] Source file not found: {source_file.name}")
        if dest_file.exists():
            print(f"[OK] Existing cleaned dataset found: {dest_file.name}")
            df_existing = pd.read_csv(dest_file)
            print(f"     Shape: {df_existing.shape} | Columns: {len(df_existing.columns)}")
            print("[INFO] To reprocess raw data, download 'WA_Fn-UseC_-HR-Employee-Attrition.csv' from:")
            print("       https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset")
            print("       and place it inside the 'HR Analytics Dashboard' directory.")
            return df_existing
        else:
            raise FileNotFoundError(
                f"Raw dataset '{source_file.name}' not found in {base_dir}.\n"
                f"Download from: https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset"
            )

    print(f"\nStep 1: Loading raw dataset '{source_file.name}'...")
    df = pd.read_csv(source_file)
    print(f"  Initial records: {df.shape[0]} rows, {df.shape[1]} columns")

    print("\nStep 2: Dropping redundant and constant columns...")
    columns_to_drop = [
        'EmployeeCount',      # Constant: always 1
        'Over18',             # Constant: always 'Y'
        'StandardHours',      # Constant: always 80
        'EmployeeNumber',     # Row identifier, non-analytical
        'DailyRate',          # Redundant rate metric
        'HourlyRate',         # Redundant rate metric
        'MonthlyRate'         # Redundant rate metric
    ]
    df = df.drop(columns=columns_to_drop, errors='ignore')
    print(f"  Retained columns ({len(df.columns)}): {list(df.columns)}")

    print("\nStep 3: Creating conditional feature - Age Bracket...")
    def get_age_bracket(age):
        if age >= 51:
            return "51-60"
        elif age >= 41:
            return "41-50"
        elif age >= 31:
            return "31-40"
        elif age >= 21:
            return "21-30"
        else:
            return "18-20"

    df['Age Bracket'] = df['Age'].apply(get_age_bracket)

    print("Step 4: Creating conditional feature - Salary Band (MonthlyIncome in USD)...")
    def get_salary_band(income):
        if income <= 5000:
            return "Low"
        elif income <= 10000:
            return "Medium"
        else:
            return "High"

    df['Salary Band'] = df['MonthlyIncome'].apply(get_salary_band)

    # Summary diagnostics
    print(f"\nSalary Band Distribution:\n{df['Salary Band'].value_counts().to_string()}")
    print(f"\nAge Bracket Distribution:\n{df['Age Bracket'].value_counts().to_string()}")

    print(f"\nStep 5: Exporting cleaned data to '{dest_file.name}'...")
    df.to_csv(dest_file, index=False)
    print(f"[SUCCESS] Cleaned data saved: {dest_file} ({df.shape[0]} rows, {df.shape[1]} cols)")
    return df


if __name__ == "__main__":
    clean_hr_data()

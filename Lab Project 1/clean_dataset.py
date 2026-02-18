import csv
import re
from pathlib import Path
from typing import Dict, List, Optional

import pandas as pd


PROJECT_ROOT = Path(__file__).parent
RAW_PATH = PROJECT_ROOT / "Unclean Dataset.csv"
OUTPUT_PATH = PROJECT_ROOT / "Cleaned_Dataset.csv"
REPORT_PATH = PROJECT_ROOT / "cleaning_report.txt"


def clean_currency(value: Optional[str]) -> Optional[float]:
    """Convert messy currency strings like ' ?20,000.00 ', '$1200' to float."""
    if value is None:
        return None
    text = str(value)
    if not text or text.strip().upper() in {"NA", "N/A"}:
        return None

    text = text.strip().strip('"').strip("'").strip()
    text = re.sub(r"[£$₦\?]", "", text)
    text = text.replace(" ", "").replace(",", "")
    text = re.sub(r"[^0-9.]", "", text)

    if not text:
        return None

    try:
        return float(text)
    except ValueError:
        return None


def clean_age(value: Optional[str]) -> Optional[int]:
    """Extract numeric age from messy strings like 'F 24', '78*', '21*'."""
    if value is None:
        return None
    text = str(value).strip()
    if not text:
        return None

    text = re.sub(r"[MFmf\*]", " ", text)
    match = re.search(r"\d{1,3}", text)
    if not match:
        return None
    try:
        age = int(match.group(0))
        if 10 <= age <= 80:
            return age
    except ValueError:
        return None
    return None


def clean_gender(*candidates: Optional[str]) -> Optional[str]:
    """Find a valid gender (M/F) among several messy candidate strings."""
    for val in candidates:
        if val is None:
            continue
        text = str(val).strip().upper()
        if not text:
            continue
        if "M" in text and "F" not in text:
            return "M"
        if "F" in text and "M" not in text:
            return "F"
    return None


def clean_course(raw: Optional[str]) -> Optional[str]:
    if raw is None:
        return None
    text = str(raw).strip().lower()
    if not text or text in {"na", "n/a"}:
        return None

    if "data science" in text:
        return "Data Science"
    if "machine learn" in text:
        return "Machine Learning"
    if "web develop" in text:
        return "Web Development"
    if "data analy" in text or "data analytics" in text:
        return "Data Analysis"
    if "cyber" in text:
        return "Cyber Security"

    return text.title()


def parse_date(raw: Optional[str]) -> Optional[pd.Timestamp]:
    if raw is None:
        return None
    text = str(raw).strip()
    if not text or text.upper() in {"NA", "N/A"}:
        return None

    dt = pd.to_datetime(text, errors="coerce", dayfirst=True)
    if pd.isna(dt):
        dt = pd.to_datetime(text, errors="coerce", dayfirst=False)
    if pd.isna(dt):
        return None
    return dt


def parse_pipe_line(line: str) -> Optional[Dict]:
    head = line.split(",")[0]
    parts = [p.strip() for p in head.split("|")]
    if len(parts) < 8:
        return None

    student_id, first, last, age, gender, course, enroll_date, payment = parts[:8]

    record = {
        "Student_ID": int(student_id) if student_id.strip().isdigit() else None,
        "First_Name": first or None,
        "Last_Name": last or None,
        "Age": clean_age(age),
        "Gender": clean_gender(gender),
        "Course": clean_course(course),
        "Enrollment_Date": parse_date(enroll_date),
        "Total_Payments": clean_currency(payment),
    }
    return record


def parse_csv_line(line: str) -> Optional[Dict]:
    reader = csv.reader([line])
    cols = next(reader, [])
    cols = [c.strip() for c in cols]
    if not cols or all(c == "" for c in cols):
        return None

    while len(cols) < 8:
        cols.append("")

    student_id = None
    first = last = age_raw = gender_raw = course_raw = enroll_date_raw = payment_raw = None

    if cols[0].isdigit():
        student_id = int(cols[0])
        first = cols[1] or None
        last = cols[2] or None
        age_raw = cols[3] or None
        gender_raw = cols[4] or None
        course_raw = cols[5] or None
        enroll_date_raw = cols[6] or None
        payment_raw = cols[7] or None
    else:
        first = cols[0] or None
        last = cols[2] or cols[1] or None
        age_raw = cols[3] or cols[4] or None
        gender_raw = cols[3] or cols[4] or None
        course_raw = cols[5] or None
        enroll_date_raw = cols[6] or None
        payment_raw = cols[7] or None

    record = {
        "Student_ID": student_id,
        "First_Name": first,
        "Last_Name": last,
        "Age": clean_age(age_raw),
        "Gender": clean_gender(gender_raw),
        "Course": clean_course(course_raw),
        "Enrollment_Date": parse_date(enroll_date_raw),
        "Total_Payments": clean_currency(payment_raw),
    }
    if not any(
        record.get(k)
        for k in ["Student_ID", "First_Name", "Last_Name", "Course", "Total_Payments"]
    ):
        return None
    return record


def load_and_clean() -> tuple[pd.DataFrame, pd.DataFrame]:
    records: List[Dict] = []

    encodings = ["utf-8", "latin-1", "cp1252", "iso-8859-1"]
    file_content = None

    for encoding in encodings:
        try:
            with RAW_PATH.open("r", encoding=encoding) as f:
                file_content = f.readlines()
            break
        except UnicodeDecodeError:
            continue

    if file_content is None:
        with RAW_PATH.open("r", encoding="utf-8", errors="ignore") as f:
            file_content = f.readlines()

    for i, raw_line in enumerate(file_content):
        line = raw_line.strip()
        if i == 0:
            continue
        if not line:
            continue

        if "|" in line:
            rec = parse_pipe_line(line)
        else:
            rec = parse_csv_line(line)

        if rec:
            records.append(rec)

    df_raw = pd.DataFrame.from_records(records)
    df = df_raw.copy()

    df["Gender"] = df["Gender"].apply(lambda g: g.upper() if isinstance(g, str) else g)
    df["Course"] = df["Course"].apply(clean_course)

    df["Age"] = pd.to_numeric(df["Age"], errors="coerce")
    df["Total_Payments"] = pd.to_numeric(df["Total_Payments"], errors="coerce")
    df["Enrollment_Date"] = pd.to_datetime(df["Enrollment_Date"], errors="coerce")

    df = df.drop_duplicates()

    if "Student_ID" in df.columns:
        df = df.sort_values(by=["Student_ID", "Enrollment_Date"], na_position="last")
        df = df.drop_duplicates(subset=["Student_ID"], keep="first")

    cols = [
        "Student_ID",
        "First_Name",
        "Last_Name",
        "Age",
        "Gender",
        "Course",
        "Enrollment_Date",
        "Total_Payments",
    ]
    df = df[[c for c in cols if c in df.columns]]

    return df_raw, df


def analyze_uncleaned_data(df: pd.DataFrame) -> Dict:
    stats = {
        "total_rows": len(df),
        "total_columns": len(df.columns),
        "missing_values": {},
        "missing_percentage": {},
        "duplicate_rows": df.duplicated().sum(),
        "duplicate_student_ids": 0,
        "data_types": df.dtypes.to_dict(),
        "data_quality_score": 0.0,
    }

    missing_counts = df.isnull().sum()
    stats["missing_values"] = missing_counts.to_dict()
    stats["missing_percentage"] = (missing_counts / len(df) * 100).to_dict()

    id_dupes = 0
    if "Student_ID" in df.columns:
        id_dupes = df["Student_ID"].duplicated().sum()
        stats["duplicate_student_ids"] = id_dupes

    completeness = (1 - missing_counts.sum() / (len(df) * len(df.columns))) * 100
    if len(df) > 0:
        if "Student_ID" in df.columns:
            uniqueness = (1 - id_dupes / len(df)) * 100
        else:
            uniqueness = (1 - stats["duplicate_rows"] / len(df)) * 100
    else:
        uniqueness = 0

    stats["data_quality_score"] = (completeness + uniqueness) / 2

    return stats


def print_uncleaned_statistics(stats: Dict) -> None:
    print("\n" + "=" * 80)
    print("UNCLEANED DATA CLEANING STATISTICS".center(80))
    print("=" * 80)

    print(f"\n[Dataset Overview]")
    print(f"   Total Rows: {stats['total_rows']}")
    print(f"   Total Columns: {stats['total_columns']}")
    print(f"   Data Quality Score: {stats['data_quality_score']:.2f}/100")

    print(f"\n[Missing Values Analysis]")
    if any(stats["missing_values"].values()):
        total_missing = sum(stats["missing_values"].values())
        print(f"   Total Missing Values: {total_missing}")
        for col, count in stats["missing_values"].items():
            if count > 0:
                pct = stats["missing_percentage"][col]
                print(f"   {col:25s}: {count:4d} missing ({pct:5.2f}%)")
    else:
        print("   [OK] No missing values found")

    print(f"\n[Duplicate Analysis]")
    print(f"   Duplicate Rows: {stats['duplicate_rows']}")
    if stats["duplicate_student_ids"] > 0:
        print(f"   Duplicate Student IDs: {stats['duplicate_student_ids']}")
    else:
        print("   [OK] No duplicate Student IDs")

    print(f"\n[Data Types]")
    for col, dtype in stats["data_types"].items():
        print(f"   {col:25s}: {str(dtype)}")


def remove_null_records(df: pd.DataFrame) -> tuple:
    rows_before = len(df)
    missing_before = df.isnull().sum().to_dict()
    df_cleaned = df.dropna()
    rows_after = len(df_cleaned)
    return df_cleaned, rows_before, rows_after, missing_before


def generate_cleaning_report(
    df_before: pd.DataFrame,
    df_after: pd.DataFrame,
    stats_before: Dict,
    rows_before: int,
    rows_after: int,
    missing_before: Dict,
) -> None:
    with open(REPORT_PATH, "w", encoding="utf-8") as f:
        f.write("=" * 80 + "\n")
        f.write("DATA CLEANING REPORT".center(80) + "\n")
        f.write("=" * 80 + "\n\n")

        f.write("EXECUTIVE SUMMARY\n")
        f.write("-" * 80 + "\n")
        f.write(f"Original Records: {rows_before}\n")
        f.write(f"Cleaned Records: {rows_after}\n")
        f.write(f"Records Removed: {rows_before - rows_after}\n")
        f.write(f"Retention Rate: {rows_after/rows_before*100:.2f}%\n")
        f.write(
            f"Data Quality Score (Before): {stats_before['data_quality_score']:.2f}/100\n\n"
        )

        f.write("MISSING VALUES ANALYSIS (Before Cleaning)\n")
        f.write("-" * 80 + "\n")
        total_missing = sum(missing_before.values())
        if total_missing > 0:
            for col, count in missing_before.items():
                if count > 0:
                    pct = (count / rows_before) * 100
                    f.write(f"{col:25s}: {count:4d} missing ({pct:5.2f}%)\n")
        else:
            f.write("No missing values found.\n")
        f.write("\n")

        f.write("DUPLICATE ANALYSIS\n")
        f.write("-" * 80 + "\n")
        f.write(f"Duplicate Rows: {stats_before['duplicate_rows']}\n")
        if stats_before["duplicate_student_ids"] > 0:
            f.write(f"Duplicate Student IDs: {stats_before['duplicate_student_ids']}\n")
        f.write("\n")

        f.write("DATA TYPES\n")
        f.write("-" * 80 + "\n")
        for col, dtype in stats_before["data_types"].items():
            f.write(f"{col:25s}: {str(dtype)}\n")
        f.write("\n")

        f.write("CLEANING ACTIONS PERFORMED\n")
        f.write("-" * 80 + "\n")
        f.write("1. Parsed messy data formats (pipe-delimited and comma-delimited)\n")
        f.write("2. Cleaned currency values (removed symbols, commas, spaces)\n")
        f.write("3. Extracted and validated ages\n")
        f.write("4. Standardized gender values (M/F)\n")
        f.write("5. Normalized course names\n")
        f.write("6. Parsed dates from multiple formats\n")
        f.write("7. Removed duplicate rows\n")
        f.write("8. Removed duplicate Student IDs (kept first occurrence)\n")
        f.write("9. Removed all records with missing/null values\n")
        f.write("\n")

        f.write("FINAL DATASET STATUS\n")
        f.write("-" * 80 + "\n")
        f.write(f"Total Records: {len(df_after)}\n")
        f.write(f"Total Columns: {len(df_after.columns)}\n")
        f.write(f"Missing Values: {df_after.isnull().sum().sum()}\n")
        f.write(f"Duplicate Rows: {df_after.duplicated().sum()}\n")
        f.write("\n")

        f.write("=" * 80 + "\n")
        f.write("Report generated successfully.\n")

    print(f"Cleaning report saved to: {REPORT_PATH}")


def main() -> None:
    if not RAW_PATH.exists():
        raise FileNotFoundError(f"Raw dataset not found at {RAW_PATH}")

    print("\n" + "=" * 80)
    print("DATA CLEANING PROCESS STARTED".center(80))
    print("=" * 80)

    print("\n[Loading and parsing data...]")
    df_raw, df = load_and_clean()
    print(f"[OK] Loaded {len(df_raw)} records (before cleaning)")

    print("\n[Analyzing uncleaned data...]")
    stats_before = analyze_uncleaned_data(df_raw)
    print_uncleaned_statistics(stats_before)

    print("\n[Removing records with missing values...]")
    df_cleaned, rows_before, rows_after, missing_before = remove_null_records(df)
    print(f"[OK] Removed {rows_before - rows_after} records with missing values")

    print("\n[Generating cleaning report...]")
    generate_cleaning_report(
        df, df_cleaned, stats_before, rows_before, rows_after, missing_before
    )

    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    df_cleaned.to_csv(OUTPUT_PATH, index=False)

    print("\n" + "=" * 80)
    print("CLEANING SUMMARY".center(80))
    print("=" * 80)
    print(f"\n[OK] Cleaned dataset written to: {OUTPUT_PATH}")
    print(f"[OK] Report saved to: {REPORT_PATH}")
    print(f"\n[Final Statistics]")
    print(f"   Rows before removing nulls: {rows_before}")
    print(f"   Rows after removing nulls: {rows_after}")
    print(f"   Records removed: {rows_before - rows_after}")
    print(f"   Retention rate: {rows_after/rows_before*100:.1f}%")
    print(
        f"   Data quality improvement: {stats_before['data_quality_score']:.2f} -> 100.00"
    )
    print("\n" + "=" * 80)


if __name__ == "__main__":
    main()


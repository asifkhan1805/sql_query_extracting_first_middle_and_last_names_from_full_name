# sql_query_extracting_first_middle_and_last_names_from_full_name
This repository contains an SQL script that demonstrates how to parse full names into first, middle, and last names using T-SQL (SQL Server syntax). It handles names with one, two, or more parts by detecting spaces and extracting substrings accordingly.

## 📌 Description

The main objective of this SQL script is to split a `full_name` column into three parts: `first_name`, `middle_name`, and `last_name`. This is commonly required for normalization, form processing, or data cleaning tasks where full names are initially stored as a single string.

## Table Structure

The table `persons` has the following structure:

```sql
CREATE TABLE persons (
    id INT PRIMARY KEY,
    full_name VARCHAR(100)
);
```

## Insert data

```sql
INSERT INTO persons (id, full_name) VALUES
(1,'John Doe'),
(2,'Emma Watson'),
(3,'Emily Rose Pattrick'),
(4,'Robert Downey'),
(5,'Chris Evans'),
(6,'Scarlett Johansson'),
(7,'Sania Iqbal Shaik');
```
## 📥 Table: `persons`

| id  | full_name                    |
|-----|------------------------------|
| 1   | John Doe                     |
| 2   | Emma Watson                  |
| 3   | Emily Rose Pattrick          |
| 4   | Robert Downey                |
| 5   | Chris Evans                  |
| 6   | Scarlett Johansson           |
| 7   | Sania Iqbal Shaik            |

Each row contains an `id` and a `full_name`. The SQL query will parse this `full_name` into separate first, middle, and last name columns for you.

## 🔍 The Query – How It Works

This SQL query is powered by a **Common Table Expression (CTE)** that performs some smart preprocessing on each `full_name` entry in the `persons` table. It calculates:

- ✅ The **total length** of the full name  
- ✅ The **number of spaces** in the name  
- ✅ The **position of the first and second spaces**

With these insights, the query then slices the `full_name` into three key parts:

- **First Name:** Everything before the first space  
- **Middle Name:** The portion between the first and second spaces (only if present)  
- **Last Name:** Everything after the last space  

### ✨ Key Features:
- 💡 Handles names with **one or two spaces**  
- 🔍 Accurately extracts **first**, **middle**, and **last names**  
- 📌 Returns `'-'` if the **middle name is missing**, ensuring clean output  

This logic makes the query robust and flexible—**ideal for real-world name data processing**.


## Query

```sql

WITH names AS (
    SELECT *, 
           LEN(full_name) AS length, 
           LEN(full_name) - LEN(REPLACE(full_name,' ','')) AS no_of_spaces,
           CHARINDEX(' ', full_name) AS first_space,
           CHARINDEX(' ', full_name, CHARINDEX(' ', full_name)+1) AS second_space
    FROM persons
)
SELECT 
    id,
    CASE WHEN no_of_spaces >= 1 THEN LEFT(full_name, first_space - 1) END AS first_name,
    CASE WHEN no_of_spaces = 2 THEN SUBSTRING(full_name, first_space + 1, length - first_space - (length - second_space)) 
         ELSE '-' END AS middle_name,
    CASE WHEN no_of_spaces = 1 THEN RIGHT(full_name, length - first_space)
         WHEN no_of_spaces = 2 AND second_space IS NOT NULL THEN RIGHT(full_name, length - second_space) 
    END AS last_name
FROM names;
```
## 🧪 Sample Output

| id  | first_name | middle_name            | last_name   |
|-----|------------|------------------------|-------------|
| 1   | John       | -                      | Doe         |
| 2   | Emma       | -                      | Watson      |
| 3   | Emily      | Rose                   | Pattrick    |
| 4   | Robert     | -                      | Downey      |
| 5   | Chris      | -                      | Evans       |
| 6   | Scarlett   | -                      |  Johansson  |
| 7   | Sania      | Iqbal                  | Shaik       |

## 🚀 How to Use
Getting started is quick and easy! Just follow these simple steps:
1. **Clone this repository** or simply copy the SQL query.
2. **Create the `persons` table** in your database.
3. **Insert your full name data** — or use the provided sample data.
4. **Run the query** to instantly extract `first_name`, `middle_name`, and `last_name` fields.

You’ll get clean, structured results ready for reporting, filtering, or further analysis! 💡
---

## 🔧 Prerequisites
Before you begin, make sure you have:
- 🛠️ **SQL Server** or any compatible SQL platform
- 🧠 Basic knowledge of **SQL string functions** (like `LEN`, `SUBSTRING`, `CHARINDEX`)
---

## 📄 License
- This project is licensed under the **MIT License**.
- You're free to use it, modify it, or enhance it however you like — just don’t forget to credit the original author if - ---- you're sharing it publicly!
---

## 🤝 Contributing
- Have ideas to improve the query? Found a bug or edge case I missed?
- We welcome contributions! 🛠️ Simply **fork the repository**, make your changes, and **submit a pull request**. Let’s make - SQL smarter, together!
---






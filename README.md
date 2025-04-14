# sql_query_extracting_first_middle_and_last_names_from_full_name
This repository contains an SQL script that demonstrates how to parse full names into first, middle, and last names using T-SQL (SQL Server syntax). It handles names with one, two, or more parts by detecting spaces and extracting substrings accordingly.
## 📋 Table of Contents

- [Description](#description)
- [Logic Used](#logic-used)
- [Example Output](#example-output)

## 📌 Description

The main objective of this SQL script is to split a `full_name` column into three parts: `first_name`, `middle_name`, and `last_name`. This is commonly required for normalization, form processing, or data cleaning tasks where full names are initially stored as a single string.

This implementation:
- Calculates the number of spaces in the full name.
- Identifies the positions of the first and second spaces.
- Uses conditional logic to extract the name components.


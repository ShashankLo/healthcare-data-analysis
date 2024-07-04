# Healthcare-Data-Analysis

## Project Description
1.This projrect involoves analyzing healthcare data using SQL.The data is stored in three tables 'patients','treatments','staff'.
2.The analysis includes tasks such as inserting valuues to the tables ,quering for specific information and joining the tables to extract      the meaningful insights.

## SQL Queries
The SQL Scripts used for this project includes:
1.Creating tables
2.Inserting values into the tables .
3.Performing various queries.
4.Joining tables for comprehensive analysis

## Steps toReproduce
1.Create the database and table using the provided SQL scripts.
2.Insert the values / data into the tables.
3.Run the SQL queries to perform data analysis.

## Example queries
  **Patients treated in the last month: or between some time interval**
  '''sql
  SELECT p.name ,t.treatment_name,t.treatment_date FROM patients p 
  JOIN treatments t ON p.patient_id=t.patient_id
  WHERE t.treatment_date>=CURDATE()-INTERVAL 1 MONTH
  OR t.treatment_date BETWEEN '2023-01-01' AND '2023-04-04';

CREATE DATABASE HealthCare;
USE HealthCare;

/*Table patients:*/
CREATE TABLE patients(
	patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    location VARCHAR(100)
    );

/*Table treatments:*/    
CREATE TABLE treatments(
	treatment_id INT PRIMARY KEY,
    patient_id INT,
    treatment_name VARCHAR(100),
    treatment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
select * from treatments;

/*Table staff:*/
CREATE TABLE staff(
	staff_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    role VARCHAR(100)
);

SHOW VARIABLES LIKE
'secure_file_priv';

/*Inserting values to the patient table*/
INSERT INTO patients
(patient_id ,name,age, gender,location)
VALUES
(1,'Kishore',45,'male','Bangalore'),
(2,'John Doe',46,'male','NewYork'),
(3,'Jane Smith',52,'female','California'),
(4,'Bob Johnson',36,'male','Texas'),
(5,'Alice Williams',29,'female','Florida');
SELECT * FROM patients;

/*Inserting values to the treatments table*/
INSERT INTO treatments
(treatment_id,patient_id ,treatment_name,treatment_date)
VALUES
(1,1,'Surgery','2023-01-01'),
(2,2,'Therapy','2023-02-15'),
(3,3,'Medication','2023-03-10'),
(4,4,'Therapy','2023-04-05'),
(5,5,'Surgery','2023-05-20');
SET sql_mode ="";
SELECT * FROM treatments;
DESCRIBE treatments;

/*Inserting values to the staff table*/
INSERT INTO staff
(staff_id,name,department,role)
VALUES
(1,'Dr.Adams','Surgery','Surgeon'),
(2,'Dr.Baker','Therapy','Therapist'),
(3,'Nurse Clark','General','Nurse'),
(4,'Dr.Davis','Therapy','Therapist'),
(5,'Nurse Evans','Surgery','Nurse');
SELECT * FROM staff;

/*Count of patients by gender*/
SELECT gender , COUNT(*) AS count
FROM patients GROUP BY gender;

/*List of treatments for each Patient*/
SELECT p.name AS patient_name,
t.treatment_name,
t.treatment_date
FROM patients p 
JOIN treatments t ON p.patient_id = t.patient_id
ORDER BY p.name,t.treatment_date; 

/*Staff details by department*/
SELECT department,COUNT(*) AS staff_count FROM staff 
GROUP BY department;

/*Patients treated in the last month*/
SELECT p.name ,t.treatment_name,t.treatment_date FROM patients p 
JOIN treatments t ON p.patient_id=t.patient_id
WHERE t.treatment_date>=CURDATE()-INTERVAL 1 MONTH
OR t.treatment_date BETWEEN '2023-01-01' AND '2023-04-04';

/*Average age of Patients */
SELECT AVG(age) AS Avg_age FROM patients;

/*Group the patients by location*/
SELECT location,COUNT(*) AS count FROM patients
GROUP BY location;

/*Creating Views for patients with their treatments*/
CREATE OR REPLACE VIEW patient_treatments AS 
SELECT 
	p.patient_id,
    p.name AS patient_name,p.age,p.gender,p.location,
    t.treatment_id ,t.treatment_name,t.treatment_date 
    FROM patients p JOIN treatments t ON p.patient_id = t.patient_id;
SELECT * FROM patient_treatments;

/*Creating a Stored procedure*/
DELIMITER $$
CREATE PROCEDURE AddNewPatient(
	IN p_patient_id INT,
	IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_gender VARCHAR(10),
    IN p_location VARCHAR(100)
)
BEGIN
	INSERT INTO patients (patient_id ,name,age,gender,location)
    VALUES(p_patient_id,p_name,p_age,p_gender,p_location);
    
    INSERT INTO action_log(action_type,action_decription)
    VALUES ('Add patient',CONCAT ('Added new patient:',p_name));
    END $$
DELIMITER ;

CALL AddNewPatient(6,'Shashank',23,'male','Mandya');
    
/*Complex join*/
SELECT 
	p.patient_id,
    p.name AS patient_name,
    t.treatment_id,
    t.treatment_name,
    t.treatment_date,
    s.staff_id,
    s.name AS staff_name,
    s.department
FROM patients p JOIN treatments t ON p.patient_id=t.patient_id JOIN 
staff s ON t.treatment_id = s.staff_id;

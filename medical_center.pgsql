DROP DATABASE medical_center_db;
CREATE DATABASE medical_center_db;

\c medical_center_db;

CREATE TABLE doctors
(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE patients
(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE interactions
(
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER REFERENCES doctors(id) NOT NULL,
    patient_id INTEGER REFERENCES patients(id) NOT NULL,
    notes TEXT,
    interaction_date DATE
);

CREATE TABLE diagnoses
(
    id SERIAL PRIMARY KEY,
    diagnosis TEXT NOT NULL,
    doctor_id INTEGER REFERENCES doctors(id) NOT NULL,
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE NOT NULL,
    interaction_id INTEGER REFERENCES interactions(id) NOT NULL
);


INSERT INTO doctors (first_name,last_name)
VALUES
('Sheri','Saltzman'),('Monica','Altman'),('Gargi','Gandhi'),('Keith','LaScalea'),('Jason','Baker'),('Audrey','Schwabe');

INSERT INTO patients (first_name,last_name)
VALUES
('Adam','Stracher'), ('Johanna','Weiss'),('Melissa','Waterstone'),('Deep','Bhatt'),('Audrey','Schwabe'), ('Brett','Ehrmann');

INSERT INTO interactions (doctor_id,patient_id,notes,interaction_date)
VALUES
(1,3,'COVID19 diagnoses','2021-01-22'),
(1,3,'Follow-up on COVID19','2021-02-22'),
(4,1,'Annual check-up','2021-02-15'),
(2,5,'Discovered underactive thyroid','2021-01-18'),
(2,5,'Continued treatment of thyroid','2021-02-20');

INSERT INTO diagnoses (diagnosis,doctor_id,patient_id,interaction_id)
VALUES
('COVID19',1,3,1),
('Underactive Thyroid',1,5,4);

SELECT i.interaction_date, i.notes, diagnoses.diagnosis, doctors.last_name AS doctor, p.last_name AS patient
FROM interactions i
LEFT JOIN diagnoses ON i.id = diagnoses.interaction_id
JOIN doctors ON i.doctor_id = doctors.id
JOIN patients p ON i.patient_id = p.id
ORDER BY i.interaction_date ASC;

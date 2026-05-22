USE HospitalDB;
GO

DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Medical_Record;
DROP TABLE IF EXISTS Appointment_Service;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Department;
GO

CREATE TABLE Patient (-- 1. Patient Table
    Patient_id   INT  PRIMARY KEY, 
    F_name       NVARCHAR(50) NOT NULL,  
    L_name       NVARCHAR(50) NOT NULL,   
    Phone_no     VARCHAR(20) NOT NULL,    
    Email        VARCHAR(100) NOT NULL,  
    Address      NVARCHAR(250),           
    DOB          DATE NOT NULL,          
    Blood_group  VARCHAR(5),            
    Gender       NVARCHAR(10) NOT NULL,CHECK (Gender IN ('Male', 'Female')));

CREATE TABLE Department ( --2. Department Table
    Dept_id        INT PRIMARY KEY,
    Dept_name      NVARCHAR(100) NOT NULL,
    Location       NVARCHAR(150) NOT NULL,
    Contact_number VARCHAR(20),);

CREATE TABLE Doctor (-- 3. Doctor Table
    Doctor_id           INT PRIMARY KEY,
    Name                NVARCHAR(100) NOT NULL,
    Specialization      NVARCHAR(100),
    Phone_no            VARCHAR(20),
    Email               VARCHAR(100) UNIQUE,
    License_no          VARCHAR(50) UNIQUE NOT NULL,
    Qualification       NVARCHAR(100),
    Years_of_experience INT CHECK (Years_of_experience >= 0),
    Dept_id             INT NOT NULL,
    Supervisor_id       INT NOT NULL,
    CONSTRAINT fk_doctor_dept FOREIGN KEY (Dept_id) REFERENCES Department(Dept_id),
    CONSTRAINT fk_Doctor_Supervisor FOREIGN KEY (Supervisor_id) REFERENCES Doctor(Doctor_id));

CREATE TABLE Appointment (-- 4. Appointment Table
    Appointment_id   INT  PRIMARY KEY,
    Date             DATE NOT NULL,
    Time             TIME NOT NULL,
    Status           NVARCHAR(20) NOT NULL CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    Appointment_type NVARCHAR(20) NOT NULL CHECK (Appointment_type IN ('Consultation', 'Follow-up', 'Emergency')),
    Reason           NVARCHAR(255),
    Patient_id       INT NOT NULL,
    Doctor_id        INT NOT NULL,
    CONSTRAINT fk_app_patient FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    CONSTRAINT fk_app_doctor  FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id),);

CREATE TABLE Service (-- 5. Service Table
    Service_id   INT PRIMARY KEY,
    Service_name NVARCHAR(100) NOT NULL,
    Service_type NVARCHAR(30),
    Unit_price   DECIMAL(10,2) NOT NULL CHECK (Unit_price >= 0),
    Description  NVARCHAR(255),
    Dept_id      INT NOT NULL,
    CONSTRAINT fk_service_dept FOREIGN KEY (Dept_id) REFERENCES Department(Dept_id));

CREATE TABLE Appointment_Service (-- 6. Appointment_Service (Junction Table)
    Appointment_id INT   PRIMARY KEY  NOT NULL,
    Service_id     INT NOT NULL,
    Quantity       INT NOT NULL   CHECK (Quantity > 0),
    CONSTRAINT fk_junction_app FOREIGN KEY (Appointment_id) REFERENCES Appointment(Appointment_id) ON DELETE CASCADE,
    CONSTRAINT fk_junction_srv FOREIGN KEY (Service_id) REFERENCES Service(Service_id));

CREATE TABLE Medical_Record (-- 7. Medical_Record Table
    Record_id              INT  PRIMARY KEY,
    Visit_date             DATE NOT NULL,
    Diagnosis              NVARCHAR(255) NOT NULL,
    Treatment_plan         NVARCHAR(255),
    Prescribed_medications NVARCHAR(255),
    Doctor_notes           NVARCHAR(500),
    Follow_up_required     BIT NOT NULL DEFAULT 0, -- BIT = Boolean
    Patient_id             INT NOT NULL,
    Doctor_id              INT NOT NULL,
    Appointment_id         INT UNIQUE,
    CONSTRAINT fk_record_patient FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    CONSTRAINT fk_record_doctor  FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id),
    CONSTRAINT fk_record_app     FOREIGN KEY (Appointment_id) REFERENCES Appointment(Appointment_id));

CREATE TABLE Billing (-- 8. Billing Table
    Bill_id        INT  PRIMARY KEY,
    Bill_date      DATE NOT NULL,
    Total_amount   DECIMAL(10,2) NOT NULL DEFAULT 0.00 CONSTRAINT chk_bill_amount CHECK (Total_amount >= 0),
    Payment_status NVARCHAR(20) NOT NULL  CHECK (Payment_status IN ('Paid', 'Unpaid', 'Partially Paid')),
    Payment_method NVARCHAR(20) NOT NULL  CHECK (Payment_method IN ('Cash', 'Card', 'Insurance')),
    Due_date       DATE,
    Patient_id     INT NOT NULL,
    Appointment_id INT UNIQUE NOT NULL,
    CONSTRAINT fk_billing_patient FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    CONSTRAINT fk_billing_app     FOREIGN KEY (Appointment_id) REFERENCES Appointment(Appointment_id),);

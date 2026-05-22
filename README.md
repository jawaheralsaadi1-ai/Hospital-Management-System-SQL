# **# Hospital Management System - SQL  Database**



A relational database project implemented using **SQL DDL statements and SQL Server**.



\---



**## Project Overview**



This repository implements a Hospital Management System database using SQL DDL statements.



The main objective of this project is to convert an ERD into a fully implemented relational database schema **using SQL**.



**The system is designed to manage:**



\* Patients

\* Doctors

\* Departments

\* Appointments

\* Medical Records

\* Services

\* Billing



\---



\## Database Features



The project includes:



\* Entity tables

\* Primary Keys

\* Foreign Keys

\* One-to-Many relationships

\* Many-to-Many relationships

\* Constraints and data integrity rules

\* Associative tables with additional attributes



\---



\## Main Tables



1\. Patient

2\. Doctor

3\. Department

4\. Appointment

5\. Service

6\. Medical\_Record

7\. Billing

8\. Appointment\_Service (Table)



\##



\### Many-to-Many Relationship



Appointments and Services are connected through the `Appointment\_Service` table.



The relationship includes:



\* Quantity of services provided



\---



\## Constraints Included



**The schema enforces:**



\* Primary key constraints

\* Foreign key constraints

\* Unique constraints

\* CHECK constraints

\* Referential integrity rules

\* Department management relationship

\* Doctor assignment to departments



\---



**## Technologies Used**



\* SQL DDL

\* SSMS (SQL Server Management Studio)



\---



**## What I Learned from This Project**



\* How to implement SQL DDL schemas

\* Database normalization principles

\* Modeling relationships between entities

\* Implementing One-to-Many and Many-to-Many relationships

\* Constraint implementation

\* Converting ER diagrams into relational schemas

\* Using SQL Server Management Studio (SSMS)



\---



**## Errors I Faced :**



***Error 1:***

```sql

Msg 2714:

There is already an object named 'Department' in the database.

```

**Solution**:

\* **Used `DROP TABLE` before creating tables again.**

\--------------------------------------------------

***Error2***

\### Database Already Exists



```sql

Msg 1801:

Database 'HospitalDB' already exists.

```

**Solution:**

**\* Checked existing databases before creating a new one.**

\-----------------------------------------------

***Error 3***

\### Foreign Key Constraint Error



```sql

Could not drop object 'Doctor' because it is referenced by a FOREIGN KEY constraint.

```

**Solution**:

**\* Dropped related tables in the correct order before recreating them.**

\----------------------------------------------------------------------------

***New information***

\### SQL Server BOOLEAN Issue

SQL Server does not support the `BOOLEAN` data type.

Instead, SQL Server uses:

```sql

BIT

```

Where:

\* `0 = False`

\* `1 = True`



\----------------------------------------------------------------------------



**## Database Concepts Applied**



\* Relational Mapping

\* SQL DDL (`CREATE TABLE`)

\* Relationship Constraints

\* Referential Integrity

\* Associative Tables (Junction table)

\* Department Management

\* Appointment-Service Relationship Modeling



\---



BY

Jawaher 




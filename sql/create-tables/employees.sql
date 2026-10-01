CREATE TABLE IF NOT EXISTS LANDING.EMPLOYEES (
    EMPLOYEEID integer PRIMARY KEY,
    LASTNAME varchar(100),
    FIRSTNAME varchar(100),
    TITLE varchar(100),
    TITLEOFCOURTESY varchar(100),
    BIRTHDATE datetime,
    HIREDATE datetime,
    ADDRESS varchar(100),
    CITY varchar(100),
    REGION varchar(100),
    POSTALCODE varchar(100),
    COUNTRY varchar(100),
    HOMEPHONE varchar(100),
    "EXTENSION" varchar(100),
    PHOTO string,
    NOTES string,
    REPORTSTO varchar(100),
    PHOTOPATH string

);

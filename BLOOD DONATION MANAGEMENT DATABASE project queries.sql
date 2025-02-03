CREATE DATABASE PROJECT;
use project;
CREATE TABLE donor_table(
 Donor_Id INT PRIMARY KEY AUTO_INCREMENT,
 Donor_Name VARCHAR(100) NOT NULL, 
 Age INT CHECK (Age >= 18 AND Age <= 65), 
 Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
 Blood_Group VARCHAR(5) NOT NULL,
 Contact_Number VARCHAR(15) UNIQUE NOT NULL,
 Email_Id VARCHAR(50) UNIQUE NOT NULL,
 Address VARCHAR(255) NULL,
 Last_Donation_Date DATE,
 Total_Donations INT DEFAULT 0);
CREATE TABLE Donation_table(
 Donation_Id INT PRIMARY KEY AUTO_INCREMENT,
 Donor_Id INT ,
 Blood_Group VARCHAR(5)	NOT NULL,
 Quantity_Donated INT NOT NULL,
 DonationDate DATE NOT NULL,
 FOREIGN KEY(Donor_Id) REFERENCES donor_table(Donor_Id)); 
 CREATE TABLE Recipient_table(
 Recipient_Id INT PRIMARY KEY AUTO_INCREMENT,
 Recipient_Name VARCHAR(100) NOT NULL, 
 Age INT CHECK (Age >= 18 AND Age <= 65), 
 Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
 Blood_Group VARCHAR(5) NOT NULL,
 Contact_Number VARCHAR(15) UNIQUE NOT NULL,
 Email_Id VARCHAR(50) UNIQUE NOT NULL,
 Address VARCHAR(255) NULL,
 RequiredBloodGroup	VARCHAR(5)	NOT NULL,
 RequiredQuantity	INT	NOT NULL);
 CREATE TABLE Donation_Status_table(
 Donation_Id INT,
 Recipient_Id INT,
 Blood_Group VARCHAR(5)	NOT NULL,
 Quantity_Donated INT NOT NULL,
 Donation_Date DATE NOT NULL,
 Status VARCHAR(20)	CHECK (Status IN ('Pending', 'Fulfilled', 'Rejected')),
 FOREIGN KEY(Donation_Id) REFERENCES Donation_table(Donation_Id),
 FOREIGN KEY(Recipient_Id) REFERENCES Recipient_table(Recipient_Id));
 INSERT INTO donor_table(Donor_Id, Donor_Name, Age, Gender, Blood_Group, Contact_Number, Email_Id, Address, Last_Donation_Date, Total_Donations)
VALUES 
(001, 'Saksitha_M', 22, 'Female', 'A+', '9965088698', 'saksitha75@gmail.com', '2/253, Sai Ram ladies hostel, chennai.', '2022-05-07', 2),
(002, 'Jana_k', 21, 'Male', 'A+', '9965088697', 'janak75@gmail.com', '2/252, Ram mens hostel, chennai.', '2022-04-23', 1),
(003, 'Jayashree_C', 21, 'Female', 'B+', '9442875232', 'c.jayashree135@gmail.com', 'Lakshmi ladies hostel, chennai.', '2020-04-27', 1),
(004, 'Meenaloshini_C', 20, 'Female', 'B+', '9698383502', 'winxwinxzoos11@gmail.com', '278/F, Gandhi Market, trichy.', '2022-07-13', 1);
INSERT INTO Donation_table (Donor_Id, Blood_Group, Quantity_Donated, DonationDate)
VALUES 
(001, 'A+', 500, '2023-08-10'),
(002, 'A+', 450, '2023-07-15'),
(003, 'B+', 400, '2023-09-01'),
(004, 'B+', 350, '2023-12-10');
INSERT INTO Recipient_table (Recipient_Name, Age, Gender, Blood_Group, Contact_Number, Email_Id, Address, RequiredBloodGroup, RequiredQuantity)
VALUES
('Nithya_R', 30, 'Female', 'A+', '9876543210', 'nithya_r@example.com', '5/123, MG Road, Chennai', 'A+', 500),
('Kumar_P', 45, 'Male', 'O-', '9898989898', 'kumar_p@example.com', '12/33, Gandhi Street, Mumbai', 'O-', 450),
('Suresh_M', 28, 'Male', 'B+', '9765432190', 'suresh_m@example.com', '7/89, Anna Nagar, Bangalore', 'B+', 300),
('Priya_S', 35, 'Female', 'AB+', '9443322110', 'priya_s@example.com', '3/12, Park Avenue, Delhi', 'AB+', 600),
('Rahul_K', 22, 'Male', 'O+', '9123456789', 'rahul_k@example.com', '10/45, Victoria Lane, Kolkata', 'O+', 400),
('Leela_V', 40, 'Female', 'B-', '9112345678', 'leela_v@example.com', '5/B, Sunrise Apartments, Hyderabad', 'B-', 350);

INSERT INTO Donation_Status_table (Donation_Id, Recipient_Id, Blood_Group, Quantity_Donated, Donation_Date, Status)
VALUES
(1, 1, 'A+', 500, '2023-08-10', 'Fulfilled'),  -- Donation from Donor 1 (Saksitha_M) to Recipient 1 (Nithya_R) is fulfilled
(2, 2, 'A+', 450, '2023-08-15', 'Pending'),   -- Donation from Donor 2 (Jana_k) to Recipient 2 (Kumar_P) is pending
(3, 3, 'B+', 400, '2023-09-01', 'Rejected'),  -- Donation from Donor 3 (Jayashree_C) to Recipient 3 (Suresh_M) is rejected
(4, 4, 'B+', 350, '2023-09-10', 'Fulfilled'); -- Donation from Donor 4 (Meenaloshini_C) to Recipient 4 (Priya_S) is fulfilled

UPDATE donation_status_table SET Status='Pending' WHERE Donation_Id=3;
CREATE INDEX idx_recipient ON Recipient_table(Recipient_Name, Age, Gender, Blood_Group, Contact_Number);
DROP INDEX idx_recipient ON recipient_table;
SELECT * FROM Donation_status_table WHERE status='fulfilled';
SELECT DISTINCT Donor_Id , Quantity_Donated FROM Donation_table Where Blood_Group='A+'; -- distinct values
SELECT donation_id,blood_group,quantity_donated FROM donation_status_table ORDER BY quantity_donated DESC; -- orderby
SELECT * FROM Donor_table WHERE Gender='Female' AND Blood_Group='B+'; -- AND Operator
SELECT * FROM Donor_table WHERE Gender='Male' OR Blood_Group='A+'; -- OR Operator
SELECT * FROM Donor_table WHERE NOT Gender='Male'; -- NOT Operator
SELECT * FROM Donation_Status_table WHERE Quantity_Donated IS NOT NULL; -- IS NOT NULL
SELECT * FROM Recipient_table LIMIT 5; -- LIMIT 
SELECT MIN(Quantity_Donated) FROM Donation_Status_Table; -- Aggragate MIN
SELECT MAX(Quantity_Donated) FROM Donation_Status_Table; -- Aggragate MAX
SELECT SUM(Quantity_Donated) FROM Donation_Status_Table; -- Aggragate SUM
SELECT AVG(Quantity_Donated) FROM Donation_Status_Table; -- Aggragate AVG
SELECT COUNT(Quantity_Donated) FROM Donation_Status_Table; -- Aggragate COUNT
SELECT * FROM donor_table WHERE Age LIKE 21; -- LIKE 
SELECT * FROM donor_table WHERE Blood_Group IN ('A+'); -- IN Operator
SELECT * FROM recipient_table WHERE age BETWEEN 20 AND 30; -- BETWEEN OPERATOR
SELECT * FROM recipient_table WHERE age NOT BETWEEN 20 AND 30; -- NOT BETWEEN OPERATOR
SELECT * FROM recipient_table 
WHERE recipient_id BETWEEN 2 AND 6 
AND age IN (30, 35, 40, 45); -- BETWEEN WITH IN Operator
SELECT * FROM donation_table WHERE DonationDate BETWEEN '2023-07-01' AND '2023-12-30'ORDER BY DonationDate ASC; -- BETWEEN DATES 
SELECT  Donation_Id, Recipient_Id, Blood_Group, Quantity_Donated FROM donation_Status_table AS Blood_Donated_list; -- Aliases
SELECT * FROM donation_Status_table INNER JOIN Donation_table ON Donation_Status_Table.donation_id=donation_table.donation_id; -- INNER JOIN
SELECT * FROM donation_Status_table LEFT JOIN Donation_table ON Donation_Status_Table.donation_id=donation_table.donation_id; -- LEFT JOIN
SELECT * FROM donation_Status_table RIGHT JOIN Donation_table ON Donation_Status_Table.donation_id=donation_table.donation_id; -- RIGHT JOIN
DELETE FROM donation_Status_table WHERE Donation_id=4; -- Delete a row in a table
SELECT DATEDIFF ('2023-12-10' , '2023-07-15') AS DIFFERENCE_DATE FROM donation_table; -- Date difference
SELECT YEAR(DonationDATE) AS YEAR FROM donation_table; -- extracting year
SELECT MONTH(DonationDATE) AS MONTH FROM donation_table; -- extracting month
SELECT DAY(DonationDATE) AS DAY FROM donation_table; -- extracting DATE
SELECT donor_name AS NAMES FROM donor_table UNION SELECT recipient_name FROM recipient_table; -- UNION using aliases
SELECT COUNT(blood_group), GENDER FROM donor_table Group BY Gender ; -- GROUP BY GENDER;
SELECT DonationDate 
FROM donation_table 
WHERE EXISTS (
    SELECT BLOOD_GROUP 
    FROM Donor_table 
    WHERE Donor_table.Donor_ID = donation_table.Donor_ID 
    AND AGE >= 21
); -- EXISTS Operator
CREATE VIEW VIEW_NAME AS SELECT Recipient_Name, Age, Gender, Blood_Group, Contact_Number FROM recipient_table; -- VIEW STATEMENT CREATION
SELECT * FROM VIEW_NAME;
DROP VIEW VIEW_NAME;
CREATE USER 'SAKSITHA@LOCALHOST' IDENTIFIED BY 'Saksitha@75'; -- CREATE NEW USER
GRANT UPDATE ON donor_table TO 'SAKSITHA@LOCALHOST'; -- GRANT PRIVILEGES
REVOKE UPDATE ON donor_table FROM 'SAKSITHA@LOCALHOST'; -- REVOKE PRIVILEGES
SELECT recipient_name from recipient_table WHERE recipient_name REGEXP '^S.*_M$'; -- REGEX
DELIMITER //
     CREATE PROCEDURE call_table()
     BEGIN
     SELECT* FROM donor_table ;
     SELECT * FROM DONATION_TABLE;  
     END //
    DELIMITER ;
CALL call_table(); 
 DELIMITER //
     CREATE PROCEDURE procedure_name()
     BEGIN
     SELECT* FROM donor_table ;
     END //
     DELIMITER ;
CALL procedure_name();
DROP PROCEDURE procedure_name;


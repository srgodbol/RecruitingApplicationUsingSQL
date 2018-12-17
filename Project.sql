DROP Table WorkHistory
DROP Table JobApplication
DROP Table Position
DROP Table Recruiter
DROP Table Employer
DROP Table Education
DROP Table Certification
DROP Table Candidate


CREATE TABLE Candidate
(
CandidateId INTEGER NOT NULL PRIMARY KEY,
CandidateEmail VARCHAR(50) NOT NULL,
CandidatePassword VARCHAR(8) NOT NULL,
CandidateFirstName VARCHAR(40) NOT NULL,
CandidateLastName VARCHAR(40) NOT NULL,
CandidateContactNumber VARCHAR(10) NOT NULL,
CandidateStreetNo VARCHAR(30) NOT NULL,
CandidateStreetName VARCHAR(30) NOT NULL,
CandidateCity VARCHAR(30) NOT NULL,
CandidateState VARCHAR(30) NOT NULL,
CandidateCountry VARCHAR(30) NOT NULL DEFAULT 'United States',
CandidateZip VARCHAR(5) NOT NULL,
CONSTRAINT chk_phone CHECK (CandidateContactNumber not like '%[^0-9]%'),
/*CONSTRAINT chk_email CHECK (CandidateEmail like '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z{2,4}'),*/
/*CONSTRAINT chk_email CHECK (CandidateEmail like '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'),*/
CONSTRAINT CHK_ZIPCode CHECK (CandidateZip LIKE '[0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT chk_pwd CHECK (CandidatePassword like '%[0-9]%' and CandidatePassword like '%[A-Z]%' and CandidatePassword like '%[!@#$%a^&*()-_+=.,;:`~]%')
)

INSERT INTO Candidate (CandidateId, CandidateEmail, CandidatePassword, CandidateFirstName, CandidateLastName, CandidateContactNumber, 
CandidateStreetNo, CandidateStreetName, CandidateCity, CandidateState, CandidateCountry, CandidateZip)  
VALUES ('1','anujjn66@gmail.com','anujjn66','Anuj','Jain','3157514396','2','westcott','Syracuse','New York','United States','13210')

Select * from Candidate
/*Insert into Candidate values ('1','anujjn66@gmail.com','anujjn66','Anuj','Jain','3157514396','2','westcott','Syracuse','New York','','13210');*/

CREATE TABLE Education
(
EducationId INTEGER NOT NULL PRIMARY KEY,
CandidateID INTEGER NOT NULL FOREIGN KEY REFERENCES Candidate(CandidateId),
DegreeType VARCHAR(8) NOT NULL,
Major VARCHAR(30) NOT NULL,
Minor VARCHAR(30),
University VARCHAR(20) NOT NULL,
UniversityCity VARCHAR(30) NOT NULL,
CandidateState VARCHAR(30) NOT NULL,
UniversityCountry VARCHAR(30) NOT NULL DEFAULT 'United States',
UniversityZip VARCHAR(5) NOT NULL,
GPA_Out_Of_Four VARCHAR (3) NOT NULL,
StartDate DATE NOT NULL,--Remember to mention format
GraduationDate DATE NOT NULL,--Remember to mention format
CONSTRAINT chk_graduationdate CHECK (GraduationDate > StartDate),
CONSTRAINT CHK_Univzip CHECK (UniversityZip LIKE '[0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT chk_GPA CHECK (GPA_Out_Of_Four LIKE '[0-4].[0-4]'),
CONSTRAINT chk_DegreeType CHECK (DegreeType='B.S.' OR DegreeType='M.S.' OR DegreeType='High School' OR DegreeType='Docterate' OR DegreeType='Diploma'),
)

Insert into Education (EducationId, CandidateID, DegreeType, Major, Minor, University, UniversityCity, CandidateState, 
UniversityCountry,UniversityZip, GPA_Out_Of_Four, StartDate, GraduationDate) VALUES 
('1','1','M.S.','Information Management','Data Science','Syracuse University','Syracuse','New York','United States','13210','4.0','5/4/2013','5/7/2018');

Select * from Education

CREATE TABLE WorkHistory
(
WorkHistoryId INTEGER NOT NULL PRIMARY KEY,
CandidateID INTEGER NOT NULL FOREIGN KEY REFERENCES Candidate(CandidateId),
Employer VARCHAR(50) NOT NULL,
Position VARCHAR(30) NOT NULL,
EmployerCity VARCHAR(30) NOT NULL,
EmployerState VARCHAR(30) NOT NULL,
EmployerCountry VARCHAR(30) NOT NULL DEFAULT 'United States',
EmployerZip VARCHAR(5) NOT NULL,
ReasonToLeave VARCHAR(100),
StartDate DATE NOT NULL,--Remember to mention format
EndDate DATE NOT NULL,--Remember to mention format
RolesAndResposibilities VARCHAR(300) NOT NULL,
CONSTRAINT chk_EndDate CHECK (EndDate > StartDate),
CONSTRAINT CHK_EmployerZip CHECK (EmployerZip LIKE '[0-9][0-9][0-9][0-9][0-9]')
)

Insert into WorkHistory (WorkHistoryId, CandidateID,Employer, Position, EmployerCity, EmployerState, EmployerCountry, EmployerZip, ReasonToLeave
,StartDate, EndDate, RolesAndResposibilities)VALUES
('1','1','JM Family','Data Governance','Miami','FLorida','United States','34543','personal','04/05/2013','05/06/2017','NA')

Select * from WorkHistory

CREATE TABLE Certification
(
CertificationID INTEGER NOT NULL PRIMARY KEY,
CandidateID INTEGER NOT NULL FOREIGN KEY REFERENCES Candidate(CandidateId),
Certification VARCHAR(50) NOT NULL,
StartDate DATE NOT NULL,--Remember to mention format
ExpiryDate DATE,--Remember to mention format
CONSTRAINT chk_ExpiryDate CHECK (ExpiryDate > StartDate)
)

Insert into Certification(CertificationID,CandidateID, Certification, StartDate, ExpiryDate) 
VALUES('1','1','Coursera Machine Learning','04/04/2017','05/03/2018')

Select * from Certification

CREATE TABLE Employer 
(
EmployerId INTEGER NOT NULL PRIMARY KEY,
EmployerName VARCHAR(50) NOT NULL,
EmployerHQStreetNo VARCHAR(30) NOT NULL,
EmployerHQStreetName VARCHAR(30) NOT NULL,
EmployerHQCity VARCHAR(30) NOT NULL,
EmployerHQState VARCHAR(30) NOT NULL,
EmployerHQCountry VARCHAR(30) NOT NULL DEFAULT 'United States',
EmployerHQZip VARCHAR(5) NOT NULL,
EmployerHQIndustry VARCHAR(20) NOT NULL, -- add values for picklist
EmployerWebsite VARCHAR(50) NOT NULL,
/*CONSTRAINT chk_EmployerWebsite CHECK (EmployerWebsite like 'https://[A-Za-z0-9._%+-]+/.[A-Za-z0-9.-]+/.[A-Za-z]{2,4}$')*/
CONSTRAINT CHK_EmployerHQZip CHECK (EmployerHQZip LIKE '[0-9][0-9][0-9][0-9][0-9]')
)

Insert into Employer Values ('1','Philips','2nd','wall street','New York','New York','United States','35464','Electronics','https://www.philips.com')

Select * from Employer

CREATE TABLE Recruiter
(
RecruiterID INTEGER NOT NULL PRIMARY KEY,
EmployerId INTEGER NOT NULL FOREIGN KEY REFERENCES Employer(EmployerId),
RecruiterFirstName VARCHAR(40) NOT NULL,
RecruiterLastName VARCHAR(40) NOT NULL,
RecruiterEmail VARCHAR(20) NOT NULL,
RecruiterContactNumber VARCHAR(9) NOT NULL,
EmployerCity VARCHAR(30) NOT NULL,
EmployerState VARCHAR(30) NOT NULL,
EmployerCountry VARCHAR(30) NOT NULL DEFAULT 'United States',
EmployerZip VARCHAR(5) NOT NULL,
CONSTRAINT chk_Rphone CHECK (RecruiterContactNumber not like '%[^0-9]%'),
/*CONSTRAINT chk_Remail CHECK (RecruiterEmail like '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')*/
)

Insert into Recruiter Values ('1','1','Jay','Smith','jayjay04@gmail.com','23454543','New York','New York','United States','33333')

Select * from Recruiter

CREATE TABLE Position
(
PositionId INTEGER NOT NULL PRIMARY KEY,
PositionTitle VARCHAR(40) NOT NULL,
EmployerId INTEGER NOT NULL FOREIGN KEY REFERENCES Employer(EmployerId),
RecruiterId INTEGER NOT NULL FOREIGN KEY REFERENCES Recruiter(RecruiterId),
PositionInitiationDate DATE NOT NULL,
PositionApplicationDeadline Date NOT NULL,
PositionType VARCHAR(20) NOT NULL,
IsPositionAvailable VARCHAR(3) NOT NULL DEFAULT 'YES',
Responsibilities VARCHAR(500) NOT NULL,
Expectations VARCHAR(100) NOT NULL,
Compensation VARCHAR(50),
CONSTRAINT chk_PositionType CHECK (PositionType='Internship' OR PositionType='Full-Time' OR PositionType='Part-Time' OR
PositionType='Temporary'),
CONSTRAINT chk_IsPositionAvailable CHECK (IsPositionAvailable='YES' OR IsPositionAvailable='NO')
)

Insert into Position Values ('1','Associate Engineer','1','1','05/05/2018','06/08/2017','Full-Time','YES','NA','NA','50,000$')

Select * from Position

CREATE TABLE JobApplication
(
JobApplicationId INTEGER NOT NULL Primary Key,
PositionId INTEGER NOT NULL FOREIGN KEY REFERENCES Position(PositionId),
CandidateId INTEGER NOT NULL FOREIGN KEY REFERENCES Candidate(CandidateId),
CandidateResume VARCHAR(1000) NOT NULL ,
CandidateCoverLetter VARCHAR(1000),
SubmittedDate DATE NOT NULL DEFAULT GETDATE(),
ApplicationDeadline DATE NOT NULL,
IsSelected VARCHAR(3) NOT NULL DEFAULT 'NO', 
IsAccepted VARCHAR(3) NOT NULL DEFAULT 'NO',
CONSTRAINT chk_IsSelected CHECK (IsSelected='YES' OR IsSelected='NO'),
CONSTRAINT chk_IsAccepted CHECK (IsAccepted='YES' OR IsAccepted='NO')
)

Insert into JobApplication Values('1','1','1','NA','NA','','6/6/2019','YES','NO')

Select * from JobApplication


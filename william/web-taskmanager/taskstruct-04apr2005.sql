# MdbToMySQL MySQL-Dump
# version 1.01
# http://www.zebradb.de
# --------------------------------------------------------

#
# Table structure for table Company
#

DROP TABLE IF EXISTS Company;
CREATE TABLE Company (
   CompanyName VARCHAR(75) NOT NULL,
   Address1 VARCHAR(50),
   Address2 VARCHAR(255),
   Address3 VARCHAR(50),
   Address4 VARCHAR(50),
   Town/City VARCHAR(30),
   County VARCHAR(20),
   PostalCode VARCHAR(20),
   Country VARCHAR(20),
   Phone VARCHAR(30),
   WorkExtension VARCHAR(6),
   FaxNumber VARCHAR(30),
   ModemNumber VARCHAR(30),
   ModemPassword VARCHAR(30),
   Email VARCHAR(50),
   Notes TEXT,
   Pharaoh TINYINT,
   INDEX (CompanyName),
   PRIMARY KEY (CompanyName)
);

#
# Table structure for table Contacts
#

DROP TABLE IF EXISTS Contacts;
CREATE TABLE Contacts (
   ContactID INT NOT NULL AUTO_INCREMENT,
   CompanyName VARCHAR(75) NOT NULL,
   MainContact TINYINT,
   FirstName VARCHAR(30),
   LastName VARCHAR(30),
   Salutation VARCHAR(5),
   Job_Title VARCHAR(50),
   Department VARCHAR(50),
   WorkPhone VARCHAR(30),
   WorkExtension VARCHAR(6),
   HomePhone VARCHAR(30),
   MobilePhone VARCHAR(30),
   FaxNumber VARCHAR(30),
   Email VARCHAR(50),
   Notes VARCHAR(255),
   INDEX (CompanyName),
   INDEX (CompanyName),
   INDEX (ContactID),
   PRIMARY KEY (ContactID)
);

#
# Table structure for table Staff
#

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
   StaffName VARCHAR(50) NOT NULL,
   Left TINYINT DEFAULT 0 NOT NULL,
   PRIMARY KEY (StaffName)
);

#
# Table structure for table Tasks
#

DROP TABLE IF EXISTS Tasks;
CREATE TABLE Tasks (
   TaskID INT NOT NULL AUTO_INCREMENT,
   CompanyName VARCHAR(75) NOT NULL,
   date_started DATETIME,
   date_finished DATETIME,
   details TEXT,
   header VARCHAR(250),
   Staff VARCHAR(50),
   Bug TINYINT,
   INDEX (CompanyName),
   INDEX (CompanyName),
   PRIMARY KEY (TaskID),
   INDEX (TaskID)
);


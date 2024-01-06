DROP DATABASE  CARS;
CREATE DATABASE CARS;
USE CARS;

CREATE TABLE `cars`.`victims` (
  `victimId` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `DateOfBirth` DATE NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `contactInformation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`victimId`));

CREATE TABLE `cars`.`suspects` (
  `suspectId` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `dateOfBirth` DATE NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `contactInformation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`suspectId`));

CREATE TABLE `cars`.`incidents` (
  `incidentId` INT NOT NULL AUTO_INCREMENT,
  `incidentType` ENUM('Robbery', 'Homicide', 'Theft') NOT NULL,
  `incidentDate` DATE NOT NULL,
  `Location` varchar(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `Status` ENUM('Open', 'Closed', 'Under Investigation') NOT NULL,
  `victimId` INT NOT NULL,
  `suspectId` INT NOT NULL,
  PRIMARY KEY (`incidentId`),
  INDEX `victimId_idx` (`victimId` ASC) VISIBLE,
  INDEX `suspectId_idx` (`suspectId` ASC) VISIBLE,
  CONSTRAINT `victimId`
    FOREIGN KEY (`victimId`)
    REFERENCES `cars`.`victims` (`victimId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `suspectId`
    FOREIGN KEY (`suspectId`)
    REFERENCES `cars`.`suspects` (`suspectId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cars`.`case1` (
  `CaseId` INT NOT NULL AUTO_INCREMENT,
  `CaseDescription` VARCHAR(45) NOT NULL,
  `IncidentId` INT NOT NULL,
  PRIMARY KEY (`CaseId`),
  INDEX `inci_idx` (`IncidentId` ASC) VISIBLE,
  CONSTRAINT `inci`
    FOREIGN KEY (`IncidentId`)
    REFERENCES `cars`.`incidents` (`incidentId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

    
CREATE TABLE `cars`.`evidence` (
  `evidenceId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `locationFound` VARCHAR(45) NOT NULL,
  `incidentId` INT NOT NULL,
  PRIMARY KEY (`evidenceId`),
  INDEX `incident_id_idx` (`incidentId` ASC) VISIBLE,
  CONSTRAINT `incidentId`
    FOREIGN KEY (`incidentId`)
    REFERENCES `cars`.`incidents` (`incidentId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cars`.`lawEnforcementAgencies` (
  `AgencyId` INT NOT NULL AUTO_INCREMENT,
  `AgencyName` VARCHAR(45) NOT NULL,
  `Jurisdiction` VARCHAR(45) NOT NULL,
  `ContactInformation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AgencyId`));
  ALTER TABLE `cars`.`lawEnforcementAgencies` 
ADD INDEX `officers_idx` (`Officers` ASC) VISIBLE;
ALTER TABLE `cars`.`lawEnforcementAgencies` 
ADD CONSTRAINT `officers`
  FOREIGN KEY (`Officers`)
  REFERENCES `cars`.`officers` (`OfficerId`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  
  CREATE TABLE `cars`.`officers` (
  `OfficerId` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `BadgeNumber` VARCHAR(45) NOT NULL,
  `Rankp` VARCHAR(45) NOT NULL,
  `ContactInformation` VARCHAR(45) NOT NULL,
  `agencyId` INT NOT NULL,
  PRIMARY KEY (`OfficerId`),
  INDEX `agency_id_idx` (`agencyId` ASC) VISIBLE,
  CONSTRAINT `agencyId`
    FOREIGN KEY (`agencyId`)
    REFERENCES `cars`.`lawEnforcementAgencies` (`AgencyId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

CREATE TABLE `cars`.`reports` (
  `reportId` INT NOT NULL AUTO_INCREMENT,
  `IncidentId` INT NOT NULL,
  `ReportingOfficer` INT NOT NULL,
  `ReportDate` DATE NOT NULL,
  `ReportDetails` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reportId`),
  INDEX `incident_id_idx` (`IncidentId` ASC) VISIBLE,
  INDEX `officer_id_idx` (`ReportingOfficer` ASC) VISIBLE,
  CONSTRAINT `Incident_id1`
    FOREIGN KEY (`IncidentId`)
    REFERENCES `cars`.`incidents` (`incidentId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `officerId`
    FOREIGN KEY (`ReportingOfficer`)
    REFERENCES `cars`.`officers` (`OfficerId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
 use cars;
 
 -- Insert data into Incidents Table
INSERT INTO Incidents (IncidentID, IncidentType, IncidentDate, Location, Description, Status, VictimID, SuspectID)
VALUES
(1, 'Robbery', '2023-01-01', '40.7128, 74.0060', 'Armed robbery at a convenience store', 'Open', 1, 2),
(2, 'Homicide', '2023-02-15', '34.0522, 118.2437', 'Investigation of a murder case', 'Closed', 2, 1),
(3, 'Theft', '2023-03-10', '41.8781, 87.6298', 'Stolen vehicle report', 'Under Investigation', 3, 3),
(4, 'Homicide', '2023-04-05', '36.7783, 119.4179', 'Physical altercation in a bar', 'Open', 4, 4),
(5, 'Theft', '2023-05-20', '32.7157, 117.1611', 'Break-in at a residential property', 'Closed', 5, 5),
(6, 'Robbery', '2023-06-12', '37.7749, 122.4194', 'Identity theft and financial fraud', 'Open', 6, 6),
(7, 'Homicide', '2023-07-03', '33.6846, 117.8265', 'Destruction of public property', 'Closed', 7, 7),
(8, 'Robbery', '2023-08-18', '39.9526, 75.1652', 'Abduction of a minor', 'Under Investigation', 8, 8),
(9, 'Homicide', '2023-09-10', '29.7604, 95.3698', 'Illegal drug trade operation', 'Open', 9, 9),
(10, 'Theft', '2023-10-05', '51.5074, 0.1278', 'Online hacking and data breach', 'Closed', 10, 10);

-- Insert data into Victims Table
INSERT INTO Victims (VictimID, FirstName, LastName, DateOfBirth, Gender, ContactInformation)
VALUES
(1, 'John', 'Doe', '1980-05-10', 'Male', '123 Main St, City, Country, 12345'),
(2, 'Jane', 'Smith', '1995-12-20', 'Female', '456 Oak St, City, Country, 56789'),
(3, 'Chris', 'Johnson', '1988-08-05', 'Male', '789 Elm St, City, Country, 10111'),
(4, 'Emily', 'White', '1990-03-25', 'Female', '987 Pine St, City, Country, 20222'),
(5, 'David', 'Brown', '1982-12-15', 'Male', '654 Birch St, City, Country, 30333'),
(6, 'Maria', 'Martinez', '1993-06-30', 'Female', '321 Cedar St, City, Country, 40444'),
(7, 'Alex', 'Taylor', '1985-09-12', 'Male', '555 Spruce St, City, Country, 50555'),
(8, 'Olivia', 'Miller', '1997-01-22', 'Female', '999 Pine St, City, Country, 60666'),
(9, 'Daniel', 'Thomas', '1987-11-08', 'Male', '777 Oak St, City, Country, 70777'),
(10, 'Sophia', 'Davis', '1998-04-18', 'Female', '888 Elm St, City, Country, 80888');
truncate table victims;
-- Insert data into Suspects Table
INSERT INTO Suspects (SuspectID, FirstName, LastName, DateOfBirth, Gender, ContactInformation)
VALUES
(1, 'Robert', 'Johnson', '1985-08-18', 'Male', '789 Elm St, City, Country, 10111'),
(2, 'Emily', 'White', '1990-03-25', 'Female', '987 Pine St, City, Country, 20222'),
(3, 'David', 'Brown', '1982-12-15', 'Male', '654 Birch St, City, Country, 30333'),
(4, 'Sophia', 'Smith', '1991-07-08', 'Female', '222 Cedar St, City, Country, 40444'),
(5, 'James', 'Jones', '1983-04-30', 'Male', '111 Spruce St, City, Country, 50555'),
(6, 'Mia', 'Martinez', '1994-09-19', 'Female', '333 Cedar St, City, Country, 60666'),
(7, 'Ethan', 'Davis', '1986-02-11', 'Male', '444 Oak St, City, Country, 70777'),
(8, 'Isabella', 'Taylor', '1995-05-27', 'Female', '666 Elm St, City, Country, 80888'),
(9, 'Daniel', 'Thomas', '1987-11-08', 'Male', '777 Oak St, City, Country, 70777'),
(10, 'Ava', 'Miller', '1996-12-03', 'Female', '555 Pine St, City, Country, 60666');

-- Insert data into LawEnforcementAgencies Table
INSERT INTO LawEnforcementAgencies (AgencyID, AgencyName, Jurisdiction, ContactInformation)
VALUES
(1, 'City Police Department', 'Citywide', 'Contact info for City PD'),
(2, 'County Sheriff Office', 'Countywide', 'Contact info for County SO'),
(3, 'State Bureau of Investigation', 'Statewide', 'Contact info for SBI'),
(4, 'Federal Bureau of Investigation', 'National', 'Contact info for FBI'),
(5, 'Drug Enforcement Administration', 'National', 'Contact info for DEA'),
(6, 'Department of Homeland Security', 'National', 'Contact info for DHS'),
(7, 'Interpol', 'International', 'Contact info for Interpol'),
(8, 'Secret Service', 'National', 'Contact info for Secret Service'),
(9, 'Environmental Protection Agency', 'National', 'Contact info for EPA'),
(10, 'Transportation Security Administration', 'National', 'Contact info for TSA');

-- Insert data into Officers Table
INSERT INTO Officers VALUES
(1, 'Michael', 'Smith', 'ABC123', 'Sergeant', '123 Main St, City, Country, 12345', 1),
(2, 'Jennifer', 'Williams', 'XYZ456', 'Detective', '456 Oak St, City, Country, 56789', 2),
(3, 'Christopher', 'Davis', 'LMN789', 'Officer', '789 Maple St, City, Country, 40444', 3),
(4, 'Emily', 'Brown', 'PQR012', 'Lieutenant', '321 Cedar St, City, Country, 50555', 4),
(5, 'Matthew', 'Taylor', 'DEF345', 'Officer', '555 Spruce St, City, Country, 50555', 5),
(6, 'Sophia', 'Jones', 'GHI678', 'Sergeant', '999 Pine St, City, Country, 60666', 6),
(7, 'Ethan', 'Martinez', 'JKL901', 'Detective', '777 Oak St, City, Country, 70777', 7),
(8, 'Olivia', 'Miller', 'MNO234', 'Captain', '555 Pine St, City, Country, 60666', 8),
(9, 'Daniel', 'Thomas', 'PQR567', 'Lieutenant', '888 Elm St, City, Country, 80888', 9),
(10, 'Ava', 'Davis', 'STU890', 'Officer', '666 Elm St, City, Country, 80888', 10);

-- Insert data into Evidence Table
INSERT INTO Evidence (EvidenceID, Description, LocationFound, IncidentID)
VALUES
(1, 'Surveillance footage', 'At the crime scene', 1),
(2, 'Fingerprint on the weapon', 'In the suspect\'s residence', 2),
(3, 'DNA sample', 'Near the crime scene', 3),
(4, 'Security camera footage', 'Outside the bar', 4),
(5, 'Tool marks at the scene', 'Burglarized property', 5),
(6, 'Email records', 'Digital evidence', 6),
(7, 'Vandalized property', 'Public park', 7),
(8, 'Witness statements', 'Kidnapping incident', 8),
(9, 'Drug samples seized', 'Trafficking operation', 9),
(10, 'Server logs', 'Online hacking incident', 10);

-- Insert data into Reports Table
INSERT INTO Reports (ReportID, IncidentID, ReportingOfficer, ReportDate, ReportDetails, Status)
VALUES
(1, 1, 1, '2023-01-02', 'Initial incident report for robbery', 'Finalized'),
(2, 2, 2, '2023-02-20', 'Final report on the homicide investigation', 'Finalized'),
(3, 3, 3, '2023-03-15', 'Ongoing investigation on stolen vehicle', 'Draft'),
(4, 4, 4, '2023-04-10', 'Assault case report', 'Finalized'),
(5, 5, 5, '2023-04-10','Report on the burglary incident', 'Finalized'),
(6, 6, 6, '2023-04-10','Fraud investigation report', 'Draft'),
(7, 7, 7, '2023-04-10','Vandalism incident report', 'Finalized'),
(8, 8, 8, '2023-04-10','Kidnapping case report', 'Under Investigation'),
(9, 9, 9, '2023-04-10','Report on drug trafficking operation', 'Draft'),
(10, 10, 10, '2023-04-10','Final report on cybercrime investigation', 'Finalized');

INSERT INTO case1 (CaseId,CaseDescription,IncidentId)
VALUES
(1,'Initial incident report for robbery', 1),
(2,'Final report on the homicide investigation', 2),
(3,'Ongoing investigation on stolen vehicle', 3),
(4,'Assault case report', 4),
(5,'Report on the burglary incident', 5),
(6,'Fraud investigation report', 6),
(7,'Vandalism incident report', 7),
(8,'Kidnapping case report', 8),
(9,'Report on drug trafficking operation', 9),
(10,'Final report on cybercrime investigation', 10);



SELECT l.AgencyID, l.AgencyName, l.Jurisdiction ,l.ContactInformation , o.OfficerID,o.FirstName, o.LastName, o.BadgeNumber,o.Rank,o.ContactInformation FROM lawenforcementagencies l JOIN Officers o ON l.Officers = o.OfficerID WHERE o.OfficerId = 1;
select * from officers;
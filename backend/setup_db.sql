/* 
- This is an SQL script to setup and populate the database for our project.
- The first section is comprised of the DDL statements.
- The second section is comprised of the corresponding insert statements.
*/

CREATE DATABASE CPMS;
USE CPMS;

-- SECTION 1: SQL Data Definition Language (DDL)

-- VehicleClass Table (ISA Super Entity)
CREATE TABLE VehicleClass (
    PlateNumber VARCHAR(10) NOT NULL,
    WeightClass CHAR(1),
    PRIMARY KEY (PlateNumber)
);

/*
-- WeightRate Table
CREATE TABLE WeightRate (
    WeightClass CHAR(1),
    HourlyRate INT,
    PRIMARY KEY (WeightClass),
    FOREIGN KEY (WeightClass) REFERENCES VehicleClass(WeightClass)
); */

-- EntryGate Table (Entity)
CREATE TABLE EntryGate (
    EntryGateID INT NOT NULL,
    StatusIsActive INT,
    PRIMARY KEY (EntryGateID)
);

-- ExitGate Table (Entity)
CREATE TABLE ExitGate (
    ExitGateID INT NOT NULL,
    StatusIsActive INT,
    PRIMARY KEY (ExitGateID)
);

-- PrivateCar Table (ISA Sub Entity)
CREATE TABLE PrivateCar (
    PlateNumber VARCHAR(10) NOT NULL,
    Membership VARCHAR(12),
    PRIMARY KEY (PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);

-- HeavyDuty Table (ISA Sub Entity)
CREATE TABLE HeavyDuty (
    PlateNumber VARCHAR(10) NOT NULL,
    CompanyName VARCHAR(255),
    PRIMARY KEY (PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);

-- Maintenance Table (ISA Sub Entity)
CREATE TABLE Maintenance (
    PlateNumber VARCHAR(10) NOT NULL,
    WorkOrderID VARCHAR(12),
    PRIMARY KEY (PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);

-- Payment Table (Entity)
CREATE TABLE Payment (
    ID VARCHAR(10) NOT NULL,
    Method VARCHAR(255),
    PlateNumber VARCHAR(10),
    ExitGateID INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (ExitGateID) REFERENCES ExitGate(ExitGateID)
);

-- Enters Table (Relationship)
CREATE TABLE Enters (
    DateTime DATETIME,
    EntryGateID INT,
    PlateNumber VARCHAR(10),
    PRIMARY KEY (EntryGateID, PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (EntryGateID) REFERENCES EntryGate(EntryGateID)
);

-- Exits Table (Relationship)
CREATE TABLE Exits (
    DateTime DATETIME,
    ExitGateID INT,
    PlateNumber VARCHAR(10),
    PRIMARY KEY (ExitGateID, PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (ExitGateID) REFERENCES ExitGate(ExitGateID)
);

-- BranchClient Table
CREATE TABLE BranchClient (
    BranchID VARCHAR(12) NOT NULL,
    ClientName VARCHAR(255),
    ClientType CHAR(1),
    PRIMARY KEY (BranchID)
);

/*
-- BranchCap Table
CREATE TABLE BranchCap (
    ClientType CHAR(1),
    ParkingCap INT,
    PRIMARY KEY (ClientType),
    FOREIGN KEY (ClientType) REFERENCES BranchClient(ClientType)
); */

-- Staff Table (Entity)
CREATE TABLE Staff (
    EmployeeID INT NOT NULL,
    FullName VARCHAR(255),
    Telephone CHAR(10),
    email VARCHAR(255) UNIQUE,
    Shift VARCHAR(255),
    StartDate DATE,
    BranchID VARCHAR(12),
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID)
);

-- Tower Table (Entity)
CREATE TABLE Tower (
    Address VARCHAR(255) NOT NULL,
    Zip CHAR(6) NOT NULL,
    FilledSlots INT,
    RemainingSlots INT,
    BranchID VARCHAR(12),
    PRIMARY KEY (Address, Zip),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID)
);

-- ParkingZone, i.e. Zone Table (Entity)
CREATE TABLE ParkingZone (
    ParkingZoneID INT NOT NULL,
    ParkingZoneType INT NOT NULL,
    FilledSlots INT,
    RemainingSlots INT,
    Address VARCHAR(255),
    Zip CHAR(6),
    PRIMARY KEY (ParkingZoneID, ParkingZoneType),
    FOREIGN KEY (Address, Zip) REFERENCES Tower(Address, Zip)
);

-- TypeSlots Table (Not in ERD)
CREATE TABLE TypeSlots (
    ParkingZoneID INT,
    TotalSlots INT,
    PRIMARY KEY (ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID)
);

/* SHOULD BE PARKING SLOT COMPRISES */
-- ParkingSlot Table (Weak Entity Set)
CREATE TABLE ParkingSlot (
    ID VARCHAR(4),
    ParkingZoneID INT,
    PRIMARY KEY (ID, ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID)
);

-- Occupy Table (Relationship)
CREATE TABLE Occupy (
    ID VARCHAR(4),
    ParkingZoneID INT,
    PlateNumber VARCHAR(10),
    PRIMARY KEY (ID, ParkingZoneID, PlateNumber),
    FOREIGN KEY (ID) REFERENCES ParkingSlot(ID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);

/*
-- SECTION 2: INSERT STATEMENTS

-- VehicleClass Table
INSERT INTO VehicleClass VALUES ('PLATE1234', 'A');
INSERT INTO VehicleClass VALUES ('PLATE2345', 'B');
INSERT INTO VehicleClass VALUES ('PLATE3456', 'C');
INSERT INTO VehicleClass VALUES ('PLATE4567', 'D');
INSERT INTO VehicleClass VALUES ('PLATE5678', 'E');

-- WeightRate Table
INSERT INTO WeightRate VALUES ('A', 10);
INSERT INTO WeightRate VALUES ('B', 15);
INSERT INTO WeightRate VALUES ('C', 20);
INSERT INTO WeightRate VALUES ('D', 25);
INSERT INTO WeightRate VALUES ('E', 30); 

-- PrivateCar Table
INSERT INTO PrivateCar VALUES ('PLATE1234', 'MEM123');
INSERT INTO PrivateCar VALUES ('PLATE2345', 'MEM234');
INSERT INTO PrivateCar VALUES ('PLATE3456', 'MEM345');
INSERT INTO PrivateCar VALUES ('PLATE4567', 'MEM456');
INSERT INTO PrivateCar VALUES ('PLATE5678', 'MEM567');

-- HeavyDuty Table
INSERT INTO HeavyDuty VALUES ('PLATE6789', 'CompA');
INSERT INTO HeavyDuty VALUES ('PLATE7890', 'CompB');
INSERT INTO HeavyDuty VALUES ('PLATE8901', 'CompC');
INSERT INTO HeavyDuty VALUES ('PLATE9012', 'CompD');
INSERT INTO HeavyDuty VALUES ('PLATE0123', 'CompE');

-- Maintenance Table
INSERT INTO Maintenance VALUES ('PLATE1234', 'WO1234');
INSERT INTO Maintenance VALUES ('PLATE2345', 'WO2345');
INSERT INTO Maintenance VALUES ('PLATE3456', 'WO3456');
INSERT INTO Maintenance VALUES ('PLATE4567', 'WO4567');
INSERT INTO Maintenance VALUES ('PLATE5678', 'WO5678');

-- Payment Table
INSERT INTO Payment VALUES ('ID123', 'Cash', 'PLATE1234', 1);
INSERT INTO Payment VALUES ('ID234', 'Card', 'PLATE2345', 2);
INSERT INTO Payment VALUES ('ID345', 'Online', 'PLATE3456', 3);
INSERT INTO Payment VALUES ('ID456', 'Check', 'PLATE4567', 4);
INSERT INTO Payment VALUES ('ID567', 'Mobile', 'PLATE5678', 5);

-- Enters Table
INSERT INTO Enters VALUES ('2023-01-01 08:00:00', 'PLATE1234', 1);
INSERT INTO Enters VALUES ('2023-01-02 09:00:00', 'PLATE2345', 2);
INSERT INTO Enters VALUES ('2023-01-03 10:00:00', 'PLATE3456', 3);
INSERT INTO Enters VALUES ('2023-01-04 11:00:00', 'PLATE4567', 4);
INSERT INTO Enters VALUES ('2023-01-05 12:00:00', 'PLATE5678', 5);

-- Exits Table
INSERT INTO Exits VALUES ('2023-01-01 18:00:00', 'PLATE1234', 1);
INSERT INTO Exits VALUES ('2023-01-02 19:00:00', 'PLATE2345', 2);
INSERT INTO Exits VALUES ('2023-01-03 20:00:00', 'PLATE3456', 3);
INSERT INTO Exits VALUES ('2023-01-04 21:00:00', 'PLATE4567', 4);
INSERT INTO Exits VALUES ('2023-01-05 22:00:00', 'PLATE5678', 5);

-- EntryGate Table
INSERT INTO EntryGate VALUES (1, 1);
INSERT INTO EntryGate VALUES (2, 1);
INSERT INTO EntryGate VALUES (3, 1);
INSERT INTO EntryGate VALUES (4, 1);
INSERT INTO EntryGate VALUES (5, 1);

-- ExitGate Table
INSERT INTO ExitGate VALUES (1, 1);
INSERT INTO ExitGate VALUES (2, 1);
INSERT INTO ExitGate VALUES (3, 1);
INSERT INTO ExitGate VALUES (4, 1);
INSERT INTO ExitGate VALUES (5, 1);

-- ParkingZoneType Table
INSERT INTO ParkingZone VALUES (1, 1, 20, 30, 'Address1', 'Zip1');
INSERT INTO ParkingZone VALUES (2, 2, 25, 25, 'Address2', 'Zip2');
INSERT INTO ParkingZone VALUES (3, 3, 30, 20, 'Address3', 'Zip3');
INSERT INTO ParkingZone VALUES (4, 4, 4, 15, 35, 'Address4', 'Zip4');
INSERT INTO ParkingZone VALUES (5, 5, 10, 40, 'Address5', 'Zip5');

-- TypeSlots Table
INSERT INTO TypeSlots VALUES (1, 50);
INSERT INTO TypeSlots VALUES (2, 50);
INSERT INTO TypeSlots VALUES (3, 50);
INSERT INTO TypeSlots VALUES (4, 50);
INSERT INTO TypeSlots VALUES (5, 50);

-- ParkingSlot Table
INSERT INTO ParkingSlot VALUES ('SLOT1', 1);
INSERT INTO ParkingSlot VALUES ('SLOT2', 2);
INSERT INTO ParkingSlot VALUES ('SLOT3', 3);
INSERT INTO ParkingSlot VALUES ('SLOT4', 4);
INSERT INTO ParkingSlot VALUES ('SLOT5', 5);

-- Occupy Table
INSERT INTO Occupy VALUES ('SLOT1', 1, 'PLATE1234');
INSERT INTO Occupy VALUES ('SLOT2', 2, 'PLATE2345');
INSERT INTO Occupy VALUES ('SLOT3', 3, 'PLATE3456');
INSERT INTO Occupy VALUES ('SLOT4', 4, 'PLATE4567');
INSERT INTO Occupy VALUES ('SLOT5', 5, 'PLATE5678');

-- BranchClient Table
INSERT INTO BranchClient VALUES ('BR001', 'Client1', 'A');
INSERT INTO BranchClient VALUES ('BR002', 'Client2', 'B');
INSERT INTO BranchClient VALUES ('BR003', 'Client3', 'C');
INSERT INTO BranchClient VALUES ('BR004', 'Client4', 'D');
INSERT INTO BranchClient VALUES ('BR005', 'Client5', 'E');

-- BranchCap
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('A', 100);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('B', 200);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('C', 300);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('D', 400);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('E', 500);

-- Tower Table
INSERT INTO Tower VALUES ('123 Main St', 'A1B2C3', 20, 30, 'BR001');
INSERT INTO Tower VALUES ('456 Oak Rd', 'D4E5F6', 25, 25, 'BR002');
INSERT INTO Tower VALUES ('789 Pine Ave', 'G7H8I9', 30, 20, 'BR003');
INSERT INTO Tower VALUES ('101 River Ln', 'J1K2L3', 15, 35, 'BR004');
INSERT INTO Tower VALUES ('202 Lake St', 'M4N5O6', 10, 40, 'BR005');

-- Staff Table
INSERT INTO Staff VALUES (1, 'John Doe', 1234567890, 'jdoe@example.com', 'Morning',
'2023-01-01', 'BR001');
INSERT INTO Staff VALUES (2, 'Jane Smith', 2345678901, 'jsmith@example.com', 'Evening',
'2023-02-01', 'BR002');
INSERT INTO Staff VALUES (3, 'Mike Brown', 3456789012, 'mbrown@example.com', 'Night',
'2023-03-01', 'BR003');
INSERT INTO Staff VALUES (4, 'Sara White', 4567890123, 'swhite@example.com', 'Morning',
'2023-04-01', 'BR004');
INSERT INTO Staff VALUES (5, 'Alex Green', 5678901234, 'agreen@example.com', 'Evening',
'2023-05-01', 'BR005'); */
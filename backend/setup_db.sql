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
-- TODO: WeightRate Table (BCNF Product)
CREATE TABLE WeightRate (
    WeightClass CHAR(1),
    HourlyRate INT,
    PRIMARY KEY (WeightClass),
    FOREIGN KEY (WeightClass) REFERENCES VehicleClass(WeightClass)
); */

-- EntryGate Table (Entity)
CREATE TABLE EntryGate (
    EntryGateID INT NOT NULL,
    StatusIsActive BOOLEAN,
    PRIMARY KEY (EntryGateID)
);

-- ExitGate Table (Entity)
CREATE TABLE ExitGate (
    ExitGateID INT NOT NULL,
    StatusIsActive BOOLEAN,
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
/* In the original ERD Diagram there is ParkingCap but we removed it */
CREATE TABLE BranchClient (
    BranchID VARCHAR(12) NOT NULL,
    ClientName VARCHAR(255),
    ClientType CHAR(1),
    PRIMARY KEY (BranchID)
);

/*
-- TODO: BranchCap Table
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
    TowerTotalSlots INT,
    -- RemainingSlots INT, , This should be a view instead
    BranchID VARCHAR(12),
    PRIMARY KEY (Address, Zip),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID)
);

-- ParkingZone, i.e. Zone Table (Entity)
-- Note: Type 1 is Private, Type 2 is Heavy, Type 3 is Maintenance, Type 4 is Mixed
CREATE TABLE ParkingZone (
    ParkingZoneID INT NOT NULL,
    ParkingZoneType INT NOT NULL,
    -- FilledSlots INT, This should be a view instead
    ZoneTotalSlots INT,
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
-- TODO: ParkingSlot Table (Weak Entity Set)
CREATE TABLE ParkingSlot (
    ID VARCHAR(8),
    ParkingZoneID INT,
    PRIMARY KEY (ID, ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID)
);

-- Occupy Table (Relationship)
CREATE TABLE Occupy (
    ID VARCHAR(8),
    ParkingZoneID INT,
    PlateNumber VARCHAR(10),
    PRIMARY KEY (ID, ParkingZoneID, PlateNumber),
    FOREIGN KEY (ID) REFERENCES ParkingSlot(ID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);


-- SECTION 2: INSERT STATEMENTS

-- VehicleClass Table 
-- A is for Private, B is for Heavy, C is for Maintenance
INSERT INTO VehicleClass VALUES ('PLATE1234', 'A');
INSERT INTO VehicleClass VALUES ('PLATE2345', 'A');
INSERT INTO VehicleClass VALUES ('PLATE3456', 'A');
INSERT INTO VehicleClass VALUES ('PLATE4567', 'A');
INSERT INTO VehicleClass VALUES ('PLATE5678', 'A');
INSERT INTO VehicleClass VALUES ('PLATE6789', 'B');
INSERT INTO VehicleClass VALUES ('PLATE7890', 'B');
INSERT INTO VehicleClass VALUES ('PLATE8901', 'B');
INSERT INTO VehicleClass VALUES ('PLATE9012', 'B');
INSERT INTO VehicleClass VALUES ('PLATE0123', 'B');
INSERT INTO VehicleClass VALUES ('PLATE0500', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0600', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0700', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0800', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0900', 'C');

/*
-- TODO: WeightRate Table
INSERT INTO WeightRate VALUES ('A', 10);
INSERT INTO WeightRate VALUES ('B', 15);
INSERT INTO WeightRate VALUES ('C', 20);
INSERT INTO WeightRate VALUES ('D', 25);
INSERT INTO WeightRate VALUES ('E', 30); 
*/


-- PrivateCar Table
INSERT INTO PrivateCar VALUES ('PLATE1234', 'p6725f');
INSERT INTO PrivateCar VALUES ('PLATE2345', 't9123a');
INSERT INTO PrivateCar VALUES ('PLATE3456', 'r1231b');
INSERT INTO PrivateCar VALUES ('PLATE4567', 'm1023i');
INSERT INTO PrivateCar VALUES ('PLATE5678', 'q1029y');

-- HeavyDuty Table
INSERT INTO HeavyDuty VALUES ('PLATE6789', 'Maersk Cargo');
INSERT INTO HeavyDuty VALUES ('PLATE7890', 'Yang Ming');
INSERT INTO HeavyDuty VALUES ('PLATE8901', 'Atlantic Snow');
INSERT INTO HeavyDuty VALUES ('PLATE9012', 'Pacific Beast');
INSERT INTO HeavyDuty VALUES ('PLATE0123', 'Vladivostok Blue');


-- Maintenance Table
INSERT INTO Maintenance VALUES ('PLATE0500', 'WO1234');
INSERT INTO Maintenance VALUES ('PLATE0600', 'WO2345');
INSERT INTO Maintenance VALUES ('PLATE0700', 'WO3456');
INSERT INTO Maintenance VALUES ('PLATE0800', 'WO4567');
INSERT INTO Maintenance VALUES ('PLATE0900', 'WO5678');

-- EntryGate Table
INSERT INTO EntryGate VALUES (1, TRUE);
INSERT INTO EntryGate VALUES (2, TRUE);
INSERT INTO EntryGate VALUES (3, TRUE);
INSERT INTO EntryGate VALUES (4, TRUE);
INSERT INTO EntryGate VALUES (5, TRUE);

-- ExitGate Table
INSERT INTO ExitGate VALUES (1, TRUE);
INSERT INTO ExitGate VALUES (2, TRUE);
INSERT INTO ExitGate VALUES (3, TRUE);
INSERT INTO ExitGate VALUES (4, TRUE);
INSERT INTO ExitGate VALUES (5, TRUE);

-- Payment Table
INSERT INTO Payment VALUES ('PID123', 'Cash', 'PLATE1234', 1);
INSERT INTO Payment VALUES ('PID234', 'Card', 'PLATE2345', 2);
INSERT INTO Payment VALUES ('PID345', 'Online', 'PLATE3456', 3);
INSERT INTO Payment VALUES ('PID456', 'Check', 'PLATE4567', 4);
INSERT INTO Payment VALUES ('PID567', 'Mobile', 'PLATE5678', 5);

-- Enters Table
INSERT INTO Enters VALUES ('2023-01-01 08:00:00', 1, 'PLATE1234');
INSERT INTO Enters VALUES ('2023-01-02 09:00:00', 1, 'PLATE2345');
INSERT INTO Enters VALUES ('2023-01-03 10:00:00', 2, 'PLATE3456');
INSERT INTO Enters VALUES ('2023-01-04 11:00:00', 2, 'PLATE4567');
INSERT INTO Enters VALUES ('2023-01-05 12:00:00', 3, 'PLATE5678');
INSERT INTO Enters VALUES ('2023-01-01 12:30:10', 3, 'PLATE6789');
INSERT INTO Enters VALUES ('2023-01-02 11:00:00', 4, 'PLATE7890');
INSERT INTO Enters VALUES ('2023-01-03 15:16:00', 4, 'PLATE8901');
INSERT INTO Enters VALUES ('2023-01-04 09:00:00', 5, 'PLATE9012');
INSERT INTO Enters VALUES ('2023-01-05 07:37:00', 5, 'PLATE0123');
INSERT INTO Enters VALUES ('2023-01-01 08:30:00', 1, 'PLATE0500');
INSERT INTO Enters VALUES ('2023-01-02 09:41:00', 2, 'PLATE0600');
INSERT INTO Enters VALUES ('2023-01-03 10:01:59', 3, 'PLATE0700');
INSERT INTO Enters VALUES ('2023-01-04 11:00:13', 4, 'PLATE0800');
INSERT INTO Enters VALUES ('2023-01-05 12:15:00', 5, 'PLATE0900');

-- Exits Table
INSERT INTO Exits VALUES ('2023-01-01 18:00:00', 1, 'PLATE1234');
INSERT INTO Exits VALUES ('2023-01-02 19:00:00', 2, 'PLATE2345');
INSERT INTO Exits VALUES ('2023-01-03 20:00:00', 3, 'PLATE3456');
INSERT INTO Exits VALUES ('2023-01-04 21:00:00', 4, 'PLATE4567');
INSERT INTO Exits VALUES ('2023-01-05 22:00:00', 5, 'PLATE5678');

-- BranchClient Table
INSERT INTO BranchClient VALUES ('BR001', 'Client1', 'A');
INSERT INTO BranchClient VALUES ('BR002', 'Client2', 'B');
INSERT INTO BranchClient VALUES ('BR003', 'Client3', 'C');
INSERT INTO BranchClient VALUES ('BR004', 'Client4', 'D');
INSERT INTO BranchClient VALUES ('BR005', 'Client5', 'E');

-- Tower Table
INSERT INTO Tower VALUES ('123 Main St', 'A1B2C3', 61, 'BR001');
INSERT INTO Tower VALUES ('456 Oak Rd', 'D4E5F6', 66, 'BR002');
INSERT INTO Tower VALUES ('456 Oak Rd', 'G7H8I9', 38, 'BR003');
INSERT INTO Tower VALUES ('101 River Ln', 'J1K2L3', 55, 'BR004');
INSERT INTO Tower VALUES ('202 Lake St', 'M4N5O6', 48, 'BR005');

-- ParkingZoneType Table
INSERT INTO ParkingZone VALUES (15, 1, 30, '123 Main St', 'A1B2C3');
INSERT INTO ParkingZone VALUES (58, 4, 31, '123 Main St', 'A1B2C3');
INSERT INTO ParkingZone VALUES (27, 1, 25, '456 Oak Rd', 'D4E5F6');
INSERT INTO ParkingZone VALUES (51, 4, 41, '456 Oak Rd', 'D4E5F6');
INSERT INTO ParkingZone VALUES (32, 2, 21, '456 Oak Rd', 'G7H8I9');
INSERT INTO ParkingZone VALUES (43, 3, 17, '456 Oak Rd', 'G7H8I9');
INSERT INTO ParkingZone VALUES (18, 1, 32, '101 River Ln', 'J1K2L3');
INSERT INTO ParkingZone VALUES (29, 1, 23, '101 River Ln', 'J1K2L3');
INSERT INTO ParkingZone VALUES (25, 2, 21, '202 Lake St', 'M4N5O6');
INSERT INTO ParkingZone VALUES (45, 3, 27, '202 Lake St', 'M4N5O6');

/*
-- TODO: TypeSlots Table THIS DOESNT MAKE SENSE
INSERT INTO TypeSlots VALUES (15, 50);
INSERT INTO TypeSlots VALUES (58, 50);
INSERT INTO TypeSlots VALUES (27, 50);
INSERT INTO TypeSlots VALUES (51, 50);
INSERT INTO TypeSlots VALUES (32, 50);
*/

-- ParkingSlot Table
/* TODO: There are tens of slots, we should make more insertions */
INSERT INTO ParkingSlot VALUES ('SLOT1', 15);
INSERT INTO ParkingSlot VALUES ('SLOT2', 15);
INSERT INTO ParkingSlot VALUES ('SLOT3', 15);
INSERT INTO ParkingSlot VALUES ('SLOT4', 15);
INSERT INTO ParkingSlot VALUES ('SLOT5', 15);
INSERT INTO ParkingSlot VALUES ('SLOT6', 15);
INSERT INTO ParkingSlot VALUES ('SLOT7', 15);
INSERT INTO ParkingSlot VALUES ('SLOT8', 15);
INSERT INTO ParkingSlot VALUES ('SLOT9', 15);
INSERT INTO ParkingSlot VALUES ('SLOT10', 15);
INSERT INTO ParkingSlot VALUES ('SLOT11', 15);
INSERT INTO ParkingSlot VALUES ('SLOT12', 15);
INSERT INTO ParkingSlot VALUES ('SLOT13', 15);
INSERT INTO ParkingSlot VALUES ('SLOT14', 15);
INSERT INTO ParkingSlot VALUES ('SLOT15', 15);
INSERT INTO ParkingSlot VALUES ('SLOT16', 15);
INSERT INTO ParkingSlot VALUES ('SLOT17', 15);
INSERT INTO ParkingSlot VALUES ('SLOT18', 15);
INSERT INTO ParkingSlot VALUES ('SLOT19', 15);
INSERT INTO ParkingSlot VALUES ('SLOT20', 15);
INSERT INTO ParkingSlot VALUES ('SLOT21', 15);
INSERT INTO ParkingSlot VALUES ('SLOT22', 15);
INSERT INTO ParkingSlot VALUES ('SLOT23', 15);
INSERT INTO ParkingSlot VALUES ('SLOT24', 15);
INSERT INTO ParkingSlot VALUES ('SLOT25', 15);
INSERT INTO ParkingSlot VALUES ('SLOT26', 15);
INSERT INTO ParkingSlot VALUES ('SLOT27', 15);
INSERT INTO ParkingSlot VALUES ('SLOT28', 15);
INSERT INTO ParkingSlot VALUES ('SLOT29', 15);
INSERT INTO ParkingSlot VALUES ('SLOT30', 15);

INSERT INTO ParkingSlot VALUES ('SLOT1', 58);
INSERT INTO ParkingSlot VALUES ('SLOT2', 58);
INSERT INTO ParkingSlot VALUES ('SLOT3', 58);
INSERT INTO ParkingSlot VALUES ('SLOT4', 58);
INSERT INTO ParkingSlot VALUES ('SLOT5', 58);
INSERT INTO ParkingSlot VALUES ('SLOT6', 58);
INSERT INTO ParkingSlot VALUES ('SLOT7', 58);
INSERT INTO ParkingSlot VALUES ('SLOT8', 58);
INSERT INTO ParkingSlot VALUES ('SLOT9', 58);
INSERT INTO ParkingSlot VALUES ('SLOT10', 58);
INSERT INTO ParkingSlot VALUES ('SLOT11', 58);
INSERT INTO ParkingSlot VALUES ('SLOT12', 58);
INSERT INTO ParkingSlot VALUES ('SLOT13', 58);
INSERT INTO ParkingSlot VALUES ('SLOT14', 58);
INSERT INTO ParkingSlot VALUES ('SLOT15', 58);
INSERT INTO ParkingSlot VALUES ('SLOT16', 58);
INSERT INTO ParkingSlot VALUES ('SLOT17', 58);
INSERT INTO ParkingSlot VALUES ('SLOT18', 58);
INSERT INTO ParkingSlot VALUES ('SLOT19', 58);
INSERT INTO ParkingSlot VALUES ('SLOT20', 58);
INSERT INTO ParkingSlot VALUES ('SLOT21', 58);
INSERT INTO ParkingSlot VALUES ('SLOT22', 58);
INSERT INTO ParkingSlot VALUES ('SLOT23', 58);
INSERT INTO ParkingSlot VALUES ('SLOT24', 58);
INSERT INTO ParkingSlot VALUES ('SLOT25', 58);
INSERT INTO ParkingSlot VALUES ('SLOT26', 58);
INSERT INTO ParkingSlot VALUES ('SLOT27', 58);
INSERT INTO ParkingSlot VALUES ('SLOT28', 58);
INSERT INTO ParkingSlot VALUES ('SLOT29', 58);
INSERT INTO ParkingSlot VALUES ('SLOT30', 58);
INSERT INTO ParkingSlot VALUES ('SLOT31', 58);

INSERT INTO ParkingSlot VALUES ('SLOT1', 27);
INSERT INTO ParkingSlot VALUES ('SLOT2', 27);
INSERT INTO ParkingSlot VALUES ('SLOT3', 27);
INSERT INTO ParkingSlot VALUES ('SLOT4', 27);
INSERT INTO ParkingSlot VALUES ('SLOT5', 27);
INSERT INTO ParkingSlot VALUES ('SLOT6', 27);
INSERT INTO ParkingSlot VALUES ('SLOT7', 27);
INSERT INTO ParkingSlot VALUES ('SLOT8', 27);
INSERT INTO ParkingSlot VALUES ('SLOT9', 27);
INSERT INTO ParkingSlot VALUES ('SLOT10', 27);
INSERT INTO ParkingSlot VALUES ('SLOT11', 27);
INSERT INTO ParkingSlot VALUES ('SLOT12', 27);
INSERT INTO ParkingSlot VALUES ('SLOT13', 27);
INSERT INTO ParkingSlot VALUES ('SLOT14', 27);
INSERT INTO ParkingSlot VALUES ('SLOT15', 27);
INSERT INTO ParkingSlot VALUES ('SLOT16', 27);
INSERT INTO ParkingSlot VALUES ('SLOT17', 27);
INSERT INTO ParkingSlot VALUES ('SLOT18', 27);
INSERT INTO ParkingSlot VALUES ('SLOT19', 27);
INSERT INTO ParkingSlot VALUES ('SLOT20', 27);
INSERT INTO ParkingSlot VALUES ('SLOT21', 27);
INSERT INTO ParkingSlot VALUES ('SLOT22', 27);
INSERT INTO ParkingSlot VALUES ('SLOT23', 27);
INSERT INTO ParkingSlot VALUES ('SLOT24', 27);
INSERT INTO ParkingSlot VALUES ('SLOT25', 27);


INSERT INTO ParkingSlot VALUES ('SLOT1', 51);
INSERT INTO ParkingSlot VALUES ('SLOT2', 51);
INSERT INTO ParkingSlot VALUES ('SLOT3', 51);
INSERT INTO ParkingSlot VALUES ('SLOT4', 51);
INSERT INTO ParkingSlot VALUES ('SLOT5', 51);
INSERT INTO ParkingSlot VALUES ('SLOT6', 51);
INSERT INTO ParkingSlot VALUES ('SLOT7', 51);
INSERT INTO ParkingSlot VALUES ('SLOT8', 51);
INSERT INTO ParkingSlot VALUES ('SLOT9', 51);
INSERT INTO ParkingSlot VALUES ('SLOT10', 51);
INSERT INTO ParkingSlot VALUES ('SLOT11', 51);
INSERT INTO ParkingSlot VALUES ('SLOT12', 51);
INSERT INTO ParkingSlot VALUES ('SLOT13', 51);
INSERT INTO ParkingSlot VALUES ('SLOT14', 51);
INSERT INTO ParkingSlot VALUES ('SLOT15', 51);
INSERT INTO ParkingSlot VALUES ('SLOT16', 51);
INSERT INTO ParkingSlot VALUES ('SLOT17', 51);
INSERT INTO ParkingSlot VALUES ('SLOT18', 51);
INSERT INTO ParkingSlot VALUES ('SLOT19', 51);
INSERT INTO ParkingSlot VALUES ('SLOT20', 51);
INSERT INTO ParkingSlot VALUES ('SLOT21', 51);
INSERT INTO ParkingSlot VALUES ('SLOT22', 51);
INSERT INTO ParkingSlot VALUES ('SLOT23', 51);
INSERT INTO ParkingSlot VALUES ('SLOT24', 51);
INSERT INTO ParkingSlot VALUES ('SLOT25', 51);
INSERT INTO ParkingSlot VALUES ('SLOT26', 51);
INSERT INTO ParkingSlot VALUES ('SLOT27', 51);
INSERT INTO ParkingSlot VALUES ('SLOT28', 51);
INSERT INTO ParkingSlot VALUES ('SLOT29', 51);
INSERT INTO ParkingSlot VALUES ('SLOT30', 51);
INSERT INTO ParkingSlot VALUES ('SLOT31', 51);
INSERT INTO ParkingSlot VALUES ('SLOT32', 51);
INSERT INTO ParkingSlot VALUES ('SLOT33', 51);
INSERT INTO ParkingSlot VALUES ('SLOT34', 51);
INSERT INTO ParkingSlot VALUES ('SLOT35', 51);
INSERT INTO ParkingSlot VALUES ('SLOT36', 51);
INSERT INTO ParkingSlot VALUES ('SLOT37', 51);
INSERT INTO ParkingSlot VALUES ('SLOT38', 51);
INSERT INTO ParkingSlot VALUES ('SLOT39', 51);
INSERT INTO ParkingSlot VALUES ('SLOT40', 51);
INSERT INTO ParkingSlot VALUES ('SLOT41', 51);

INSERT INTO ParkingSlot VALUES ('SLOT1', 32);
INSERT INTO ParkingSlot VALUES ('SLOT2', 32);
INSERT INTO ParkingSlot VALUES ('SLOT3', 32);
INSERT INTO ParkingSlot VALUES ('SLOT4', 32);
INSERT INTO ParkingSlot VALUES ('SLOT5', 32);
INSERT INTO ParkingSlot VALUES ('SLOT6', 32);
INSERT INTO ParkingSlot VALUES ('SLOT7', 32);
INSERT INTO ParkingSlot VALUES ('SLOT8', 32);
INSERT INTO ParkingSlot VALUES ('SLOT9', 32);
INSERT INTO ParkingSlot VALUES ('SLOT10', 32);
INSERT INTO ParkingSlot VALUES ('SLOT11', 32);
INSERT INTO ParkingSlot VALUES ('SLOT12', 32);
INSERT INTO ParkingSlot VALUES ('SLOT13', 32);
INSERT INTO ParkingSlot VALUES ('SLOT14', 32);
INSERT INTO ParkingSlot VALUES ('SLOT15', 32);
INSERT INTO ParkingSlot VALUES ('SLOT16', 32);
INSERT INTO ParkingSlot VALUES ('SLOT17', 32);
INSERT INTO ParkingSlot VALUES ('SLOT18', 32);
INSERT INTO ParkingSlot VALUES ('SLOT19', 32);
INSERT INTO ParkingSlot VALUES ('SLOT20', 32);
INSERT INTO ParkingSlot VALUES ('SLOT21', 32);

INSERT INTO ParkingSlot VALUES ('SLOT1', 43);
INSERT INTO ParkingSlot VALUES ('SLOT2', 43);
INSERT INTO ParkingSlot VALUES ('SLOT3', 43);
INSERT INTO ParkingSlot VALUES ('SLOT4', 43);
INSERT INTO ParkingSlot VALUES ('SLOT5', 43);
INSERT INTO ParkingSlot VALUES ('SLOT6', 43);
INSERT INTO ParkingSlot VALUES ('SLOT7', 43);
INSERT INTO ParkingSlot VALUES ('SLOT8', 43);
INSERT INTO ParkingSlot VALUES ('SLOT9', 43);
INSERT INTO ParkingSlot VALUES ('SLOT10', 43);
INSERT INTO ParkingSlot VALUES ('SLOT11', 43);
INSERT INTO ParkingSlot VALUES ('SLOT12', 43);
INSERT INTO ParkingSlot VALUES ('SLOT13', 43);
INSERT INTO ParkingSlot VALUES ('SLOT14', 43);
INSERT INTO ParkingSlot VALUES ('SLOT15', 43);
INSERT INTO ParkingSlot VALUES ('SLOT16', 43);
INSERT INTO ParkingSlot VALUES ('SLOT17', 43);

INSERT INTO ParkingSlot VALUES ('SLOT1', 18);
INSERT INTO ParkingSlot VALUES ('SLOT2', 18);
INSERT INTO ParkingSlot VALUES ('SLOT3', 18);
INSERT INTO ParkingSlot VALUES ('SLOT4', 18);
INSERT INTO ParkingSlot VALUES ('SLOT5', 18);
INSERT INTO ParkingSlot VALUES ('SLOT6', 18);
INSERT INTO ParkingSlot VALUES ('SLOT7', 18);
INSERT INTO ParkingSlot VALUES ('SLOT8', 18);
INSERT INTO ParkingSlot VALUES ('SLOT9', 18);
INSERT INTO ParkingSlot VALUES ('SLOT10', 18);
INSERT INTO ParkingSlot VALUES ('SLOT11', 18);
INSERT INTO ParkingSlot VALUES ('SLOT12', 18);
INSERT INTO ParkingSlot VALUES ('SLOT13', 18);
INSERT INTO ParkingSlot VALUES ('SLOT14', 18);
INSERT INTO ParkingSlot VALUES ('SLOT15', 18);
INSERT INTO ParkingSlot VALUES ('SLOT16', 18);
INSERT INTO ParkingSlot VALUES ('SLOT17', 18);
INSERT INTO ParkingSlot VALUES ('SLOT18', 18);
INSERT INTO ParkingSlot VALUES ('SLOT19', 18);
INSERT INTO ParkingSlot VALUES ('SLOT20', 18);
INSERT INTO ParkingSlot VALUES ('SLOT21', 18);
INSERT INTO ParkingSlot VALUES ('SLOT22', 18);
INSERT INTO ParkingSlot VALUES ('SLOT23', 18);
INSERT INTO ParkingSlot VALUES ('SLOT24', 18);
INSERT INTO ParkingSlot VALUES ('SLOT25', 18);
INSERT INTO ParkingSlot VALUES ('SLOT26', 18);
INSERT INTO ParkingSlot VALUES ('SLOT27', 18);
INSERT INTO ParkingSlot VALUES ('SLOT28', 18);
INSERT INTO ParkingSlot VALUES ('SLOT29', 18);
INSERT INTO ParkingSlot VALUES ('SLOT30', 18);
INSERT INTO ParkingSlot VALUES ('SLOT31', 18);
INSERT INTO ParkingSlot VALUES ('SLOT32', 18);

INSERT INTO ParkingSlot VALUES ('SLOT1', 29);
INSERT INTO ParkingSlot VALUES ('SLOT2', 29);
INSERT INTO ParkingSlot VALUES ('SLOT3', 29);
INSERT INTO ParkingSlot VALUES ('SLOT4', 29);
INSERT INTO ParkingSlot VALUES ('SLOT5', 29);
INSERT INTO ParkingSlot VALUES ('SLOT6', 29);
INSERT INTO ParkingSlot VALUES ('SLOT7', 29);
INSERT INTO ParkingSlot VALUES ('SLOT8', 29);
INSERT INTO ParkingSlot VALUES ('SLOT9', 29);
INSERT INTO ParkingSlot VALUES ('SLOT10', 29);
INSERT INTO ParkingSlot VALUES ('SLOT11', 29);
INSERT INTO ParkingSlot VALUES ('SLOT12', 29);
INSERT INTO ParkingSlot VALUES ('SLOT13', 29);
INSERT INTO ParkingSlot VALUES ('SLOT14', 29);
INSERT INTO ParkingSlot VALUES ('SLOT15', 29);
INSERT INTO ParkingSlot VALUES ('SLOT16', 29);
INSERT INTO ParkingSlot VALUES ('SLOT17', 29);
INSERT INTO ParkingSlot VALUES ('SLOT18', 29);
INSERT INTO ParkingSlot VALUES ('SLOT19', 29);
INSERT INTO ParkingSlot VALUES ('SLOT20', 29);
INSERT INTO ParkingSlot VALUES ('SLOT21', 29);
INSERT INTO ParkingSlot VALUES ('SLOT22', 29);
INSERT INTO ParkingSlot VALUES ('SLOT23', 29);

INSERT INTO ParkingSlot VALUES ('SLOT1', 25);
INSERT INTO ParkingSlot VALUES ('SLOT2', 25);
INSERT INTO ParkingSlot VALUES ('SLOT3', 25);
INSERT INTO ParkingSlot VALUES ('SLOT4', 25);
INSERT INTO ParkingSlot VALUES ('SLOT5', 25);
INSERT INTO ParkingSlot VALUES ('SLOT6', 25);
INSERT INTO ParkingSlot VALUES ('SLOT7', 25);
INSERT INTO ParkingSlot VALUES ('SLOT8', 25);
INSERT INTO ParkingSlot VALUES ('SLOT9', 25);
INSERT INTO ParkingSlot VALUES ('SLOT10', 25);
INSERT INTO ParkingSlot VALUES ('SLOT11', 25);
INSERT INTO ParkingSlot VALUES ('SLOT12', 25);
INSERT INTO ParkingSlot VALUES ('SLOT13', 25);
INSERT INTO ParkingSlot VALUES ('SLOT14', 25);
INSERT INTO ParkingSlot VALUES ('SLOT15', 25);
INSERT INTO ParkingSlot VALUES ('SLOT16', 25);
INSERT INTO ParkingSlot VALUES ('SLOT17', 25);
INSERT INTO ParkingSlot VALUES ('SLOT18', 25);
INSERT INTO ParkingSlot VALUES ('SLOT19', 25);
INSERT INTO ParkingSlot VALUES ('SLOT20', 25);
INSERT INTO ParkingSlot VALUES ('SLOT21', 25);

INSERT INTO ParkingSlot VALUES ('SLOT1', 45);
INSERT INTO ParkingSlot VALUES ('SLOT2', 45);
INSERT INTO ParkingSlot VALUES ('SLOT3', 45);
INSERT INTO ParkingSlot VALUES ('SLOT4', 45);
INSERT INTO ParkingSlot VALUES ('SLOT5', 45);
INSERT INTO ParkingSlot VALUES ('SLOT6', 45);
INSERT INTO ParkingSlot VALUES ('SLOT7', 45);
INSERT INTO ParkingSlot VALUES ('SLOT8', 45);
INSERT INTO ParkingSlot VALUES ('SLOT9', 45);
INSERT INTO ParkingSlot VALUES ('SLOT10', 45);
INSERT INTO ParkingSlot VALUES ('SLOT11', 45);
INSERT INTO ParkingSlot VALUES ('SLOT12', 45);
INSERT INTO ParkingSlot VALUES ('SLOT13', 45);
INSERT INTO ParkingSlot VALUES ('SLOT14', 45);
INSERT INTO ParkingSlot VALUES ('SLOT15', 45);
INSERT INTO ParkingSlot VALUES ('SLOT16', 45);
INSERT INTO ParkingSlot VALUES ('SLOT17', 45);
INSERT INTO ParkingSlot VALUES ('SLOT18', 45);
INSERT INTO ParkingSlot VALUES ('SLOT19', 45);
INSERT INTO ParkingSlot VALUES ('SLOT20', 45);
INSERT INTO ParkingSlot VALUES ('SLOT21', 45);
INSERT INTO ParkingSlot VALUES ('SLOT22', 45);
INSERT INTO ParkingSlot VALUES ('SLOT23', 45);
INSERT INTO ParkingSlot VALUES ('SLOT24', 45);
INSERT INTO ParkingSlot VALUES ('SLOT25', 45);
INSERT INTO ParkingSlot VALUES ('SLOT26', 45);
INSERT INTO ParkingSlot VALUES ('SLOT27', 45);


-- Occupy Table
INSERT INTO Occupy VALUES ('SLOT1', 15, 'PLATE6789');
INSERT INTO Occupy VALUES ('SLOT2', 58, 'PLATE7890');
INSERT INTO Occupy VALUES ('SLOT3', 27, 'PLATE8901');
INSERT INTO Occupy VALUES ('SLOT4', 51, 'PLATE9012');
INSERT INTO Occupy VALUES ('SLOT5', 32, 'PLATE0123');
INSERT INTO Occupy VALUES ('SLOT6', 43, 'PLATE0500');
INSERT INTO Occupy VALUES ('SLOT7', 18, 'PLATE0600');
INSERT INTO Occupy VALUES ('SLOT8', 29, 'PLATE0700');
INSERT INTO Occupy VALUES ('SLOT9', 27, 'PLATE0800');
INSERT INTO Occupy VALUES ('SLOT10', 45, 'PLATE0900');

/*
-- TODO: BranchCap
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('A', 100);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('B', 200);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('C', 300);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('D', 400);
INSERT INTO BranchCap (ClientType, ParkingCap) VALUES ('E', 500);
*/

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
'2023-05-01', 'BR005');
/* 
- This is an SQL script to setup and populate the database for our project.
- The first section is comprised of the DDL statements.
- The second section is comprised of the corresponding insert statements.
*/

CREATE DATABASE cpms_db;
USE cpms_db;

DROP TABLE IF EXISTS Occupy;
DROP TABLE IF EXISTS Exits;
DROP TABLE IF EXISTS ParkingSlot;
DROP TABLE IF EXISTS TypeSlots;
DROP TABLE IF EXISTS ParkingZone;
DROP TABLE IF EXISTS Tower;
DROP TABLE IF EXISTS Staff;
/* DROP TABLE IF EXISTS BranchCap; */
DROP TABLE IF EXISTS BranchClient;
DROP TABLE IF EXISTS Enters;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS HeavyDuty;
DROP TABLE IF EXISTS PrivateCar;
DROP TABLE IF EXISTS ExitGate;
DROP TABLE IF EXISTS EntryGate;
DROP TABLE IF EXISTS WeightRate;
DROP TABLE IF EXISTS VehicleClass;

-- SECTION 1: SQL Data Definition Language (DDL)

-- VehicleClass Table (ISA Super Entity)
CREATE TABLE VehicleClass (
    PlateNumber VARCHAR(10) NOT NULL,
    WeightClass CHAR(1),
    PRIMARY KEY (PlateNumber)
);

-- WeightRate Table (BCNF Product)
CREATE TABLE WeightRate (
    WeightClass CHAR(1),
    HourlyRate INT,
    PRIMARY KEY (WeightClass)
);

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
    WorkOrderID VARCHAR(12) NOT NULL, -- There must be a valid work order
    PRIMARY KEY (PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);

-- Payment Table (Entity)
-- Added Payment amount
-- Newly added assertion, makes sure that the payment amounts are zero or positive
CREATE TABLE Payment (
    PaymentID VARCHAR(255) NOT NULL,
    Method VARCHAR(255),
    Amount FLOAT,
    PlateNumber VARCHAR(10),
    ExitGateID INT,
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (ExitGateID) REFERENCES ExitGate(ExitGateID),
    CONSTRAINT PositiveAmount CHECK (Amount >= 0)
);

-- Enters Table (Relationship)
-- Removed GateID as primary key, replaced it with time instead
CREATE TABLE Enters (
    DateTime DATETIME,
    EntryGateID INT,
    PlateNumber VARCHAR(10),
    PRIMARY KEY (DateTime, PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (EntryGateID) REFERENCES EntryGate(EntryGateID) ON DELETE CASCADE
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
    Email VARCHAR(255) UNIQUE,
    Shift VARCHAR(255),
    StartDate DATE,
    BranchID VARCHAR(12),
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID) ON DELETE CASCADE
);

-- Tower Table (Entity)
/* Added new TowerID */
CREATE TABLE Tower (
    TowerID VARCHAR (8) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Zip CHAR(6) NOT NULL,
    TowerTotalSlots INT,
    -- RemainingSlots INT, , This should be a view instead
    BranchID VARCHAR(12),
    PRIMARY KEY (TowerID),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID) ON DELETE CASCADE
);

-- ParkingZone, i.e. Zone Table (Entity)
-- Note: Type 1 is Private, Type 2 is Heavy, Type 3 is Maintenance, Type 4 is Mixed
CREATE TABLE ParkingZone (
    ParkingZoneID INT NOT NULL,
    ParkingZoneType INT NOT NULL,
    -- FilledSlots INT, This should be a view instead
    ZoneTotalSlots INT,
    TowerID VARCHAR(8),
    PRIMARY KEY (ParkingZoneID, ParkingZoneType),
    FOREIGN KEY (TowerID) REFERENCES Tower(TowerID) ON DELETE CASCADE
);

-- TypeSlots Table (Not in ERD)
CREATE TABLE TypeSlots (
    ParkingZoneID INT,
    TotalSlots INT,
    PRIMARY KEY (ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE
);

/* SHOULD BE PARKING SLOT COMPRISES */
-- TODO: ParkingSlot Table (Weak Entity Set)
CREATE TABLE ParkingSlot (
    ParkingSlotID VARCHAR(8),
    ParkingZoneID INT,
    PRIMARY KEY (ParkingSlotID, ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE
);

-- Exits Table (Relationship)
-- Removed GateID as primary key, replaced it with time instead
-- Added ParkingZoneID and ParkingSlotID to preserve parking history
CREATE TABLE Exits (
    DateTime DATETIME,
    ExitGateID INT,
    PlateNumber VARCHAR(10),
    ParkingZoneID INT,
    ParkingSlotID VARCHAR(8),
    PRIMARY KEY (DateTime, PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE,
    FOREIGN KEY (ParkingSlotID) REFERENCES ParkingSlot(ParkingSlotID) ON DELETE CASCADE,
    FOREIGN KEY (ExitGateID) REFERENCES ExitGate(ExitGateID) ON DELETE CASCADE
);

-- Occupy Table (Relationship)
CREATE TABLE Occupy (
    ParkingSlotID VARCHAR(8),
    ParkingZoneID INT,
    PlateNumber VARCHAR(10),
    PRIMARY KEY (ParkingSlotID, ParkingZoneID, PlateNumber),
    FOREIGN KEY (ParkingSlotID) REFERENCES ParkingSlot(ParkingSlotID) ON DELETE CASCADE,
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE,
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);
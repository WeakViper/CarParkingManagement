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
/* DROP TABLE IF EXISTS TypeSlots; */
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
-- Added NOT NULL to WeightClass to enforce total disjoint
CREATE TABLE VehicleClass (
    PlateNumber VARCHAR(10) NOT NULL,
    WeightClass CHAR(1) NOT NULL,
    PRIMARY KEY (PlateNumber)
);

-- WeightRate Table (Reference)
CREATE TABLE WeightRate (
    WeightClass CHAR(1) NOT NULL,
    HourlyRate INT NOT NULL,
    PRIMARY KEY (WeightClass)
);

-- EntryGate Table (Entity)
CREATE TABLE EntryGate (
    EntryGateID INT NOT NULL,
    StatusIsActive INT NOT NULL,
    PRIMARY KEY (EntryGateID)
);

-- ExitGate Table (Entity)
CREATE TABLE ExitGate (
    ExitGateID INT NOT NULL,
    StatusIsActive INT NOT NULL,
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
    Method VARCHAR(255) NOT NULL,
    Amount FLOAT NOT NULL,
    PlateNumber VARCHAR(10) NOT NULL,
    ExitGateID INT NOT NULL,
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (ExitGateID) REFERENCES ExitGate(ExitGateID),
    CONSTRAINT PositiveAmount CHECK (Amount >= 0)
);

-- Enters Table (Relationship)
-- Removed GateID as primary key, replaced it with time instead
-- Total participation is enforced via backend implementation
CREATE TABLE Enters (
    DateTime DATETIME NOT NULL,
    EntryGateID INT NOT NULL,
    PlateNumber VARCHAR(10) NOT NULL,
    PRIMARY KEY (DateTime, PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (EntryGateID) REFERENCES EntryGate(EntryGateID) ON DELETE CASCADE
);

-- BranchClient Table

/* 
Assume the following specification for ClientTypes
A: Shopping malls
B: Apartment buildings
C: Superblock with both commercial and residential zones
*/

CREATE TABLE BranchClient (
    BranchID VARCHAR(255) NOT NULL,
    ClientName VARCHAR(255) NOT NULL,
    ClientType CHAR(1),
    PRIMARY KEY (BranchID)
);

/*
-- We decided to make this a view instead, in order not to duplicate data
-- It's also not a frequently used functionality compared to other aspects of the application
-- BranchCap Table
CREATE TABLE BranchCap (
    ClientType CHAR(1),
    ParkingCap INT,
    PRIMARY KEY (ClientType),
    FOREIGN KEY (ClientType) REFERENCES BranchClient(ClientType)
); */

-- Staff Table (Entity)
CREATE TABLE Staff (
    EmployeeID INT UNIQUE NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    Telephone CHAR(10) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Shift VARCHAR(255),
    StartDate DATE,
    BranchID VARCHAR(12) NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID) ON DELETE CASCADE
);

-- Tower Table (Entity)
/* Added new TowerID */
CREATE TABLE Tower (
    TowerID VARCHAR(8) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Zip CHAR(6) NOT NULL,
    TowerTotalSlots INT NOT NULL,
    -- RemainingSlots INT, Removed this, as it makes more sense to be a view
    -- FilledSlots INT, This should be a view instead
    BranchID VARCHAR(12) NOT NULL,
    PRIMARY KEY (TowerID),
    FOREIGN KEY (BranchID) REFERENCES BranchClient(BranchID) ON DELETE CASCADE
);

-- ParkingZone, i.e. Zone Table (Entity)
-- Note: Type 1 is Private, Type 2 is Heavy, Type 3 is Maintenance, Type 4 is Mixed
CREATE TABLE ParkingZone (
    ParkingZoneID INT NOT NULL,
    ParkingZoneType INT NOT NULL,
    -- RemainingSlots INT, Removed this, as it makes more sense to be a view
    -- FilledSlots INT, This should be a view instead
    ZoneTotalSlots INT NOT NULL,
    TowerID VARCHAR(8) NOT NULL,
    PRIMARY KEY (ParkingZoneID), -- Removed ParkingZoneType from primary key
    FOREIGN KEY (TowerID) REFERENCES Tower(TowerID) ON DELETE CASCADE
);

/*
-- We decided to add this as an attribute ZoneTotalSlots in ParkingZone instead
-- It actually saves data and it's less redundant
-- TypeSlots Table (Not in ERD)
CREATE TABLE TypeSlots (
    ParkingZoneID INT,
    TotalSlots INT,
    PRIMARY KEY (ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE
); */

-- ParkingSlot Table (Weak Entity Set, a.k.a ParkingSlotsComprises)
CREATE TABLE ParkingSlot (
    ParkingSlotID VARCHAR(8) NOT NULL,
    ParkingZoneID INT NOT NULL,
    PRIMARY KEY (ParkingSlotID, ParkingZoneID),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE
);

-- Exits Table (Relationship)
-- Removed GateID as primary key, replaced it with time instead
-- Added ParkingZoneID and ParkingSlotID to preserve parking history
CREATE TABLE Exits (
    DateTime DATETIME,
    ExitGateID INT NOT NULL,
    PlateNumber VARCHAR(10) NOT NULL,
    ParkingZoneID INT NOT NULL,
    ParkingSlotID VARCHAR(8) NOT NULL,
    PRIMARY KEY (DateTime, PlateNumber),
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber),
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE,
    FOREIGN KEY (ParkingSlotID) REFERENCES ParkingSlot(ParkingSlotID) ON DELETE CASCADE,
    FOREIGN KEY (ExitGateID) REFERENCES ExitGate(ExitGateID) ON DELETE CASCADE
);

-- Occupy Table (Relationship)
CREATE TABLE Occupy (
    ParkingSlotID VARCHAR(8) NOT NULL,
    ParkingZoneID INT NOT NULL,
    PlateNumber VARCHAR(10) NOT NULL,
    PRIMARY KEY (ParkingSlotID, ParkingZoneID, PlateNumber),
    FOREIGN KEY (ParkingSlotID) REFERENCES ParkingSlot(ParkingSlotID) ON DELETE CASCADE,
    FOREIGN KEY (ParkingZoneID) REFERENCES ParkingZone(ParkingZoneID) ON DELETE CASCADE,
    FOREIGN KEY (PlateNumber) REFERENCES VehicleClass(PlateNumber)
);
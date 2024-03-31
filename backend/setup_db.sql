/* 
- This is an SQL script to setup and populate the database for our project.
- The first section is comprised of the DDL statements.
- The second section is comprised of the corresponding insert statements.
*/

CREATE DATABASE CPMS;
USE CPMS;

-- SECTION 1: SQL Data Definition Language (DDL)

-- VehicleClass Table
CREATE TABLE VehicleClass (
    Plate# VARCHAR(10) PRIMARY KEY,
    WeightClass CHAR(1)
);

-- WeightRate Table
CREATE TABLE WeightRate (
    WeightClass CHAR(1) PRIMARY KEY,
    HourlyRate INT,
    FOREIGN KEY (WeightClass) REFERENCES VehicleClass
);


-- PrivateCar Table
CREATE TABLE PrivateCar (
    Plate# VARCHAR(10) PRIMARY KEY,
    Membership VARCHAR(12),
    FOREIGN KEY (Plate#) REFERENCES VehicleClass
);

-- HeavyDuty Table
CREATE TABLE HeavyDuty (
    Plate# VARCHAR(10) PRIMARY KEY,
    CompanyName VARCHAR(255),
    FOREIGN KEY (Plate#) REFERENCES VehicleClass
);

-- Maintenance Table
CREATE TABLE Maintenance (
    Plate# VARCHAR(10) PRIMARY KEY,
    WorkOrder# VARCHAR(12),
    FOREIGN KEY (Plate#) REFERENCES VehicleClass
);

-- Payment Table
CREATE TABLE Payment (
    ID VARCHAR(10) PRIMARY KEY,
    Method VARCHAR(255),
    Plate# VARCHAR(10),
    ExitGate# INT,
    FOREIGN KEY (Plate#) REFERENCES VehicleClass,
    FOREIGN KEY (ExitGate#) REFERENCES ExitGate
);

-- Enter Table
CREATE TABLE Enter (
    DateTime DATETIME,
    Plate# VARCHAR(10),
    EntryGate# INT,
    PRIMARY KEY (EntryGate#, Plate#),
    FOREIGN KEY (Plate#) REFERENCES VehicleClass,
    FOREIGN KEY (EntryGate#) REFERENCES EntryGate
);

-- Exit Table
CREATE TABLE Exit (
    DateTime DATETIME,
    Plate# VARCHAR(10),
    ExitGate# INT,
    PRIMARY KEY (ExitGate#, Plate#),
    FOREIGN KEY (Plate#) REFERENCES VehicleClass,
    FOREIGN KEY (ExitGate#) REFERENCES ExitGate
);

-- EntryGate Table
CREATE TABLE EntryGate (
    EntryGate# INT PRIMARY KEY,
    StatusIsActive INT
);

-- ExitGate Table
CREATE TABLE ExitGate (
    ExitGate# INT PRIMARY KEY,
    StatusIsActive INT
);

-- ZoneType Table
CREATE TABLE ZoneType (
    ZoneID INT PRIMARY KEY,
    ZoneType INT,
    FilledSlots INT,
    RemainingSlots INT,
    Address VARCHAR(255),
    Zip CHAR(6),
    FOREIGN KEY (Address, Zip) REFERENCES Tower
);

-- TypeSlots Table
CREATE TABLE TypeSlots (
    ZoneType INT PRIMARY KEY,
    TotalSlots INT,
    FOREIGN KEY (ZoneType) REFERENCES ZoneType
);

-- ParkingSlot Table
CREATE TABLE ParkingSlot (
    ID VARCHAR(4),
    ZoneID INT,
    PRIMARY KEY (ID, ZoneID),
    FOREIGN KEY (ZoneID) REFERENCES ZoneType(ZoneID)
);

-- Occupy Table
CREATE TABLE Occupy (
    ID VARCHAR(4),
    ZoneID INT,
    Plate# VARCHAR(10),
    PRIMARY KEY (ID, ZoneID, Plate#),
    FOREIGN KEY (ID) REFERENCES ParkingSlot(ID),
    FOREIGN KEY (ZoneID) REFERENCES ZoneType(ZoneID),
    FOREIGN KEY (Plate#) REFERENCES VehicleClass(Plate#)
);

-- BranchClient Table
CREATE TABLE BranchClient (
    Branch# VARCHAR(12) PRIMARY KEY,
    ClientName VARCHAR(255),
    ClientType CHAR(1)
);

-- BranchCap Table
CREATE TABLE BranchCap (
    ClientType CHAR(1) PRIMARY KEY,
    ParkingCap INT,
    FOREIGN KEY (ClientType) REFERENCES BranchClient
);

-- Tower Table
CREATE TABLE Tower (
    Address VARCHAR(255),
    Zip CHAR(6),
    FilledSlots INT,
    RemainingSlots INT,
    Branch# VARCHAR(12),
    PRIMARY KEY (Address, Zip),
    FOREIGN KEY (Branch#) REFERENCES BranchClient(Branch#)
);

-- Staff Table
CREATE TABLE Staff (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(255),
    Telephone INT,
    email VARCHAR(255) UNIQUE,
    Shift VARCHAR(255),
    StartDate DATE,
    Branch# VARCHAR(12),
    FOREIGN KEY (Branch#) REFERENCES BranchClient(Branch#)
);

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

-- Enter Table
INSERT INTO Enter VALUES ('2023-01-01 08:00:00', 'PLATE1234', 1);
INSERT INTO Enter VALUES ('2023-01-02 09:00:00', 'PLATE2345', 2);
INSERT INTO Enter VALUES ('2023-01-03 10:00:00', 'PLATE3456', 3);
INSERT INTO Enter VALUES ('2023-01-04 11:00:00', 'PLATE4567', 4);
INSERT INTO Enter VALUES ('2023-01-05 12:00:00', 'PLATE5678', 5);

-- Exit Table
INSERT INTO Exit VALUES ('2023-01-01 18:00:00', 'PLATE1234', 1);
INSERT INTO Exit VALUES ('2023-01-02 19:00:00', 'PLATE2345', 2);
INSERT INTO Exit VALUES ('2023-01-03 20:00:00', 'PLATE3456', 3);
INSERT INTO Exit VALUES ('2023-01-04 21:00:00', 'PLATE4567', 4);
INSERT INTO Exit VALUES ('2023-01-05 22:00:00', 'PLATE5678', 5);

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

-- ZoneType Table
INSERT INTO ZoneType VALUES (1, 1, 20, 30, 'Address1', 'Zip1');
INSERT INTO ZoneType VALUES (2, 2, 25, 25, 'Address2', 'Zip2');
INSERT INTO ZoneType VALUES (3, 3, 30, 20, 'Address3', 'Zip3');
INSERT INTO ZoneType VALUES (4, 4, 4, 15, 35, 'Address4', 'Zip4');
INSERT INTO ZoneType VALUES (5, 5, 10, 40, 'Address5', 'Zip5');

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
'2023-05-01', 'BR005');
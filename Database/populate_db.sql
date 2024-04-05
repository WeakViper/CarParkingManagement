-- SECTION 2: INSERT STATEMENTS
USE cpms_db;

-- VehicleClass Table 
-- A is for Private, B is for Heavy, C is for Maintenance
INSERT INTO VehicleClass VALUES ('PLATE1234', 'A');
INSERT INTO VehicleClass VALUES ('PLATE2345', 'A');
INSERT INTO VehicleClass VALUES ('PLATE3456', 'A');
INSERT INTO VehicleClass VALUES ('PLATE4567', 'A');
INSERT INTO VehicleClass VALUES ('PLATE5678', 'A');

-- New Values for A
INSERT INTO VehicleClass VALUES ('PLATE4321', 'A');
INSERT INTO VehicleClass VALUES ('PLATE5432', 'A');
INSERT INTO VehicleClass VALUES ('PLATE6543', 'A');
INSERT INTO VehicleClass VALUES ('PLATE7654', 'A');
INSERT INTO VehicleClass VALUES ('PLATE8765', 'A');
INSERT INTO VehicleClass VALUES ('PLATE9876', 'A');
INSERT INTO VehicleClass VALUES ('PLATE0987', 'A');
INSERT INTO VehicleClass VALUES ('PLATE2435', 'A');
INSERT INTO VehicleClass VALUES ('PLATE3645', 'A');
INSERT INTO VehicleClass VALUES ('PLATE7457', 'A');
-- End of new values

INSERT INTO VehicleClass VALUES ('PLATE6789', 'B');
INSERT INTO VehicleClass VALUES ('PLATE7890', 'B');
INSERT INTO VehicleClass VALUES ('PLATE8901', 'B');
INSERT INTO VehicleClass VALUES ('PLATE9012', 'B');
INSERT INTO VehicleClass VALUES ('PLATE0123', 'B');

-- New Values for B
INSERT INTO VehicleClass VALUES ('PLATE1199', 'B');
INSERT INTO VehicleClass VALUES ('PLATE2288', 'B');
INSERT INTO VehicleClass VALUES ('PLATE3377', 'B');
INSERT INTO VehicleClass VALUES ('PLATE4466', 'B');
INSERT INTO VehicleClass VALUES ('PLATE6644', 'B');
INSERT INTO VehicleClass VALUES ('PLATE7733', 'B');
INSERT INTO VehicleClass VALUES ('PLATE8822', 'B');
INSERT INTO VehicleClass VALUES ('PLATE9911', 'B');
INSERT INTO VehicleClass VALUES ('PLATE1919', 'B');
INSERT INTO VehicleClass VALUES ('PLATE2828', 'B');
-- End of new values

INSERT INTO VehicleClass VALUES ('PLATE0500', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0600', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0700', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0800', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0900', 'C');

-- New Values for C
INSERT INTO VehicleClass VALUES ('PLATE0511', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0611', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0711', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0811', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0911', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0522', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0622', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0722', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0822', 'C');
INSERT INTO VehicleClass VALUES ('PLATE0922', 'C');
-- End of new values

-- WeightRate Table
INSERT INTO WeightRate VALUES ('A', 5);
INSERT INTO WeightRate VALUES ('B', 10);
INSERT INTO WeightRate VALUES ('C', 2); /* Cheap because the building calls maintenance */

-- PrivateCar Table
INSERT INTO PrivateCar VALUES ('PLATE1234', 'p6725f');
INSERT INTO PrivateCar VALUES ('PLATE2345', 't9123a');
INSERT INTO PrivateCar VALUES ('PLATE3456', 'r1231b');
INSERT INTO PrivateCar VALUES ('PLATE4567', 'm1023i');
INSERT INTO PrivateCar VALUES ('PLATE5678', 'q1029y');
INSERT INTO PrivateCar VALUES ('PLATE4321', NULL);
INSERT INTO PrivateCar VALUES ('PLATE5432', NULL);
INSERT INTO PrivateCar VALUES ('PLATE6543', NULL);
INSERT INTO PrivateCar VALUES ('PLATE7654', NULL);
INSERT INTO PrivateCar VALUES ('PLATE8765', NULL);
INSERT INTO PrivateCar VALUES ('PLATE9876', 'x1273a');
INSERT INTO PrivateCar VALUES ('PLATE0987', 'a1238b');
INSERT INTO PrivateCar VALUES ('PLATE2435', 'j1923h');
INSERT INTO PrivateCar VALUES ('PLATE3645', 'n9212p');
INSERT INTO PrivateCar VALUES ('PLATE7457', 'k1920r');

-- HeavyDuty Table
INSERT INTO HeavyDuty VALUES ('PLATE6789', 'Maersk Cargo');
INSERT INTO HeavyDuty VALUES ('PLATE7890', 'Yang Ming');
INSERT INTO HeavyDuty VALUES ('PLATE8901', 'Atlantic Snow');
INSERT INTO HeavyDuty VALUES ('PLATE9012', 'Pacific Beast');
INSERT INTO HeavyDuty VALUES ('PLATE0123', 'Vladivostok Blue');
INSERT INTO PrivateCar VALUES ('PLATE1199', NULL);
INSERT INTO PrivateCar VALUES ('PLATE2288', NULL);
INSERT INTO PrivateCar VALUES ('PLATE3377', 'Selandia Baru');
INSERT INTO PrivateCar VALUES ('PLATE4466',  NULL);
INSERT INTO PrivateCar VALUES ('PLATE6644', 'Bajak Laut');
INSERT INTO PrivateCar VALUES ('PLATE7733', 'Yang Ming');
INSERT INTO PrivateCar VALUES ('PLATE8822', 'Maersk Cargo');
INSERT INTO PrivateCar VALUES ('PLATE9911', 'Ming Yang');
INSERT INTO PrivateCar VALUES ('PLATE1919', 'Atlantic Snow');
INSERT INTO PrivateCar VALUES ('PLATE2828', 'Vladivostok Blue');

-- Maintenance Table
INSERT INTO Maintenance VALUES ('PLATE0500', 'WO1234');
INSERT INTO Maintenance VALUES ('PLATE0600', 'WO2345');
INSERT INTO Maintenance VALUES ('PLATE0700', 'WO3456');
INSERT INTO Maintenance VALUES ('PLATE0800', 'WO4567');
INSERT INTO Maintenance VALUES ('PLATE0900', 'WO5678');
INSERT INTO Maintenance VALUES ('PLATE0511', 'WO4321');
INSERT INTO Maintenance VALUES ('PLATE0611', 'WO5432');
INSERT INTO Maintenance VALUES ('PLATE0711', 'WO6543');
INSERT INTO Maintenance VALUES ('PLATE0811', 'WO7654');
INSERT INTO Maintenance VALUES ('PLATE0911', 'WO8756');
INSERT INTO Maintenance VALUES ('PLATE0522', 'WO9786');
INSERT INTO Maintenance VALUES ('PLATE0622', 'WO0978');
INSERT INTO Maintenance VALUES ('PLATE0722', 'WO0123');
INSERT INTO Maintenance VALUES ('PLATE0822', 'WO1324');
INSERT INTO Maintenance VALUES ('PLATE0922', 'WO2435');

-- EntryGate Table
INSERT INTO EntryGate VALUES (1, 1);
INSERT INTO EntryGate VALUES (2, 1);
INSERT INTO EntryGate VALUES (3, 1);
INSERT INTO EntryGate VALUES (4, 1);
INSERT INTO EntryGate VALUES (5, 1);
INSERT INTO EntryGate VALUES (6, 1);
INSERT INTO EntryGate VALUES (7, 1);
INSERT INTO EntryGate VALUES (8, 0);
INSERT INTO EntryGate VALUES (9, 1);
INSERT INTO EntryGate VALUES (10, 1);
INSERT INTO EntryGate VALUES (11, 1);
INSERT INTO EntryGate VALUES (12, 0);
INSERT INTO EntryGate VALUES (13, 1);
INSERT INTO EntryGate VALUES (14, 0);
INSERT INTO EntryGate VALUES (15, 1);

-- ExitGate Table
INSERT INTO ExitGate VALUES (1, 1);
INSERT INTO ExitGate VALUES (2, 1);
INSERT INTO ExitGate VALUES (3, 1);
INSERT INTO ExitGate VALUES (4, 1);
INSERT INTO ExitGate VALUES (5, 1);
INSERT INTO ExitGate VALUES (6, 1);
INSERT INTO ExitGate VALUES (7, 0);
INSERT INTO ExitGate VALUES (8, 1);
INSERT INTO ExitGate VALUES (9, 1);
INSERT INTO ExitGate VALUES (10, 1);
INSERT INTO ExitGate VALUES (11, 1);
INSERT INTO ExitGate VALUES (12, 0);
INSERT INTO ExitGate VALUES (13, 0);
INSERT INTO ExitGate VALUES (14, 0);
INSERT INTO ExitGate VALUES (15, 1);

-- Payment Table
INSERT INTO Payment VALUES (UUID(), 'Cash', 20, 'PLATE1234', 1);
INSERT INTO Payment VALUES (UUID(), 'Card', 10, 'PLATE2345', 2);
INSERT INTO Payment VALUES (UUID(), 'Online', 30,  'PLATE3456', 3);
INSERT INTO Payment VALUES (UUID(), 'Check', 20, 'PLATE4567', 4);
INSERT INTO Payment VALUES (UUID(), 'Mobile', 10, 'PLATE5678', 5);

-- Enters Table
INSERT INTO Enters VALUES ('2023-01-01 08:00:00', 1, 'PLATE1234');
INSERT INTO Enters VALUES ('2023-01-01 09:00:00', 1, 'PLATE2345');
INSERT INTO Enters VALUES ('2023-01-01 10:00:00', 2, 'PLATE3456');
INSERT INTO Enters VALUES ('2023-01-01 10:00:00', 3, 'PLATE4567');
INSERT INTO Enters VALUES ('2023-01-01 10:00:00', 4, 'PLATE5678');

-- New Values for A
INSERT INTO Enters VALUES ('2023-01-01 08:01:00', 5, 'PLATE4321');
INSERT INTO Enters VALUES ('2023-01-01 08:02:00', 6, 'PLATE5432');
INSERT INTO Enters VALUES ('2023-01-01 08:03:00', 7, 'PLATE6543');
INSERT INTO Enters VALUES ('2023-01-01 08:04:00', 7, 'PLATE7654');
INSERT INTO Enters VALUES ('2023-01-05 08:05:00', 5, 'PLATE8765');
INSERT INTO Enters VALUES ('2023-01-05 08:06:00', 9, 'PLATE9876');
INSERT INTO Enters VALUES ('2023-01-05 09:01:00', 10, 'PLATE0987');
INSERT INTO Enters VALUES ('2023-01-05 09:02:00', 1, 'PLATE2435');
INSERT INTO Enters VALUES ('2023-01-04 09:03:00', 2, 'PLATE3645');
INSERT INTO Enters VALUES ('2023-01-04 09:04:00', 2, 'PLATE7457');
-- End of new values

INSERT INTO Enters VALUES ('2023-01-02 11:01:00', 11, 'PLATE6789');
INSERT INTO Enters VALUES ('2023-01-02 11:02:00', 11, 'PLATE7890');
INSERT INTO Enters VALUES ('2023-01-02 11:03:00', 11, 'PLATE8901');
INSERT INTO Enters VALUES ('2023-01-02 11:04:00', 11, 'PLATE9012');
INSERT INTO Enters VALUES ('2023-01-02 11:05:00', 11, 'PLATE0123');

-- New Values for B
INSERT INTO Enters VALUES ('2023-01-02 07:00:00', 13, 'PLATE1199');
INSERT INTO Enters VALUES ('2023-01-02 07:01:00', 15, 'PLATE2288');
INSERT INTO Enters VALUES ('2023-01-02 07:02:00', 13, 'PLATE3377');
INSERT INTO Enters VALUES ('2023-01-02 07:03:00', 15, 'PLATE4466');
INSERT INTO Enters VALUES ('2023-01-03 07:04:00', 13, 'PLATE6644');
INSERT INTO Enters VALUES ('2023-01-03 07:05:00', 11, 'PLATE7733');
INSERT INTO Enters VALUES ('2023-01-03 07:06:00', 10, 'PLATE8822');
INSERT INTO Enters VALUES ('2023-01-01 07:07:00', 9, 'PLATE9911');
INSERT INTO Enters VALUES ('2023-01-01 07:08:00', 10, 'PLATE1919');
INSERT INTO Enters VALUES ('2023-01-01 07:09:00', 11, 'PLATE2828');
-- End of new values

INSERT INTO Enters VALUES ('2023-01-06 08:40:20', 1,'PLATE0500');
INSERT INTO Enters VALUES ('2023-01-06 08:00:10', 2,'PLATE0600');
INSERT INTO Enters VALUES ('2023-01-06 08:20:30', 3,'PLATE0700');
INSERT INTO Enters VALUES ('2023-01-06 08:00:40', 4,'PLATE0800');
INSERT INTO Enters VALUES ('2023-01-06 08:01:51', 5,'PLATE0900');

-- New ValueEnters
INSERT INTO Enters VALUES ('2023-01-01 08:30:00', 1, 'PLATE0511');
INSERT INTO Enters VALUES ('2023-01-02 08:42:00', 1, 'PLATE0611');
INSERT INTO Enters VALUES ('2023-01-03 08:53:00', 2, 'PLATE0711');
INSERT INTO Enters VALUES ('2023-01-04 08:49:00', 5, 'PLATE0811');
INSERT INTO Enters VALUES ('2023-01-05 08:02:00', 6, 'PLATE0911');
INSERT INTO Enters VALUES ('2023-01-05 08:03:00', 7, 'PLATE0522');
INSERT INTO Enters VALUES ('2023-01-06 08:13:00', 8, 'PLATE0622');
INSERT INTO Enters VALUES ('2023-01-06 08:17:00', 5, 'PLATE0722');
INSERT INTO Enters VALUES ('2023-01-01 08:02:33', 3, 'PLATE0822');
INSERT INTO Enters VALUES ('2023-01-01 08:03:47', 2, 'PLATE0922');

-- Stopped here

-- BranchClient Table
INSERT INTO BranchClient VALUES ('BR001', 'Client1', 'A');
INSERT INTO BranchClient VALUES ('BR002', 'Client2', 'B');
INSERT INTO BranchClient VALUES ('BR003', 'Client3', 'C');
INSERT INTO BranchClient VALUES ('BR004', 'Client4', 'D');
INSERT INTO BranchClient VALUES ('BR005', 'Client5', 'E');

-- Tower Table
INSERT INTO Tower VALUES ('100', '123 Main St', 'A1B2C3', 61, 'BR001');
INSERT INTO Tower VALUES ('200', '456 Oak Rd', 'D4E5F6', 66, 'BR002');
INSERT INTO Tower VALUES ('300', '456 Oak Rd', 'G7H8I9', 38, 'BR003');
INSERT INTO Tower VALUES ('400', '101 River Ln', 'J1K2L3', 55, 'BR004');
INSERT INTO Tower VALUES ('500', '202 Lake St', 'M4N5O6', 48, 'BR005');

-- ParkingZoneType Table
INSERT INTO ParkingZone VALUES (15, 1, 30, '100');
INSERT INTO ParkingZone VALUES (58, 4, 31, '100');
INSERT INTO ParkingZone VALUES (27, 1, 25, '200');
INSERT INTO ParkingZone VALUES (51, 4, 41, '200');
INSERT INTO ParkingZone VALUES (32, 2, 21, '300');
INSERT INTO ParkingZone VALUES (43, 3, 17, '300');
INSERT INTO ParkingZone VALUES (18, 1, 32, '400');
INSERT INTO ParkingZone VALUES (29, 1, 23, '400');
INSERT INTO ParkingZone VALUES (25, 2, 21, '500');
INSERT INTO ParkingZone VALUES (45, 3, 27, '500');

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
INSERT INTO ParkingSlot VALUES ('SLOT01', 15);
INSERT INTO ParkingSlot VALUES ('SLOT02', 15);
INSERT INTO ParkingSlot VALUES ('SLOT03', 15);
INSERT INTO ParkingSlot VALUES ('SLOT04', 15);
INSERT INTO ParkingSlot VALUES ('SLOT05', 15);
INSERT INTO ParkingSlot VALUES ('SLOT06', 15);
INSERT INTO ParkingSlot VALUES ('SLOT07', 15);
INSERT INTO ParkingSlot VALUES ('SLOT08', 15);
INSERT INTO ParkingSlot VALUES ('SLOT09', 15);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 58);
INSERT INTO ParkingSlot VALUES ('SLOT02', 58);
INSERT INTO ParkingSlot VALUES ('SLOT03', 58);
INSERT INTO ParkingSlot VALUES ('SLOT04', 58);
INSERT INTO ParkingSlot VALUES ('SLOT05', 58);
INSERT INTO ParkingSlot VALUES ('SLOT06', 58);
INSERT INTO ParkingSlot VALUES ('SLOT07', 58);
INSERT INTO ParkingSlot VALUES ('SLOT08', 58);
INSERT INTO ParkingSlot VALUES ('SLOT09', 58);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 27);
INSERT INTO ParkingSlot VALUES ('SLOT02', 27);
INSERT INTO ParkingSlot VALUES ('SLOT03', 27);
INSERT INTO ParkingSlot VALUES ('SLOT04', 27);
INSERT INTO ParkingSlot VALUES ('SLOT05', 27);
INSERT INTO ParkingSlot VALUES ('SLOT06', 27);
INSERT INTO ParkingSlot VALUES ('SLOT07', 27);
INSERT INTO ParkingSlot VALUES ('SLOT08', 27);
INSERT INTO ParkingSlot VALUES ('SLOT09', 27);
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


INSERT INTO ParkingSlot VALUES ('SLOT01', 51);
INSERT INTO ParkingSlot VALUES ('SLOT02', 51);
INSERT INTO ParkingSlot VALUES ('SLOT03', 51);
INSERT INTO ParkingSlot VALUES ('SLOT04', 51);
INSERT INTO ParkingSlot VALUES ('SLOT05', 51);
INSERT INTO ParkingSlot VALUES ('SLOT06', 51);
INSERT INTO ParkingSlot VALUES ('SLOT07', 51);
INSERT INTO ParkingSlot VALUES ('SLOT08', 51);
INSERT INTO ParkingSlot VALUES ('SLOT09', 51);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 32);
INSERT INTO ParkingSlot VALUES ('SLOT02', 32);
INSERT INTO ParkingSlot VALUES ('SLOT03', 32);
INSERT INTO ParkingSlot VALUES ('SLOT04', 32);
INSERT INTO ParkingSlot VALUES ('SLOT05', 32);
INSERT INTO ParkingSlot VALUES ('SLOT06', 32);
INSERT INTO ParkingSlot VALUES ('SLOT07', 32);
INSERT INTO ParkingSlot VALUES ('SLOT08', 32);
INSERT INTO ParkingSlot VALUES ('SLOT09', 32);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 43);
INSERT INTO ParkingSlot VALUES ('SLOT02', 43);
INSERT INTO ParkingSlot VALUES ('SLOT03', 43);
INSERT INTO ParkingSlot VALUES ('SLOT04', 43);
INSERT INTO ParkingSlot VALUES ('SLOT05', 43);
INSERT INTO ParkingSlot VALUES ('SLOT06', 43);
INSERT INTO ParkingSlot VALUES ('SLOT07', 43);
INSERT INTO ParkingSlot VALUES ('SLOT08', 43);
INSERT INTO ParkingSlot VALUES ('SLOT09', 43);
INSERT INTO ParkingSlot VALUES ('SLOT10', 43);
INSERT INTO ParkingSlot VALUES ('SLOT11', 43);
INSERT INTO ParkingSlot VALUES ('SLOT12', 43);
INSERT INTO ParkingSlot VALUES ('SLOT13', 43);
INSERT INTO ParkingSlot VALUES ('SLOT14', 43);
INSERT INTO ParkingSlot VALUES ('SLOT15', 43);
INSERT INTO ParkingSlot VALUES ('SLOT16', 43);
INSERT INTO ParkingSlot VALUES ('SLOT17', 43);

INSERT INTO ParkingSlot VALUES ('SLOT01', 18);
INSERT INTO ParkingSlot VALUES ('SLOT02', 18);
INSERT INTO ParkingSlot VALUES ('SLOT03', 18);
INSERT INTO ParkingSlot VALUES ('SLOT04', 18);
INSERT INTO ParkingSlot VALUES ('SLOT05', 18);
INSERT INTO ParkingSlot VALUES ('SLOT06', 18);
INSERT INTO ParkingSlot VALUES ('SLOT07', 18);
INSERT INTO ParkingSlot VALUES ('SLOT08', 18);
INSERT INTO ParkingSlot VALUES ('SLOT09', 18);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 29);
INSERT INTO ParkingSlot VALUES ('SLOT02', 29);
INSERT INTO ParkingSlot VALUES ('SLOT03', 29);
INSERT INTO ParkingSlot VALUES ('SLOT04', 29);
INSERT INTO ParkingSlot VALUES ('SLOT05', 29);
INSERT INTO ParkingSlot VALUES ('SLOT06', 29);
INSERT INTO ParkingSlot VALUES ('SLOT07', 29);
INSERT INTO ParkingSlot VALUES ('SLOT08', 29);
INSERT INTO ParkingSlot VALUES ('SLOT09', 29);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 25);
INSERT INTO ParkingSlot VALUES ('SLOT02', 25);
INSERT INTO ParkingSlot VALUES ('SLOT03', 25);
INSERT INTO ParkingSlot VALUES ('SLOT04', 25);
INSERT INTO ParkingSlot VALUES ('SLOT05', 25);
INSERT INTO ParkingSlot VALUES ('SLOT06', 25);
INSERT INTO ParkingSlot VALUES ('SLOT07', 25);
INSERT INTO ParkingSlot VALUES ('SLOT08', 25);
INSERT INTO ParkingSlot VALUES ('SLOT09', 25);
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

INSERT INTO ParkingSlot VALUES ('SLOT01', 45);
INSERT INTO ParkingSlot VALUES ('SLOT02', 45);
INSERT INTO ParkingSlot VALUES ('SLOT03', 45);
INSERT INTO ParkingSlot VALUES ('SLOT04', 45);
INSERT INTO ParkingSlot VALUES ('SLOT05', 45);
INSERT INTO ParkingSlot VALUES ('SLOT06', 45);
INSERT INTO ParkingSlot VALUES ('SLOT07', 45);
INSERT INTO ParkingSlot VALUES ('SLOT08', 45);
INSERT INTO ParkingSlot VALUES ('SLOT09', 45);
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

-- Exits Table
INSERT INTO Exits VALUES ('2023-01-01 18:00:00', 1, 'PLATE1234', 51, 'SLOT10');
INSERT INTO Exits VALUES ('2023-01-02 19:15:00', 2, 'PLATE3333', 51, 'SLOT7');
INSERT INTO Exits VALUES ('2023-01-05 22:00:00', 5, 'PLATE5678', 45, 'SLOT14');
INSERT INTO Exits VALUES ('2023-01-05 12:02:00', 5, 'PLATE4433', 45, 'SLOT2');
INSERT INTO Exits VALUES ('2023-01-01 18:01:00', 1, 'PLATE9999', 32, 'SLOT10');
INSERT INTO Exits VALUES ('2023-01-04 21:00:00', 4, 'PLATE4567', 29, 'SLOT13');
INSERT INTO Exits VALUES ('2023-01-04 21:01:00', 4, 'PLATE6666', 29, 'SLOT3');
INSERT INTO Exits VALUES ('2023-01-04 21:01:00', 4, 'PLATE1111', 29, 'SLOT9');
INSERT INTO Exits VALUES ('2023-01-04 11:01:00', 4, 'PLATE5544', 29, 'SLOT4');
INSERT INTO Exits VALUES ('2023-01-03 20:45:00', 3, 'PLATE7777', 27, 'SLOT4');
INSERT INTO Exits VALUES ('2023-01-02 19:00:00', 2, 'PLATE2345', 27, 'SLOT11');
INSERT INTO Exits VALUES ('2023-01-03 20:45:00', 3, 'PLATE2222', 27, 'SLOT8');
INSERT INTO Exits VALUES ('2023-01-03 10:45:00', 3, 'PLATE6655', 27, 'SLOT8');
INSERT INTO Exits VALUES ('2023-01-03 20:00:00', 3, 'PLATE3456', 25, 'SLOT12');
INSERT INTO Exits VALUES ('2023-01-05 12:07:00', 5, 'PLATE8877', 25, 'SLOT11');
INSERT INTO Exits VALUES ('2023-01-02 19:15:00', 2, 'PLATE8888', 18, 'SLOT5');
INSERT INTO Exits VALUES ('2023-01-02 09:15:00', 2, 'PLATE7766', 18, 'SLOT1');
INSERT INTO Exits VALUES ('2023-01-05 22:07:00', 5, 'PLATE4444', 18, 'SLOT1');
INSERT INTO Exits VALUES ('2023-01-05 22:02:00', 5, 'PLATE5555', 15, 'SLOT2');
INSERT INTO Exits VALUES ('2023-01-05 12:02:00', 5, 'PLATE9988', 15, 'SLOT15');
INSERT INTO Exits VALUES ('2023-01-05 12:07:00', 5, 'PLATE3322', 15, 'SLOT1');

-- Occupy Table
INSERT INTO Occupy VALUES ('SLOT01', 15, 'PLATE6789');
INSERT INTO Occupy VALUES ('SLOT02', 58, 'PLATE7890');
INSERT INTO Occupy VALUES ('SLOT03', 27, 'PLATE8901');
INSERT INTO Occupy VALUES ('SLOT04', 51, 'PLATE9012');
INSERT INTO Occupy VALUES ('SLOT05', 32, 'PLATE0123');
INSERT INTO Occupy VALUES ('SLOT06', 43, 'PLATE0500');
INSERT INTO Occupy VALUES ('SLOT07', 18, 'PLATE0600');
INSERT INTO Occupy VALUES ('SLOT08', 29, 'PLATE0700');
INSERT INTO Occupy VALUES ('SLOT09', 27, 'PLATE0800');
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
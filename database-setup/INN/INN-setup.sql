-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Rooms
(
    RoomID VARCHAR(3) PRIMARY KEY,
    RoomName VARCHAR(24),
    Beds int,
    BedType VARCHAR(6),
    MaxOccupancy int,
    BasePrice int,
    Decor VARCHAR(11)
);

CREATE TABLE Reservations
(
    Code int PRIMARY KEY,
    RoomID VARCHAR(3),
    CheckIn VARCHAR(9), -- oracle time so using varchar as temp 
    CheckOut VARCHAR(9),
    Rate DECIMAL(5,2),
    LastName VARCHAR(13),
    FirstName VARCHAR(10),
    Adults int,
    Kids int,
    UNIQUE (Code, LastName, FirstName),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);
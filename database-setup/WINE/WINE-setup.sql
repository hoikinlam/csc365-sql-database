-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Appelations
(
    LineNumber int PRIMARY KEY,
    Appelation VARCHAR(36) UNIQUE,
    County VARCHAR(15),
    State VARCHAR(10),
    Area VARCHAR(20),
    isAVA VARCHAR(3)
);

CREATE TABLE Grapes
(
    GrapeID int PRIMARY KEY,
    GrapeName VARCHAR(19) UNIQUE,
    Color VARCHAR(5)
);

CREATE TABLE Wine
(
    WineID int PRIMARY KEY,
    GrapeName VARCHAR(19),
    WineryName VARCHAR(30),
    Appelation VARCHAR(36),
    State VARCHAR(10),
    Name VARCHAR(49),
    Year int,
    Price int,
    Score int,
    Cases int,
    Drink VARCHAR(4),
    FOREIGN KEY (GrapeName) REFERENCES Grapes(GrapeName),
    FOREIGN KEY (Appelation) REFERENCES Appelations(Appelation)
);
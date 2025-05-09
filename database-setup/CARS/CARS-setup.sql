-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Continents
(
    ContID int PRIMARY KEY,
    ContinentName VARCHAR(9)
);

CREATE TABLE Countries
(
    CountryID int PRIMARY KEY,
    CountryName VARCHAR(11),
    ContinentID int,
    FOREIGN KEY (ContinentID) REFERENCES Continents(ContID)
);

CREATE TABLE Car_Makers
(
    MakerID int PRIMARY KEY,
    Maker VARCHAR(12),
    FullName VARCHAR(22),
    CountryID int,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Model_List
(
    ModelID int PRIMARY KEY,
    MakerID int,
    ModelName VARCHAR(13) UNIQUE,
    FOREIGN KEY (MakerID) REFERENCES Car_Makers(MakerID)
);

CREATE TABLE Car_Names
(
    MakeID int PRIMARY KEY,
    ModelName VARCHAR(13),
    MakeDescription VARCHAR(36),
    FOREIGN KEY (ModelName) REFERENCES Model_List(ModelName)
);

CREATE TABLE Cars_Data
(
    MakeID int PRIMARY KEY,
    MPG DECIMAL(3,1),
    Cylinders int,
    Edispl int,
    Horsepower int,
    Weight int,
    Accelerate DECIMAL(3,1),
    Year int,
    FOREIGN KEY(MakeID) REFERENCES Car_Names(MakeID)
);
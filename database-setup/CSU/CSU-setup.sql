-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Campuses
(
    ID int PRIMARY KEY,
    Campus VARCHAR(55),
    Location VARCHAR(15),
    County VARCHAR(15),
    Year int
);

CREATE TABLE CSU_Fees
(
    CampusID int,
    Year int,
    CampusFee int,
    PRIMARY KEY(CampusID, Year),
    FOREIGN KEY(CampusID) REFERENCES Campuses(ID)
);

CREATE TABLE Degrees
(
    Year int,
    CampusID int,
    Degrees int,
    PRIMARY KEY (CampusID, Year),
    FOREIGN KEY(CampusID) REFERENCES Campuses(ID)
);

CREATE TABLE Disciplines
(
    DisciplineID int PRIMARY KEY,
    Name VARCHAR(27)
);

CREATE TABLE Discipline_Enrollments
(
    CampusID int,
    DisciplineID int,
    Year int,
    Undergraduate int,
    Graduate int,
    PRIMARY KEY (CampusID, DisciplineID),
    FOREIGN KEY(CampusID) REFERENCES Campuses(ID),
    FOREIGN KEY(DisciplineID) REFERENCES Disciplines(DisciplineID)
);

CREATE TABLE Enrollments
(
    CampusID int,
    Year int,
    TotalEnrollment_AY int,
    FTE_AY int,
    PRIMARY KEY (CampusID, Year),
    FOREIGN KEY(CampusID) REFERENCES Campuses(ID)
);

CREATE TABLE Faculty
(
    CampusID int,
    Year int,
    Faculty DECIMAL(5,1),
    PRIMARY KEY (CampusID, Year),
    FOREIGN KEY(CampusID) REFERENCES Campuses(ID)
);
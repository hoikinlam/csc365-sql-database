-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Marathon
(
    Place int,
    Time TIME,
    Pace TIME,
    GroupPlace int,
    ParticipantGroup VARCHAR(5),
    Age int,
    Sex VARCHAR(1),
    BIBNumber int,
    FirstName VARCHAR(10),
    LastName VARCHAR(13),
    Town VARCHAR(15),
    State VARCHAR(2),
    PRIMARY KEY(BIBNumber, FirstName, LastName),
    UNIQUE (Place)
);
-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Airlines
(
    AirlineID int PRIMARY KEY,
    AirlineName VARCHAR(20),
    Abbreviation VARCHAR(11),
    Country VARCHAR(3)
);

CREATE TABLE Airports100
(
    City VARCHAR(17),
    AirportCode VARCHAR(3) PRIMARY KEY,
    AirportName VARCHAR(44),
    Country VARCHAR(14),
    CountryAbbrev VARCHAR(3)
);

CREATE TABLE Flights
(
    AirlineID int,
    FlightNumber int,
    SourceAirport VARCHAR(5),
    DestAirport VARCHAR(5),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
    FOREIGN KEY (SourceAirport) REFERENCES Airports100(AirportCode),
    FOREIGN KEY (DestAirport) REFERENCES Airports100(AirportCode)
);
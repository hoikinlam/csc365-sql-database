-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Albums
(
    AlbumID int PRIMARY KEY,
    Title VARCHAR(37),
    Year int,
    Label VARCHAR(21),
    PerformanceType VARCHAR(6)
);

CREATE TABLE Band
(
    MemberID int PRIMARY KEY,
    FirstName VARCHAR(10),
    LastName VARCHAR(9)
);

CREATE TABLE Songs
(
    SongID int PRIMARY KEY,
    SongTitle VARCHAR(31)
);

CREATE TABLE Instruments
(
    SongID int,
    MemberID int,
    Instrument VARCHAR(14),
    PRIMARY KEY (SongID, MemberID, Instrument),
    FOREIGN KEY (MemberID) REFERENCES Band(MemberID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Performance
(
    SongID int,
    MemberID int,
    StagePosition VARCHAR(6),
    PRIMARY KEY (SongID, MemberID, StagePosition),
    FOREIGN KEY (MemberID) REFERENCES Band(MemberID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Tracklists
(
    AlbumID int,
    Position int,
    SongID int,
    PRIMARY KEY (AlbumID, SongID),
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Vocals
(
    SongID int,
    MemberID int,
    Type VARCHAR(6),
    PRIMARY KEY (SongID, MemberID, Type),
    FOREIGN KEY (MemberID) REFERENCES Band(MemberID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);
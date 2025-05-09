-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT Band.Firstname, COUNT(Band.Id)
FROM Band, Instruments
WHERE Band.Id = Instruments.Bandmate
    AND Band.Id = 1
    AND Instruments.Instrument = 'bass balalaika'
UNION
SELECT Band.Firstname, COUNT(Band.Id)
FROM Band, Instruments
WHERE Band.Id = Instruments.Bandmate
    AND Band.Id = 2
    AND Instruments.Instrument = 'bass balalaika'
UNION
SELECT Band.Firstname, COUNT(Band.Id)
FROM Band, Instruments
WHERE Band.Id = Instruments.Bandmate
    AND Band.Id = 3
    AND Instruments.Instrument = 'bass balalaika'
UNION
SELECT Band.Firstname, COUNT(Band.Id)
FROM Band, Instruments
WHERE Band.Id = Instruments.Bandmate
    AND Band.Id = 4
    AND Instruments.Instrument = 'bass balalaika';

-- Query 2
SELECT COUNT(*)
FROM Band b1, Band b2, Performance, Vocals, Songs
WHERE b1.FirstName = 'Solveig'
    AND b2.FirstName = 'Turid'
    AND b1.Id = Performance.Bandmate
    AND Performance.StagePosition = 'center'
    AND Performance.Song = Songs.SongId
    AND b2.Id = Vocals.Bandmate
    AND Vocals.VocalType = 'lead'
    AND Vocals.Song = Songs.SongId;

-- Query 3
SELECT COUNT(*)
FROM Band, Instruments, Performance, Vocals, Songs
WHERE Band.Firstname = 'Anne-Marit'
    AND Band.Id = Instruments.Bandmate
    AND Instruments.Instrument = 'banjo'
    AND Band.Id = Performance.Bandmate
    AND Performance.StagePosition = 'center'
    AND Band.Id = Vocals.Bandmate
    AND Vocals.VocalType = 'lead'
    AND Instruments.Song = Songs.SongId
    AND Vocals.Song = Songs.SongId
    AND Performance.Song = Songs.SongId;

-- Query 4
SELECT COUNT(DISTINCT Instruments.Instrument)
FROM Band, Instruments, Songs
WHERE Band.Firstname = 'Turid'
    AND Band.Id = Instruments.Bandmate
    AND Instruments.Song = Songs.SongId;

-- Query 5
SELECT DISTINCT Instruments.Instrument
FROM Band, Instruments, Songs
WHERE Band.Firstname = 'Solveig'
    AND Band.Id = Instruments.Bandmate
    AND Instruments.Song = Songs.SongId
INTERSECT
SELECT DISTINCT Instruments.Instrument
FROM Band, Instruments, Songs
WHERE Band.Firstname = 'Turid'
    AND Band.Id = Instruments.Bandmate
    AND Instruments.Song = Songs.SongId
ORDER BY Instrument ASC;

-- Query 6
SELECT GROUP_CONCAT(DISTINCT i1.Instrument SEPARATOR ' or ')
FROM Band b1, Band b2, Instruments i1, Instruments i2, Songs s1, Songs s2
WHERE b1.Firstname = 'Solveig' AND b2.Firstname ='Turid'
    AND b1.Id = i1.Bandmate AND b2.Id = i2.Bandmate
    AND i1.Song = s1.SongId AND i2.Song = s2.SongId
    AND i1.Instrument = i2.Instrument;

-- Query 7
SELECT COUNT(DISTINCT i1.Song) - COUNT(DISTINCT i2.Song)
FROM Instruments i1, Instruments i2, Songs s1, Songs s2
WHERE i1.Song = s1.SongId
    AND i2.Song = s2.SongId
    AND i2.Instrument = 'guitar';

-- Query 8
SELECT COUNT(DISTINCT Songs.SongId)
FROM Band b1, Band b2, Instruments i1, Instruments i2, Songs
WHERE b1.Id = i1.Bandmate
    AND b2.Id = i2.Bandmate
    AND i1.Song = Songs.SongId
    AND i2.Song = Songs.SongId
    AND i1.Instrument = i2.Instrument
    AND b1.Id != b2.Id;
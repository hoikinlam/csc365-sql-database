-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT Band.Firstname, COUNT(Vocals.Song)
FROM Band, Vocals, Songs
WHERE Band.Id = Vocals.Bandmate
    AND Vocals.VocalType = 'lead'
    AND Vocals.Song = Songs.SongId
GROUP BY Band.Firstname
ORDER BY COUNT(Vocals.Song) DESC;

-- Query 2
SELECT Band.Firstname, COUNT(DISTINCT Instruments.Instrument)
FROM Band, Instruments, Songs, Tracklists, Albums
WHERE Band.Id =Instruments.Bandmate
    AND Instruments.Song = Songs.SongId
    AND Songs.SongId = Tracklists.Song
    AND Tracklists.Album = Albums.AId
    AND Albums.Title = 'Rockland'
GROUP BY Band.Firstname
ORDER BY Band.Firstname;

-- Query 3
SELECT Performance.StagePosition, COUNT(Performance.Song)
FROM Band, Performance, Songs
WHERE Band.Firstname = 'Solveig'
    AND Band.Id = Performance.Bandmate
    AND Performance.Song = Songs.SongId
GROUP BY Performance.StagePosition
ORDER BY COUNT(Performance.Song) ASC;

-- Query 4
SELECT b1.Firstname, COUNT(Songs.SongId)
FROM Band b1, Band b2, Instruments, Songs, Performance
WHERE b1.Id = Instruments.Bandmate
    AND b1.Firstname != 'Anne-Marit'
    AND Instruments.Instrument = 'bass balalaika'
    AND Instruments.Song = Songs.SongId
    AND b2.Firstname = 'Anne-Marit'
    AND b2.Id = Performance.Bandmate
    AND Performance.StagePosition = 'left'
    AND Performance.Song = Songs.SongId
GROUP BY b1.Firstname
ORDER BY b1.Firstname ASC;

-- Query 5
SELECT DISTINCT Instruments.Instrument
FROM Instruments, Band, Songs
WHERE Band.Id = Instruments.Bandmate
    AND Instruments.Bandmate = 1
    AND Instruments.Song = Songs.SongId
INTERSECT
SELECT DISTINCT Instruments.Instrument
FROM Instruments, Band, Songs
WHERE Band.Id = Instruments.Bandmate
    AND Instruments.Bandmate = 2
    AND Instruments.Song = Songs.SongId
INTERSECT
SELECT DISTINCT Instruments.Instrument
FROM Instruments, Band, Songs
WHERE Band.Id = Instruments.Bandmate
    AND Instruments.Bandmate = 3
    AND Instruments.Song = Songs.SongId
INTERSECT
SELECT DISTINCT Instruments.Instrument
FROM Instruments, Band, Songs
WHERE Band.Id = Instruments.Bandmate
    AND Instruments.Bandmate = 4
    AND Instruments.Song = Songs.SongId
ORDER BY Instrument ASC;

-- Query 6
SELECT Band.Firstname, COUNT(DISTINCT i1.Song)
FROM Band, Instruments i1, Instruments i2, Songs
WHERE Band.Id = i1.Bandmate
    AND i1.Song = Songs.SongId
    AND Band.Id = i2.Bandmate
    AND i2.Song = Songs.SongId
    AND i1.Song = i2.Song
    AND i1.Instrument != i2.Instrument
GROUP BY Band.Firstname
HAVING COUNT(DISTINCT i1.Instrument) > 1
ORDER BY Band.Firstname ASC;
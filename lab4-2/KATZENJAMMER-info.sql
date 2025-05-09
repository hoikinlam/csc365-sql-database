-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT Songs.Title
FROM Tracklists, Albums, Songs
WHERE Tracklists.Album = Albums.AId
    AND Albums.Title = 'Le Pop'
    AND Tracklists.Song = Songs.SongId
ORDER BY Tracklists.Position ASC;

-- Query 2
SELECT Band.Firstname, Instruments.Instrument
FROM Instruments, Songs, Band
WHERE Songs.SongId = Instruments.Song
    AND Songs.Title = 'Cherry Pie'
    AND Instruments.Bandmate = Band.Id
ORDER BY Band.Firstname ASC, Instruments.Instrument ASC;

-- Query 3
SELECT DISTINCT Instruments.Instrument
FROM Band, Instruments
WHERE Band.Firstname = 'Turid'
    AND Band.Id = Instruments.Bandmate
ORDER BY Instruments.Instrument ASC;

-- Query 4
SELECT Songs.Title, Band.Firstname
FROM Instruments, Songs, Band
WHERE Instruments.Instrument = 'toy piano'
    AND Instruments.Song = Songs.SongId
    AND Instruments.Bandmate = Band.Id
ORDER BY Songs.Title ASC, Band.Firstname ASC;

-- Query 5
SELECT DISTINCT Instruments.Instrument
FROM Band, Instruments, Songs, Vocals
WHERE Band.Firstname = 'Turid'
    AND Band.Id = Instruments.Bandmate
    AND Instruments.Song = Songs.SongId
    AND Vocals.Bandmate = Band.Id
    AND Vocals.Song = Songs.SongId
    AND Vocals.VocalType = 'lead'
ORDER BY Instruments.Instrument ASC;

-- Query 6
SELECT DISTINCT Songs.Title, Band.Firstname, Performance.StagePosition
FROM Vocals, Band, Songs, Performance
WHERE Vocals.Bandmate = Band.Id
    AND Vocals.VocalType = 'lead'
    AND Vocals.Song = Songs.SongId
    AND Performance.Bandmate = Band.Id
    AND Performance.Song = Songs.SongId
    AND Performance.StagePosition != 'center'
ORDER BY Songs.Title ASC;

-- Query 7
SELECT DISTINCT s1.Title
FROM Band, Instruments i1, Instruments i2, Songs s1, Songs s2
WHERE Band.Firstname = 'Anne-Marit'
    AND Band.Id = i1.Bandmate AND Band.Id = i2.Bandmate
    AND s1.SongId = i1.Song AND s2.SongId = i2.Song
    AND i1.Song = i2.Song
    AND i1.Instrument != i2.Instrument;

-- Query 8
SELECT DISTINCT b1.Firstname AS `RIGHT`, b2.Firstname AS CENTER, b3.Firstname AS BACK, b4.Firstname AS `LEFT`
FROM Songs, Performance p1, Performance p2, Performance p3, Performance p4, Band b1, Band b2, Band b3, Band b4
WHERE Songs.Title = 'Johnny Blowtorch'
    AND Songs.SongId = p1.Song AND Songs.SongId = p2.Song AND Songs.SongId = p3.Song AND Songs.SongId = p4.Song
    AND p1.Bandmate = b1.Id AND p2.Bandmate = b2.Id AND p3.Bandmate = b3.Id AND p4.Bandmate = b4.Id
    AND p1.Stageposition = 'right'
    AND p2.Stageposition = 'center'
    AND p3.Stageposition = 'back'
    AND p4.Stageposition = 'left'
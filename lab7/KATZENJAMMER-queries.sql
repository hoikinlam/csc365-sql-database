-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT Band.Firstname
FROM Band
EXCEPT
SELECT DISTINCT Band.Firstname
FROM Band, Instruments
WHERE Band.Id = Instruments.Bandmate
    AND Instruments.Instrument = 'accordion';

-- Query 2
SELECT Title
FROM Songs
WHERE SongId = 
    (SELECT SongId
    FROM Songs
    EXCEPT
    SELECT DISTINCT Song
    FROM Vocals);

-- Query 3
SELECT Title
FROM Songs
WHERE SongId = 
    (SELECT Song
    FROM
        (SELECT Song, COUNT(Instrument) AS count
        FROM Instruments
        GROUP BY Song) Q
    WHERE count = (SELECT MAX(count) FROM 
        (SELECT Song, COUNT(Instrument) AS count
        FROM Instruments
        GROUP BY Song) X)
    );

-- Query 4
WITH PlayCount AS(
    SELECT Instrument, Bandmate, COUNT(Song) AS count
    FROM Instruments
    GROUP BY Instrument, Bandmate
),
MostPlayed AS(
    SELECT Bandmate, MAX(count) AS count
    FROM PlayCount
    GROUP BY Bandmate
),
FINAL AS(
    SELECT PlayCount.Bandmate, PlayCount.count, PlayCount.Instrument
    FROM PlayCount, MostPlayed
    WHERE PlayCount.Bandmate = MostPlayed.Bandmate
        AND PlayCount.count = MostPlayed.count
)
SELECT Band.Firstname, FINAL.Instrument, FINAL.count AS num
FROM FINAL, Band
WHERE FINAL.Bandmate = Band.Id
ORDER BY Band.Firstname, FINAL.Instrument;

-- Query 5
SELECT Instruments.Instrument
FROM Instruments, Band
WHERE Band.Id = Instruments.Bandmate
    AND Band.Firstname = 'Anne-Marit'
GROUP BY Instruments.Instrument
EXCEPT
SELECT Instruments.Instrument
FROM Instruments, Band
WHERE Band.Id = Instruments.Bandmate
    AND Band.Firstname != 'Anne-Marit'
GROUP BY Instruments.Instrument;

-- Query 6
WITH CountInstrument AS(
    SELECT Bandmate, COUNT(DISTINCT Instrument) AS count
    FROM Instruments
    GROUP BY Bandmate
),
MostPlayed AS(
    SELECT MAX(count) AS count
    FROM CountInstrument
)
SELECT Band.Firstname
FROM CountInstrument, MostPlayed, Band
WHERE CountInstrument.count = MostPlayed.count
    AND CountInstrument.Bandmate = Band.Id;

-- Query 7
WITH AlbumSongs AS (
    SELECT Song, Position
    FROM Albums, Tracklists
    WHERE Albums.Title = 'Le Pop'
      AND Albums.AId = Tracklists.Album
    GROUP BY Song, Position
)
SELECT Songs.Title, Band.Firstname
FROM AlbumSongs
LEFT JOIN Vocals ON AlbumSongs.Song = Vocals.Song AND Vocals.VocalType = 'lead'
LEFT JOIN Band ON Band.Id = Vocals.Bandmate
JOIN Songs ON Songs.SongId = AlbumSongs.Song
ORDER BY AlbumSongs.Position;

-- Query 8
WITH SongPerInstrument AS(
    SELECT Instrument, COUNT(Song) AS count
    FROM Instruments
    GROUP BY Instrument
),
MaxSong AS(
    SELECT MAX(count) AS count
    FROM SongPerInstrument
)
SELECT SongPerInstrument.Instrument
FROM SongPerInstrument, MaxSong
WHERE SongPerInstrument.count = MaxSong.count;
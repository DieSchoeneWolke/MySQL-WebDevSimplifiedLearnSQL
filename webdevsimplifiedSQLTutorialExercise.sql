-- https://github.com/WebDevSimplified/Learn-SQL
-- DROP DATABASE song_list;
-- DROP TABLE songs;

CREATE DATABASE song_list;
USE song_list;

CREATE TABLE bands (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE albums (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (band_id)
        REFERENCES bands (id)
);

CREATE TABLE songs (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id)
        REFERENCES albums (id)
);

SELECT 
    name AS 'Band Name'
FROM
    bands;

SELECT 
    *
FROM
    albums
WHERE
    release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

SELECT 
    b.name AS 'Band Name'
FROM
    bands AS b
        JOIN
    albums AS a ON b.id = a.band_id
WHERE
    a.band_id IS NOT NULL;

SELECT 
    b.name AS 'Band Name', COUNT(a.id) AS num_albums
FROM
    bands AS b
        LEFT JOIN
    albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 0;

SELECT 
    albums.name AS 'Name',
    albums.release_year AS 'Release Year',
    SUM(songs.length) AS 'Duration'
FROM
    albums
        JOIN
    songs ON albums.id = songs.album_id
GROUP BY albums.id , albums.name , albums.release_year
ORDER BY SUM(songs.length) DESC
LIMIT 1;

UPDATE albums 
SET 
    release_year = 1986
WHERE
    id = 4;

INSERT INTO bands(id,name) VALUES (8,'eam Theater');
INSERT INTO albums(id,name,release_year,band_id) VALUES (19,'Tibe f Force',2010,8);

DELETE FROM albums 
WHERE
    id = 19;

DELETE FROM bands 
WHERE
    bands.id = 8;

SELECT 
    AVG(songs.length) AS 'Average Song Duration'
FROM
    songs;

SELECT 
    albums.name AS 'Album',
    albums.release_year AS 'Release Year',
    MAX(songs.length) AS 'Duration'
FROM
    albums
        JOIN
    songs ON albums.id = songs.album_id
GROUP BY songs.album_id;

SELECT 
    bands.name AS 'Band', COUNT(songs.id) AS 'Number of Songs'
FROM
    bands
        JOIN
    albums ON bands.id = albums.band_id
        JOIN
    songs ON albums.id = songs.album_id
GROUP BY albums.band_id;

-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE producers
(
  id SERIAL PRIMARY KEY,
  producer TEXT NOT NULL
);

CREATE TABLE artists
(
  id SERIAL PRIMARY KEY,
  artist TEXT NOT NULL
);

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY,
  album TEXT NOT NULL
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  album_id INTEGER REFERENCES albums(id) NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL
);

CREATE TABLE producers_songs
(
  id SERIAL PRIMARY KEY,
  producer_id INTEGER REFERENCES producers(id) NOT NULL,
  song_id INTEGER REFERENCES songs(id) NOT NULL
);

CREATE TABLE artists_songs
(
  id SERIAL PRIMARY KEY,
  artist_id INTEGER REFERENCES artists(id) NOT NULL,
  song_id INTEGER REFERENCES songs(id) NOT NULL
);

INSERT INTO producers
  (producer)
VALUES
  ('Dust Brothers'),
  ('Stephen Lironi'),
  ('Roy Thomas Baker'),
  ('Walter Afanasieff'),
  ('Benjamin Rice'),
  ('Rick Parashar'),
  ('Al Shux'),
  ('Max Martin'),
  ('Cirkut'),
  ('Shellback'),
  ('Benny Blanco'),
  ('The Matrix'),
  ('Darkchild');
  
SELECT * FROM producers;

INSERT INTO artists
  (artist)
VALUES
  ('Hanson'),
  ('Queen'),
  ('Mariah Cary'),
  ('Boyz II Men'),
  ('Lady Gaga'),
  ('Bradley Cooper'),
  ('Nickelback'),
  ('Jay Z'),
  ('Alicia Keys'),
  ('Katy Perry'),
  ('Juicy J'),
  ('Maroon 5'),
  ('Christina Aguilera'),
  ('Avril Lavigne'),
  ('Destiny''s Child');

SELECT * FROM artists;

INSERT INTO albums
  (album)
VALUES
  ('Middle of Nowhere'),
  ('A Night at the Opera'),
  ('Daydream'),
  ('A Star Is Born'),
  ('Silver Side Up'),
  ('The Blueprint 3'),
  ('Prism'),
  ('Hands All Over'),
  ('Let Go'),
  ('The Writing''s on the Wall');

SELECT * FROM albums;

INSERT INTO songs
  (title, album_id,duration_in_seconds, release_date)
VALUES
  ('MMMBop',1, 238,'1997-04-15'),
  ('Bohemian Rhapsody',2, 355,'1975-10-31'),
  ('One Sweet Day',3, 282,'1995-11-14'),
  ('Shallow',4, 216,'2018-09-27'),
  ('How You Remind Me',5, 223,'2001-08-21'),
  ('New York State of Mind',6, 276,'2009-10-20'),
  ('Dark Horse',7, 215, '12-17-2013'),
  ('Moves Like Jagger',8, 201, '06-21-2011'),
  ('Complicated',9, 244, '05-14-2002'),
  ('Say My Name',10, 240, '11-07-1999');


INSERT INTO producers_songs
  (producer_id,song_id)
VALUES
  (1,1),
  (2,1),
  (3,2),
  (4,3),
  (5,4),
  (6,5),
  (7,6),
  (8,7),
  (9,7),
  (10,8),
  (11,8),
  (12,9),
  (13,10);

INSERT INTO artists_songs
  (artist_id,song_id)
VALUES
  (1,1),
  (2,2),
  (3,3),
  (4,3),
  (5,4),
  (6,4),
  (7,5),
  (8,6),
  (9,6),
  (10,7),
  (11,7),
  (12,8),
  (13,8),
  (14,9),
  (15,10);

  SELECT songs.title, artists.artist, albums.album, producers.producer FROM songs
  JOIN albums ON songs.album_id = albums.id
  JOIN artists_songs ON songs.id = artists_songs.song_id
  JOIN artists ON artists_songs.artist_id = artists.id
  JOIN producers_songs ON songs.id = producers_songs.song_id
  JOIN producers ON producers_songs.producer_id = producers.id
  ORDER BY songs.title, artists.artist, albums.album, producers.producer;

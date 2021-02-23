-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE stars
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  galaxy_id INTEGER REFERENCES galaxies(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  star_id INTEGER REFERENCES stars(id) ON DELETE CASCADE NOT NULL,
  moons TEXT[]
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  planet_id INTEGER REFERENCES planets(id) ON DELETE CASCADE NOT NULL
);

INSERT INTO galaxies
  (name)
VALUES
  ('Milky Way');

INSERT INTO stars
  (name,galaxy_id)
VALUES
  ('The Sun',1),
  ('Proxima Centauri',1),
  ('Gliese 876',1);


INSERT INTO planets
  (name, orbital_period_in_years, star_id)
VALUES
  ('Earth', 1.00, 1),
  ('Mars', 1.88, 1),
  ('Venus', 0.62, 1),
  ('Neptune', 164.8, 1),
  ('Proxima Centauri b', 0.03, 2),
  ('Gliese 876 b', 0.23, 3);

INSERT INTO moons
  (name,planet_id)
VALUES
  ('The Moon',1),
  ('Phobos',2),
  ('Deimos',2),
  ('Naiad',3),
  ('Thalassa',3),
  ('Despina',3),
  ('Galatea',3),
  ('Larissa',3),
  ('S/2004 N 1',3),
  ('Proteus',3),
  ('Triton',3),
  ('Nereid',3),
  ('Halimede',3),
  ('Sao',3),
  ('Laomedeia',3),
  ('Psamathe',3),
  ('Neso',3);


-- moon information
SELECT m.name,p.name,s.name,g.name FROM moons m
JOIN planets p ON m.planet_id = p.id
JOIN stars s ON p.star_id = s.id
JOIN galaxies g ON s.galaxy_id = g.id;

-- number of moons per planet
SELECT p.name,COUNT(m.planet_id) AS moon_count FROM moons m
RIGHT JOIN planets p ON m.planet_id = p.id
GROUP BY p.name
ORDER BY moon_count DESC,p.name ASC;
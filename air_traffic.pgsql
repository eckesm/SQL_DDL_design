-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE countries
(
  id SERIAL PRIMARY KEY,
  country TEXT UNIQUE NOT NULL
);

CREATE TABLE cities
(
  id SERIAL PRIMARY KEY,
  city TEXT UNIQUE NOT NULL,
  country_id INTEGER REFERENCES countries(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  airline TEXT UNIQUE NOT NULL
);

CREATE TABLE flights
(
  id SERIAL PRIMARY KEY,
  airline_id INTEGER REFERENCES airlines(id) ON DELETE CASCADE NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  from_city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE NOT NULL,
  to_city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE passengers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  passenger_id INTEGER REFERENCES passengers(id) NOT NULL,
  flight_id INTEGER REFERENCES flights(id) ON DELETE CASCADE NOT NULL,
  seat TEXT NOT NULL
);

INSERT INTO countries (country)
VALUES
('United States'),
('United Kingdom'),
('Mexico'),
('Morocco'),
('China'),
('Chile'),
('Japan'),
('France'),
('UAE'),
('Brazil');

INSERT INTO cities (city,country_id)
VALUES
('Seattle',1),
('London',2),
('Las Vegas',1),
('Mexico City',3),
('Casablanca',4),
('Beijing',5),
('Charlotte',1),
('Chicago',1),
('New Orleans',1),
('Santiago',6),
('Washington DC',1),
('Tokyo',7),
('Los Angeles',1),
('Paris',8),
('Dubai',9),
('New York',1),
('Cedar Rapids',1),
('Sao Paolo',10);

SELECT cities.id,cities.city,countries.country FROM cities
JOIN countries ON cities.country_id=countries.id
ORDER BY cities.city ASC;

INSERT INTO airlines (airline)
VALUES
('United'),
('British Airways'),
('Delta'),
('TUI Fly Belgium'),
('Air China'),
('American Airlines'),
('Avianca Brasil');

SELECT * FROM airlines
ORDER BY airline;

INSERT INTO passengers (first_name, last_name)
VALUES
('Jennifer','Finch'),
('Thadeus','Gathercoal'),
('Sonja','Pauley'),
('Waneta','Skeleton'),
('Berkie','Wycliff'),
('Alvin','Leathes'),
('Cory','Squibbes');

SELECT * FROM passengers;


INSERT INTO flights (airline_id,departure,arrival,from_city_id,to_city_id)
VALUES
(1,'2018-04-08 09:00:00','2018-04-08 12:00:00',11,1),
(2,'2018-12-19 12:45:00','2018-12-19 16:15:00',12,2),
(3,'2018-01-02 07:00:00','2018-01-02 08:03:00',13,3),
(3,'2018-04-15 16:50:00','2018-04-15 21:00:00',1,4),
(4,'2018-08-01 18:30:00','2018-08-01 21:50:00',14,5),
(5,'2018-10-31 01:15:00','2018-10-31 12:55:00',15,6),
(1,'2019-02-06 06:00:00','2019-02-06 07:47:00',16,7),
(6,'2018-12-22 14:42:00','2018-12-22 15:56:00',17,8),
(6,'2019-02-06 16:28:00','2019-02-06 19:18:0',7,9),
(7,'2019-01-20 19:30:00','2019-01-20 22:45:00',18,10);

-- SELECT a.airlines,f.departure,f.arrival,cities.city,

INSERT INTO tickets
  (passenger_id,flight_id, seat)
VALUES
  (1,1,'33B'),
  (2,2,'8A'),
  (3,3,'12F'),
  (1,4,'20A'),
  (4,5,'23D'),
  (2,6,'18C'),
  (5,7,'9E'),
  (6,8,'1A'),
  (5,9,'32B'),
  (7,10,'10D');

-- departures
SELECT p.last_name, t.seat, a.airline, cities.city,countries.country, f.departure FROM tickets t
JOIN passengers p ON t.passenger_id = p.id
JOIN flights f ON t.flight_id = f.id
JOIN airlines a ON f.airline_id = a.id
JOIN cities ON f.from_city_id = cities.id
JOIN countries ON cities.country_id = countries.id;

-- arrivals
SELECT p.last_name, t.seat, a.airline, cities.city,countries.country,f.arrival FROM tickets t
JOIN passengers p ON t.passenger_id = p.id
JOIN flights f ON t.flight_id = f.id
JOIN airlines a ON f.airline_id = a.id
JOIN cities ON f.to_city_id = cities.id
JOIN countries ON cities.country_id = countries.id;


-- How to make depature and arrival cities/countries show up on the same board if they can only be joined on one ID?
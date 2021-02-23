DROP DATABASE craigslist_db;
CREATE DATABASE craigslist_db;

\c craigslist_db;

CREATE TABLE regions
(
    id SERIAL PRIMARY KEY,
    region VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE categories
(
    id SERIAL PRIMARY KEY,
    category VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    pref_region_id INTEGER REFERENCES regions(id) NOT NULL
);

CREATE TABLE posts
(
    id SERIAL PRIMARY KEY,
    owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    price DECIMAL NOT NULL,
    category_id INTEGER REFERENCES categories(id) NOT NULL,
    location VARCHAR(50) NOT NULL,
    region_id INTEGER REFERENCES regions(id) NOT NULL
);

INSERT INTO regions (region)
VALUES
('Kansas City'),
('Miami'),
('New York City'),
('Seattle');

INSERT INTO categories (category)
VALUES
('Books'),
('Furniture'),
('Plants'),
('Televisions');

INSERT INTO users (email,name,pref_region_id)
VALUES
('bill@microsoft.com',NULL, 4),
('johanna@gmail.com','Johanna Weiss', 3),
('melissa@gmail.com','Melissa Waterstone',2),
('deep@gmail.com','Deep Bhatt', 3),
('audrey@gmail.com','Audrey Schwabe', 1), 
('brett@gmail.com','Brett Ehrmann',4);

INSERT INTO posts (owner_id,title,text,price,category_id,location,region_id)
VALUES
(5,'Monsterous Monstera for Money','Please buy my Monstea plant--I am moving and cannot take it with me!',19.99,3,'South Florida',2),
(1,'Couch for sale','It''s not clean, but it is free!',0,2,'Microsoft Headquarters',4);

SELECT * FROM users;
SELECT * FROM posts;

SELECT u.email,p.title,p.text,p.price,r.region,c.category FROM posts p
JOIN categories c ON p.category_id = c.id
JOIN users u ON p.owner_id = u.id
JOIN regions r ON p.region_id = r.id;

DELETE FROM users
WHERE id = 5;

SELECT * FROM posts;

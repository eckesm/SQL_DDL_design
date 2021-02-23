DROP DATABASE soccer_league_db;
CREATE DATABASE soccer_league_db;

\c soccer_league_db;

CREATE TABLE teams
(
    id SERIAL PRIMARY KEY,
    team VARCHAR(50) UNIQUE NOT NULL
    
);

CREATE TABLE players
(
    id SERIAL PRIMARY KEY,
    player VARCHAR(50) NOT NULL,
    team_id INTEGER REFERENCES teams(id) NOT NULL
    
);

CREATE TABLE games
(
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    winning_team_id INTEGER REFERENCES teams(id) NOT NULL
    
);

CREATE TABLE goals
(
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players(id) NOT NULL,
    game_id INTEGER REFERENCES games(id) NOT NULL
    
);

CREATE TABLE matchups
(
    id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES games(id) NOT NULL,
    team_id INTEGER REFERENCES teams(id) NOT NULL
    
);

CREATE TABLE referees
(
    id SERIAL PRIMARY KEY,
    referee VARCHAR(50) NOT NULL
    
);


CREATE TABLE games_referees
(
    id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES games(id) NOT NULL,
    referee_id INTEGER REFERENCES referees(id) NOT NULL
);


INSERT INTO teams (team)
VALUES
('Team 1'),
('Team 2'),
('Team 3'),
('Team 4');
SELECT * FROM teams;

INSERT INTO players (player, team_id)
VALUES
('Player 1',1),
('Player 2',2),
('Player 3',3),
('Player 4',4),
('Player 5',1),
('Player 6',2),
('Player 7',3),
('Player 8',4),
('Player 9',1),
('Player 10',2),
('Player 11',3),
('Player 12',4);
SELECT * FROM players;

INSERT INTO referees (referee)
VALUES
('Referee 1'),
('Referee 2'),
('Referee 3');
SELECT * FROM referees;

INSERT INTO games (date,winning_team_id)
VALUES
('2021-01-01',3),
('2021-01-02',4),
('2021-01-03',3),
('2021-01-04',2),
('2021-01-05',2),
('2021-01-06',3);
SELECT * FROM games;

INSERT INTO matchups (game_id,team_id)
VALUES
(1,3),
(1,1),
(2,4),
(2,2),
(3,3),
(3,4),
(4,2),
(4,1),
(5,2),
(5,4),
(6,3),
(6,1);
SELECT * FROM matchups;

INSERT INTO goals (player_id,game_id)
VALUES
(3,1),
(7,1),
(12,2),
(11,3),
(11,3),
(12,3),
(10,4),
(2,5),
(2,5),
(2,5),
(11,6);
SELECT * FROM goals;

INSERT INTO games_referees (game_id,referee_id)
VALUES
(1,1),
(1,2),
(2,3),
(2,1),
(3,2),
(3,3),
(4,1),
(4,2),
(5,3),
(5,1),
(6,2),
(6,3);
SELECT * FROM games_referees;

-- goals by player in each game
SELECT goals.game_id,players.player, COUNT(*) FROM goals
JOIN players ON  goals.player_id = players.id
JOIN games ON goals.game_id = games.id
GROUP BY goals.game_id,players.player
ORDER BY goals.game_id,players.player;

-- standings
SELECT teams.team,COUNT(games.winning_team_id) AS wins FROM games
RIGHT JOIN teams ON games.winning_team_id = teams.id
GROUP BY teams.team
ORDER BY COUNT(*) DESC;
-- Use this template for your se2222 term project
-- Before submission be sure that your file is named like [your_ID].sql
-- Name: Esra Alın
-- ID: 18070006017
-- Short description of your scenario: Twitch is a live-streaming platform for gamers that supports building communities around a 
-- shared and streamable interest. There is a streamers that broadcast their gameplay or
-- activity by sharing their screen with fans and subscribers who can hear and watch them live.there is tables such as streamers, subscribers, users, communities,
-- moderators, games, tournaments, channels, sponsors and teams.I have tried to create a database system for live-streaming platform.

-- (Minus 5 of total points if not included)

-- 1. Create and use a schema for your project named SE2222_[your_ID]
CREATE SCHEMA SE2222_18070006017;
USE SE2222_18070006017;
-- 1. Definitions:
-- (15 points)
-- All table definitions of your project including any constraints
-- Before each table creation give a short explanation of the table

-- STREAMERS: Streamers plays games on their channels.Username and mailAddress(unique) can obviously identify a streamer. Also, they must have a password
-- and they may add a short biography if they want. Their earnings represent the total gained money that they get from external sources.
CREATE TABLE STREAMER( 
   username varchar(10) PRIMARY KEY,
   mailAddress varchar(30) UNIQUE KEY,
   biography varchar(255),
   passwords varchar(10) NOT NULL,
   earning double

);

-- USERS: Users can use this platform freely. Our primary keys are the same. They have wallet for donating to streamers if they want.
CREATE TABLE USERS(
   username varchar(10) PRIMARY KEY,
   mailAddress varchar(30) UNIQUE KEY,
   wallet double,
   passwords varchar(10) NOT NULL
);

-- SUBSCRIBERS: The subscribing system is a kind of paid version of Twitch. Users pay for streamers to subscribe their channel. 
-- Duration of one subscription is 30 day. Also, they may donate to streamers. For both of them, they use their wallets.
CREATE TABLE SUBSCRIBER(
  username varchar(10) PRIMARY KEY,
  mailAddress varchar(30) UNIQUE KEY,
  wallet double,
  subTime INT,
  passwords varchar(30) NOT NULL
);




-- COMMUNITY: Small discussion platforms made up of users and subscribers.Guideline includes some rules that protect
-- standards of community. 
CREATE TABLE COMMUNITY(
  comName varchar(20),
  member INT,
  guideline varchar(255)
);


-- MODERATOR: . They can block the users who do not follow the rules in the live. They are helpers of streamer.
CREATE TABLE MODERATOR(
   username varchar(10) PRIMARY KEY,
   mailAddress varchar(30) UNIQUE KEY,
   passwords varchar(10) NOT NULL
);


-- GAME: This interface includes the lives of streamers according to the game that they play. Games may a type like horror, strategy..
-- Viewer represent the number of audience. GNAME  identifies each game.
CREATE TABLE GAME(
  gname varchar(20) PRIMARY KEY,
  gtype varchar(20),
  viewer double
);


-- TOURNAMENT: tournaments include teams and teams consist of players (streamers). After tournaments, it has a winner which is leader team.
-- tname = tournament name
CREATE TABLE TOURNAMENT(
  tname varchar(50) PRIMARY KEY, 
  teamName varchar(50) UNIQUE KEY,
  viewer double,
  leaderTeam varchar(50)
);


-- CHANNELS: Streamers use their own channels to make broadcast. Each channel has a identifier name.Also, it has rules in guideline.
-- subCount stores the number of subscribers. donateBar stores the total earned money from donations.
CREATE TABLE CHANNELS(
  chName varchar(20) PRIMARY KEY,
  guideline varchar(255),
  viewer double,
  subCount double,
  donateBar double
);


-- SPONSOR: There is an companies that supports streamers to advertise their products. 
-- Payment is fee paid to steamer.
CREATE TABLE SPONSOR(
   companyName varchar(50) PRIMARY KEY,
   payment double
);

-- TEAM: Teams are part of tournaments who plays games in Twitch. Each teams have members which made up of streamers.
-- Capacity holds the number of members.
CREATE TABLE TEAM(
  teamName varchar(50) PRIMARY KEY,
  capacity INT
);


-- Ex:
-- A1 table holds A values
CREATE TABLE A1(
A INT PRIMARY KEY);
-- 2. Insertions(Data manipulation):
-- (15 points)
-- For each table, add enough number of rows to make your queries in step three to produce meaningful result sets.

INSERT INTO STREAMER VALUES('ELRAENN','elraen@gmail.com','Hello, I am 27 years old.','5556x',2000);
INSERT INTO STREAMER VALUES('WTCN','wtcn@gmail.com','Hello, I am 25 years old.','4447y',2500);
INSERT INTO STREAMER VALUES('ELWIND','elwind@gmail.com','Hello, I am 22 years old.','7778a',1600);


INSERT INTO USERS VALUES('aligunay1','aligunay@gmail.com',200,'12345a');
INSERT INTO USERS VALUES('denizakk','denizak@gmail.com',NULL,'123567bb');
INSERT INTO USERS VALUES('berilserg','berilsergun@gmail.com',500,'123899c');

INSERT INTO SUBSCRIBER VALUES('efecaykan','efec@gmail.com',50,15,'5557v');
INSERT INTO SUBSCRIBER VALUES('selintan','selintan@gmail.com',60,28,'8956c');

INSERT INTO COMMUNITY VALUES('Powerful girls',587,'You cannot use swearing.');
INSERT INTO COMMUNITY VALUES('LoL Gamers',744,'You cannot use swearing.');

INSERT INTO MODERATOR VALUES('canguney22','canguney@gmail.com','01222a');
INSERT INTO MODERATOR VALUES('demirgurl','demir11@gmail.com','p15468');

INSERT INTO GAME VALUES('League of Legends','Strategy',12556);
INSERT INTO GAME VALUES('Outlast','Horror',5699);
INSERT INTO GAME VALUES('Counter Strike','War',17779);

INSERT INTO TOURNAMENT VALUES('Riot Games LoL Tournament', 'SSK',800,'SSK');
INSERT INTO TOURNAMENT VALUES('CS WINNER', 'FB',800,'FB');

INSERT INTO CHANNELS VALUES('ELRAENN','Do not flood',8922,150,2600);
INSERT INTO CHANNELS VALUES('WTCN',NULL,5569,100,1556);
INSERT INTO CHANNELS VALUES('ELWIND',NULL,2004,85,1030);


INSERT INTO SPONSOR VALUES('Master PC',8000);
INSERT INTO SPONSOR VALUES('PEPSI',5500);

INSERT INTO TEAM VALUES('SSK',5);
INSERT INTO TEAM VALUES('FB',5);
INSERT INTO TEAM VALUES('GS',5);
INSERT INTO TEAM VALUES('DP',5);




-- Ex:
INSERT INTO A1(A) VALUES(1);
-- 3. Queries:
-- (15 points)
-- Write 5 queries with explanations 
-- Write 5 queries. Your queries should do a task that is meaningful in your selected context (project topic). 
-- At least one that joins two or more tables
-- At least one that include group functions
-- At least one with one or more sub-query(es)
-- At least one update
-- At least one delete
-- At least one include arithmetic functions
-- At least one uses alias

-- Finding total earned money from subscribers then listing with the name of streamer.(earns 5 dollars from one subscriber.)
SELECT  s.username "StreamerName", (c.subCount)*5 "EARNBYSUB" from CHANNELS c, STREAMER s where c.chName = s.username;

-- Deleting teams that are not participate in the tournaments.
DELETE from TEAM where teamName NOT IN (SELECT teamName from TOURNAMENT);
-- To see the result, execute this: SELECT teamName from TEAM;


-- Updating biography of streamers for indicating that he is a junior broadcaster if he's earning less than average donateBar value.
UPDATE STREAMER SET biography = 'A Junior BroadCaster' where earning < (SELECT AVG(donateBar) from CHANNELS);




-- Ex:
-- Finding all records in A1 table
SELECT * FROM A1;
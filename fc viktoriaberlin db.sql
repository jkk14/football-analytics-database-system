-- FOOTBALL CLUB DATABASE --
-- FC Viktoria Berlin Analytics System --



# Creating Player Table

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(100),
    Nationality VARCHAR(50),
    Position VARCHAR(50),
    MarketValue DECIMAL(10,2)
);

# Insering Sample Player Data

INSERT INTO Players VALUES
(1, 'Georgious Labroussis', 'Germany', 'Midfielder', 450000.00),
(2, 'Connolly', 'USA', 'Defender', 380000.00),
(3, 'Mark-Oliver Witteck', 'England', 'Forward', 620000.00),
(4, 'Jesse Kumah', 'Ghana', 'Midfielder', 500000.00),
(5, 'Aboudoul-Rachid Tchadjei', 'Germany', 'Forward', 700000.00);

# Creating Matches Table 

CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    Opponent VARCHAR(100),
    MatchDate DATE,
    Competition VARCHAR(100),
    Result VARCHAR(20)
);

# Inserting Sample Match data
INSERT INTO Matches VALUES
(101, 'Tasmania Berlin', '2026-02-11', 'Oberliga NOFV Nord', '2-1 Win'),
(102, 'Lichtenberg 47', '2026-02-18', 'Oberliga NOFV Nord', '1-1 Draw'),
(103, 'H. Rostock II U23', '2026-02-25', 'Oberliga NOFV Nord', '3-0 Win'),
(104, 'Neustrelitz', '2026-03-03', 'Oberliga NOFV Nord', '0-2 Loss'),
(105, 'Makkabi Berlin', '2026-03-10', 'Oberliga NOFV Nord', '2-0 Win');

# Creating Player Statistics Table 

CREATE TABLE PlayerStats (
PlayerID INT,
    MatchID INT,
    Goals INT,
    Assists INT,
    PassesCompleted INT,
    
    PRIMARY KEY (PlayerID, MatchID),

    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

# Inserting Sample PlayerStats data

INSERT INTO PlayerStats VALUES
(1, 101, 0, 1, 67),
(2, 101, 0, 0, 54),
(3, 101, 1, 0, 28),
(4, 101, 1, 1, 73),
(5, 101, 0, 0, 25),

(1, 102, 0, 0, 71),
(2, 102, 0, 0, 49),
(3, 102, 1, 0, 30),
(4, 102, 0, 1, 75),
(5, 102, 0, 0, 22),

(1, 103, 1, 0, 69),
(2, 103, 0, 0, 58),
(3, 103, 1, 1, 31),
(4, 103, 0, 2, 80),
(5, 103, 1, 0, 27);



# Creating Injuries table 

CREATE TABLE Injuries (
InjuryID INT PRIMARY KEY,
PlayerID INT,
InjuryDiagnosis VARCHAR(100),
RecoveryWeeks INT,
InjuryStatus VARCHAR(50),

   FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

# Inserting sample injuries data
INSERT INTO Injuries VALUES
(1, 2, 'Hamstring Injury', 4, 'Recovering'),
(2, 5, 'Ankle Sprain', 2, 'Fit Soon');

# Creating Transfer Target Table 

CREATE TABLE TransferTargets (
    TargetID INT PRIMARY KEY,
    PlayerName VARCHAR(100),
    CurrentClub VARCHAR(100),
    Position VARCHAR(50),
    ScoutRating INT
);

# inserting sample transfer target data 

INSERT INTO TransferTargets VALUES
(1, 'Leon Hartmann', 'BFC Dynamo', 'Midfielder', 8),
(2, 'Kevin Mensah', 'SV Babelsberg 03', 'Forward', 9),
(3, 'Ali Cem', 'Berliner AK 07', 'Defender', 7);


# Creating player transfer decision table 

CREATE TABLE TransferDecisions (
    RecommendationID INT PRIMARY KEY,
    PlayerID INT,
    RecommendationType VARCHAR(50),
    Reason VARCHAR(255),
    DecisionDate DATE,

    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

# inserting sample transfer decisions data
INSERT INTO TransferDecisions VALUES
(1, 2, 'Keep', 'Strong defensive performances this season', '2026-03-15'),
(2, 3, 'Keep', 'Top attacking contributor', '2026-03-15'),
(3, 5, 'Loan', 'Needs more consistent game time', '2026-03-15');

# Creating Training load table 

CREATE TABLE TrainingLoad (
    LoadID INT PRIMARY KEY,
    PlayerID INT,
    TrainingHours DECIMAL(5,2),
    FitnessLevel INT,
    TrainingDate DATE,

    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

# inserting training load data 
INSERT INTO TrainingLoad VALUES
(1, 1, 10.5, 8, '2026-03-01'),
(2, 2, 7.0, 6, '2026-03-01'),
(3, 3, 11.0, 9, '2026-03-01'),
(4, 4, 12.5, 9, '2026-03-01'),
(5, 5, 8.0, 7, '2026-03-01');

SELECT * FROM players;
SELECT * FROM matches;
SELECT * FROM playerstats;
SELECT * FROM injuries;
SELECT * FROM trainingload;
SELECT * FROM transferdecisions;
SELECT * FROM transfertargets;

# adding one more injury update to the list 

INSERT INTO Injuries
VALUES (3, 1, 'Illness', 1, 'Recovering');



-- -- VIEW
-- PLAYER PERFORMANCE SUMMARY TO ANALYZE CURRENT SQUAD PERFORMANCE

CREATE VIEW PlayerPerformanceSummary AS
SELECT 
    p.PlayerName,                                      
    p.Position,
    SUM(ps.Goals) AS TotalGoals,
    SUM(ps.Assists) AS TotalAssists,
    AVG(ps.PassesCompleted) AS AvgPassesCompleted
FROM Players p
JOIN PlayerStats ps
ON p.PlayerID = ps.PlayerID
GROUP BY p.PlayerName, p.Position;


SELECT * FROM playerperformancesummary;

-- VIEW 
-- Transfer Watchlist View TO ANALYZE FUTURE RECRUITMENT

CREATE VIEW TransferWatchlist AS
SELECT
    PlayerName,
    ClubID,
    Position,
    ScoutRating
FROM TransferTargets
WHERE ScoutRating >= 8;

DROP VIEW transferwatchlist;

SELECT * FROM transferwatchlist;

# NORMALIZING TRANSFER TARGETS TABLE
-- club names repeat and makes the table difficult to update 

-- normalized design --
# creating a seperate CLUB table 

# dropping transfertarget table 

DROP TABLE transfertargets;

CREATE TABLE Clubs ( 
ClubID INT PRIMARY KEY,
CurrentClub VARCHAR(100)
);

# inserting clubs data 

INSERT INTO Clubs VALUES
(1, 'BFC Dynamo'),
(2, 'SV Babelsberg 03'),
(3, 'Berliner AK 07');

# creating new transfertarget table 

CREATE TABLE TransferTargets (
    TargetID INT PRIMARY KEY,
    PlayerName VARCHAR(100),
    ClubID INT,
    Position VARCHAR(50),
    ScoutRating INT,

    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

# inserting transfertarget data

INSERT INTO TransferTargets VALUES
(1, 'Leon Hartmann', 1, 'Midfielder', 8),
(2, 'Kevin Mensah', 2, 'Forward', 9),
(3, 'Ali Cem', 3, 'Defender', 7);

SELECT * FROM  clubs;
SELECT * FROM transfertargets;

# new transfer watchlist view after normalization 

CREATE VIEW TransferWatchlist AS
SELECT
    transfertargets.PlayerName,
    clubs.CurrentClub,
    transfertargets.Position,
    transfertargets.ScoutRating
FROM TransferTargets 
JOIN Clubs 
ON transfertargets.ClubID = clubs.ClubID
WHERE transfertargets.ScoutRating >= 8;

SELECT * FROM Transferwatchlist;


# MATCH PERFORMANCE TREND VIEW
# creating VIEW

CREATE VIEW MatchPerformanceTrend AS
SELECT
    m.MatchDate,
    m.Opponent,
    SUM(ps.Goals) AS TeamGoals,
    SUM(ps.Assists) AS TeamAssists
FROM Matches m
JOIN PlayerStats ps
ON m.MatchID = ps.MatchID
GROUP BY m.MatchDate, m.Opponent
ORDER BY m.MatchDate;

SELECT * FROM matchperformancetrend;

-- ENTITY RELATIONAL DIAGRAM -------

#                             +----------------------+
#                             |       Players        |
#                             +----------------------+
#                             | PK  PlayerID         |
#                             |     PlayerName       |
#                             |     Nationality      |
#							  |     Position         |
#                             |     MarketValue      |
#                             +----------------------+
#                                 |       |        |
#                                 |       |        |
#                          1      |       |        | 1
#                                 |       |        |
#                                 |       |        |
#                                 M       M        M

#  +-------------------+   +----------------------+   +-------------------------+
#  |     Injuries      |   |    TrainingLoad      |   |   TransferDecisions    |
#  +-------------------+   +----------------------+   +-------------------------+
#  | PK  InjuryID      |   | PK  LoadID           |   | PK  RecommendationID   |
#  | FK  PlayerID      |   | FK  PlayerID         |   | FK  PlayerID           |
#  |     Diagnosis     |   |     TrainingHours    |   |     RecommendationType |
#  |     RecoveryWeeks |   |     FitnessLevel     |   |     Reason             |
#  |     InjuryStatus  |   |     TrainingDate     |   |     DecisionDate       |
#  +-------------------+   +----------------------+   +-------------------------+




#                    MANY-TO-MANY RELATIONSHIP
#               Players  <------>  Matches
#                    resolved using PlayerStats


#  +----------------------+        +----------------------+
#  |     PlayerStats      |        |       Matches       |
#  +----------------------+        +----------------------+
#  | PK,FK PlayerID       |------->|                     |
#  | PK,FK MatchID        |        | PK  MatchID         | 
#  |      Goals           |        |     Opponent        |
#  |      Assists         |        |     MatchDate       |
#  |      PassesCompleted |        |     Competition     |
#  +----------------------+        |     Result          |
#                                  +----------------------+


# +----------------------+         +----------------------+
# |        Clubs         |         |   TransferTargets    |
# +----------------------+         +----------------------+
# | PK  ClubID           |1       M| PK  TargetID         |
# |     ClubName         |-------->| FK  ClubID           |
# +----------------------+         |     PlayerName       |
#                                  |     Position         |
#                                  |     ScoutRating      |
#                                  +----------------------+



SELECT * FROM players;
SELECT * FROM matches;
SELECT * FROM playerstats;
SELECT * FROM trainingload;
SELECT * FROM injuries;

# updating players on injury list to have lower fitness levels

UPDATE trainingload
SET fitnesslevel = 5
WHERE playerid = 1;

UPDATE trainingload
SET fitnesslevel = 6
WHERE playerid = 5;

UPDATE trainingload 
SET fitnesslevel = 3
WHERE playerid = 2;





-- QUERYING & ANALYTICS ---

# 1.  WHICH PLAYER HAS THE HIGHEST GOAL CONTRIBUTION (GOALS & ASSISTS)
# PERFORMANCE ANALYSIS & TACTICAL ROLES. 
# Such analysis can aid managers in deciding which tactics to play in order to maximize the attacking impact of the team.

SELECT players.PlayerID, 
players.PlayerName, 
sum(Goals) AS TotalGoals, 
sum(Assists) AS TotalAssists, 
SUM(playerstats.Goals + playerstats.Assists) AS GoalContribution
FROM players
JOIN playerstats
ON players.PlayerID = playerstats.PlayerID
GROUP BY PlayerName, PlayerID
ORDER BY GoalContribution DESC;

-- GOAL CONTRIBUTORS AS A STORED PROCEDURE-- 
# to automate frequently used analytical queries within the system.

DELIMITER //

CREATE PROCEDURE GetTopGoalContributors()
BEGIN

SELECT 
    players.PlayerID,
    players.PlayerName,
    SUM(playerstats.Goals) AS TotalGoals,
    SUM(playerstats.Assists) AS TotalAssists,
    SUM(playerstats.Goals + playerstats.Assists) AS GoalContribution

FROM players

JOIN playerstats
ON players.PlayerID = playerstats.PlayerID

GROUP BY players.PlayerID, players.PlayerName

ORDER BY GoalContribution DESC;

END //

DELIMITER ;

CALL GetTopGoalContributors();



# 2. Classify players as “Fit”, “Moderate”, or “Needs Recovery” based on their fitness levels using CASE
# The CASE expression acts as an If-else statement, used to define different results based on specified conditions in an SQL statement
# team management can use this for player selection for matches and identify players when need personalised drills.

SELECT players.PlayerID, PlayerName, players.Position , Fitnesslevel,
CASE 
  WHEN FitnessLevel > 7 THEN 'Fit'
  WHEN FitnessLevel BETWEEN 6 AND 7 THEN 'Moderate Fitness'
  ELSE 'Needs Recovery'
 END AS FitnessStatus
FROM players
JOIN trainingload 
ON players.PlayerID = trainingload.PlayerID;

# 3. Which players contribute most to possession football through completed passes?
# Viktoria Berlin uses a possession-based playing style, so completed passes are used to evaluate ball retention and build-up contribution.

SELECT
    p.PlayerName,
    p.Position,
    SUM(ps.PassesCompleted) AS TotalPasses,

    RANK() OVER (
        ORDER BY SUM(ps.PassesCompleted) DESC
    ) AS PassRank                                              
                                                               
FROM Players p
JOIN PlayerStats ps
ON p.PlayerID = ps.PlayerID

GROUP BY p.PlayerName, p.Position;

# This query joins the Players and PlayerStats tables,
# calculates the total completed passes for each player
# and ranks players from highest to lowest passing contribution using a window function
# The query identifies the players most involved in possession play
# to the manager support possession-based tactical decisions.

-- one slow / messy query used with this database that can be improved 

# The Goal Contribution query is long and messy. As the database grows: thousands of match records, many seasons, many players the JOIN operation becomes heavier.
# improving query using an index 


DROP INDEX idx_playerstats_playerid
ON PlayerStats;

CREATE INDEX idx_playerstats_playerid
ON PlayerStats(PlayerID);



SELECT players.PlayerID, 
players.PlayerName, 
sum(Goals) AS TotalGoals, 
sum(Assists) AS TotalAssists, 
SUM(playerstats.Goals + playerstats.Assists) AS GoalContribution
FROM players
JOIN playerstats
ON players.PlayerID = playerstats.PlayerID
GROUP BY PlayerName, PlayerID
ORDER BY GoalContribution DESC;

# the query result duration improved after using an index from 0.141 secs to 0.000 secs













⚽ Project Overview- Football Analytics Database System

Modern football clubs generate large amounts of data from player performance, match statistics, training sessions, injury monitoring, and recruitment activities. Managing this information effectively requires a structured database system capable of supporting both operational and analytical needs.

This project was developed to demonstrate how relational database systems can be used within a football environment to store, manage, analyse, and visualize football data for improved decision-making.

🎯 Objectives
Design a normalized relational database for football operations.
Maintain data consistency using primary and foreign keys.
Support football analytics through SQL queries and business logic.
Improve query performance using indexing techniques.
Present insights through interactive Power BI dashboards.
🏗️ Database Design

The database was designed using Entity Relationship Modelling (ERD) and implemented in MySQL Workbench.

Main Entities
Players
Matches
PlayerStats
TrainingLoad
Injuries
TransferTargets
TransferDecisions
Clubs
Relationships
One-to-Many:
Players → TrainingLoad
Players → Injuries
Players → TransferDecisions
Many-to-Many:
Players ↔ Matches
Implemented through the PlayerStats junction table.
Normalization

The database was normalized to reduce redundancy and improve consistency. Club information was separated into a dedicated Clubs table and linked through foreign keys.

💻 SQL Implementation

The project includes:

Analytical Queries
Goal Contribution Analysis
Player Fitness Classification
Passing Contribution Analysis
Transfer Target Identification
Business Logic

Implemented using:

CASE Expressions
JOIN Operations
GROUP BY Clauses
Window Functions (RANK)
Views
TransferWatchlist
MatchPerformanceTrend
Stored Procedure

A stored procedure was created to automate player goal contribution analysis and improve query reusability.

Query Optimization

Indexes were implemented to improve query performance.

Example:

CREATE INDEX idx_playerstats_playerid
ON PlayerStats(PlayerID);

The optimization reduced query execution time significantly when retrieving goal contribution statistics.

📊 Power BI Dashboard

The SQL outputs were visualized using Microsoft Power BI.

Dashboard Features
Goal Contribution Analysis
Player Fitness Monitoring
Passing Contribution Analysis
Tactical Performance Insights

The dashboard transforms database outputs into visual reports that are easier for coaches, analysts, and decision-makers to interpret.

🔧 Technologies Used
MySQL Workbench
SQL
Power BI
ERD Modelling
Database Normalization
Query Optimization
📈 Key Insights

The system demonstrates how football data can be transformed into meaningful information for:

Team Selection
Tactical Planning
Performance Monitoring
Injury Management
Recruitment Decisions
🚧 Limitations
Developed using sample football data rather than live club data.
Small dataset compared to professional football environments.
No real-time data integration.
Limited predictive analytics capabilities.
🔮 Future Improvements
Integration with live football data sources.
Larger datasets for advanced analysis.
Machine learning models for performance prediction.
Automated scouting and recruitment recommendations.
Real-time dashboard reporting.
👨‍💻 Author

Jesse  Kumah
MSc Data Analytics
Berlin School of Business and Innovation 

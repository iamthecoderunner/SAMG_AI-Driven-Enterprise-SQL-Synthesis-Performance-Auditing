USE Week7StreamingDb;
GO

INSERT INTO Users (UserId, AccountCreatedDate, Country, Tier)
VALUES
(1, '2025-01-10', 'Philippines', 'Premium'),
(2, '2025-03-15', 'Philippines', 'Basic'),
(3, '2025-07-20', 'Singapore', 'Premium'),
(4, '2024-11-05', 'Philippines', 'Basic'),
(5, '2026-02-01', 'Malaysia', 'Premium');
GO

INSERT INTO Subscriptions (SubId, UserId, MonthlyCost, Status)
VALUES
(1, 1, 499.00, 'Active'),
(2, 2, 299.00, 'Active'),
(3, 3, 499.00, 'Cancelled'),
(4, 4, 299.00, 'Active'),
(5, 5, 499.00, 'Active');
GO

INSERT INTO Content
(ContentId, Title, Genre, ReleaseYear, BaseRuntimeMinutes)
VALUES
(101, 'Action Alpha',   'Action', 2024, 120),
(102, 'Action Bravo',   'Action', 2025, 110),
(103, 'Action Charlie', 'Action', 2023, 100),
(104, 'Action Delta',   'Action', 2025, 95),
(201, 'Drama One',      'Drama', 2024, 90),
(202, 'Drama Two',      'Drama', 2025, 105),
(203, 'Drama Three',    'Drama', 2023, 115),
(204, 'Drama Four',     'Drama', 2025, 100);
GO

INSERT INTO WatchHistory
(PlaybackId, UserId, ContentId, WatchDate, MinutesWatched)
VALUES
(1001, 1, 101, '2025-01-12T10:00:00', 90),
(1002, 1, 102, '2025-01-13T10:00:00', 70),
(1003, 1, 103, '2025-01-14T10:00:00', 50),
(1004, 1, 104, '2025-01-15T10:00:00', 30),

(1005, 2, 101, '2025-03-20T09:00:00', 40),
(1006, 2, 102, '2025-03-21T09:00:00', 80),
(1007, 2, 103, '2025-03-22T09:00:00', 60),
(1008, 2, 104, '2025-03-23T09:00:00', 20),

(1009, 3, 201, '2025-07-21T18:00:00', 100),
(1010, 3, 202, '2025-07-22T18:00:00', 80),
(1011, 3, 203, '2025-07-23T18:00:00', 60),
(1012, 3, 204, '2025-07-24T18:00:00', 40),

-- User 4 was created in 2024, so these records must NOT count in Target 1
(1013, 4, 101, '2025-01-10T08:00:00', 500),
(1014, 4, 201, '2025-01-11T08:00:00', 500),

-- Same timestamp for User 1 to test PlaybackId as tie-breaker in Target 2
(1015, 1, 201, '2025-02-01T12:00:00', 40),
(1016, 1, 202, '2025-02-01T12:00:00', 55),

-- User 5 created in 2026, so this must also NOT count in Target 1
(1017, 5, 204, '2026-02-05T15:00:00', 300);
GO
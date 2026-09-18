USE Week7StreamingDb;
GO

CREATE TABLE Users
(
    UserId INT NOT NULL PRIMARY KEY,
    AccountCreatedDate DATETIME2 NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    Tier NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE Subscriptions
(
    SubId INT NOT NULL PRIMARY KEY,
    UserId INT NOT NULL,
    MonthlyCost DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Subscriptions_Users
        FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO

CREATE TABLE Content
(
    ContentId INT NOT NULL PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Genre NVARCHAR(100) NOT NULL,
    ReleaseYear INT NOT NULL,
    BaseRuntimeMinutes INT NOT NULL
);
GO

CREATE TABLE WatchHistory
(
    PlaybackId INT NOT NULL PRIMARY KEY,
    UserId INT NOT NULL,
    ContentId INT NOT NULL,
    WatchDate DATETIME2 NOT NULL,
    MinutesWatched INT NOT NULL,
    CONSTRAINT FK_WatchHistory_Users
        FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_WatchHistory_Content
        FOREIGN KEY (ContentId) REFERENCES Content(ContentId)
);
GO

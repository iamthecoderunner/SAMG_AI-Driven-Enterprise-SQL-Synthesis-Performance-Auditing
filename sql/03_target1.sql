USE Week7StreamingDb;
GO

WITH Users2025 AS (
    SELECT UserId
    FROM Users
    WHERE AccountCreatedDate >= '2025-01-01'
      AND AccountCreatedDate <  '2026-01-01'
),
ContentTotals AS (
    SELECT
        c.Genre,
        c.ContentId,
        c.Title,
        SUM(wh.MinutesWatched) AS TotalMinutesWatched
    FROM WatchHistory AS wh
    INNER JOIN Users2025 AS u
        ON u.UserId = wh.UserId
    INNER JOIN Content AS c
        ON c.ContentId = wh.ContentId
    GROUP BY
        c.Genre,
        c.ContentId,
        c.Title
),
RankedContent AS (
    SELECT
        Genre,
        ContentId,
        Title,
        TotalMinutesWatched,
        ROW_NUMBER() OVER (
            PARTITION BY Genre
            ORDER BY TotalMinutesWatched DESC, ContentId
        ) AS GenreRank
    FROM ContentTotals
)
SELECT
    Genre,
    ContentId,
    Title,
    TotalMinutesWatched,
    GenreRank
FROM RankedContent
WHERE GenreRank <= 3
ORDER BY Genre, GenreRank;
GO
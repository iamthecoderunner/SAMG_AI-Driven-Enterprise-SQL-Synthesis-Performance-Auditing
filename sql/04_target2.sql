USE Week7StreamingDb;
GO

WITH PlaybackTrajectory AS
(
    SELECT
        wh.UserId,
        wh.PlaybackId,
        wh.WatchDate,
        c.Title,
        wh.MinutesWatched,
        LAG(wh.MinutesWatched) OVER
        (
            PARTITION BY wh.UserId
            ORDER BY wh.WatchDate, wh.PlaybackId
        ) AS PreviousMinutesWatched
    FROM WatchHistory AS wh
    LEFT JOIN Content AS c
        ON c.ContentId = wh.ContentId
)
SELECT
    UserId,
    PlaybackId,
    WatchDate,
    Title,
    MinutesWatched,
    PreviousMinutesWatched,
    MinutesWatched - PreviousMinutesWatched AS MinutesWatchedDifference
FROM PlaybackTrajectory
ORDER BY UserId, WatchDate, PlaybackId;
GO
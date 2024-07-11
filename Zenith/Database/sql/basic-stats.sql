SELECT 
    pgl.[SEASON_YEAR],
    pgl.[PLAYER_ID],
    pgl.[PLAYER_NAME],
    pgl.[TEAM_ABBREVIATION],
    pgl.[GAME_ID],
    pgl.[GAME_DATE],
    pgl.[WL],
    pgl.[PTS],
    pgl.[OREB],
    pgl.[DREB],
    pgl.[REB],
    pgl.[AST],
    pgl.[TOV],
    pgl.[STL],
    pgl.[BLK],
	pgl.[FG3M],

	pgl.oppAbrv,
    ROUND(AVG(CAST(pgl.PTS AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS PPG,          -- Points Per Game
    ROUND(AVG(CAST(pgl.FGM AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FGM,          -- Field Goals Made Per Game
    ROUND(AVG(CAST(pgl.FGA AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FGA,          -- Field Goals Attempted Per Game
    ROUND(AVG(CAST(pgl.FG_PCT AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FG_PCT,    -- Field Goal Percentage
    ROUND(AVG(CAST(pgl.FG3M AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FG3M,        -- Three-Point Field Goals Made Per Game
    ROUND(AVG(CAST(pgl.FG3A AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FG3A,        -- Three-Point Field Goals Attempted Per Game
    ROUND(AVG(CAST(pgl.FG3_PCT AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FG3_PCT,  -- Three-Point Field Goal Percentage
    ROUND(AVG(CAST(pgl.FTM AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FTM,          -- Free Throws Made Per Game
    ROUND(AVG(CAST(pgl.FTA AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FTA,          -- Free Throws Attempted Per Game
    ROUND(AVG(CAST(pgl.FT_PCT AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS FT_PCT,    -- Free Throw Percentage
    ROUND(AVG(CAST(pgl.OREB AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS OREB,        -- Offensive Rebounds Per Game
    ROUND(AVG(CAST(pgl.DREB AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS DREB,        -- Defensive Rebounds Per Game
    ROUND(AVG(CAST(pgl.REB AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS REBPG,          -- Rebounds Per Game
    ROUND(AVG(CAST(pgl.AST AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS APG,          -- Assists Per Game
    ROUND(AVG(CAST(pgl.TOV AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS TOV,          -- Turnovers Per Game
    ROUND(AVG(CAST(pgl.STL AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS SPG,          -- Steals Per Game
    ROUND(AVG(CAST(pgl.BLK AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS BPG,          -- Blocks Per Game
    ROUND(AVG(CAST(pgl.BLKA AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS BLKA,        -- Blocked Attempts Per Game
    ROUND(AVG(CAST(pgl.PF AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS PF,            -- Personal Fouls Per Game
    ROUND(AVG(CAST(pgl.PFD AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS PFD,          -- Personal Fouls Drawn Per Game
    ROUND(AVG(CAST(pgl.PLUS_MINUS AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS Plus_Minus, -- Plus/Minus Per Game
	SUM(CAST(pgl.DD2 AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN 10 PRECEDING AND 1 PRECEDING) AS Count_DD2_last_10,          -- Double-Doubles last 10 games
    SUM(CAST(pgl.TD3 AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN 10 PRECEDING AND 1 PRECEDING) AS Count_TD3_last_10,           -- Triple-Doubles last ten games

    ROUND(AVG(CAST(bsa.[estimatedOffensiveRating] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_estimatedOffensiveRating,
    ROUND(AVG(CAST(bsa.[offensiveRating] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_offensiveRating,
    ROUND(AVG(CAST(bsa.[estimatedDefensiveRating] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_estimatedDefensiveRating,
    ROUND(AVG(CAST(bsa.[defensiveRating] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_defensiveRating,
    ROUND(AVG(CAST(bsa.[estimatedNetRating] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_estimatedNetRating,
    ROUND(AVG(CAST(bsa.[netRating] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_netRating,
    ROUND(AVG(CAST(bsa.[assistPercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_assistPercentage,
    ROUND(AVG(CAST(bsa.[assistToTurnover] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_assistToTurnover,
    ROUND(AVG(CAST(bsa.[assistRatio] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_assistRatio,
    ROUND(AVG(CAST(bsa.[offensiveReboundPercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_offensiveReboundPercentage,
    ROUND(AVG(CAST(bsa.[defensiveReboundPercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_defensiveReboundPercentage,
    ROUND(AVG(CAST(bsa.[reboundPercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_reboundPercentage,
    ROUND(AVG(CAST(bsa.[turnoverRatio] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_turnoverRatio,
    ROUND(AVG(CAST(bsa.[effectiveFieldGoalPercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_effectiveFieldGoalPercentage,
    ROUND(AVG(CAST(bsa.[trueShootingPercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_trueShootingPercentage,
    ROUND(AVG(CAST(bsa.[usagePercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_usagePercentage,
    ROUND(AVG(CAST(bsa.[estimatedUsagePercentage] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_estimatedUsagePercentage,
    ROUND(AVG(CAST(bsa.[estimatedPace] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_estimatedPace,
    ROUND(AVG(CAST(bsa.[pace] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_pace,
    ROUND(AVG(CAST(bsa.[pacePer40] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_pacePer40,
    ROUND(AVG(CAST(bsa.[possessions] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_possessions,
    ROUND(AVG(CAST(bsa.[PIE] AS FLOAT)) OVER (PARTITION BY bsa.[personId], pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS avg_PIE

	  --case when ROUND(AVG(CAST(pgl.PTS AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING), 2) >
	  --ROUND(AVG(CAST(pgl.PTS AS FLOAT)) OVER (PARTITION BY PLAYER_ID, SEASON_YEAR ORDER BY GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) then 1 else 0 end as recent_pts_trend,
	  --lag(
	  -- ROUND(AVG(CAST(pgl.PTS AS FLOAT)) OVER (PARTITION BY pgl.PLAYER_ID, pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING), 2) -
   -- ROUND(AVG(CAST(pgl.PTS AS FLOAT)) OVER (PARTITION BY pgl.PLAYER_ID, pgl.SEASON_YEAR ORDER BY pgl.GAME_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 2) AS pts_momentum
	  --,pts

FROM 
    [nba_game_data].[dbo].[PlayerGameLogs] pgl

	LEFT OUTER JOIN [nba_game_data].[dbo].[BoxScoreAdvancedV3] bsa
		ON
		pgl.GAME_ID = bsa.GAME_ID
		and pgl.PLAYER_ID = bsa.personId

WHERE 
    PLAYER_ID = 1627783
ORDER BY 
    GAME_DATE;
SELECT
  CASE
    WHEN team = 'South Korea' THEN 'Korea Republic'
    ELSE team
  END AS team,
  SUM(cnt_performance_match) as num_matches,
  SUM(cnt_performance_match) * 3 AS max_points,
  ROUND(SUM(percent_record) / (SUM(cnt_performance_match) * 3), 2) AS percent_record,
  SUM(scores) AS total_scores
FROM (
  SELECT
    team,
    what_happened,
    cnt_performance_match,
    CASE
      WHEN what_happened = 'lost' THEN cnt_performance_match * 0
      WHEN what_happened = 'tied' THEN cnt_performance_match * 1
      WHEN what_happened = 'won' THEN cnt_performance_match * 3
    END AS percent_record,
    scores
  FROM (
    SELECT
      team,
      what_happened,
      COUNT(*) AS cnt_performance_match,
      SUM(scores) AS scores
    FROM (
      SELECT
        *
      FROM (
        SELECT
          year,
          home AS team,
          home_score AS scores,
          CASE
            WHEN home_score > away_score THEN 'won'
            WHEN home_score < away_score THEN 'lost'
            WHEN home_score = away_score THEN 'tied'
          END AS what_happened
        FROM
          [paul_the_octopus_dataset.matches_history] ) home,
        (
        SELECT
          year,
          away AS team,
          away_score AS scores,
          CASE
            WHEN away_score > home_score THEN 'won'
            WHEN away_score < home_score THEN 'lost'
            WHEN home_score = away_score THEN 'tied'
          END AS what_happened
        FROM
          [paul_the_octopus_dataset.matches_history] ) away
      ORDER BY
        year ASC)
    GROUP BY
      1,
      2) )
GROUP BY
  1
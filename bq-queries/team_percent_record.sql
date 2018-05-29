SELECT
  team,
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
    FROM
      [project-paul-the-octopus:felipegc.team_history]
    GROUP BY
      1,
      2) )
GROUP BY
  1
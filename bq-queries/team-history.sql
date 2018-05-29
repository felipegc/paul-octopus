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
    [project-paul-the-octopus:paul_the_octopus_dataset.matches_history] ) home,
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
    [project-paul-the-octopus:paul_the_octopus_dataset.matches_history] ) away
  ORDER BY year ASC
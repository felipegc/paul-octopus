SELECT
  date,
  RTRIM(LTRIM(home)) as team_1,
  RTRIM(LTRIM(away)) AS team_2
FROM
  [paul_the_octopus_dataset.matches]
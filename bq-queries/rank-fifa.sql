SELECT
  rank,
  team,
  total_points,
  INTEGER(rank / 5) + 1 AS rank_group
FROM
  [paul_the_octopus_dataset.fifa_rank]
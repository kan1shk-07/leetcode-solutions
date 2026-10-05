# Write your MySQL query statement below# Write your MySQL query statement below
WITH cte1 AS (
    SELECT
        user_id,
        COUNT(content_id) AS total_reactions
    FROM reactions
    GROUP BY user_id
),

cte2 AS (
    SELECT
        user_id,
        reaction,
        COUNT(content_id) AS reaction_count
    FROM reactions
    GROUP BY
        user_id,
        reaction
)

SELECT
    cte2.user_id,
    cte2.reaction AS dominant_reaction,
    ROUND(cte2.reaction_count / cte1.total_reactions, 2) AS reaction_ratio
FROM cte2
JOIN cte1
    ON cte2.user_id = cte1.user_id
WHERE cte1.total_reactions > 4
  AND cte2.reaction_count / cte1.total_reactions >= 0.60
ORDER BY
    reaction_ratio DESC,
    cte2.user_id ASC;

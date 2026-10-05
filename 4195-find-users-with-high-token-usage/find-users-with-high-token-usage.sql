SELECT DISTINCT
    a.*
FROM
    (SELECT
            user_id,
            COUNT(1) AS prompt_count,
            ROUND(AVG(tokens), 2) AS avg_tokens
    FROM prompts
    GROUP BY user_id
    HAVING prompt_count > 2) a
        JOIN prompts b ON a.user_id = b.user_id
        AND a.avg_tokens > b.tokens
ORDER BY avg_tokens DESC , a.user_id ASC;
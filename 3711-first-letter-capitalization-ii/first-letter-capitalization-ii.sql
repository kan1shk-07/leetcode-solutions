WITH RECURSIVE words AS (
    -- Step 1: Split content_text into space-separated words
    SELECT 
        content_id,
        content_text,
        1 AS word_num,
        REGEXP_SUBSTR(content_text, '[^ ]+', 1, 1) AS word
    FROM user_content
    WHERE REGEXP_SUBSTR(content_text, '[^ ]+', 1, 1) IS NOT NULL

    UNION ALL

    SELECT 
        content_id,
        content_text,
        word_num + 1,
        REGEXP_SUBSTR(content_text, '[^ ]+', 1, word_num + 1) AS word
    FROM words
    WHERE REGEXP_SUBSTR(content_text, '[^ ]+', 1, word_num + 1) IS NOT NULL
),
hyphen_parts AS (
    -- Step 2: Split hyphenated words into their individual segments
    SELECT 
        content_id,
        word_num,
        1 AS part_num,
        REGEXP_SUBSTR(word, '[^-]+', 1, 1) AS part
    FROM words
    WHERE word REGEXP '^[a-zA-Z]+(-[a-zA-Z]+)+$'

    UNION ALL

    SELECT 
        hp.content_id,
        hp.word_num,
        hp.part_num + 1,
        REGEXP_SUBSTR(w.word, '[^-]+', 1, hp.part_num + 1) AS part
    FROM hyphen_parts hp
    JOIN words w 
      ON hp.content_id = w.content_id 
     AND hp.word_num = w.word_num
    WHERE REGEXP_SUBSTR(w.word, '[^-]+', 1, hp.part_num + 1) IS NOT NULL
),
converted_hyphen_words AS (
    -- Step 3: Capitalize first letter and lowercase the rest for every hyphen segment
    SELECT 
        content_id,
        word_num,
        GROUP_CONCAT(
            CONCAT(UPPER(LEFT(part, 1)), LOWER(SUBSTRING(part, 2))) 
            ORDER BY part_num 
            SEPARATOR '-'
        ) AS converted_word
    FROM hyphen_parts
    GROUP BY content_id, word_num
),
transformed_words AS (
    -- Step 4: Apply capitalization rules
    SELECT 
        w.content_id,
        w.word_num,
        CASE 
            -- Rule 1: Starts with a non-English letter -> keep entirely unchanged (e.g. -HE-LL-O-)
            WHEN w.word NOT REGEXP '^[a-zA-Z]' 
                THEN w.word

            -- Rule 2: Letter segments connected by hyphens -> use converted parts
            WHEN w.word REGEXP '^[a-zA-Z]+(-[a-zA-Z]+)+$' 
                THEN chw.converted_word

            -- Rule 3: Regular words -> capitalize 1st letter, lowercase rest
            ELSE CONCAT(UPPER(LEFT(w.word, 1)), LOWER(SUBSTRING(w.word, 2)))
        END AS final_word
    FROM words w
    LEFT JOIN converted_hyphen_words chw 
      ON w.content_id = chw.content_id 
     AND w.word_num = chw.word_num
)
-- Step 5: Reassemble the words in original sequence
SELECT 
    u.content_id,
    u.content_text AS original_text,
    COALESCE(
        GROUP_CONCAT(tw.final_word ORDER BY tw.word_num SEPARATOR ' '), 
        u.content_text
    ) AS converted_text
FROM user_content u
LEFT JOIN transformed_words tw 
  ON u.content_id = tw.content_id
GROUP BY u.content_id, u.content_text
ORDER BY u.content_id;
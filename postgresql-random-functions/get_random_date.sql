\timing on
BEGIN;

-- Get a random date
--
--
CREATE OR REPLACE FUNCTION get_random_date(
       inter INTERVAL DEFAULT '20 year'::interval,
       period TEXT DEFAULT 'random'
       ) returns date as
$$
DECLARE
  result date;
BEGIN
    IF period = 'past' THEN
        result := now() - (random() * inter);
    ELSIF period = 'future' THEN
        result := now() + (random() * inter);
    ELSE
        result := now() + ((random() - 0.5) * 2 * inter);
    END IF;

    return result;
END;
$$ language plpgsql;

COMMIT;

/* 
SELECT get_random_date(),
       get_random_date('3 week') as rand, 
       get_random_date('3 week', 'past') as past, 
       get_random_date('3 week', 'future') as future, 
       generate_series(1,7);

WITH rdate AS (
SELECT get_random_date('30 year') as rand, 
       get_random_date('30 year', 'past') as past, 
       get_random_date('30 year', 'future') as future, 
       generate_series(1,7000)
) SELECT min(rand), max(rand), min(past), max(future) from rdate;

*/

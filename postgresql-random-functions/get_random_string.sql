
-- Get a random string
--
-- source : https://www.depesz.com/2017/02/06/generate-short-random-textual-ids/
--
CREATE OR REPLACE FUNCTION get_random_string(
        IN string_length INTEGER,
        IN possible_chars TEXT
        DEFAULT '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    ) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    output TEXT = '';
    i INT4;
    pos INT4;
BEGIN
    FOR i IN 1..string_length LOOP
        pos := 1 + CAST( random() * ( LENGTH(possible_chars) - 1) AS INT4 );
        output := output || substr(possible_chars, pos, 1);
    END LOOP;
    RETURN output;
END;
$$;


-- get a random ipv4 random address
--
-- very simple version, some address may be invalid
--
CREATE OR REPLACE FUNCTION get_random_inet(
    ) RETURNS inet
    LANGUAGE plpgsql
    AS $$
BEGIN
    return CONCAT(
      TRUNC(RANDOM() * 250 + 2), '.',
      TRUNC(RANDOM() * 250 + 2), '.',
      TRUNC(RANDOM() * 250 + 2), '.',
      TRUNC(RANDOM() * 250 + 2)
)::inet;

END;
$$;

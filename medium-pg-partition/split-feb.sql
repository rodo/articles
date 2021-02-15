\timing
--
-- move old data
--
BEGIN;

-- detach legay table

ALTER TABLE payments DETACH PARTITION payments_old;

-- create new partition

CREATE TABLE payments_202102 PARTITION OF payments
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE INDEX idx_payments_202102 ON payments_202102 (created);

-- move lines

WITH moved_rows AS (
    DELETE FROM payments_old a
    WHERE created >= '2021-02-01' AND created <'2021-03-01'
    RETURNING a.* 
)
INSERT INTO payments_202102
SELECT * FROM moved_rows;

ANALYZE payments_202102;

--

ALTER TABLE payments_old DROP CONSTRAINT payments_old;

-- 
ALTER TABLE payments_old ADD constraint payments_old
CHECK  (created >= '2000-01-01' AND created <'2021-02-01');

-- reattach legacy table

alter table payments ATTACH PARTITION payments_old
    FOR VALUES FROM ('2000-01-01') TO ('2021-02-01');

COMMIT;






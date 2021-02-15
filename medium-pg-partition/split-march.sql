-- We will move some data to the right table
--
BEGIN;

-- detach legacy table
ALTER TABLE payments DETACH PARTITION payments_old;

-- create new partition for March
CREATE TABLE payments_202103 PARTITION OF payments
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE INDEX idx_payments_202103 ON payments_202103 (created);

-- move rows
WITH moved_rows AS (
    DELETE FROM payments_old a
    WHERE created >= '2021-03-01' AND created <'2021-04-01'
    RETURNING a.*
)
INSERT INTO payments_202103
SELECT * FROM moved_rows;

-- recreate the constraint with new bounds
ALTER TABLE payments_old DROP CONSTRAINT payments_old;

ALTER TABLE payments_old ADD constraint payments_old
CHECK  (created >= '2000-01-01' AND created <'2021-03-01');

-- reattach the legacy table on new bounds
ALTER TABLE payments ATTACH PARTITION payments_old
    FOR VALUES FROM ('2000-01-01') TO ('2021-03-01');

COMMIT;


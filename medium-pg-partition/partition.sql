\timing on
--
-- Create the partitioned table
-- attach the legacy table for old values
--
BEGIN;

-- rename the legacy table
ALTER TABLE payments RENAME TO payments_old;

-- create the new main table, with the legacy name to ensure
-- applications compatibility
CREATE TABLE payments (
       payment_id int NOT NULL DEFAULT nextval('public.payments_id_seq'::regclass)
     , created timestamptz NOT NULL
     , updated  timestamptz NOT NULL DEFAULT now()
     , amount float
     , status varchar DEFAULT 'new')
PARTITION BY RANGE (created);

-- Add a constraint to ensure the legacy table contains predictable
-- data
ALTER TABLE payments_old ADD CONSTRAINT payments_old
   CHECK  (created >= '2000-01-01' AND created <'2021-04-01');

-- attach the legacy table to the new partitionned one
ALTER TABLE payments ATTACH PARTITION payments_old
    FOR VALUES FROM ('2000-01-01') TO ('2021-04-01');

-- add some partitions
CREATE TABLE payments_202104 PARTITION OF payments
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE payments_202105 PARTITION OF payments
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

COMMIT;


\timing on
BEGIN;

-- start by dropping existing object to be idempotent
--
DROP TABLE IF EXISTS payments CASCADE;
DROP SEQUENCE IF EXISTS public.payments_id_seq;

-- We have an autoincrement column as often
CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE payments (
       payment_id int NOT NULL DEFAULT nextval('public.payments_id_seq'::regclass),
       created timestamptz NOT NULL,
       updated  timestamptz NOT NULL DEFAULT now(),
       amount float,
       status varchar DEFAULT 'new');

CREATE INDEX idx_payments_created ON payments (created);

-- fill with some data
-- around 500k rows in Feb 15
INSERT INTO payments (created) VALUES (
generate_series(timestamp '2020-01-01'
               , now()
               , interval  '1 minutes') ); 
COMMIT;


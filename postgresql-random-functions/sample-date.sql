--
-- create a table with random data
--
\timing on
DROP TABLE IF EXISTS sample_table;

CREATE TABLE sample_table (
         id int
       , created date default get_random_date('10 year', 'past')
       , expired date default get_random_date('1 week', 'future')       
       , callback date default get_random_date('1 year')       
       , firstname text default get_random_firstname()
       , country text default get_random_country()
       , ip_addr inet default get_random_inet()
);       

INSERT INTO sample_table (id) VALUES (generate_series(1, 10000));

-- Filename:replace.sql
TRUNCATE TABLE trigger_test;
TRUNCATE TABLE logger;
INSERT INTO trigger_test (id,val) VALUES (100,'insert');
REPLACE INTO trigger_test (id,val) VALUES (100,'replace');
REPLACE INTO trigger_test (id,val) VALUES (101,'replace');


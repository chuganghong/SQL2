-- Filename:isolation-table.sql
DROP TABLE IF EXISTS transaction_test;
CREATE TABLE transaction_test
(
	id INT NOT NULL AUTO_INCREMENT,
	val VARCHAR(20) NOT NULL,
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- inset some data
INSERT INTO transaction_test (val) VALUES ('a'),('b'),('c');

-- Repeatable Read
-- one
SELECT @@global.tx_isolation, @@session.tx_isolation;
START TRANSACTION;
SELECT * FROM transaction_test;
SELECT SLEEP(20);
INSERT INTO transaction_test (val) VALUES (@@session.tx_isolation);
SELECT * FROM transaction_test;
COMMIT;
-- two
START TRANSACTION;
INSERT INTO transaction_test (val) VALUES ('x'),('y'),('z');
SELECT * FROM transaction_test;
COMMIT;
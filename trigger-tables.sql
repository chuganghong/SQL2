-- Filename:trigger-tables.sql
USE studysql;
DROP TABLE IF EXISTS trigger_test;
CREATE TABLE trigger_test
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	val VARCHAR(10) NOT NULL,
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS logger;
CREATE TABLE logger
(
	action ENUM('INSERT','UPDATE','DELETE') NOT NULL,
	occurred TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	id INT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO trigger_test (id,val) VALUES (NULL,'A');


-- insert-triggers.sql
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_test_bri$$
CREATE TRIGGER trigger_test_bri
BEFORE INSERT ON trigger_test
FOR EACH ROW
	INSERT INTO logger(action,occurred,id)
		VALUES ('INSERT',NOW(),NEW.id);
$$
DROP TRIGGER IF EXISTS trigger_test_ari$$
CREATE TRIGGER trigger_test_ari
AFTER INSERT ON trigger_test
FOR EACH ROW
	INSERT INTO logger(action,occurred,id)
		VALUES ('INSERT',NOW(),NEW.id);
$$
DELIMITER ;

INSERT INTO trigger_test(id,val) VALUES (NULL,'B');

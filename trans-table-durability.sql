-- Filename:trans-table-durability.sql
-- Durability 持久性

USE studysql;

SET NAMES utf8;

DROP TABLE IF EXISTS durability_test;
CREATE TABLE durability_test
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	c1 VARCHAR(2000) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER $$

DROP PROCEDURE IF EXISTS fill_durability $$
CREATE PROCEDURE fill_durability()
DETERMINISTIC
BEGIN
	DECLARE counter INT DEFAULT 0;
	TRUNCATE TABLE durability_test;
	WHILE TRUE
	DO
		START TRANSACTION;
		SET counter = 0;
		WHILE counter < 10
		DO
			INSERT INTO durability_test(c1) VALUES (REPEAT ('Expert PHP and MySQL',100));
			SET counter = counter + 1;
		END WHILE;
		COMMIT;
	END WHILE;
END $$

DELIMITER ;

CALL fill_durability;
		
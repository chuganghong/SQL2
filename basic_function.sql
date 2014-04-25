-- Filename:basic_function.sql
-- Basic syntax to create a function

DELIMITER //

CREATE FUNCTION add_tax (price FLOAT)
RETURNS FLOAT
/* DETERMINISTIC
READS SQL DATA */
BEGIN
	RETURN price*1.1;
END

//

DELIMITER  ;

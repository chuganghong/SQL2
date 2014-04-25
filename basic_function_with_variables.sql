-- Basic syntax to create a function

DELIMITER //

CREATE FUNCTION add_tax_variables (price FLOAT)
RETURNS FLOAT
BEGIN
	DECLARE tax FLOAT DEFAULT 0.10;
	RETURN price*(1 + tax);
END

//

DELIMITER ;
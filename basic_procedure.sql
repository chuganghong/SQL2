-- Basic stored procedure example
DELIMITER //

CREATE PROCEDURE total_film_id (out total float)
BEGIN
	SELECT SUM(tag_id) INTO total FROM tmp_tags;
END
//

DELIMITER ;

CALL total_film_id(@t);

SELECT @t;
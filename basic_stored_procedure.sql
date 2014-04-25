-- Basic stored procedure example

delimiter //

CREATE PROCEDURE total_films (out total float)
BEGIN
	SELECT SUM(film_id) INTO total FROM tmp_films;
END
//

delimiter ;


-- Procedure to find the orderid with the largest amount
-- could be done with max,but just to illustrate stored procedure principles
-- Database movies(20140420)

DELIMITER //
CREATE PROCEDURE largest_order(OUT largest_id INT)
BEGIN
	DECLARE this_id INT;
	DECLARE this_amount FLOAT;
	DECLARE 1_amount FLOAT DEFAULT 0.0;
	DECLARE 1_id INT;
	
	DECLARE done INT DEFAULT 0;
	DECLARE c1 CURSOR FOR SELECT tag_id,kind_id FROM tmp_tags;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	
	OPEN c1;
	REPEAT
		FETCH c1 INTO this_id,this_amount;
		IF NOT done THEN
			IF this_amount > 1_amount THEN
				SET 1_amount = this_amount;
				SET 1_id = this_id;
			END IF;
		END IF;
	UNTIL DONE END REPEAT;
	CLOSE c1;
	
	SET largest_id = 1_id;
	
END
//

DELIMITER ;
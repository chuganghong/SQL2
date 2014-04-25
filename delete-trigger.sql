-- Filename:delete-trigger.sql
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_test_brd$$
CREATE TRIGGER trigger_test_brd
BEFORE DELETE ON trigger_test
FOR EACH ROW
	INSERT INTO logger(action,occurred,id)
	VALUES ('DELETE',NOW(),OLD.id);
$$

DROP TRIGGER IF EXISTS trigger_test_ard$$
CREATE TRIGGER trigger_test_ard
AFTER DELETE ON trigger_test
FOR EACH ROW
	INSERT INTO logger(action,occurred,id)
	VALUES ('DELETE',NOW(),OLD.id);
$$

DELIMITER ;

-- OTHER
DELETE FROM trigger_test WHERE id > 10;
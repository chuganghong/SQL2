-- Filename:update-trigger.sql
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_test_bru$$
CREATE TRIGGER trigger_test_bru
BEFORE UPDATE ON trigger_test
FOR EACH ROW
	INSERT INTO logger(action,occurred,id)
	VALUES ('UPDATE',NOW(),OLD.id);
$$
DROP TRIGGER IF EXISTS trigger_test_aru$$
CREATE TRIGGER trigger_test_aru
AFTER UPDATE ON trigger_test
FOR EACH ROW
	INSERT INTO logger(action,occurred,id)
	VALUES('UPDATE',NOW(),NEW.id);
$$
DELIMITER ;



-- other
INSERT INTO trigger_test(id,val) VALUES (NULL,'D');
UPDATE trigger_test SET id = id + 10 WHERE val = 'b';
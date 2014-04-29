-- Filename:event-table.sql
-- 事件
DROP TABLE IF EXISTS event_test;
CREATE TABLE event_test
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	action VARCHAR(10) NOT NULL,
	val VARCHAR(10) NOT NULL,
	PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET NAMES utf8;
-- every-min-event start
CREATE EVENT e_minute
ON SCHEDULE EVERY 1 MINUTE
COMMENT 'Perform event every minute'
DO
	INSERT INTO event_test (action,val)
	VALUES ('Minute', DATE_FORMAT(NOW(),'%i%s'));
	
SELECT * FROM event_test;
-- every-min-event end

-- once-off-event start
CREATE EVENT e_nextminute
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
COMMENT 'Perform event just once'
DO
	INSERT INTO event_test (action,val)
	VALUES (' 1 Minute',DATE_FORMAT(NOW(),'%i%s'));
	
-- once-off-event end

-- 启用事件调度程序 start
SHOW GLOBAL VARIABLES LIKE 'event_scheduler' ;
-- 输出
-- +-----------------+------
-- | Variable_name   | Value
-- +-----------------+------
-- | event_scheduler | OFF
-- +-----------------+------
-- 1 row in set (0.00 sec)
SET GLOBAL event_scheduler = TRUE;

-- 启用事件调度程序 end

-- 变更事件
ALTER EVENT e_minute DISABLE; --停止事件
SHOW EVENTS\G
ALTER EVENT e_minute ENABLE; --重启事件
SELECT SLEEP(60);
DROP event e_minute;
SHOW EVENTS\G

-- 事件特权。不知如何何时使用这两条语句。
GRANT EVENT ON studysql.* TO root@localhost;
REVOKE EVENT ONT studysql.* FROM root@localhost;

-- 事件元数据。有啥用？
SELECT * FROM mysql.event\G
SELECT * FROM INFORMATION_SCHEMA.EVENTS\G

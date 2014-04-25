-- 结合该文件和trans-tables.sql理解非事务性表和事务性表
-- Filename:trans-tables.sql

DROP TABLE IF EXISTS trans_parent;
CREATE TABLE trans_parent
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	val VARCHAR(10) NOT NULL,
	PRIMARY KEY(id),
	UNIQUE KEY(val)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS trans_child;
CREATE TABLE trans_child
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	parent_id INT UNSIGNED NOT NULL,
	created TIMESTAMP NOT NULL,
	PRIMARY KEY(id),
	INDEX (parent_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Test
START TRANSACTION;
INSERT INTO trans_parent(val) VALUES ('a');
INSERT INTO trans_child(parent_id,created) VALUES (LAST_INSERT_ID(),NOW());

-- Consistency
START TRANSACTION;
INSERT INTO trans_parent (val) VALUES ('a');
INSERT INTO trans_child (parent_id, created) VALUES (999,NOW());
COMMIT;


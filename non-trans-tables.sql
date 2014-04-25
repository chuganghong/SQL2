-- 结合该文件和trans-tables.sql理解非事务性表和事务性表
-- Filename:non-trans-tables.sql

DROP TABLE IF EXISTS non_trans_parent;
CREATE TABLE non_trans_parent
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	val VARCHAR(10) NOT NULL,
	PRIMARY KEY(id),
	UNIQUE KEY(val)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS non_trans_child;
CREATE TABLE non_trans_child
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	parent_id INT UNSIGNED NOT NULL,
	created TIMESTAMP NOT NULL,
	PRIMARY KEY(id),
	INDEX (parent_id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Test
START TRANSACTION;
INSERT INTO non_trans_parent(val) VALUES ('a');
INSERT INTO non_trans_child(parent_id,created) VALUES (LAST_INSERT_ID(),NOW());


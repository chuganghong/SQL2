-- Filename:fulltext.sql
-- 全文索引学习

USE studysql;

SET NAMES utf8;

CREATE TABLE books_text
(
	book_id INT NULL DEFAULT 0,
	title VARCHAR(64) DEFAULT '',
	content text,
	PRIMARY KEY (book_id),
	FULLTEXT INDEX title (title),
	FULLTEXT INDEX content (content)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
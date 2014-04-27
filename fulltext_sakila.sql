-- Filename:fulltext_sakila.sql
-- 使用sakila数据学习全文索引

-- 自然语言模式
SELECT film_id, title FROM film_text
WHERE MATCH(title,description)
AGAINST('Frisbee' IN NATURAL LANGUAGE MODE) 
LIMIT 6; 

-- 自然语言模式
SELECT film_id, title,description FROM film_text
WHERE MATCH(title,description)
AGAINST('Frisbee' IN NATURAL LANGUAGE MODE) 
LIMIT 2\G

-- 自然语言模式
SELECT film_id, title,description FROM film_text
WHERE MATCH(title)
AGAINST('Frisbee' IN NATURAL LANGUAGE MODE) 
LIMIT 2\G

-- 自然语言模式
SELECT film_id, title,description FROM film_text
WHERE MATCH(title,description)
AGAINST('FLYING HOOK' IN NATURAL LANGUAGE MODE) 
LIMIT 5\G

-- 自然语言模式
SELECT film_id, title,description FROM film_text
WHERE MATCH(title,description)
AGAINST('FLYING' IN NATURAL LANGUAGE MODE) 
LIMIT 5\G

-- 自然语言模式
SELECT film_id, title,description FROM film_text
WHERE MATCH(title,description)
AGAINST('FLYING And' IN NATURAL LANGUAGE MODE) 
LIMIT 5\G

-- 布尔模式
SELECT film_id,title,description FROM film_text
WHERE MATCH(title,description)
AGAINST ('technical +writer' IN BOOLEAN MODE)
LIMIT 5\G

-- 布尔模式
SELECT film_id,title,description FROM film_text
WHERE MATCH(title,description)
AGAINST ('technical -writer' IN BOOLEAN MODE)
LIMIT 6\G

-- 布尔模式
SELECT film_id,title,description FROM film_text
WHERE MATCH(title,description)
AGAINST ('"Fight a Pastry Chef"' IN BOOLEAN MODE)
LIMIT 5\G
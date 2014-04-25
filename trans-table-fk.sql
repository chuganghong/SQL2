-- 结合trans-tables.sql理解Consistency
-- Filename:trans-table-fk.sql

TRUNCATE TABLE trans_parent;
DROP TABLE IF EXISTS trans_child_fk;
CREATE TABLE trans_child_fk
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	parent_id INT UNSIGNED NOT NULL,
	created TIMESTAMP NOT NULL,
	PRIMARY KEY(id),
	INDEX(parent_id),
	FOREIGN KEY(parent_id) REFERENCES trans_parent(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '设置了foreign key的table';

-- test Consistency
START TRANSACTION; -- 若没有此句，就没有使用事务，就不能执行ROLLBACK
INSERT INTO trans_parent (val) VALUES ('a');
INSERT INTO trans_child_fk (parent_id, created) VALUES (999, NOW());
/* 执行上述代码的时候，出现报错信息：
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`studysql`.`tr
ans_child_fk`, CONSTRAINT `trans_child_fk_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `trans_parent
` (`id`)) 
虽然出现了报错信息，但第一条insert语句执行了，第二条insert没有执行。可是事务是作为一个整体执行，若第二条insert没有成功
第二条insert就应该也不成功才对。实际运行结果却不是这样。看来，事务，主要作用就是可以回滚吧。
*/

-- 再用这段代码
START TRANSACTION;
INSERT INTO trans_parent (val) VALUES ('a');
-- INSERT INTO trans_parent (val) VALUES ('b');
INSERT INTO trans_child_fk (parent_id, created) VALUES (LAST_INSERT_ID(), NOW());
COMMIT;
-- 通过测试

-- table trans_parent 清空
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE trans_parent;
SET FOREIGN_KEY_CHECKS=1;
-- 通过测试

-- delete data of trans_parent
START TRANSACTION;
DELETE FROM trans_parent;
/*报错信息： ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`studysql`
.`trans_child_fk`, CONSTRAINT `trans_child_fk_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `trans_pa
rent` (`id`)) */

-- 级联约束
ALTER TABLE trans_child_fk
DROP FOREIGN KEY trans_child_fk_ibfk_1,-- 此处的foreign key不应该是parent_id吗？
ADD FOREIGN KEY (parent_id) REFERENCES trans_parent(id)
ON DELETE CASCADE;

START TRANSACTION;
DELETE FROM trans_parent;
COMMIT;
/* 通过了测试，经过上面的代码的作用之后，可以在删除table trans_parent中的数据的同时，
自动删除了table trans_child_fk中的数据 */

SELECT * FROM trans_parent;
SELECT * FROM trans_child_fk;


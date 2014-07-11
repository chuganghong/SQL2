-- SELECT example

SELECT MATCHNO,WON-LOST
FROM MATCHES
WHERE WON = LOST + 2;

-- 批量替换
UPDATE cdc_integral_log SET `desc`=REPLACE(`desc`, '<img', '<img style="width:100px;height:80px;" ');

SET @name = 'Jim';
SELECT @name;
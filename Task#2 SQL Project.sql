#Задание №2

-- Создание базы данных mini_project
CREATE DATABASE IF NOT EXISTS mini_project;

-- Использование базы данных mini_project
USE mini_project;

-- Создание таблицы T_TAB1
CREATE TABLE IF NOT EXISTS T_TAB1 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    GOODS_TYPE VARCHAR(100),
    QUANTITY INT,
    AMOUNT INT,
    SELLER_NAME VARCHAR(100)
);

-- Создание таблицы T_TAB2
CREATE TABLE IF NOT EXISTS T_TAB2 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100),
    SALARY INT,
    AGE INT
);

-- Добавление данных в таблицу T_TAB1
INSERT INTO T_TAB1 (GOODS_TYPE, QUANTITY, AMOUNT, SELLER_NAME)
VALUES
    ('MOBILE PHONE', 2, 400000, 'MIKE'),
    ('KEYBOARD', 1, 10000, 'MIKE'),
    ('MOBILE PHONE', 1, 50000, 'JANE'),
    ('MONITOR', 1, 110000, 'JOE'),
    ('MONITOR', 2, 80000, 'JANE'),
    ('MOBILE PHONE', 1, 130000, 'JOE'),
    ('MOBILE PHONE', 1, 60000, 'ANNA'),
    ('PRINTER', 1, 90000, 'ANNA'),
    ('KEYBOARD', 2, 10000, 'ANNA'),
    ('PRINTER', 1, 80000, 'MIKE');

-- Добавление данных в таблицу T_TAB2
INSERT INTO T_TAB2 (NAME, SALARY, AGE)
VALUES
    ('ANNA', 110000, 27),
    ('JANE', 80000, 25),
    ('MIKE', 120000, 25),
    ('JOE', 70000, 24),
    ('RITA', 120000, 29);

-- Пример SQL запроса с JOIN по имени продавца
SELECT 
    T1.ID,
    T1.GOODS_TYPE,
    T1.QUANTITY,
    T1.AMOUNT,
    T2.NAME AS SELLER_NAME,
    T2.SALARY,
    T2.AGE
FROM 
    T_TAB1 T1
JOIN 
    T_TAB2 T2 ON T1.SELLER_NAME = T2.NAME;


-- 1.Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). Какое количество уникальных категорий товаров вернёт запрос?
SELECT DISTINCT GOODS_TYPE AS 'категория товаров', COUNT(GOODS_TYPE) AS 'количество'
FROM T_TAB1
GROUP BY GOODS_TYPE;



-- 2.Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?
SELECT 
    SUM(QUANTITY) AS 'суммарное количество', 
    SUM(AMOUNT) AS 'суммарная стоимость' 
FROM 
    T_TAB1
WHERE GOODS_TYPE = 'MOBILE PHONE';

-- 3.Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?
SELECT 
    NAME, 
    SALARY
FROM 
    T_TAB2
WHERE 
	SALARY> 100000;
    
-- 4.Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.
SELECT 
    MIN(AGE) AS min_age,
    MAX(AGE) AS max_age,
    MIN(SALARY) AS min_salary,
    MAX(SALARY) AS max_salary
FROM T_TAB2;

-- 5.Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
SELECT
    GOODS_TYPE,
    AVG(QUANTITY) AS average_quantity
FROM 
    T_TAB1
WHERE GOODS_TYPE IN ('KEYBOARD', 'PRINTER')
GROUP BY GOODS_TYPE;

-- 6.Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
SELECT
    SELLER_NAME,
    SUM(AMOUNT) AS sum_amount
FROM 
    T_TAB1
GROUP BY SELLER_NAME;

-- 7.Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.
SELECT
	DISTINCT T1.SELLER_NAME,
    T1.GOODS_TYPE,
    T1.QUANTITY,
    T1.AMOUNT,
    T2.SALARY,
    T2.AGE
FROM 
    T_TAB1 T1
JOIN 
    T_TAB2 T2 ON T1.SELLER_NAME = T2.NAME
WHERE 
	T1.SELLER_NAME='MIKE';

-- 8.Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?
SELECT
	DISTINCT T1.SELLER_NAME,
    T2.AGE
FROM 
    T_TAB1 T1
JOIN 
    T_TAB2 T2 ON T1.SELLER_NAME = T2.NAME
WHERE 
	 T1.QUANTITY= 0;
    
-- 9.Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос?
SELECT
	DISTINCT T1.SELLER_NAME,
    T2.SALARY
FROM 
    T_TAB1 T1
JOIN 
    T_TAB2 T2 ON T1.SELLER_NAME = T2.NAME
WHERE 
	 T2.AGE < 26;
-- 10. Сколько строк вернёт следующий запрос:
SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';

 
 
 
SELECT * FROM T_TAB1;
SELECT * FROM T_TAB2;
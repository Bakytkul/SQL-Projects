#Задание #1

CREATE DATABASE users_adverts;
USE users_adverts;


SELECT * FROM user;

-- 1. Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице 
-- в период с 2023-11-07 по 2023-11-15.

SELECT COUNT(DISTINCT user_id) AS Count_Id FROM user
WHERE date BETWEEN '2023-11-07' AND  '2023-11-15';


-- 2.Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 
USE users_adverts;

SELECT 
    user_id,
    SUM(view_adverts) AS total_views
FROM 
    user
GROUP BY 
    user_id
ORDER BY 
    total_views DESC
LIMIT 1;

-- 3. Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.
USE users_adverts;

SELECT
    date,
    AVG(total_views / unique_users) AS avg_views_per_user
FROM (
    SELECT
        date,
        COUNT(DISTINCT user_id) AS unique_users,
        SUM(view_adverts) AS total_views
    FROM
        user
    GROUP BY
        date
    HAVING
        unique_users > 500
) AS subquery
GROUP BY
    date
ORDER BY
    avg_views_per_user DESC
LIMIT 1;


-- 4. Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.
SELECT 
    user_id,
    COUNT(DISTINCT date) AS total_days
FROM 
    user
GROUP BY 
    user_id
ORDER BY 
    total_days DESC;

-- 5. Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, 
-- у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.
USE users_adverts;

SELECT 
    user_id,
    avg_views_per_day
FROM (
    SELECT 
        user_id,
        COUNT(DISTINCT date) AS active_days,
        AVG(view_adverts) AS avg_views_per_day
    FROM 
        user
    GROUP BY 
        user_id
) AS user_stats
WHERE 
    active_days >= 5
ORDER BY 
    avg_views_per_day DESC
LIMIT 1;

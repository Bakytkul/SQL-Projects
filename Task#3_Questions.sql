-- Question#1
-- Выведите сколько пользователей добавили книгу 'Coraline', сколько пользователей прослушало больше 10%. 

SELECT 
    COUNT(DISTINCT ac.user_id) AS users_added_coraline,
    COUNT(DISTINCT CASE 
                      WHEN (l.position_to - l.position_from) > 0.1 * (ab.duration - l.position_from) 
                      THEN l.user_id 
                   END) AS users_listened_over_10_percent
FROM 
    audiobooks ab
JOIN 
    audio_cards ac ON ac.audiobook_uuid = ab.uuid
JOIN 
    listenings l ON l.audiobook_uuid = ab.uuid
WHERE 
    ab.title = 'Coraline';




-- Question#2
-- По каждой операционной системе и названию книги выведите количество пользователей, сумму прослушивания в часах, не учитывая тестовые прослушивания. 
SELECT 
    ab.title AS book_title,
    l.os_name AS operating_system,
    COUNT(DISTINCT l.user_id) AS user_count,
    SUM((l.position_to - l.position_from) / 3600.0) AS total_listening_hours
FROM 
    listenings l
JOIN 
    audiobooks ab ON l.audiobook_uuid = ab.uuid
WHERE 
    l.is_test = 0
GROUP BY 
    ab.title, l.os_name
ORDER BY 
    ab.title, l.os_name;


-- Question#3
-- Найдите книгу, которую слушает больше всего людей. 
SELECT 
    ab.title AS book_title,
    COUNT(DISTINCT l.user_id) AS user_count
FROM 
    listenings l
JOIN 
    audiobooks ab ON l.audiobook_uuid = ab.uuid
GROUP BY 
    ab.title
ORDER BY 
    user_count DESC
LIMIT 1;


-- Question#4
-- Найдите книгу, которую чаще всего дослушивают до конца.
SELECT 
    ab.title AS book_title,
    COUNT(DISTINCT l.user_id) AS user_count
FROM 
    listenings l
JOIN 
    audiobooks ab ON l.audiobook_uuid = ab.uuid
WHERE 
    l.position_to >= ab.duration
GROUP BY 
    ab.title
ORDER BY 
    user_count DESC
LIMIT 1;



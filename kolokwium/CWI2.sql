--Znajdź identyfikatory ćwierków o treści
--dłuższej niż 250 znaków

SELECT tweet_id, CHAR_LENGTH(text)
FROM tweets
WHERE CHAR_LENGTH(text) > 250
ORDER BY CHAR_LENGTH(text);

-- 2. Znajdź teksty ćwierków o liczbie 
--polubień większej od 4. 

SELECT text, likes
FROM tweets
WHERE likes > 4;

-- 3. Wypisz loginy użytkowników, którzy nie 
--zarejestrowali się ani w sobotę ani w niedzielę. 

SELECT login
FROM users
WHERE to_char(registered, 'FMDay') NOT IN ('Saturday', 'Sunday');

-- 4. Wypisz nazwy dni tygodnia, w które zarejestrowało się
--więcej niż piętnastu użytkowników


SELECT to_char(registered, 'FMDay'), COUNT( DISTINCT user_id)
FROM users
GROUP BY to_char(registered, 'FMDay')
HAVING COUNT(DISTINCT user_id) > 15;

-- 5. Wypisz login każdego użytkownika wraz
--z liczbą obserwowanych przez niego użytkowników.  

SELECT login, COUNT(follows_id) AS liczba_osob_obserwowanych
FROM users
LEFT JOIN follows
USING(user_id)
GROUP BY user_id;

--6. Wypisz login każdego użytkownika wraz z liczbą
--użytkowników obserwujących go bezpośrednio. 

SELECT login, COUNT(follows.user_id) AS liczba_obserwatorow
FROM users
LEFT JOIN follows
ON users.user_id = follows.follows_id
GROUP BY login;

--7. Wypisz loginy użytkowników, którzy opublikowali ćwierk 
--w dniu rejestracji. 

SELECT DISTINCT login, u.registered, t.posted_date
FROM users AS u
JOIN tweets AS t
ON u.user_id = t.posted_by
WHERE u.registered = t.posted_date;

-- 8. Znajdź loginy użytkowników, których opublikowali ćwierk
--z największą liczbą polubień. 

SELECT login, likes
FROM users u
JOIN tweets t
ON u.user_id = t.posted_by
WHERE likes = (SELECT MAX(likes) FROM tweets);

--9. Wypisz loginy użytkowników, którzy opublikowali ćwierki z
--największą liczbą wyświetleń.  

SELECT login, views
FROM users u
JOIN tweets t
ON u.user_id = t.posted_by
WHERE views = (SELECT MAX(views) FROM tweets);

--10. Wypisz loginy użytkowników wraz z liczbą różnych użytkowników,
--którzy polubili któryś z ich postów.  

SELECT * FROM tweets;
SELECT * FROM likes;
SELECT * FROM users;

SELECT login, count(distinct likes.user_id)
FROM users
LEFT JOIN tweets
ON users.user_id = tweets.posted_by
LEFT JOIN likes
ON tweets.tweet_id = likes.likes_post
GROUP BY login, users.user_id;

--11. Wypisz loginy użytkowników obserwowanych
--(bezpośrednio) przez użytkownika @ljaskowicz2o.  

SELECT login
FROM users
INNER JOIN follows
ON users.user_id = follows.follows_id
WHERE follows.user_id = (SELECT user_id FROM users 
WHERE login = '@ljaskowicz2o');

--12. Wypisz loginy użytkowników obserwujących
--(bezpośrednio) użytkownika @ljaskowicz2o. (3) 

SELECT login
FROM users
INNER JOIN follows
USING(user_id)
WHERE follows.follows_id = (SELECT user_id FROM users 
WHERE login = '@ljaskowicz2o');

--13. Znajdź loginy użytkowników, 
--obserwujących największą liczbę użytkowników.  

SELECT * FROM follows;

SELECT login, COUNT(follows_id)
FROM follows
INNER JOIN users
USING(user_id)
GROUP BY login
HAVING COUNT(follows_id) = (SELECT COUNT(follows_id)
FROM follows GROUP BY user_id ORDER BY COUNT(follows_id) DESC LIMIT 1);

--14. Znajdź loginy użytkowników, 
--obserwowanych przez największą liczbę użytkowników.  

SELECT login, COUNT(follows.user_id)
FROM follows
INNER JOIN users
ON follows.follows_id = users.user_id
GROUP BY login
HAVING COUNT(follows.user_id) = (SELECT COUNT(user_id)
FROM follows GROUP BY follows_id ORDER BY COUNT(user_id) DESC LIMIT 1);

--15. Wypisz ćwierki otagowane najdłuższym tagiem.  

SELECT * FROM tags;
SELECT * FROM tagged;
SELECT * FROM tweets;

SELECT tweet_id, length(tags.name)
FROM tweets
INNER JOIN tagged
USING(tweet_id)
INNER JOIN tags
USING(tag_id)
WHERE length(tags.name) = (SELECT MAX(length(name)) FROM tags) ;


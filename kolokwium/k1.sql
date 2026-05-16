--7

SELECT * FROM tweets;

SELECT * FROM users;

SELECT DISTINCT login
FROM users AS u
INNER JOIN tweets AS t
ON u.user_id = t.posted_by
WHERE registered = posted_date
ORDER BY login;

--8

SELECT likes
FROM tweets
ORDER BY likes DESC;

SELECT DISTINCT login, likes 
FROM tweets AS t
INNER JOIN users AS u
ON u.user_id = t.posted_by
WHERE likes = (SELECT MAX(likes) FROM tweets);

--9

SELECT views
FROM tweets
ORDER BY views DESC;

SELECT  DISTINCT login, views 
FROM tweets AS t
INNER JOIN users AS u
ON u.user_id = t.posted_by
WHERE views = (SELECT MAX(views) FROM tweets);

--10

SELECT * FROM likes;
SELECT * FROM users;
SELECT * FROM tweets;

SELECT login, COUNT(DISTINCT l.user_id)
FROM users AS u
INNER JOIN tweets AS t
ON u.user_id = t.posted_by
INNER JOIN likes AS l
ON t.tweet_id = l.likes_post
GROUP BY login;

--11

SELECT * FROM follows;
SELECT * FROM users;

SELECT login
FROM users AS u
INNER JOIN follows AS f
ON u.user_id = f.follows_id
WHERE f.user_id = (SELECT user_id FROM users WHERE login = '@ljaskowicz2o');

--12 analogiczne

--13

SELECT * FROM follows;
SELECT * FROM users;

SELECT f.user_id, u.login, COUNT(f.follows_id)
FROM follows as f
INNER JOIN users as u
USING(user_id)
GROUP BY f.user_id, u.login
HAVING COUNT(f.follows_id) = (SELECT COUNT(follows_id) 
							FROM follows 
							GROUP BY user_id 
							ORDER BY COUNT(follows_id) DESC
							LIMIT 1)
;

--15

SELECT * FROM tags;
SELECT * FROM tagged;

SELECT tweet_id, length(name)
FROM tagged as td
INNER JOIN tags as ts
USING(tag_id)
WHERE length(name) = (SELECT length(name)
							FROM tags
							ORDER BY length(name) DESC
							LIMIT 1);

--alternatywna wersja

SELECT tweet_id, length(name)
FROM tagged as td
INNER JOIN tags as ts
USING(tag_id)
WHERE length(name) = (SELECT max(length(name)) FROM tags);

--16.2

SELECT * FROM tweets;
SELECT COUNT(tweet)

---REKURENCJA

--21. Wypisz identyfikatory ćwierków cytujących ćwierk (pośrednio lub bezpośrednio – do
--trzeciego poziomu w głąb) o identyfikatorze 195.

SELECT * FROM tweets;

WITH RECURSIVE cwie AS(
SELECT tweet_id, cites, ARRAY[tweet_id] AS wypisane, 0 AS poziom
FROM tweets 
WHERE tweet_id = 195
UNION ALL
SELECT t.tweet_id, t.cites, cwie.wypisane || t.tweet_id, poziom + 1
FROM tweets as t
INNER JOIN cwie
ON t.cites = cwie.tweet_id
WHERE NOT (t.tweet_id = ANY(cwie.wypisane)) AND poziom < 3)
SELECT * FROM cwie WHERE tweet_id != 195;


--22. Wypisz identyfikatory użytkowników obserwowanych (bezpośrednio lub pośrednio –
--do drugiego poziomu obserwacji) przez użytkownika @ljaskowicz2o.

SELECT * FROM follows;
SELECT * FROM users;

WITH RECURSIVE fol AS(
SELECT user_id, follows_id, ARRAY[user_id] AS wypisane, 0 AS poziom
FROM follows 
WHERE user_id IN (SELECT user_id FROM users WHERE login = '@ljaskowicz2o')
UNION ALL
SELECT f.user_id, f.follows_id, wypisane || f.user_id, poziom + 1
FROM follows AS f
INNER JOIN fol
ON f.user_id = fol.follows_id
WHERE NOT (f.user_id = ANY(wypisane)) AND poziom <1
)
SELECT * FROM fol;


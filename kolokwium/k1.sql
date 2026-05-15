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


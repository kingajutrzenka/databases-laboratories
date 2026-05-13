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

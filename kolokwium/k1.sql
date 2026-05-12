SELECT * 
FROM tweets
ORDER BY tweet_id;

--1 

SELECT tweet_id
FROM tweets
GROUP BY tweet_id
HAVING LENGTH(text) > 250;

--2

SELECT text, likes
FROM tweets
WHERE likes > 4
ORDER BY likes;

--3

SELECT * FROM users;

SELECT login, TRIM(TO_CHAR(registered, 'Day'))
FROM users
WHERE TRIM(TO_CHAR(registered, 'Day')) NOT IN('Saturday', 'Sunday');

--4 

SELECT COUNT(login), TRIM(TO_CHAR(registered, 'Day'))
FROM users
GROUP BY TRIM(TO_CHAR(registered, 'Day'))
HAVING COUNT(login) > 15;

--5

SELECT * FROM follows;

SELECT COUNT(follows_id), user_id
FROM follows
GROUP BY user_id
ORDER BY COUNT(follows_id);

--6

SELECT COUNT(user_id), follows_id
FROM follows
GROUP BY follows_id
ORDER BY COUNT(user_id);

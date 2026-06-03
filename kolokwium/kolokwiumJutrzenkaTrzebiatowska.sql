--Kinga Jutrzenka Trzebiatowska
--dodawałam aliasy tylko, gdzie była konieczna potrzeba lub czułam potrzebe

--1 

SELECT SUM(views) AS suma_wyswietlen, to_char(posted_date, 'Day') AS dzien_tygodnia, posted_by AS identyfikator_uzytkownika
FROM tweets
GROUP BY CUBE(to_char(posted_date, 'Day'), posted_by);

--2

SELECT tweet_id, cites
FROM tweets
WHERE cites != 3 OR cites IS NULL
ORDER BY tweet_id;

--3

SELECT * FROM tagged;
select * FROM tags;

SELECT tw.tweet_id, ts.name
FROM tweets AS tw
LEFT JOIN tagged
USING(tweet_id)
LEFT JOIN tags AS ts
USING(tag_id)
ORDER BY tweet_id DESC;

--4

-- zrozumiałam z polecenia, że brak polubień też może być minimalną liczbą

SELECT login
FROM users AS u
JOIN tweets AS t
ON u.user_id = t.posted_by
WHERE likes = (SELECT MIN(likes) FROM tweets);

--5

WITH RECURSIVE obserwowanie AS(
SELECT fo.user_id,
fo.follows_id,
1 AS poziom
FROM follows AS fo
WHERE follows_id IN (SELECT user_id FROM users WHERE login LIKE '%ar%')

UNION ALL

SELECT f.user_id,
f.follows_id,
o.poziom +1
FROM follows AS f
JOIN obserwowanie AS o 
ON f.follows_id = o.user_id
WHERE o.poziom < 2) 

SELECT 
o.user_id as id_osoby_obserwujacej, 
o.poziom,
u.login as login_obserowanej_osoby
FROM obserwowanie AS o
JOIN users AS u
ON o.follows_id = u.user_id
WHERE login LIKE '%ar%'
ORDER BY login DESC, poziom;



--Zadania zamieszczone poniżej dotyczą bazy testowej o nazwie cwierkacz, 
--dostępnej na serwerze sxterm.mat.umk.pl. 


--1. Wypisz identyfikatory ćwierków cytowanych w ćwierku (pośrednio lub bezpośrednio)
--o identyfikatorze 4.

--Poniżej wpisz rozwiązanie:

SELECT * FROM tweets;

WITH RECURSIVE cwi AS(
SELECT * 
FROM tweets
WHERE tweet_id = 4

UNION ALL

SELECT t.*
FROM tweets as t
INNER JOIN cwi
ON t.tweet_id = cwi.cites)

SELECT tweet_id 
FROM cwi
WHERE tweet_id != 4;

--20. Wypisz identyfikatory ćwierków cytowanych w ćwierku (pośrednio lub bezpośrednio)
--o identyfikatorze 3. [Uwaga. Tutaj szczególnie zastanów się nad warunkiem stopu.]

--Poniżej wpisz rozwiązanie:

WITH RECURSIVE cwie AS(
SELECT tweet_id,
cites,
ARRAY[tweet_id] AS wypisane --
FROM tweets 
WHERE tweet_id = 3

UNION ALL

SELECT t.tweet_id, t.cites, cwie.wypisane || t.tweet_id
FROM tweets as t
INNER JOIN cwie
ON t.tweet_id = cwie.cites
WHERE NOT (t.tweet_id = ANY(cwie.wypisane))) --
SELECT tweet_id FROM cwie WHERE tweet_id != 3;


-- 21.Wypisz identyfikatory ćwierków cytujących ćwierk (pośrednio lub bezpośrednio – do
--trzeciego poziomu w głąb) o identyfikatorze 195

WITH RECURSIVE cwie AS (
    SELECT 
        tweet_id, 
        cites, 
        ARRAY[tweet_id] AS wypisane, 
        0 AS poziom  --                
    FROM tweets 
    WHERE tweet_id = 195
    
    UNION ALL
    
    SELECT 
        t.tweet_id, 
        t.cites, 
        cwie.wypisane || t.tweet_id, 
        cwie.poziom + 1     --         
    FROM tweets AS t
    INNER JOIN cwie ON t.cites = cwie.tweet_id
    WHERE NOT (t.tweet_id = ANY(cwie.wypisane))
      AND cwie.poziom < 3           --
)
SELECT tweet_id 
FROM cwie 
WHERE tweet_id != 195;

--22. Wypisz identyfikatory użytkowników obserwowanych (bezpośrednio lub pośrednio –
--do drugiego poziomu obserwacji) przez użytkownika @ljaskowicz2o.


WITH RECURSIVE obserw AS(
	SELECT 
		user_id,
		follows_id,
		0 AS poziom,
	FROM follows
	WHERE user_id = (SELECT user_id FROM users WHERE login = '@ljaskowicz2o')
	
UNION ALL

	SELECT 
		f.user_id,
		f.follows_id,
		obserw.poziom + 1
	FROM follows AS f
	INNER JOIN obserw ON f.user_id = obserw.follows_id
	WHERE obserw.poziom < 1

)
SELECT DISTINCT follows_id FROM obserw;

--wersja z ARRAY

WITH RECURSIVE obserw AS(
	SELECT 
		user_id,
		follows_id,
		0 AS poziom,
		ARRAY[user_id] AS odwiedzeni
	FROM follows
	WHERE user_id = (SELECT user_id FROM users WHERE login = '@ljaskowicz2o')
	
UNION ALL

	SELECT 
		f.user_id,
		f.follows_id,
		obserw.poziom + 1,
		obserw.odwiedzeni || f.user_id
	FROM follows AS f
	INNER JOIN obserw ON f.user_id = obserw.follows_id
	WHERE obserw.poziom < 1 AND NOT (f.user_id = ANY(obserw.odwiedzeni))

)
SELECT DISTINCT follows_id FROM obserw;



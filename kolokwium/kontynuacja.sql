--16. Jednym poleceniem wypisz liczbę ćwierków dla następujących poziomów grupowania:  

--1) liczby polubień i długości tekstu  

--2) liczby polubień  

--3) liczby postów o danej długości tekstu 

--4) wszystkich rekordów.  

SELECT * FROM  tweets;

SELECT likes, length(text), COUNT(tweet_id) AS liczba_ćwierkow
FROM tweets
GROUP BY GROUPING SETS(
(likes, length(text)),
(likes),
(length(text)),
());

--lub możemy użyć CUBE

SELECT likes,length(text), COUNT(tweet_id) AS liczba_ćwierkow
FROM tweets
GROUP BY CUBE(likes, length(text));

--17. Jednym poleceniem pogrupuj użytkowników względem dnia
--tygodnia rejestracji i liczby opublikowanych ćwierków i 
--utwórz zestawienie zawierające liczby postów w poszczególnych
--grupach oraz podsumowania częściowe.  

SELECT to_char(registered, 'Day'), user_id, COUNT(tweet_id) AS liczba_cwierkow
FROM users
LEFT JOIN tweets
ON users.user_id = tweets.posted_by
GROUP BY ROLLUP(to_char(registered, 'Day'),  user_id);

---18. Nie używając operatora LIMIT wypisz identyfikatory siedmiu
--użytkowników z najwcześniejszymi datami rejestracji. Jeśli na 7.
--miejscu jest więcej niż jeden użytkownik, to należy wypisać 
--wszystkich. 

SELECT * FROM users;

WITH uzytkownik AS(
SELECT user_id,registered,
rank() OVER (ORDER BY registered) AS data
FROM users)
SELECT user_id, registered
FROM uzytkownik
WHERE data <= 7
ORDER BY registered;

--Uwaga!! dopiski tylko po to by sprawdzić poprawność

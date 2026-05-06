-- Polecenie rekurencyjne wyświetla wszystkich podwładnych pracownika o id równym 8.
--w1
WITH RECURSIVE podwladni(i) 
AS(
SELECT id from pracownicy WHERE boss=8
UNION ALL
SELECT p.id FROM pracownicy p JOIN podwladni ON p.boss = i)
SELECT 	i FROM podwladni;

--w2
WITH RECURSIVE podwladni(i, f, l) 
AS(
SELECT id, first_name, last_name from pracownicy WHERE boss=8
UNION ALL
SELECT p.id, p.first_name, p.last_name FROM pracownicy p JOIN podwladni ON p.boss = i)
SELECT f, l FROM podwladni;

--w3

WITH RECURSIVE podwladni(i) 
AS(
SELECT id from pracownicy WHERE boss=8
UNION ALL
SELECT p.id FROM pracownicy p JOIN podwladni ON p.boss = i)
SELECT first_name, last_name
FROM podwladni
INNER  JOIN pracownicy
ON i = id;

--w4

WITH RECURSIVE podwladni(i) 
AS(
SELECT 8
UNION ALL
SELECT p.id FROM pracownicy p JOIN podwladni ON p.boss = i)
SELECT first_name, last_name
FROM podwladni
INNER  JOIN pracownicy
ON i = id
WHERE i != 8;

WITH RECURSIVE podwladni(i, s) 
AS(
SELECT 8,0
UNION ALL
SELECT p.id, s+1 FROM pracownicy p JOIN podwladni ON p.boss = i)
SELECT i, first_name, last_name
FROM podwladni
INNER  JOIN pracownicy
ON i = id
WHERE s > 1;

----- coś, coś, coś
-- Polecenie rekurencyjnie dla każdej osoby o imieniu Ernesta wyszukuje i wyświetla
--identyfikatory wszystkich jej podwładnych – w parze z zapamiętanym identyfikatorem osoby
--Ernesta

WITH RECURSIVE er(i, s)
AS(
SELECT id, id from pracownicy WHERE first_name='Ernesta'
UNION ALL
SELECT p.id, s FROM pracownicy p JOIN er ON p.boss = i)
SELECT i, first_name, last_name, s
FROM er
INNER  JOIN pracownicy
ON i = id;
----- s wskazuje której ernesty jest podwładny dany pracownik

--WITH RECURSIVE Npodwladni(i, s) 
--AS(
--SELECT boss, id FROM pracownicy WHERE id=11
--UNION ALL
--SELECT p.boss FROM pracownicy p JOIN Nodwladni ON p.id = i)
--SELECT i, first_name, last_name
--FROM Npodwladni	
--INNER  JOIN pracownicy
--ON i = id;



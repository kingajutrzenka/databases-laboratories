-- Rekurecja 

-- Polecenie rekurencyjnie oblicza kolejne potęgi liczby 3 (od 1-szej do 5-tej)

WITH RECURSIVE potegi(n, s) AS (
  -- n to wykładnik, s to wynik potęgowania
  SELECT 1, 3 
  UNION ALL
  SELECT n + 1, s * 3 FROM potegi WHERE n < 5
)
SELECT '3^' || n || ' = ' || s AS wynik FROM potegi;

-- Polecenie rekurencyjnie oblicza sumy kolejnych liczb naturalnych od 1 do 10 (1, 1+2, …, 1+2+ … + 10).

WITH RECURSIVE dodawanie(n, s) AS (
  SELECT 1, 1
  UNION ALL
  SELECT n+ 1, s + (n + 1) FROM dodawanie WHERE n < 10)
SELECT 'Suma liczb od 1 do ' || n || ' = ' || s AS wynik FROM  dodawanie;

--Polecenie rekurencyjnie oblicza sumy kolejnych liczb nieparzystych od 1 do 11 (1, 1 +3, 1 +3 +5, …, 1+3+…+11).

WITH RECURSIVE dodawanie(n, s) AS (
  SELECT 1, 1
  UNION ALL
  SELECT n+ 2, s + (n + 2) FROM dodawanie WHERE n < 10)
SELECT 'Suma liczb od 1 do ' || n || ' = ' || s AS wynik FROM  dodawanie;

--  Polecenie wypisuje kolejno liczby – od numeru bieżącego roku do 2000.

WITH RECURSIVE lata(s) AS (
  SELECT 2026
  UNION ALL
  SELECT s - 1 FROM lata WHERE s > 2000)
SELECT 'Lata ' || s AS wynik FROM lata;

--  Polecenie rekurencyjnie wyznacza początkowe wyrazy ciągu Fibonacciego – od pierwszego do dziesiątego.

WITH RECURSIVE f(n, o, na) AS (
  SELECT 1, 0, 1
  UNION ALL
  SELECT n + 1,
  na,
  o + na
  FROM f
  WHERE n < 10)
SELECT 'fi' || o  FROM f;

  
  
  

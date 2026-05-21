-- 1. Czyszczenie starych tabel (jeśli istnieją), żeby można było uruchamiać skrypt wielokrotnie
DROP TABLE IF EXISTS filie_warszawa;
DROP TABLE IF EXISTS filie_krakow;

-- 2. Tworzenie tabeli dla Warszawy
CREATE TABLE filie_warszawa (
    isbn VARCHAR(20),
    tytul VARCHAR(100),
    stan_magazynowy INT
);

-- 3. Tworzenie tabeli dla Krakowa
CREATE TABLE filie_krakow (
    isbn VARCHAR(20),
    tytul VARCHAR(100),
    stan_magazynowy INT
);

-- 4. Wprowadzanie danych dla Warszawy
INSERT INTO filie_warszawa (isbn, tytul, stan_magazynowy) VALUES
('978-1','Władca Pierścieni', 5),
('978-2','Harry Potter', 12),
('978-3','Diuna', 8),
('978-4','Drakula', 3),
('978-5','Hobbit', 7),
('978-5','Hobbit', 7); -- Celowy duplikat do testów!

-- 5. Wprowadzanie danych dla Krakowa
INSERT INTO filie_krakow (isbn, tytul, stan_magazynowy) VALUES
('978-2','Harry Potter', 15),
('978-3','Diuna', 2),
('978-5','Hobbit', 4),
('978-6','Wiedźmin', 9),
('978-7','Frankenstein', 6);

-----------------------INTERSECT-----------------------

SELECT tytul
FROM filie_krakow 
INTERSECT
SELECT tytul
FROM filie_warszawa;

-----------------------UNION-----------------------------

SELECT tytul, isbn
FROM filie_krakow 
UNION
SELECT tytul, isbn
FROM filie_warszawa
ORDER BY tytul;

-----------------------EXCEPT----------------------------

SELECT tytul
FROM filie_krakow 
EXCEPT
SELECT tytul
FROM filie_warszawa;
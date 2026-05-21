-- Tworzymy tabelę pracowników
CREATE TABLE praco (
    id_pracownika SERIAL PRIMARY KEY,
    imie_nazwisko VARCHAR(100)
);

-- Tworzymy tabelę obowiązkowych szkoleń
CREATE TABLE szkolenia (
    id_szkolenia SERIAL PRIMARY KEY,
    nazwa_szkolenia VARCHAR(100)
);

-- Dodajemy przykładowych pracowników
INSERT INTO praco(imie_nazwisko) VALUES 
('Anna Kowalska'), 
('Jan Nowak'), 
('Piotr Wiśniewski');

-- Dodajemy listę szkoleń
INSERT INTO szkolenia (nazwa_szkolenia) VALUES 
('Szkolenie BHP'), 
('Ochrona Danych (RODO)'), 
('Pierwsza Pomoc');

---------------------zadanie 1--------------------------------

SELECT praco.imie_nazwisko,
szkolenia.nazwa_szkolenia
FROM praco
CROSS JOIN szkolenia
ORDER BY imie_nazwisko, szkolenia;

---------------------natural join-------------------------------

-- Dodajemy kolumnę łączącą do tabeli pracowników
ALTER TABLE praco ADD COLUMN id_szkolenia INT;

-- Przypisujemy pracownikom jakieś ukończone szkolenia
UPDATE praco SET id_szkolenia = 1 WHERE imie_nazwisko = 'Anna Kowalska'; -- BHP
UPDATE praco SET id_szkolenia = 2 WHERE imie_nazwisko = 'Jan Nowak';      -- RODO
UPDATE praco SET id_szkolenia = 1 WHERE imie_nazwisko = 'Piotr Wiśniewski'; -- BHP


---zad1b

SELECT praco.imie_nazwisko,
szkolenia.nazwa_szkolenia
FROM praco
NATURAL JOIN szkolenia; 

--

SELECT * FROM praco;

SELECT p1.imie_nazwisko,
p2.imie_nazwisko
FROM praaco AS p1
JOIN praco AS p2
ON p1.id_szkolenia = p2.id_szkolenia 
AND p1.imie_nazwisko < p2.imie_nazwisko;
--- Podzapytania skoreowane 🥲🥲🥲🥲-----

CREATE TABLE IF NOT EXISTS placki (
    id INT,
    imie TEXT,
    dzial TEXT,
    pensja INT
);

INSERT INTO placki VALUES
(1, 'Ania',   'Rowery Górskie', 6000),
(2, 'Bartek', 'Rowery Górskie', 4500),
(3, 'Kasia',  'Rowery Górskie', 7500),
(4, 'Tomek',  'Rowery Miejskie', 4000),
(5, 'Magda',  'Rowery Miejskie', 5500);

--1

SELECT p1.imie, p1.dzial, p1.pensja
FROM placki AS p1
WHERE p1.pensja > (
    -- To jest podzapytanie skorelowane
    SELECT AVG(p2.pensja) 
    FROM placki AS p2 
    WHERE p2.dzial = p1.dzial -- <--- TUTAJ JEST KOLELACJA!
);

--wyświetli najmniej zarabiającą osobę w każdym dziale

SELECT * FROM placki;

SELECT p1.imie, p1.dzial, p1.pensja
FROM placki AS p1
WHERE p1.pensja = (
    SELECT MIN(p2.pensja) 
    FROM placki AS p2 
    WHERE p2.dzial = p1.dzial);

-------EXISTS, NOT EXISTS---------------------

CREATE TABLE klienci (
    id INT,
    imie TEXT
);

CREATE TABLE zamowienia (
    id INT,
    klient_id INT,
    nazwa_placka TEXT
);

INSERT INTO klienci VALUES 
(1, 'Ania'), (2, 'Bartek'), (3, 'Zosia'), (4, 'Kamil');

INSERT INTO zamowienia VALUES 
(101, 1, 'Placek Węgierski'),
(102, 2, 'Placek po Zbójnicku'),
(103, 2, 'Placek Ziemniaczany');

--Chcemy wypisać tylko tych klientów, którzy złożyli przynajmniej jedno zamówienie.

SELECT k.imie 
FROM klienci k
WHERE EXISTS (
    SELECT *
    FROM zamowienia z 
    WHERE z.klient_id = k.id
);

--- SOSY

CREATE TABLE sosy (
    id INT,
    nazwa_sosu TEXT
);

CREATE TABLE zamowione_sosy (
    zamowienie_id INT,
    sos_id INT
);

-- Baza dostępnych sosów w plackarni
INSERT INTO sosy VALUES 
(1, 'Czosnkowy'), 
(2, 'Pomidorowy'), 
(3, 'Ostry'), 
(4, 'Tzatziki');

-- Sosy, które faktycznie zostały wybrane przez klientów w zamówieniach
INSERT INTO zamowione_sosy VALUES 
(101, 1), -- Ktoś do zamówienia 101 wziął sos Czosnkowy
(102, 1), -- Ktoś do zamówienia 102 wziął sos Czosnkowy
(103, 2); -- Ktoś do zamówienia 103 wziął sos Pomidorowy

--wróci nazwy sosów, które NIGDY nie 
--zostały zamówione przez żadnego klienta

SELECT * FROM sosy;
SELECT * FROM zamowione_sosy;

SELECT s.nazwa_sosu
FROM sosy AS s
WHERE NOT EXISTS(
SELECT * 
FROM zamowione_sosy AS z
WHERE s.id = z.sos_id);
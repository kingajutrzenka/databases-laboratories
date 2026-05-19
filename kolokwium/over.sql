-------------------OVER-------------------------

SELECT * FROM sklep_sprzedaz;

SELECT 
    region, 
    sklep, 
    utarg,
    SUM(utarg) OVER(PARTITION BY region) AS utarg_regionu
FROM 
    sklep_sprzedaz;

--

SELECT 
    region, 
    sklep, 
    utarg,
    DENSE_RANK() OVER(PARTITION BY region ORDER BY utarg DESC) AS miejsce_w_rankingu
FROM 
    sklep_sprzedaz;


--------------------CROSSTAB------------------------------

-- Włączamy rozszerzenie (na wypadek, gdyby nie było włączone)
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- Tworzymy tabelę testową
CREATE TABLE sprzedaz_rowerow (
    sprzedawca TEXT,
    kwartal TEXT,
    sztuki INT
);

-- Wrzucamy testowe dane
INSERT INTO sprzedaz_rowerow (sprzedawca, kwartal, sztuki) VALUES
('Ania', 'Q1', 12),
('Ania', 'Q2', 15),
('Ania', 'Q3', 18),
('Ania', 'Q4', 22),
('Bartek', 'Q1', 10),
-- Bartek w Q2 miał urlop i nic nie sprzedał (brak wiersza)
('Bartek', 'Q3', 25),
('Bartek', 'Q4', 30),
('Kasia', 'Q1', 14),
('Kasia', 'Q2', 19),
('Kasia', 'Q3', 11),
('Kasia', 'Q4', 15);

-- CROSSTAB

SELECT * FROM sprzedaz_rowerow;

SELECT * FROM crosstab(
$$ SELECT *
FROM sprzedaz_rowerow ORDER BY 1, 2$$,
$$ VALUES('Q1'), ('Q2'), ('Q3'), ('Q4') $$)
AS wykres(
sprzedawca TEXT,
Q1 INT, 
Q2 INT, 
Q3 INT,
Q4 INT
);

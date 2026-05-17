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

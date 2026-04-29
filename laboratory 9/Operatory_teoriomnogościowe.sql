--Polecenie sprawdza, które adresy występują jednocześnie w tabeli Dostawcy i tabeli Klienci

SELECT * FROM klienci;


--SELECT adres FROM klienci
--EXCEPT 
--SELECT adres FROM dostawcy;

--  Bez użycia DISTINCT wypisz bez powtórzeń wszystkie imiona Klientów.

SELECT imie FROM klienci
INTERSECT
SELECT imie FROM klienci;

--Wypisz w porządku alfabetycznym nazwiska klientów, umieszczając przy nazwiskach osób bez podanego numeru telefonu znak ‘–’.

SELECT nazwisko FROM klienci WHERE telefon IS NOT NULL
UNION
SELECT nazwisko || '-' FROM klienci WHERE telefon IS NOT NULL;

--  Polecenie wyświetla ISBN książek, które nigdy nie zostały zamówione


SELECT * FROM ksiazki;
SELECT * FROM zamowioneksiazki;

SELECT isbn from ksiazki
EXCEPT
SELECT isbn from zamowioneksiazki; 

-- Polecenie wyświetla imiona i nazwiska klientów, którzy mają na imię Jan lub nazwisko Zych.

SELECT imie, nazwisko FROM klienci
INTERSECT
SELECT imie, nazwisko FROM klienci WHERE imie = 'Jan' OR nazwisko = 'Zych';

SELECT imie, nazwisko FROM klienci WHERE imie = 'Jan' 
UNION
SELECT imie, nazwisko FROM klienci WHERE  nazwisko = 'Zych';

-- Polecenie wyświetla imiona i nazwiska klientów, którzy nie spełniają warunku z poprzedniego polecenia. Postaraj się napisać różne polecenia.

SELECT imie, nazwisko FROM klienci
EXCEPT
SELECT imie, nazwisko FROM klienci WHERE imie = 'Jan' OR nazwisko = 'Zych';

SELECT imie, nazwisko FROM klienci WHERE imie != 'Jan' AND nazwisko != 'Zych';

--Polecenie wypisuje liczbę książek (tabela Ksiazki) dla 3 poziomów grupowania: wydawca i rok,wydawca, wszystkie

SELECT COUNT(isbn), wydawca, rokwydania
FROM ksiazki
GROUP BY ROLLUP(wydawca, rokwydania) 
ORDER BY 3,2;

SELECT COUNT(isbn), wydawca, rokwydania
FROM ksiazki
GROUP BY wydawca, rokwydania
UNION ALL
SELECT COUNT(isbn), wydawca, NULL
FROM ksiazki
GROUP BY wydawca
UNION ALL
SELECT COUNT(isbn), NULL, NULL
FROM ksiazki
ORDER BY 3,2;

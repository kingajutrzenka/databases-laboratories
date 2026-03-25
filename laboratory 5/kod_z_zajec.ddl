kjutrzenka=> \i ~/BD/ksiegarnia_postgres.sql
kjutrzenka=> \d
               List of relations
 Schema |       Name       | Type  |   Owner
--------+------------------+-------+------------
 public | ceny             | table | kjutrzenka
 public | dostawcy         | table | kjutrzenka
 public | klienci          | table | kjutrzenka
 public | ksiazki          | table | kjutrzenka
 public | zamowienia       | table | kjutrzenka
 public | zamowioneksiazki | table | kjutrzenka
(6 rows)

kjutrzenka=> SELECT * FROM ksiazki;
       isbn        |    autor    |                     tytul                     |        wydawca         | rokwydani
-------------------+-------------+-----------------------------------------------+------------------------+----------
 978-83-08-06167-1 | Singer      | Dwór                                          | Wydawnictwo Literackie |       201
 978-83-280-0958-5 | Mankell     | Morderca bez twarzy                           | W.A.B.                 |       201
 978-83-668-3911-3 | Stuart      | Shuggie Bain                                  | Wydawnictwo Poznańskie |       202
 978-83-812-9662-5 | Małecki     | Saturnin                                      | Sine Qua Non           |       202
 978-83-777-9221-6 | Dostojewski | Zbrodnia i kara                               | MG                     |       201
 978-83-240-4563-1 | Llosa       | Rozmowa w Katedrze                            | Znak                   |       200
 978-83-803-2171-7 | Atwood      | Ślepy zabójca                                 | Wielka Litera          |       201
 978-83-788-5528-6 | Heller      | Paragraf 22                                   | Albatros               |
 978-83-818-8246-0 | Oz          | Opowieść o miłości i mroku                    | Rebis                  |
 978-83-961-2648-1 | Le Tellier  | Anomalia                                      | Filtry                 |       202
 978-83-280-4417-3 | Foer        | Wszystko jest iluminacją                      | W.A.B.                 |       201
 978-83-080-6083-4 | Catton      | Wszystko, co lśni                             | Wydawnictwo Literackie |       201
 978-83-775-8028-8 | Orwell      | Folwark zwierzęcy                             | Muza                   |       201
 978-83-8125-342-0 | McEwan      | Pokuta                                        | Albatros               |       201
 978-83-080-6833-5 | Littell     | Łaskawe                                       | Wydawnictwo Literackie |       201
 978-83-739-2351-5 | Mrożek      | Krótkie ale całe historie Opowiadania wybrane | Noir Sur Blanc         |       201
 978-83-287-1318-5 | Marquez     | Sto lat samotności                            |                        |
 978-83-287-0886-0 | Zafon       | Cień wiatru                                   | Muza                   |
 978-83-813-9913-5 | Żulczyk     | Informacja zwrotna                            | Świat Książki          |       202
 978-83-7495-593-5 | Nevo        | Do następnych mistrzostw                      |                        |       201
 978-83-801-5978-5 | Zhang       | Ile z gór tych złota                          | Echa                   |       202
 978-83-68226-55-3 | Lynch       | Pieśń prorocza                                | Wydawnictwo Marginesy  |       202
 978-83-08-07565-4 | Flanagan    | Ścieżki Północy                               | Wydawnictwo Literackie |       201
(23 rows)

kjutrzenka=> SELECT COUNT(tytul) FROM ksiazki;
 count
-------
    23
(1 row)

kjutrzenka=> SELECT COUNT(tytul)
kjutrzenka-> FROM ksiazki
kjutrzenka-> WHERE rokwydania IS NOT null;
 count
-------
    19
(1 row)

kjutrzenka=> SELECT DISTINCT COUNT(tytul)
FROM ksiazki
WHERE rokwydania IS NOT null;
 count
-------
    19
(1 row)

kjutrzenka=> SELECT COUNT(DISTINCT wydawca)
FROM ksiazki
WHERE rokwydania IS NOT null;
 count
-------
    14
(1 row)

kjutrzenka=> SELECT MIN(ksiazki) AS minimum
kjutrzenka-> , MAX;
ERROR:  column "ksiazki" does not exist
LINE 1: SELECT MIN(ksiazki) AS minimum
                   ^
kjutrzenka=> SELECT MIN(cena) AS minimum,
kjutrzenka-> MAX(cena) AS maksimum,
kjutrzenka-> AVG(cena) AS średnia,
kjutrzenka-> ;
ERROR:  syntax error at or near ";"
LINE 4: ;
        ^
kjutrzenka=> SELECT MIN(cena) AS minimum,
MAX(cena) AS maksimum,
AVG(cena) AS średnia
kjutrzenka-> FROM ksiazki;
 minimum | maksimum |       średnia
---------+----------+---------------------
   14.99 |    79.90 | 44.4182608695652174
(1 row)

kjutrzenka=> SELECT MIN(cena) AS minimum,
MAX(cena) AS maksimum,
round(AVG(cena), 2) AS średnia
FROM ksiazki;
 minimum | maksimum | średnia
---------+----------+---------
   14.99 |    79.90 |   44.42
(1 row)

kjutrzenka=> SELECT * FROM zamowioneksiazki;
 numerzam |       isbn        | ilosc
----------+-------------------+-------
        1 | 978-83-961-2648-1 |     3
        1 | 978-83-775-8028-8 |     6
        2 | 978-83-775-8028-8 |    15
        2 | 978-83-080-6083-4 |     4
        2 | 978-83-803-2171-7 |     1
        6 | 978-83-961-2648-1 |     8
        6 | 978-83-812-9662-5 |     4
        6 | 978-83-080-6083-4 |    11
        7 | 978-83-240-4563-1 |     3
        7 | 978-83-68226-55-3 |     1
(10 rows)

kjutrzenka=> SELECT SUM(ilosc) FROM zamowioneksiazki;
 sum
-----
  56
(1 row)

kjutrzenka=> SELECT AVG(cena)
kjutrzenka-> FROM ksiazki
kjutrzenka-> WHERE rokwydania > 2018;
         avg
---------------------
 49.2114285714285714
(1 row)

kjutrzenka=> SELECT AVG(cena)
FROM ksiazki
round(WHERE rokwydania > 2018);
ERROR:  syntax error at or near "WHERE"
LINE 3: round(WHERE rokwydania > 2018);
              ^
kjutrzenka=> SELECT AVG(cena)
FROM ksiazki
WHERE rokwydania > 2018;
         avg
---------------------
 49.2114285714285714
(1 row)

kjutrzenka=> SELECT AVG(cena)
FROM ksiazki
WHERE rokwydania > 2018;
         avg
---------------------
 49.2114285714285714
(1 row)

kjutrzenka=> SELECT AVG(cena)
FROM ksiazki
WHERE rokwydania > 2018
kjutrzenka-> round;
ERROR:  syntax error at or near "round"
LINE 4: round;
        ^
kjutrzenka=> SELECT AVG(cena)
FROM ksiazki
WHERE rokwydania > 2018
round;^C
kjutrzenka=> SELECT Round(AVG(cena), 2)
FROM ksiazki
WHERE rokwydania > 2018;
 round
-------
 49.21
(1 row)

kjutrzenka=> SELECT sutor, tytul
kjutrzenka-> FROM ksiazki
kjutrzenka-> WHERE cena = (SELECT MAX(cena) FROM ksiazki);
ERROR:  column "sutor" does not exist
LINE 1: SELECT sutor, tytul
               ^
HINT:  Perhaps you meant to reference the column "ksiazki.autor".
kjutrzenka=> SELECT autor, tytul
FROM ksiazki
WHERE cena = (SELECT MAX(cena) FROM ksiazki);
 autor  |       tytul
--------+--------------------
 Llosa  | Rozmowa w Katedrze
 Catton | Wszystko, co lśni
(2 rows)

kjutrzenka=> ^C
kjutrzenka=> SELECT autor, tytul
FROM ksiazki
WHERE cena = (SELECT MIN(cena) FROM ksiazki);
 autor  |                     tytul
--------+-----------------------------------------------
 Orwell | Folwark zwierzęcy
 Mrożek | Krótkie ale całe historie Opowiadania wybrane
(2 rows)

kjutrzenka=> SELECT autor, tytul
FROM ksiazki
WHERE cena > (SELECT MIN(cena) FROM ksiazki);
    autor    |           tytul
-------------+----------------------------
 Singer      | Dwór
 Mankell     | Morderca bez twarzy
 Stuart      | Shuggie Bain
 Małecki     | Saturnin
 Dostojewski | Zbrodnia i kara
 Llosa       | Rozmowa w Katedrze
 Atwood      | Ślepy zabójca
 Heller      | Paragraf 22
 Oz          | Opowieść o miłości i mroku
 Le Tellier  | Anomalia
 Foer        | Wszystko jest iluminacją
 Catton      | Wszystko, co lśni
 McEwan      | Pokuta
 Littell     | Łaskawe
 Marquez     | Sto lat samotności
 Zafon       | Cień wiatru
 Żulczyk     | Informacja zwrotna
 Nevo        | Do następnych mistrzostw
 Zhang       | Ile z gór tych złota
 Lynch       | Pieśń prorocza
 Flanagan    | Ścieżki Północy
(21 rows)

kjutrzenka=> SELECT autor, tytul
FROM ksiazki
WHERE cena < (SELECT MAX(cena) FROM ksiazki);
    autor    |                     tytul
-------------+-----------------------------------------------
 Singer      | Dwór
 Mankell     | Morderca bez twarzy
 Stuart      | Shuggie Bain
 Małecki     | Saturnin
 Dostojewski | Zbrodnia i kara
 Atwood      | Ślepy zabójca
 Heller      | Paragraf 22
 Oz          | Opowieść o miłości i mroku
 Le Tellier  | Anomalia
 Foer        | Wszystko jest iluminacją
 Orwell      | Folwark zwierzęcy
 McEwan      | Pokuta
 Littell     | Łaskawe
 Mrożek      | Krótkie ale całe historie Opowiadania wybrane
 Marquez     | Sto lat samotności
 Zafon       | Cień wiatru
 Żulczyk     | Informacja zwrotna
 Nevo        | Do następnych mistrzostw
 Zhang       | Ile z gór tych złota
 Lynch       | Pieśń prorocza
 Flanagan    | Ścieżki Północy
(21 rows)

kjutrzenka=> SELECT * FROM ceny;
 przedzial | dolna | gorna
-----------+-------+-------
         1 |  0.00 | 19.99
         2 | 20.00 | 39.99
         3 | 40.00 | 59.99
         4 | 60.00 | 79.99
         5 | 80.00 | 99.99
(5 rows)

kjutrzenka=> SELECT przedzial
kjutrzenka-> FROM ceny
kjutrzenka-> WHERE (SELECT MAX(cena) FROM ksiazki);
ERROR:  argument of WHERE must be type boolean, not type numeric
LINE 3: WHERE (SELECT MAX(cena) FROM ksiazki);
              ^
kjutrzenka=> SELECT przedzial
FROM ceny
WHERE (SELECT MAX(cena) FROM ksiazki) BETWEEN(dolna, gorna);
ERROR:  syntax error at or near ";"
LINE 3: WHERE (SELECT MAX(cena) FROM ksiazki) BETWEEN(dolna, gorna);
                                                                   ^
kjutrzenka=> ^C
kjutrzenka=> SELECT przedzial
FROM ceny
WHERE (SELECT MAX(cena) FROM ksiazki) BETWEEN dolna AND gorna;
 przedzial
-----------
         4
(1 row)

kjutrzenka=> SELECT MAX(cena) FROM ksiazki;
  max
-------
 79.90
(1 row)

kjutrzenka=> SELECT autor, tytul
FROM ksiazki
WHERE cena < (SELECT MAX(cena) FROM ksiazki);^C
kjutrzenka=> SELECT * FROM dostawcy;
 numerdost | nazwadost | adresdost | telefondost
-----------+-----------+-----------+-------------
         1 | Czytelni  | Warszawa  |   601601601
         2 | Druki     | Katowice  |   606606606
         3 | Bukinista | Opole     |   598765432
         4 | ElLibro   | Warszawa  |   687654321
         5 | Lyna      | Elbląg    |
         6 | Czytam    | Elbląg    |
         7 | Litera    | Opole     |
(7 rows)

kjutrzenka=> SELECT * FROM zamowienia;
 numerzam | numerkli |  datazam   | zamzrealizowane
----------+----------+------------+-----------------
        1 |        2 | 2022-10-23 | N
        2 |        2 | 2022-09-02 | T
        3 |        3 | 2023-01-20 | N
        4 |        6 | 2022-02-23 | N
        5 |        1 | 2022-03-10 | N
        6 |        6 | 2022-08-27 | T
        7 |        6 | 2025-01-05 | T
(7 rows)

kjutrzenka=> SELECT * FROM klienci;
 numerkli | imie  | nazwisko |  adres   |  telefon
----------+-------+----------+----------+-----------
        2 | Jan   | Tym      | Gdynia   | 222233233
        3 | Jan   | Nowak    | Sopot    | 422123456
        4 | Adam  | Wat      | Warszawa |
        5 | Ewa   | Zych     | Sopot    | 702206602
        6 | Agata | Kot      | Opole    | 702206609
        1 | Anna  | Nowacka  | Gdynia   |
(6 rows)

kjutrzenka=> SELECT imie, nazwisko
kjutrzenka-> FROM klienci
kjutrzenka-> WHERE adres = (SELECT adres FROM klienci WHERE imie = Ewa AND nazwisko = Zych);
ERROR:  column "ewa" does not exist
LINE 3: ...E adres = (SELECT adres FROM klienci WHERE imie = Ewa AND na...
                                                             ^
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres = (SELECT adres FROM klienci WHERE imie = 'Ewa' AND nazwisko = 'Zych');
 imie | nazwisko
------+----------
 Jan  | Nowak
 Ewa  | Zych
(2 rows)

kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres = (SELECT adres FROM klienci WHERE imie = 'Jan');
ERROR:  more than one row returned by a subquery used as an expression
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres = (SELECT adres FROM klienci WHERE imie IN 'Jan');
ERROR:  syntax error at or near "'Jan'"
LINE 3: ...ERE adres = (SELECT adres FROM klienci WHERE imie IN 'Jan');
                                                                ^
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres = (SELECT adres FROM klienci WHERE imie IN ('Jan'));
ERROR:  more than one row returned by a subquery used as an expression
kjutrzenka=> ^C
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres IN (SELECT adres FROM klienci WHERE imie = 'Jan');
 imie | nazwisko
------+----------
 Jan  | Tym
 Jan  | Nowak
 Ewa  | Zych
 Anna | Nowacka
(4 rows)

kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE miasto IN (SELECT adresdost FROM dostawcy);
ERROR:  column "miasto" does not exist
LINE 3: WHERE miasto IN (SELECT adresdost FROM dostawcy);
              ^
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres IN (SELECT adresdost FROM dostawcy);
 imie  | nazwisko
-------+----------
 Adam  | Wat
 Agata | Kot
(2 rows)

kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres IN (SELECT adresdost FROM dostawcy WHERE COUNT(adresdost)>2);
ERROR:  aggregate functions are not allowed in WHERE
LINE 3: ...RE adres IN (SELECT adresdost FROM dostawcy WHERE COUNT(adre...
                                                             ^
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres IN (SELECT adresdost FROM dostawcy HAVING  COUNT(adresdost)>2);
ERROR:  column "dostawcy.adresdost" must appear in the GROUP BY clause or be used in an aggregate function
LINE 3: WHERE adres IN (SELECT adresdost FROM dostawcy HAVING  COUNT...
                               ^
kjutrzenka=> SELECT imie, nazwisko
FROM klienci
WHERE adres IN (SELECT adresdost FROM dostawcy HAVING  COUNT(adresdost)>2);^C
kjutrzenka=>

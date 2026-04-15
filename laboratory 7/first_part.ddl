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

kjutrzenka=> SELECT imie
kjutrzenka-> FROM klienci
kjutrzenka-> GROUP BY imie;
 imie
-------
 Ewa
 Agata
 Anna
 Jan
 Adam
(5 rows)

kjutrzenka=> SELECT imie, COUNT(numerkli) AS ile
FROM klienci
GROUP BY imie;
 imie  | ile
-------+-----
 Ewa   |   1
 Agata |   1
 Anna  |   1
 Jan   |   2
 Adam  |   1
(5 rows)

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

kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
GROUP BY adresdost;
 adresdost | ile
-----------+-----
 Warszawa  |   2
 Opole     |   2
 Katowice  |   1
 Elbląg    |   2
(4 rows)

kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
GROUP BY adresdost ;
 adresdost | ile
-----------+-----
 Warszawa  |   2
 Opole     |   2
 Katowice  |   1
 Elbląg    |   2
(4 rows)

kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
GROUP BY adresdost
kjutrzenka-> WHERE nazwadost LIKE '%e%';
ERROR:  syntax error at or near "WHERE"
LINE 4: WHERE nazwadost LIKE '%e%';
        ^
kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
WHERE nazwadost LIKE '%e%'
kjutrzenka-> GROUP BY adresdost;
 adresdost | ile
-----------+-----
 Warszawa  |   1
 Opole     |   1
(2 rows)

kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
GROUP BY adresdost;
 adresdost | ile
-----------+-----
 Warszawa  |   2
 Opole     |   2
 Katowice  |   1
 Elbląg    |   2
(4 rows)

kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
GROUP BY adresdost
kjutrzenka-> HAVING adresdost > 1;
ERROR:  operator does not exist: character varying > integer
LINE 4: HAVING adresdost > 1;
                         ^
HINT:  No operator matches the given name and argument types. You might need to add explicit type casts.
kjutrzenka=> SELECT adresdost, COUNT(numerdost) AS ile
FROM dostawcy
GROUP BY adresdost
HAVING COUNT(adresdost) > 1 AND adresdost LIKE '%e%';
 adresdost | ile
-----------+-----
 Opole     |   2
(1 row)

kjutrzenka=> SELECT * FROM kiazki;
ERROR:  relation "kiazki" does not exist
LINE 1: SELECT * FROM kiazki;
                      ^
kjutrzenka=> SELECT * FROM ksiazki;
kjutrzenka=> SELECT wydawca, COUNT(tytul) AS ile
kjutrzenka-> FROM ksiazki
kjutrzenka-> GROUP BY wydawca;
        wydawca         | ile
------------------------+-----
                        |   2
 Wydawnictwo Marginesy  |   1
 Wielka Litera          |   1
 Rebis                  |   1
 MG                     |   1
 Znak                   |   1
 Echa                   |   1
 Wydawnictwo Literackie |   4
 Albatros               |   2
 Filtry                 |   1
 Świat Książki          |   1
 Muza                   |   2
 W.A.B.                 |   2
 Wydawnictwo Poznańskie |   1
 Sine Qua Non           |   1
 Noir Sur Blanc         |   1
(16 rows)

kjutrzenka=> SELECT wydawca, COUNT(tytul) AS ile
FROM ksiazki
GROUP BY wydawca;
        wydawca         | ile
------------------------+-----
                        |   2
 Wydawnictwo Marginesy  |   1
 Wielka Litera          |   1
 Rebis                  |   1
 MG                     |   1
 Znak                   |   1
 Echa                   |   1
 Wydawnictwo Literackie |   4
 Albatros               |   2
 Filtry                 |   1
 Świat Książki          |   1
 Muza                   |   2
 W.A.B.                 |   2
 Wydawnictwo Poznańskie |   1
 Sine Qua Non           |   1
 Noir Sur Blanc         |   1
(16 rows)

kjutrzenka=> SELECT wydawca, COUNT(tytul) AS ile
FROM ksiazki
GROUP BY wydawca
kjutrzenka-> SELECT wydawca, COUNT(tytul) AS ile
FROM ksiazki
GROUP BY wydawca;
ERROR:  syntax error at or near "SELECT"
LINE 4: SELECT wydawca, COUNT(tytul) AS ile
        ^
kjutrzenka=> SELECT wydawca, COUNT(tytul) AS ile
FROM ksiazki
GROUP BY wydawca
SELECT wydawca, COUNT(tytul) AS ile
FROM ksiazki
GROUP BY wydawca;
ERROR:  syntax error at or near "SELECT"
LINE 4: SELECT wydawca, COUNT(tytul) AS ile
        ^
kjutrzenka=> ;
kjutrzenka=> SELECT wydawca, COUNT(tytul) AS ile
FROM ksiazki
WHERE wydawca IS NOT NULL
kjutrzenka-> GROUP BY wydawca;
        wydawca         | ile
------------------------+-----
 Wydawnictwo Marginesy  |   1
 Wielka Litera          |   1
 Rebis                  |   1
 MG                     |   1
 Znak                   |   1
 Echa                   |   1
 Wydawnictwo Literackie |   4
 Albatros               |   2
 Filtry                 |   1
 Świat Książki          |   1
 Muza                   |   2
 W.A.B.                 |   2
 Wydawnictwo Poznańskie |   1
 Sine Qua Non           |   1
 Noir Sur Blanc         |   1
(15 rows)

kjutrzenka=> SELECT wydawca, MIN(cena) AS ile
FROM ksiazki
WHERE wydawca IS NOT NULL
GROUP BY wydawca;
        wydawca         |  ile
------------------------+-------
 Wydawnictwo Marginesy  | 49.90
 Wielka Litera          | 39.90
 Rebis                  | 54.90
 MG                     | 49.90
 Znak                   | 79.90
 Echa                   | 39.99
 Wydawnictwo Literackie | 21.39
 Albatros               | 35.90
 Filtry                 | 49.90
 Świat Książki          | 49.90
 Muza                   | 14.99
 W.A.B.                 | 39.90
 Wydawnictwo Poznańskie | 44.90
 Sine Qua Non           | 39.99
 Noir Sur Blanc         | 14.99
(15 rows)

kjutrzenka=> SELECT wydawca, MIN(cena) AS ile
FROM ksiazki
WHERE wydawca IS NOT NULL
GROUP BY wydawca
kjutrzenka-> HAVING COUNT(tytul) > 1
kjutrzenka-> ORDER BY wydawca DESC;
        wydawca         |  ile
------------------------+-------
 Wydawnictwo Literackie | 21.39
 W.A.B.                 | 39.90
 Muza                   | 14.99
 Albatros               | 35.90
(4 rows)

kjutrzenka=> SELECT nazwadost. COUNT(tytul) FROM dostawcy
kjutrzenka-> INNER JOIN ksiazki
kjutrzenka-> USING(numerdost)
kjutrzenka-> GROUP BY nazwadost;
ERROR:  schema "nazwadost" does not exist
LINE 1: SELECT nazwadost. COUNT(tytul) FROM dostawcy
               ^
kjutrzenka=> SELECT nazwadost COUNT(tytul) FROM dostawcy
INNER JOIN ksiazki
USING(numerdost)
GROUP BY nazwadost;
ERROR:  syntax error at or near "("
LINE 1: SELECT nazwadost COUNT(tytul) FROM dostawcy
                              ^
kjutrzenka=> SELECT nazwadost,  COUNT(tytul) FROM dostawcy
INNER JOIN ksiazki
USING(numerdost)
GROUP BY nazwadost;
 nazwadost | count
-----------+-------
 Druki     |     6
 Bukinista |     3
 Lyna      |     3
 ElLibro   |     2
 Czytelni  |     9
(5 rows)

kjutrzenka=> \i ~\BD\naprawyPostgreSQL.sql
psql:/users/stud/mat/kjutrzenka: error: could not read from input file: Is a directory
kjutrzenka=> \i ~/BD/naprawyPostgreSQL.sql
CREATE TABLE
CREATE TABLE
CREATE TABLE
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
\INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
dINSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1

INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
CREATE INDEX
CREATE INDEX
CREATE INDEX
ALTER TABLE
ALTER TABLE
ALTER TABLE
kjutrzenka=> \d
               List of relations
 Schema |       Name       | Type  |   Owner
--------+------------------+-------+------------
 public | ceny             | table | kjutrzenka
 public | dostawcy         | table | kjutrzenka
 public | klienci          | table | kjutrzenka
 public | ksiazki          | table | kjutrzenka
 public | naprawy          | table | kjutrzenka
 public | pojazdy          | table | kjutrzenka
 public | uslugi           | table | kjutrzenka
 public | zamowienia       | table | kjutrzenka
 public | zamowioneksiazki | table | kjutrzenka
(9 rows)


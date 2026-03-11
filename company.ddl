kjutrzenka=> \i ~/BD/Companies.sql

kjutrzenka=> \d
             List of relations
 Schema |     Name     | Type  |   Owner
--------+--------------+-------+------------
 public | companies    | table | kjutrzenka
 public | samochod     | table | kjutrzenka
 public | wynajem      | table | kjutrzenka
 public | wypozyczenie | table | kjutrzenka
(4 rows)

kjutrzenka=> SELECT * FROM companies;
kjutrzenka=> SELECT Company, Country FROM companies;
kjutrzenka=> SELECT Company, Country FROM companies ORDER BY Country;
kjutrzenka=>
kjutrzenka=> SELECT Company, Country FROM companies ORDER BY Company. Country DESC;
ERROR:  missing FROM-clause entry for table "company"
LINE 1: SELECT Company, Country FROM companies ORDER BY Company. Cou...
                                                        ^
kjutrzenka=> SELECT Company, Country FROM companies ORDER BY Company, Country DESC;
kjutrzenka=> SELECT Company, Country FROM companies ORDER BY Company ASC, Country DESC;
kjutrzenka=> SELECT Company, Country FROM companies ORDER BY Company DESC , Country DESC;
kjutrzenka=> SELECT DISTINCT Country FROM companies ORDER BY Country;
    country
----------------
 Canada
 Czech Republic
 Estonia
 France
 Germany
 Poland
 Portugal
 Spain
 United Kingdom

(10 rows)

kjutrzenka=> DROP TABLE companies;
DROP TABLE

kjutrzenka=> \d
             List of relations
 Schema |     Name     | Type  |   Owner
--------+--------------+-------+------------
 public | employees    | table | kjutrzenka
 public | films        | table | kjutrzenka
 public | samochod     | table | kjutrzenka
 public | wynajem      | table | kjutrzenka
 public | wypozyczenie | table | kjutrzenka
(5 rows)

kjutrzenka=> SELECT * FROM employees;
kjutrzenka=>
kjutrzenka=> SELECT FullName FROM employees;
kjutrzenka=>
kjutrzenka=> SELECT FullName FROM employees;
kjutrzenka=> SELECT FullName, lenght(Fullname) FROM employees WHERE Fullname LIKE %company ;
ERROR:  syntax error at or near "%"
LINE 1: ...nght(Fullname) FROM employees WHERE Fullname LIKE %company ;
                                                             ^
kjutrzenka=> SELECT FullName, lenght(Fullname) FROM employees WHERE Fullname LIKE '%company' ;
ERROR:  function lenght(character varying) does not exist
LINE 1: SELECT FullName, lenght(Fullname) FROM employees WHERE Fulln...
                         ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
kjutrzenka=> SELECT FullName, lenght(FullName) FROM employees WHERE FullName LIKE '%company' ;
ERROR:  function lenght(character varying) does not exist
LINE 1: SELECT FullName, lenght(FullName) FROM employees WHERE FullN...
                         ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
kjutrzenka=>
kjutrzenka=> SELECT FullName, lenght(FullName) FROM employees WHERE FullName LIKE '%company' ;^C
kjutrzenka=> SELECT FullName, length(FullName) FROM employees WHERE FullName LIKE '%company' ;
 fullname | length
----------+--------
(0 rows)

kjutrzenka=> SELECT FullName, length(FullName) FROM employees WHERE FullName LIKE '%ny' ;
 fullname | length
----------+--------
(0 rows)

kjutrzenka=> SELECT FullName, length(FullName), upper(substr(Company, length(Company) - 1)) FROM employees ;
kjutrzenka=> SELECT movietitle,
kjutrzenka-> rount(ticketprice * 0,92, 2)  AS cena_netto
kjutrzenka-> FROM ;
ERROR:  syntax error at or near ";"
LINE 3: FROM ;
             ^
kjutrzenka=> SELECT movietitle,
round(ticketprice/1.08, 2)  AS cena_netto
FROM films;
kjutrzenka=> SELECT now(CURRENT_TIME);
ERROR:  function now(time with time zone) does not exist
LINE 1: SELECT now(CURRENT_TIME);
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
kjutrzenka=> SELECT CURRENT_TIME;
    current_time
--------------------
 09:40:50.496783+01
(1 row)

kjutrzenka=> SELECT CURRENT_DATE + 500;
  ?column?
------------
 2027-07-31
(1 row)

kjutrzenka=> SELECT CURRENT_DATE + 500;
  ?column?
------------
 2027-07-31
(1 row)

kjutrzenka=> SELECT CURRENT_TIME + 500;
ERROR:  operator does not exist: time with time zone + integer
LINE 1: SELECT CURRENT_TIME + 500;
                            ^
HINT:  No operator matches the given name and argument types. You might need to add explicit type casts.
kjutrzenka=> SELECT EXTRACT
kjutrzenka-> SELECT EXTRAT(MONTH FROM DATE(now()) + 500;
kjutrzenka(> SELECT movietitle,
round(ticketprice/1.08, 2)  AS cena_netto
FROM films;\
invalid command \
Try \? for help.
kjutrzenka(> \q
kjutrzenka@sxterm:~$ psql
psql (16.10 (Debian 16.10-1.pgdg12+1))
Type "help" for help.

kjutrzenka=> SELECT age('1939-09-01', '1918-11-11');
           age
-------------------------
 20 years 9 mons 20 days
(1 row)

kjutrzenka=> SELECT age('1918-11-11', '1939-09-01');
            age
----------------------------
 -20 years -9 mons -20 days
(1 row)

kjutrzenka=> SELECT age('1939-09-01', '1918-11-11');
           age
-------------------------
 20 years 9 mons 20 days
(1 row)

kjutrzenka=> SELECT age('1939-09-01', '1918-11-11');^C
kjutrzenka=> SELECT age('1939-09-01', '1918-11-11');^C
kjutrzenka=> SELECT EXTRACT (DAY FROM AGE('1939-09-01', '1918-11-11'));
 extract
---------
      20
(1 row)

kjutrzenka=> SELECT DATEDIFF('1939-09-01', '1918-11-11');
ERROR:  function datediff(unknown, unknown) does not exist
LINE 1: SELECT DATEDIFF('1939-09-01', '1918-11-11');
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
kjutrzenka=> DROP TABLE films
kjutrzenka-> ;
DROP TABLE
kjutrzenka=> DROP TABLE employees;
DROP TABLE
kjutrzenka=> DROP TABLE samochod;
ERROR:  cannot drop table samochod because other objects depend on it
DETAIL:  constraint wynajem_samochod_fk on table wynajem depends on table samochod
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
kjutrzenka=> DROP TABLE wynajem;
DROP TABLE
kjutrzenka=> DROP TABLE wypozyczenie;
DROP TABLE
kjutrzenka=> DROP TABLE samochod;
DROP TABLE

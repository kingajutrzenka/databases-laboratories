kjutrzenka=> \i ~/BD/Films.sql
 \d
             List of relations
 Schema |     Name     | Type  |   Owner
--------+--------------+-------+------------
 public | films        | table | kjutrzenka
 public | samochod     | table | kjutrzenka
 public | wynajem      | table | kjutrzenka
 public | wypozyczenie | table | kjutrzenka
(4 rows)

kjutrzenka=> SELECT FilmId FROM companies WHERE Subtitles 'Polish' OR 'English';
ERROR:  relation "companies" does not exist
LINE 1: SELECT FilmId FROM companies WHERE Subtitles 'Polish' OR 'En...
                           ^
kjutrzenka=> ^C
kjutrzenka=> SELECT FilmId FROM companies WHERE Subtitles 'Polish' OR 'English';
ERROR:  relation "companies" does not exist
LINE 1: SELECT FilmId FROM companies WHERE Subtitles 'Polish' OR 'En...
                           ^
kjutrzenka=> SELECT FilmId FROM companies WHERE Subtitles IN  ('Polish', 'English');
ERROR:  relation "companies" does not exist
LINE 1: SELECT FilmId FROM companies WHERE Subtitles IN  ('Polish', ...
                           ^
kjutrzenka=> SELECT FilmId FROM films WHERE Subtitles IN  ('Polish', 'English');
 filmid
--------
     22
     93
     99
(3 rows)

kjutrzenka=> SELECT MovieTitle FROM Films WHERE Ticketprice BETWEEN [10, 12);
ERROR:  syntax error at or near "["
LINE 1: ...CT MovieTitle FROM Films WHERE Ticketprice BETWEEN [10, 12);
                                                              ^

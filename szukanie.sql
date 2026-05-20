---------------------SIMILAR TO-------------------------------------

SELECT * FROM employees;

-- W polu company występuje myślnik

SELECT company FROM employees WHERE company SIMILAR TO '%-%';

-- W polu company występuje apostrof.

SELECT company FROM employees WHERE company SIMILAR TO '%''%'

--  W polu jobtitle występuje pojedyncze słowo,
--po nim spacja i liczba zapisana z pomocą rzymskich cyfr.

SELECT jobtitle FROM employees WHERE jobtitle SIMILAR TO '%''%'

--coś tam coś tam..........

--W polu jobtitle występuje pojedyncze słowo, po nim spacja
--i liczba zapisana z pomocą rzymskich cyfr.



-- W polu email nazwa użytkownika kończy się dowolną cyfrą, zaś cały adres łańcuchem '.com'.

SELECT email FROM employees WHERE email SIMILAR TO '[a-zA-Z0-9]*[[:digit:]]@[a-zA-Z0-9]*.com'

--W polu email w nazwie użytkownika 
--liczba dwucyfrowa, a w nazwie domeny brak jest cyfr.

SELECT email 
FROM employees
WHERE email SIMILAR TO '[a-zA-Z]*[1-9][0-9][a-zA-Z]*@[a-zA-Z.]*';

--W polu email w nazwie domeny liczba trzycyfrowa,
--po której NIE następuje bezpośrednio kropka.

--SELECT email 
--FROM employees
--WHERE email SIMILAR TO '%@[a-zA-Z0-9]*@[1-9][0-9]{2}[^.][a-zA-Z.]+%';

--???????????????????????

-------------------------- ~, ~* -----------------------------------

-- W polu company występuje myślnik

SELECT company FROM employees WHERE company ~ '-';

-- W polu company występuje apostrof.

SELECT company FROM employees WHERE company ~ ''''

-- W polu company dwukrotnie występuje podwójnie 
-- napisane l (jak np. w Olson, Carroll and Willms)

SELECT company FROM employees WHERE company ~ '(ll)'

--W polu company występuje podwójnie napisane
--e lub l, lub o (jak np. w Feeney and Sons).

SELECT company FROM employees WHERE company ~ '(ll|ee|oo)'

-- W polu company występuje podwójnie napisana wielka
--lub mała litera (jak np. w Dach LLC).

SELECT company FROM employees WHERE company ~ '([A-Za-z])\1';

--W polu company przynajmniej DWUKROTNIE występuje napisany łańcuch
--ie lub ll, lub on, lub ma. Wielkość liter nie ma znaczenia 
--(jak np. w Kuhlman-Mayert)

SELECT company FROM employees 
WHERE company ~*'(ie|ll|on|ma)|.*\1'

-- Uwaga! Musi być \1, bo musi byc  2 razy to samo


-- to_tsvector

--naucz się, bo jesteś leniwa XD
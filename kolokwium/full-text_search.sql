------Full-text search------------

SELECT cfgname FROM pg_ts_config;

CREATE TABLE recipes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    content TEXT
);

-- Wrzucamy trzy przykładowe przepisy
INSERT INTO recipes (title, content) VALUES
('Apple Pie', 'Grandma baked a delicious cake with roasted apples and cinnamon.'),
('Healthy Snack', 'I love eating a fresh apple in the morning.'),
('Roast Chicken', 'Classic roasted chicken with potatoes.');


----- wyszukiwanie ----------------------------

--Chcemy znaleźć przepisy, w których pojawia się słowo 
--"roast" (pieczony) oraz "apple" (jabłko).

SELECT * FROM recipes;

SELECT *
FROM recipes
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'roast & apple');

-- content to nazwa kolumny

---rodzaje operatorów:
-- | : OR
-- ! : NOT
-- & : AND
-- <x> : tylko te teksty, gdzie x:
-- - słowa występują bezpośrednio jeden po drugim
-- 2 jest max jedno słowo odstępu

------------Napisz zapytanie wyszukujące przepisy, które w swojej
--treści mająsłowo „kurczak” (chicken) LUB słowo „ciasto” (cake).

SELECT *
FROM recipes
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'chicken | cake ') ;

---Napisz zapytanie wyszukujące przepisy, które zawierają słowo
--„pieczony” (roast), ale bezwzględnie wykluczają te,
-- w których pojawiają się „ziemniaki” (potato).

SELECT *
FROM recipes
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'roast & !potato') ;

--przepis, w którym słowo „świeże” (fresh) występuje w
--tekście bezpośrednio przed słowem „jabłko” (apple).

SELECT *
FROM recipes
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'fresh <-> apple') ;




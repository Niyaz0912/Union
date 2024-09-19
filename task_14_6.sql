--По итогам прошлой домашней работы у вас уже есть
--базы данных Students либо БД Фитнес клуб и овощам.
--Ваша задача сделать как следующие запросы:


    --два запроса Exists;

SELECT *
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Products
    WHERE type = 'fruit' AND id = p.id
); -- Выводит полную информацию из таблицы Products, где type указан, как fruit

SELECT *
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Products
    WHERE calories > 50 AND id = p.id
); --Выводит полную информацию из таблицы Products, где calories больше 50


    --по одному запросу на ANY/SOME (разных а не просто заменить ANY на SOME);

SELECT *
FROM Products
WHERE calories = ANY (
    SELECT calories
    FROM Products
    WHERE type = 'fruit' AND color = 'green'
); -- Выводит позиции где есть фрукты с зеленым цветом
SELECT *
FROM Products
WHERE calories = SOME (
    SELECT calories
    FROM Products
    WHERE type = 'vegetable' AND color = 'red'
); -- Выводит позиции где есть овощи с красным цветом цветом


    --один запрос ALL;

SELECT *
FROM Products
WHERE calories < ALL (
    SELECT calories
    FROM Products
    WHERE type = 'fruit'
); -- Запрос ALL на поиск продуктов с калорийностью меньше всех фруктов

    --один запрос на сочетание ANY/SOME, ALL


    --один запрос на UNION

SELECT name, type, calories
FROM Products
WHERE type = 'fruit' AND calories > 50

UNION

SELECT name, type, calories
FROM Products
WHERE type = 'vegetable' AND calories > 50
-- Запрос на UNION для объединения фруктов и овощей с калорийностью более 50


    --один запрос на UNION ALL

SELECT name, type, calories
FROM Products
WHERE color = 'yellow'

UNION ALL

SELECT name, type, calories
FROM Products
WHERE calories > 50;
-- Запрос на UNION ALL для объединения всех продуктов с желтым цветои и с калорийностью более 50


--по одному запросу на все JOIN (INNER/LEFT/RIGHT/LEFT+RIGHT/FULL) - всего пять штук

SELECT FirstName, LastName, Specialization, Schedule
FROM Инструкторы inner join Секции
ON Инструкторы.InstructorID = Секции.SectionID
-- Объединяет информацию с таблицы Инструкторы (ФИО и специализацию) с таблицей Секции (расписание занятий)

SELECT Посетители.*, Инструкторы.*
FROM Посетители
LEFT JOIN Инструкторы ON Посетители.VisitorID = InstructorID;
-- Запрос вставляет слева в таблицу с Инструкторами таблицу Посетители

SELECT SectionName,Schedule, FirstName, LastName, Phone
FROM Секции
RIGHT JOIN Инструкторы ON Секции.SectionID = Инструкторы.InstructorID;
-- Запрос вставляет справа в таблицу с Секциями ФИО и номер инструкторов

SELECT Инструкторы.*, Посетители.*
FROM Инструкторы
LEFT JOIN Посетители ON InstructorID = Посетители.VisitorID

UNION

SELECT Инструкторы.*, Посетители.*
FROM Посетители
RIGHT JOIN Инструкторы ON Посетители.VisitorID = InstructorID;
-- Полное объединение левых и правых результатов

SELECT Посетители.*, Инструкторы.*
FROM Посетители
FULL JOIN Инструкторы ON Посетители.VisitorID = InstructorID;
-- Запрос на объединение всех посетителей и инструкторов
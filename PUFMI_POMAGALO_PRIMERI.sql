/*

USE TestDb -- select the database you want to use
  Задача 2-1. Да се създаде база от данни с име TESTDB.
  CREATE DATABASE TESTDB

  Задача 2-2. Да се създаде таблица в тази база данни с име COUNTRIES и следните колони:
  country_code – с тип char(3);
  name – тип varchar(40);
  population – тип int

CREATE TABLE COUNTRIES
(
	COUNTRY_CODE CHAR(3),
	NAME VARCHAR (40),
	POPULATION INT
)

Задача 2-3. Да се добави нов атрибут в таблицата COUNTRIES с име phone_code и тип цяло 
число до 3 цифри.


ALTER TABLE COUNTRIES 
ADD PHONE_CODE INT -- число до 3 цифри-------------------------

Задача 2-4. Да се добави ред в таблицата COUNTRIES със следните данни:
 country_code: BGR;
 name: България;
 population: 7500000;
 phone_code: 359.

INSERT INTO COUNTRIES (COUNTRY_CODE, NAME, POPULATION, PHONE_CODE)
VALUES('BGR', 'България', 7500000, 359)

Задача 2-5. Да се промени населението на България на 6 милиона.

select * from COUNTRIES

UPDATE COUNTRIES 
SET POPULATION = 6000000
WHERE COUNTRY_CODE = 'BGR'

Задача 2-6. Да се изтрият всички редове в таблицата COUNTRIES.
DELETE FROM COUNTRIES

Задача 2-7. Да се изтрие таблицата COUNTRIES от базата данни.
DROP TABLE COUNTRIES

Задача 2-8. Да се изтрие базата данни TESTDB
create database testtdbbbb
DROP DATABASE testtdbbbb

--Задача 3-2. Да се увеличи количеството с 2 броя и да се намали единичната цена с 5% на 
--продукт с идентификатор 2254 в поръчка с идентификатор 2354.

UPDATE ORDER_ITEMS
SET UNIT_PRICE = (3445.20 - (3445.20*8/100)), QUANTITY = 72
WHERE PRODUCT_ID = 2254 AND ORDER_ID = 2354 

Задача 4-1. Да се изведат имената, заплатите и идентификаторите на длъжностите на 
служителите, работещи в отдели 50 и 80. Резултатът да е подреден по фамилия
на служител във възходящ ред.

SELECT FNAME, LNAME, SALARY, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 80
ORDER BY LNAME ASC

-- Задача 4-2. Да се изведат общата сума на заплатите и броя служители в отдел 60.
SELECT  COUNT(SALARY) AS SALARY_COUNT, COUNT(DEPARTMENT_ID) AS COUNT_EMPLOYEES
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 60

--Задача 4-3. За всички поръчки да се изведат идентификатор на поръчка и обща стойност на 
--поръчката. Резултатът да е подреден по стойност на поръчката в низходящ ред.

SELECT ORDER_ID, (QUANTITY * UNIT_PRICE) AS ORDER_PRICE
FROM ORDER_ITEMS
ORDER BY ORDER_PRICE DESC

-- ORDERS, която ще съхранява данни за направените поръчки.	
-- ORDER_ITEMS. Тя ще съхранява данни за съдържанието на поръчките.

Задача 4-4. Да се изведат всички малки имена на клиенти и служители с евентуалните 
повторения, сортирани в низходящ ред по име.

SELECT FNAME
FROM CUSTOMERS
UNION ALL
SELECT FNAME
FROM EMPLOYEES
ORDER BY FNAME DESC

Задача 4-5. Да се изведат име и фамилия на клиенти и служители без повторения, а като 
трета колона за клиентите да се използва израз, генериращ низа „Клиент 
(<идентификатор>)“, за служителите – „Служител (<идентификатор>)“.


-- Да видя какво беше атрибут в таблица да науча точно 3те нормални форми

Първа нормална форма – всички атрибути трябва да съдържат скаларни (атомарни, 
единични) стойности.

 Втора нормална форма – да е в първа нормална форма и всички атрибути в таблицата 
трябва да зависят от целия първичен ключ.

 Трета нормална форма – да е във втора нормална форма и всички атрибути в таблицата 
да бъдат функционално зависими само от първичния ключ. Целта е да се гарантира, че 
няма т.нар. транзитивни зависимости – A определя B, B определя C, следователно A 
определя C транзитивно. Ако такива са налице, значи таблицата представя повече от 
един обект.

Задача 4-6. Да се изведат общите собствени имена на клиенти и служители.
SELECT DISTINCT FNAME
FROM CUSTOMERS
WHERE FNAME IN (SELECT FNAME FROM EMPLOYEES)


-- ----------------------------------------------------------------------------------------da razgledam pak
(SELECT * FROM DEPARTMENTS
 WHERE DEPARTMENTS.COUNTRY_ID = CUSTOMERS.COUNTRY_ID)


 minus operator
-- или
SELECT DISTINCT COUNTRY_ID
FROM CUSTOMERS
WHERE COUNTRY_ID <> ALL (SELECT COUNTRY_ID FROM DEPARTMENTS)

  ALL е логически оператор и се използва в комбинация с оператор за сравнение. 
Позволява да се сравни скаларна стойност с множество от стойности, върнати от 
вложена заявка. Връща true ако операторът за сравнение върне true за всички 
сравнения, иначе false. Операторът за сравнение <>, използван в комбинация с ALL, е 
аналог на оператора NOT IN.

Задача 4-7. Да се изведат собствените имена на клиенти, които не се срещат сред тези на 
служителите.

SELECT DISTINCT FNAME
FROM CUSTOMERS
WHERE FNAME <> ALL (SELECT FNAME FROM EMPLOYEES)

АТРИБУТ МИСЛЯ ЧЕ БЕШЕ КОЛОНА НА ТАБЛИЦАТА

 NATURAL JOIN извежда всички възможни свързани двойки от записи, така че всяка 
двойка да има равенство на стойностите във всички атрибути с еднакви имена от двете 
релации. Операторът създава неявна join клауза, базирана на общите колони на двете 
таблици, чиито редове се съединяват

4-10. Да се изведат държавите и регионите, в които се намират.
SELECT *
FROM COUNTRIES 
INNER JOIN REGIONS ON 
REGIONS.REGION_ID = COUNTRIES.REGION_ID

----------------------------------------------------------------------------------------------------------------natural join 
р 4-11. Да се изведат имената на клиентите, имената на държавите, от които са, и 
имената на регионите на държавите.

SELECT FNAME, LNAME, COUNTRIES.NAME, REGIONS.NAME
FROM CUSTOMERS 
JOIN COUNTRIES ON 
COUNTRIES.COUNTRY_ID = CUSTOMERS.COUNTRY_ID 
JOIN REGIONS ON 
REGIONS.REGION_ID = COUNTRIES.REGION_ID

STR 72 DA PRODULJA

 4-13. Да се изведат държавите и регионите, в които се намират. Резултатния набор 
да включва държавите, за които няма въведен регион.

SELECT *
FROM COUNTRIES RIGHT JOIN REGIONS ON
REGIONS.REGION_ID = COUNTRIES.REGION_ID

4. Да се изведат държавите и регионите, в които се намират. Резултатния набор 
да включва държавите, за които няма въведен регион и регионите, за които 
няма въведени държави

SELECT *
FROM COUNTRIES C
FULL JOIN REGIONS R  ON
R.REGION_ID = C.REGION_ID


4.6.6.3. SEMI-JOIN 
Извежда редове от първата таблица, за които има поне едно съвпадение с редове от 
втората релация. Всеки ред от първата релация участва най-много веднъж в резултатния 
набор, дори да има повече от един съвпадащи реда във втората релация. Реализира се с 
предикатите IN и EXISTS.

Пример 4-16. Да се изведат отделите, в които има назначени служители.

SELECT NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID 
IN (SELECT DEPARTMENT_ID FROM EMPLOYEES )

STR 79
4.6.6.4. ANTI JOIN 

Пример 4-18. Да се изведат комбинациите между всички региони и държави, сортирани по 
име на държава.

SELECT *
FROM REGIONS CROSS JOIN COUNTRIES
ORDER BY COUNTRIES.NAME

4.6.7. Задачи 
Задача 4-8. Да се изведат идентификаторите и датите на поръчките, както и имената на 
служителите, които са ги обработили.

SELECT ORDER_ID, ORDER_DATE, FNAME, LNAME
FROM ORDERS, EMPLOYEES
WHERE ORDERS.EMPLOYEE_ID = EMPLOYEES.EMPLOYEE_ID

Задача 4-9. Да се изведат имената на всички клиенти и идентификаторите на поръчките им.
В резултатния набор да участват и клиентите, които все още не са правили 
поръчки.

SELECT FNAME, LNAME, ORDER_ID
FROM CUSTOMERS C 
LEFT JOIN ORDERS O  ON C.CUSTOMER_ID = O.CUSTOMER_ID

Задача 4-10. Да се изведат имената на продуктите, които не са поръчвани до момента.

SELECT NAME
FROM PRODUCTS  
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID FROM ORDER_ITEMS)

Задача 4-11. Да се изведат имената на всички клиенти, които са от държави в регион 
„Западна Европа“

SELECT R.NAME, CU.FNAME, CU.LNAME
FROM REGIONS R 
JOIN COUNTRIES CO ON R.REGION_ID = CO.REGION_ID 
JOIN CUSTOMERS CU ON CO.COUNTRY_ID = CU.COUNTRY_ID
WHERE R.NAME = 'Западна Европа'

SELECT R.NAME, CU.FNAME, CU.LNAME 
FROM CUSTOMERS CU 
JOIN COUNTRIES CO ON CO.COUNTRY_ID = CU.COUNTRY_ID
JOIN REGIONS R ON R.REGION_ID = CO.REGION_ID 
WHERE R.NAME = 'Западна Европа'


Пример 4-21. Да се изведат петимата служители, започвайки от 10-ти ред, подредени по 
дата на постъпване в компанията. Първата заявка ще покаже всички с цел 
демонстрация, втората ще извърши подбора.

SELECT FNAME, LNAME
FROM EMPLOYEES
ORDER BY HIRE_DATE
OFFSET 9 ROWS 
FETCH NEXT 5 ROWS ONLY

Задача 4-12. Да се изведат вторите 10 най-добре платени служители (подредени по заплата 
низходящо).

SELECT FNAME, LNAME , SALARY 
FROM EMPLOYEES
ORDER BY SALARY DESC
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY

Задача 4-13. Да се изведат име, фамилия и пол на клиентите, направили последните 5 
поръчки

SELECT TOP 5 WITH TIES FNAME, LNAME, GENDER, ORDER_DATE
FROM CUSTOMERS CU, ORDERS ORD
WHERE CU.CUSTOMER_ID = ORD.CUSTOMER_ID
ORDER BY ORDER_DATE DESC


Задача 4-12. Да се изведат вторите 10 най-добре платени служители (подредени по заплата 
низходящо).


SELECT FNAME,SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC
OFFSET 9 ROWS
FETCH FIRST 10 ROWS ONLY 

Пример 4-18. Да се изведат комбинациите между всички региони и държави, сортирани по 
име на държава.

select *
from REGIONS CROSS JOIN COUNTRIES
ORDER BY COUNTRIES.NAME
--------------------------------------------------------------------------------------------------------------------------------------------
Задачи адастра 

зад 1
Find the average amount of shipped orders. (В google translate e  намерете средното количество изпратени поръчки)

select avg(total_amount)
from orders
--------------------
Верен отговор проблема е че имаме колона status (която най вероятно е дали поръчката е изпратена, затова отговора трябва да е)

SELECT AVG(ORDER_ID) -- Обаче нямаме данни id тата дали почват от 0 ако не почват трябва да се ползва някаква count функция
FROM ORDERS
WHERE STATUS = 'SHIPPED' 

SELECT AVG(ORDER_ID) 
FROM ORDERS
WHERE LEN(SHIP_ADDRESS) > 1 -- ТОВА Е ЗАЯВКА С КОЯТО СЪМ ПРОВЕРЯВАЛ
За текст вкарване или търсене 'ползваме' ако е число просто го пишем 10 

зад 2 
List the category name, product name and quantity 
of the products that have been orderd.
----------\/ ВЯРНА
SELECT CAT_NAME, PRODUCT_NAME, QUANTITY
FROM ORDER_ITEMS O
JOIN PRODUCTS P ON P.PRODUCT_ID = O.PRODUCT_ID
JOIN CATEGORIES C ON C.CAT_ID = P.CAT_ID

---------\/ ТЕСТОВА
SELECT R.NAME, C.NAME, D.MANAGER_ID
FROM DEPARTMENTS D
JOIN  COUNTRIES C ON C.COUNTRY_ID = D.COUNTRY_ID
JOIN REGIONS R ON C.REGION_ID = R.REGION_ID

зад 3
LIST ALL UNIQUE PRODUCT IDS OF ordered products 
that have been orderd with price greater than 50$.

SELECT DISTINCT P.PRDUCT_ID,
FROM PRODUCTS P
WHERE P.PRICE > 50
JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID

зад 4 
LIST THE TOTAL AMOUNT OF SHIPPED ORDERS MADE BY FEMALE CUSTOMERS. 
RESULT SHOULD BE ORDERED BY DESCENDING DATE.

SELECT COUNT(ORDER_ID)
FROM ORDERS O
WHERE C.SEX = 'F'
ORDER BY DATE DESC
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID

зад 5
LIST BY CATEGORY NAME ALL PRODUCTS WHICH NAME CONTAINS "moon". ------------------------

SELECT CAT_NAME
FROM PRUDUCTS P
WHERE PRODUCT_NAME LIKE '%moon%' -- TEKST SAMO S EDINI4NI KAVI4KI. ZA DA POKAJE И РЕДОВЕ В КОИТО СЕ СЪДЪРЖАТ ТЕЗИ 3 БУКВИ ТОВА СА WILDCARD: ends with %ddd , contains %ddd%, ddd% start with, _d% second word is d
JOIN CATEGORY C ON C.CAT_ID = P.CAT_ID

зад 6 
Add a new product with name 'Marswatch' and price = 99$ to the database.

insert into products (PRODUCT_NAME,PRICE)
VALUES('Marswatch',99); --- da proverq kavi4kite

зад 7
Remove product with Id=15 from the database.
delete from product
where product_id = 15

зад  9
List all male customer names and the lowest amount they spend on an order.

SELECT DISTINCT CUSTOMER_NAME 
FROM CUSTOMERS C
WHERE SEX = 'M'
ORDER BY  TOTAL_AMOUNT ASC
JOIN ORDER O ON O.CUSTOMER_ID = C.CUSTOMER_ID

SELECT FNAME, UNIT_PRICE
FROM  ORDER_ITEMS OI
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID 
ORDER BY UNIT_PRICE
зад 10
Create a query that will list all customer names and count of the 
orders they have made.
Query should list only customers which made at 
least one order more than 1000$.

SELECT CUSTOMER_NAME, COUNT(ORDER_ID)
FROM CUSTOMERS C
WHERE TOTAL_AMOUNT > 1000 
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_AMOUNT DESC
JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID

------------------- TEST QUERY
SELECT C.FNAME, C.LNAME, OI.UNIT_PRICE
FROM CUSTOMERS C
JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = O.ORDER_ID 
ORDER BY UNIT_PRICE DESC

--Пример 5-1. Да се създаде изглед,
--който съдържа име и фамилия на клиентите, както и 
--номер и дата на поръчките, които те са направили.


CREATE VIEW CUSTOMER_ORDERS
AS
SELECT C.FNAME +' '+ C.LNAME AS CUSTOMER, O.ORDER_ID, O.ORDER_DATE
FROM CUSTOMERS C, ORDERS O
WHERE C.CUSTOMER_ID = O.ORDER_ID

SELECT * FROM CUSTOMERORDERS

Пример 5-2. Да се модифицира горният изглед така,
че да съдържа и колона с името на 
съответния служител, обработил поръчката.

ALTER VIEW CUSTOMERORDERS AS
SELECT C.FNAME +' '+ C.LNAME AS CUSTOMER,
		O.ORDER_ID, O.ORDER_DATE,
		E.FNAME +' '+ E.LNAME AS EMPLOYEE
FROM CUSTOMERS C, ORDERS O, EMPLOYEES E
WHERE C.CUSTOMER_ID = O.ORDER_ID
AND O.EMPLOYEE_ID = E.EMPLOYEE_ID

Пример 5-3. Да се модифицира горния изглед така,
че да съдържа само поръчките, 
обработени от служител с идентификатор = 167.ALTER VIEW CUSTOMERORDERS AS
SELECT C.FNAME +''+ C.LNAME AS CUSTOMER,
	O.ORDER_ID,O.ORDER_DATE,
	E.FNAME +' '+ E.LNAME AS EMPLOYEE

FROM EMPLOYEES E, CUSTOMERS C, ORDERS O
WHERE O.EMPLOYEE_ID = E.EMPLOYEE_ID
AND C.CUSTOMER_ID = O.CUSTOMER_ID
AND EMPLOYEE_ID = 167

Пример 5-4. Да се създаде изглед, 
съдържащ име и фамилия на служител и общата сума на 
поръчките, които той е обработил.

CREATE VIEW EMPLOYEE_ORDERS AS
SELECT E.FNAME +' '+ E.LNAME AS EMPLOYEE,
		SUM(OI.UNIT_PRICE*OI.QUANTITY) AS ORDERS_TOTAL
FROM EMPLOYEES E, ORDERS O, ORDER_ITEMS OI
WHERE E.EMPLOYEE_ID = O.EMPLOYEE_ID
AND OI.ORDER_ID = O.ORDER_ID
GROUP BY E.EMPLOYEE_ID, E.FNAME, E.LNAME

SELECT * FROM EMPLOYEE_ORDERS
ORDER BY ORDERS_TOTAL DESC


Пример 5-5. Да се създаде изглед, който съдържа имена,
отдел и заплата на 5-мата 
служители с най-висока заплата. За да бъдат извлечени служителите, 
подредени по заплата, очевидно ще трябва да бъдат сортирани по този 
критерий

CREATE VIEW EMP_DEP_SAL AS
SELECT TOP 5 E.FNAME +' '+ E.LNAME AS EMPLOYEE,
		D.NAME AS DEPARTMENT,
		E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.SALARY DESC

SELECT * FROM EMP_DEP_SAL 
ORDER BY SALARY DESC

*/
USE TRADECOMPANY_TWO

select isbn, title, price , 'Най скъпата е публикувана ' + cast(year_pub as varchar)
from book
where price = (select max(price) from book)
union
select isbn, title, price, 'Най евтината е публикувана ' + cast(year_pub as varchar)
from book
where price = (select min(price) from book)

-- Преубразуваме годината на публикуване към varchar, за да може при слепването на низа да няма двусмислие и да излезнат грешки.

-- най скъпата и най евтината книга друг вариант
select * from book
where price = (select max(price) from book)
or price = (select min(price) from book)
-----------------------------------


SELECT C.*
FROM ORDERS O 
RIGHT JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.ORDER_ID 
WHERE C.CUSTOMER_ID = 105


-- ADASTRA TEST SECOND

--- 1                 ---OK

SELECT AVG(ORDER_ID)
FROM ORDERS 
WHERE STATUS = 'SHIPPED'

--- 2 - DA PROVERQ ---------------- ok

SELECT CAT_NAME, PRODUCT_NAME, QUANTITY 
FROM CATEGORIES C
JOIN PRODUCTS P ON P.CAT_ID = C.CAT_ID
JOIN ORDERS_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID


--- 3  DA PROVERQ ZA CENATA da vidq ima li variant da 
--pokaje samo edinstwenite produkti

SELECT DISTINCT PRODUCT_ID 
FROM ORDER_ITEMS OI
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID 
WHERE  PRICE > 50

--- 4  OK

SELECT TOTAL_AMOUNT
FROM CUSTOMERS C
JOIN ORDERS O ON O.ORDER_ID = C.ORDER_ID
WHERE (SEX = 'F' AND STATUS = 'SHIPPED')
ORDER BY O.DATE DESC

--- 5  OK

SELECT P.PRODUCT_NAME
FROM CATEGORIES C
JOIN PRODUCT P ON P.CAT_ID = C.CAT_ID
WHERE PRODUCT_NAME LIKE '%moon%'
ORDER BY C.CAT_NAME

--- 6  OK

INSERT INTO PRODUCTS (PRODUCT_NAME,PRICE)
VALUES ('Marswatch', 99)

--- 8  OK

DELETE FROM PRODUCTS
WHERE PRODUCT_ID = 15

--- 9 -- OK
LIST ALL MALE CUSTOMER NAMES AND THE LOWEST 
 AMOUNT THEY SPEND ON AN ORDER

SELECT C.CUSTOMER_NAME, O.TOTAL_AMOUT
FROM CUSTOMERS C
JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
WHERE SEX = 'M'
ORDER BY O.TOTAL_AMOUT ASC

SELECT C.CUSTOMER_NAME, O.TOTAL_AMOUT
FROM CUSTOMERS C
JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
WHERE SEX = 'M'
GROUP BY C.CUSTOMER_NAME
ORDER BY O.TOTAL_AMOUT ASC

 

 SELECT C.FNAME,C.LNAME, MIN(OI.UNIT_PRICE * OI.QUANTITY) AS TOTAL_AMOUNT
 FROM CUSTOMERS C
 JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
 JOIN ORDER_ITEMS OI ON OI.ORDER_ID = O.ORDER_ID
 WHERE C.GENDER = 'M'
 GROUP BY  C.FNAME, C.LNAME
 ORDER BY TOTAL_AMOUT ASC -- TUKA NE RABOTI 6TOTO PRAVQ REDA W ZAQWKATA I PO NEGO PODREJDAM
 -- TRQBWA PO VE4RE SUZDADENA KOLONA DA PODREJDAM

SELECT * 
FROM CUSTOMERS


--- 10  -- NA KANTAR  DA PROVERQ NAPRED

SELECT DISTINCT C.CUSTOMER_NAME, COUNT(O.ORDER_ID) 
FROM CUSTOMERS C
JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
WHERE TOTAL_AMOUT > 1000 

SELECT C.CUSTOMER_NAME, COUNT(O.ORDER_ID) 
FROM CUSTOMERS C
JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
WHERE TOTAL_AMOUT > 1000 
GROUP BY C.CUSTOMER_ID




NA FMI BD
SELECT C.FNAME, C.LNAME, COUNT(O.ORDER_ID)
FROM CUSTOMERS C 
JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = O.ORDER_ID
GROUP BY  C.FNAME, C.LNAME

-------------------------- UPRAJNENIQ KRAQ NA U4EBNIKA
 4 - 11 DA SE IZWEDAT IMENATA NA WSI4KI KLIENTI KOITO SA OT DURJAVI  W REGION ZAPADNA EWROPA

 SELECT C.FNAME, C.LNAME, S.NAME , R.REGION_ID
 FROM CUSTOMERS C, COUNTRIES S , REGIONS R
 WHERE C.COUNTRY_ID = S.COUNTRY_ID
 AND S.REGION_ID = R.REGION_ID
 AND R.NAME = 'Западна Европа'

 ZAD 5-1 

 CREATE VIEW PRODUCT_QUANTITY
 AS
 SELECT NAME, SUM(QUANTITY) AS SUM_QUANTITY
 FROM PRODUCTS P 
 JOIN ORDER_ITEMS OI ON P.PRODUCT_ID = OI.PRODUCT_ID
 GROUP BY P.PRODUCT_ID, NAME

 SELECT * FROM PRODUCT_QUANTITY

 ZAD 5-2 

 CREATE VIEW CUST_ORDER_NUM
 AS
 SELECT TOP 10 WITH TIES FNAME + ' ' + LNAME AS CUSTOMER, COUNT(ORDER_ID) AS ORDER_NUM
 FROM CUSTOMERS C 
 JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
 GROUP BY C.CUSTOMER_ID, FNAME + ' ' + LNAME
 ORDER BY ORDER_NUM DESC

 SELECT * FROM CUST_ORDER_NUM

 ZAD 6-1

 -- 4 - 13  да се изведе име фамилия и пол на клиентите направили последните 5 поръчки

 SELECT C.FNAME, C.LNAME, C.GENDER, O.ORDER_DATE
 FROM CUSTOMERS C, ORDERS O
 WHERE C.CUSTOMER_ID = O.CUSTOMER_ID
 ORDER BY ORDER_DATE DESC
 OFFSET 0 ROWS
 FETCH NEXT 5 ROWS ONLY

 -- 5-1 DA SE IZVEDE IZGLED KOITO POKAZWA IMENATA NA PRODUCTITE I OB6TO
 -- PORU4ANO KOLI4ESTWO PRODUKT
 CREATE VIEW PRODUCT_QUANTITY
 AS
 SELECT P.NAME, SUM(OI.QUANTITY) AS SUM_QUANTITY
 FROM PRODUCTS P
 JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
 GROUP BY P.PRODUCT_ID, P.NAME

 SELECT * FROM PRODUCT_QUAINITY

 ZAD 5-2 
 CREATE VIEW TOP_10_CUSTOMERS
 AS
 SELECT TOP 10 WITH TIES FNAME, C.LNAME AS CUSTOMER, COUNT(ORDER_ID) AS ORDER_NUM
 FROM CUSTOMERS C
 JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
 GROUP BY C.CUSTOMER_ID, FNAME, LNAME
 ORDER BY ORDER_NUM DESC

 5-4 
 CREATE VIEW  EMPLOYEE_ORDERS AS
 SELECT E.FNAME,E.LNAME, SUM(OI.UNIT_PRICE * OI.QUANTITY) AS ORDERS_TOTAL
 FROM EMPLOYEES E, ORDERS O, ORDER_ITEMS OI
 WHERE E.EMPLOYEE_ID = O.EMPLOYEE_ID
 AND OI.ORDER_ID = O.ORDER_ID
 GROUP BY E.EMPLOYEE_ID, E.FNAME, E.LNAME

 SELECT * FROM  EMPLOYEE_ORDERS
 ORDER BY ORDERS_TOTAL DESC

 - 5-5
 CREATE VIEW  EMP_TOP_SALARY AS
 SELECT TOP 5 E.FNAME, E.LNAME, D.NAME AS DEPARTMENT, E.SALARY
 FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
 ORDER BY E.SALARY DESC

 UPDATE CUSTOMER_COUNTRIES
 SET LNAME = 'КОЛЕВ'
 WHERE CUSTOMER_ID = 10

 CREATE VIEW CUSTOMER_COUNTRIESS (CUSTOM_COLUMN)
 AS
 SELECT C.COUNTRY_ID, C.NAME, C.REGION_ID,
		M.CUSTOMER_ID, M.FNAME, M.GENDER,
		M.LNAME,M.COUNTRY_ID AS CUST_COUNTRY_ID, M.EMAIL
 FROM COUNTRIES C
 JOIN CUSTOMERS M ON C.COUNTRY_ID = M.COUNTRY_ID


 INSERT INTO CUSTOMER_COUNTRIES(CUSTOMER_ID,FNAME,LNAME, CUST_COUNTRY_ID)
 VALUES(10, 'Иван', 'Петров', 'BG')

 SELECT * FROM CUSTOMERS_COUNTRIES
 WHERE CUSTOMER_ID = 10

 SELECT * 
 FROM CUSTOMERS 
 WHERE CUSTOMER_ID = 10 

 DELETE FROM CUSTOMERS
 WHERE CUSTOMER_ID = 10 

 DELETE FROM CUSTOMERS_COUNTRIES
 WHERE CUSTOMER_ID = 10

 ----- proceduri

 7-1 . Да се създаде съхранена процедура, която да извежда списък с поръчките на 
определен клиент, както и информация за самия клиент
 CREATE PROCEDURE CUSTOMER_ORDERSS
 AS
 SELECT C.FNAME, C.LNAME, C.EMAIL, C.ADDRESS, O.ORDER_ID, O.ORDER_DATE
 FROM CUSTOMERS C, ORDERS O
 WHERE C.CUSTOMER_ID = O.CUSTOMER_ID
 AND C.CUSTOMER_ID = 102

 EXECUTE CUSTOMER_ORDERSS

 7-2 2. Да се създаде процедура, която за подадена като входен параметър поръчка 
(идентификатор) извежда имена на служител, който я е обработил, както и 
общата й стойност.

CREATE PROCEDURE EMPLOYEE_ORDERSS @ORDER INT
AS
SELECT FNAME, LNAME, O.ORDER_ID, SUM(QUANTITY*UNIT_PRICE)
FROM EMPLOYEES E, ORDERS O, ORDER_ITEMS OI
WHERE E.EMPLOYEE_ID = O.EMPLOYEE_ID
AND OI.ORDER_ID = O.ORDER_ID
AND O.ORDER_ID = @ORDER
GROUP BY FNAME, LNAME, O.ORDER_ID

EXEC  EMPLOYEE_ORDERSS 2354

EXEC EMPLOYEE_ORDERSS @ORDER = 2354

7-3 Да се създаде процедура с изходни параметри, която ще връща като 
параметри броя на клиентите и броя на служителите.
CREATE PROCEDURE CUSTOMER_EMPLOYEE_COUNT_SECOND @CUST_COUNT INT OUTPUT,
@EMP_COUNT INT OUTPUT
AS
	SELECT @CUST_COUNT = COUNT(*) FROM CUSTOMERS;
	SELECT @EMP_COUNT = COUNT(*) FROM EMPLOYEES;


	DECLARE @EMPS INT , @CUSTS INT 
	EXEC GET_CUSTOMERS_EMPLOYEES_COUNT @CUSTS OUTPUT, @EMPS OUTPUT
	PRINT 'Employee count: ' + CAST(@EMPS AS VARCHAR)
	PRINT 'Customers count: ' + CONVERT(VARCHAR, @CUSTS)

	Пример 7-4. Да се създаде функция, връщаща като скаларна стойност текст, съдържащ 
името на отдел (подаден като параметър) и обща стойност на заплатите в него

CREATE FUNCTION DEPARTMENT_SALARYY (@DEPT_ID INT) RETURNS VARCHAR(200)
AS
BEGIN 
DECLARE @SUM_SALARY NUMERIC(10,2), @NAME VARCHAR(50)

SELECT @NAME = D.NAME, @SUM_SALARY = SUM(E.SALARY)
FROM DEPARTMENTS D 
JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID = @DEPT_ID
GROUP BY D.DEPARTMENT_ID, D.NAME

RETURN 'Обща сума на заплати в ' + @NAME + ' (ID ' +
		CAST(@DEPT_ID AS VARCHAR) + ') E ' +
		CAST(@SUM_SALARY AS VARCHAR) + '.'

END

SELECT DBO.DEPARTMNETS_SALARY(DEPARTMENT_ID)
FROM DEPARTMENTS

Пример 7-5. Да се създаде функция, връщаща като резултат резултатен набор служителите 
с техните длъжности
 
 CREATE FUNCTION EMPLOYEES_JOBS() RETURNS TABLE
 AS
 RETURN
	SELECT FNAME, LNAME, JOB_TITLE
	FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID

	SELECT * FROM DBO.EMPLOYEES_JOBS()
	ORDER BY FNAME, LNAME

--- 8-2 

------------------------------------- TRIGERI

CREATE TRIGGER TRG_INSERT_PRODUCTS
ON PRODUCTS
AFTER INSERT, UPDATE, DELETE
AS

PRINT 'INSERTED RECORDS ARE'
SELECT * FROM INSERTED

PRINT 'DELETED RECORDS ARE'
SELECT * FROM DELETED

SET NOCOUNT ON
INSERT INTO PRODUCTS(PRODUCT_ID, NAME, DESCR, PRICE)
VALUES (11, 'Мобилен телефон Samsung A410', 'Ергономичен корпус...', 1380);


INSERT INTO PRODUCTS(PRODUCT_ID, NAME, PRICE)
SELECT PRODUCT_ID + 10000, 'NEW ' + NAME, PRICE*1.2
FROM PRODUCTS
WHERE product_id BETWEEN 2400 AND 2405

DELETE FROM PRODUCTS
WHERE PRODUCT_ID > 10000

------------------------------------- TRIGERI
----------------------------------------- kursor
Пример 8-1. Да се създаде курсор, който демонстрира прочитане на данни ред по ред от 
курсор. Резултатният набор за целта ще съдържа всички клиенти от Германия. 
Стъпките от жизнения цикъл са обозначени в коментари.

DECLARE @CUST_ID VARCHAR(10), @F_NAME VARCHAR(20), @L_NAME VARCHAR(20) 
---1 
DECLARE CUSTOMERS_CURSOR CURSOR FOR
SELECT CUSTOMER_ID, FNAME, LNAME
FROM CUSTOMERS
WHERE COUNTRY_ID = 'DE'
--2
OPEN CUSTOMER_CURSOR
-- 3
FETCH NEXT FROM CUTOMER_CURSOR INTO @CUST_ID, @F_NAME, @L_NAME
PRINT 'Клиенти от германия: '
PRINT '----------------------------'
WHILE @@FETCH_STATUS = 0 
--4
PRINT @F_NAME + ' ' + @L_NAME + ' (ID = ' + @CUST_ID + ')'
FETCH NEXT FROM @CUST_ID , @F_NAME,	@L_NAME
END
--5
CLOSE CUSTOMERS_CURSOR

--6
DEALLOCATE CUSTOMER_CURSOR







Пример 8-2. Да се създаде курсор, който демонстрира обновяване и изтриване на ред от 
курсор. За целта резултатният набор ще съдържа всички записи от таблицата с 
професиите.

DECLARE @JOB_ID VARCHAR, @JOB_TITLE VARCHAR(25), MIN_SAL DECIMAL

DECLARE JOBS_CURSOR CURSOR FOR
SELECT JOB_ID, JOB_TITLE, MIN_SALARY FROM JOBS

OPEN JOBS_CUROSR 
FETCH NEXT FROM JOBS_CURSOR INTO @JOB_ID, @JOB_TITLE, @MIN_SAL

SET NOCOUNT ON

WHILE @@FETCH_STATUS = 0
BEGIN
	IF(@JOB_ID = 'IT_PROG')
	BEGIN
	PRINT 'Минимална заплата за ' + @JOB_TITLE +
		  ' ще бъде променена.' 
	UPDATE	JOBS SET MIN_SALARY = 5000
	WHERE CURRENT OF JOBS_CURSOR
	END

	IF(@JOB_ID = 'MK_REP')
	BEGIN
	PRINT @JOB_TITLE + ' ще бъде изтрита!'
	DELETE FROM JOBS WHERE CURRENT OF JOBS_CURSOR
	END

	FETCH NEXT FROM JOBS_CURSOR INTO @JOB_ID, @JOB_TITLE, @MIN_SAL
END

CLOSE JOB_CURSOR
DEALLOCATE JOBS_CURSOR

SET NOCOUNT OFF


Задача 8-1. Да се създаде курсор, който съдържа име, фамилия, телефон и заплата на 
всички служители със заплата от 10000 до 13000. Да се обходи курсорът, като се 
извеждат имената, телефона и заплатата на текущия служител, след което ако 
заплатата му е под 12000 да се увеличи с 5%

DECLARE @FNAME VARCHAR(20), @LNAME VARCHAR(25), @PHONE VARCHAR(20), @SALARY numeric(8,2), @EMPLOYEE_ID INT 

DECLARE EMPLOYEE_SALARY_BETWEEN_10_13K CURSOR FOR
SELECT  FNAME, LNAME, PHONE, SALARY, EMPLOYEE_ID
FROM EMPLOYEES
WHERE SALARY > 10000 AND SALARY < 13000

OPEN EMPLOYEE_SALARY_BETWEEN_10_13K
FETCH NEXT FROM EMPLOYEE_SALARY_BETWEEN_10_13K INTO @FNAME, @LNAME, @PHONE, @SALARY, @EMPLOYEE_ID

PRINT 'Имена на клиенти, на които ще се вдигне заплатата с 5% : ' -- само текста е различен в запазения тригер
PRINT '----------------------------'

WHILE @@FETCH_STATUS = 0
BEGIN 

	BEGIN
	PRINT @FNAME + ' ' + @LNAME+ ' ' + @PHONE+ ' ' + CAST(@SALARY  AS VARCHAR) 
	FETCH NEXT FROM EMPLOYEE_SALARY_BETWEEN_10_13K INTO @FNAME,	@LNAME, @PHONE, @SALARY, @EMPLOYEE_ID
	END

	IF(@SALARY<1200)
	BEGIN 
		PRINT 'Ще бъде вдигната заплатата с 5% на ' + @FNAME + ' ' + @LNAME+ ' ' + @PHONE+ ' ' + @SALARY 		
		UPDATE EMPLOYEES
		SET SALARY = SALARY + (SALARY*5/100)
		WHERE EMPLOYEE_ID = @EMPLOYEE_ID
	END
END
CLOSE EMPLOYEE_SALARY_BETWEEN_10_13K
DEALLOCATE EMPLOYEE_SALARY_BETWEEN_10_13K
------------------------------------------- kursor

SELECT * 
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 104

		UPDATE EMPLOYEES
		SET SALARY = SALARY + (SALARY*5/100)
		WHERE EMPLOYEE_ID = 104


Пример 7-4. Да се създаде функция, връщаща като скаларна стойност текст, съдържащ 
името на отдел (подаден като параметър) и обща стойност на заплатите в него.

CREATE FUNCTION DEPARTMENTS_SALARY(@DEPT_ID INT) RETURNS VARCHAR(200)
AS
BEGIN
 DECLARE @SUM_SALARY NUMERIC(10,2), @NAME VARCHAR(50)
 SELECT @NAME = D.NAME, @SUM_SALARY = SUM(E.SALARY)
 FROM DEPARTMENTS D JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.DEPARTMENT_ID = @DEPT_ID
 GROUP BY D.DEPARTMENT_ID, D.NAME
 RETURN 'Общата сума на заплати в ' + @NAME + ' (ID = ' +
 CAST(@DEPT_ID AS VARCHAR) + ') е ' +
 CAST(@SUM_SALARY AS VARCHAR) + '.'
END


CREATE FUNCTION DEPARTMENT_SALARY(@DEPT_ID INT) RETURNS VARCHAR(200)
AS
BEGIN
DECLARE @SUM_SALARY NUMERIC(10,2), @NAME VARCHAR(50)
SELECT @NAME = D.NAME, @SUM_SALARY = SUM(E.SALARY)
FROM DEPARTMENTS D JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID = @DEPT_ID
GROUP BY D.DEPARTMENT_ID, D.NAME
RETURN 'Общата сума на заплати в ' +@NAME + ' (ID = ' +
CAST(@DEPT_ID AS VARCHAR) + ') e ' +
CAST(@SUM_SALARY AS VARCHAR) + '.'
END


Задача 7-1. Да се създаде процедура, която извежда всички отдели и броя служители в тях.

CREATE PROCEDURE DEPARTMENT_EMPLOYEE_COUNT 
AS 
	SELECT D.NAME, COUNT(E.EMPLOYEE_ID)
	FROM DEPARTMENTS D JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
	GROUP BY D.DEPARTMENT_ID, D.NAME

EXECUTE DEPARTMENT_EMPLOYEE_COUNT


Задача 7-2. Да се създаде процедура с входен параметър номер на поръчка, която извежда 
списък на продуктите, единичните цени и количествата, участващи в тази
поръчка.

CREATE PROCEDURE PRODUCT_QUANTITY_ORDER @ORDER_ID INT
AS
	SELECT I.ORDER_ID, P.NAME, P.PRICE, I.QUANTITY
	FROM PRODUCTS P 
	JOIN ORDER_ITEMS I ON I.PRODUCT_ID = P.PRODUCT_ID
	WHERE I.ORDER_ID = @ORDER_ID
GO
-- ORDER 2369 FOR TEST

EXEC PRODUCT_QUANTITY_ORDER @ORDER_ID = 2369

Задача 7-3. Да се създаде процедура, която връща като параметри (OUTPUT) броя поръчки 
и общата стойност на поръчките на клиент с идентификатор, подаден като 
входен параметър.
 ------------------------------------------------------------------------------------------------------------- DA PROVERQ NAPRED VQRNO LI E
CREATE PROCEDURE CUSTOMER_ORDER @CUST_ID INT, @ORDERS_COUNT INT OUTPUT, @TOTAL_SUM INT OUTPUT  
AS
	SELECT	@ORDERS_COUNT = COUNT(O.ORDER_ID), @TOTAL_SUM = SUM(I.UNIT_PRICE * I.QUANTITY)
	FROM CUSTOMERS C
	JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID
	JOIN ORDER_ITEMS I ON O.ORDER_ID = I.ORDER_ID
	WHERE O.CUSTOMER_ID = @CUST_ID
GO

DECLARE @CUST_ID INT, @ORDERS INT, @TOTAL INT 
EXEC  CUSTOMER_ORDER 101, @ORDERS OUTPUT , @TOTAL OUTPUT
PRINT 'ORDERS COUNT : ' + CAST(@ORDERS AS VARCHAR)
PRINT 'TOTAL SUM ORDERS : ' + CONVERT(VARCHAR, @TOTAL)

SELECT CUSTOMER_ID, COUNT(ORDER_ID)
FROM ORDERS
GROUP BY CUSTOMER_ID


Задача 7-4. Да се създаде функция, която за подадена като параметър (идентификатор) 
длъжност връща като скаларна стойност наименование на длъжност и средната 
заплата за тази длъжност.

------------------------------------------- DA VNIMAVAM I DA ZADAVAM TO4NO TIPOWETE VMESTO VARCHAR DA E VARCHAR (10)
ALTER FUNCTION JOB_NAME_AVG_SALARY(@JOB_ID VARCHAR(10)) RETURNS VARCHAR (200)
AS 
BEGIN
	DECLARE @AVERAGE_SALARY NUMERIC(10,2), @NAME VARCHAR(60)
	SELECT @NAME = J.JOB_TITLE , @AVERAGE_SALARY  = ((J.MIN_SALARY + J.MAX_SALARY)/2)
	FROM JOBS J
	WHERE J.JOB_ID = @JOB_ID
	RETURN 'Име на отдел: ' + CAST(@NAME AS VARCHAR) + ' Средна заплата: ' + CAST(@AVERAGE_SALARY AS VARCHAR) + '.' 
END

SELECT DBO.JOB_NAME_AVG_SALARY(JOB_ID)
FROM JOBS

SELECT * FROM JOBS

SELECT DBO.DEPARTMENT_SALARY (DEPARTMENT_ID)
FROM DEPARTMENTS

Пример 7-5. Да се създаде функция, връщаща като резултат резултатен набор служителите 
с техните длъжности.
CREATE FUNCTION EMPLOYEE_JOBS() RETURNS TABLEASRETURN		SELECT FNAME, LNAME, JOB_TITLE		FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_IDSELECT * FROM DBO.EMPLOYEE_JOBS()ORDER BY FNAME, LNAME


--Схемата е обектът в базата данни, който притежава функцията. DBO идва от database 
--owner – това е специфична черта за MSSQL

-- ORDER BY MOJE DA SE POLZWA SAMO ZA OPREDELQNE NA 
--REDOTWETE S TOP ILI OFFSET ORDER BY SE 
--POLZWA I PRI IZWIKWANE NA IZGLEDA

CREATE VIEW CUSTOMERS_COUNTRIES AS
SELECT C.COUNTRY_ID, C.NAME, C.REGION_ID,
		M.CUSTOMER_ID, M.FNAME, M.LNAME, M.GENDER,
		M.COUNTRY_ID AS CUST_COUNTRY_ID, M.EMAIL
FROM COUNTRIES C JOIN CUSTOMERS M ON C.COUNTRY_ID = M.COUNTRY_ID

INSERT INTO CUSTOMERS_COUNTRIES(CUSTOMER_ID, FNAME, LNAME, CUST_COUNTRY_ID)
VALUES (10,'Иван', 'Петров','BG')

Пример 5-7. Да се промени фамилията на клиент с идентификатор 10.
UPDATE CUSTOMERS_COUNTRIES
SET LNAME = 'Колев'
WHERE CUSTOMER_ID = 10

Пример 5-8. Да се изтрие клиент с идентификатор 10.
DELETE FROM CUSTOMERS_COUNTRIES
WHERE CUSTOMER_ID = 10
-- OBA4E DAWA GRE6KA ZA6TOTO IZGLEDA E BAZIRAN NA 2 TABLICI

5.5.Задачи 
Задача 5-1. Да се създаде изглед, който съдържа имената
на продуктите и общо поръчано 
количество от продукт.

CREATE VIEW PRODUCT_NAME AS
SELECT P.NAME, SUM(QUANTITY) AS QUANTITY
FROM PRODUCTS P, ORDER_ITEMS OI 
WHERE P.PRODUCT_ID = OI.PRODUCT_ID
GROUP BY P.NAME



Задача 5-2. Да се създаде изглед, който съдържа десетимата
клиенти с най-голям брой 
поръчки. Ако последният клиент има равен брой поръчки 
с други клиенти, те 
също да участват в изгледа

CREATE VIEW CUSTOMER_ORDERS AS
SELECT TOP 10 WITH TIES C.FNAME +' '+ C.LNAME AS CUSTOMER_NAME, SUM(ORDER_ID) AS ORDER_QUANTITY
FROM CUSTOMERS C, ORDERS O
WHERE C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.FNAME, C.LNAME
ORDER BY ORDER_QUANTITY DESC

USE TRADECOMPANY_TWO


BEGIN TRANSACTION

INSERT CUSTOMERS(CUSTOMER_ID,COUNTRY_ID,FNAME,LNAME,ADDRESS,EMAIL,GENDER)
VALUES (1001, 'BG', 'Иван', 'Николов', 'бул. България 236, Пловдив',
'ivannikolov@mail.com', 'M'); 
INSERT ORDERS(ORDER_ID, CUSTOMER_ID, EMPLOYEE_ID, SHIP_ADDRESS, ORDER_DATE)
VALUES(1, 1001, 107, 'бул. Македония 12, Пловдив', GETDATE());
INSERT ORDER_ITEMS(ORDER_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY)
VALUES(1, 1726, 99, 1);
INSERT ORDER_ITEMS(ORDER_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY)
VALUES(1, 1782, 615, 1);

COMMIT TRANSACTION


Пример 6-2. Да се направи транзакция, която променя фамилията на клиент с 
идентификатор = 1001, след което отхвърля направените промени

BEGIN TRANSACTION 

PRINT 'Фамилия преди промяната:'

SELECT LNAME
FROM CUSTOMERS
WHERE CUSTOMER_ID = 1001

UPDATE CUSTOMERS SET LNAME = 'Иванов'
WHERE CUSTOMER_ID = 1001

PRINT 'Фамилия след промяната:  '

SELECT FNAME, LNAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID = 1001

ROLLBACK TRANSACTION

PRINT 'Фамилия след отхвърлянето на промяната:  '

SELECT LNAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID = 1001



Пример 6-3. Да се направи транзакция, която въвежда нов клиент, поставя точка на запис, 
въвежда поръчка, след което отхвърля промените до точката на запис, т.е. 
отхвърля се само поръчката.
SELECT *
FROM CUSTOMERS
WHERE CUSTOMER_ID = 1002

BEGIN TRANSACTION 

INSERT CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, GENDER)
VALUES (1002, 'BG', 'Петър', 'Василев', 'M');
SAVE TRAN point1
INSERT ORDERS(ORDER_ID, CUSTOMER_ID, EMPLOYEE_ID, ORDER_DATE)
VALUES (2, 1002, 110, GETDATE());
ROLLBACK TRAN point1

COMMIT TRAN


--------------------------------------------------------------------------------------------------------- NE E RE6ENA
6.5.Задачи 
Задача 6-1. Да се направи транзакция транзакция, която има за цел да изтрие отдел 
„Мениджмънт“, като преди това прехвърли всички служители от него в отдел 
„Администрация“.

BEGIN TRAN 

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90 

UPDATE EMPLOYEES
SET DEPARTMENT_ID = 100
WHERE DEPARTMENT_ID = 90

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90 

SELECT DEPARTMENT_ID
FROM DEPARTMENTS


DELETE FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 90


COMMIT TRAN


Задача 6-2. Да се направи транзакция транзакция, която изтрива продукт с идентификатор 
1726, като преди това го изтрива от всички поръчки, в които участва, като накрая 
отхвърля направените промени.

BEGIN TRAN

DELETE FROM ORDER_ITEMS
WHERE PRODUCT_ID = 1726

DELETE FROM PRODUCTS
WHERE PRODUCT_ID = 1726

ROLLBACK TRAN

COMMIT TRAN

SELECT *
FROM ORDER_ITEMS 
WHERE PRODUCT_ID = 1726	




Пример 7-1. Да се създаде съхранена процедура, която да извежда списък с поръчките на 
определен клиент, както и информация за самия клиент

CREATE PROCEDURE CUSTOMER_ORDERS_PROCEDURE
AS
SELECT FNAME, LNAME, EMAIL, ADDRESS, ORDER_ID, ORDER_DATE
FROM CUSTOMERS JOIN ORDERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
WHERE CUSTOMERS.CUSTOMER_ID = 102

EXEC CUSTOMER_ORDERS_PROCEDURE

Пример 7-2. Да се създаде процедура, която за подадена като входен параметър поръчка 
(идентификатор) извежда имена на служител, който я е обработил, както и 
общата й стойност.

CREATE PROCEDURE EMPLOYEES_ORDERS_PROCEDURE @ORDER INT
AS
SELECT FNAME, LNAME, O.ORDER_ID, SUM(UNIT_PRICE*QUANTITY) AS TOTAL
FROM EMPLOYEES E 
JOIN ORDERS O ON O.EMPLOYEE_ID = E.EMPLOYEE_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = O.ORDER_ID
WHERE O.ORDER_ID = 2354 
GROUP BY FNAME, LNAME, O.ORDER_ID

EXEC EMPLOYEES_ORDERS_PROCEDURE @ORDER = 2354

Пример 7-3. Да се създаде процедура с изходни параметри, която ще връща като 
параметри броя на клиентите и броя на служителите.
CREATE PROCEDURE GET_CUSTOMERS_EMPLOYEES_COUNT @CUST_COUNT INT OUTPUT,
@EMPS_COUNT INT OUTPUT
AS
SELECT @CUST_COUNT = COUNT(*) FROM CUSTOMERS;
SELECT @EMPS_COUNT = COUNT(*) FROM EMPLOYEES;

DECLARE @EMPS INT, @CUSTS INT
EXEC GET_CUSTOMERS_EMPLOYEES_COUNT @EMPS OUTPUT, @CUSTS OUTPUT
PRINT 'EMPLOYEES COUNT: ' + CAST(@EMPS AS VARCHAR)
PRINT 'CUSTOMERS COUNT: ' + CONVERT(VARCHAR, @CUSTS)
----------------------------------------------------------------------------------------- PROCEDURI
Пример 7-2. Да се създаде процедура, която за подадена като входен параметър поръчка 
(идентификатор) извежда имена на служител, който я е обработил, както и 
общата й стойност

CREATE PROCEDURE CUSTOMER_ORDER_PROCEDURE  @ORDER INT
AS
SELECT FNAME, LNAME, SUM(QUANTITY * UNIT_PRICE)
FROM EMPLOYEE E 
JOIN ORDERS O ON O.EMPLOYEE_ID = E.EMPLOYEE_ID 
JOIN ORDER_ITEM OI ON O.ORDER_ID = OI.ORDER_ID
WHERE O.ORDER_ID = 2354
GROUP BY FNAME, LNAME, O.ORDER_ID

EXEC CUSTOMER_ORDER_PROCEDURE @ORDER = 2354 

Пример 7-3. Да се създаде процедура с изходни параметри, която ще връща като 
параметри броя на клиентите и броя на служителите.
CREATE PROCEDURE GET_CUSTOMERS_EMPLOYEES_COUNT @CUST_COUNT INT OUTPUT,
@EMPLOYEES_COUNT INT OUTPUT
AS
	SELECT	@CUST_COUNT = COUNT(*) FROM CUSTOMERS;
	SELECT  @EMPLOYEES_COUNT = COUNT(*) FROM EMPLOYEES;

DECLARE @EMPS INT, @CUSTS INT
EXEC GET_CUSTOMERS_EMPLOYEES_COUNT @EMPS OUTPUT, @CUSTS OUTPUT
PRINT 'EMPLOYEE COUNT: ' + CAST(@EMPS AS VARCHAR)
PRINT 'CUSTOMERS COUNT: ' + CONVERT(VARCHAR, @CUSTS)




------------------ TEST QUERY
SELECT OI.QUANTITY, P.NAME, O.SHIP_ADDRESS
FROM ORDER_ITEMS OI
JOIN PRODUCTS P ON P.PRODUCT_ID = OI.PRODUCT_ID
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
--- 408 REDA ZA GORANATA ZAQWKA
SELECT OI.QUANTITY, P.NAME, O.SHIP_ADDRESS
FROM ORDER_ITEMS OI
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
JOIN PRODUCTS P ON P.PRODUCT_ID = OI.PRODUCT_ID
--- 408 REDA ZA GORANATA ZAQWKA
SELECT *
FROM PRODUCTS P
INNER JOIN ORDER_ITEMS OI ON P.PRODUCT_ID = OI.PRODUCT_ID
INNER JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
--- 408 REDA ZA GORANATA ZAQWKA

SELECT COUNT(PRODUCT_ID)
FROM PRODUCTS

SELECT COUNT(ORDER_ID)
FROM ORDERS

SELECT *
FROM ORDER_ITEMS
------------------ TEST QUERY

SELECT R.NAME, C.NAME, D.MANAGER_ID
FROM DEPARTMENTS D
JOIN  COUNTRIES C ON C.COUNTRY_ID = D.COUNTRY_ID
JOIN REGIONS R ON C.REGION_ID = R.REGION_ID

зад 3
LIST ALL UNIQUE PRODUCT IDS OF ordered products 
that have been orderd with price greater than 50$.

SELECT DISTINCT P.PRDUCT_ID,
FROM PRODUCTS P
WHERE P.PRICE > 50
JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID

SELECT *
FROM COUNTRIES




select avg(total_amount)
from orders

 AVG(CUSTOMER_ID)
select CUSTOMER_ID
from CUSTOMERS


SELECT DISTINCT COUNTRY_ID
FROM CUSTOMERS
WHERE COUNTRY_ID IN (SELECT COUNTRY_ID
 FROM DEPARTMENTS)

SELECT FNAME, LNAME
FROM CUSTOMERS
WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM ORDERS)

SELECT NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES)

SELECT *
FROM REGIONS NATURAL JOIN COUNTRIES

SELECT *
FROM COUNTRIES

SELECT FNAME, LNAME
FROM CUSTOMERS
UNION 
SELECT FNAME, LNAME
FROM EMPLOYEES




SELECT O.ORDER_ID, (COUNT(OI.QUANTITY)*COUNT(OI.UNIT_PRICE)) AS ORDER_PRICE
FROM ORDERS O, ORDER_ITEMS OI
GROUP BY OI.ORDER_PRICE




SELECT Е.DEPARTMENT_ID, COUNT(Е.EMPLOYEE_ID) AS EMP_COUNT
FROM EMPLOYEES Е, 
GROUP BY DEPARTMENT_ID



-- PROMQNA NA ZAPLATA NA SLUJITEL
UPDATE EMPLOYEES
SET SALARY = 20200
WHERE EMPLOYEES_ID = 1501
-- IZTRIVANE
DELETE FROM ORDERS
WHERE ORDER_ID = 1

USE TRADECOMPANY

SELECT *
FROM ORDERS
WHERE ORDER_ID = 2354

SELECT * 
FROM ORDER_ITEMS
WHERE PRODUCT_ID = 2254 AND ORDER_ID = 2354 


 use master go
 alter database TRADECOMPANY_test set single_user with rollback immediate

 drop database TRADECOMPANY_test

 ------------------------------------------------------------
 -- if database doesnt want to be deleted because is in use 
USE master;
GO
ALTER DATABASE TRADECOMPANY_test 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE TRADECOMPANY_test;
------------------------------------------------------------

SELECT* FROM COUNTRIES

DROP DATABASE TRADECOMPANY

CREATE DATABASE TRADECOMPANY

CREATE DATABASE TRADECOMPANY_test

USE TRADECOMPANY_test

USE TRADECOMPANY_TWO



CREATE TABLE REGIONS 
(
 REGION_ID SMALLINT NOT NULL PRIMARY KEY IDENTITY(1, 1),
 NAME VARCHAR(25) NOT NULL UNIQUE
)

ALTER TABLE REGIONS ALTER COLUMN NAME VARCHAR (25) NOT NULL 

ALTER TABLE REGIONS CONVERT TO CHARACTER SET utf8

 ALTER DATABASE TRADECOMPANY CHARACTER SET utf8 COLLATE utf8_general_ci;

use TRADECOMPANY

-- ako dawa problem s smqna na colliosion  right-click database to change, and then select Properties dialog box, 
--select the Options page. From the Restrict Access option, select Single. for single user . posle triq tablicata i q suzdawam otnovo 
-- slagam dannite i ve4e trqbwa da moje da raboti s bulgarski ezik	

INSERT INTO REGIONS 
VALUES ('БЪЛГАРИЯ');

SELECT * FROM REGIONS ,COUNTRIES,CUSTOMERS,DEPARTMENTS,EMPLOYEES,JOBS,ORDER_ITEMS,ORDERS,PRODUCTS

DELETE  FROM REGIONS

DROP TABLE REGIONS

USE master;
GO
ALTER DATABASE TRADECOMPANY
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE TRADECOMPANY
SET READ_ONLY;
GO
ALTER DATABASE TRADECOMPANY
SET MULTI_USER;
GO

CREATE TABLE COUNTRIES 
(
 COUNTRY_ID CHAR(2) NOT NULL,
 NAME VARCHAR(40) NOT NULL,
 REGION_ID SMALLINT NULL,
 CONSTRAINT PK_COUNTRY PRIMARY KEY (COUNTRY_ID),
 CONSTRAINT FK_COUNTRIES_REGIONS FOREIGN KEY (REGION_ID)
 REFERENCES REGIONS (REGION_ID)
)

ALTER TABLE COUNTIRES
DROP CONSTRAINT FK_COUNTRIES_REGIONS;

ALTER TABLE COUNTRIES ADD CONSTRAINT FK_COUNTRIES_REGIONS FOREIGN KEY (REGION_ID)
 REFERENCES REGIONS (REGION_ID)



DROP TABLE COUNTRIES

CREATE TABLE CUSTOMERS 
(
 CUSTOMER_ID NUMERIC(6) NOT NULL,
 COUNTRY_ID CHAR(2) NOT NULL,
 FNAME VARCHAR(20) NOT NULL,
 LNAME VARCHAR(20) NOT NULL,
 ADDRESS TEXT NULL,
 EMAIL VARCHAR(30) NULL,
 GENDER CHAR(1) NULL DEFAULT 'M'
 CONSTRAINT CUST_GENDER CHECK (GENDER IS NULL OR (GENDER IN ('M','F'))),
 CONSTRAINT PK_CUSTOMERS PRIMARY KEY (CUSTOMER_ID)
)


DROP TABLE CUSTOMERS

ALTER TABLE CUSTOMERS
 ADD CONSTRAINT FK_CUSTOMER_COUNTRIES FOREIGN KEY (COUNTRY_ID)
 REFERENCES COUNTRIES (COUNTRY_ID)


 CREATE TABLE JOBS 
(
 JOB_ID VARCHAR(10) NOT NULL PRIMARY KEY,
 JOB_TITLE VARCHAR(35) NOT NULL,
 MIN_SALARY NUMERIC(6) NULL,
 MAX_SALARY NUMERIC(6) NULL
)

CREATE TABLE EMPLOYEES 
(
 EMPLOYEE_ID INT NOT NULL,
 FNAME VARCHAR(20) NOT NULL,
 LNAME VARCHAR(25) NOT NULL,
 EMAIL VARCHAR(40) NOT NULL,
 PHONE VARCHAR(20) NULL,
 HIRE_DATE DATETIME NOT NULL,
 SALARY NUMERIC(8,2) NOT NULL
 CONSTRAINT SALARY_CHECK CHECK (SALARY > 0),
 JOB_ID VARCHAR(10) NOT NULL,
 MANAGER_ID INT NULL,
 DEPARTMENT_ID INT NULL,
 CONSTRAINT PK_EMPLOYEES PRIMARY KEY (EMPLOYEE_ID),
 CONSTRAINT UK_EMAIL UNIQUE (EMAIL),
 CONSTRAINT FK_EMPLOYEE_JOBS FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID),
 CONSTRAINT FK_EMPLOYEE_MANAGERS FOREIGN KEY (MANAGER_ID)
 REFERENCES EMPLOYEES (EMPLOYEE_ID)
)


CREATE TABLE DEPARTMENTS
(
 DEPARTMENT_ID INT NOT NULL,
 NAME VARCHAR(30) NOT NULL,
 MANAGER_ID INT NULL,
 COUNTRY_ID CHAR(2) NOT NULL,
 CITY VARCHAR(30) NOT NULL,
 STATE VARCHAR(25) NULL,
 ADDRESS VARCHAR(40) NULL,
 POSTAL_CODE VARCHAR(12) NULL,
 CONSTRAINT PK_DEPT PRIMARY KEY (DEPARTMENT_ID),
 CONSTRAINT FK_DEPT_MGR FOREIGN KEY (MANAGER_ID)
 REFERENCES EMPLOYEES (EMPLOYEE_ID),
 CONSTRAINT FK_DEPT_COUNTRIES FOREIGN KEY (COUNTRY_ID)
 REFERENCES COUNTRIES (COUNTRY_ID)
)
ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_EMPLOYEE_DEPARTMENTS FOREIGN KEY (DEPARTMENT_ID) 
REFERENCES DEPARTMENTS


CREATE TABLE ORDERS 
(
 ORDER_ID INT NOT NULL PRIMARY KEY,
 ORDER_DATE DATETIME NOT NULL,
 CUSTOMER_ID NUMERIC(6) NOT NULL FOREIGN KEY REFERENCES CUSTOMERS,
 EMPLOYEE_ID INT NOT NULL FOREIGN KEY REFERENCES EMPLOYEES,
 SHIP_ADDRESS VARCHAR(150) NULL
)


CREATE TABLE PRODUCTS 
(
 PRODUCT_ID INT NOT NULL PRIMARY KEY,
 NAME VARCHAR(70) NOT NULL,
 PRICE NUMERIC(8,2) NOT NULL,
 DESCR VARCHAR(2000) NULL,
)

CREATE TABLE ORDER_ITEMS
(
 ORDER_ID INT NOT NULL,
 PRODUCT_ID INTEGER NOT NULL,
 UNIT_PRICE NUMERIC(8,2) NOT NULL,
 QUANTITY NUMERIC(8) NOT NULL,
 CONSTRAINT PK_ORDER_ITEMS PRIMARY KEY (ORDER_ID, PRODUCT_ID),
 CONSTRAINT FK_ORD_ITEM_ORDERS FOREIGN KEY (ORDER_ID)
 REFERENCES ORDERS (ORDER_ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT FK_ORD_ITEM_PRODUCTS FOREIGN KEY (PRODUCT_ID)
 REFERENCES PRODUCTS (PRODUCT_ID)
)


INSERT INTO REGIONS (NAME)
VALUES ('Източна Европа');

SELECT * FROM REGIONS

DELETE FROM REGIONS

ALTER DATABASE TRADECOMPANY
CHARACTER  Cyrillic_General_CI_AI_KS
COLLATE Cyrillic_General_CI_AI_KS

SELECT * FROM sys.fn_helpcollations() WHERE [name] NOT LIKE N'SQL%';

ALTER DATABASE TRADECOMPANY CHARACTER SET utf8mb4 COLLATE
utf8mb4_unicode_ci;

cp1251_general_ci

ZABRAVIH HOI KOD OT MARKIRANITE OPRAVI PROBLEMA
*/
DELETE FROM REGIONS

SELECT * FROM REGIONS

INSERT INTO COUNTRIES (COUNTRY_ID, NAME, REGION_ID)
VALUES ('BG', 'България', 1);

DELETE FROM COUNTRIES
SELECT * FROM COUNTRIES


INSERT CUSTOMERS(CUSTOMER_ID,COUNTRY_ID,FNAME,LNAME,ADDRESS,EMAIL,GENDER)
VALUES (1001, 'BG', 'Георги', 'Генев', 'бул. България 100, Пловдив',
'ggenev@gmail.com', 'M');

DELETE FROM CUSTOMERS
SELECT * FROM CUSTOMERS

INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('SA_REP', 'Търговски представител', 9000, 17000);

DELETE FROM JOBS
SELECT * FROM JOBS

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, NAME, COUNTRY_ID, CITY, STATE, 
ADDRESS, POSTAL_CODE)
VALUES (80, 'Продажби', 'BG', 'Пловдив', 'Пловдив', 'бул. Марица 10', '4000')

DELETE FROM DEPARTMENTS
SELECT * FROM DEPARTMENTS

INSERT INTO EMPLOYEES(EMPLOYEE_ID, FNAME, LNAME, EMAIL, PHONE, HIRE_DATE,
JOB_ID, SALARY, DEPARTMENT_ID)
VALUES (1501, 'Петър', 'Тодоров', 'petert@trade_company.com', '0899332013',
CONVERT(DATE, '30-01-2017', 105), 'SA_REP', 19000, 80);

DELETE FROM EMPLOYEES
SELECT * FROM EMPLOYEES

INSERT INTO PRODUCTS(PRODUCT_ID, NAME, DESCR, PRICE)
VALUES (20001, 'Смартфон Samsung Galaxy S10e', 'Смартфон Samsung Galaxy S10e, 
Dual SIM, 128GB, 6GB RAM, 4G, Black.', 1400);

DELETE FROM PRODUCTS
SELECT * FROM PRODUCTS

INSERT ORDERS(ORDER_ID, CUSTOMER_ID, EMPLOYEE_ID, SHIP_ADDRESS, ORDER_DATE)
VALUES (1, 1001, 1501, 'бул. България 140, Пловдив', CONVERT(DATETIME, '13-
07-2010 10:30', 105));

DELETE FROM ORDERS
SELECT * FROM ORDERS

INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY)
VALUES (1, 20001, 1400, 2);

DELETE FROM ORDER_ITEMS
SELECT * FROM ORDER_ITEMS

UPDATE EMPLOYEES
SET SALARY = 20200
WHERE EMPLOYEE_ID = 1501

DELETE FROM ORDERS
WHERE ORDER_ID = 1

-- упражнение страница >=60

SELECT *
FROM PRODUCTS 
WHERE PRICE > 2000
ORDER BY PRICE;

SELECT COUNT(EMPLOYEE_ID)
FROM EMPLOYEES;


SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS  EMP_COUNT
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID

/*
4.2.1. Задачи 
Задача 4-1. Да се изведат имената, заплатите и идентификаторите на длъжностите на 
служителите, работещи в отдели 50 и 80. Резултатът да е подреден по фамилия
на служител във възходящ ред.

SELECT FNAME, LNAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 80
ORDER BY LNAME ASC;

Задача 4-2. Да се изведат общата сума на заплатите и броя служители в отдел 60.

SELECT SUM(SALARY), COUNT(DEPARTMENT_ID)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

Задача 4-3. За всички поръчки да се изведат идентификатор на поръчка и обща стойност на 
поръчката. Резултатът да е подреден по стойност на поръчката в низходящ ред.

SELECT ORR.ORDER_ID, OI.UNIT_PRICE
FROM ORDERS ORR, ORDER_ITEMS OI  
ORDER BY  UNIT_PRICE


*/

SELECT COUNTRY_ID 
FROM CUSTOMERS
UNION
SELECT COUNTRY_ID 
FROM DEPARTMENTS
ORDER BY COUNTRY_ID

/*
4.3.1. Задачи 
Задача 4-4. Да се изведат всички малки имена на клиенти и служители с евентуалните 
повторения, сортирани в низходящ ред по име.

SELECT FNAME
FROM EMPLOYEES
UNION ALL
SELECT FNAME
FROM CUSTOMERS
ORDER BY FNAME ASC

Задача 4-5. Да се изведат име и фамилия на клиенти и служители без повторения, а като 
трета колона за клиентите да се използва израз, генериращ низа „Клиент 
(<идентификатор>)“, за служителите – „Служител (<идентификатор>)“.

SELECT 'CUSTOMER' AS TYPE, FNAME, LNAME 
FROM CUSTOMERS
UNION
SELECT 'EMPLOYEE' AS TYPE, FNAME, LNAME 
FROM EMPLOYEES

*/

/*4.4.1. Задачи 
Задача 4-6. Да се изведат общите собствени имена на клиенти и служители.

SELECT DISTINCT FNAME
FROM CUSTOMERS
WHERE FNAME IN (SELECT FNAME FROM EMPLOYEES)

SELECT DISTINCT FNAME
FROM CUSTOMERS
WHERE EXISTS 
(SELECT * 
FROM EMPLOYEES
WHERE EMPLOYEES.FNAME = CUSTOMERS.FNAME)

*/

-- MSSQL Да се изведат идентификаторите на държавите, в които има клиенти и в същото време няма отдели на фирмата.

SELECT COUNTRY_ID FROM CUSTOMERS
EXCEPT
SELECT COUNTRY_ID FROM DEPARTMENTS

-- ALTERNATIVNIQ KOD NA TOWA DA SE POLZWA MINUS OPERATOR E 

SELECT DISTINCT COUNTRY_ID
FROM CUSTOMERS
WHERE NOT EXISTS
(SELECT * 
 FROM  DEPARTMENTS
 WHERE DEPARTMENTS.COUNTRY_ID = CUSTOMERS.COUNTRY_ID)


--
/* 4.5.1. Задачи 
Задача 4-7. Да се изведат собствените имена на клиенти, които не се срещат сред тези на 
служителите.

SELECT DISTINCT FNAME
FROM CUSTOMERS
WHERE NOT EXISTS 
(SELECT FNAME
FROM EMPLOYEES
WHERE EMPLOYEES.FNAME = CUSTOMERS.FNAME)


Пример 4-9. Да се изведат държавите и регионите, в които се намират.

SELECT *
FROM COUNTRIES
INNER JOIN REGIONS 
ON REGIONS.REGION_ID = COUNTRIES.REGION_ID

Пример 4-11. Да се изведат имената на клиентите, имената на държавите, от които са, и 
имената на регионите на държавите.

SELECT FNAME, LNAME, COUNTRIES.NAME, REGIONS.NAME
FROM CUSTOMERS
JOIN COUNTRIES ON CUSTOMERS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID

	Пример 4-12. Да се изведат регионите и държавите, които се намират в тях. Резултатният 
набор да включва и регионите, в които няма въведени държави
SELECT *
FROM REGIONS R 
LEFT OUTER JOIN COUNTRIES C ON R.REGION_ID = C.REGION_ID

ример 4-15. Да се изведат държавите и регионите, в които се намират.

SELECT *
FROM COUNTRIES, REGIONS
WHERE COUNTRIES.REGION_ID = REGIONS.REGION_ID

Пример 4-16. Да се изведат отделите, в които има назначени служители
SELECT NAME
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES)

SELECT NAME
FROM DEPARTMENTS D
WHERE EXISTS (SELECT 1
 FROM EMPLOYEES E
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID)

 Пример 4-17. Да се изведат имената на клиентите, които все още не са правили поръчки.
SELECT FNAME, LNAME
FROM CUSTOMERS
WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID
 FROM ORDERS)

 SELECT FNAME, LNAME
FROM CUSTOMERS
WHERE NOT EXISTS (SELECT *
 FROM ORDERS
 WHERE CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID)

 Пример 4-18. Да се изведат комбинациите между всички региони и държави, сортирани по 
име на държава.
SELECT *
FROM REGIONS CROSS JOIN COUNTRIES
ORDER BY COUNTRIES.NAME

4.6.7. Задачи 
Задача 4-8. Да се изведат идентификаторите и датите на поръчките, както и имената на 
служителите, които са ги обработили.

SELECT ORD.ORDER_ID, ORD.ORDER_DATE,  E.FNAME, E.LNAME
FROM ORDERS ORD
JOIN  EMPLOYEES E ON ORD.EMPLOYEE_ID = E.EMPLOYEE_ID

Задача 4-9. Да се изведат имената на всички клиенти и идентификаторите на поръчките им.
В резултатния набор да участват и клиентите, които все още не са правили 
поръчки.


SELECT  CU.FNAME, CU.LNAME, ORD.ORDER_ID
FROM ORDERS ORD
RIGHT OUTER JOIN CUSTOMERS CU ON ORD.CUSTOMER_ID = CU.CUSTOMER_ID

Задача 4-10. Да се изведат имената на продуктите, които не са поръчвани до момента.

SELECT P.NAME
FROM PRODUCTS P
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID  FROM ORDERS)

Задача 4-11. Да се изведат имената на всички клиенти, които са от държави в регион 
„Западна Европа“

SELECT CUSTOMERS.FNAME, CUSTOMERS.LNAME, REGIONS.NAME
FROM CUSTOMERS 
JOIN COUNTRIES ON CUSTOMERS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID
WHERE REGIONS.NAME = 'Западна Европа'

Пример 4-11. Да се изведат имената на клиентите, имената на държавите, от които са, и 
имената на регионите на държавите.

SELECT FNAME, LNAME, COUNTRIES.NAME, REGIONS.NAME
FROM CUSTOMERS
JOIN COUNTRIES ON CUSTOMERS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID
*/


















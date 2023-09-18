SELECT * FROM customer_purchases WHERE NOT (location = 'Gila county' or location = 'Santa Cruz county');

SELECT * FROM customer_purchases WHERE location IN('Gila county', 'Santa Cruz County');

SELECT * FROM customer_purchases WHERE purchases BETWEEN 1000 AND 2000;

SELECT * FROM customer_purchases WHERE  location LIKE 'g __%';

SELECT ClientOrderInformation AS Orders FROM ClientOrders

SELECT CONCAT (first_name, " " , last_name) AS 'client_names' FROM client_details


SELECT x.column1, x.column2, y.cloumn1 , y.cloumn2
FROM table_1 AS x, table_2 AS y 
WHERE x.column2 < 12 and y.cloumn2 < 5;

SELECT ORDERID , date_food_order_placed_with_supplier AS "Order place Date" , Date_food_order_received_from_supplier 
AS "ORDER Recevied Date"  , order status  from Food_Orders_delivery_status;

SELECT CONCAT(ORDERID, "" , Order_status) AS "Order Status" from Food_Orders_delivery_status;

SELECT s.StarterName , s.Cost , c.CourseName, c.Cosot FROM courses AS c, Starters AS s where c.Cost 
< 12 AND s.cost < 5;

SELECT clients.FullName FROM Clients INNER JOIN ORDERS ON Clients.ClientID = Orders.ClientID;

SELECT clients.ClientID, Clients.FullName AS "Full name", Clients.ContactNumbber AS "Phone number" , order S.ProductID AS 
"Product code", orders.Quantity as "Items Quantity", Orders.Cost FROM Clients INNER JOIN orders ON 
clients.ClientID = Orders.ClientsID; 
 
 SELECT c.ClientID AS "Client ID" , c.Fullname AS "Full name", o.OrderID AS "Order ID", o.Quantity, o.Cost
 from clients AS c LEFT JOIN AS o On c.clientID = o.ClientID;
 
 SELECT c.ClientID AS "Client ID", c.FullName AS "Full name", o.OrderID AS "Order ID", o.Quntity, o.cost
 FROM Client AS RIGHT JOIN  Order AS o ON c.ClientID = o.ClientID;
 
SELECT e1.fullname as "Line manager", e2.FullName AS "Employee" FROM Employees AS e1 INNER JOIN
Employees AS e2 on e1.EmployeeID = e2.LineManagerID;

SELECT FullName, Location FROM CurrentClients UNION SELECT FullName, location from legacyClients;

SELECT FullName, Location FROM CurrentClients UNION SELECT FullName, location from legacyClients;

SELECT Department FROM orders GROUP BY Department;

SELECT Department, COUNT(Department) FROM orders GROUP BY Department;

SELECT department, SUM(orderTotal) FROM orders GROUP BY Department;

SELECT department, MIN(orderTotal) FROM orders GROUP BY Department;

SELECT department, AVG(orderTotal) FROM orders GROUP BY Department;

SELECT Department, SUM(OrderTotal) FROM orders GROUP BY Department;

SELECT Department, SUM(OrderTotal) FROM orders GROUP BY Department HAVING SUM(OrderTotal) > 2275;

SELECT Department, SUM(OrderTotal) AS total  FROM orders GROUP BY Department HAVING total > 2275;
INSERT INTO EmployeeContactinfo(EmployeeID, contactNumber, Email) VALUES (1, 351478025, "seamus.h@luckyshrub.com");

REPLACE INTO EmployeeContactinfo(EMployeeID, ContactNumbber, Email) VALUES (1,351478025, "thomas.e@luckyshrub.com" )

REPLACE INTO EmployeeContactinfo(EmployeeID, ContactNumbber, Email) VALUES (1, 351478025, "maria.c@luckyShrubb.com");

CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL , PhoneNumber 
INT NOT NULL UNIQUE);

CREATE TABLE BOOKINGS(BookingID INT NOT NULL PRIMARY KEY, BookingDate DATE NOT NULL, TableNumber INT NOT NULL,
NumberOfGuests INT NOT NULL CHECK (NumberOfGuests<=8), CustomerID INT NOT NULL, FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE Machinery MODIFY EmploeeID VARCHAR(10) NOT NULL PRIMARY key, MODIFY FullName VARCHAR(100) NOT NULL, MODIFY fULLName 
VARCHAR(100) NOT NULL , MODIFY PhoneNumber INT NOT NULL UNIQUE;

ALTER TABLE MACHINERY ADD CLOUMN Age INT CHECK(Age >=18);

CREATE TABLE ClientTest SELECT * FROM CLIENTS;

CREATE TABLE ClientsTest2 SELECT FullName, ContactNumbber FROM Clients Where Location = "Pinal County";

CREATE TABLE Clientstest3 like Clients;

CREATE TABLE test.DBclientsTest SELECT * FROM Lucky_shurb.Clients;

SELECT * FROM Employees WHERE AnnualSalary > (SELECT AnnualSalary FROM Employees WHERE Role = 'Assistant Chef')

SELECT * FROM Employees WHERE AnnualSalary <= ALL(SELECT AnnualSalary FROM Employees WHERE Role IN('Manager', 'Assistant Manager', 'Head Chef', 
'Head Waiter'));

SELECT * FROM Employees WHERE AnnualSalary >= ANY(SELECT AnnualSalary FROM Employees WHERE Role IN('Manager', 'Assistant Manager', 'Head Chef', 
'Head Waiter'));

SELECT * FROM Employees WHERE EXISTS (SELECT * FROM Booking.EmployeeID = Employees.EmployeeID AND Role IN('Head Chef', 'Head Waiter'));


SELECT * FROM Employees WHERE NOT EXISTS (SELECT * FROM Booking.EmployeeID = Employees.EmployeeID AND Role IN('Head Chef', 'Head Waiter'));

CREATE VIEW TOP3PRODUCTS AS SELECT Products.Item, Orders.Quantity, Orders.Cost FROM Orders INNER JOIN
Produts ON Orders.ProductID = Products.ProductID ORDER by ORDERS.Cost DESC LIMIT 3;

SELECT ClientID, AVG(Cost) FROM client_Orders GROUP BY ClientID;

SELECT ClientID, ROUND(AVG(Cost),2) FROM client_Orders GROUP BY ClientID;

SELECT OrderID,Item,MOD(Quantity,2) FROM mg_orders;

SELECT CONCAT(Name,'-',Quantity) FROM items,mg_orders WHERE items.ItemID = mg_orders.ItemID;

SELECT UCASE(OrderStatus) FROM mg_orders;

SELECT LCASE(OrderStatus) FROM mg_orders;

SELECT SUBSTR(ClientName1,6) FROM Clients WHERE ClientID =1;

SELECT CURRENT_DATE();

SELECT CURRENT_TIME();

SELECT DATE_FORMART(OrderDate, '%M') FROM mg_orders;

SELECT DATEIFF(Delivery, OrderDate) FROM mg_orders WHERE mg_orders WHERE DeliveryDate ISN NOT NULL;

SELECT ItemID, GREATEST(Q1,Q2,Q3,Q4) AS highest, LEAST(Q1,Q2,Q3,Q4) AS lowest from sales_revenue;

SELECT * FROM mg_orders WHERE ISNULL(DeliveryDate);

SELECT ItemID,
CASE
WHEN LEAST(Q1,Q2,Q3,Q4) <= 25000 THEN "Loss"
ELSE "Profit"
END AS Profit_loss
FROM sales_revenue;

CREATE PROCEDURE GetProductDetails() SELECT * FROM Products;

CALL GetProductDetails();

CREATE PROCEDURE GetLowestPriceProducts(LowestPrice INT) SELECT * FROM Products WHERE Price <= LowestPrice;

CALL GetLowestPriceProducts(50);

DROP PROCEDURE  GetLowestPriceProducts;

CREATE PROCEDURE GetLowestCost (OUT LowestCost DECIMAL(6,2))
SELECT MIN(Cost) INTO LowestCost FROM Orders;

CALL GetLowestCost (@order_lowest_cost);

CREATE PROCEDURE SquareAnumber (INOUT aNumber INT)
BEGIN
   set aNumber = aNumber * aNumber;
END

CREATE FUNCTION FindTotalCost(Cost DECIMAL(5,2))
RETURN DECIMAL (5,2) DETERMINISTIC
RETURN (Cost - (Cost * 0.1));

SELECT findTotalCost(100)

DELIMITER //
CREATE FUNCTION GetTotalCost(Cost DECIMAL(5,2)) RETURNS DECIMAL(5,2) DETERMINISTIC BEGIN IF
(Cost >= 100 AND Cost < 500) THEN SET Cost = Cost - (Cost * 0.1); ELSEIF (Cost >= 500) THEN SET Cost = Cost - (Cost * 0.2);
END IF RETURN(Cost); END//

DELIMITER ;
SELECT GetTotalCost(500);
DELIIMTER //

CREATE PROCEDURE GetProductSummary(OUT NumberOfLowPriceProducts INT, OUT NumberofHighPriceProducts INT) 
BEGIN SELECT COUNT(ProductID) INTO NumberOfLowPriceProducts FROM Products WHERE Price <50;
SELECT COUNT(ProductID) INTO NumberofHighPriceProducts FROM Products WHERE Price >= 50; END // 


CREATE TRIGGER OrderQtycheck
BEFORE INSERT
ON orders FOR EACH ROW
BEGIN
    IF NEW.orderQty < 0 THEN
    SET NEW.orderQty = 0;
    END IF;
END;

CREATE TRIGGER LogNewOrderInsert
AFTER INSERT
ON Orders FOR EACH ROW
INSERT INTO Audits VALUES ('After','A new order was inserted', 'INSERT');

 CREATE TRIGGER AfterDeleteOrder
 AFTER DELETE
 ON Orders FOR EACH ROW
 INSERT INTO Audits
 VALUES('AFTER', CONCAT('Oder'OLD.OrderID, 'was deleted at' CURRENT_TIME() 'On') CURRENT_DATE()), 'DELETE');
 
 DELIMITER //
 CREATE TRIGGER OrderQtyCheck BEFORE INSERT ON Orders FOR EACH ROW BEGIN IF NEW.Quantity < 0
 THEN SET NEW.Quantity = 0; END IF; END //
 
 CREATE EVENT GenerateRevenueReport
 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 12 HOUR
 DO 
 BEGIN
    INSERT INTO ReportData (OrderID,ClientID, ProductID, Quantity, Cost, Date)
	SELECT *
	FROM Orders
	WHERE Date
	BETWEEN '2022-08-01' AND '2022-08-31'
END

CREATE EVENT [IF NOT EXISTS] event_name
ON SCHEDULE
EVERY interval STARTS TIMESTAMP [+INTERVAL] ENDS TIMESTAMP [+INTERVAL]
DO
Event_body

CREATE EVENT DailyRestock
ON SCHEDULE 
EVERY 1 DAY
DO 
BEGIN
    IF Products.NumberOfItems < 50 THEN
	UPDATE Products SET NUMBEROfItms = 50;
	END IF;
END

DELIMTER //
CREATE EVENT GenerateRevenueReport ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 12 HOUR DO 
BEGIN INSERT INTO ReportData (OrderID, ClientID, ProductID, Quantity, Cost, Date) SELECT  * FROM
Orders WHERE Date BETWEEN '2022-08-01' AND '2022-08-31'; END//

CREATE EVENT DilyRestock ON SCHEDULE EVERY 1 DAY DO BEGIN IF Products.NUMBEROfItems < 50 THEN UPDATE 
Products SET NUMBEROfItems = 50; END IF; END //

DROP EVENT IF EXISTS DailyRestock;

UPDATE Clients REVERSEFullName = CONCAT(SUBSTR_INDEX(FULLName, '', -1), ' ' SUBSTRING_INDEX(FullName, '',1));

CREATE INDEX index_name ON Table_name (cloumn list)

EXPLAIN SELECT ContactNumber FROM Clients WHERE FullName='Jane Delgado';

CREATE INDEX IdxFullName ON Clients(FullName);

START TRANSACTION;

INSERT INTO Orders(OrderID, ClientID, ProductID, qunaityt, Cost, Date) VALUES(30, 'C11', 'P1', 10 , 500, '2022-09-30');

UPDATE products SET NumberOfItems = (NumberofItems - 10) WHERE ProductId = "P1";

SELECT Orderss.OrderID, Orders.ClientID, Orders.Quantity, Products.ProductID, Products.Number 
of Items FROM Orders INNER JOIN Products ON (Orders.ProductID = Products.ProductID) WHERE Orders.OrderID = 30;

ROLLBACK;

WITH 
Average_sales_2020 AS (SELECT CONCAT(AVG(Cost), "(2020") AS "Average Sale" FROM Orders
WHERE YEAR(DATE) = 2020),
Average_sales_2021 AS (SELECT CONCAT(AVG(Cost), "2021") FROM Orders 
WHERE YEAR(DATE) = 2021),
Average_sales_2022 AS (SELECT CONCAT(AVG(Cost), "2022") FROM Orders 
WHERE YEAR(DATE) = 2022)
SELECT * FROM Average_sales_2020
UNION
SELECT * FROM Average_sales_2021
UNION 
SELECT * FROM Average_sales_2022;

PREPARE GetOrderStatement FROM 'SELECT ClientID, ProductID, Quantity, Cost , From Orders WHERE OrderID= ?';

SET @Order_id = 10;

EXECUTE GetOrderStatement USING @Order_id;

CREATE TABLE Activity(ActivityID INT PRIMARY KEY, Properties JASON);
INSERT INTO TABLE Activity(ActivityID, Properties) VALUES
(1, '{"ClientID":"Cl1","ProductID":"P1", "Order": "True"}'),
(2, '{"ClientID":"Cl2","ProductID":"P4", "Order": "False"}'),
(3, '{"ClientID":"Cl5","ProductID":"P5", "Order": "True"}');

SELECT ActivityID, Properties->'$.ClientID', Properties->'$.ProductID', Properties->'$.Order'FROM Activity;


SELECT ProductID
FROM Orders
WHERE ProductID = ANY(SELECT ProductID FROM Orders WHERE Qunatity > = 100);

SELECT ProductID FROM Products  WHERE ProductID = ANY(SELECT Product FROM Orders WHERE Quantity >=10);

SELECT Orders.ClientID, Orders.Cost , Clients.FullName, Cleints.ContactNumbber FROM Orders INNER
JOIN Clients ON(Orders.ClientID = Clients.ClientID) AND (Date BETWEEN '2020-09-10' AND '2020-09-20')

CREATE VIEW TopProducts AS SELECT ProductName, Orders.Quantity, Orders,Cost FROM Orders 
INNER JOIN Products ON Orders.ProductID ORDER BY Orders.Cost DESC LIMIT 5;


SELECT * FROM TopProducts;

SELECT Columns
FROMtable1
LEFT JOIN table2
on table1.CommonColumn = Table2.CommonColumn
UNION
SELECT COLUMNS
FROM table1
RIGHT JOIN table2
ON Table1.commoncolumn = table2 commmonCloumn.commoncloumn

SELECT Clients.Clients.ID, Clients.FullName, Clients.ContactNumber,
Orders.OrderID, Orders.Cost, Orders.Date
FROM Clients
LEFT JOIN Orders
ON Clients.ClientID = Orders.ClientID
UNION
SELECT Clients.Clients.ID, Clients.FullName, Clients.ContactNumber,
Orders.OrderID, Orders.Cost, Orders.Date
FROM Clients
RIGHT JOIN Orders
ON CLients.ClientID = Orders.ClientID
SELECT Clients.ClientID, Clients.FullName, Clients.ContactNumber, Orders.ID, Orders.Cost,Orders.Date FROM Clients
LEFT JOIN Orders ON Clients.ClientID = Orders.ClientID UNION SELECT CLIENTS.ClientID, CLients.FullName, Clients.ContactNumber
Order.OrderID, Orders.Cost, Orders.Date FROM Clients RIGHT JOIN Orders ON ClientID = Orders.ClientID

SELECT Clients.clientID, Clients.ContactNumber,
Orders.OrderID, Orders.Quantity, Orders.Date,
Products.NumberofItems AS'Items in stock'
FROM Clients INNER JOIN Orders INNER JOIN Products
ON(Clients.ClientID = Orders.ClientID AND Orders.ProductID = Products.ProductID)
WHERE(Orders.Qunatity >= 10 AND Date > '2020-09-05' AND Products.NumberofItems >= 50);

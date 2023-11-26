/* (Database Fundamentals, Assignment Part D, Autumn  2020 */
/* First author's name: Zhitan Wu, Clayton Cheung, Jacob Braithwaite*/
/* First author's email: zhitan.wu@student.uts.edu.au, clayton.cheung@student.uts.edu.au, jacob.braithwaire@student.uts.edu.au*/
/* script name: dbenvironment.sql */
/* purpose:     Builds PostgreSQL tables for Factor75 */
/* date:        25th October, 2023 */
/* The URL for the website related to this database is https://www.factor75.com/ */

--=================================================================================================
-- Drop the tables below

-- Write your scripts here
CREATE TABLE CustomerMenu_t ( -- One of the disjoint entities\
    CustomerMenuID INT PRIMARY KEY NOT NULL,
    Ingredients VARCHAR (30),
    Tags VARCHAR (10)
);  

INSERT INTO CustomerMenu_t (CustomerMenuID, Ingredients, Tags)
VALUES
    (1, 'Bread', 'Breakfast'),
    (2, 'Coffee', 'Breakfast'),
    (3, 'Tea', 'Breakfast'),
    (4, 'Sandwich', 'Lunch'),
    (5, 'Burger', 'Dinner'),
    (6, 'Pizza', 'Dinner');

CREATE TABLE Customer_t (
    CustomerID INT PRIMARY KEY NOT NULL,
    CustomerMenuID INT, 
    CustomerFName Varchar(20),
    CustomerLName Varchar(50),
    phone Varchar(12),
    AddressNumb INT,
    Street Varchar(100),
    postcode Varchar(4),
    MealsPerWeek INT,
    FOREIGN KEY (CustomerMenuID) References CustomerMenu_t(CustomerMenuID)
);

INSERT INTO Customer_t (CustomerID, CustomerFName, CustomerLName, phone, AddressNumb, Street, postcode, MealsPerWeek)
VALUES
    (1, 'John', 'Smith', '0400000000', 1 , 'Street St', '2100', 2),
    (2, 'Bob', 'Smith', '0400000001', 2, 'Streety St', '2110', 2),
    (3, 'Name', 'LName', '0400000005', 3, 'Street St', '2000', 3),
    (4, 'Bob', 'Johnson', '0400000002', 1, 'Avenue Ave', '2020', 2),
    (5, 'Eve', 'Johnston', '0400000003', 2, 'Avenue Blvd', '2100', 5);

CREATE TABLE DietaryCategory_t (
    DietaryCategoryID INT PRIMARY KEY NOT NULL,
    DietCatName VARCHAR (20)
);

INSERT INTO DietaryCategory_t (DietaryCategoryID, DietCatName)
VALUES
    (1, 'Vegan'),
    (2, 'Vegetarian'),
    (3, 'Low_Calorie'),
    (4, 'High_Calorie'),
    (5, 'Keto');

CREATE TABLE CustomerDietaryPreference_t ( -- Associative
    CustomerID INT NOT NULL, 
    DietaryCategoryID INT NOT NULL,
    Allergies Varchar(200),
    CONSTRAINT CustomerDietaryPreference_PK PRIMARY KEY (CustomerID, DietaryCategoryID),
    FOREIGN KEY (CustomerID) References Customer_t(CustomerID),
    FOREIGN KEY (DietaryCategoryID) References DietaryCategory_t(DietaryCategoryID)
); 

INSERT INTO CustomerDietaryPreference_t (CustomerID, DietaryCategoryID, Allergies)
VALUES
    (1, 3, 'Dairy'),
    (3, 3, 'None'),
    (5, 5, 'Nuts, Dairy'),
    (4, 2, 'Soy'),
    (2, 1, 'Gluten');

CREATE TABLE Order_t (
    OrderID INT PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,
    OrderedMeals Varchar(20),
    OrderedDate Varchar(20),
    DeliveryDate Varchar(20),
    PaymentStatus Varchar (10),
    Reoccuring Varchar (1),
    FOREIGN KEY (CustomerID) References Customer_t(CustomerID)
);
    -- (1, 'John', 'Smith', '0400000000', 1, 'Street St', '2100', 2),
    -- (2, 'Bob', 'Smith', '0400000001', 2, 'Streety St', '2110', 1),
    -- (3, 'Name', 'LName', '0400000005', 1, 'Street St', '2000', 3),
    -- (4, 'Bob', 'Johnson', '0400000002', 3, 'Avenue Ave', '2020', 1),
    -- (5, 'Eve', 'Johnston', '0400000003', 4, 'Avenue Blvd', '2100', 5);

INSERT INTO Order_t (OrderID, CustomerID, OrderedMeals, OrderedDate, DeliveryDate, PaymentStatus, Reoccuring)
VALUES
    (1, 1, 'Coffee', '01012023', '05012023', 1, 1),
    (2, 2, 'Tea', '01012023', '05012023', 0, 0),
    (3, 3, 'Burger', '01012023', '05012023', 0, 1),
    (4, 4, 'Burger, Pizza', '01012023', '05012023', 1, 0),
    (5, 5, 'Coffee', '01012023', '05012023', 1, 1);

CREATE TABLE Menu_t ( -- One of the disjoint entities
    MenuID INT PRIMARY KEY NOT NULL,
    MenuName VARCHAR (20),
    Description VARCHAR (50)
);

INSERT INTO Menu_t (MenuID, MenuName, Description)
VALUES
    (1, 'Breakfast', 'Breakfast Menu'),
    (2, 'Lunch', 'Lunch Menu'),
    (3, 'Dinner', 'Dinner Menu'),
    (4, 'Snacks', 'Snacks Menu'),
    (5, 'Dessert', 'Dessert Menu');


CREATE TABLE Meal_t (
    MealID INT PRIMARY KEY NOT NULL,
    MenuID INT NOT NULL,
    MealName VARCHAR (20),
    FOREIGN KEY (MenuID) References Menu_t(MenuID)
);

INSERT INTO Meal_t (MealID, MenuID, MealName)
VALUES
    (1, 1, 'Bread'),
    (2, 1, 'Coffee'),
    (3, 1, 'Tea'),
    (4, 2, 'Sandwich'),
    (5, 3, 'Burger'),
    (6, 3, 'Pizza');

CREATE TABLE Review_t (
    ReviewID INT PRIMARY KEY NOT NULL,
    MealID INT NOT NULL, 
    CustomerID INT,
    DateSubmitted VARCHAR (15),
    Rating INT,
    Comments Varchar(300),
    FOREIGN KEY (MealID) References Meal_t(MealID),
    FOREIGN KEY (CustomerID) References Customer_t(CustomerID)
);

INSERT INTO Review_t (ReviewID, MealID, CustomerID, DateSubmitted, Rating, Comments)
VALUES
    (1, 1, 1, '06012023', 5, 'Good bread'),
    (2, 2, 3, '06012023', 5, 'Excellent coffee'),
    (3, 3, 2, '06012023', 5, 'Rubbish'),
    (4, 4, 4, '06012023', 5, 'Nice sandwich'),
    (5, 5, 5, '06012023', 5, 'Decent');

CREATE TABLE DietaryMenu_t ( -- One of the disjoint entities
    DietaryMenuID INT PRIMARY KEY NOT NULL,
    DietaryCategoryID INT NOT NULL, 
    DietaryMenuType VARCHAR (20),
    FOREIGN KEY (DietaryCategoryID) References DietaryCategory_t(DietaryCategoryID)
);

INSERT INTO DietaryMenu_t (DietaryMenuID, DietaryCategoryID, DietaryMenuType)
VALUES
    (1, 1, 'Vegan Menu'),
    (2, 2, 'Vegetarian Menu'),
    (3, 3, 'Low_Calorie Menu'),
    (4, 4, 'High_Calorie Menu'),
    (5, 5, 'Keto Menu');
    
CREATE TABLE BusinessMenu_t ( -- One of the disjoint entities
    BusinessMenuID INT PRIMARY KEY NOT NULL,
    MealStockLevel VARCHAR (50)
);

    INSERT INTO BusinessMenu_t (BusinessMenuID, MealStockLevel)
    VALUES
    (1, 'High'),
    (2, 'High'),
    (3, 'High'),
    (4, 'Medium'),
    (5, 'High');   

CREATE TABLE Employee_t ( -- One of the disjoint entities
    EmployeeID INT PRIMARY KEY,
    EmployeeFName VARCHAR (15),
    EmployeeLName VARCHAR (15),
    EmployeeRole VARCHAR (10),
    Email VARCHAR (25), 
    Phone VARCHAR (15)
); 

    INSERT INTO Employee_t (EmployeeID, EmployeeFName, EmployeeLName, EmployeeRole, Email, Phone)
    VALUES
        (1, 'Bob', 'Bobby', 'Waiter', 'bob@restraunt.com', '041101010101'),
        (2, 'Richard', 'Smith', 'Waiter', 'richard@restraunt.com', '041101010102'),
        (3, 'Alice', 'A', 'Owner', 'alice@restraunt.com', '041101010103'),
        (4, 'John', 'B', 'chef', 'chef@restraunt.com', '041101010104'),
        (5, 'Mary', 'C', 'chef', 'maryc@restraunt.com', '041101010105');

CREATE TABLE Supplier_t (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR (40)
);

INSERT INTO Supplier_t (SupplierID, SupplierName)
VALUES
    (1, 'Bread supplies'),
    (2, 'Coffee Beans Supplies'),
    (3, 'Supplier Pty ltd'),
    (4, 'Supplier a LTD'),
    (5, 'Supplier of food');


CREATE TABLE Ingredient_t (
    IngredientID INT PRIMARY KEY,
    SupplierID INT, 
    IngredientName VARCHAR (20),
    StockLevel VARCHAR (20),
    FOREIGN KEY (SupplierID) References Supplier_t(SupplierID)
);

INSERT INTO Ingredient_t (IngredientID, SupplierID, IngredientName, StockLevel)
VALUES
    (1, 1, 'Egg', 'High'),
    (2, 2, 'Coffee Beans', 'High'),
    (3, 3, 'Meat', 'Low'),
    (4, 4, 'bread', 'Medium'),
    (5, 5, 'salt', 'Medium');

CREATE TABLE MealIngredient_t ( -- Associative entity
    IngredientID INT NOT NULL, 
    MealID INT NOT NULL,
    IngredientAmount VARCHAR (50), 
    CONSTRAINT MealIngredient_PK PRIMARY KEY (IngredientID, MealID),
    FOREIGN KEY (IngredientID) References Ingredient_t(IngredientID),
    FOREIGN KEY (MealID) References Meal_t(MealID)
); 

INSERT INTO MealIngredient_t (IngredientID, MealID, IngredientAmount)
VALUES
    (1, 6, '20g'),
    (2, 6, '100g'),
    (3, 5, '1000g'),
    (4, 5, '10g'),
    (5, 6, '10g');

CREATE TABLE Chef_t ( -- One of the disjoint entities
    ChefID INT PRIMARY KEY 
); 

INSERT INTO Chef_t (ChefID)
VALUES
    (1),
    (2),
    (3),
    (4),
    (5);

CREATE TABLE Kitchen_t (
    KitchenID INT PRIMARY KEY
);

INSERT INTO Kitchen_t (KitchenID)
VALUES
    (1),
    (2),
    (3),
    (4),
    (5);

CREATE TABLE ChefKitchen_t ( -- Associative entity
    StartDate VARCHAR (10),
    ChefID INT, 
    KitchenID INT,
    Shift VARCHAR (15),
    EndDate VARCHAR (10),
    CONSTRAINT ChefKitchen_PK PRIMARY KEY (StartDate, ChefID, KitchenID),
    FOREIGN KEY (ChefID) References Chef_t(ChefID),
    FOREIGN KEY (KitchenID) References Kitchen_t(KitchenID)
);

INSERT INTO ChefKitchen_t (StartDate, ChefID, KitchenID, Shift, EndDate)
VALUES
    ('01012023', 1, 1, 'Morning', '10012023'),
    ('01012023', 2, 2, 'Morning', '10012023'),
    ('01012023', 3, 3, 'Night', '10012023'),
    ('01012023', 4, 4, 'Night', '10012023'),
    ('01012023', 5, 5, 'Night', '10012023');


--=================================================================================================
-- Create and insert into the tables below


--=================================================================================================
-- Select * from TableName Statements
-- Note: Please write the “select * from TableName” statements in one line.

-- 2.b.1: Question: 
-- 2.b.1: SELECT statement: 
    SELECT * FROM ChefKitchen_t;

-- 2.b.2: Question: 
-- 2.b.2: SELECT statement:
    SELECT * FROM Customer_t where MealsPerWeek > 1;

-- 2.b.3: Question: 
-- 2.b.3: SELECT statement:
    SELECT CustomerFName, CustomerLName From Customer_t where MealsPerWeek > 1;

--=================================================================================================
-- 3.a: Question: 
-- 3.a: SELECT statement uinsg Group by:

    SELECT CustomerID
    FROM Order_t
    GROUP BY CustomerID;

-- 3.b: Question: 
-- 3.b: SELECT statement uisng Inner Join:
    -- 3.b: Retrieve customer information along with their associated dietary preferences

    SELECT C.CustomerID, C.CustomerFName, C.CustomerLName, DC.DietCatName
    FROM Customer_t C
    INNER JOIN CustomerDietaryPreference_t CDP ON C.CustomerID = CDP.CustomerID
    INNER JOIN DietaryCategory_t DC ON CDP.DietaryCategoryID = DC.DietaryCategoryID;

-- 3.c: Question: 
-- 3.c: SELECT statement using Sub Query:

    SELECT M.MenuName, M.MenuID, M.Description
    FROM Menu_t M
    WHERE M.MenuID = ANY(
        SELECT MealID
        FROM Review_t
        WHERE Rating = (SELECT MAX(Rating) FROM Review_t)
    );



SELECT * FROM CustomerMenu_t;
-- Customer_t``
SELECT * FROM DietaryCategory_t;
SELECT * FROM CustomerDietaryPreference_t;
SELECT * FROM Order_t;
SELECT * FROM Menu_t;
SELECT * FROM Meal_t;
SELECT * FROM Review_t;
SELECT * FROM DietaryMenu_t;
SELECT * FROM BusinessMenu_t;
SELECT * FROM Employee_t;
SELECT * FROM Supplier_t;
SELECT * FROM Ingredient_t;
SELECT * FROM MealIngredient_t;
SELECT * FROM Chef_t;
SELECT * FROM Kitchen_t;
-- ChefKitchen_t ``

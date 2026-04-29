CREATE DATABASE gravity_books_DWH;
GO

USE gravity_books_DWH;
GO

-- 1. Dim_Author
CREATE TABLE Dim_Author (
    Author_SK    INT PRIMARY KEY IDENTITY(1,1),
    Author_BK    INT,
    Author_Name  VARCHAR(200)
);

-- 2. Dim_Book
CREATE TABLE Dim_Book (
    Book_SK          INT PRIMARY KEY IDENTITY(1,1),
    Book_BK          INT,
    ISBN13           VARCHAR(50),
    Title            VARCHAR(500),
    Num_Pages        INT,
    Publication_Date DATE,
    
    -- Language --
    Language_BK      INT,          
    Language_Code    VARCHAR(10),
    Language_Name    VARCHAR(100),
    
    -- Publisher --
    Publisher_BK     INT,          
    Publisher_Name   VARCHAR(200),
    
    
    -- SCD Type 2 --
    Start_Date       DATE,
    End_Date         DATE,
    Is_Current       BIT
);

-- 3. Bridge_Book_Author
CREATE TABLE Bridge_Book_Author (
    Book_SK    INT FOREIGN KEY REFERENCES Dim_Book(Book_SK),
    Author_SK  INT FOREIGN KEY REFERENCES Dim_Author(Author_SK)
);

-- 4. Dim_Customer
CREATE TABLE Dim_Customer (
    Customer_SK  INT PRIMARY KEY IDENTITY(1,1),
    Customer_BK  INT,
    First_Name   VARCHAR(100),
    Last_Name    VARCHAR(100),
    Email        VARCHAR(200),
    -- SCD Type 2
    Start_Date   DATE,
    End_Date     DATE,
    Is_Current   BIT
);

-- 5. Dim_Address
CREATE TABLE Dim_Address (
    Address_SK     INT PRIMARY KEY IDENTITY(1,1),
    Address_BK     INT,
    Street_Number  VARCHAR(50),
    Street_Name    VARCHAR(200),
    City           VARCHAR(100),
    Country_BK     INT,
    Country_Name   VARCHAR(100),
    Status_Name    VARCHAR(50),
    -- SCD Type 2
    Start_Date     DATE,
    End_Date       DATE,
    Is_Current     BIT
);

-- 6. Dim_Shipping_Method
CREATE TABLE Dim_Shipping_Method (
    Shipping_Method_SK  INT PRIMARY KEY IDENTITY(1,1),
    Shipping_Method_BK  INT,
    Method_Name         VARCHAR(100),
    Cost                DECIMAL(10,2)
);

-- 7. Dim_Order_Status
CREATE TABLE Dim_Order_Status (
    Order_Status_SK  INT PRIMARY KEY IDENTITY(1,1),
    Status_BK        INT,
    Status_Value     VARCHAR(100)
);

-- 8. Dim_Date
CREATE TABLE Dim_Date (
    Date_SK       INT PRIMARY KEY IDENTITY(1,1),
    Full_Date     DATE,
    Day_Of_Month  INT,
    Day_Name      VARCHAR(20),
    Month_Num     INT,
    Month_Name    VARCHAR(20),
    Quarter_Num   INT,
    Year_Num      INT,
    Is_Weekend    BIT
);


------------------------
USE gravity_books_DWH;


ALTER TABLE Dim_Book ALTER COLUMN Title VARCHAR(400);
ALTER TABLE Dim_Book ALTER COLUMN ISBN13 VARCHAR(13);


ALTER TABLE Dim_Book ALTER COLUMN Language_Code VARCHAR(8);
ALTER TABLE Dim_Book ALTER COLUMN Language_Name VARCHAR(50);


ALTER TABLE Dim_Book ALTER COLUMN Publisher_Name NVARCHAR(1000);


------------------------
ALTER TABLE gravity_books_DWH.dbo.Dim_Address
ADD Status_BK INT;

----------------------------
ALTER TABLE gravity_books_DWH.dbo.Dim_Address
ALTER COLUMN Start_Date DATETIME;

ALTER TABLE gravity_books_DWH.dbo.Dim_Address
ALTER COLUMN End_Date DATETIME;

---------------------------------
ALTER TABLE Dim_Customer
ALTER COLUMN Start_Date DATETIME;

ALTER TABLE Dim_Customer
ALTER COLUMN End_Date DATETIME;

------------------------------------------
ALTER TABLE gravity_books_DWH.dbo.Fact_Sales
DROP COLUMN Quantity;
----------------------------------------------
USE gravity_books_DWH;

ALTER TABLE Dim_Date
ALTER COLUMN Full_Date DATETIME;

use amazon_ecommerce;

CREATE TABLE orders (
	OrderDate DATE,
    OrderID INT,
    DeliveryDate DATE,
    CustomerID INT,
    Location VARCHAR(50),
    Zone VARCHAR(25),
    DeliveryType VARCHAR(20),
    ProductCategory VARCHAR(100),
    SubCategory VARCHAR(100),
    Product VARCHAR(200),
    UnitPrice DECIMAL(10,2),
    ShippingFee DECIMAL(10,2),
    OrderQuantity INT,
    SalePrice DECIMAL(10,2),
    Status VARCHAR(20),
    Rating INT,
    Reason VARCHAR(100),
    Customer_age INT,
    Delivery_days INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from orders limit 10;

CREATE TABLE customer (
    CustomerID INT PRIMARY KEY,
    CustomerAge INT,
    CustomerGender VARCHAR(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from customer limit 10;
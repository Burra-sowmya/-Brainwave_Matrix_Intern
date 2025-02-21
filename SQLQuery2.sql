--Create a database for online store
CREATE DATABASE Online_Store;

--Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1) ,
    CategoryName VARCHAR(100) UNIQUE,
    Description TEXT,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1) ,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    Stock INT,
    CategoryID INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATETIME DEFAULT GETDATE(),  -- Added comma here
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    Status VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--Create Shipping Table
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ShippingAddress VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    ShippingDate DATETIME, 
    DeliveryDate DATETIME, 
    Status VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create Reviews Table
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    CustomerID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    ReviewText TEXT,
    ReviewDate  DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Insert Customers Values
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode)
VALUES 
('Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '789 Pine St', 'Springfield', 'IL', '62703'),
('Bob', 'Williams', 'bob.williams@example.com', '555-987-6543', '321 Maple St', 'Springfield', 'IL', '62704'),
('Charlie', 'Brown', 'charlie.brown@example.com', '555-456-7890', '654 Cedar St', 'Springfield', 'IL', '62705'),
('Diana', 'Prince', 'diana.prince@example.com', '555-321-0987', '987 Birch St', 'Springfield', 'IL', '62706'),
('Ethan', 'Hunt', 'ethan.hunt@example.com', '555-654-3210', '159 Spruce St', 'Springfield', 'IL', '62707');
SELECT * FROM Customers;

--Insert Categories Values
INSERT INTO Categories (CategoryName, Description)
VALUES 
('Clothing', 'Apparel for men, women, and children, including shirts, pants, and accessories.'),
('Home & Kitchen', 'Products for home improvement, kitchenware, and decor.'),
('Sports & Outdoors', 'Equipment and apparel for various sports and outdoor activities.'),
('Health & Beauty', 'Personal care products, cosmetics, and health supplements.'),
('Toys & Games', 'Fun and educational toys for children of all ages.');
SELECT * FROM Categories;

-- 3. Insert Products Values
INSERT INTO Products (ProductName, Description, Price, Stock, CategoryID)
VALUES 
('T-Shirt', '100% cotton t-shirt available in various colors.', 15.99, 150, 1),  
('Blender', 'High-speed blender for smoothies and soups.', 49.99, 75, 2),  
('Basketball', 'Official size basketball for indoor and outdoor play.', 29.99, 200, 3), 
('Moisturizer', 'Hydrating moisturizer for all skin types.', 24.99, 100, 4),  
('Board Game', 'Fun strategy board game for family and friends.', 34.99, 80, 5);  
SELECT * FROM Products;

--Insert Orders Values
INSERT INTO Orders (CustomerID, TotalAmount, Status)
VALUES 
(1, 1019.98, 'Pending'),   
(2, 19.99, 'Completed'),    
(1, 299.99, 'Shipped'),     
(3, 49.99, 'Pending'),      
(4, 89.99, 'Completed');    
SELECT * FROM Orders;

--Insert Order Items Values
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price)
VALUES 
(1, 22, 1, 999.99),  
(1, 24, 1, 19.99),   
(2, 20, 1, 699.99),  
(3, 23, 1, 299.99),  
(4, 21, 1, 49.99),   
(5, 24, 1, 34.99);   
SELECT * FROM OrderItems;

--Insert Payments Values
INSERT INTO Payments (OrderID, Amount, PaymentMethod, Status)
VALUES 
(1, 1019.98, 'Credit Card', 'Completed'),  
(2, 19.99, 'PayPal', 'Completed'),          
(3, 299.99, 'Credit Card', 'Completed'),     
(4, 49.99, 'Debit Card', 'Pending'),         
(5, 89.99, 'Credit Card', 'Completed');       
SELECT * FROM Payments;

---Insert Shipping Records 
INSERT INTO Shipping (OrderID, ShippingAddress, City, State, ZipCode, Country, ShippingDate, DeliveryDate, Status)
VALUES 
(1, '123 Elm St', 'Chicago', 'IL', '60601', 'USA', GETDATE(), DATEADD(DAY, 5, GETDATE()), 'Shipped'), 
(2, '456 Oak St', 'Los Angeles', 'CA', '90001', 'USA', GETDATE(), DATEADD(DAY, 7, GETDATE()), 'In Transit'),   
(3, '789 Pine St', 'New York', 'NY', '10001', 'USA', GETDATE(), DATEADD(DAY, 3, GETDATE()), 'Pending'),    
(4, '321 Maple St', 'Houston', 'TX', '77001', 'USA', GETDATE(), DATEADD(DAY, 4, GETDATE()), 'Delivered'),     
(5, '654 Cedar St', 'Miami', 'FL', '33101', 'USA', GETDATE(), DATEADD(DAY, 6, GETDATE()), 'Cancelled'); 
SELECT * FROM Shipping;

--Insert Reviews Values
INSERT INTO Reviews (ProductID, CustomerID, Rating, ReviewText)
VALUES 
(23, 1, 5, 'A thrilling read! Couldn’t put it down.'),  
(22, 3, 4, 'The blender works well, but it’s a bit noisy.'), 
(24, 3, 5, 'Perfect for family game nights! Highly entertaining.'),  
(20, 2, 3, 'Good laptop, but it gets hot during heavy use.'), 
(24, 3, 4, 'Smartphone has great features, but it’s a bit pricey.');  
SELECT * FROM Reviews;

-- Retrieve All Products with Their Categories
SELECT p.ProductID, p.ProductName, p.Price, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;

--Get All Orders for a Specific Customer
SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.Status
FROM Orders o
WHERE o.CustomerID = 2;  

--Update Stock for a Product
UPDATE Products
SET Stock = Stock - 1 
WHERE ProductID = 23;   
select * from Products;
--Get Total Sales Amount for Each Product
SELECT p.ProductName, SUM(oi.Quantity * oi.Price) AS TotalSales
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY p.ProductName;
--Retrieve All Reviews for a Specific Product
SELECT r.ReviewID, r.Rating, r.ReviewText, c.FirstName, c.LastName
FROM Reviews r
JOIN Customers c ON r.CustomerID = c.CustomerID
WHERE r.ProductID = 21; 

--Get All Pending Orders

SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.Status = 'Pending';

-- Delete a Customer (and their related orders, if necessary)
DELETE FROM Customers
WHERE CustomerID = 5; 
select * from Customers;

-- Update Payment Status for an Order
UPDATE Payments
SET Status = 'Pending'
WHERE OrderID = 4;  
select * from Payments;

--Get the Most Recent Review for Each Product
SELECT r.ProductID, r.ReviewText, r.Rating, r.ReviewDate
FROM Reviews r
WHERE r.ReviewDate = (
    SELECT MAX(ReviewDate)
    FROM Reviews
    WHERE ProductID = r.ProductID
);

--Count the Number of Products in Each Category
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

--Get Total Revenue from All Completed Orders
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE Status = 'Completed';

--Get Shipping Information for a Specific Order
SELECT s.ShippingID, s.ShippingAddress, s.City, s.State, s.ZipCode, s.Status
FROM Shipping s
WHERE s.OrderID = 1; 
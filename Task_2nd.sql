									-- TASK (2) --
-- -------------------------------------------------------------------------------------------
-- (A) CREATING TABLES

-- Creating Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Creating Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Creating Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Creating OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Creating Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- -------------------------------------------------------------------------------------------
-- (B) INSERTING DATA

-- Inserting sample data into Products
INSERT INTO Products (product_name, price, stock_quantity) VALUES
('Laptop', 1000.00, 50),
('Smartphone', 600.00, 100),
('Tablet', 300.00, 200);

-- Inserting sample data into Customers
INSERT INTO Customers (first_name, last_name, email, address) VALUES
('John', 'Doe', 'john.doe@example.com', '123 Main St'),
('Jane', 'Smith', 'jane.smith@example.com', '456 Oak St');

-- Inserting a sample order
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-07-15');

-- Inserting order details
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1000.00),
(1, 2, 2, 1200.00);

-- Inserting a payment
INSERT INTO Payments (order_id, payment_date, amount, payment_method) VALUES
(1, '2024-07-15', 2200.00, 'Credit Card');

-- -------------------------------------------------------------------------------------------
-- (C) QUERIES TO HANDLE CUSTOMER ORDERS
-- 1.  VIEW ALL ORDERS BY A CUSTOMER

SELECT O.order_id, O.order_date, OD.product_id, P.product_name, OD.quantity, OD.price
FROM Orders O
JOIN OrderDetails OD ON O.order_id = OD.order_id
JOIN Products P ON OD.product_id = P.product_id
WHERE O.customer_id = 1;

-- 2. CHECK STOCK FOR A PRODUCT 

SELECT product_name, stock_quantity
FROM Products
WHERE product_id = 1;

-- 3. UPDATE STOCK AFTER AN ORDER

UPDATE Products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

-- 4. VIEW ALL PAYMENTS FOR AN ORDER 

SELECT P.payment_id, P.payment_date, P.amount, P.payment_method
FROM Payments P
WHERE P.order_id = 1;

-- 5. INSERT A NEW ORDER

-- Insert into Orders table
INSERT INTO Orders (customer_id, order_date) VALUES (2, '2024-07-15');

-- Assuming new order_id is 2, insert into OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES (2, 3, 1, 300.00);

-- Update stock quantity
UPDATE Products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 3;

-- Insert into Payments table
INSERT INTO Payments (order_id, payment_date, amount, payment_method) VALUES (2, '2024-07-15', 300.00, 'PayPal');

-- -------------------------------------------FINISH------------------------------------------------


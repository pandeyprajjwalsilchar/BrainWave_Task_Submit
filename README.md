Task (1): An Overview 
We designed a database for a library system with tables for authors, books, members, transactions, staff, and processes. 
Each table has primary keys, and foreign keys establish relationships between them. 
Sample data includes authors like J.K. Rowling and George Orwell, books such as "Harry Potter and the Philosopher's Stone" and "1984," a member named John Doe, and a staff member named Alice Johnson. Transactions and processes track book borrowings and the staff involved in these processes. 
This setup facilitates efficient library management and tracking of book loans.

Here are some additional conceptual and important points to consider:

Indexes: Add indexes on frequently queried columns, such as Name in Authors, Title in Books, and Email in Members, to enhance query performance.
Constraints: Ensure data integrity by using constraints like NOT NULL, UNIQUE, and CHECK where appropriate. For example, ensure Email in Members is unique.
Normalization: The database schema follows normalization principles, reducing data redundancy and ensuring data integrity.
Transactions and Atomicity: Ensure that operations involving multiple steps, like borrowing a book, are handled within transactions to maintain atomicity.
Stored Procedures: Implement stored procedures for common operations such as borrowing a book, returning a book, or registering a new member to encapsulate business logic and improve performance.
Views: Create views for common queries, such as active borrowings or overdue books, to simplify data access and improve security by restricting direct access to the underlying tables.
Triggers: Implement triggers for automatic actions, such as updating the membership status based on due dates or return dates.
Security: Define user roles and privileges to ensure that only authorized users can perform certain actions, like adding new books or managing transactions.

1. Adding Indexes -
  CREATE INDEX idx_author_name ON Authors(Name);
  CREATE INDEX idx_book_title ON Books(Title);
  CREATE INDEX idx_member_email ON Members(Email);

2. Creating a Stored Procedure to Borrow a Book -
DELIMITER //

CREATE PROCEDURE BorrowBook (
    IN p_BookID INT,
    IN p_MemberID INT,
    IN p_BorrowDate DATE,
    IN p_DueDate DATE
)
BEGIN
    DECLARE v_TransactionID INT;

    -- Insert into Transactions
    INSERT INTO Transactions (BookID, MemberID, BorrowDate, DueDate)
    VALUES (p_BookID, p_MemberID, p_BorrowDate, p_DueDate);

    -- Get the last inserted TransactionID
    SET v_TransactionID = LAST_INSERT_ID();

    -- Assuming StaffID is 1 (librarian handling the process)
    INSERT INTO Processes (TransactionID, StaffID, ProcessDate)
    VALUES (v_TransactionID, 1, p_BorrowDate);
END //

DELIMITER ;

-- -------------------------------END TASK (1)--------------------------------------------


Task (2): An Overview 
We designed a database for an online store, including tables for products, customers, orders, order details, and payments. 
The schema includes primary and foreign keys to maintain relationships between the tables. 
We provided SQL queries to create the tables, insert sample data, and handle operations such as viewing orders by a customer, checking product stock, updating stock after an order, viewing payments, and inserting new orders. 
This setup ensures efficient management of customer orders and inventory.

Here are a few additional points to consider:

Indexes: Add indexes on foreign keys and frequently queried columns to improve performance.
Constraints: Ensure data integrity by using constraints like NOT NULL, UNIQUE, and CHECK.
Transactions: Use transactions to ensure that complex operations, like placing an order, either complete fully or roll back in case of an error.
Triggers: Implement triggers to automatically update stock quantities or other related actions.
Views: Create views for common queries to simplify data access for reporting and analysis.
Stored Procedures: Use stored procedures for complex operations to improve performance and maintainability.

1. Adding Indexes -

CREATE INDEX idx_customer_id ON Orders(customer_id);
CREATE INDEX idx_order_id ON OrderDetails(order_id);

2. Creating a Trigger to Update Stock -

CREATE TRIGGER update_stock_after_order
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
   UPDATE Products
   SET stock_quantity = stock_quantity - NEW.quantity
   WHERE product_id = NEW.product_id;
END;

-- -------------------------------END TASK (2)--------------------------------------------

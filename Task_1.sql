CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    Publisher VARCHAR(255),
    PublicationYear INT,
    Genre VARCHAR(100),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255),
    MembershipStatus VARCHAR(50)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    DueDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(50)
);

CREATE TABLE Processes (
    ProcessID INT PRIMARY KEY AUTO_INCREMENT,
    TransactionID INT,
    StaffID INT,
    ProcessDate DATE,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

INSERT INTO Authors (Name) VALUES ('J.K. Rowling');
INSERT INTO Authors (Name) VALUES ('George Orwell');

INSERT INTO Books (Title, AuthorID, Publisher, PublicationYear, Genre) 
VALUES ('Harry Potter and the Philosopher''s Stone', 1, 'Bloomsbury', 1997, 'Fantasy');
INSERT INTO Books (Title, AuthorID, Publisher, PublicationYear, Genre) 
VALUES ('1984', 2, 'Secker & Warburg', 1949, 'Dystopian');

INSERT INTO Members (Name, Address, Phone, Email, MembershipStatus) 
VALUES ('John Doe', '123 Main St', '555-1234', 'john@example.com', 'Active');

INSERT INTO Staff (Name, Role) VALUES ('Alice Johnson', 'Librarian');

INSERT INTO Transactions (BookID, MemberID, BorrowDate, DueDate) 
VALUES (1, 1, '2024-06-01', '2024-06-15');

INSERT INTO Processes (TransactionID, StaffID, ProcessDate) 
VALUES (1, 1, '2024-06-01');

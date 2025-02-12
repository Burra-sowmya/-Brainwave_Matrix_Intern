--Create DataBase
CREATE DATABASE library_management;
-- Create Authors Table
CREATE TABLE Authors (
    author_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    bio TEXT
);

-- Create Books Table
CREATE TABLE Books (
    book_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    author_id INT,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year INT,
    genre VARCHAR(100),
    availability_status VARCHAR(20) DEFAULT 'Available' CHECK (availability_status IN ('Available', 'Checked Out', 'Reserved')),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create Members Table
CREATE TABLE Members (
    member_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255),
    membership_date DATE DEFAULT GETDATE()
);

-- Create Loans Table
CREATE TABLE Loans (
    loan_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    book_id INT,
    member_id INT,
    loan_date DATE DEFAULT  GETDATE(),
    due_date DATE, -- New field to track due date
    return_date DATE,
    status VARCHAR(10) DEFAULT 'Active' CHECK (status IN ('Active', 'Returned', 'Overdue')), -- New field to track loan status
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Create Reservations Table
CREATE TABLE Reservations (
    reservation_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    book_id INT,
    member_id INT,
    reservation_date DATE DEFAULT  GETDATE(),
    expiration_date DATE,
    status VARCHAR(10) DEFAULT 'Active' CHECK (status IN ('Active', 'Returned', 'Overdue')),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

--Insert sample Authors records
INSERT INTO Authors (name, bio) VALUES
('Alice Smith', 'Alice is a renowned author known for her thrilling novels.'),
('Bob Johnson', 'Bob writes about technology and its impact on society.'),
('Catherine Lee', 'Catherine is a poet who explores themes of love and loss.'),
('David Brown', 'David is a historian who specializes in ancient civilizations.'),
('Eva White', 'Eva is a children’s book author with a passion for storytelling.'),
('Frank Green', 'Frank writes science fiction and enjoys world-building.'),
('Grace Taylor', 'Grace is a motivational speaker and author of self-help books.'),
('Henry Wilson', 'Henry is a travel writer who shares his adventures around the globe.'),
('Isabella Martinez', 'Isabella writes romance novels that captivate her readers.'),
('Jack Thompson', 'Jack is a journalist who covers current events and politics.'),
('Katherine Davis', 'Katherine is a fantasy author with a vivid imagination.'),
('Liam Garcia', 'Liam writes memoirs and personal essays about his life experiences.'),
('Mia Rodriguez', 'Mia is a graphic novelist who combines art and storytelling.'),
('Noah Anderson', 'Noah is a playwright whose works are performed internationally.'),
('Olivia Martinez', 'Olivia writes historical fiction that brings the past to life.');
SELECT * FROM Authors;

--Insert sample Books records

INSERT INTO Books (title, author_id, isbn, publication_year, genre, availability_status) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, '978-0439708180', 1997, 'Fantasy', 'Available'),
('Harry Potter and the Chamber of Secrets', 1, '978-0439708181', 1998, 'Fantasy', 'Available'),
('Harry Potter and the Prisoner of Azkaban', 1, '978-0439708182', 1999, 'Fantasy', 'Available'),
('A Game of Thrones', 2, '978-0553103540', 1996, 'Fantasy', 'Reserved'),
('A Clash of Kings', 2, '978-0553108576', 1998, 'Fantasy', 'Available'),
('A Storm of Swords', 2, '978-0553106633', 2000, 'Fantasy', 'Available'),
('The Hobbit', 3, '978-0547928227', 1937, 'Fantasy', 'Available'),
('The Fellowship of the Ring', 3, '978-0547928203', 1954, 'Fantasy', 'Available'),
('The Two Towers', 3, '978-0547928210', 1954, 'Fantasy', 'Available'),
('The Return of the King', 3, '978-0547928234', 1955, 'Fantasy', 'Available'),  -- Changed ISBN
('Murder on the Orient Express', 4, '978-0062073501', 1934, 'Mystery', 'Available'),
('The Adventures of Tom Sawyer', 5, '978-0486280615', 1876, 'Fiction', 'Available'),
('Pride and Prejudice', 6, '978-1503290563', 1813, 'Romance', 'Available'),
('The Great Gatsby', 7, '978-0743273565', 1925, 'Fiction', 'Available'),
('To Kill a Mockingbird', 8, '978-0061120084', 1960, 'Fiction', 'Available');

SELECT * FROM Books;

--Insert sample Members records

INSERT INTO Members (name, contact_info) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Michael Johnson', 'michael.johnson@example.com'),
('Emily Davis', 'emily.davis@example.com'),
('William Brown', 'william.brown@example.com'),
('Olivia Wilson', 'olivia.wilson@example.com'),
('James Garcia', 'james.garcia@example.com'),
('Sophia Martinez', 'sophia.martinez@example.com'),
('Benjamin Anderson', 'benjamin.anderson@example.com'),
('Ava Thomas', 'ava.thomas@example.com'),
('Lucas Taylor', 'lucas.taylor@example.com'),
('Mia Moore', 'mia.moore@example.com'),
('Ethan Jackson', 'ethan.jackson@example.com'),
('Isabella White', 'isabella.white@example.com'),
('Alexander Harris', 'alexander.harris@example.com'),
('Charlotte Clark', 'charlotte.clark@example.com');
SELECT * FROM Members;

--Insert sample Loans records

INSERT INTO Loans (book_id, member_id, due_date, return_date, status) VALUES
(1, 1, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(2, 2, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(3, 3, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(4, 4, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(5, 5, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(6, 6, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(7, 7, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(8, 8, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(9, 9, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(10, 10, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(11, 11, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(12, 12, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(13, 13, DATEADD(DAY, 14, GETDATE()), NULL, 'Active'),
(14, 14, DATEADD(DAY, 14, GETDATE()), NULL, 'Active');
SELECT * FROM Loans;

--Insert sample Reservations records

INSERT INTO Reservations (book_id, member_id, expiration_date, status) VALUES
(1, 1, DATEADD(DAY, 7, GETDATE()), 'Active'),
(2, 2, DATEADD(DAY, 7, GETDATE()), 'Active'),
(3, 3, DATEADD(DAY, 7, GETDATE()), 'Active'),
(4, 4, DATEADD(DAY, 7, GETDATE()), 'Active'),
(5, 5, DATEADD(DAY, 7, GETDATE()), 'Active'),
(6, 6, DATEADD(DAY, 7, GETDATE()), 'Active'),
(7, 7, DATEADD(DAY, 7, GETDATE()), 'Active'),
(8, 8, DATEADD(DAY, 7, GETDATE()), 'Active'),
(9, 9, DATEADD(DAY, 7, GETDATE()), 'Active'),
(10, 10, DATEADD(DAY, 7, GETDATE()), 'Active'),
(11, 11, DATEADD(DAY, 7, GETDATE()), 'Active'),
(12, 12, DATEADD(DAY, 7, GETDATE()), 'Active'),
(13, 13, DATEADD(DAY, 7, GETDATE()), 'Active'),
(14, 14, DATEADD(DAY, 7, GETDATE()), 'Active'),
(15, 15, DATEADD(DAY, 7, GETDATE()), 'Active');
SELECT * FROM Reservations ;



--Add a New Book
INSERT INTO Books (title, author_id, isbn, publication_year, genre, availability_status) 
VALUES ('New Book Title', 16, '978-1234567890', 2023, 'Fiction', 'Available');
select * from Books;

--Get All Books with Author Names
SELECT b.title, a.name AS author_name, b.publication_year, b.genre, b.availability_status
FROM Books b
JOIN Authors a ON b.author_id = a.author_id;

-- Get All Loans with Member Names
SELECT l.loan_id, b.title, m.name AS member_name, l.loan_date, l.due_date, l.status
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id;

--Get All Reservations that are Active
SELECT r.reservation_id, b.title, m.name AS member_name, r.reservation_date, r.expiration_date
FROM Reservations r
JOIN Books b ON r.book_id = b.book_id
JOIN Members m ON r.member_id = m.member_id
WHERE r.status = 'Active';


--Update Availability Status of a Book
UPDATE Books
SET availability_status = 'Checked Out'
WHERE book_id = 1; -- Change the book_id as needed
select * from Books;


--Mark a Loan as Returned
UPDATE Loans
SET return_date = GETDATE(), status = 'Returned'
WHERE loan_id = 2; -- Change the loan_id as needed
select * from Loans;


--Extend Due Date for a Loan
UPDATE Loans
SET due_date = DATEADD(DAY, 7, due_date) -- Extend by 7 days
WHERE loan_id = 1; -- Change the loan_id as needed
SELECT * FROM Loans;

 --Delete a Loans
SELECT * FROM Loans
WHERE book_id = 13;  -- Check for active loans before deletion
DELETE FROM Loans
WHERE book_id = 14;  -- Delete loans associated with the book
SELECT * FROM Loans;
 

--Count of Books by Genre
SELECT genre, COUNT(*) AS book_count
FROM Books
GROUP BY genre;


--Count of Loans by Member
SELECT m.name AS member_name, COUNT(l.loan_id) AS loan_count
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.name;



--Get Members with No Active Loans
SELECT m.name
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id AND l.status = 'Active'
WHERE l.loan_id IS NULL;

--Get Members with No Loans and Top Results

SELECT TOP 5 m.name
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL
ORDER BY m.name;  -- Limit to 5 results



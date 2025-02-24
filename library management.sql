#creating a database
CREATE DATABASE Library;
USE Library;
#create table branch
CREATE TABLE Branch( 
Branch_no VARCHAR(20) primary key,
Manager_id VARCHAR(20) UNIQUE,
Branch_address VARCHAR(50),
Contact_no BIGINT UNIQUE
);
INSERT INTO Branch(Branch_no,Manager_id,Branch_address,Contact_no)
VALUES
('LIB-0001','3001','STATE PUBLIC LIBRARY,Manachira,Kozhikode','9234000012'),
('LIB-0002','3012','DESAPOSHINI LIBRARY,Kuthiravattam,Kozhikode','9234000013');
SELECT*FROM Branch;
#create table employees
CREATE TABLE Employees(
Emp_Id int primary key,
Emp_name VARCHAR(50),
Position   VARCHAR(50),
Salary int,
Branch_no VARCHAR(20),
foreign key (Branch_no) references
Branch (Branch_no)
);
INSERT INTO Employees(Emp_Id,Emp_name,Position,Salary,Branch_no)
VALUES 
('3001','Venugopal','Manager','55000','LIB-0001'),
('2100','Aravind','Librarian','40000','LIB-0001'),
('2101','Joseph','Assistant Librarian','25000','LIB-0001'),
('2102','Kavitha','Assistant Librarian','30000','LIB-0001'),
('2001','Anu joseph','Computer Operator','40000','LIB-0001'),
('2002','Adam Muhammed','Computer Operator','45000','LIB-0001'),
('3012','Aswathynayar','Manager','55000','LIB-0002'),
('2103','Amar philiphs','Librarian','40000','LIB-0002'),
('2104','Sindhu','Assistant Librarian','30000','LIB-0002'),
('2003','Mahima','Computer Opertator','45000','LIB-0002');
SELECT*FROM Employees;
#create table books
CREATE TABLE Books(
ISBN VARCHAR(50) primary key,
Book_title VARCHAR(50) NOT NULL,
Category VARCHAR(50),
Rental_Price int NOT NULL,
Status VARCHAR(3) DEFAULT 'YES',
Author VARCHAR(50),
Publisher VARCHAR(50)
);
INSERT INTO Books(ISBN,Book_title,Category,Rental_Price,Author,Publisher)
VALUES
('BOOK-00001','Pride and Prejudice','Literary Fiction','80','Jane Austen','T.Egerton,Whitehall'),
('BOOK-00002','The Book Thief','Historical fiction','70','Markus Zusak','Alfred A.Knof'),
('BOOK-00003','The Diary of a Young Girl','Autobiography','70','Anne Frank','Penguin'),
('BOOK-00004','The Alchemist','Adventure,Fantasy','70','Paulo Coehlo','HarperTorch'),
('BOOK-00005','SPQR:A history of Ancient','History','60','Mary Beard','Liverright and Company'),
('BOOK-00006','Funny Story','Womens Fiction/Contemporary romance','60','Emily Henry','Berkley'),
('BOOK-00007','Hamlet','Tragedy','50','William Shakespeare','Simon and Schuster');
SELECT*FROM Books;
#create table customer
CREATE TABLE Customer(
Customer_Id VARCHAR(20) primary key,
Customer_name VARCHAR(50) NOT NULL,
Customer_address VARCHAR(100) NOT NULL,
Reg_date DATE DEFAULT(current_date)
);
INSERT INTO Customer(Customer_Id,Customer_name,Customer_address,Reg_date)
VALUES
('CUST-00001','Aravind','Skyline apart 22,Kozhikode','2019-11-09'),
('CUST-00002','Shreya Mathew','Skyline apart 23 Kozhikode','2019-12-08'),
('CUST-00003','Anumol','Skyline apart 24 Kozhikode','2020-08-09'),
('CUST-00004','Aryan','Skyline apart 12 Kozhikode','2020-09-04'),
('CUST-00005','Arun','Skyline apart 13 Kozhikode','2020-10-09'),
('CUST-00006','Miya','Skyline apart 15 Kozhikode','2023-07-07');
SELECT*FROM Customer;
#create table issue status
CREATE TABLE IssueStatus(
Issue_Id VARCHAR (20)  primary key,
Issued_cust VARCHAR(20),
FOREIGN KEY (Issued_cust) references Customer (Customer_Id),
Issued_book_name VARCHAR(50),
Issue_date DATE DEFAULT(CURRENT_DATE),
Isbn_book VARCHAR(20),
foreign key(Isbn_book) references Books(ISBN)
);

INSERT INTO IssueStatus(Issue_Id,Issued_cust,Issued_book_name,Issue_date,Isbn_book)
values
('ISSUE-00001','CUST-00001','Pride and Prejudice','2019-12-09','BOOK-00001'),
('ISSUE-00002','CUST-00002','Funny story','2020-09-04','BOOK-00006'),
('ISSUE-00003','CUST-00003','The Diary of a Young Girl','2023-06-09','BOOK-00003'),
('ISSUE-00004','CUST-00004','Hamlet','2023-06-12','BOOK-00007'),
('ISSUE-00005','CUST-00005','The Alchemist','2024-07-12','BOOK-00004');
SELECT*FROM IssueStatus;

#create table returnstatus
CREATE TABLE ReturnStatus(
Return_Id VARCHAR (20) primary key,
Return_cust VARCHAR(20),
foreign key (Return_cust) references Customer (Customer_Id),
Return_book_name VARCHAR(50),
Return_date DATE DEFAULT(CURRENT_date),
Isbn_book2 VARCHAR(20),
foreign key(Isbn_book2) references Books(ISBN)
);
INSERT INTO ReturnStatus(Return_Id,Return_cust,Return_book_name,Return_date,Isbn_book2)
VALUES
('RET-00001','CUST-00005','The Alchemist','2024-12-09','BOOK-00004'),
('RET-00002','CUST-00003','The Diary of a Young Girl','2023-11-03','BOOK-00003'),
('RET-00003','CUST-00001','Pride and Prejudice','2020-04-09','BOOK-00001'),
('RET-00004','CUST-00002','Funny story','2021-07-08','BOOK-00006'),
('RET-00005','CUST-00004','Hamlet','2023-12-10','BOOK-00007');

SELECT*FROM ReturnStatus;

#1.Retrieve the book title, category, and rental price of all available books
SELECT Book_title,category,Rental_price FROM Books;

#2. List the employee names and their respective salaries in descending order of salary
SELECT Emp_name,Salary FROM Employees ORDER BY Salary DESC;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT Issued_book_name,Customer_name FROM IssueStatus LEFT JOIN Customer on Issued_cust=customer_Id;

#4.Display the total count of books in each category.
SELECT Category,COUNT(*) FROM Books GROUP BY Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name,position FROM Employees Where Salary>50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name FROM Customer WHERE Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus) AND Reg_date<'2022-01-01';

#7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS 'Employee_Count' FROM  Employees GROUP BY Branch_no;

#8.Display the names of customers who have issued books in the month of June 2023
SELECT Customer_name, Customer_Id FROM IssueStatus LEFT JOIN Customer ON Issued_cust=Customer_Id
where issue_date BETWEEN '2023-06-01' AND '2023-06-30';

#9.Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Book_title LIKE '%history%';

#10.Retrieve the branch numbers along with the count of employees for branches having more 
#than 5 employees
SELECT Branch_no,COUNT(*) AS 'EmployeeCount' FROM Employees GROUP BY Branch_no HAVING COUNT(*)>5;

#11.Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT Emp_name,Branch_address FROM Branch left join Employees ON Manager_Id=Emp_Id;

#12.Display the names of customers who have issued books with a rental price higher than 25
SELECT Customer_name,Issued_cust FROM Customer
 RIGHT JOIN IssueStatus ON Issued_cust=Customer_Id
LEFT JOIN Books ON IssueStatus.Isbn_book=Books.ISBN
WHERE Rental_price>25;

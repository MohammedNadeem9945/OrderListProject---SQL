DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Import Data into Orders Table
-- Import Data into Customers Table
-- Import Data into Books Table




-- 1) Retrieve all books in the "Fiction" genre:
Select * from Books
Where genre='Fiction';


-- 2) Find books published after the year 1950:
Select * from Books 
Where published_year='1950';

-- 3) List all customers from the Canada:
Select * from Customers
where country='Canada';

-- 4) Show orders placed in November 2023:
Select * from orders where order_date Between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
Select Count(stock) as Total_stock from Books;


-- 6) Find the details of the most expensive book:
Select * from Books Order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
Select c.name,c.customer_id from Orders o join Customers c on c.customer_id=o.customer_id
where quantity>1 ;

-- 8) Retrieve all orders where the total amount exceeds $20:
Select * from Orders Where total_amount>20;

-- 9) List all genres available in the Books table:
Select Distinct(genre) from Books;

-- 10) Find the book with the lowest stock:
Select * from Books Order by stock;

-- 11) Calculate the total revenue generated from all orders:
Select sum(total_amount) as Total_revenue from Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
Select b.genre,sum(o.Quantity) as total_books_sold from Books b join Orders o on b.book_id=o.book_id Group by b.genre;


-- 2) Find the average price of books in the "Fantasy" genre:
Select AVG(price)as Average_price,genre from Books where genre='Fantasy' Group by genre;

-- 3) List customers who have placed at least 2 orders:
Select c.name,Count(o.order_id) from Customers c 
Join Orders o on c.customer_id = o.customer_id
Group by c.name Having Count(o.order_id)>2;

-- 4) Find the most frequently ordered book:
Select o.book_id,b.title,Count(o.order_id) as Order_count from Books b join Orders o on b.book_id = o.book_id group by o.book_id,b.title
Order by order_count Desc Limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
Select title,Price,genre from books where genre='Fantasy' Group by genre,title,price Order by price desc Limit 3 ;



-- 6) Retrieve the total quantity of books sold by each author:
Select b.author,Sum(o.quantity) as total_quantity from Books b join Orders o on b.book_id=o.book_id
Group by b.author;




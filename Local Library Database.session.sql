/*
  # База данных библиотеки:
    [-] Сотрудники          - Staff
        - Staff information
    [-] Читатели            - Customer
        - Customer information
    [-] Виды услуг          - Service
        - Take, order, extend
    [-] Фонды               - Registry
        - Count of books
    [-] Регистрация заказов - Request
        - order information
    [-] Контроль            - Control
        - Triggers and procedures on update delete data for outdated requests
*/

-- DROP SCHEMA IF EXISTS library CASCADE;
-- CREATE SCHEMA library;
-- SET search_path = library;
SET SCHEMA 'public';

CREATE OR REPLACE PROCEDURE setup_tables()
  LANGUAGE plpgsql AS
$$
BEGIN
  -- Drop all tables and relations
  DROP TABLE IF EXISTS Staff CASCADE;
  DROP TABLE IF EXISTS Customer CASCADE;
  DROP TABLE IF EXISTS Service CASCADE;
  DROP TABLE IF EXISTS Book CASCADE;
  DROP TABLE IF EXISTS Registry CASCADE;
  DROP TABLE IF EXISTS Request CASCADE;
  DROP TABLE IF EXISTS CustomerRequest CASCADE;
  DROP TABLE IF EXISTS StaffService CASCADE;

  CREATE TABLE Staff (
    id serial PRIMARY KEY,
    name     varchar(30) NOT NULL,
    surname  varchar(30) NOT NULL,
    phone    varchar(12) NOT NULL UNIQUE
  );

  CREATE TABLE Customer (
    id serial PRIMARY KEY,
    password    uuid         not NULL
    name        varchar(30)  NOT NULL,
    surname     varchar(30)  NOT NULL,
    address     varchar(256) NOT NULL,
    phone       varchar(12)  NOT NULL UNIQUE,
    order_id    int
  );

  CREATE TABLE Book (
    id      serial PRIMARY KEY,
    title        varchar(128) NOT NULL,
    author       varchar(128) NOT NULL,
    publisher    varchar(128) NOT NULL,
    published_at date         NOT NULL
  );

  CREATE TABLE CustomerRequest (
    customer_id int NOT NULL,
    request_id  int NOT NULL
  );

  CREATE TABLE Service (
    id int PRIMARY KEY,
    name       varchar(128) NOT NULL UNIQUE
  );

  CREATE TABLE StaffService (
    staff_id   int NOT NULL,
    service_id int NOT NULL
  );

  -- Table that contains count of each book
  CREATE TABLE Registry (
    book_id int NOT NULL,
    remains int NOT NULL -- Count of remaining books with book_id = book_id
  );

  -- Order information
  CREATE TABLE Request (
    id serial PRIMARY KEY,
    service_id int   NOT NULL, -- Service type
    books_id   int[] NOT NULL, -- List of requested books
    created_at date  NOT NULL, -- Request creation date
    expired_at date  NOT NULL  -- Request expired date
  );

  ALTER TABLE CustomerRequest
    ADD FOREIGN KEY (customer_id) REFERENCES Customer (id) ON DELETE CASCADE;

  ALTER TABLE CustomerRequest
    ADD FOREIGN KEY (request_id) REFERENCES Request (id) ON DELETE CASCADE;

  ALTER TABLE StaffService
    ADD FOREIGN KEY (staff_id) REFERENCES Staff (id) ON DELETE CASCADE;

  ALTER TABLE StaffService
    ADD FOREIGN KEY (service_id) REFERENCES Service (id) ON DELETE CASCADE;
END;
$$;

CREATE OR REPLACE PROCEDURE fill_tables()
  LANGUAGE plpgsql AS
$$
DECLARE
  quantity int[] DEFAULT ARRAY [0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]::int[];
BEGIN
  -- Create staff members
  INSERT INTO staff (name, surname, phone)
  VALUES ('Glenn', 'Paine', '425-614-1566'),
         ('Mason', 'Palacios', '313-397-7297'),
         ('Reanne', 'Montgomery', '435-841-5858'),
         ('Wallace', 'Deleon', '570-465-9100'),
         ('Dora', 'Blankenship', '864-291-9143'),
         ('Abi', 'Alford', '864-384-1397');

  -- Create customers
  INSERT INTO customer (name, surname, password, address, phone)
  VALUES ('Thalia', 'Gilbert', '900150983cd24fb0d6963f7d28e17f72', '802 Smith Road Lilburn, Georgia', '402-441-9890'),
         ('Star', 'Mahoney', 'e2fc714c4727ee9395f324cd2e7f331f', '2051 Hanover Street New York, New York', '973-824-3592'),
         ('Esme', 'Gonzalez', 'acbd18db4cc2f85cedef654fccc4a4d8', '125 Caynor Circle Piscataway, New Jersey', '530-571-0019'),
         ('Edison', 'Dillard', '37b51d194a7513e45b56f6524f2d51f2', '1737 Jenna Lane Des Moines, Iowa', '515-244-6784'),
         ('Yannis', 'Parra', '900150983cd24fb0d6963f7d28e17f72', '4230 Boone Crockett Lane BOGALUSA, Louisiana', '360-389-7358'),
         ('Annabell', 'Hammond', '900150983cd24fb0d6963f7d28e17f72', '1747 Watson Street Litile Egg Harbor To, New Jersey', '609-812-2135'),
         ('Gino', 'Kennedy', '900150983cd24fb0d6963f7d28e17f72', '4988 Duffy Street Crown Point, Indiana', '219-776-2888'),
         ('Hazel', 'Slater', '900150983cd24fb0d6963f7d28e17f72', '1441 Norman Street Los Angeles, California', '323-278-0641'),
         ('Rahima', 'Travers', '900150983cd24fb0d6963f7d28e17f72', '396 Virgil Street Wayne, New Jersey', '848-468-1618'),
         ('Kiri', 'Mcmanus', '900150983cd24fb0d6963f7d28e17f72', '642 Bombardier Way Worthington, Ohio', '740-210-6405'),
         ('Camron', 'Tomlinson', '900150983cd24fb0d6963f7d28e17f72', '2645 Primrose Lane Madison, Wisconsin', '608-603-6709'),
         ('Taran', 'Hodson', '900150983cd24fb0d6963f7d28e17f72', '1017 Dawson Drive Little Rock, Arkansas', '501-945-4054'),
         ('Morwenna', 'Barrow', '900150983cd24fb0d6963f7d28e17f72', '20 Raoul Wallenberg Place Wolcott, Connecticut', '203-879-6087');

  -- Create books
  INSERT INTO book (title, author, publisher, published_at)
  VALUES ('in search of Lost Time', 'Marcel Proust', 'Penguin Random House', '1829-02-10'),
         ('Ulysses', 'James Joyce', 'Penguin Random House', '1857-12-21'),
         ('Don Quixote', 'Miguel de Cervantes', 'Penguin Random House', '1861-09-29'),
         ('One Hundred years OF Solitude', 'Gabriel Garcia Marquez', 'Penguin Random House', '1862-08-10'),
         ('The Great Gatsby', 'F. Scott Fitzgerald', 'Penguin Random House', '1865-09-11'),
         ('Moby Dick', 'Herman Melville', 'Penguin Random House', '1866-03-17'),
         ('War and Peace', 'Leo Tolstoy', 'Penguin Random House', '1900-04-02'),
         ('Hamlet', 'William Shakespeare', 'Penguin Random House', '1900-04-03'),
         ('The Odyssey', 'Homer', 'Penguin Random House', '1902-06-07'),
         ('Madame Bovary', 'Gustave Flaubert', 'Penguin Random House', '1906-05-05'),
         ('The Divine Comedy', 'Dante Alighieri', 'Penguin Random House', '1912-11-17'),
         ('Lolita', 'Vladimir Nabokov', 'Penguin Random House', '1918-02-02'),
         ('The Brothers Karamazov', 'Fyodor Dostoyevsky', 'Hachette Livre', '1920-12-14'),
         ('Crime AND Punishment', 'Fyodor Dostoyevsky', 'Hachette Livre', '1933-01-09'),
         ('Wuthering Heights', 'Emily Brontë', 'Hachette Livre', '1945-12-01'),
         ('The Catcher IN the Rye', 'J. D. Salinger', 'Hachette Livre', '1961-08-25'),
         ('Pride AND Prejudice', 'Jane Austen', 'Hachette Livre', '1967-05-20'),
         ('The Adventures OF Huckleberry Finn', 'Mark Twain', 'Hachette Livre', '1968-10-14'),
         ('Anna Karenina', 'Leo Tolstoy', 'Hachette Livre', '1969-08-22'),
         ('Alice''s Adventures in Wonderland', 'Lewis Carroll', 'Hachette Livre', '1972-02-18'),
         ('The Iliad', 'Homer', 'HarperCollins', '1977-02-22'),
         ('To the Lighthouse', 'Virginia Woolf', 'HarperCollins', '1993-08-27'),
         ('Catch-22', 'Joseph Heller', 'HarperCollins', '2015-02-14'),
         ('Heart of Darkness', 'Joseph Conrad', 'HarperCollins', '2016-01-12'),
         ('The Sound and the Fury', 'William Faulkner', 'HarperCollins', '2018-08-20'),
         ('Nineteen Eighty Four', 'George Orwell', 'HarperCollins', '1824-12-01'),
         ('Great Expectations', 'Charles Dickens', 'HarperCollins', '1831-06-05'),
         ('One Thousand and One Nights', 'India/Iran/Iraq/Egypt', 'HarperCollins', '1833-11-18'),
         ('The Grapes of Wrath', 'John Steinbeck', 'HarperCollins', '1848-12-31'),
         ('Absalom, Absalom!', 'William Faulkner', 'HarperCollins', '1849-12-24'),
         ('Invisible Man', 'Ralph Ellison', 'Macmillan Publishers', '1855-09-11'),
         ('To Kill a Mockingbird', 'Harper Lee', 'Macmillan Publishers', '1861-04-22'),
         ('The Trial', 'Franz Kafka', 'Macmillan Publishers', '1861-07-01'),
         ('The Red and the Black', 'Stendhal', 'Macmillan Publishers', '1884-08-11'),
         ('Middlemarch', 'George Eliot', 'Macmillan Publishers', '1886-06-13'),
         ('Gulliver''S Travels', 'Jonathan Swift', 'Macmillan Publishers', '1928-04-29'),
         ('Beloved', 'Toni Morrison', 'Macmillan Publishers', '1941-02-24'),
         ('Mrs. Dalloway', 'Virginia Woolf', 'Macmillan Publishers', '1952-03-13'),
         ('The Stories OF Anton Chekhov', 'Anton Chekhov', 'Macmillan Publishers', '1965-04-11'),
         ('The Stranger', 'Albert Camus', 'Macmillan Publishers', '1966-11-12'),
         ('Jane Eyre', 'Charlotte Bronte', 'Simon & Schuster', '1968-06-06'),
         ('The Aeneid', 'Virgil', 'Simon & Schuster', '1971-03-24'),
         ('Collected Fiction', 'Jorge Luis Borges', 'Simon & Schuster', '1973-10-16'),
         ('The Sun ALSO Rises', 'Ernest Hemingway', 'Simon & Schuster', '1976-06-06'),
         ('David Copperfield', 'Charles Dickens', 'Simon & Schuster', '1994-08-07'),
         ('Tristram Shandy', 'Laurence Sterne', 'Simon & Schuster', '1995-09-29'),
         ('Leaves OF Grass', 'Walt Whitman', 'Simon & Schuster', '1997-10-31'),
         ('The Magic Mountain', 'Thomas Mann', 'Simon & Schuster', '2001-08-17'),
         ('A Portrait OF the Artist AS a Young Man', 'James Joyce', 'Simon & Schuster', '2002-11-16'),
         ('Midnight''s Children', 'Salman Rushdie', 'Simon & Schuster', '2021-04-21');

  -- Fill the registry with random books count
  INSERT INTO registry (book_id, remains)
  SELECT book_id, quantity[book_id]
  FROM book;

  -- Create services {Take: 1, Return: 2, Extend: 3} --> CONST table
  INSERT INTO service (service_id, name)
  VALUES (1, 'Take book'),
         (2, 'Return book'),
         (3, 'Extend book');

  -- Assign staff members to different services
  INSERT INTO staffservice (staff_id, service_id)
  VALUES (1, 1), -- Take   book
         (2, 1), -- Take   book
         (3, 2), -- Return book
         (4, 2), -- Return book
         (5, 3), -- Extend book
         (6, 3);

  -- Create two requests for customers
  INSERT INTO request(service_id, books_id, created_at, expired_at)
  VALUES (1, ARRAY [3,4,8,25,35,14], '2015-02-28', '2015-02-28'::date + INTERVAL '1 month' * 4),
         (1, ARRAY [1,2,3,4,5], '2008-12-16', '2008-12-16'::date + INTERVAL '1 month' * 5),
         (1, ARRAY [1,3,5,7,8], CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month' * 5),
         (1, ARRAY [1,5,3,8,7], CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month' * 3),
         (1, ARRAY [2,5,9,40], '2020-07-11', '2020-07-11'::date + INTERVAL '1 month' * 6),
         (1, ARRAY [4,7,8,9,10], CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month' * 7),
         (1, ARRAY [7,8,9,15], '2004-04-21', '2004-04-21'::date + INTERVAL '1 month' * 5);

  -- Set add customer record relations
  INSERT INTO customerrequest(customer_id, request_id)
  VALUES (1, 1),
         (2, 2),
         (3, 3),
         (4, 4),
         (5, 5),
         (6, 1),
         (7, 7);

END;
$$;

-- Setup all tables and relations
CALL setup_tables();

-- Fill all tables with template data
-- and [registry] table with random data
CALL fill_tables();
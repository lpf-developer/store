--Criação da base de dados STORE com collation utf8mb4
CREATE DATABASE STORE CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

--Seleciona a base de dados STORE
USE STORE;

--Criação da tabela Categories
CREATE TABLE Categories(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

--Criação da tabela Products
CREATE TABLE Products(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY(category_id) REFERENCES Categories(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

--Inserção de 5 categorias na tabela Categories
INSERT INTO Categories(name, description) VALUES
    ('Electronics', 'Devices and gadgets'),
    ('Clothing', 'Apparel and accessories'),
    ('Books', 'Printed and digital books'),
    ('Furniture', 'Home and office furniture'),
    ('Toys', 'Children\'s toys and games');

--Inserção de 15 produtos na tabela Products
INSERT INTO Products(name, price, category_id) VALUES
    ('Smartphone', 699.99, 1),
    ('Laptop', 999.99, 1),
    ('Headphones', 199.99, 1),
    ('T-Shirt', 29.99, 2),
    ('Jeans', 49.99, 2),
    ('Jacket', 89.99, 2),
    ('Mystery Novel', 14.99, 3),
    ('Science Fiction Book', 19.99, 3),
    ('Non-fiction Book', 24.99, 3),
    ('Office Chair', 129.99, 4),
    ('Dining Table', 499.99, 4),
    ('Sofa', 799.99, 4),
    ('Action Figure', 14.99, 5),
    ('Board Game', 29.99, 5),
    ('Puzzle', 9.99, 5);

--Verificação das inserções
SELECT * FROM Categories;
SELECT * FROM Products;

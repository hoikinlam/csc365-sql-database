-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Customers
(
    CustomerID int PRIMARY KEY,
    LastName VARCHAR(10),
    FirstName VARCHAR(8)
);

CREATE TABLE Goods
(
    GoodsID VARCHAR(13) PRIMARY KEY,
    Flavor VARCHAR(10),
    Food VARCHAR(9),
    Price DECIMAL(4,2),
    UNIQUE (Flavor,Food)
);

CREATE TABLE Receipts
(
    ReceiptNumber int PRIMARY KEY,
    Date VARCHAR(11), -- Date is oracle not sql format so temp in varchar
    CustomerID int,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Items
(
    ReceiptNumber int,
    Ordinal int,
    ItemID VARCHAR(13),
    PRIMARY KEY (ReceiptNumber, Ordinal),
    FOREIGN KEY (ReceiptNumber) REFERENCES Receipts(ReceiptNumber),
    FOREIGN KEY (ItemID) REFERENCES Goods(GoodsID)
);
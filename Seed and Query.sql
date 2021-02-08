#create databases
drop database if exists POS_Convenience;
create database POS_Convenience;

use POS_Convenience;

#Creating Tables
drop table if exists POS;
CREATE TABLE POS (
    Timestamp varchar(100),
    TransactionNumber VARCHAR(6),
    ProductUPC VARCHAR(12),
    Price FLOAT(9 , 3 ),
    Retailer VARCHAR(200)
);

drop table if exists ProductUPC;
CREATE TABLE ProductUPC (
    ProductUPC VARCHAR(12),
    ProductName VARCHAR(255)
);

Show Tables;

#Loading Data from CSV
Load data local infile '/Users/Mishaun_Bhakta/Documents/Python/Projects/365DataScience/SQL/Ryan Morris Test Data/POS_UPC_Data.csv' into table ProductUPC
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ProductUPC, ProductName);

select * from ProductUPC;

Load data local infile '/Users/Mishaun_Bhakta/Documents/Python/Projects/365DataScience/SQL/Ryan Morris Test Data/POSData.csv' into table POS
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Timestamp, TransactionNumber, ProductUPC, Price, Retailer);

select * from POS limit 5;

#Joining Tables

SELECT 
    *
FROM
    POS p
        LEFT JOIN
    ProductUPC u ON p.ProductUPC = u.ProductUPC;
    
#Question: How many unique transactions by retailer between 3-3-18 to 3-4-18

select Timestamp, str_to_date(Timestamp,'%M %d,%Y') as date, TransactionNumber from POS;


SELECT 
    Retailer,
    COUNT(DISTINCT (TransactionNumber)) AS UniqueTransactions
FROM
    POS
GROUP BY Retailer;

#Question:Select and return only the retailer with highest total sales and that retailer’s total sales number

select retailer, count(distinct(TransactionNumber)) as TotalUniqueSales
from pos
group by retailer
order by TotalUniqueSales desc
limit 1;
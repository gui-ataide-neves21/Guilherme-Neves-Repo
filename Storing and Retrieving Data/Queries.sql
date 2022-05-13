USE project_GroupM;

#1 List all the customer’s names, dates, and products or services bought by these customers in a range of two dates.
select concat(c.FIRST_NAME, ' ', c.LAST_NAME) as 'Customer Name', o.DATE_ORDER as 'Date of the Order', concat( p.PRODUCT_TYPE , " " , p.BRAND , " " , p.MODEL) as 'Product'
from `Order` o
join Client_Account c  on c.CLIENT_ID = o.CLIENT_ID
Join Products_Ordered p_o on p_o.ORDER_ID = o.ORDER_ID
join Products p on p.PRODUCT_ID = p_o.PRODUCT_ID
where o.DATE_ORDER between '2015-01-01' and '2017-12-31';


#2 List the best three customers (you are free to select the criteria that define a “best customer”)
SELECT concat(c.first_name, ' ' ,c.last_name) as 'Costumers Name', round(sum(po.QUANTITY *p.PRICE )/count(po.ORDER_ID), 2) as `Average Spending per order (in euros)`
FROM products_ordered po,  `order` o, Client_Account c, products p
WHERE  po.ORDER_ID= o.ORDER_ID and po.PRODUCT_ID=p.PRODUCT_ID and  o.CLIENT_ID=c.CLIENT_ID
group by o.CLIENT_ID
order by `Average Spending per order (in euros)` desc
limit 3 ;

#3 Get the average amount of sales (in euros) by month and by year for the whole sales history.
select concat(min(o.DATE_ORDER), ' - ', max(o.DATE_ORDER)) as 'Period of Sales', 
	   sum(p.PRICE*po.QUANTITY) AS TotalSales, 
	   round(sum(p.PRICE*po.QUANTITY) / TIMESTAMPDIFF(YEAR,min(o.DATE_ORDER),max(o.DATE_ORDER)), 2) as 'YearlyAverage', 
	   round(sum(p.PRICE*po.QUANTITY) / TIMESTAMPDIFF(MONTH,min(o.DATE_ORDER),max(o.DATE_ORDER)), 2) as 'MonthlyAverage'  
from `order` as o
join Products_Ordered as po on po.ORDER_ID = o.ORDER_ID
join Products as p on p.PRODUCT_ID = po.PRODUCT_ID;

#4 Get the total sales by geographical location (city/country).
select sum(po.QUANTITY*p.price) as `Total Sales (in euros)` , o.SHIPPING_LOCATION as 'Location' 
from  products_ordered po, products p,  `order` o
where o.ORDER_ID = po.ORDER_ID and po.PRODUCT_ID = p.PRODUCT_ID
group by o.SHIPPING_LOCATION
order by `Total Sales (in euros)` desc;

#5 List all the locations where products/services where sold and the product has customer’s ratings.
Select  o.SHIPPING_LOCATION as 'Location' 
From products as p
join Products_Ordered po on po.product_id = p.product_id
Join `order` o on o.order_id=po.order_id 
Where p.rating is not null
group by o.SHIPPING_LOCATION;


# Trigger 1: udates the stock of products after the customer completes an order.

Delimiter $$
Create Trigger Update_Stock_Products
After Insert
On products_ordered
For Each Row
Begin
	If New.ORDER_ID IS NOT NULL Then
		Update Products p 
        join products_ordered po on p.PRODUCT_ID = po.PRODUCT_ID
        join `order` o on o.ORDER_ID=po.ORDER_ID
		Set p.STOCK = p.STOCK - po.QUANTITY;
	End If;
END $$
delimiter ;


# Trigger 2: inserts a row in a “log” table if the price of a product is updated

create table log(
ID integer unsigned auto_increment primary key,
TS datetime,
Prod_ID integer not null,
New_Price integer,
Old_price integer,
MSG varchar (20)
);

delimiter $$
create trigger on_price_update
after update
on products
for each row
begin
	insert into log (TS, prod_id, New_Price, Old_Price, MSG) 
    values
    (now(), new.product_id, new.price, old.price, 'updated price');
end $$
delimiter ;

SET SQL_SAFE_UPDATES = 0;


CREATE VIEW InvoiceDetails AS
select
o.INVOICE_NUMBER AS `Invoice Number`,
concat( p.PRODUCT_TYPE, " ", p.BRAND, " ", p.MODEL, " ", p.COLOR , " ", p.SIZE, p.STORAGE) AS `Item description`,
p.price AS `Price (in euros)`,
po.quantity AS `Quantity`
from (products_ordered po join products p) 
join `order` o
where (po.PRODUCT_ID = p.PRODUCT_ID) and (o.ORDER_ID = po.ORDER_ID)
order by o.invoice_number;

CREATE VIEW invoice AS
 select
 o.INVOICE_NUMBER AS `Invoice Number`,
 o.DATE_ORDER AS `Date of issued`,
 concat( c.FIRST_NAME, " ", c.LAST_NAME) AS `Client Name`,
 c.ADRESS AS `Adress`,
 c.LOCATION AS `City`,
 c.COUNTRY AS `Country`,
 c.ZIP_CODE AS `Zip-Code`, 
 (sum((p.price * po.quantity)))  AS `SubTotal (in euros)`,
 concat(round((p.TAXRATE*100),1), "%") AS `TaxRate`, 
 round((sum((p.price * po.quantity)))*(p.TAXRATE) + sum((p.price * po.quantity)), 2) as `Total Price Before Discounts`, 
 round((sum(p.discount)*(sum((p.price * po.quantity))+sum((p.price * po.quantity))*(p.TAXRATE))), 2)as `TotalDiscount (in euros)`,
 round(((sum((p.price * po.quantity)))*(p.TAXRATE) + sum((p.price * po.quantity))) - (sum(p.discount)*(sum((p.price * po.quantity))+sum((p.price * po.quantity))*(p.TAXRATE))), 2) AS InvoiceTotal
 from `order` o 
 join client_account c
 join products p
 join products_ordered po
 where ((c.CLIENT_ID = o.CLIENT_ID) and (o.ORDER_ID = po.ORDER_ID) and (po.PRODUCT_ID = p.PRODUCT_ID))
 group by o.invoice_number;
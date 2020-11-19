#5. drop date column
Alter table house_price_data
drop date;
#6. Use sql query to find how many rows of data you have.
SELECT COUNT(*) FROM house_price_data;
#7. Now we will try to find the unique values in some of the categorical columns:
select DISTINCT(bedrooms) from house_price_data
ORDER BY bedrooms ASC;

select DISTINCT(bathrooms) from house_price_data
ORDER BY bathrooms ASC;;

select DISTINCT(floors) from house_price_data
ORDER BY floors ASC;;

select DISTINCT(house_price_data.condition) from house_price_data
ORDER BY house_price_data.condition ASC;;

select DISTINCT(grade) from house_price_data
ORDER BY grade ASC;


#8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.

select * from house_price_data
ORDER BY price DESC
limit 10;

#9.What is the average price of all the properties in your data?
select AVG(price) from house_price_data;

#10. 
#a.What is the average price of the houses grouped by bedrooms? 
select bedrooms,AVG(price) as average_price 
from house_price_data
group by bedrooms;
#b. What is the average sqft_living of the houses grouped by bedrooms?
select bedrooms,AVG(sqft_living) as Average_sqft_living 
from house_price_data
group by bedrooms;
#c.What is the average price of the houses with a waterfront and without a waterfront?
select waterfront, AVG(price) as Average_of_the_prices 
from house_price_data
where waterfront=1;
#d.Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

select AVG(house_price_data.condition), grade
from house_price_data
group by grade
order by grade ASC;

#--> no correlation

#11. One of the customers is only interested in the following houses:
#    Number of bedrooms either 3 or 4
#   Bathrooms more than 3
#   One Floor
#   No waterfront
#   Condition should be 3 at least
# Grade should be 5 at least
#   Price less than 300000

Select * from house_price_data
where bedrooms = 3 or 4 &
bathrooms > 3 &
floors=1 &
`condition`>=3 &
grade>=5 &
price<300000;

#12.Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
#first get avg
Select AVG(`Price`) from house_price_data;
#then write 2nd query
Select * 
from house_price_data 
where price>=2*(Select AVG(`Price`) from house_price_data);
#13. Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW expensive_properties AS
Select * 
from house_price_data 
where price>=2*(Select AVG(`Price`) from house_price_data);

Select * from expensive_properties;

#14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
Select
(select AVG(price)
from house_price_data
where bedrooms=4
group by bedrooms)
-
(select AVG(price)
from house_price_data
where bedrooms=3
group by bedrooms)
as difference
;
#15.What are the different locations where properties are available in your database? (distinct zip codes)

select distinct(zipcode) 
from house_price_data
order by zipcode ASC;

#16.Show the list of all the properties that were renovated.

Select * 
from house_price_data
where yr_renovated != 0;

#17. Provide the details of the property that is the 11th most expensive property in your database.

select * 
from house_price_data
order by price DESC
limit 1
OFFSET 10;
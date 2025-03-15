create database OrdCusSalpeo;

create table sale (
  snum integer primary key not null,
  sname varchar(30) not null,
  city varchar(15)not null,
  comm decimal(5,2)not null
  );
  
  select * from sale;

 create table Cust (
cnum int primary key not null,
cname varchar(30) not null,
city varchar(30) not null,
rating integer not null,
snum integer not null
);

select * from cust;


create table orde (
  onum integer primary key not null,
  amt decimal(6,2) not null,
  odate date not null,
  cnum integer not null,
  snum integer not null
);

select * from orde;


insert into sale values (1001, 'Peel', 'London',0.12),
(1002, 'Serres', 'San Jose',0.13),
(1003, 'Axelrod', 'New york',0.10),
(1004, 'Motika', 'London',0.11),
(1007, 'Rafkin', 'Barcelona',0.15);



insert into cust values (2001, 'Hoffman', 'London', 100 ,1001),
(2002, 'Giovanne', 'Rome', 200 ,1003),
(2003, 'Liu', 'San Jose', 300 ,1002),
(2004, 'Grass', 'Berlin', 100 ,1002),
(2006, 'Clemens', 'London', 300 ,1007),
(2007, 'Pereira', 'Rome', 100 ,1004),
(2008, 'James', 'London', 200 ,1007);


insert into orde value (3001,18.69, '1994-10-03',2008,1007),
(3002,1900.10, '1994-10-03',2007,1004),
(3003,767.19, '1994-10-03',2001,1001),
(3005,5160.45, '1994-10-03',2003,1002),
(3006,1098.16, '1994-10-04',2008,1007),
(3007,75.75, '1994-10-05',2004,1002),
(3008,4723.00, '1994-10-05',2006,1001),
(3009,1713.23, '1994-10-04',2002,1003),
(3010,1309.95, '1994-10-06',2004,1002),
(3011,9891.88, '1994-10-06',2006,1001);

# 4  Write a query to match the salespeople to the customers according to the city they are living.

select s.sname as SalespersonName,
       c.cname as CustomerName,
       s.city as City
from sale s
join cust c
on   s.city = c.city;

# 5 Write a query to select the names of customers and the salespersons who are providing service to them.

select c.cname AS CustomerName, 
       s.sname AS SalespersonName
from cust c
join sale s
on c.snum = s.snum;

# 6 Write a query to find out all orders by customers not located in the same cities as that of their salespeople

select o.onum as OrderNumber,
       o.amt as OrderAmount,
       o.odate as OrderDate,
       c.cname as CustomerName,
       c.city as CustomerCity,
       s.sname as SalespersonName,
       s.city as SalespersonCity
from  orde o
join  cust c on o.cnum = c.cnum
join  sale s on o.snum = s.snum
where  c.city <> s.city;


# 7 Write a query that lists each order number followed by name of customer who made that order

select o.onum as OrderNum,
	   c.cname as CustomerName
       from orde o
       join cust c
       on o.cnum=c.cnum;

# 8 Write a query that finds all pairs of customers having the same rating………………

select c1.cname as Customer1,
       c2.cname as Customer2,
       c1.rating as Rating
from cust c1
join cust c2
on c1.rating = c2.rating
and c1.cnum < c2.cnum;

# 9 Write a query to find out all pairs of customers served by a single salesperson………………..

select c1.cname as Customer1,
       c2.cname as Customer2,
       s.sname as SalespersonName
from cust c1
join cust c2 
on  c1.snum = c2.snum 
and c1.cnum < c2.cnum
join sale s
on c1.snum = s.snum;

# 10 Write a query that produces all pairs of salespeople who are living in same city………………..

select s1.sname as Salesperson1,
       s2.sname as Salesperson2,
       s1.city as City
from   sale s1
join   sale s2 
on     s1.city = s2.city
and    s1.snum < s2.snum;


# 11 Write a Query to find all orders credited to the same salesperson who services Customer 2008

select  o.onum as OrderNumber,
        o.amt as OrderAmount,
		o.odate as OrderDate,
        c.cname as CustomerName,
        s.sname as SalespersonName
from orde o
join cust c on o.cnum = c.cnum
join sale s on o.snum = s.snum
where s.snum = (select snum from cust where cnum = 2008);

# 12 Write a Query to find out all orders that are greater than the average for Oct 4th

select  o.onum as OrderNumber,
        o.amt as OrderAmount,
		o.odate as OrderDate
from orde o
where o.odate = '1994-10-04'
and 
    o.amt > (select avg(amt) 
        from orde
        where odate = '1994-10-04'
    );
    
    
# 13 Write a Query to find all orders attributed to salespeople in London.

select  o.onum as OrderNumber,
        o.amt as OrderAmount,
		o.odate as OrderDate,
		c.cname as CustomerName,
		s.sname as SalespersonName,
        s.city as SalespersonCity
from orde o
join cust c on o.cnum = c.cnum
join sale s on o.snum = s.snum
where s.city = 'London';


# 14 Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 

select c.cname as CustomerName,
       c.cnum as CustomerNumber
from cust c
where c.cnum = (select s.snum + 1000 from sale s where s.sname = 'Serres');


# 15 Write a query to count customers with ratings above San Jose’s average rating.

select count(*) as CustomerCount
from cust c
where 
    c.rating > ( select avg(c.rating)
        from cust c
        where city = 'San Jose');
  
        
select  c.cname as CustomerName,
        c.city as City,
        c.rating as Rating
from cust c
where
    c.rating > (select avg(c.rating)
        from cust c
        where c.city = 'San Jose');

# 16 Write a query to show each salesperson with multiple customers.

select s.sname as SalespersonName,
       count(c.cnum) as CustomerCount
from sale s
join cust c on s.snum = c.snum
group by s.snum, s.sname
having count(c.cnum) > 1;

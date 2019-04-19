1a)
select first_name, last_name
from actor;

1b)
alter table actor
add Actor_Name VARCHAR(50);
SET SQL_SAFE_UPDATES = 0;
update actor
set Actor_Name = concat(first_name,' ',last_name);
SET SQL_SAFE_UPDATES = 1;

2a)
select actor_id, first_name, last_name
from actor
where first_name = "joe";

2b)
select * 
from actor
where last_name like "%GEN%";

2c)
select * 
from actor
where last_name like "%LI%"
order by last_name, first_name;

2d)
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

4a)
select count(actor_id), last_name
from actor
group by last_name;

4b)
select count(actor_id), last_name
from actor
group by last_name
having count(actor_id) >1;

4c)
update actor
set first_name='HARPO'
where first_name='GROUCHO' and last_name='WILLIAMS';

4d)
SET SQL_SAFE_UPDATES = 0;
update actor
set first_name='GROUCHO'
where first_name='HARPO';
SET SQL_SAFE_UPDATES = 1;

5a)
Show create table address;
CREATE TABLE `address` (
   `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
   `address` varchar(50) NOT NULL,
   `address2` varchar(50) DEFAULT NULL,
   `district` varchar(20) NOT NULL,
   `city_id` smallint(5) unsigned NOT NULL,
   `postal_code` varchar(10) DEFAULT NULL,
   `phone` varchar(20) NOT NULL,
   `location` geometry NOT NULL,
   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`address_id`),
   KEY `idx_fk_city_id` (`city_id`),
   SPATIAL KEY `idx_location` (`location`),
   CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8
 
 6a)
 select s.first_name, s.last_name, a.address 
 from staff s, address a
 where s.address_id=a.address_id;
 
 6b)
 select first_name, last_name, sum(amount) as 'August purchases'
 from payment p, staff s
 where s.staff_id=p.staff_id AND
p.payment_date between '2005-07-31-23:59' AND '2005-09-01-00:00'
group by (s.staff_id);
  
 6c)
 select f.title as 'Film Name', Sum(a.actor_id) as 'Number of Actors in Film'
 from film_actor a, film f
 where f.film_id=a.film_id
 group by (f.title);
 
 6d)
 select title, film_id as 'Number of Copies Available'
 from film
 where title = 'Hunchback Impossible';

 6e)
 select c.first_name, c.last_name , sum(p.amount) 'total amount spent' 
 from payment p, customer c
 where p.customer_id=c.customer_id
 group by c.customer_id
 ORDER BY last_name ASC;
 
 7a)
 Select f.title, l.name as 'film language'
 from film f, language l
 where f.language_id =l.language_id
 AND l.name = 'English'
 AND title like 'K%' or 'Q%';
 
 7b)
 select a.first_name, a.last_name 
 from film_actor f, actor a
 where f.actor_id=a.actor_id
 and f.film_id in (select film_id from film where title = 'Alone Trip');

7c)
select first_name, last_name, c.email
from customer c, address a
where c.address_id=a.address_id
and a.city_id in (select c.city_id 
from city c, country o 
where c.country_id=o.country_id and o.country='Canada');

7d)
Select f.title
from film f, film_category c
where f.film_id=c.film_id
and c.category_id in (select category_id from category where name ='Family');

7e)
Select f.title, sum()
from film f
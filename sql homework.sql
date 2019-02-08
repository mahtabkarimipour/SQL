USE sakila
#question 1

SELECT first_name, last_name FROM actor;

SELECT concat(first_name,last_name) AS "actor name" FROM actor;
#question 2
SELECT * FROM actor WHERE first_name="Joe";

SELECT * FROM actor WHERE last_name LIKE '%gen%';

SELECT * FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name;

SELECT * FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");
#question 3
ALTER TABLE actor
    ADD actorDescription BLOB;
    
ALTER TABLE actor
DROP COLUMN actorDescription;

#question 4
SELECT COUNT(*) numbers, last_name
   FROM actor
   GROUP BY last_name;
   
SELECT COUNT(*) last_name, last_name
   FROM actor
   GROUP BY last_name HAVING numbers > 2;
   
UPDATE actor
SET 
    first_name = "HARPO"
WHERE 
    last_name = "WILLIAMS";
    
UPDATE actor
SET 
    first_name = "GROUCHO"
WHERE 
    last_name = "WILLIAMS";

#question 5
SHOW CREATE TABLE Address;
#question 6

SELECT first_name, last_name, address FROM staff
INNER JOIN address ON staff.address_id=address.address_id;

SELECT first_name, last_name, sum(amount) FROM staff
INNER JOIN payment ON staff.staff_id=payment.staff_id
group by(first_name);

SELECT title, count(actor_id) FROM film_actor
INNER JOIN film ON film_actor.film_id=film.film_id
group by title;

select count(*) from inventory where film_id in (select film_id from film where title= "Hunchback Impossible");

SELECT first_name, last_name, SUM(amount) FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY last_name ORDER BY last_name;


-- Question 7
select * from film WHERE title LIKE 'k%' or title LIKE 'q%';

select first_name, last_name from actor where actor_id in (select actor_id from film_actor where film_id in
(select film_id from film where title="alone trip"));

select first_name, last_name,email from customer where address_id in (select address_id from address where city_id in 
(select city_id from city INNER JOIN country ON city.country_id=country.country_id where country="Canada"));

select * from film where film.film_id in (select film_id from film_category INNER JOIN category ON film_category.category_id=category.category_id
where category.name="Family");

SELECT store_id, SUM(amount) FROM customer
INNER JOIN payment ON customer.store_id=payment.staff_id


SELECT title, count(title) FROM rental
INNER JOIN inventory ON rental.inventory_id=inventory.inventory_id
INNER JOIN film on inventory.film_id=film.film_id
group by title order by count(title) DESC;

SELECT store_id, city, country FROM store
INNER JOIN address ON store.address_id=address.address_id
INNER JOIN city on address.city_id=city.city_id
INNER JOIN country on city.country_id=country.country_id;

SELECT category.name AS 'Genre', SUM(payment.amount) AS 'GR'
FROM category, film_category, inventory, rental, payment
WHERE category.category_id = film_category.category_id AND film_category.film_id = inventory.film_id AND inventory.inventory_id = rental.inventory_id AND rental.rental_id = payment.rental_id
GROUP BY Genre
ORDER BY 'GR' DESC LIMIT 5;

#question 8
create VIEW top_five_genres AS SELECT category.name AS 'Genre', SUM(payment.amount) AS 'GR'
FROM category, film_category, inventory, rental, payment
WHERE category.category_id = film_category.category_id AND film_category.film_id = inventory.film_id AND inventory.inventory_id = rental.inventory_id AND rental.rental_id = payment.rental_id
GROUP BY Genre
ORDER BY 'GR' DESC LIMIT 5;

SHOW CREATE VIEW top_five_genres;

select * from top_five_genres;

DROP VIEW top_five_genres;



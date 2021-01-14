-- Question 1: Create person table
CREATE TABLE PERSON (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR (50) NULL,
	last_name VARCHAR (50) NULL,
	birth_date DATE NULL,
	gender VARCHAR (6) NULL,
	salary NUMERIC CHECK(salary > 0)
);
ALTER TABLE PERSON
    OWNER to postgres;

-- Question 2: Insert 2 records into person table
INSERT INTO person (first_name, last_name, birth_date, gender, salary) VALUES
	('John', 'Doe', '01-JAN-2020', 'MALE', '10000.50'),
	('Mary', 'Jane', '29-FEB-2020', 'FEMALE', '5000.12');
	
-- Question 3
-- Insert 1,000,000 records into person table
INSERT INTO person (first_name, last_name, birth_date, gender, salary) SELECT
	(ARRAY['Aiden',
			'Anika',
			'Ariya',
			'Ashanti',
			'Avery',
			'Cameron',
			'Ceri',
			'Che',
			'Danica',
			'Darcy',
			'Dion',
			'Eman',
			'Eren',
			'Esme',
			'Frankie',
			'Gurdeep',
			'Haiden',
			'Indi',
			'Isa',
			'Jaskaran',
			'Jaya',
			'Jo',
			'Jodie',
			'Kacey',
			'Kameron',
			'Kayden',
			'Keeley',
			'Kenzie',
			'Lucca',
			'Macauley',
			'Manraj',
			'Nur',
			'Oluwatobiloba',
			'Reiss',
			'Riley',
			'Rima',
			'Ronnie',
			'Ryley',
			'Sam',
			'Sana',
			'Shola',
			'Sierra',
			'Tamika',
			'Taran',
			'Teagan',
			'Tia',
			'Tiegan',
			'Virginia',
			'Zhane',
			'Zion'])[random() * 49 + 1],
	(ARRAY['Ahmad',
			'Andersen',
			'Arias',
			'Barlow',
			'Beck',
			'Bloggs',
			'Bowes',
			'Buck',
			'Burris',
			'Cano',
			'Chaney',
			'Coombes',
			'Correa',
			'Coulson',
			'Craig',
			'Frye',
			'Hackett',
			'Hale',
			'Huber',
			'Hyde',
			'Irving',
			'Joyce',
			'Kelley',
			'Kim',
			'Larson',
			'Lynn',
			'Markham',
			'Mejia',
			'Miranda',
			'Neal',
			'Newton',
			'Novak',
			'Ochoa',
			'Pate',
			'Paterson',
			'Pennington',
			'Rubio',
			'Santana',
			'Schaefer',
			'Schofield',
			'Shaffer',
			'Sweeney',
			'Talley',
			'Trevino',
			'Tucker',
			'Velazquez',
			'Vu',
			'Wagner',
			'Walton',
			'Woodward'])[random() * 49 + 1],
	timestamp '1970-01-01 00:00:00' + random() * (timestamp '2070-12-31 00:00:00' - timestamp '1970-01-01 00:00:00'),
	(ARRAY['MALE', 'FEMALE'])[random() * 1 + 1],
	round(CAST(random()*100000.00+1 AS NUMERIC), 3)
	FROM generate_series(1, 1000000);
	
-- Question 4
-- Display all records where the first name is John and the last name is Doe
SELECT * FROM person
WHERE first_name LIKE 'John'
AND last_name LIKE 'Doe';

-- Display all records where the gender is female and salary is greater than 5000.50 and birth_date is between the Unix Timestamp values of '946684800' and '1609372800'
SELECT * FROM person
WHERE DATE_PART('epoch', birth_date) BETWEEN 946684800 AND 1609372800
AND salary > 5000.50
AND gender LIKE 'FEMALE';

-- Display the number of records grouped by gender and salary (where salary is rounded up to the nearest thousandth)
SELECT gender, salary, COUNT(*) AS count FROM person
GROUP BY gender, salary;

-- Question 5
-- Using INDEX for first_name and last_name columns
CREATE INDEX name_idx
    ON person USING btree
    (first_name ASC NULLS LAST, last_name ASC NULLS LAST);
	
	
-- Using INDEX for salary and birth_date (in unix_timestamp format) in DESC order
CREATE INDEX birth_salary_idx ON person USING btree (DATE_PART('epoch', birth_date) DESC NULLS LAST, salary DESC NULLS LAST);

-- Reorder columns in Group By statement to improve the calculation
SELECT gender, salary, COUNT(*) AS count FROM person
GROUP BY salary, gender;

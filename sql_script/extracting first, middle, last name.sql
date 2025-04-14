-- Creating a table structure
CREATE TABLE persons (
    id int PRIMARY KEY,
    full_name VARCHAR(100)
);

-- Insert data
INSERT INTO persons (id,full_name) VALUES
(1,'John Doe'),
(2,'Emma Watson'),
(3,'Emily Rose Pattrick'),
(4,'Robert Downey'),
(5,'Chris Evans'),
(6,'Scarlett Johansson'),
(7,'Sania Iqbal Shaik');


-- SQL Query for Extracting First, Middle, and Last Names from Full Name
with names as (
select *, len(full_name) length, 
len(full_name)-len(REPLACE(full_name,' ','')) no_of_spaces,
CHARINDEX(' ',full_name)as first_space,
CHARINDEX(' ', full_name,CHARINDEX(' ',full_name)+1) as second_space
from persons
)
select id,
case when no_of_spaces>=1 then left(full_name,first_space-1) end as first_name,
case when no_of_spaces=2 then substring(full_name,first_space+1,length-first_space-(length-second_space)) else '-' end as middle_name,
case when no_of_spaces = 1 then right(full_name, length-first_space)
	 when no_of_spaces = 2 and second_space is not null then right(full_name, length-second_space) end as last_name
from names;
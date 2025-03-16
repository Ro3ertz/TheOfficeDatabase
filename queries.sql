-- Basic Queries

--Find all employees
select *
from employee;

--Find all clients
select *
from client;

--Find all employees ordered by salary
select *
from employee
order by salary desc;

--Find all eployees ordered by sex then name
select *
from employee
order by sex, first_name;

--Find the fists 5 employees in the table
select*
from employee
limit 5;

--Find the first and last name of all employees
select first_name, last_name
from employee;

--Find the forename and surnames names of all employees
select first_name as forename, last_name as surname
from employee;

--Find out all the different genders
select distinct sex
from employee;
----------------------------------------------------------------

--Functions

--Find the number of employees
select count(emp_id)
from employee;

--Find the number of female employees born after 1970
select count(emp_id)
from employee
where sex = 'F' and birth_day > '1970-01-01';

--Find the average of all employees' salaries
select avg(salary)
from employee;

--Find the sum of all employee's salaries
select sum(salary)
from employee;

--Find out how many males and females the are
select count(sex), sex
from employee
group by sex;

--Find the total sales of each salesman
select sum(total_sales), emp_id
from works_with
group by emp_id;

-----------------------------------------------------------------
--Wildcards
-- % = any # characters, _ = one character

--Find any client's who are an LLC
select *
from client
where client_name like '%LLC';

--Find any branch suppliers who are in the label business
select *
from branch_supplier
where supplier_name like '% Label%';

--Find any clients who are schools
select *
from client
where client_name like '%school%';
------------------------------------------------------------------------------
--Union

--Find a list of employee, branch names and clients
select first_name as Company_names
from employee
union
select branch_name
from branch
union
select client_name
from client;

--Find a list of all clients and branch supplier's names
select client_name, client_id
from client
union 
select supplier_name, branch_id
from branch_supplier;

--Find a list of all money spent or ernerd by the company
select salary as Spent_Ernerd_Company
from employee
union 
select total_sales
from works_with;
------------------------------------------------------------
--Joins

insert into branch values (4, 'Buffalo', NULL, NULL);

select *
from branch

--Find all branches and the names of their managers
--join
select employee.emp_id, employee.first_name, branch.branch_name
from employee
join branch
on employee.emp_id = branch.mgr_id;

--Find our all branches and the names of their managers
--left join
select employee.emp_id, employee.first_name, branch.branch_name
from employee
left join branch
on employee.emp_id = branch.mgr_id;

--right join
select employee.emp_id, employee.first_name, branch.branch_name
from employee
right join branch
on employee.emp_id = branch.mgr_id;

--------------------------------------------------------------
--Nested queries

--Find names of all employees who have
--sold over 30,000 to a single client
select employee.first_name, employee.last_name
from employee
where employee.emp_id IN (
	select works_with.emp_id
	from works_with
	where works_with.total_sales > 30000
);

--Find all clients who are handled by branch
--that Michael Scott manages
--Assume you know Michael's ID
select client.client_name
from client
where client.branch_id = (
	select branch.branch_id
	from branch
	where branch.mgr_id = 102
);

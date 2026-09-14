
select e.name as emp_nm,
   d.department_name as dept_nm
from employees e, departments d
where e.department_id = d.department_id;


select e.name as "이름",
   d.department_name as "부서명"
from employees e, departments d
where e.department_id = d.department_id;


SELECT * FROM EMPLOYEES WHERE MANAGER_ID = 123;
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL;


SELECT NAME, SALARY 
FROM EMPLOYEES WHERE SALARY > 5000;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 10;

select * from customers where name like 'C%';

select name
from customers
where name like '%r\%%' escape '\';
#패턴 'r%'를 포함하는 데이터

select name
from customers
where name like '%#_3%' escape '#';
#패턴 '_3'를 포함하는 데이터

select file_name
from FILE_INFO
where file_name like '%\_2026%' escape '\';

select * from employees
where salary not between 3000 and 5000;

select name, email
from customers
where name like '%\%%' escape '\';

SELECT ACCOUNT_ID, BALANCE
FROM ACCOUNTS
WHERE ACCOUNT_TYPE IN ('SAVINGS', 'CREDIT') 
  AND BALANCE BETWEEN 30000 AND 70000;

SELECT TRANSACTION_ID, AMOUNT
FROM TRANSACTIONS
WHERE TRANSACTION_TYPE IN ('DEPOSIT') 
  AND AMOUNT >= 1000;

SELECT LOAN_ID, AMOUNT
FROM LOANS
WHERE STATUS NOT IN ('REJECTED') 
  AND AMOUNT >= 50000;
  
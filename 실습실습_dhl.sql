
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


SELECT NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY DESC NULLS LAST;

SELECT NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID ASC, SALARY DESC nulls last;

SELECT NAME, EMAIL
FROM CUSTOMERS
ORDER BY EMAIL ASC NULLS FIRST, NAME ASC;



SELECT NAME, EMAIL
FROM CUSTOMERS
ORDER BY 
    CASE WHEN EMAIL IS NULL THEN 0 ELSE 1 END ASC,
    EMAIL ASC,
    TO_NUMBER(REGEXP_SUBSTR(NAME, '[0-9]+')) ASC;


SELECT *
FROM ACCOUNTS
WHERE BALANCE >= 50000
ORDER BY ACCOUNT_TYPE ASC, BALANCE DESC;

SELECT TRANSACTION_ID, AMOUNT
FROM TRANSACTIONS
ORDER BY TRANSACTION_TYPE ASC, AMOUNT DESC;

SELECT DISTINCT ACCOUNT_TYPE
FROM ACCOUNTS;

SELECT DISTINCT TRANSACTION_TYPE
FROM TRANSACTIONS;

SELECT COUNT(DISTINCT ACCOUNT_TYPE), COUNT(DISTINCT CUSTOMER_ID)
FROM ACCOUNTS
ORDER BY ACCOUNT_TYPE ASC, CUSTOMER_ID ASC;

SELECT DEPARTMENT_ID, ROUND(AVG(SALARY), -1) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID ASC;

SELECT JOB_ID,
    MAX(SALARY) AS MAX_SALARY,
    MIN(SALARY) AS MIN_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID;

SELECT SUM(COUNT(*)) AS EMP_COUNT
FROM EMPLOYEES
WHERE SALARY > 5000
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID ASC NULLS LAST;

SELECT SUM(EMP_COUNT) AS EMP_COUNT
FROM (
    SELECT DEPARTMENT_ID, COUNT(*) AS EMP_COUNT
    FROM EMPLOYEES
    WHERE SALARY > 5000
    GROUP BY DEPARTMENT_ID
) subquery
ORDER BY DEPARTMENT_ID ASC NULLS LAST;

SELECT DEPARTMENT_ID, ROUND(AVG(SALARY), -1) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 6000
ORDER BY DEPARTMENT_ID ASC NULLS LAST;

SELECT ACCOUNT_TYPE, ROUND(AVG(BALANCE), -1) AS AVG_BALANCE
FROM ACCOUNTS
GROUP BY ACCOUNT_TYPE
ORDER BY AVG_BALANCE DESC;

SELECT TRANSACTION_TYPE,
    ROUND(SUM(AMOUNT), -1) AS TOTAL_AMOUNT
FROM TRANSACTIONS
GROUP BY ROLLUP(TRANSACTION_TYPE);

SELECT CUSTOMER_ID,
    COUNT(*) AS ACCOUNT_COUNT,
    ROUND(AVG(BALANCE), -1) AS AVG_BALANCE
FROM ACCOUNTS
GROUP BY CUSTOMER_ID
HAVING AVG(BALANCE) >= 50000
ORDER BY ACCOUNT_COUNT DESC, CUSTOMER_ID ASC;


To_CHAR(TRANSACTION_DATE, 'YYYY-MM') AS TRANSACTION_MONTH,
    SUM(AMOUNT) AS TOTAL_AMOUNT;




-- #1 승인된 대출의 대출 건수 및 총 대출 금액
SELECT COUNT(LOAN_ID) AS LOAN_COUNT,
        ROUND(SUM(AMOUNT), -1) AS TOTAL_AMOUNT
FROM LOANS
WHERE STATUS = 'APPROVED'
GROUP BY STATUS;

SELECT SUM(AMOUNT) AS TOT_AMT, COUNT(*) AS CNT
FROM LOANS
WHERE STATUS = 'APPROVED';



-- #2 월별 거래 금액 합게 조회
SELECT TRANSACTION_MONTH, ROUND(SUM(AMOUNT), -1) AS TOTAL_AMOUNT
FROM (SELECT TRANSACTION_ID, ACCOUNT_ID, AMOUNT, TRANSACTION_TYPE, TRANSACTION_DATE, TO_CHAR(TRANSACTION_DATE, 'YYYY-MM') AS TRANSACTION_MONTH
    FROM TRANSACTIONS
    )
GROUP BY TRANSACTION_MONTH
HAVING ROUND(SUM(AMOUNT), -1) > 100000
;

SELECT TO_CHAR(TRANSACTION_DATE, 'YYYY-MM') AS TRANSACTION_MONTH, 
    SUM(AMOUNT) AS TOTAL_AMOUNT
FROM TRANSACTIONS
GROUP BY TO_CHAR(TRANSACTION_DATE, 'YYYY-MM')
HAVING SUM(AMOUNT) > 100000;


-- #3 각 지점별 승인된 대출의 대출 건수, 평균 대출 금액, 총 대출 금액 조회
SELECT BRANCH_ID, COUNT(LOAN_ID) AS LOAN_COUNT, 
    ROUND(AVG(AMOUNT), -1) AS AVG_AMOUNT,
    ROUND(SUM(AMOUNT), -1) AS TOTAL_AMOUNT
FROM LOANS
WHERE STATUS = 'APPROVED'
GROUP BY BRANCH_ID;

SELECT BRANCH_ID,
    AVG(AMOUNT) AS AVG_AMOUNT,
    SUM(AMOUNT) AS TOTAL_AMOUNT
FROM LOANS
WHERE STATUS = 'APPROVED'
GROUP BY BRANCH_ID;

-- 문자 함수
select upper('hello') as uppercase,
    lower('world') as lowercase
from dual;

select *
from dual;

select length('SQL Function') as LENGTH,
    SUBSTR('SQL Function', 5, 8) as SUBSTRING
from dual;

-- substring 내 인자값
select instr('Oracle SQL', 'SQL') AS POSITION,
    TRIM(' Oracle SQL  ') AS TRIMMED_STRING,
    length(' Oracle SQL  ')
FROM DUAL;

select LPAD('SQL', 10, '*') AS LEFT_PADDED,
    RPAD('SQL', 10, '*') AS RIGHT_PADDED
FROM DUAL;

SELECT REPLACE('Hello SQL', 'SQL', 'Oracle') AS REPLACED_STRING,
    CONCAT('Hello', 'World') AS CONCATENATED_STRING,
    'Hello'||'World' AS CONCATENATED_STRING
FROM DUAL;

select round(123.456, 2) as rounded,
    trunc(123.456, 2) as truncated
from DUAL;

SELECT ABS(-123) AS ABSOLUTE,
    MOD(10, 3) AS REMAINDER
FROM DUAL;

select ceil(123.456) as CEILED,
    FLOOR(123.456) as FLOORED
FROM DUAL;

select sysdate as SYS_DATE,
    current_date as SESSION_DATE
FROM DUAL;

select add_months(sysdate, 2) as two_months_later,
    months_between(sysdate, to_date('2024-01-01', 'YYYY-MM-DD')) AS MONTH_DIFF,
    days_between(sysdate, to_date('2024-01-01', 'YYYY-MM-DD')) AS DAYS_DIFF
FROM DUAL;

SELECT NEXT_DAY(SYSDATE, 'SUNDAY') AS NEXT_SUNDAY,
    LAST_DAY(SYSDATE) AS END_OF_MONTH
FROM DUAL;

SELECT EXTRACT(YEAR FROM SYSDATE) AS CURRENT_YEAR,
    TRUNC(SYSDATE, 'MM') AS START_OF_MONTH
FROM DUAL;

SELECT NVL(NULL, 'Default Value') AS RESULT 
FROM DUAL;

SELECT NVL2('ABC', 'Not Null', 'Null') AS RESULT 
FROM DUAL;

SELECT COALESCE(NULL, NULL, 'First Non-Null') AS RESULT
FROM DUAL;

SELECT NULLIF(1,1) AS RESULT1, NULLIF(1,2) AS RESULT2
FROM DUAL;

SELECT	EMPLOYEE_ID,
    CASE WHEN SALARY > 10000 THEN 'HIGH'
    WHEN SALARY	BETWEEN	5000 AND 10000 THEN	'MEDIUM'
    ELSE 'LOW' END 
    AS SALARY_LEVEL
FROM	EMPLOYEES;

SELECT EMPLOYEE_ID, DECODE(JOB_ID, 'ADMIN', '관리자', 
                                   'DEV', '개발자',
                                   'HR', '인사담당자',
                                   '기타')	
                    AS	DEPARTMENT_NAME
FROM EMPLOYEES;

select * from employees;
select * from departments;

select e.name, d.department_name
from employees e 
    inner join departments d 
    on e.department_id = d.department_id;

select e.name, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- LEFT OUTER JOIN
select e.name, d.department_name
from employees e 
    left join departments d 
    on e.department_id = d.department_id;

select e.name, d.department_name
from employees e
    right outer join departments d
    on e.department_id = d.departmen0t_id;

select e.name, d.department_name
from employees e
    full outer join departments d
    on e.department_id = d.department_id;

select e1.name as employee, e2.name as manager
from employees e1
    left join employees e2
    on e1.manager_id = e2.employee_id;

select name, department_name
from employees
natural join departments;

select c.name, t.amount
from customers c
inner join accounts a
    on c.customer_id = a.customer_id
inner join transactions t
    on a.account_id = t.account_id;

select e.EMPLOYEE_ID,
        e.name as EMP_NM,
        d.LOCATION
from employees e, departments d
where e.department_id = d.department_id (+)
and d.location = 'New York';


-- # 1
SELECT B.BRANCH_NAME, C.NAME AS CUSTOMER_NAME, C.EMAIL AS CUSTOMER_EMAIL, C.PHONE AS CUSTOMER_PHONE, C.ADDRESS AS CUSTOEMR_ADDRESS
FROM BRANCHES B
LEFT OUTER JOIN LOANS L ON B.BRANCH_ID = L.BRANCH_ID
LEFT OUTER JOIN CUSTOMERS C ON L.CUSTOMER_ID = C.CUSTOMER_ID
ORDER BY B.BRANCH_NAME, CUSTOMER_NAME;

-- # 2

SELECT COUNT(*)
FROM (
    SELECT A.ACCOUNT_ID, C.NAME AS CUSTOMER_NAME, C.EMAIL AS CUSTOMER_EMAIL
    FROM ACCOUNTS A
    LEFT JOIN CUSTOMERS C ON A.CUSTOMER_ID = C.CUSTOMER_ID
    WHERE A.BALANCE > 50000
    ORDER BY C.NAME
);

-- # 3


--SELECT DISTINCT STATUS FROM LOANS;
SELECT L.LOAN_ID, C.NAME, L.AMOUNT, L.STATUS
FROM LOANS L LEFT OUTER JOIN CUSTOMERS C ON L.CUSTOMER_ID = C.CUSTOMER_ID
WHERE L.STATUS = 'PENDING';


select name, salary
from employees
where salary > (select avg(salary) from employees);

SELECT DEPARTMENT_ID, NAME, SALARY
FROM EMPLOYEES E1
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEES E2
                WHERE E1.DEPARTMENT_ID = E2.DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, NAME, SALARY,
        (SELECT AVG(SALARY) FROM EMPLOYEES
         WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) AS AVG_SALARY
FROM EMPLOYEES E
WHERE DEPARTMENT_ID IS NOT NULL;

SELECT D.DEPARTMENT_NAME, T.AVG_SALARY
FROM DEPARTMENTS D,
     (SELECT DEPARTMENT_ID, AVG(SALARY) AS AVG_SALARY
      FROM EMPLOYEES GROUP BY DEPARTMENT_ID) T
WHERE D.DEPARTMENT_ID = T.DEPARTMENT_ID;

SELECT NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                       FROM DEPARTMENTS 
                       WHERE DEPARTMENT_NAME = 'Department 1'); 


SELECT DEPARTMENT_ID, SUM(SALARY) AS TOTAL_SALARY, AVG(SALARY) AS AVG_SALARY,
       (SELECT AVG(SALARY) FROM EMPLOYEES) AS COMPANY_AVG_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY DEPARTMENT_ID;

select name from employees
where department_id in (select department_id 
                        from departments 
                        where location = 'New York');

select name from employees
where (department_id, job_id) in 
            (select department_id, job_id from job_history);

-- # 1
-- join
select count (*) from (
SELECT DISTINCT C.NAME
FROM CUSTOMERS C
JOIN LOANS L ON C.CUSTOMER_ID = L.CUSTOMER_ID
JOIN BRANCHES B ON L.BRANCH_ID = B.BRANCH_ID
WHERE B.LOCATION = 'Location 1'
);

select count (*) from (
select distinct c.name
from loans L 
    left join branches b on L.branch_id = b.branch_id
    left join customers c on L.customer_id = c.customer_id
where b.location = 'Location 1'
);

-- subquery

SELECT C.NAME
FROM CUSTOMERS C
WHERE C.CUSTOMER_ID IN (
    SELECT L.CUSTOMER_ID
    FROM LOANS L
    WHERE L.BRANCH_ID IN (
        SELECT B.BRANCH_ID
        FROM BRANCHES B
        WHERE B.LOCATION = 'Location 1'
    )
);

select name
from customers
where customer_id in (select customer_id from loans, branches
                      where location = 'Location 1');
;


SELECT NAME
FROM CUSTOMERS
WHERE CUSTOMER_ID IN (
    SELECT L.CUSTOMER_ID
    FROM LOANS L
    JOIN BRANCHES B
    ON L.BRANCH_ID = B.BRANCH_ID
    WHERE B.LOCATION = 'Location 1'
);

SELECT TRANSACTION_ID, ACCOUNT_ID, AMOUNT, TRANSACTION_DATE
FROM TRANSACTIONS
WHERE ACCOUNT_ID IN (
    SELECT ACCOUNT_ID
    FROM ACCOUNTS
    WHERE CUSTOMER_ID = 100
);

SELECT CUSTOMER_ID, ACCOUNT_ID, BALANCE
FROM ACCOUNTS A
WHERE BALANCE = (
    SELECT MAX(BALANCE)
    FROM ACCOUNTS B
    WHERE A.CUSTOMER_ID = B.CUSTOMER_ID
);

SELECT CUSTOMER_ID, ACCOUNT_ID, BALANCE
FROM ACCOUNTS A
WHERE (A.CUSTOMER_ID, A.BALANCE)

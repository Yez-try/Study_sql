SELECT *
FROM tab;--TAB�� ���̺��̶�� ��

SELECT *
FROM EMPLOYEES;

--
SELECT  *
FROM EMPLOYEES
WHERE commission_pct IS NOT NULL;
--�������
--comission_pct���̺� ���� �Ѱ��� row�� �˻縦 �Ѵ�.
--�ش�row�� where���ǿ� �´��� Ȯ���� ������ �����´�.

--
select *
from employees
where salary between 15000 and 25000;


--�޿��� 10000������ ������� �ٹ��ϴ� �μ����� �Է��ϼ���
select distinct department_id
from employees
where salary <= 10000;

SELECT DEPARTMENT_NAME
FROM departments
WHERE department_id IN (50,40,110,30,70,10,20,60,100,80);

select DISTINCT B.DEPARTMENT_NAME
FROM EMPLOYEES A, departments B
WHERE A.DEPARTMENT_ID = b.department_id AND A.SALARY <= 10000;

--
SELECT *
FROM departments
WHERE department_name LIKE '_a%in_';

SELECT *
FROM employees
WHERE first_name LIKE '%K%';

SELECT *
FROM employees
WHERE first_name LIKE '%k%';


SELECT LAST_NAME, SALARY, HIRE_DATE, COMMISSION_PCT FROM EMPLOYEES
ORDER BY HIRE_DATE ASC, SALARY desc;

SELECT LAST_NAME, SALARY, HIRE_DATE, COMMISSION_PCT FROM EMPLOYEES
ORDER BY 2 desc,3 ASC;


select * from countries where country_id like '%'||'J'||'%';

--220728

--1. �������(Employees) ���̺��� �����ȣ, �̸�, �޿�, ����, �Ի���, ����� �����ȣ�� ���
SELECT EMPLOYEE_ID,first_name,salary,job_id,hire_date,manager_id
FROM EMPLOYEES;

--2. �������(Employees) ���̺��� ����� �̸�, ��, �޿���  ������ $100 ���ʽ��� �߰��Ͽ� ����� ���� Increased Ann_Salary, 
--   �޿��� $100 ���ʽ��� �߰��Ͽ� ����� ������ Increased Salary��� ��Ī�� �ٿ� ���
SELECT FIRST_NAME, LAST_NAME, SALARY, SALARY*12+100 AS "Increased Ann_Salary", (SALARY+100)*12 AS "Increased Salary"
FROM employees;


--3. ���� �� ������ �޿� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
--	�������(Employees) ���̺��� �޿��� $7,000~$10,000 ���� �̿��� ����� �̸��� �� �� �޿��� �޿��� ���� ������ ���
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < 7000 OR salary > 10000
ORDER BY 3 ASC;

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY Not between 7000 and 10000
ORDER BY 3 ASC;



--4. ����� ��(last_name) �߿� ��e�� �� ��o�� ���ڰ� ���Ե� ����� ��� //���� and�� ����
SELECT *
FROM EMPLOYEES
WHERE last_name LIKE '%e%' and last_name like '%o%';


--5. �޿�(salary)�� ������(commission_pct)�� ���� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
--   ������ �޴�(null�� �ƴ�) ��� ����� �̸��� ��, �޿�, ����, �������� ����Ͻÿ�. 
--   �̶� �޿��� ū ������� �����ϵ�, �޿��� ������ �������� ū ������� ����
select first_name, last_name, salary, job_id, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--function
Select 1+1
from dual;

select sum(salary) from employees;

select salary, sum(salary) from employees;
--ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
--00937. 00000 -  "not a single-group group function"
-- SELECT�� ������� �ϼ��� �簢�� ����� ���� �ؾ� ��

select count(employee_id) from employees; --107��
select count(commission_pct) from employees; --35��
--null���� �����ϰ� ī��Ʈ�ϱ⶧���� ���� �ٸ�

--avg()
select sum(commission_pct) from employees; -- 7.8
select avg(commission_pct) from employees; -- 0.22 
--��������غ���
select sum(commission_pct)/count(employee_id) from employees; --0.07
--avg�� ���� �͵� ������ ����Ѵ�
--�ڿ� ���� null�� ����� ������ ���� ����� �� �ִ�.
select avg(nvl(commission_pct,0)) from employees;


--max,min
select max(salary) from employees;
select min(salary) from employees;

--���ڵ� max , min ����������?
select max(last_name) from employees;
select min(last_name) from employees;

select sum(salary), avg(salary), max(salary), count(salary)
from employees;

--����� ������ ����ϴµ� �޿��� ��� �޿����� ���� �޴� ������� ����ϼ���
select *
from employees
where salary > avg(salary);
--�����߻�
--ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�
--00934. 00000 -  "group function is not allowed here"
--�׷��Լ��� where���� ����� �� ����.

select *
from employees
where salary > 6461.831775700934579439252336448598130841;
--���� �������..


-------------------------------------------------------------
--group by
select department_id, count(*)
from employees
group by department_id;

--having
--where�� ��� ���� ������ �ְ�
--having�� �׷��� ������ �ش�.
select department_id, sum(salary), avg(salary)
from employees
group by department_id
having avg(salary) > 10000;

--�Ѹ��� �Ŵ����� ����� ���������� �ִ���
select manager_id, count(*)
from employees
group by manager_id;

-- ������� ������(job_id) ��ü �޿� ����� 10000�޷����� ū ��츦 ��ȸ
-- ������ �޿������ ����ϼ���.
-- ��, ������ clerk �� ���Ե� ���� �����ϰ� ����ϴµ�
--�޿������ ���� ������� ����ϼ���.
select job_id, avg(salary)
from employees
where job_id not like '%CLERK%'
group by job_id
having avg(salary) >10000
order by avg(salary) desc;

--�����Լ�
--����
select abs(-10) from dual;
select floor(3.94) from dual;
select Round(3.94,1) from dual;
select round(62462, -2) from dual;
select trunc(3.14, 1) from dual;

--����
select length('�ѱ�')from dual;
select lengthb('HELLO')from dual;
select lengthb('��')from dual;

select substr('abc', 1,1) from dual;

select rpad('abc',8,'#') from dual;
select lpad('abc',8,'#') from dual;

-- ID : hello �� ���̵� ã�⸦ �ߴ�
-- he***�� ���� ���ü� �ְ� �غ��ƶ�
select rpad(substr('hello',1,2),length('hello'),'*') from dual;



--��¥
select SYSDATE-1, SYSDATE, SYSDATE+1, sysdate+4 from dual; 
-- +1���ϸ� ���� �Ϸ� ���Ѵ�.
-- �����޷� �� �Ѿ��.

-- �������� �Ի��� 3������ ���� �ӿ�ȴ� ����ض�
SELECT hire_date, ADD_MONTHS(HIRE_DATE, 3) from employees;
select next_day(sysdate, 2) from dual;
select last_day(sysdate) from dual;

select extract(minute from systimestamp) from dual;
--sysdate �� �ú��� ���� �������� �����Ƿ� ������ �� �� �ִ�.

--����ȯ �Լ�
select sysdate, to_char(sysdate, 'YYYY MM DD Day')
from dual;

--select to_char(45,'RN')
select to_char(3300000, '99,999,999')
from dual;

select to_number('10')*3 from dual;
select to_number('1,234','999,999,999')*2 from dual; --�ڹٿ����� �̰� ���� �ٲܼ� ������ ���⼭�� ���˹��ڿ����� ���� �ٲܼ��ִ�.

--select to_date('22��04��05��','YY��MM��DD��') from dual;
select to_date('22.04.05','YY.MM.DD') from dual;
select to_date('21211224 235540', 'YYYY-MM-DD HH24:MI:SS') --ĸ�� ����
from dual;

select * from regions;

--Insert 1��° ���
Insert into REgions (region_id,region_name)
values (5, 'South America');
--insert 2
insert into regions -- �÷��� �����ϰ� �ٷ� value���´�� ���̺� ������� �Է�
values (6, 'Korea');
--INSERT 3
insert into regions (region_id)
values (7); --Name�� null�� ��
--INSERT 4 ����

ROLLBACK; -- ������ Ŀ���ߴ� �������� �ǵ�����

SELECT * FROM regions;

--COMMIT
Insert into REgions (region_id,region_name)
values (5, 'South America');
insert into regions --�÷����� ������ ������ 
values (8); -- �� ���� �𸣰� ������ ����.

COMMIT;

SELECT * FROM COUNTRIES;

INSERT INTO countries (REGION_ID, COUNTRY_NAME, COUNTRY_Id)
VALUES (3, 'KOREA', 'KO');

COMMIT;

--PRIMARY KEY ��������
INSERT INTO COUNTRIES
VALUES ('KO','NORTHKOREA',3);
--ORA-00001: ���Ἲ ���� ����(HR.COUNTRY_C_ID_PK)�� ����˴ϴ�
--primary Key��� ���� ����(null�����, �ߺ������)�� �ɷ� �ֱ� ������ �ߺ� �����ʹ� �Ұ�����

INSERT INTO COUNTRIES
VALUES (NULL, 'NORTHKOREA', 3);-- ���� ����

--FOREGION KEY
INSERT INTO COUNTRIES
VALUES ('NK','NORTHKOREA', 10);
--ORA-02291: ���Ἲ ��������(HR.COUNTR_REG_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
--�����ϴ� ���̺� �ش� ���� ����־����.

INSERT INTO COUNTRIES
VALUES ('CU','CUBA', 5);

SELECT * FROM REGIONS;

Rollback;
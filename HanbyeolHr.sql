SELECT * 
FROM tab;

�ȿ� ������� �����͸� ��� �ִ�?
DESC countries; 
�̸� : �÷���

DESC departments;
DESC employees;

select * from departments;

select * from countries;

select region_name, region_id, 1+1 from regions;

select region_id, region_id, region_id*3
from regions;

select * from employees
where phone_number like '515.%';

desc employees;

-- SQL �ּ�
-- employees ���̺��� ����� �̸�, �Ի糯¥, ������ ��ȸ�غ�����.
select first_name, hire_date, salary
from employees;

--�μ���ȣ�� ��ȸ
select department_id from employees;
-- ��� �μ� ��ȣ��?
select * from departments;
-- ��� ������ �ִ� departments��?
select * from locations;

select * from employees;

select distinct department_id from employees;
--distinct�� select������ �� �ѹ��� ����� �� �ִ�.

-------------------------------------------------
--���, ��, ����, ����
select employee_id, last_name, job_id, salary
from employees;

--���, ��, ����, ����
select employee_id as "���", last_name as "��", job_id, salary*12 as "����"
from employees;
--��Ī�� ����غ��� as ��Ī�� ���� ����Ҽ� �ִ�.

--����̶� �������� Ŀ�̼�pct�� ���� �޴� ����(Ŀ�̼� ������ �״�� ������ �߰�)
select employee_id, salary, nvl(commission_pct,0) as commission, salary+(salary*nvl(commission_pct,0)) as realsalary
from employees;
--���Ͱ��� select�������� �Լ��� ����� �� �ִ�.
--(����)NVL(�÷���, null�ΰ�� ��ü��)

--���, �̸�, ����
--������ 20000�ʰ��� ����� ȣ��
select employee_id, first_name, salary
from employees
where salary > 20000;


-- last_name�� Khoo�� ����� ��� ���� ���
select *
from employees
where last_name = 'Khoo'; 
--���ڿ������� ��ҹ��ڸ� �����ϴ� �Ű澵��

--������� ��� ���� ���
--2005�� 1��1�� ���Ŀ� �Ի��� ������� ��� ����
select *
from employees
where hire_date >= '05/01/01';
--��¥���ĵ� �յڷ� Ȭ����ǥ�� �ٿ������
--�⵵�� 4�ڸ����� �Է��ص� �����ϰ� ���´�.!

--1.����� 110���� ����� ���� �μ��� �ٹ��ϴ� ������� �̸�, ������ ����ϼ���.
select department_id
from employees
where employee_id = 110;

select first_name, salary
from employees
where department_id = 100;

--2. last_name�� king�� �ٹ��ϴ� �μ��� ���
select department_id
from employees
where last_name = 'King';

select department_name
from departments
where department_id = 90 or department_id = 80;

-- ����� 102���� ����� �μ���, 
select a.employee_id, b.location_id
from employees a, departments b
where a.department_id = b.department_id and employee_id = 102;

--�μ��� �ִ� ���ø�
select city
from locations
where location_id = 1700;

--���ð� �ִ� �����
select *
from countries
where country_id = 'US';

--���� �ִ� �����
select *
from regions
where region_id = 2;

--�̷��� ���� ����Ǿ��ִ� ���̺��� '�������̺�'�̶�� �Ѵ�.


-- and
select *
from employees
where department_id = 30 or department_id = 60;

--commsion_pcp�� null�� ģ������ ����ض�
select *
from employees
where commission_pct is null;


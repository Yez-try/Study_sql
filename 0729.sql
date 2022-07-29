--07/29
-- update --
--UPDATE ���̺�� SET �������÷���1=�����Ұ�1, �������÷���2=�����Ұ�, ...             : ���̺��� ��� ROW�� ����
--UPDATE ���̺�� SET �������÷���1=�����Ұ�1, �������÷���2=�����Ұ�, ... WHERE ���ǽ� : Ư���� ROW ����

SELECT * FROM REGIONS;

UPDATE REGIONS SET REGION_NAME = 'Korea'; --��� ���� �ϰ� ������Ʈ �Ѵ�.
ROLLBACK;

--������ WHERE���ǽ��� �Ἥ Ư���� �ֵ鸸 ����
UPDATE REGIONS SET REGION_NAME = 'Korea' WHERE REGION_ID = 6;


UPDATE REGIONS SET REGION_NAME = 'Korea' WHERE REGION_ID = 12; --������ �ƴѵ� 0���� ������Ʈ �� ��� ���з� ����.

--COMMISSION_PCT�� NULL�̸� 0���� ������Ʈ �ض�
UPDATE EMPLOYEES SET COMMISSION_PCT = 0 WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES;

--UPDATE REGIONS SET REGION_ID=NULL WHERE REGION_ID = 6
--ORA-01407: NULL�� ("HR"."REGIONS"."REGION_ID")�� ������Ʈ�� �� �����ϴ�
UPDATE REGIONS SET REGION_ID=7 WHERE REGION_ID = 6;
ROLLBACK;

SELECT * FROM COUNTRIES;
UPDATE COUNTRIES SET COUNTRY_NAME = 'ȣ��', REGION_ID = 2 WHERE COUNTRY_ID = 'AU';

-- DELETE --
--Table�� �ִ� ROW�� ����
--DELETE ���̺��              : Table�� ��� ROW ����
--DELETE ���̺�� WHERE ���ǽ� : Ư���� ROW ����
-- (MYSQL ���� ��� FROM�� �ٴ´�.) DELETE FROM ���̺�� WHERE ���ǽ� 
SELECT * FROM TAB;

DELETE JOB_HISTORY;
SELECT * FROM JOB_HISTORY;

SELECT * FROM REGIONS;
DELETE REGIONS WHERE REGION_ID = 6;

DELETE REGIONS WHERE REGION_ID = 4;
-- ORA-02292: ���Ἲ ��������(HR.COUNTR_REG_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
-- �ش� REGION_ID�� �����ϴ� �ٸ� ���̺��� FOREIGNŰ�� �����Ƿ�

ROLLBACK;

--�����ȣ�� 110���� ����� �μ����� ��ȸ.

-- SubQuary --
-- �Ʒ��� ���� ������ ���� �� �ٸ� �������� ���� ���� subquary��� �Ѵ�.
SELECT DEPARTMENT_NAME FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 
    (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 110);

-- ����� ��� ������ ��ȸ, ��� �޿����� ���� �޴� ������� ���
SELECT * FROM EMPLOYEES
WHERE SALARY > 
    (SELECT AVG(SALARY) FROM EMPLOYEES);
    
--����� 198���� ����� �ٹ��ϴ� �μ��� ���ø��� �����̳�
SELECT CITY FROM LOCATIONS
WHERE LOCATION_ID =
    (SELECT LOCATION_ID FROM DEPARTMENTS
    WHERE DEPARTMENT_ID =
        (SELECT DEPARTMENT_ID FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 198));
        
--����� 199���� ����� �Ŵ����� �ٹ��ϴ� �μ��� �ִ� �����?
SELECT COUNTRY_NAME FROM COUNTRIES
WHERE COUNTRY_ID =
    (SELECT COUNTRY_ID FROM LOCATIONS
        WHERE LOCATION_ID =
        (SELECT LOCATION_ID FROM DEPARTMENTS
        WHERE DEPARTMENT_ID =
            (SELECT DEPARTMENT_ID FROM EMPLOYEES
            WHERE EMPLOYEE_ID =
                (SELECT MANAGER_ID FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 199))));



--����� �� �޿��� ���� ���� ����� ���� �μ��� �ٹ��ϴ� ������� ��� ����
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID = 
    (select DEPARTMENT_ID from EMPLOYEES
    WHERE SALARY = 
        (SELECT MAX(SALARY) FROM EMPLOYEES));
        
-- �޿��� ���� ���� �޴»���� ���� ���� �޴� ����� ���� �μ��� �ٹ��ϴ� ������� ��� ����
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID = 
    (select DEPARTMENT_ID from EMPLOYEES
    WHERE SALARY = 
        (SELECT MAX(SALARY) FROM EMPLOYEES)) 
or Department_id =
    (select DEPARTMENT_ID from EMPLOYEES
    WHERE SALARY = 
        (SELECT min(SALARY) FROM EMPLOYEES));
        
        
-- ������ �������� --
-- ���������� ������� �������� ���, ������� �������̱� ������ �񱳿����ڰ� �Ұ����ϴ�
-- �׷��� IN, any, all, exists ���� ����Ѵ�.

-- all(��1,��2) : and�� �ǹ� 
-- any(��1, ��2) : or�� �ǹ�
-- exists(��������) :  �� �����(��ȯ ��)�� �����մϱ�?

-- ��ձ޿����� ���� �޴� ������� �μ� ����
select * from departments
where department_id in
    (select distinct department_id from employees
    where salary > 
        (select avg(salary) from employees));
    
--seattle�̶�� ���ÿ� �ٹ��ϴ� ������� ���� ���
select * from employees
where department_id in
    (select distinct department_id from departments
    where location_id = 
        (select location_id from locations
        where city = 'Seattle'));
        
-- Join --
    -- �����ڿ� ���� ����
     -- EQUI JOIN(=) �����ͳ��� ���� (���� ���� ���)
     -- NON EQUI JOIN (>. <)
     -- CARTESIAN JOIN(CROSS JOIN) : ����� �� ��ŭ �����Ѵ�.
    
    -- ������ ���̺� ���� ����
     -- SELF JOIN : �ڱ��ڽ� ���̺�� �����ϴ� ���
    
-- ����� 100�� ����� �̸�, ����, �μ���
SELECT E.LAST_NAME, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E
    INNER JOIN
    --LEFT OUTER JOIN
    DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 178;
    
-- �����ȣ�� 192���� ����� �̸�, ��, ����, �μ���, ���ø�
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME , CITY --���̺� ��Ī�� �Ƚ��൵ ���� ���� ����ȴ�.
FROM EMPLOYEES E
    INNER JOIN
    DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN
    LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.EMPLOYEE_ID = 192;

SELECT DEPARTMENT_ID , CITY --DEPARTMENT_ID�� �����̸��� 2���̹Ƿ� ����
FROM EMPLOYEES E
    INNER JOIN
    DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN
    LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.EMPLOYEE_ID = 192;

SELECT E.LAST_NAME, E.SALARY, D.DEPARTMENT_ID
FROM EMPLOYEES E
    INNER JOIN
    DEPARTMENTS D
    USING(DEPARTMENT_ID) --ON ��� USING�� ����Ҽ� �ִ�.
    INNER JOIN
    LOCATIONS L
    USING(LOCATION_ID)
WHERE E.EMPLOYEE_ID = 192;
--USING�� ���� �ߺ��Ǵ� ���� �ϳ��� ��������.
--JOIN�ϴ� ������ �ϳ��� �������� ������ ON�� ���� ���̺� ������ ���� �ʴ´�.
    
SELECT *
FROM EMPLOYEES NATURAL JOIN DEPARTMENTS;
--���߿� ������̶� �ٽú���� ����

--SELF JOIN ����� 192���� ����� �̸�, ����, �Ŵ����� �̸�, ����(JOIN����, ����������)
SELECT A.FIRST_NAME, A.SALARY, b.first_name AS "M_NAME", B.SALARY "M_SALARY"
FROM EMPLOYEES A INNER JOIN
    EMPLOYEES B
    ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE A.EMPLOYEE_ID = 192;

SELECT A.FIRST_NAME, A.SALARY, b.first_name AS "M_NAME", B.SALARY "M_SALARY"
FROM EMPLOYEES A INNER JOIN
    EMPLOYEES B
    ON A.MANAGER_ID = B.EMPLOYEE_ID AND A.EMPLOYEE_ID = 192; --�̷������� AND ������ ��뵵 �����ϴ�

--���������� �̿��ؼ�!
SELECT FIRST_NAME, SALARY, 
    (SELECT FIRST_NAME
    FROM employees
    WHERE EMPLOYEE_ID = 
    (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 192)) AS "MNAME",
    (SELECT SALARY
    FROM employees
    WHERE EMPLOYEE_ID = 
    (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 192)) AS "MSALARY"
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 192;

-- 178���� INNER JOIN�ϸ� ��ȸ�� �ȵ�
-- DEPARTMENT_ID�� NULL�̹Ƿ� DEPARTMENTS���� ��Ī�Ǵ� �����Ͱ� ���� ������
-- �� ��쿡�� ���� �� ���̺� ������ ���� -> �������̹Ƿ� LEFT OUTER JOIN�� ���ش�.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID
FROM EMPLOYEES E
    LEFT OUTER JOIN
    DEPARTMENTS D
    ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
ORDER BY EMPLOYEE_ID DESC;

SELECT *
FROM DEPARTMENTS;

INSERT INTO DEPARTMENTS(DEPARTMENT_NAME, LOCATION_ID)
VALUES (TESTNAME, 2400);


```sql ����
1. ����� 198�� ����� �ٹ��ϴ� �μ��� �ִ� ���ð� ���� �ִ� ���� �ִ� ��� ����

2. LAST_NAME�� Khoo �� ����� �ٹ��ϴ� �μ���

3. �����ȣ�� 199���� ����� �Ŵ����� �ٹ��ϴ� �μ��� �ִ� ����� ���

4. ����� �߿��� ������ ���� ���� ����� �ٹ��ϴ� ���ø�

5. �μ����� IT�� �μ��� �ٹ��ϴ� ������� ��� ���� ���

6. Employees ���̺��� LAST_NAME�� Greenberg ������� �޿��� �� ���� �ް� �ִ� ��������� ���

7. �μ��� �ּұ޿��� �ް� �ִ� ����� ���� ���

8. �����̸��� 'S'�ν����ϴ� ������ �ٹ��ϴ� ����� ���� ���	

9. ���� Austin ����� �Ŵ���(���)�� �ٹ��ϴ� �μ��� ��� �޿����� �μ������ �� ū �μ��� �̸�
```
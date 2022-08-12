--07/29
-- update --
--UPDATE 테이블명 SET 수정할컬럼명1=수정할값1, 수정할컬럼명2=수정할값, ...             : 테이블의 모든 ROW가 수정
--UPDATE 테이블명 SET 수정할컬럼명1=수정할값1, 수정할컬럼명2=수정할값, ... WHERE 조건식 : 특정한 ROW 수정

SELECT * FROM REGIONS;

UPDATE REGIONS SET REGION_NAME = 'Korea'; --모든 행을 일괄 업데이트 한다.
ROLLBACK;

--보통은 WHERE조건식을 써서 특정한 애들만 수정
UPDATE REGIONS SET REGION_NAME = 'Korea' WHERE REGION_ID = 6;


UPDATE REGIONS SET REGION_NAME = 'Korea' WHERE REGION_ID = 12; --에러는 아닌데 0개가 업데이트 된 경우 실패로 본다.

--COMMISSION_PCT가 NULL이면 0으로 업데이트 해라
UPDATE EMPLOYEES SET COMMISSION_PCT = 0 WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES;

--UPDATE REGIONS SET REGION_ID=NULL WHERE REGION_ID = 6
--ORA-01407: NULL로 ("HR"."REGIONS"."REGION_ID")을 업데이트할 수 없습니다
UPDATE REGIONS SET REGION_ID=7 WHERE REGION_ID = 6;
ROLLBACK;

SELECT * FROM COUNTRIES;
UPDATE COUNTRIES SET COUNTRY_NAME = '호주', REGION_ID = 2 WHERE COUNTRY_ID = 'AU';

-- DELETE --
--Table에 있는 ROW를 삭제
--DELETE 테이블명              : Table의 모든 ROW 삭제
--DELETE 테이블명 WHERE 조건식 : 특정한 ROW 삭제
-- (MYSQL 같은 경우 FROM이 붙는다.) DELETE FROM 테이블명 WHERE 조건식 
SELECT * FROM TAB;

DELETE JOB_HISTORY;
SELECT * FROM JOB_HISTORY;

SELECT * FROM REGIONS;
DELETE REGIONS WHERE REGION_ID = 6;

DELETE REGIONS WHERE REGION_ID = 4;
-- ORA-02292: 무결성 제약조건(HR.COUNTR_REG_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- 해당 REGION_ID를 참조하는 다른 테이블의 FOREIGN키가 있으므로

ROLLBACK;

--사원번호가 110번인 사원의 부서명을 조회.

-- SubQuary --
-- 아래와 같이 쿼리문 내에 또 다른 쿼리문을 쓰는 것을 subquary라고 한다.
SELECT DEPARTMENT_NAME FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 
    (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 110);

-- 사원의 모든 정보를 조회, 평균 급여보다 많이 받는 사원들을 계산
SELECT * FROM EMPLOYEES
WHERE SALARY > 
    (SELECT AVG(SALARY) FROM EMPLOYEES);
    
--사번이 198번인 사원이 근무하는 부서의 도시명은 무엇이냐
SELECT CITY FROM LOCATIONS
WHERE LOCATION_ID =
    (SELECT LOCATION_ID FROM DEPARTMENTS
    WHERE DEPARTMENT_ID =
        (SELECT DEPARTMENT_ID FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 198));
        
--사번이 199번인 사원의 매니저가 근무하는 부서가 있는 나라는?
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



--사원들 중 급여가 제일 많은 사원과 같은 부서에 근무하는 사원들의 모든 정보
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID = 
    (select DEPARTMENT_ID from EMPLOYEES
    WHERE SALARY = 
        (SELECT MAX(SALARY) FROM EMPLOYEES));
        
-- 급여를 제일 많이 받는사원과 제일 적게 받는 사원과 같은 부서에 근무하는 사원들의 모든 정보
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID = 
    (select DEPARTMENT_ID from EMPLOYEES
    WHERE SALARY = 
        (SELECT MAX(SALARY) FROM EMPLOYEES)) 
or Department_id =
    (select DEPARTMENT_ID from EMPLOYEES
    WHERE SALARY = 
        (SELECT min(SALARY) FROM EMPLOYEES));
        
        
-- 다중행 서브쿼리 --
-- 서브쿼리의 결과물이 여러개인 경우, 결과물이 여러개이기 때문에 비교연산자가 불가능하다
-- 그래서 IN, any, all, exists 등을 사용한다.

-- all(값1,값2) : and의 의미 
-- any(값1, 값2) : or의 의미
-- exists(서브쿼리) :  이 결과물(반환 행)이 존재합니까?

-- 평균급여보다 많이 받는 사원들의 부서 정보
select * from departments
where department_id in
    (select distinct department_id from employees
    where salary > 
        (select avg(salary) from employees));
    
--seattle이라는 도시에 근무하는 사원들의 정보 출력
select * from employees
where department_id in
    (select distinct department_id from departments
    where location_id = 
        (select location_id from locations
        where city = 'Seattle'));
        
-- Join --
    -- 연산자에 따른 구분
     -- EQUI JOIN(=) 같은것끼리 조인 (가장 많이 사용)
     -- NON EQUI JOIN (>. <)
     -- CARTESIAN JOIN(CROSS JOIN) : 경우의 수 만큼 조인한다.
    
    -- 조인할 테이블에 따른 구분
     -- SELF JOIN : 자기자신 테이블과 조인하는 경우
    
-- 사번이 100인 사원의 이름, 월급, 부서명
SELECT E.LAST_NAME, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E
    INNER JOIN
    --LEFT OUTER JOIN
    DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 178;
    
-- 사원번호가 192번인 사원의 이름, 성, 월급, 부서명, 도시명
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME , CITY --테이블 별칭을 안써줘도 문제 없이 실행된다.
FROM EMPLOYEES E
    INNER JOIN
    DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN
    LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.EMPLOYEE_ID = 192;

SELECT DEPARTMENT_ID , CITY --DEPARTMENT_ID는 같은이름이 2개이므로 에러
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
    USING(DEPARTMENT_ID) --ON 대신 USING을 사용할수 있다.
    INNER JOIN
    LOCATIONS L
    USING(LOCATION_ID)
WHERE E.EMPLOYEE_ID = 192;
--USING을 쓰면 중복되는 열이 하나로 합쳐진다.
--JOIN하는 열명이 하나로 합쳐지기 때문에 ON과 같이 테이블 구분을 하지 않는다.
    
SELECT *
FROM EMPLOYEES NATURAL JOIN DEPARTMENTS;
--나중에 강사님이랑 다시보기로 ㅏㅁ

--SELF JOIN 사법이 192번인 사원의 이름, 월급, 매니적을 이름, 월급(JOIN으로, 서브쿼리로)
SELECT A.FIRST_NAME, A.SALARY, b.first_name AS "M_NAME", B.SALARY "M_SALARY"
FROM EMPLOYEES A INNER JOIN
    EMPLOYEES B
    ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE A.EMPLOYEE_ID = 192;

SELECT A.FIRST_NAME, A.SALARY, b.first_name AS "M_NAME", B.SALARY "M_SALARY"
FROM EMPLOYEES A INNER JOIN
    EMPLOYEES B
    ON A.MANAGER_ID = B.EMPLOYEE_ID AND A.EMPLOYEE_ID = 192; --이런식으로 AND 연산자 사용도 가능하다

--서브쿼리를 이용해서!
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

-- 178번은 INNER JOIN하면 조회가 안됨
-- DEPARTMENT_ID가 NULL이므로 DEPARTMENTS에서 매칭되는 데이터가 없기 때문에
-- 이 경우에는 먼저 쓴 테이블 순으로 왼쪽 -> 오른쪽이므로 LEFT OUTER JOIN을 써준다.
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


```sql 숙제
1. 사번이 198인 사원이 근무하는 부서가 있는 도시가 속해 있는 나라가 있는 대륙 정보

2. LAST_NAME이 Khoo 인 사람의 근무하는 부서명

3. 사원번호가 199번인 사원의 매니저가 근무하는 부서가 있는 나라명 출력

4. 사원들 중에서 월급이 가장 적은 사원이 근무하는 도시명

5. 부서명이 IT인 부서에 근무하는 사원들의 모든 정보 출력

6. Employees 테이블에서 LAST_NAME이 Greenberg 사원보다 급여를 더 많이 받고 있는 사원들정보 출력

7. 부서별 최소급여를 받고 있는 사원의 정보 출력

8. 도시이름이 'S'로시작하는 지역에 근무하는 사원의 정보 출력	

9. 성이 Austin 사원의 매니저(상사)가 근무하는 부서의 평균 급여보다 부서평균이 더 큰 부서의 이름
```
select * from employees;
--1. 사번이 198인 사원이 근무하는 부서가 있는 도시가 속해 있는 나라가 있는 대륙 정보
select region_name from regions
where region_id = (
        select region_id from countries
        where country_id = (
            select country_id from locations
            where location_id = (
                select location_id from departments
                where department_id = (
                    select department_id from employees
                    where employee_id = 198))));
                    
                    
                    
--2. LAST_NAME이 Khoo 인 사람의 근무하는 부서명
select department_name from departments
where department_id = (
    select department_id from employees
    where last_name = 'Khoo');
    
    
--3. 사원번호가 199번인 사원의 매니저가 근무하는 부서가 있는 나라명 출력
select country_name from countries
where country_id = (
    select country_id from locations
    where location_id = (
        select location_id from departments
        where department_id = (
            select department_id from employees
            where employee_id = 199)));
                    
--4. 사원들 중에서 월급이 가장 적은 사원이 근무하는 도시명
select city from locations
where location_id = (
    select location_id from departments
    where department_id = (
        select department_id from employees
        where salary = (
            select min(salary) from employees)));


--5. 부서명이 IT인 부서에 근무하는 사원들의 모든 정보 출력
select * from employees
where department_id = (
    select department_id from departments
    where department_name = 'IT');
    
--6. Employees 테이블에서 LAST_NAME이 Greenberg 사원보다 급여를 더 많이 받고 있는 사원들정보 출력
select * from employees
where salary > (
    select salary from employees
    where last_name = 'Greenberg');
    
    
--7. 부서별 최소급여를 받고 있는 사원의 정보 출력
SELECT * FROM EMPLOYEES WHERE 
    (JOB_ID,SALARY) IN 
    (SELECT  JOB_ID, MIN(SALARY) FROM EMPLOYEES GROUP BY JOB_ID)
ORDER BY JOB_ID;
    
SELECT * FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN
(select department_id,min(salary) from employees
group by department_iD);

SELECT *
FROM employees
WHERE salary IN
    (SELECT MIN(salary) FROM employees GROUP BY department_id);

--8. 도시이름이 'S'로시작하는 지역에 근무하는 사원의 정보 출력	
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID FROM DEPARTMENTS
    WHERE LOCATION_ID IN (
        SELECT LOCATION_ID FROM LOCATIONS
        WHERE CITY LIKE 'S%'));
    


--9. 성이 Austin 사원의 매니저(상사)가 근무하는 부서의 평균 급여보다 부서평균이 더 큰 부서의 이름
select department_name from departments
where department_id in
(select department_id from employees
group by department_id
having avg(salary) >     
    (select avg(salary) from employees
    where department_id = 
        (select department_id from employees
        where employee_id = 
            (SELECT manager_id FROM EMPLOYEES
            WHERE LAST_NAME = 'Austin'))));


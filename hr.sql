SELECT *
FROM tab;--TAB는 테이블이라는 뜻

SELECT *
FROM EMPLOYEES;

--
SELECT  *
FROM EMPLOYEES
WHERE commission_pct IS NOT NULL;
--실행순서
--comission_pct테이블에 가서 한개의 row씩 검사를 한다.
--해당row가 where조건에 맞는지 확인후 맞으면 가져온다.

--
select *
from employees
where salary between 15000 and 25000;


--급여가 10000이하의 사원들이 근무하는 부서명을 입력하세요
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

--1. 사원정보(Employees) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력
SELECT EMPLOYEE_ID,first_name,salary,job_id,hire_date,manager_id
FROM EMPLOYEES;

--2. 사원정보(Employees) 테이블에서 사원의 이름, 성, 급여와  연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 
--   급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭을 붙여 출력
SELECT FIRST_NAME, LAST_NAME, SALARY, SALARY*12+100 AS "Increased Ann_Salary", (SALARY+100)*12 AS "Increased Salary"
FROM employees;


--3. 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
--	사원정보(Employees) 테이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 이름과 성 및 급여를 급여가 적은 순서로 출력
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < 7000 OR salary > 10000
ORDER BY 3 ASC;

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY Not between 7000 and 10000
ORDER BY 3 ASC;



--4. 사원의 성(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력 //및은 and를 뜻함
SELECT *
FROM EMPLOYEES
WHERE last_name LIKE '%e%' and last_name like '%o%';


--5. 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
--   수당을 받는(null이 아닌) 모든 사원의 이름과 성, 급여, 업무, 수당율을 출력하시오. 
--   이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬
select first_name, last_name, salary, job_id, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--function
Select 1+1
from dual;

select sum(salary) from employees;

select salary, sum(salary) from employees;
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
-- SELECT의 결과물은 완성된 사각형 모양을 유지 해야 함

select count(employee_id) from employees; --107개
select count(commission_pct) from employees; --35개
--null값을 제외하고 카운트하기때문에 값이 다름

--avg()
select sum(commission_pct) from employees; -- 7.8
select avg(commission_pct) from employees; -- 0.22 
--수동계산해보자
select sum(commission_pct)/count(employee_id) from employees; --0.07
--avg는 널인 것도 포함해 계산한다
--뒤에 배우는 null을 사용해 다음과 같이 계산할 수 있다.
select avg(nvl(commission_pct,0)) from employees;


--max,min
select max(salary) from employees;
select min(salary) from employees;

--글자도 max , min 쓸수있을까?
select max(last_name) from employees;
select min(last_name) from employees;

select sum(salary), avg(salary), max(salary), count(salary)
from employees;

--사원의 정보를 출력하는데 급여가 평균 급여보다 많이 받는 사람들을 출력하세요
select *
from employees
where salary > avg(salary);
--에러발생
--ORA-00934: 그룹 함수는 허가되지 않습니다
--00934. 00000 -  "group function is not allowed here"
--그룹함수는 where절에 사용할 수 없다.

select *
from employees
where salary > 6461.831775700934579439252336448598130841;
--좀더 배워야함..


-------------------------------------------------------------
--group by
select department_id, count(*)
from employees
group by department_id;

--having
--where는 모든 행의 조건을 주고
--having은 그룹의 조건을 준다.
select department_id, sum(salary), avg(salary)
from employees
group by department_id
having avg(salary) > 10000;

--한명의 매니저에 몇명의 부하직원이 있는지
select manager_id, count(*)
from employees
group by manager_id;

-- 사원들의 업무별(job_id) 전체 급여 평균이 10000달러보다 큰 경우를 조회
-- 업무별 급여평균을 출력하세요.
-- 단, 업무에 clerk 이 포함된 경우는 제외하고 출력하는데
--급여평균이 높은 순서대로 출력하세요.
select job_id, avg(salary)
from employees
where job_id not like '%CLERK%'
group by job_id
having avg(salary) >10000
order by avg(salary) desc;

--단일함수
--숫자
select abs(-10) from dual;
select floor(3.94) from dual;
select Round(3.94,1) from dual;
select round(62462, -2) from dual;
select trunc(3.14, 1) from dual;

--문자
select length('한글')from dual;
select lengthb('HELLO')from dual;
select lengthb('가')from dual;

select substr('abc', 1,1) from dual;

select rpad('abc',8,'#') from dual;
select lpad('abc',8,'#') from dual;

-- ID : hello 를 아이디 찾기를 했다
-- he***와 같이 나올수 있게 해보아라
select rpad(substr('hello',1,2),length('hello'),'*') from dual;



--날짜
select SYSDATE-1, SYSDATE, SYSDATE+1, sysdate+4 from dual; 
-- +1을하면 일을 하루 더한다.
-- 다음달로 잘 넘어간다.

-- 인턴으로 입사후 3개월뒤 정식 임용된다 계산해라
SELECT hire_date, ADD_MONTHS(HIRE_DATE, 3) from employees;
select next_day(sysdate, 2) from dual;
select last_day(sysdate) from dual;

select extract(minute from systimestamp) from dual;
--sysdate 는 시분초 값을 가져오지 않으므로 에러가 날 수 있다.

--형변환 함수
select sysdate, to_char(sysdate, 'YYYY MM DD Day')
from dual;

--select to_char(45,'RN')
select to_char(3300000, '99,999,999')
from dual;

select to_number('10')*3 from dual;
select to_number('1,234','999,999,999')*2 from dual; --자바에서는 이걸 쉽게 바꿀수 없지만 여기서는 포맷문자열으로 쉽게 바꿀수있다.

--select to_date('22년04월05일','YY년MM월DD일') from dual;
select to_date('22.04.05','YY.MM.DD') from dual;
select to_date('21211224 235540', 'YYYY-MM-DD HH24:MI:SS') --캡쳐 참고
from dual;

select * from regions;

--Insert 1번째 방법
Insert into REgions (region_id,region_name)
values (5, 'South America');
--insert 2
insert into regions -- 컬럼명 생략하고 바로 value쓰는대신 테이블 순서대로 입력
values (6, 'Korea');
--INSERT 3
insert into regions (region_id)
values (7); --Name에 null이 들어감
--INSERT 4 에러

ROLLBACK; -- 이전에 커밋했던 시점까지 되돌린다

SELECT * FROM regions;

--COMMIT
Insert into REgions (region_id,region_name)
values (5, 'South America');
insert into regions --컬럼명을 써주지 않으면 
values (8); -- 들어갈 곳을 모르고 에러가 난다.

COMMIT;

SELECT * FROM COUNTRIES;

INSERT INTO countries (REGION_ID, COUNTRY_NAME, COUNTRY_Id)
VALUES (3, 'KOREA', 'KO');

COMMIT;

--PRIMARY KEY 제약조건
INSERT INTO COUNTRIES
VALUES ('KO','NORTHKOREA',3);
--ORA-00001: 무결성 제약 조건(HR.COUNTRY_C_ID_PK)에 위배됩니다
--primary Key라는 제약 조건(null비허용, 중복비허용)에 걸려 있기 때문에 중복 데이터는 불가능함

INSERT INTO COUNTRIES
VALUES (NULL, 'NORTHKOREA', 3);-- 역시 동일

--FOREGION KEY
INSERT INTO COUNTRIES
VALUES ('NK','NORTHKOREA', 10);
--ORA-02291: 무결성 제약조건(HR.COUNTR_REG_FK)이 위배되었습니다- 부모 키가 없습니다
--참조하는 테이블에 해당 값이 들어있어야함.

INSERT INTO COUNTRIES
VALUES ('CU','CUBA', 5);

SELECT * FROM REGIONS;

Rollback;
SELECT * 
FROM tab;

안에 어떤유형의 데이터를 담고 있니?
DESC countries; 
이름 : 컬럼명

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

-- SQL 주석
-- employees 테이블의 사원의 이름, 입사날짜, 월급을 조회해보세요.
select first_name, hire_date, salary
from employees;

--부서번호를 조회
select department_id from employees;
-- 어디 부서 번호지?
select * from departments;
-- 어디 지역에 있는 departments지?
select * from locations;

select * from employees;

select distinct department_id from employees;
--distinct는 select문에서 딱 한번만 사용할 수 있다.

-------------------------------------------------
--사번, 성, 직종, 월급
select employee_id, last_name, job_id, salary
from employees;

--사번, 성, 직종, 연봉
select employee_id as "사번", last_name as "성", job_id, salary*12 as "연봉"
from employees;
--별칭을 사용해보자 as 별칭과 같이 사용할수 있다.

--사번이랑 샐러리랑 커미션pct랑 실제 받는 월급(커미션 없으면 그대로 있으면 추가)
select employee_id, salary, nvl(commission_pct,0) as commission, salary+(salary*nvl(commission_pct,0)) as realsalary
from employees;
--위와같이 select문에서는 함수도 사용할 수 있다.
--(참고)NVL(컬럼명, null인경우 대체값)

--사번, 이름, 월급
--월급이 20000초과인 사원만 호출
select employee_id, first_name, salary
from employees
where salary > 20000;


-- last_name이 Khoo인 사람의 모든 정보 출력
select *
from employees
where last_name = 'Khoo'; 
--문자열에서는 대소문자를 구분하니 신경쓸것

--사원들의 모든 정보 출력
--2005년 1월1일 이후에 입사한 사람들의 모든 정보
select *
from employees
where hire_date >= '05/01/01';
--날짜형식도 앞뒤로 홑따옴표를 붙여줘야함
--년도를 4자리수로 입력해도 동일하게 나온다.!

--1.사번이 110번인 사원과 같은 부서에 근무하는 사원들의 이름, 월급을 출력하세요.
select department_id
from employees
where employee_id = 110;

select first_name, salary
from employees
where department_id = 100;

--2. last_name이 king이 근무하는 부서명 출력
select department_id
from employees
where last_name = 'King';

select department_name
from departments
where department_id = 90 or department_id = 80;

-- 사번이 102번인 사원의 부서명, 
select a.employee_id, b.location_id
from employees a, departments b
where a.department_id = b.department_id and employee_id = 102;

--부서가 있는 도시명
select city
from locations
where location_id = 1700;

--도시가 있는 나라명
select *
from countries
where country_id = 'US';

--나라가 있는 대륙명
select *
from regions
where region_id = 2;

--이렇게 서로 연결되어있는 테이블을 '연결테이블'이라고 한다.


-- and
select *
from employees
where department_id = 30 or department_id = 60;

--commsion_pcp가 null인 친구들을 출력해라
select *
from employees
where commission_pct is null;


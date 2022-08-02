-- DDL --

--제약조건 조회
 -- 모든 제약 조건 조회
SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'REGIONS';

--테이블 생성하기
-- 회원테이블 생성
CREATE TABLE MEMBER (
    ID VARCHAR2(20), --아이디는 최대 영어로 10글자까지
    PW VARCHAR2(20) , -- 비번도 최대 10글자
    NAME VARCHAR2(100), -- 이름
    PHONE VARCHAR2(20), --010를 숫자 10으로 저장하기 때문에 문제 있을 수 있음 OR 앞에 0 이 입력된 경우 8진수로 인식하는 경우도 있음. OR '-'기호를 빼기 연산해버리는 경우가 있음
    AGE NUMBER(3) -- 999까지 들어감
    );
    
SELECT * FROM MEMBER;
DESC MEMBER;

INSERT INTO MEMBER (id,pw,name,phone,age)
values ('ewlia', 'yeji1202', '심예지','010-7537-8627', 20);

insert into member
values ('smile2434', 'hoell5533', '손오공', '010-3346-4672' ,186);

-- POINT TABLE 생성
-- 이름, 번호, 국어, 영어, 수학, 총점, 평균(소숫점 2자리)
CREATE TABLE POINT (
    NAME VARCHAR2(100),
    NUM NUMBER(2),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOTAL NUMBER(3),
    AVG NUMBER(5,2)
    );
    
SELECT * FROM TAB;
SELECT * FROM POINT;

INSERT INTO POINT (NAME, NUM, KOR, ENG, MATH, TOTAL, AVG)
VALUES ('심예지', 1, 100,100,100,300,100);

ROLLBACK;
INSERT INTO POINT (NAME, NUM, KOR, ENG, MATH, TOTAL, AVG)
VALUES
('홍길똥', 2, 0,0,100,100,33.33);

-- 멤버 테이블 삭제
DROP TABLE MEMBER;
SELECT * FROM TAB; --멤버테이블은 삭제됐는데, BIN$RxHG4xodSg+MyagB82jljQ==$0 테이블이 생겼다... 휴지통으로 간거얌


-- 제약조건 걸기 --

-- 이렇게 만드는 건 추천하지 않는다. (왜냐면 시스템이 자동으로 제약조건 이름 만든다.)
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --아이디
    PW VARCHAR2(20) NOT NULL, -- 비번
    NAME VARCHAR2(100), -- 이름
    PHONE VARCHAR2(20) , --UNIQUE, NOTNULL 이렇게 두개는 안들어감
    AGE NUMBER(3) -- 999까지 들어감
    );

-- ORA-00001: 무결성 제약 조건(HR.SYS_C007334)에 위배됩니다
-- 어떤 제약조건 위반인지 알수 없음(USER_CONSTRAINTS)를 확인해야함

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER';


--제약 조건 이름 : 테이블명_컬럼명_제약조건약어 (회사마다 다를수있음)
-- 컬럼레벨 방식 : 제약조건을 컬럼명 바로 옆에 붙여쓰는 방식
-- NOT NULL은 컬럼레벨 방식으로만 제약조건을 줄수있다.
-- 한계 : 제약조건 한번에 한개만 가능
CREATE TABLE MEMBER (
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY, --아이디
    PW VARCHAR2(20) CONSTRAINT MEMBER_PW_NN NOT NULL, -- 비번
    NAME VARCHAR2(100) DEFAULT 'NAME' ,-- 이름 --NULL이 들어온 경우 기본값을 넣어주려고 함
    PHONE VARCHAR2(20) CONSTRAINT MEMBER_PHONE_U UNIQUE, --UNIQUE, NOTNULL 이렇게 두개는 안들어감
    AGE NUMBER(3) CONSTRAINT MEMBER_NUMBER_C CHECK (AGE BETWEEN 0 AND 120) -- -값부터 999까지 가능한데 , 0살부터 120살까지만 가능하게 하세요
    );
    
INSERT INTO MEMBER (id,pw,name,phone,age)
values ('SIMYJ', 'yeji1202', '심예지','010-7532-8627', 20);

--직접 널을 넣으면 NULL이 들어간다!.
--insert into member (id,PW, NAME, phone,age)
--values ('smile2434','3LWLK434', NULL, '010-3346-4672' , 35); 
    
insert into member (id,PW, phone,age)
values ('smile2434','3LWLK434', '010-3346-4672' , 35);

SELECT * FROM MEMBER;
    
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER';

DROP TABLE MEMBER;


-- 테이블레벨 방식 : 선언을 다 한 후에 테이블 아래에 붙여쓰는 방식
-- 이방식으로는 NOT NULL, default제약조건을 줄 수 없다.
CREATE TABLE MEMBER (
    ID VARCHAR2(20) , --아이디
    PW VARCHAR2(20) , -- 비번
    NAME VARCHAR2(100) ,-- 이름 --NULL이 들어온 경우 기본값을 넣어주려고 함
    PHONE VARCHAR2(20), --UNIQUE, NOTNULL 이렇게 두개는 안들어감
    AGE NUMBER(3),  -- -값부터 999까지 가능한데 , 0살부터 120살까지만 가능하게 하세요
    constraint member_id_pk primary key (ID),
    constraint member_phone_u unique (phone),
    constraint member_age_c check (age between 0 and 120)
    );
    

-- 포인트 테이블에 제약조건을 걸어보자
 -- 포인트 테이블은 후보키가 없다. 이렇게 후보키가 없으면 개발자가 후보키를 만들어주어야 한다.
 -- 인공키 : 다른 튜플과 식별할 수 있도록 하는 키
 -- 복합키 : 두개 이상의 컬럼을 합쳐서 하나의 키로 만드는 것
DROP TABLE POINTS;
DROP TABLE MEMBER;

--아래 멤버는 학생 테이블이다.
CREATE TABLE MEMBER (
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY, --아이디
    PW VARCHAR2(20) CONSTRAINT MEMBER_PW_NN NOT NULL, -- 비번
    NAME VARCHAR2(100) DEFAULT 'NAME' ,-- 이름 --NULL이 들어온 경우 기본값을 넣어주려고 함
    PHONE VARCHAR2(20) CONSTRAINT MEMBER_PHONE_U UNIQUE, --UNIQUE, NOTNULL 이렇게 두개는 안들어감
    AGE NUMBER(3) CONSTRAINT MEMBER_NUMBER_C CHECK (AGE BETWEEN 0 AND 120) -- -값부터 999까지 가능한데 , 0살부터 120살까지만 가능하게 하세요
    );

-- foreign key
-- 외래키 :
CREATE TABLE POINTS (
    NUM NUMBER, -- 다른 튜플과 차별화하기 위해 만든 인공키
    ID VARCHAR2(20) CONSTRAINT POINTS_ID_FK REFERENCES MEMBER (ID), --MEMBER 테이블에 있는 값이 들어가야함. (POINT테이블이 MEMBER테이블을 향한다. (참조한다)) | MEMBER가 부모테이블 POINTS가 자식테이블이 된다.
    -- 컬럼명이 같으면 (ID)는 생략해도 된다.
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOTAL NUMBER(3),
    AVG NUMBER(5,2)
    );
    
INSERT INTO MEMBER (id,pw,name,phone,age)
values ('SIMYJ', 'fdlsie202909', '심예지','010-7532-8627', 20);    

select * from member;

insert into points
values(1, 'id12', 60,75, 82, 178,85.32); -- 부모에 없는 값은 입력할 수 없다.`

insert into points
values(1, 'SIMYJ', 60,75, 82, 178,85.32);

select * from points;

delete member where id = 'SIMYJ';  --자식이 있으면 지워지지 않음

INSERT INTO MEMBER (id,pw,name,phone,age)
values ('id1', 'fdlsie202909', '아디','010-7522-8173', 28);    

delete member where id = 'id1'; -- 없으면 지워짐

-- 참고
-- on delete cascade : 자식의 튜플도 같이 삭제
-- on delete set null : 자식의 attribute 에 null


-- 공지 게시판 db 만들기
CREATE TABLE NOTICE(
    idx number(8) constraint notice_idx_pk primary key,
    title varchar2(300) constraint notice_title_nn not null,
    writer varchar2(20) constraint NOTICE_WRITER_FK REFERENCES MEMBER (ID),
    contents varchar2(4000),
    RDATE date,
    click number(5) DEFAULT 0
);
DROP TABLE NOTICE;

SELECT * FROM NOTICE;

INSERT INTO NOTICE (IDX, TITLE, WRITER, CONTENTS, RDATE, CLICK)
VALUES (2, '타이틀', 'SIMYJ','내용',SYSDATE,0);

DELETE NOTICE WHERE IDX = 0;

-- 1번글의 조회수를 127로 수정
UPDATE NOTICE SET CLICK = 127 WHERE IDX = 1;

-- 테이블의 모든 ROW의 조회수를 각각 1씩 증가하도록 수정
UPDATE NOTICE SET CLICK = CLICK+1;

-- 모든 row 삭제
delete notice;
TRUNCATE table notice;

SELECT * FROM NOTICE;

--member 에서 로그인을 진행
select * from member
where id = 'abcd' and pw = 1 or 1 = 1; --pw에 '1 or 1 = 1'을 쓰면 sql injection문제가 발생할 수 있다.
select * from member
where id = ? and pw = '1 or 1 = 1'; --pw에 '1 or 1 = 1'을 쓰면 sql injection문제가 발생할 수 있다.

rollback;

select * from tab;
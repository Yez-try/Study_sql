select * from tab;

select * from bankmembers;

commit;

update board set contents = 'contents update test' where no = 0;
delete board where no = 1;

insert into board (no, title, contents, id, views, bdate)
values (1, 'title test', 'contents test', 'idhello', 0, '2022-08-01');

-- 휴지통 테이블 조회하기
select * from recyclebin;

-- 휴지통 지우기
purge recyclebin;

-- 테이블 완전 지우기
drop table points;
drop table member purge;

-- 테이블 수정 --
-- column 추가
-- 숫자가 들어갈 Level 컬럼 추가
select * from member;
ALTER TABLE MEMBER ADD (KIND NUMBER(2)); --두자리 숫자를 넣을 수 있는 KIND 컬럼을 추가해라

-- 데이터 수정
update member set kind = 1 where id = 'smile2434';
update member set kind = 2 where id = 'yeji1202';

-- 컬럼 삭제
-- name 컬럼 삭제
ALTER table member drop column name;

-- 기존 컬럼의 컬럼명 or 데이터타입 변경
-- 컬럼명 변경 --
ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 새로운컬럼명;
--멤버테이블의 kind컬럼은 role로 바꾸어라..
ALTER table member rename column kind to role;

alter table member rename column role to lv;

-- ROLE 컬럼의 데이터타입 변경 NUMBER -> VARCHAR2
-- 컬럼의 데이터타입을 변경할 때에는 변경 전에 
        -- 해당 컬럼의 데이터를 NULL로 수정(UPDATE)
		-- 같은 DataType으로 변경 할 경우는 바로 변경 가능
		-- 같은 DataType 이라도 Size가 맞지 않으면 바로 변경 불가능

ALTER TABLE MEMBER MODIFY (LV VARCHAR2(100));
UPDATE MEMBER SET LV = NULL;

-- MEMBER TABLE명을 USER이름으로 변경
RENAME MEMBER TO USERS;

select * from USERS;

update USERS set LV = 1 where id = 'smile2434';
update USERS set LV = 2 where PW = 'yeji1202';
UPDATE USERS SET LV = 3 WHERE ID = 'ewlia';
-- 제약조건 수정
-- ROLE COLUMN 에 NOT NULL제약 조건 추가
ALTER TABLE USERS ADD CONSTRAINT USER_LV_NN NOT NULL (LV); -- NOT NULL은 컬럼레벨에서만 줄 수 있다.

ALTER TABLE USERS ADD CONSTRAINT USER_LV_U UNIQUE (LV);

INSERT INTO USERS VALUES('id4','pw4','010444444444',30, 'user');

-- ROLE컬럼에 UNIQUE 제약조건 삭제
alter table userS drop constraint USER_LV_U;

INSERT INTO USERS VALUES('id5','pw5','010555555',30, 'user');
SELECT * FROM USERS;

SELECT * FROM USER_CONSTRAINTS;


-- 시퀀스
CREATE SEQUENCE TEST_SEQ --시퀀스 만들때는 뒤에 SEQ를 붙여서 꼭 알려준다.
INCREMENT BY 1 -- 안써도 1이 디폴트 (1씩 증가)
START WITH 1 -- 디폴트
NOMAXVALUE -- 디폴트
NOCYCLE -- 디폴트
NOCACHE; -- 디폴트

-- 시퀀스 목록 보기
SELECT * FROM SEQ;

-- SEQUENCE 사용 
 -- NEXTVAL : 새로운 시퀀스값을 주세요
SELECT TEST_SEQ.NEXTVAL FROM DUAL;
INSERT INTO USERS VALUES('i6','pw6','0106666666666',TEST_SEQ.NEXTVAL, 'user');
INSERT INTO USERS VALUES('iD7','pw7','0167776666666',TEST_SEQ.NEXTVAL, 'user');
INSERT INTO USERS VALUES('iD8','pw8','010886666666',TEST_SEQ.NEXTVAL, 'user');

SELECT * FROM USERS;

 --CURRVAL : 단독 사용불가, 같은 쿼리내에 사용가능함
 SELECT TEST_SEQ.CURRVAL FROM DUAL; -- 최근에 NEXTVAL한 결과물을 가져와라
 
 --SEQUENCE 수정 
  -- START WITH 수정 불가
  -- 시퀀스를 생성하고 한번도 사용하지 않은 경우 수정 불가

 -- 삭제 
 DROP SEQUENCE TEST_SEQ;


-- TCL --
CREATE TABLE NOTICE(
    idx number(8) constraint notice_idx_pk primary key,
    title varchar2(300) constraint notice_title_nn not null,
    writer varchar2(20) ,
    contents varchar2(4000),
    RDATE date,
    click number(5) DEFAULT 0
);


SELECT * FROM USERS;
SELECT * FROM NOTICE;

-- 트랜젝션 한 단위 만들기
-- 시작
INSERT INTO USERS VALUES('iD10','pw10','0108866688899',50, 'user');
INSERT INTO NOTICE 
VALUES(1, 'T1','W1','C1',SYSDATE, 0);
-- 끝
ROLLBACK;
 --SQL에서는 두개의 문장을 완료하고 문제 없는 경우 COMMIT을 해주면 되지만
 --자바는 한개의 문장을 실행하면 바로 COMMIT하므로 문제가 생겼을 때 ROLLBACK;할 수 없다.
 
---------------------------------------------
SELECT * FROM TAB;

DROP TABLE USERS;
DROP TABLE NOTICE;
DROP TABLE TEMP;
PURGE RECYCLEBIN;



-------------------------------------------
-- BANK DB 만들기
-- 회원DB 만들기
CREATE TABLE BANKMEMBERS (
    ID VARCHAR2(50) CONSTRAINT BANKMEMBERS_ID_PK PRIMARY KEY,
    PW VARCHAR2(50) CONSTRAINT BANKMEMBERS_PW_NN NOT NULL,
    NAME VARCHAR2(20) CONSTRAINT BANKMEMBERS_NAME_NN NOT NULL,
    EMAIL VARCHAR2(100) CONSTRAINT BANKMEMBERS_EMAIL_NN NOT NULL,
    PHONE VARCHAR2(20) CONSTRAINT BANKMEMBERS_PHONE_NN NOT NULL,
    LV VARCHAR2(20) CONSTRAINT BANKMEMBERS_LV NOT NULL,
    CONSTRAINT BANKMEMBERS_EMAIL_U UNIQUE (EMAIL),
    CONSTRAINT BANKMEMBERS_PHONE_U UNIQUE (PHONE)
    );
    
SELECT * FROM BANKMEMBERS;

INSERT INTO BANKMEMBERS
VALUES ('EWLIA','TOEYSLKD30930','걍회원','EWILA@NAVER.COM','010-7863-8215','NORMAL');
INSERT INTO BANKMEMBERS
VALUES ('SYSTEM','SYSSYS333','관리자','SYSBANK87555@GOOGLE.COM','010-5675-2244','MANAGER');
INSERT INTO BANKMEMBERS
VALUES ('ID123','DLDIWL2345','일회원','LETS6363@HANMAIL.COM','010-7888-3553','NORMAL');


-- 통장리스트DB만들기 --
CREATE TABLE ACCOUNTLIST (
    ACID NUMBER(10) CONSTRAINT ACCOUNTLIST_ACID_PK PRIMARY KEY,
    ACNAME VARCHAR(200) CONSTRAINT ACCOUNTLIST_ACNAME_NN NOT NULL,
    ACRATE NUMBER(4,2) DEFAULT 0,
    ACSALE NUMBER(1) DEFAULT 0);
    
    
CREATE SEQUENCE ACID_SEQ
INCREMENT BY 100
START WITH 100;


INSERT INTO ACCOUNTLIST
VALUES (ACID_SEQ.NEXTVAL, '기본통장', 0, 1);
INSERT INTO ACCOUNTLIST
VALUES (ACID_SEQ.NEXTVAL, '적금통장', 2.5, 1);

-- default테스트
INSERT INTO ACCOUNTLIST
VALUES (ACID_SEQ.NEXTVAL, '막만든통장',null,null);
INSERT INTO ACCOUNTLIST (acid, acname)
VALUES (ACID_SEQ.NEXTVAL, '다시막만든통장');

SELECT * FROM ACCOUNTLIST;


-- 통장계좌정보 만들기 --
CREATE TABLE ACCOUNTS (
    ACNUM NUMBER(15) CONSTRAINT ACCOUNTS_ACNUM_PK PRIMARY KEY,
    ID VARCHAR2(50) CONSTRAINT ACCOUNTS_ID_FK REFERENCES BANKMEMBERS , --ON DELETE CASCADE --부모가 삭제될때 자식테이블도 함께 삭제
    ACID NUMBER(10) CONSTRAINT ACCOUNTS_ACID_FK REFERENCES ACCOUNTLIST, --ON DELETE SET NULL --자식 컬럼에 null
    ACDATE DATE CONSTRAINT ACCOUNTS_ACDATE_NN NOT NULL);
    
INSERT INTO ACCOUNTS
VALUES ( 200||802||1000 , 'ID123', 200, SYSDATE);
-- VALUES ( 200||0802||0000 , 'ID123', 200, SYSDATE); --숫자이므로 앞 0이 사라진다
INSERT INTO ACCOUNTS
VALUES ( 200||802||1001 , 'EWLIA', 200, SYSDATE);
-- VALUES ( 200||0802||0001 , 'EWLIA', 200, SYSDATE);

--references 테스트
INSERT INTO ACCOUNTS
VALUES ( 200||802||1002 , 'E2356', 200, SYSDATE);


SELECT * FROM ACCOUNTS;


-- 거래내역 만들기 --
CREATE TABLE BANKTRADE (
    TNUM NUMBER CONSTRAINT BANKTRADE_TNUM_PK PRIMARY KEY,
    ACNUM NUMBER(15) CONSTRAINT BANKTRADE_TNUM_FK REFERENCES ACCOUNTS (ACNUM),
    IO NUMBER(1) CONSTRAINT BANKTRADE_IO_NN NOT NULL, --IN은 1, OUT은 0
    TAMOUNT NUMBER CONSTRAINT BANKTRADE_TAMOUNT_NN NOT NULL,
    TBALANCE NUMBER CONSTRAINT BANKTRADE_TBALANCE_NN NOT NULL,
    TDATE DATE DEFAULT SYSDATE,
    MEMO VARCHAR2(20)
    );
    alter table banktrade add constraint banktrade_io_chk check (io in (1,0));
    

 
CREATE SEQUENCE TRADE_SEQ;

INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021001, 1, 10, 10, '계좌생성');

INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021000, 1, 10, 10, '계좌생성');
    
INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021001, 1, 1000, 
(select * from (SELECT tbalance FROM BANKTRADE where acnum = 2008021001 order by tnum desc) where rownum = 1) 
+ 1000
, '1000원입금');
INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021001, 0, 1000, 
(select * from (SELECT tbalance FROM BANKTRADE where acnum = 2008021001 order by tnum desc) where rownum = 1) 
- 1000
, '1000원출금');


INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021000, , 10, 10, '계좌생성');

SELECT * FROM BANKTRADE;


ALTER TABLE USERS ADD CONSTRAINT USER_LV_NN NOT NULL (LV);

--회원탈퇴를 한다면?
--ACCOUNTS 테이블 참고

CREATE TABLE BANKBOOK (
    BOOKNUM NUMBER,
    BOOKNAME VARCHAR2(200),
    BOOKRATE NUMBER(4,2),
    BOOKSALE NUMBER(1) CHECK (BOOKSALE BETWEEN 0 AND 1),
    --제약조건
    CONSTRAINT BANKBOOK_BOOKNUM_PK PRIMARY KEY (BOOKNUM)
);

select * from bankbook;

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



CREATE TABLE BANKACCOUNT (
    ACNUM NUMBER(15) CONSTRAINT BANKACCOUNT_ACNUM_PK PRIMARY KEY,
    ID VARCHAR2(50) CONSTRAINT BANKACCOUNT_ID_FK REFERENCES BANKMEMBERS , --ON DELETE CASCADE --부모가 삭제될때 자식테이블도 함께 삭제
    BOOKNUM NUMBER CONSTRAINT BANKACCOUNT_ACID_FK REFERENCES BANKBOOK, --ON DELETE SET NULL --자식 컬럼에 null
    ACDATE DATE CONSTRAINT BANKACCOUNT_ACDATE_NN NOT NULL);

CREATE TABLE BANKTRADE (
    TRADENUM NUMBER,
    TRADEAMOUNT NUMBER,
    TRADEEBALANCE NUMBER,
    TRADEDATE DATE,
    TRADEIO NUMBER(1) CHECK (TRADEIO BETWEEN 0 AND 1),
    ACNUM NUMBER,
    --제약조건
    CONSTRAINT BANKTRADE_TRADENUM_PK PRIMARY KEY (TRADENUM),
    CONSTRAINT BANKTRADE_ACNUM_FK FOREIGN KEY (ACNUM) REFERENCES BANKACCOUNT
);

select * from bankaccount;
drop table Banktrade;
drop table accounts;
drop table accountlist;

desc bankaccount; --description 테이블명
select * from user_constraints where table_name = 'BANKACCOUNT';

select * from user_constraints;
select * from all_constraints;


insert into bankaccount 
values (ACcount_SEQ.nextval, 'idtest2', 1660195790001, sysdate);

select * from bankaccount;


CREATE SEQUENCE ACcount_SEQ;

commit;


--로그인한 사용자가 가입한 상품의 이름과 이자율 조회
select bookname, bookrate from bankbook
where booknum in
    (select booknum from bankaccount
    where id = 'rereplay')
;

-- 로그인한 사용자가 가입한 상품의 이름, 이자율, 가입날짜 조회
select bookname, bookrate, acdate
from bankaccount ba left join bankbook b
using(booknum)
where id = 'rereplay';

select ba.booknum, bookname, bookrate, acdate
from bankaccount ba left join bankbook b
on ba.booknum = b.booknum
where id = 'rereplay'
order by booknum;

desc bankmembers;

INSERT INTO BANKMEMBERS (ID, PW, NAME, EMAIL, PHONE, LV) VALUES ('id8585','pw8585','오마이','email8585@naver.com','010-8888-5555','NORMAL') ;

-- 주말 실습 문제 (게시판 만들기) --
CREATE TABLE NOTICE(
    NUM NUMBER(9) CONSTRAINT NOTICE_NO_PK PRIMARY KEY,
    TITLE VARCHAR2(200) CONSTRAINT NOTICE_TITLE_NN NOT NULL,
    CONTENTS CLOB,
    WRITER VARCHAR2(200) CONSTRAINT NOTICE_WRITER_NN NOT NULL,
    REGDATE DATE,
    HIT NUMBER(9));
    
 
CREATE TABLE QNA(
    NUM NUMBER(9) CONSTRAINT QNA_NO_PK PRIMARY KEY,
    TITLE VARCHAR2(200) CONSTRAINT QNA_TITLE_NN NOT NULL,
    CONTENTS CLOB,
    WRITER VARCHAR2(200) CONSTRAINT QNA_WRITER_NN NOT NULL,
    REGDATE DATE,
    HIT NUMBER(9),
    REF NUMBER(9),
    STEP NUMBER(9),
    DEPTH NUMBER(2)
    );
    

CREATE TABLE BANKBOOK (
    BOOKNUM NUMBER,
    BOOKNAME VARCHAR2(200),
    BOOKRATE NUMBER(4,2),
    BOOKSALE NUMBER(1) CHECK (BOOKSALE BETWEEN 0 AND 1),
    --ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
VALUES ('EWLIA','TOEYSLKD30930','ï¿½ï¿½È¸ï¿½ï¿½','EWILA@NAVER.COM','010-7863-8215','NORMAL');
INSERT INTO BANKMEMBERS
VALUES ('SYSTEM','SYSSYS333','ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½','SYSBANK87555@GOOGLE.COM','010-5675-2244','MANAGER');
INSERT INTO BANKMEMBERS
VALUES ('ID123','DLDIWL2345','ï¿½ï¿½È¸ï¿½ï¿½','LETS6363@HANMAIL.COM','010-7888-3553','NORMAL');



CREATE TABLE BANKACCOUNT (
    ACNUM NUMBER(15) CONSTRAINT BANKACCOUNT_ACNUM_PK PRIMARY KEY,
    ID VARCHAR2(50) CONSTRAINT BANKACCOUNT_ID_FK REFERENCES BANKMEMBERS , --ON DELETE CASCADE --ï¿½Î¸ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½É¶ï¿½ ï¿½Ú½ï¿½ï¿½ï¿½ï¿½Ìºï¿½ï¿? ï¿½Ô²ï¿½ ï¿½ï¿½ï¿½ï¿½
    BOOKNUM NUMBER CONSTRAINT BANKACCOUNT_ACID_FK REFERENCES BANKBOOK, --ON DELETE SET NULL --ï¿½Ú½ï¿½ ï¿½Ã·ï¿½ï¿½ï¿½ null
    ACDATE DATE CONSTRAINT BANKACCOUNT_ACDATE_NN NOT NULL);

CREATE TABLE BANKTRADE (
    TRADENUM NUMBER,
    TRADEAMOUNT NUMBER,
    TRADEEBALANCE NUMBER,
    TRADEDATE DATE,
    TRADEIO NUMBER(1) CHECK (TRADEIO BETWEEN 0 AND 1),
    ACNUM NUMBER,
    --ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
    CONSTRAINT BANKTRADE_TRADENUM_PK PRIMARY KEY (TRADENUM),
    CONSTRAINT BANKTRADE_ACNUM_FK FOREIGN KEY (ACNUM) REFERENCES BANKACCOUNT
);

select * from bankaccount;
drop table Banktrade;
drop table accounts;
drop table accountlist;

desc bankaccount; --description ï¿½ï¿½ï¿½Ìºï¿½ï¿?
select * from user_constraints where table_name = 'BANKACCOUNT';

select * from user_constraints;
select * from all_constraints;


insert into bankaccount 
values (ACcount_SEQ.nextval, 'idtest2', 1660195790001, sysdate);

select * from bankaccount;


CREATE SEQUENCE ACcount_SEQ;
CREATE SEQUENCE Board_SEQ;

commit;


--ï¿½Î±ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½Ú°ï¿? ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½Ç°ï¿½ï¿½ ï¿½Ì¸ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½È¸
select bookname, bookrate from bankbook
where booknum in
    (select booknum from bankaccount
    where id = 'rereplay')
;

-- ï¿½Î±ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½Ú°ï¿? ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½Ç°ï¿½ï¿½ ï¿½Ì¸ï¿½, ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½, ï¿½ï¿½ï¿½Ô³ï¿½Â¥ ï¿½ï¿½È¸
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

INSERT INTO BANKMEMBERS (ID, PW, NAME, EMAIL, PHONE, LV) VALUES ('id8585','pw8585','ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½','email8585@naver.com','010-8888-5555','NORMAL') ;

-- ï¿½Ö¸ï¿½ ï¿½Ç½ï¿½ ï¿½ï¿½ï¿½ï¿½ (ï¿½Ô½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿?) --
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
    
CREATE SEQUENCE BOARD_SEQ
ORDER;

CREATE TABLE NOTICEFILE(
    FILENUM NUMBER CONSTRAINT NOTICEFILE_FILENUM_PK PRIMARY KEY,
    FILENAME VARCHAR2(200) CONSTRAINT NOTICEFILE_FILENAME_NN NOT NULL,
    ORINAME VARCHAR2(200) CONSTRAINT NOTICEFILE_ORINAME_NN NOT NULL,
    NUM NUMBER CONSTRAINT NOTICEFILE_NUM_FK REFERENCES NOTICE(NUM) ON DELETE CASCADE
);

CREATE TABLE QNAFILE(
    FILENUM NUMBER CONSTRAINT QNAFILE_FILENUM_PK PRIMARY KEY,
    FILENAME VARCHAR2(200) CONSTRAINT QNAFILE_FILENAME_NN NOT NULL,
    ORINAME VARCHAR2(200) CONSTRAINT QNAFILE_ORINAME_NN NOT NULL,
    NUM NUMBER CONSTRAINT QNAFILE_NUM_FK REFERENCES QNA(NUM) ON DELETE CASCADE
);

CREATE TABLE MEMBERFILE(

FILENUM NUMBER CONSTRAINT MEMBERFILE_FILENUM_PK PRIMARY KEY,
FILENAME VARCHAR2(200) CONSTRAINT MEMBERFILE_FILENAME_NN NOT NULL,
ORINAME VARCHAR2(200) CONSTRAINT MEMBERFILE_ORINAME_NN NOT NULL,
USERNAME VARCHAR2(200) CONSTRAINT MEMERFILE_USERNAME_FK REFERENCES BANKMEMBERS(ID)
);


select * from qna;

--SELECT num, title, writer, regdate, hit, ref, step, depth 
--		FROM (
--		  select rownum rown, Q.* 
--		  from QNA Q 
--		  where <include refid="search"></include>
--		  ORDER BY REF DESC, step asc)
--		WHERE rown between ${startRow} and ${lastRow} 


-- ¹ðÅ©ºÏ´ñ±Û Å×ÀÌºí ¸¸µé±â
-- ½ÃÄö½º´Â BOARD_SEQ ½ÃÄö½º »ç¿ëÇÒ °ÍÀÓ
CREATE TABLE BB_COMMENT (
    NUM NUMBER constraint bbCom_num_PK primary key,
    BOOKNUM NUMBER constraint bbCom_booknum_FK references bankbook,
    WRITER VARCHAR2(50),
    CONTENTS VARCHAR2(4000),
    REGDATE DATE
    );
    
    
select * from BB_COMMENT;

--insert Å×½ºÆ®
--insert into bb_comment (num, booknum, writer, contents, regDate)
--values (Board_seq.nextval, 1662359624020, 0905, 'contents', sysdate);

select * from
(select rownum rn , c.* from
    (select *
    from BB_COMMENT 
    where booknum = 1662359624020
    order by num desc) c)
where rn between 1 and 5;


--delete BB_COMMENT where num = 672;
rollback;
    
    
Create table Role(
    Rolenum number constraint Role_num_pk primary key,
    Rolename Varchar2(200) constraint Role_name_nn not null
);

commit;

insert into role (rolenum, rolename)
values (board_seq.nextval, 'admin');

insert into role (rolenum, rolename)
values (board_seq.nextval, 'vip');

insert into role (rolenum, rolename)
values (board_seq.nextval, 'member');

select * from role;

Create table member_role(
    num number constraint mr_num_pk primary key,
    username constraint MR_un_FK References BankMEMBERS (ID),
    rolenum number constraint mr_rn_fk references role(rolenum));
    
commit;

select * from bankMembers;

insert into Member_role(num, username, rolenum)
values (Board_seq.nextval, '0905', 684);

select * from notice where num = 461;

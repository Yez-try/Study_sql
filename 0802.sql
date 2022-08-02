select * from tab;

-- ������ ���̺� ��ȸ�ϱ�
select * from recyclebin;

-- ������ �����
purge recyclebin;

-- ���̺� ���� �����
drop table points;
drop table member purge;

-- ���̺� ���� --
-- column �߰�
-- ���ڰ� �� Level �÷� �߰�
select * from member;
ALTER TABLE MEMBER ADD (KIND NUMBER(2)); --���ڸ� ���ڸ� ���� �� �ִ� KIND �÷��� �߰��ض�

-- ������ ����
update member set kind = 1 where id = 'smile2434';
update member set kind = 2 where id = 'yeji1202';

-- �÷� ����
-- name �÷� ����
ALTER table member drop column name;

-- ���� �÷��� �÷��� or ������Ÿ�� ����
-- �÷��� ���� --
ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO ���ο��÷���;
--������̺��� kind�÷��� role�� �ٲپ��..
ALTER table member rename column kind to role;

alter table member rename column role to lv;

-- ROLE �÷��� ������Ÿ�� ���� NUMBER -> VARCHAR2
-- �÷��� ������Ÿ���� ������ ������ ���� ���� 
        -- �ش� �÷��� �����͸� NULL�� ����(UPDATE)
		-- ���� DataType���� ���� �� ���� �ٷ� ���� ����
		-- ���� DataType �̶� Size�� ���� ������ �ٷ� ���� �Ұ���

ALTER TABLE MEMBER MODIFY (LV VARCHAR2(100));
UPDATE MEMBER SET LV = NULL;

-- MEMBER TABLE���� USER�̸����� ����
RENAME MEMBER TO USERS;

select * from USERS;

update USERS set LV = 1 where id = 'smile2434';
update USERS set LV = 2 where PW = 'yeji1202';
UPDATE USERS SET LV = 3 WHERE ID = 'ewlia';
-- �������� ����
-- ROLE COLUMN �� NOT NULL���� ���� �߰�
ALTER TABLE USERS ADD CONSTRAINT USER_LV_NN NOT NULL (LV); -- NOT NULL�� �÷����������� �� �� �ִ�.

ALTER TABLE USERS ADD CONSTRAINT USER_LV_U UNIQUE (LV);

INSERT INTO USERS VALUES('id4','pw4','010444444444',30, 'user');

-- ROLE�÷��� UNIQUE �������� ����
alter table userS drop constraint USER_LV_U;

INSERT INTO USERS VALUES('id5','pw5','010555555',30, 'user');
SELECT * FROM USERS;

SELECT * FROM USER_CONSTRAINTS;


-- ������
CREATE SEQUENCE TEST_SEQ --������ ���鶧�� �ڿ� SEQ�� �ٿ��� �� �˷��ش�.
INCREMENT BY 1 -- �Ƚᵵ 1�� ����Ʈ (1�� ����)
START WITH 1 -- ����Ʈ
NOMAXVALUE -- ����Ʈ
NOCYCLE -- ����Ʈ
NOCACHE; -- ����Ʈ

-- ������ ��� ����
SELECT * FROM SEQ;

-- SEQUENCE ��� 
 -- NEXTVAL : ���ο� ���������� �ּ���
SELECT TEST_SEQ.NEXTVAL FROM DUAL;
INSERT INTO USERS VALUES('i6','pw6','0106666666666',TEST_SEQ.NEXTVAL, 'user');
INSERT INTO USERS VALUES('iD7','pw7','0167776666666',TEST_SEQ.NEXTVAL, 'user');
INSERT INTO USERS VALUES('iD8','pw8','010886666666',TEST_SEQ.NEXTVAL, 'user');

SELECT * FROM USERS;

 --CURRVAL : �ܵ� ���Ұ�, ���� �������� ��밡����
 SELECT TEST_SEQ.CURRVAL FROM DUAL; -- �ֱٿ� NEXTVAL�� ������� �����Ͷ�
 
 --SEQUENCE ���� 
  -- START WITH ���� �Ұ�
  -- �������� �����ϰ� �ѹ��� ������� ���� ��� ���� �Ұ�

 -- ���� 
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

-- Ʈ������ �� ���� �����
-- ����
INSERT INTO USERS VALUES('iD10','pw10','0108866688899',50, 'user');
INSERT INTO NOTICE 
VALUES(1, 'T1','W1','C1',SYSDATE, 0);
-- ��
ROLLBACK;
 --SQL������ �ΰ��� ������ �Ϸ��ϰ� ���� ���� ��� COMMIT�� ���ָ� ������
 --�ڹٴ� �Ѱ��� ������ �����ϸ� �ٷ� COMMIT�ϹǷ� ������ ������ �� ROLLBACK;�� �� ����.
 
---------------------------------------------
SELECT * FROM TAB;

DROP TABLE USERS;
DROP TABLE NOTICE;
DROP TABLE TEMP;
PURGE RECYCLEBIN;



-------------------------------------------
-- BANK DB �����
-- ȸ��DB �����
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
VALUES ('EWLIA','TOEYSLKD30930','��ȸ��','EWILA@NAVER.COM','010-7863-8215','NORMAL');
INSERT INTO BANKMEMBERS
VALUES ('SYSTEM','SYSSYS333','������','SYSBANK87555@GOOGLE.COM','010-5675-2244','MANAGER');
INSERT INTO BANKMEMBERS
VALUES ('ID123','DLDIWL2345','��ȸ��','LETS6363@HANMAIL.COM','010-7888-3553','NORMAL');

-- ���帮��ƮDB����� --
CREATE TABLE ACCOUNTLIST (
    ACID NUMBER(10) CONSTRAINT ACCOUNTLIST_ACID_PK PRIMARY KEY,
    ACNAME VARCHAR(200) CONSTRAINT ACCOUNTLIST_ACNAME_NN NOT NULL,
    ACRATE NUMBER(4,2) DEFAULT 0,
    ACSALE NUMBER(1) DEFAULT 0);
    
    
CREATE SEQUENCE ACID_SEQ
INCREMENT BY 100
START WITH 100;


INSERT INTO ACCOUNTLIST
VALUES (ACID_SEQ.NEXTVAL, '�⺻����', 0, 1);
INSERT INTO ACCOUNTLIST
VALUES (ACID_SEQ.NEXTVAL, '��������', 2.5, 1);

SELECT * FROM ACCOUNTLIST;


-- ����������� ����� --
CREATE TABLE ACCOUNTS (
    ACNUM NUMBER(15) CONSTRAINT ACCOUNTS_ACNUM_PK PRIMARY KEY,
    ID VARCHAR2(50) CONSTRAINT ACCOUNTS_ID_FK REFERENCES BANKMEMBERS,
    ACID NUMBER(10) CONSTRAINT ACCOUNTS_ACID_FK REFERENCES ACCOUNTLIST,
    ACDATE DATE CONSTRAINT ACCOUNTS_ACDATE_NN NOT NULL);
    
INSERT INTO ACCOUNTS
VALUES ( 200||802||1000 , 'ID123', 200, SYSDATE);
-- VALUES ( 200||0802||0000 , 'ID123', 200, SYSDATE); --�����̹Ƿ� �� 0�� �������
INSERT INTO ACCOUNTS
VALUES ( 200||802||1001 , 'EWLIA', 200, SYSDATE);
-- VALUES ( 200||0802||0001 , 'EWLIA', 200, SYSDATE);

SELECT * FROM ACCOUNTS;

-- �ŷ����� ����� --
CREATE TABLE BANKTRADE (
    TNUM NUMBER CONSTRAINT BANKTRADE_TNUM_PK PRIMARY KEY,
    ACNUM NUMBER(15) CONSTRAINT BANKTRADE_TNUM_FK REFERENCES ACCOUNTS (ACNUM),
    IO NUMBER(1) CONSTRAINT BANKTRADE_IO_NN NOT NULL, --IN�� 1, OUT�� 0
    TAMOUNT NUMBER CONSTRAINT BANKTRADE_TAMOUNT_NN NOT NULL,
    TBALANCE NUMBER CONSTRAINT BANKTRADE_TBALANCE_NN NOT NULL,
    TDATE DATE DEFAULT SYSDATE,
    MEMO VARCHAR2(20)
    );
 
CREATE SEQUENCE TRADE_SEQ;

INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021001, 1, 10, 10, '���»���');

INSERT INTO BANKTRADE (TNUM, ACNUM, IO, TAMOUNT, TBALANCE,MEMO)
VALUES (TRADE_SEQ.NEXTVAL, 2008021000, 1, 10, 10, '���»���');
    

SELECT * FROM BANKTRADE;


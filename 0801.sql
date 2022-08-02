-- DDL --

--�������� ��ȸ
 -- ��� ���� ���� ��ȸ
SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'REGIONS';

--���̺� �����ϱ�
-- ȸ�����̺� ����
CREATE TABLE MEMBER (
    ID VARCHAR2(20), --���̵�� �ִ� ����� 10���ڱ���
    PW VARCHAR2(20) , -- ����� �ִ� 10����
    NAME VARCHAR2(100), -- �̸�
    PHONE VARCHAR2(20), --010�� ���� 10���� �����ϱ� ������ ���� ���� �� ���� OR �տ� 0 �� �Էµ� ��� 8������ �ν��ϴ� ��쵵 ����. OR '-'��ȣ�� ���� �����ع����� ��찡 ����
    AGE NUMBER(3) -- 999���� ��
    );
    
SELECT * FROM MEMBER;
DESC MEMBER;

INSERT INTO MEMBER (id,pw,name,phone,age)
values ('ewlia', 'yeji1202', '�ɿ���','010-7537-8627', 20);

insert into member
values ('smile2434', 'hoell5533', '�տ���', '010-3346-4672' ,186);

-- POINT TABLE ����
-- �̸�, ��ȣ, ����, ����, ����, ����, ���(�Ҽ��� 2�ڸ�)
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
VALUES ('�ɿ���', 1, 100,100,100,300,100);

ROLLBACK;
INSERT INTO POINT (NAME, NUM, KOR, ENG, MATH, TOTAL, AVG)
VALUES
('ȫ���', 2, 0,0,100,100,33.33);

-- ��� ���̺� ����
DROP TABLE MEMBER;
SELECT * FROM TAB; --������̺��� �����ƴµ�, BIN$RxHG4xodSg+MyagB82jljQ==$0 ���̺��� �����... ���������� ���ž�


-- �������� �ɱ� --

-- �̷��� ����� �� ��õ���� �ʴ´�. (�ֳĸ� �ý����� �ڵ����� �������� �̸� �����.)
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --���̵�
    PW VARCHAR2(20) NOT NULL, -- ���
    NAME VARCHAR2(100), -- �̸�
    PHONE VARCHAR2(20) , --UNIQUE, NOTNULL �̷��� �ΰ��� �ȵ�
    AGE NUMBER(3) -- 999���� ��
    );

-- ORA-00001: ���Ἲ ���� ����(HR.SYS_C007334)�� ����˴ϴ�
-- � �������� �������� �˼� ����(USER_CONSTRAINTS)�� Ȯ���ؾ���

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER';


--���� ���� �̸� : ���̺��_�÷���_�������Ǿ�� (ȸ�縶�� �ٸ�������)
-- �÷����� ��� : ���������� �÷��� �ٷ� ���� �ٿ����� ���
-- NOT NULL�� �÷����� ������θ� ���������� �ټ��ִ�.
-- �Ѱ� : �������� �ѹ��� �Ѱ��� ����
CREATE TABLE MEMBER (
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY, --���̵�
    PW VARCHAR2(20) CONSTRAINT MEMBER_PW_NN NOT NULL, -- ���
    NAME VARCHAR2(100) DEFAULT 'NAME' ,-- �̸� --NULL�� ���� ��� �⺻���� �־��ַ��� ��
    PHONE VARCHAR2(20) CONSTRAINT MEMBER_PHONE_U UNIQUE, --UNIQUE, NOTNULL �̷��� �ΰ��� �ȵ�
    AGE NUMBER(3) CONSTRAINT MEMBER_NUMBER_C CHECK (AGE BETWEEN 0 AND 120) -- -������ 999���� �����ѵ� , 0����� 120������� �����ϰ� �ϼ���
    );
    
INSERT INTO MEMBER (id,pw,name,phone,age)
values ('SIMYJ', 'yeji1202', '�ɿ���','010-7532-8627', 20);

--���� ���� ������ NULL�� ����!.
--insert into member (id,PW, NAME, phone,age)
--values ('smile2434','3LWLK434', NULL, '010-3346-4672' , 35); 
    
insert into member (id,PW, phone,age)
values ('smile2434','3LWLK434', '010-3346-4672' , 35);

SELECT * FROM MEMBER;
    
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER';

DROP TABLE MEMBER;


-- ���̺��� ��� : ������ �� �� �Ŀ� ���̺� �Ʒ��� �ٿ����� ���
-- �̹�����δ� NOT NULL, default���������� �� �� ����.
CREATE TABLE MEMBER (
    ID VARCHAR2(20) , --���̵�
    PW VARCHAR2(20) , -- ���
    NAME VARCHAR2(100) ,-- �̸� --NULL�� ���� ��� �⺻���� �־��ַ��� ��
    PHONE VARCHAR2(20), --UNIQUE, NOTNULL �̷��� �ΰ��� �ȵ�
    AGE NUMBER(3),  -- -������ 999���� �����ѵ� , 0����� 120������� �����ϰ� �ϼ���
    constraint member_id_pk primary key (ID),
    constraint member_phone_u unique (phone),
    constraint member_age_c check (age between 0 and 120)
    );
    

-- ����Ʈ ���̺� ���������� �ɾ��
 -- ����Ʈ ���̺��� �ĺ�Ű�� ����. �̷��� �ĺ�Ű�� ������ �����ڰ� �ĺ�Ű�� ������־�� �Ѵ�.
 -- �ΰ�Ű : �ٸ� Ʃ�ð� �ĺ��� �� �ֵ��� �ϴ� Ű
 -- ����Ű : �ΰ� �̻��� �÷��� ���ļ� �ϳ��� Ű�� ����� ��
DROP TABLE POINTS;
DROP TABLE MEMBER;

--�Ʒ� ����� �л� ���̺��̴�.
CREATE TABLE MEMBER (
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY, --���̵�
    PW VARCHAR2(20) CONSTRAINT MEMBER_PW_NN NOT NULL, -- ���
    NAME VARCHAR2(100) DEFAULT 'NAME' ,-- �̸� --NULL�� ���� ��� �⺻���� �־��ַ��� ��
    PHONE VARCHAR2(20) CONSTRAINT MEMBER_PHONE_U UNIQUE, --UNIQUE, NOTNULL �̷��� �ΰ��� �ȵ�
    AGE NUMBER(3) CONSTRAINT MEMBER_NUMBER_C CHECK (AGE BETWEEN 0 AND 120) -- -������ 999���� �����ѵ� , 0����� 120������� �����ϰ� �ϼ���
    );

-- foreign key
-- �ܷ�Ű :
CREATE TABLE POINTS (
    NUM NUMBER, -- �ٸ� Ʃ�ð� ����ȭ�ϱ� ���� ���� �ΰ�Ű
    ID VARCHAR2(20) CONSTRAINT POINTS_ID_FK REFERENCES MEMBER (ID), --MEMBER ���̺� �ִ� ���� ������. (POINT���̺��� MEMBER���̺��� ���Ѵ�. (�����Ѵ�)) | MEMBER�� �θ����̺� POINTS�� �ڽ����̺��� �ȴ�.
    -- �÷����� ������ (ID)�� �����ص� �ȴ�.
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOTAL NUMBER(3),
    AVG NUMBER(5,2)
    );
    
INSERT INTO MEMBER (id,pw,name,phone,age)
values ('SIMYJ', 'fdlsie202909', '�ɿ���','010-7532-8627', 20);    

select * from member;

insert into points
values(1, 'id12', 60,75, 82, 178,85.32); -- �θ� ���� ���� �Է��� �� ����.`

insert into points
values(1, 'SIMYJ', 60,75, 82, 178,85.32);

select * from points;

delete member where id = 'SIMYJ';  --�ڽ��� ������ �������� ����

INSERT INTO MEMBER (id,pw,name,phone,age)
values ('id1', 'fdlsie202909', '�Ƶ�','010-7522-8173', 28);    

delete member where id = 'id1'; -- ������ ������

-- ����
-- on delete cascade : �ڽ��� Ʃ�õ� ���� ����
-- on delete set null : �ڽ��� attribute �� null


-- ���� �Խ��� db �����
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
VALUES (2, 'Ÿ��Ʋ', 'SIMYJ','����',SYSDATE,0);

DELETE NOTICE WHERE IDX = 0;

-- 1������ ��ȸ���� 127�� ����
UPDATE NOTICE SET CLICK = 127 WHERE IDX = 1;

-- ���̺��� ��� ROW�� ��ȸ���� ���� 1�� �����ϵ��� ����
UPDATE NOTICE SET CLICK = CLICK+1;

-- ��� row ����
delete notice;
TRUNCATE table notice;

SELECT * FROM NOTICE;

--member ���� �α����� ����
select * from member
where id = 'abcd' and pw = 1 or 1 = 1; --pw�� '1 or 1 = 1'�� ���� sql injection������ �߻��� �� �ִ�.
select * from member
where id = ? and pw = '1 or 1 = 1'; --pw�� '1 or 1 = 1'�� ���� sql injection������ �߻��� �� �ִ�.

rollback;

select * from tab;
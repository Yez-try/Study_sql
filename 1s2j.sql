
1. ���̺� ����
	-- ���
		CREATE TABLE "ROLE" (
			"ROLENUM"	NUMBER		NOT NULL,
			"ROLENAME"	VARCHAR2(200)		NULL
		);
	-- ȸ�����
		CREATE TABLE "MEMBER_ROLE" (
			"R_NUM"	NUMBER		NOT NULL,
			"ROLENUM"	NUMBER		NOT NULL,
			"ID"	VARCHAR2(200)		NOT NULL
		);
	-- ȸ��
		CREATE TABLE "MEMBER" (
			"ID"	VARCHAR2(200)		NOT NULL,
			"PW"	VARCHAR2(200)		NULL,
			"NAME"	VARCHAR2(200)		NULL,
			"N_NAME"	VARCHAR2(200)		NULL,
			"B_DATE"	NUMBER		NULL,
			"GENDER"	VARCHAR2(200)		NULL,
			"EMAIL"	VARCHAR2(200)		NULL,
			"PHONE"	VARCHAR2(200)		NULL,
			"POINT"	NUMBER		NULL
		);
        
        drop table member;
	-- ����
		CREATE TABLE "TEACHER" (
			"T_NUM"	NUMBER		NOT NULL,
			"ID"	VARCHAR2(200)		NOT NULL,
			"BANK_ NUM"	VARCHAR2(200)		NULL,
			"BANK_NAME"	VARCHAR2(200)		NULL,
			"INTRODUCE"	CLOB		NULL
		);
	-- ȸ������
		CREATE TABLE "MEMBER_FILE" (
			"MF_NUM"	NUMBER		NOT NULL,
			"ID"	VARCHAR2(200)		NOT NULL,
			"F_NAME"	VARCHAR2(200)		NULL,
			"F_ORINAME"	VARCHAR2(200)		NULL
		);
	-- ��ٱ���
		CREATE TABLE "CART" (
			"C_NUM"	NUMBER		NOT NULL,
			"ID"	VARCHAR2(200)		NOT NULL,
			"L_NUM"	NUMBER		NOT NULL
		);
        
        		-- ��޹�ȣ ������ ����
			CREATE SEQUENCE ROLE_SEQ;
			
			-- ��� ������ �߰�
			INSERT INTO ROLE(ROLENUM, ROLENAME)
			VALUES(1, '������');
			
			INSERT INTO ROLE(ROLENUM, ROLENAME)
			VALUES(2, '����');
			
			INSERT INTO ROLE(ROLENUM, ROLENAME)
			VALUES(3, 'ȸ��');

		-- �����ȣ�� �� ������ ����
			CREATE SEQUENCE TEACHER_SEQ;

		-- ȸ����� ������ȣ ������ ����
			CREATE SEQUENCE MEMBER_ROLE_SEQ;
		
		-- ȸ�� ��� ����
			INSERT INTO MEMBER_ROLE(R_NUM, ROLENUM, ID)
			VALUES(MEMBER_ROLE_SEQ.NEXTVAL, 8, 'koo');
            
            commit;
            
            
            
            //���� ���̺�
CREATE TABLE LECTURE (
	L_NUM	NUMBER	NOT NULL,
	ID	VARCHAR2(200)	NOT NULL,
	C_NUM	NUMBER	NOT NULL,
	LEVEL_NUM	NUMBER	NOT NULL,
	L_NAME	VARCHAR2(200)	NULL,
	L_CONTENTS	VARCHAR2(500)	NULL,
	L_PRICE	NUMBER	NULL,
	L_COUNT	NUMBER	NULL,
	L_DATE	NUMBER	NULL
);

//ī�װ��� ���̺�
CREATE TABLE CATEGORY (
	C_NUM	NUMBER	NOT NULL,
	C_NAME	VARCHAR2(200)	NULL
);

//���� ���� ���̺�
CREATE TABLE L_FILE (
	NUM	NUMBER	NOT NULL,
	L_NUM	NUMBER	NOT NULL,
	F_NAME	VARCHAR2(200)	NULL,
	F_ORINAME	VARCHAR2(200)	NULL
);

//���� ���̺�
CREATE TABLE LECTURE_SIGN (
	S_NUM	NUMBER	NOT NULL,
	L_NUM	NUMBER	NOT NULL,
	ID	VARCHAR2(200)	NOT NULL,
	S_START	DATE	NULL,
	S_END	DATE	NULL,
	STATUS NUMBER	NULL
);

//���̵� ���̺�
CREATE TABLE "LEVEL" (
	LEVEL_NUM	NUMBER	NOT NULL,
	LEVEL_NAME VARCHAR2(200)	NULL
);

//��ٱ��� ���̺�
CREATE TABLE CART (
	CART_NUM	NUMBER	NOT NULL,
	ID	VARCHAR2(200)	NOT NULL,
	L_NUM	NUMBER	NOT NULL
);

//���� ���� ���̺�
CREATE TABLE VIDEO (
	V_NUM	NUMBER	NOT NULL,
	L_NUM	NUMBER	NOT NULL,
	V_URL	VARCHAR2(300)	NULL,
	V_CONTEXT	VARCHAR2(300)	NULL,
	V_SEQ	NUMBER	NULL
);

//Primary Key
ALTER TABLE `LECTURE` ADD CONSTRAINT `PK_LECTURE` PRIMARY KEY (
	`L_NUM`
);

ALTER TABLE `CATEGORY` ADD CONSTRAINT `PK_CATEGORY` PRIMARY KEY (
	`C_NUM`
);

ALTER TABLE `L_FILE` ADD CONSTRAINT `PK_L_FILE` PRIMARY KEY (
	`NUM`
);

ALTER TABLE `LECTURE_SIGN` ADD CONSTRAINT `PK_LECTURE_SIGN` PRIMARY KEY (
	`S_NUM`
);

ALTER TABLE `LEVEL` ADD CONSTRAINT `PK_LEVEL` PRIMARY KEY (
	`LEVEL_NUM`
);

ALTER TABLE `CART` ADD CONSTRAINT `PK_CART` PRIMARY KEY (
	`CART_NUM`
);

ALTER TABLE `VIDEO` ADD CONSTRAINT `PK_VIDEO` PRIMARY KEY (
	`V_NUM`
);

//Foreign Key
ALTER TABLE `LECTURE` ADD CONSTRAINT `FK_MEMBER_TO_LECTURE_1` FOREIGN KEY (
	`ID`
)
REFERENCES `MEMBER` (
	`ID`
);

ALTER TABLE `LECTURE` ADD CONSTRAINT `FK_CATEGORY_TO_LECTURE_1` FOREIGN KEY (
	`C_NUM`
)
REFERENCES `CATEGORY` (
	`C_NUM`
);

ALTER TABLE `LECTURE` ADD CONSTRAINT `FK_LEVEL_TO_LECTURE_1` FOREIGN KEY (
	`LEVEL_NUM`
)
REFERENCES `LEVEL` (
	`LEVEL_NUM`
);

ALTER TABLE `L_FILE` ADD CONSTRAINT `FK_LECTURE_TO_L_FILE_1` FOREIGN KEY (
	`L_NUM`
)
REFERENCES `LECTURE` (
	`L_NUM`
);

ALTER TABLE `LECTURE_SIGN` ADD CONSTRAINT `FK_LECTURE_TO_LECTURE_SIGN_1` FOREIGN KEY (
	`L_NUM`
)
REFERENCES `LECTURE` (
	`L_NUM`
);

ALTER TABLE `LECTURE_SIGN` ADD CONSTRAINT `FK_MEMBER_TO_LECTURE_SIGN_1` FOREIGN KEY (
	`ID`
)
REFERENCES `MEMBER` (
	`ID`
);

ALTER TABLE `CART` ADD CONSTRAINT `FK_MEMBER_TO_CART_1` FOREIGN KEY (
	`ID`
)
REFERENCES `MEMBER` (
	`ID`
);

ALTER TABLE `CART` ADD CONSTRAINT `FK_LECTURE_TO_CART_1` FOREIGN KEY (
	`L_NUM`
)
REFERENCES `LECTURE` (
	`L_NUM`
);

ALTER TABLE `VIDEO` ADD CONSTRAINT `FK_LECTURE_TO_VIDEO_1` FOREIGN KEY (
	`L_NUM`
)
REFERENCES `LECTURE` (
	`L_NUM`
);

//Sequence
//���� ��ȣ(l_num) SEQUENCE
CREATE SEQUENCE LECTURE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

//��ٱ��� ��ȣ(cart_num) SEQUENCE
CREATE SEQUENCE CART_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

//���� ���� ��ȣ(f_num) SEQUENCE
CREATE SEQUENCE FILE_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

//���� ���� ��ȣ(v_num) SEQUENCE
CREATE SEQUENCE VIDEO_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

//���� ��û ��ȣ(s_num) SEQUENCE
CREATE SEQUENCE SIGN_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;


--������
create sequence ORDER_SEQ;


--���̺� ����
CREATE TABLE "ORDER" (
"O_NUM"	NUMBER		NOT NULL,
"L_NUM"	NUMBER		NOT NULL,
"P_UID"	VARCHAR2(200)		NOT NULL,
"O_AMOUNT"	NUMBER		NULL
);

CREATE TABLE "PAYMENT" (
	"P_UID"	VARCHAR2(200)		NOT NULL,
	"ID"	VARCHAR2(200)		NOT NULL,
	"P_POINT"	NUMBER		NULL,
	"P_AMOUNT"	NUMBER		NULL,
	"P_REALAMOUNT"	NUMBER		NULL,
	"P_REGDATE"	DATE		NULL,
	"P_METHOD"	VARCHAR2(100)		NULL,
	"P_C_NAME"	VARCHAR2(200)		NULL,
	"P_C_NUM"	NUMBER		NULL,
	"P_C_QUOTA"	NUMBER		NULL,
	"P_REMAINS"	NUMBER		NULL,
	"P_AT"	NUMBER		NULL,
	"P_RECEIPT"	VARCHAR2(400)		NULL,
	"P_C_APPLY"	NUMBER		NULL
);
--�׽�Ʈdata
insert into payment (p_uid, id, p_point, p_amount, p_realamount, p_regdate, p_method, p_c_name, p_c_num, p_c_quota, p_remains, p_at, P_RECEIPT, p_c_apply)
values ('p_uid', 'id', 1, 6600, 5662210, sysdate, 'p_method', 'p_c_name', 1555555555, 3, 5662210, 15578685, 'P_RECEIPT', 11111);

commit;

		INSERT INTO MEMBER(ID, PW, NAME, N_NAME, B_DATE, GENDER, EMAIL, PHONE, POINT)
		VALUES ('id', 'pw', 'na', 'yj', 19941202, '����', 'email@naver.com', '010-2342-2342', 0);
        
        select * from lecture;
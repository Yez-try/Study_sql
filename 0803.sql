-- 08/03 --
select * from tab;

purge RECYCLEBIN;

select * from bankmembers;
desc bankmembers;

insert into bankmembers (ID,PW,name, email,phone, lv)
values ('test','pwtest','nametest','email@test','010-0004-9866','NORMAL');

commit;

delete bankmembers where lv = 'normal';

select * from bankmembers where id like '%test%' order by id asc;


ALTER TABLE accountlist MODIFY (acid number);
desc accountlist;

insert into accountlist (acid, acname, acrate, acsale)
values (1,'���游������2',10.50,1);

select * from accountlist where acid = 234444 order by acid desc;

delete accountlist where acsale = 0;

update accountlist
set accountlist.acsale = 0
where acname = '���游������2';

delete banktrade;
delete accounts;
delete accountlist;


rollback;
commit;

--�ϳ��� ��ȸ
select * from accountlist where acid= 2382255456656;

--update �غ���
update accountlist
set acrate = 87.1, acname = '�׽�Ʈ����'
where acid = 2382255456656;
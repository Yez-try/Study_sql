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
values (1,'대충만든적금2',10.50,1);

select * from accountlist where acid = 234444 order by acid desc;

delete accountlist where acsale = 0;

update accountlist
set accountlist.acsale = 0
where acname = '대충만든적금2';

delete banktrade;
delete accounts;
delete accountlist;


rollback;
commit;

--하나만 조회
select * from accountlist where acid= 2382255456656;

--update 해보기
update accountlist
set acrate = 87.1, acname = '테스트적금'
where acid = 2382255456656;
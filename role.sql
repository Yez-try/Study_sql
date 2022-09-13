--admin회원
select * from bankmembers where id = '0905' ;

select * from bankmembers;
select * from Member_role;

select * from member_role where rolenum = 681 or rolenum=682;
select * from role;

--id, name, rolename을 가져오는 조인 쿼리를 작성해라

select id, name, rolename
from bankmembers BM
    left join member_role MR
    on BM.id = MR.username
    left join role R
    on MR.rolenum = R.rolenum;
where id = 'hi';


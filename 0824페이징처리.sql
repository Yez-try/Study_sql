-- ∆‰¿Ã¬°√≥∏Æ --

insert into notice 
values (board_seq.nextval, 'title','contentl', 'id8585',sysdate,0);

select * from notice where 
num <= (select max(num)-0 from notice) and
num > (select max(num)-10 from notice)
order by num desc;

select num, title, contents, writer, regdate, hit 
from (select rownum as rown, nt.* 
from (select * from notice 
order by num desc) nt)
where rown between 1 and 10;


select rownum as rown, nt.* from notice nt
order by num desc;

select rownum, nt.* from notice nt
order by num desc;

select num, title, contents, writer, regdate, hit 
from (select rownum , nt.* from notice nt
order by num desc)
where rownum between 11 and 20;

select * from 
(select * from notice order by num desc) nt
where rownum between 1 and 10;

commit;

select count(num) from notice;

select * from bankmembers;

select rownum rown, Q.* 
		  from QNA Q 
		  ORDER BY NUM DESC;

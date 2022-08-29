-- 검색 --
select * from notice where contents like '%0%';


--답글달기--
select * from Qna;

INSERT INTO QNA (NUM, TITLE, CONTENTS, WRITER, REGDATE, HIT, REF, STEP, DEPTH)
		VALUES (BOARD_SEQ.NEXTVAL, '답글1', 0, 'id8585', SYSDATE, 0, 441, 1, 1);

update Qna set step=step+1 where ref=441 and step>0;

commit;






-- db 생성
create database haksa;
-- 테이블 접근
use 테이블명; 

-- 유저 생성 및 권한 부여
create user jin@localhost identified by '1111';



-- grant all privileges(이거 말고도 select,insert,update,등등) on (*은 모든 DB, 혹은 db명).(*은 모든 테이블, 혹은 테이블명) to '사용자명'@'호스트';
-- 모든 권한 삭제 REVOKE ALL PRIVILEGES ON *.* FROM 사용자명@호스트;
-- 권한 확인 SHOW GRANTS FOR 사용자명;
grant all privileges on haksa.* to jin@localhost;
-- 계정 생성과 동시에 권한 부여
grant all privileges on haksa.* to jin@localhost with grant option;


-- 특정 테이블의 칼럼 조회 (코멘트 포함)
show full columns from table_name;


-- 유저 삭제
DELETE FROM user WHERE user='username';
flush PRIVILEGES;
 
-- 기본적인 sql 명령문
-- create, drop / db 혹은 table 생성 및 삭제
-- update, delete / 정보 변경 혹은 삭제

-- alter은 테이블 변경에서는 아래의 일을 할 수 있다.
-- 테이블 이름 변경 (RENAME)
-- 테이블 칼럼 , 제약조건 추가 (ADD)
-- 테이블 변경 (CHANGE, MODIFY)
-- 테이블 제약 조건 제거 (DROP)

alter table table_name
rename test_name;

-- 칼럼이름 변경
alter table table_name
rename column name to name1;
-- 테이블에 주석 달기
alter table table_name
comment = 'comment';
-- 주석확인
show create table table_name;

-- 칼럼에 주석 추가
alter table table_name change column_name colum_name data_type(varchar,int,...) 널 여부(not null) comment 'this is the comment'

-- primay key 추가
alter table exercise_copy add primary key(ex_no);



-- update는 특정정보를 where절로 골라서 변경한다.

-- insert into 테이블명 (칼럼명,칼럼명/이거 없어도 된다 values랑 칼럼수가 맞기만 하면 된다.) values(정보,정보,...)

insert into student values ('20141001', 'John', 'Sierra117', 10, 4, 1, 'd', '1990501', '1', '01066', '101-203', '010', '4503', '7570', '010-4053-7570');

insert into fee values ('20141001', '2020', 1, 1, 200, 200, 'jg', 200, 50, 'y', '2020-02-01');


insert into attend values ('20141001', '2020', 1, 1, 'hi', '1', 3, 3, '1', '1', '2020-03-01');

insert into professor values('1', 'Elizabeth', 'Ellie', '2020-03-26');

insert into subject values('1', 'nursing', 'nursing', '1990');

insert into department values(10, 'Ganho', 'Dept. of Nursing', '1991-02-01');



-- rollback;
-- savepoint aa; 저장지점 설정
-- truncate table; 
-- set autocommit = 0; 자동 커밋 막기
-- commit; 

-- 1.Delete
-- - 데이터만 삭제 되며 테이블 용량은 줄어 들지 않는다. 또한 삭제후 잘못 삭제한 것을 되돌릴 수 있다.
-- - TABLE이나 CLUSTER에 행이 많으면 행이 삭제될 때마다 많은 SYSTEM 자원이 소모 된다.
-- - Commit이전에는 Rollback이 가능하다.
-- - 롤백정보를 기록 하므로 Truncate에 비해서 느리다.
-- - 전체 또는 일부만 삭제 가능 하다.
-- - 삭제 행수를 반환 한다.
-- - 데이터를 모두 Delete해도 사용했던 Storage는 Release 처리 되지 않는다.

 

 

-- 2.Truncate - 테이블의 모든 로우를 제거하는 Truncate Table
-- - 테이블을 최초 생성된 초기상태로 만든다.
-- - 용량이 줄어들고, 인덱스 등도 모두 삭제 된다.
-- - Rollback 불가능 하다.
-- - 무조건 전체 삭제만 가능 하다.
-- - 삭제 행수를 반환 하지 않는다.
-- - 테이블이 사용했던 Storage중 최초 테이블 생성시 할당된 Storage만 남기고 Release 처리 된다.

 

 

-- 3. Drop table - 테이블 구조를 제거
-- 기존 테이블의 존재를 제한다. (테이블의 정의 자체를 완전히 삭제한다)
-- Rollback 불가능 하다.
-- 테이블이 사용했던 Storage는 모두 Release 처리 된다.





-- mysql db 확인
use mysql;
-- mysql 테이블들 확인
show tables;
-- user 테이블 칼람확인
desc user;
-- 비밀번호 설정상태 확인
select host,user,plugin,authentication_string, password_last_changed from user;

-- 유저 비밀번호 바꾸기 1
 alter user 'jin'@'localhost' identified with mysql_native_password by '0000';
 flush privileges;
-- 유저 비밀번호 바꾸기 2
set password = '1111';

-- 다른 유저 비밀번호 바꾸기 3
set password for 'root'@'localhost' = '0000';



-- 테이블 생성
create table department(
    dept_code int(2) Not null,
    dept_name char(30) Not null,
    dept_ename varchar(50),
    create_date date default null,
    primary key (dept_code)
) engine = innoDB;

create table student(
    stu_no char(10) Not null,
    stu_name char(10) Not null,
    stu_ename varchar(30),
    dept_code int(2) Not null,
    garde int(1) Not null,
    class int(1) Not null,
    juya char(2),
    birthday varchar(8) Not null,
    gender varchar(1) Not null,
    post_no varchar(5) Not null,
    address varchar(100),
    tel1 varchar(3),
    tel2 varchar(4),
    tel3 varchar(5),
    mobile varchar(14),
    primary key(stu_no),

    -- 외래키 선언
    -- constraint 이름 foreign key(칼럼명)
    -- references 테이블명(칼럼명)
    constraint s_dp_fk foreign key(dept_code)
    references department(dept_code)
) engine = innoDB;



-- view 생성

create view view_name(column1,column2,column3) AS
select (column1,column2,calculations)
from tbl_selected_db;

--mysql 종료

quit;



-- make a copy of the table

create table copy_cat as select * from cat;  


CREATE TABLE [대상 테이블명] SELECT * FROM [원본 테이블명]

-- 이미 있는 테이블에 덮어 씌울 때
INSERT INTO [대상 테이블명] SELECT * FROM [원본 테이블명]  

-- 다른 db에서 가져올 때
mysql> INSERT INTO [대상 데이터베이스명].[대상 테이블명] 

        -> SELECT * FROM [원본 데이터베이스명].[원본테이블명] 

-- 중복값때문에 신경 쓰일때
 INSERT ignore INTO .....

-- 코멘트
-- SQL은 대소문자 구분이 없음.
-- 데이터베이스(Database) : 데이터의 모음
-- DBMS( DB Management System ) : DB관리소프트웨어
-- DBMS 종류
-- 1. 오라클 : 중대형기업에서 주로 사용하고, 상용DB 점유율 1등
--           : 유료
-- 2. MySQL : 소/중/대형기업에서 주로 사용하고, 전체 DB 사용율 1등
--          : 오라클에 인수합병후, 부분 유료화됨.
-- 3. MariaDB : MySQL 초기개발자들이 다시 개발함. MySQL 8.x버전에서
--            : SQL문이 호환됨. 실행파일이름도 mysql이다. 완전 무료.
-- 4. PostgresSQL(포스트그리큐엘) : 완전 무료, 표준SQL을 준수하면서
--            : MySQL과는 다른 기원을 가진 DB.
-- 1,2,3,4번은 관계형 DBMS라고 함. 테이블과 컬럼, 줄(ROW,레코드) 기반
-- SQL 언어를 사용함.
-- No-SQL 언어 기반의 DBMS
-- 1. MongoDB : 객체 및 문서 기반
-- 2. Firebase RealtimeDB & FirestoreDB : 구글이 만든 백엔드 서버리스 솔루션
-- 3. Redis(레디스) : 메모리기반 DB, 속도가 엄청빠름.
-- SQL 언어란?
-- Structured Query Language : 쿼리는 질의어를 의미
-- SQL를 통해 DB에 명령을 내리거나 결과를 가져옴.
-- SQL CRUD에 대해서
-- Create : 데이타 추가 - Insert
-- Read : 읽기 - Select
-- Update : 수정 - Update
-- Delete : 삭제 - Delete

-- database 생성
create database if not exists mydb;
-- database 선택
use mydb;
-- table 생성
    -- not null : null이 아니어야 됨
    -- auto_increment : 1씩 자동 증가
    -- primary key : 기본키로 지정
create table member (
	memberno int(11) not null auto_increment primary key,
    id varchar(50),
    `name` varchar(50)
);
-- 테이블 구조 확인
desc member;
-- 레코드 추가
-- `name` : SQL 예약어를 사용자 정의 변수로 사용할 때
insert into member (memberno, id, `name`)
	values (1, 'hong', '홍길동');
select * from member;
insert into member (memberno, id, `name`)
	values (2, 'tom', '톰아저씨');
-- 모든 필드 기입시 필드이름 생략가능
insert into member
	values (3, 'sony', '손흥민');
insert into member
	values (4, 'mask', '머스크');
-- 레코드 수정하기
update member set id='lee', `name`='미스터리' where memberno=1;
-- 레코드 삭제하기
delete from member where memberno=1;
select * from member;
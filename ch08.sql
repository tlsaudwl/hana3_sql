-- DDL : 데이터 정의어

CREATE DATABASE 세계학사;
USE 세계학사;

CREATE TABLE 학과
    (
	   학과번호 CHAR(2)
      ,학과명 VARCHAR(20)
      ,학과장명 VARCHAR(20)
    );

INSERT INTO 학과 VALUES
     ('AA','컴퓨터공학과','배경민')
    ,('BB','소프트웨어학과','김남준')
    ,('CC','디자인융합학과','박선영');
    
CREATE TABLE 학생
    ( 
       학번 CHAR(5)
      ,이름 VARCHAR(20) 
      ,생일 DATE
      ,연락처 VARCHAR(20)
      ,학과번호 CHAR(2)
    );

INSERT INTO 학생 VALUES
     ('S0001','이윤주','2020-01-30','01033334444','AA')
	,('S0001','이승은','2021-02-23',NULL,'AA')
    ,('S0003','백재용','2018-03-31','01077778888','DD');
    
-- 구조만 복사하고 데이터는 추가되지 않음
CREATE TABLE 휴학생 AS
SELECT *
FROM 학생
WHERE 1 = 2;   

CREATE TABLE 회원
    (
       아이디 VARCHAR(20) PRIMARY KEY
      ,회원명 VARCHAR(20)
      ,키 INT
      ,몸무게 INT
      ,체질량지수 DECIMAL(4,1) AS (몸무게 / POWER(키 / 100, 2)) STORED
    );
-- STORED : 계산된 값을 실제 컬럼으로 저장
-- VIRTUAL : SELECT시에 즉시 계산되어 출력
    
INSERT INTO 회원(아이디, 회원명, 키, 몸무게)
VALUES('APPLE','김사과',178, 70);

SELECT * FROM 회원;

-- ALTER TABLE : 테이블의 특성을 변경
ALTER TABLE 학생 ADD 성별 CHAR(1);
ALTER TABLE 학생 DROP COLUMN 성별;
DESC 학생;

-- DROP TABLE : 테이블 삭제
DROP TABLE 학과;
DROP TABLE 학생;

CREATE TABLE 학과
    (
       학과번호 CHAR(2) PRIMARY KEY
      ,학과명 VARCHAR(20) NOT NULL
      ,학과장명 VARCHAR(20)
    );

DROP TABLE 학생;
CREATE TABLE 학생
    (
       학번 CHAR(5) PRIMARY KEY
      ,이름 VARCHAR(20) NOT NULL
      ,생일 DATE NOT NULL
      ,연락처 VARCHAR(20) UNIQUE
      ,학과번호 CHAR(2) REFERENCES 학과(학과번호)
      ,성별 CHAR(1) CHECK(성별 IN ('남','여'))
      ,등록일 DATE DEFAULT(CURDATE())
      ,FOREIGN KEY (학과번호) REFERENCES 학과(학과번호) 
      ON UPDATE CASCADE ON DELETE CASCADE
    );
   
DESC 학과;
DESC 학생;

CREATE TABLE 과목
    (
	   과목번호 CHAR(5) PRIMARY KEY
      ,과목명 VARCHAR(20) NOT NULL
      ,학점 INT NOT NULL CHECK(학점 BETWEEN 2 AND 4)
      ,구분 VARCHAR(20) CHECK(구분 IN ('전공','교양','일반'))
    );

INSERT INTO 학과
VALUES ('AA','컴퓨터공학과','배경민');

-- 기본키가 중복되어 오류
INSERT INTO 학과
VALUES ('AA','소프트웨어학과','김남준');
-- 오류 수정
INSERT INTO 학과
VALUES ('BB','소프트웨어학과','김남준');

INSERT INTO 학과
VALUES ('CC','디자인융합학과','박선영');

SELECT * FROM 학과;


-- 학생 테이블 추가
INSERT INTO 학생(학번, 이름, 생일, 학과번호) 
VALUES ('S0001','이윤주','2020-01-30','AA');

-- 기본키다 없어서 오류임
INSERT INTO 학생(이름, 생일, 학과번호) 
VALUES ('이승은','2021-02-23','AA');   
-- 오류 수정
INSERT INTO 학생(학번, 이름, 생일, 학과번호)
VALUES ('S0002', '이승은','2020-01-30', 'AA');

-- 부모테이블에 없는 키값을 넣으려고 할때 오류
INSERT INTO 학생(학번, 이름, 생일, 학과번호) 
VALUES ('S0003','백재용','2018-03-31','DD'); 
-- 오류 수정
INSERT INTO 학생(학번, 이름, 생일, 학과번호)
VALUES ('S0003','백재용','2018-03-31','CC');

SELECT * FROM 학생;

DESC 학생;


-- 연습문제
-- 1. 영화 테이블 생성하기
CREATE TABLE 영화 (
	영화번호 CHAR(5) PRIMARY KEY,
    타이틀 VARCHAR(100) NOT NULL,
    장르 VARCHAR(20) CHECK (장르 IN ("코미디", "드라마", "다큐", "SF", "액션", "역사", "기타")),
    배우 VARCHAR(100) NOT NULL,
    감독 VARCHAR(50) NOT NULL,
    제작사 VARCHAR(150) NOT NULL,
    개봉일 DATE,
    등록일 DATE default(NOW())
    );

-- 2. 평점관리 테이블 생성하기
CREATE TABLE 평점관리 (
	번호 INT primary KEY auto_increment,
    평가자닉네임 VARCHAR(50) NOT NULL,
    영화번호 CHAR(20) NOT NULL,
    평점 INT NOT NULL CHECK(평점 BETWEEN 1 AND 5),
    평가 VARCHAR(2000) NOT NULL,
	등록일 DATE DEFAULT(NOW()),
    FOREIGN KEY(영화번호) REFERENCES 영화(영화번호) -- ON UPDATE CASCADE ON DELETE CASCADE
    );
    
-- 3. 영화 테이블 데이터 추가
INSERT INTO 영화(영화번호, 타이틀, 장르, 배우, 감독, 제작사, 개봉일)
VALUES 
("00001", "파묘", "드라마", "최민식, 김고은", "장재현", "쇼박스", "2024-02-22"),
("00002", "둔:파트2", "액션", "티미시 샬라메, 젠데이아", "드니 뵐뇌브", "레전더리 픽처스", "2024-02-28");

-- 4. 평점관리 테이블 데이터 추가
INSERT INTO 평점관리(평가자닉네임, 영화번호, 평점, 평가) 
VALUES 
("영화광", "00001", 5, "미치도록 스릴이 넘쳐요"),
("무비러브", "00002", 4, "장엄한 스케일이 좋다");

-- 5번 (오류 발생, 영화번호가 영화 테이블에 없기 때문)
INSERT INTO 평점관리(평가자닉네임, 영화번호, 평점, 평가) 
VALUES ("영화광", "00003", 5, "미치도록 스릴이 넘쳐요");

-- 6번 : 영화 레코드를 삭제하려고 하면 오류발생
DELETE FROM 영화
WHERE 영화번호 = '00001';

-- 7번 : 평점관리 테이블 - 영화번호 제약 조건에 ON DELETE CASCADE 추가 후
DELETE FROM 영화
WHERE 영화번호 = '00001';

SELECT * FROM 영화;
SELECT * FROM 평점관리;


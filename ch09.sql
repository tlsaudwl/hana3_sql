-- 윈도우 함수

USE 세계무역;

SELECT AVG(마일리지)
FROM 고객
WHERE 도시 = '부산광역시';

-- 집계함수와 각 행의 데이타를 함께 출력할 수 없음.
SELECT 고객번호, 
       AVG(마일리지)
FROM 고객
WHERE 도시 = '부산광역시';

-- 집계 윈도우 함수는 각행의 데이터와 집계함수의 정보를 함께 출력 가능하다.
SELECT 고객번호
      ,고객회사명
      ,마일리지
      ,AVG(마일리지) OVER() AS 평균마일리지 
FROM 고객
WHERE 도시 = '부산광역시';

SELECT 고객번호
      ,도시
      ,마일리지 AS 고객마일리지
      ,AVG(마일리지) OVER(PARTITION BY 도시) AS 도시평균마일리지
      ,마일리지 - AVG(마일리지) OVER(PARTITION BY 도시) AS 차이
FROM 고객
WHERE 지역 = '경기도';

SELECT 고객번호
      ,마일리지 AS 고객마일리지 
      ,SUM(마일리지) OVER() AS 마일리지합
      ,SUM(마일리지) OVER(ORDER BY 고객번호) AS 누적마일리지
FROM 고객
WHERE 도시 = '부산광역시';

SELECT 고객번호
      ,고객회사명
      ,담당자명
      ,마일리지
      ,RANK() OVER(ORDER BY 마일리지 DESC) AS 순위
FROM 고객
WHERE 도시 = '부산광역시';

SELECT 고객번호
      ,도시
      ,마일리지
      ,NTILE(3) OVER(ORDER BY 마일리지) AS 그룹
 FROM 고객
 WHERE 도시 = '인천광역시' AND 마일리지 BETWEEN 100 AND 10000;


SELECT 고객회사명
      ,마일리지
      ,FIRST_VALUE(고객회사명) OVER(ORDER BY 마일리지) AS 최소마일리지보유고객
      ,	FIRST_VALUE(마일리지) OVER(ORDER BY 마일리지) AS 최소마일리지
      ,마일리지 - FIRST_VALUE(마일리지) OVER(ORDER BY 마일리지) AS 차이  
FROM 고객
WHERE 도시 = '부산광역시';

SELECT 고객회사명
      ,마일리지
      ,LAST_VALUE(고객회사명) OVER(ORDER BY 마일리지) AS 최대마일리지보유고객
      ,LAST_VALUE(마일리지) OVER(ORDER BY 마일리지) AS 최대마일리지
FROM 고객
WHERE 도시 = '부산광역시';

SELECT LAG(고객번호) OVER(ORDER BY 고객번호) AS 이전행고객번호
      ,고객번호 
      ,LEAD(고객번호) OVER(ORDER BY 고객번호) AS 다음행고객번호 
FROM 고객;

SELECT 주문월
		,주문금액합
		,SUM(주문금액합) OVER(ORDER BY 주문월) AS 누적금액합
FROM (
		SELECT MONTH(주문일) AS 주문월
		      ,SUM(주문수량 * 단가) AS 주문금액합
		FROM 주문
		INNER JOIN 주문세부
		ON 주문.주문번호 = 주문세부.주문번호 
		WHERE YEAR(주문일) = 2021
		GROUP BY MONTH(주문일)
) AS 월별주문;
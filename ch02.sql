USE 세계무역;

SELECT *
FROM 고객;

-- 출력되는 행의 개수
SELECT count(*)
FROM 고객;

SELECT 고객번호,담당자명,고객회사명,마일리지 AS 포인트
		,마일리지 * 1.1 AS "10%인상된 마일리지"
FROM 고객;

SELECT 고객번호,담당자명,마일리지 AS 포인트
FROM 고객
WHERE 마일리지 >= 100000;

SELECT 고객번호,담당자명,도시,마일리지 AS 포인트
FROM 고객
WHERE 도시 = '서울특별시'
ORDER BY 마일리지 DESC;

-- limit : 개수제한
SELECT *
FROM 고객
LIMIT 3;

-- 마일리지 상위 3명 / 하위 3명 => DESC 대신에 ASC 또는 생략
SELECT *
FROM 고객
ORDER BY 마일리지 DESC
LIMIT 3;

SELECT DISTINCT 도시
FROM 고객;

-- 비교 연산자
SELECT 23 >= 5
	,23 <= 5
	,23 > 23
	,23 < 23
	,23 = 23
	,23 <> 23
	,23 != 23;

-- 산술 연산자
SELECT 23 + 5 AS 더하기
	,23 - 5 AS 빼기
	,23 * 5 AS 곱하기
	,23 / 5 AS 실수나누기
	,23 DIV 5 AS 정수나누기
	,23 % 5 AS 나머지1
	,23 MOD 5 AS 나머지2;
	
-- where절에 조건절 사용
SELECT *
FROM 고객
WHERE 도시 = '부산광역시' AND 마일리지 < 1000; 

-- 집합연산자 UNION, UNION ALL
-- UNION : 두개의 SELECT의 결과를 합쳐줌
--		 : 컬럼의 갯수와 타입을 일치시켜야 됨
-- UNION ALL : 중복되는 레코드도 다 출력해줌
SELECT 고객번호, 도시, 마일리지 
FROM 고객 
WHERE 도시='부산광역시'
UNION ALL 
SELECT 고객번호, 도시, 마일리지
FROM 고객 
WHERE 마일리지 < 1000
ORDER BY 마일리지; -- asc가 생략됨

-- 위의 UNION 결과와 동일하다
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 도시 = '부산광역시' OR 마일리지 < 1000
ORDER BY 1;

-- is null 연산자
SELECT 지역
FROM 고객;

SELECT *
FROM 고객
WHERE 지역 IS NULL;
-- count는 0이다
-- csv의 비어있는 데이터를 import할때, ''빈 문자열로 들어와서

UPDATE 고객
SET 지역 = NULL 
WHERE 지역 = '';

-- IN, BETWEEN AND 연산자
-- ~중의 하나, where or를 간결화
SELECT 고객번호, 담당자직위
FROM 고객
WHERE 담당자직위 IN ('영업 과장', '마케팅 과장');

-- ~에서 ~까지의 논리, where and를 간결화
SELECT 담당자명, 마일리지
FROM 고객
WHERE 마일리지 BETWEEN 100000 AND 200000;

-- LIKE 절 : 유사한 문자열을 검색할 때
SELECT *
FROM 고객
WHERE 도시 LIKE '%광역시'
AND (고객번호 LIKE '_C%' OR 고객번호 LIKE '__C%');


-- 연습문제
-- 1.‘서울’에 사는 고객 중에 마일리지가 15,000점 이상 20,000점 이하인 고객의 모든 컬럼 정보를 보이시오.
SELECT *
FROM 고객
WHERE 도시 LIKE '%서울%'
WHERE 마일리지 BETWEEN 15000 AND 20000;

-- 2.세계무역의 고객들은 어느 지역, 어느 도시에 사는지 지역과 도시를 한 번씩만 보이시오. 
-- 이때 결과를 지역 순으로 나타내고, 동일 지역에 대해서는 도시 순으로 나태내시오.
SELECT DISTINCT 지역, 도시
FROM 고객
ORDER BY 1,2;
-- order by 지역, 도시

-- 3.‘춘천시’나 ‘과천시’ 또는 ‘광명시’에 사는 고객 중에서 담당자직위에 ‘이사’ 또는 ‘사원’이 들어가는 고객의 모든 정보를 보이시오.
SELECT *
FROM 고객
WHERE 도시 IN ('춘천시','과천시','광명시')
AND (담당자직위 LIKE '%이사%' OR 담당자직위 LIKE '%사원%');

-- 4.‘광역시’나 ‘특별시’에 살지 않는 고객들 중에서 마일리지가 많은 상위 고객 3명의 모든 정보를 출력하시오.
SELECT *
FROM 고객
WHERE (도시 LIKE '%광역시%' OR 도시 LIKE '%특별시%')
ORDER BY 마일리지 DESC 
LIMIT 3;

-- 5.지역에 값이 들어있는 고객 중에서 담당자직위가 ‘대표 이사’인 고객을 빼고 보이시오.
-- (지역은 NULL 값으로 찍혀도 됩니다.)     <> : 같지 않다
SELECT *
FROM 고객
WHERE 지역 IS NOT NULL 
AND 담당자직위 <> '대표 이사';


-- 실전문제
-- 1.제품 테이블에서 세계무역이 취급하는 제품 중에서 ‘주스’ 제품에 대한 모든 정보를 검색하시오.
SELECT *
FROM 제품
WHERE 제품명 LIKE '%주스%';

-- 2.제품 테이블에서 단가가 5,000원 이상 10,000원 이하인 ‘주스’제품에는 무엇이 있는지 검색하시오.
SELECT *
FROM 제품
WHERE 제품명 LIKE '%주스%'
AND 단가 BETWEEN 5000 AND 10000;

-- 3.제품 테이블에서 제품번호가 1,2,4,7,11,20인 제품의 모든 정보를 보이시오.
SELECT *
FROM 제품
WHERE 제품번호 in(1,2,4,7,11,20);

-- 4.제품 테이블에서 재고금액이 높은 상위 10개 제품에 대해 제품번호, 제품명, 단가, 재고, 재고금액(단가 * 재고)을 보이시오.
SELECT 제품번호, 제품명, 단가, 재고, 단가*재고 AS 재고금액
FROM 제품
ORDER BY 재고금액 DESC 
LIMIT 10;
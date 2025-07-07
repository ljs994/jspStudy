USE DVDMarketDB;

// 유저 가입 :
 INSERT INTO user_tbl VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW());

// 유저 조회 :
 SELECT * FROM user_tbl WHERE user_id = ?;

// 유저 탈퇴 :
 DELETE FROM user_tbl WHERE user_id = ?;

// 유저 정보 수정 : 
 UPDATE user_tbl SET (?, ?, ?) = (f1, f2, f3) WHERE user_id = ?;


CREATE TABLE user_tbl (
  user_id			VARCHAR(20),	-- 아이디
  user_pw			VARCHAR(20),	-- 비밀번호
  user_name			VARCHAR(10),	-- 이름
  user_gender		VARCHAR(4),		-- 성별
  user_birth		DATE,			-- 생년월일
  user_email		VARCHAR(30),	-- 이메일
  user_phone		VARCHAR(20),	-- 전화번호
  user_address		VARCHAR(100),	-- 주소
  user_registdate	DATETIME,		-- 생성일
  is_admin			INT		NOT NULL DEFAULT 0,	-- 어드민 0 = 일반 계정	1 = 어드민계정
  auth_token 		TEXT 	DEFAULT NULL,		-- 토큰생성
  PRIMARY KEY (user_id)
) DEFAULT CHARSET = UTF8;

SELECT * FROM user_tbl;
DESC user_tbl;
DROP TABLE user_tbl;

INSERT INTO user_tbl VALUES ("testuser1", "1234", "테스트1", "남자", "2025-04-20", 
	"testuser1@test.com", "010-1234-5678", "병점동", NOW());
	
INSERT INTO user_tbl VALUES ("testuser2", "1234", "테스트2", "남자", "2025-04-20", 
	"testuser2@test.com", "010-2222-2222", "병점동", NOW());
	
INSERT INTO user_tbl VALUES ("testuser3", "1234", "테스트3", "남자", "2025-04-20", 
	"testuser3@test.com", "010-3333-3333", "병점동", NOW());
	
INSERT INTO user_tbl VALUES ("dummyuser1", "DummyPass!1", "홍길동", "남자", "1990-01-01",
	"dummy1@example.com", "010-1234-5678", "서울시 강남구 역삼동", NOW(), 0, NULL);

INSERT INTO user_tbl VALUES ("admin", "1234", "관리자", "남자", "1990-01-01",
	"admin@test.com", "010-1234-5678", "서울시 강남구 역삼동", NOW(), 1, NULL);

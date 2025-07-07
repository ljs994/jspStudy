// 세션
// 세션 생성 : 
 INSERT INTO session_tbl VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY));

// 세션 조회 :
 SELECT * FROM session_tbl WHERE user_token = ?;

// 세션 수정 :
 - 없음

// 세션 삭제 :
 DELETE FROM session_tbl WHERE user_token = ?;

CREATE TABLE session_tbl (
  user_token		VARCHAR(100),
  user_id			VARCHAR(20),
  create_date		DATETIME,
  expiration_date	DATETIME,
  PRIMARY KEY (user_token)
) DEFAULT CHARSET = UTF8;

SELECT * FROM session_tbl;
DESC session_tbl;
DROP TABLE session_tbl;
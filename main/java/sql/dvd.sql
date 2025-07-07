// 영상
// 영상 등록
 INSERT INTO dvd_tbl VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?);

// 영상 조회(전체)
 SELECT * FROM dvd_tbl;

// 영상 조회(1개)
 SELECT * FROM dvd_tbl WHERE dvd_id = ?;

// 영상 조회(조건.저자)
 SELECT * FROM dvd_tbl WHERE dvd_author = ?;
// 영상 조회(조건.가격)
 SELECT * FROM dvd_tbl WHERE dvd_unitPrice BETWEEN ? AND ?;

// 유저 정보 수정 : 
 UPDATE user_tbl SET (?, ?, ?) = (f1, f2, f3) WHERE user_id = ?;

// 영상 삭제 :
 DELETE FROM dvd_tbl WHERE dvd_id = ?;

CREATE TABLE dvd_tbl (
  dvd_id				VARCHAR(10),
  dvd_name 				VARCHAR(20),
  dvd_unitPrice  		INT,
  dvd_author			VARCHAR(20),
  dvd_description 		TEXT,
  dvd_publisher 		VARCHAR(20),
  dvd_category 			VARCHAR(20),	
  dvd_unitsInStock 		LONG,
  dvd_releaseDate   	DATETIME,
  dvd_condition 		VARCHAR(20),
  dvd_thumbnailUrl		VARCHAR(100),
  PRIMARY KEY (dvd_id)
) DEFAULT CHARSET = UTF8;

SELECT * FROM dvd_tbl;
DESC dvd_tbl;
DROP TABLE dvd_tbl;
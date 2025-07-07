// 게시판

CREATE TABLE board_tbl (
  board_index 		INT AUTO_INCREMENT,
  board_id 			VARCHAR(10),
  board_name 		VARCHAR(10),
  board_subject 	VARCHAR(100),
  board_content 	TEXT,
  board_regist_day 	VARCHAR(30),
  board_hit 		INT,
  board_ip 			VARCHAR(20),
  PRIMARY KEY (board_index)
) DEFAULT CHARSET = UTF8;

SELECT * FROM board_tbl;
DESC board_tbl;
DROP TABLE board_tbl;
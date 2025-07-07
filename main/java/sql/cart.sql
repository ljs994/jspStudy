// 장바구니
// DVD 추가 :
 INSERT INTO cart_tbl VALUES (?, ?, 1);

// 장바구니 조회(전체) :
 SELECT * FROM cart_tbl WHERE user_id = ?;

// 장바구니 조회(1개) :
 SELECT * FROM cart_tbl WHERE user_id = ? AND book_id = ?;

// 장바구니 상품+ :
 UPDATE cart_tbl SET (book_count) = (book_count + 1) WHERE user_id = ? AND book_id = ?;

// 장바구니 상품- :
 UPDATE cart_tbl SET (book_count) = (book_count - 1) WHERE user_id = ? AND book_id = ?;

// 장바구니 상품 삭제 :
 DELETE FROM book_tbl WHERE user_id = ? and book_id = ?;
 

CREATE TABLE cart_tbl (
  user_id		VARCHAR(20),
  book_id		VARCHAR(10),
  book_count	VARCHAR(10),
  PRIMARY KEY (user_id, book_id)
) DEFAULT CHARSET = UTF8;

SELECT * FROM cart_tbl;
DESC cart_tbl;
DROP TABLE cart_tbl;
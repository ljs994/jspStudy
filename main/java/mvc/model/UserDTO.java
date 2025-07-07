package mvc.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class UserDTO {
    private String userId;					// 아이디
    private String userPw;					// 비밀번호
    private String userName;				// 이름
    private String userGender;				// 성별
    private LocalDate userBirth;			// 생년월일
    private String userEmail;				// 이메일
    private String userPhone;				// 전화번호
    private String userAddress;				// 주소
    private LocalDateTime userRegistDate;	// 생성일
    private int isAdmin;					// 어드민
    private String authToken;				// 토큰
    
    
    // 게터세터
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public LocalDate getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(LocalDate userBirth) {
		this.userBirth = userBirth;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	public LocalDateTime getUserRegistDate() {
		return userRegistDate;
	}
	public void setUserRegistDate(LocalDateTime userRegistDate) {
		this.userRegistDate = userRegistDate;
	}
	public int getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}
	public String getAuthToken() {
		return authToken;
	}
	public void setAuthToken(String authToken) {
		this.authToken = authToken;
	}

  
}
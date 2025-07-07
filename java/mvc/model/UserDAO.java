package mvc.model;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;

public class UserDAO {
	private static UserDAO instance;

	private UserDAO() {
	}

	public static synchronized UserDAO getInstance() {
		if (instance == null) {
			instance = new UserDAO();
		}
		return instance;
	}

	// 아이디 중복 검사
	public boolean existsById(String userId) {
		String sql = "SELECT 1 FROM user_tbl WHERE user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		} catch (Exception e) {
			throw new RuntimeException("existsById 오류: " + e.getMessage(), e);
		}
	}

	// 회원가입
	public int insert(UserDTO u) {
		String sql = "INSERT INTO user_tbl(" + "user_id, user_pw, user_name, user_gender, "
				+ "user_birth, user_email, user_phone, user_address, user_registdate, is_admin, auth_token"
				+ ") VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, u.getUserId());
			ps.setString(2, u.getUserPw());
			ps.setString(3, u.getUserName());
			ps.setString(4, u.getUserGender());
			ps.setDate(5, Date.valueOf(u.getUserBirth()));
			ps.setString(6, u.getUserEmail());
			ps.setString(7, u.getUserPhone());
			ps.setString(8, u.getUserAddress());
			ps.setTimestamp(9, Timestamp.valueOf(u.getUserRegistDate()));
			ps.setInt(10, u.getIsAdmin());
			ps.setString(11, u.getAuthToken());
			return ps.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException("insert 오류: " + e.getMessage(), e);
		}
	}

	// 내정보 보기
	public UserDTO findById(String userId) {
		String sql = "SELECT * FROM user_tbl WHERE user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					UserDTO u = new UserDTO();
					u.setUserId(rs.getString("user_id"));
					u.setUserPw(rs.getString("user_pw"));
					u.setUserName(rs.getString("user_name"));
					u.setUserGender(rs.getString("user_gender"));
					u.setUserBirth(rs.getDate("user_birth").toLocalDate());
					u.setUserEmail(rs.getString("user_email"));
					u.setUserPhone(rs.getString("user_phone"));
					u.setUserAddress(rs.getString("user_address"));
					u.setUserRegistDate(rs.getTimestamp("user_registdate").toLocalDateTime());
					u.setIsAdmin(rs.getInt("is_admin"));
					u.setAuthToken(rs.getString("auth_token"));

					return u;
				}
			}
		} catch (Exception e) {
			throw new RuntimeException("findById 오류: " + e.getMessage(), e);
		}
		return null;
	}

	// 수정
	public int update(UserDTO u) {
		String sql = "UPDATE user_tbl SET user_pw=?, user_name=?, user_email=?, "
				+ "user_phone=?, user_address=? WHERE user_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, u.getUserPw());
			ps.setString(2, u.getUserName());
			ps.setString(3, u.getUserEmail());
			ps.setString(4, u.getUserPhone());
			ps.setString(5, u.getUserAddress());
			ps.setString(6, u.getUserId());

			return ps.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException("update 오류: " + e.getMessage(), e);
		}
	}

	// 회원탈퇴
	public int delete(String userId) {
		String sql = "DELETE FROM user_tbl WHERE user_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			return ps.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException("delete 오류: " + e.getMessage(), e);
		}
	}
}

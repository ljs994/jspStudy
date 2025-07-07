package mvc.controller;

import mvc.model.UserDTO;
import mvc.model.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/user.do")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO dao = UserDAO.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		switch (action) {
		case "registerForm":
			req.getRequestDispatcher("/member/addMember.jsp").forward(req, resp);
			break;

		case "loginForm":
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
			break;

		case "checkId":
			String userId = req.getParameter("userId");
			boolean exists = dao.existsById(userId);
			resp.setContentType("text/plain; charset=UTF-8");
			resp.getWriter().write(String.valueOf(!exists));
			break;

		case "myInfo":
			HttpSession session = req.getSession(false);
			if (session != null && session.getAttribute("loginUser") != null) {
				String myId = ((UserDTO) session.getAttribute("loginUser")).getUserId();
				UserDTO me = dao.findById(myId);
				req.setAttribute("user", me);
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초");
				String formattedDate = me.getUserRegistDate().format(formatter);
				req.setAttribute("formattedDate", formattedDate);
				req.getRequestDispatcher("/member/myInfo.jsp").forward(req, resp);
			} else {
				resp.sendRedirect(req.getContextPath() + "/user.do?action=loginForm");
			}
			break;

		case "updateForm":
			session = req.getSession(false);
			if (session != null && session.getAttribute("loginUser") != null) {
				String id = ((UserDTO) session.getAttribute("loginUser")).getUserId();
				UserDTO u = dao.findById(id);
				req.setAttribute("user", u);
				req.getRequestDispatcher("/member/edit.jsp").forward(req, resp);
			} else {
				resp.sendRedirect(req.getContextPath() + "/user.do?action=loginForm");
			}
			break;

		case "logout":
			HttpSession logoutSession = req.getSession(false);
			if (logoutSession != null) {
				logoutSession.invalidate();
			}
			resp.sendRedirect(req.getContextPath() + "/welcome.jsp");
			break;

		default:
			resp.sendRedirect(req.getContextPath() + "/user.do?action=loginForm");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 한글 파라미터 처리
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		switch (action) {
		// 회원가입 처리
		case "register":
			UserDTO newUser = buildUser(req);
			dao.insert(newUser);
			// 가입 직후 세션에 로그인 정보 저장하지 않고, 결과 페이지로 이동
			req.setAttribute("newUserId", newUser.getUserId());
			req.getRequestDispatcher("/member/registerResult.jsp").forward(req, resp);
			break;

		// 로그인 처리
		case "login":
			String id = req.getParameter("userId");
			String pw = req.getParameter("userPw");

			UserDTO userDTO = dao.findById(id);

			if (userDTO != null && userDTO.getUserPw().equals(pw)) {
				HttpSession session = req.getSession();
				session.setAttribute("loginUser", userDTO);
				session.setAttribute("sessionId", userDTO.getUserId());
				resp.sendRedirect(req.getContextPath() + "/welcome.jsp");
			} else {
				resp.sendRedirect(req.getContextPath() + "/user.do?action=loginForm&error=1");
			}
			break;

		// 로그아웃
		case "logout":
			HttpSession logoutSession = req.getSession(false);
			if (logoutSession != null) {
				logoutSession.invalidate();
			}
			resp.sendRedirect(req.getContextPath() + "/welcome.jsp");
			break;

		// 내 정보 수정 처리
		case "update":
			UserDTO updated = buildUser(req);
			dao.update(updated);
			// 세션에 저장된 정보도 갱신
			req.getSession().setAttribute("loginUser", updated);
			resp.sendRedirect(req.getContextPath() + "/user.do?action=myInfo&updated=true");
		    break;

		// 회원 탈퇴 처리
		case "delete":
		    HttpSession session = req.getSession(false);
		    if (session != null && session.getAttribute("loginUser") != null) {
		        String deleteId = ((UserDTO) session.getAttribute("loginUser")).getUserId();
		        dao.delete(deleteId);
		        session.invalidate();
		    }
		    resp.sendRedirect(req.getContextPath() + "/member/delete.jsp");
		    break;

		// 기본: 로그인 폼
		default:
			resp.sendRedirect(req.getContextPath() + "/user.do?action=loginForm");
		}
	}

	// 폼 파라미터를 UserDTO에 담아주는 메서드
	private UserDTO buildUser(HttpServletRequest req) {
		UserDTO userDTO = new UserDTO();
		userDTO.setUserId(req.getParameter("userId"));
		userDTO.setUserPw(req.getParameter("userPw"));
		userDTO.setUserName(req.getParameter("name"));
		userDTO.setUserGender(req.getParameter("gender"));

		// 생년월일: null 체크 후 설정
		String birthParam = req.getParameter("birth");
		if (birthParam != null && !birthParam.isEmpty()) {
			userDTO.setUserBirth(LocalDate.parse(birthParam));
		} else {
			// 기존 정보 유지
			HttpSession session = req.getSession(false);
			if (session != null) {
				UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
				if (loginUser != null) {
					userDTO.setUserBirth(loginUser.getUserBirth());
				}
			}
		}
		// 이메일: mail1 + "@" + mail2
		String mail1 = req.getParameter("mail1");
		String mail2 = req.getParameter("mail2");
		userDTO.setUserEmail(mail1 + "@" + mail2);

		// 전화번호: hidden 필드로 합친 값
		userDTO.setUserPhone(req.getParameter("phone"));

		// 주소
		userDTO.setUserAddress(req.getParameter("address"));

		// 가입일시: 수정 시는 기존 값 유지해야 함
		HttpSession session = req.getSession(false);
		if (session != null) {
			UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
			if (loginUser != null) {
				userDTO.setUserRegistDate(loginUser.getUserRegistDate());
				userDTO.setIsAdmin(loginUser.getIsAdmin());
			}
		}

		userDTO.setAuthToken(null); // 기본값 유지
		return userDTO;
	}

}

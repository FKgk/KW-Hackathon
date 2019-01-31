<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userIf" />
<jsp:setProperty name="user" property="sec1" />
<jsp:setProperty name="user" property="sec2" />
<jsp:setProperty name="user" property="sec3" />
<jsp:setProperty name="user" property="sec4" />
<jsp:setProperty name="user" property="deName" />



<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>U-CAMPUS</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		System.out.println("뭐빠짐?" + user.getUserID() + " " + user.getUserPassword() + " " + user.getUserName() + " "
				+ user.getDeName() + " " + user.getUserEmail());

		// 회원가입을 하려는 하나라도 입력이 안 되어서 null 값이 전달되었다면?
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserEmail() == null ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user); //join 이라는 함수가 userDAO 에 선언이 되어있어서 이게 쿼리안에 자동으로 들어가겠지?
			if (result == -1) { // 프라이머리 키인 유저 아이디이기 때문에 이미 존재한다면 -1이 반환될 것
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다!!!!')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				session.setAttribute("userID", user.getUserID()); //회원가입 완료되면 그 세션값 받아서 메인페이지로 이동하게 하려고...!
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}

		if (user.getSec1() == null && user.getSec2() == null && user.getSec3() == null && user.getSec4() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('한 과목도 선택되지 않았습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = 0;
			result = userDAO.join(user);
			System.out.println(result);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.!')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입 완료!')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}
	%>

</body>
</html>

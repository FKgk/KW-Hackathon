<!-- login.jsp 에서 그냥 복붙을 해와서 바디를 비웠다 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%> 
<%
	request.setCharacterEncoding("UTF-8"); //건너오는 모든 데이터를 utf-8 로 받을 수 있게..
%>
    <%-- UTF-8 이 대부분의 언어 문자열을 고를 수 있어서 자주 쓰인다 --%>

<jsp:useBean id="user" class="user.User" scope="page" /> 
<jsp:setProperty name="user" property="userID" /> 
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 페이지</title>
</head>

<body>
<%
String userID = null; //일단 null 로 초기화 하고
if (session.getAttribute("userID") != null) { //로그인이 되어있다면 null 값이 아니라면 그에 해당하는 세션값을 넣어주는 것
	userID = (String) session.getAttribute("userID");
}


if (userID != null) { //그리고 로그인이 되어있다면 이미 로그인이 되었다고 화면을 보여주는 것.
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인 되었습니다.')");
	script.println("location.href='main.jsp'");
	script.println("</script>");
}
UserDAO userDAO = new UserDAO();
			int result = userDAO.login(user.getUserID(), user.getUserPassword());
			
			if (result == 1) { //여기서부터는 스크립트를 실행하는 역할을 하는 거 같다.
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");

			} else if (result == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀렸습니다.')");
				script.println("history.back()"); // 전 페이지로 돌려보내는 것
				script.println("</script>");
			}
			else if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디입니다')");
				script.println("history.back()"); // 전 페이지로 돌려보내는 것
				script.println("</script>");
			}
			else if (result == -2) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('ㅠㅠ 데이터베이스 오류가 발생했습니다!!!!')");
				script.println("history.back()"); // 전 페이지로 돌려보내는 것
				script.println("");
				script.println("</script>");
			}
 %>
</body>
</html>
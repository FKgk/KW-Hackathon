<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<title>KW LIFE</title>
<style type="text/css">
a, a:hover {
   color: #000000;
   text-decoration: none;
}
</style>
</head>
<body>

   <%
      String userID = null;
      if (session.getAttribute("userID") != null) {
         userID = (String) session.getAttribute("userID");
      }
      int pageNumber = 1;
      if (request.getParameter("pageNumber") != null) {
         pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
      }
   %>
   
      <%
      if (userID == null) { //그리고 로그인이 되어있다면 이미 로그인이 되었다고 화면을 보여주는 것.
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('로그인 하세요')");
    		script.println("location.href='login.jsp'");
    		script.println("</script>");
    	}
   %> 
   
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp"> KW UNIVERSITY</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			<% if(userID==null){%>
				<li><a href="login.jsp">U-CAMPUS</a></li>
				<%}else{ %>
				<li><a href="ucammain.jsp">U-CAMPUS</a></li>
				<% }%>
				<li><a href="bbs.jsp">KW LIFE</a></li>
			</ul>
           <%
         	if(userID==null){
         %>
         <ul class="nav navbar-nav navbar-right">
            <li class ="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role = "button" aria-haspopup="true"
                  aria-expanded="false"> 접속하기<span class ="caret"></span></a>
               <ul class="dropdown-menu">
                     <li class="active"><a href="login.jsp">로그인</a></li>
                     <li> <a href="join.jsp">회원가입</a></li>
              </ul>
            </li>
         </ul>
         <%
         	}else{
         %>
           <ul class="nav navbar-nav navbar-right">
            <li class ="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role = "button" aria-haspopup="true"
                  aria-expanded="false"> 회원관리<span class ="caret"></span></a>
               <ul class="dropdown-menu">
                     <li><a href="logoutAction.jsp">로그아웃</a></li>             
              </ul>
            </li>
         </ul>
         <%
         }
         %>
      </div>
      <div class="container">
         <div class="row">
            <table class="table table-striped" style="text-align: center; border: ipx solid #dddddd">
               <thead>
                  <tr>
                     <th style="background-color: #eeeeee; text-align: center;">번호</th>
                     <th style="background-color: #eeeeee; text-align: center;">제목</th>
                     <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                     <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                  </tr>
               </thead>
               <tbody>
                  <%
                     BbsDAO bbsDAO = new BbsDAO();
                     ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                     for (int i = 0; i < list.size(); i++) {
                  %>
                  <tr>
                     <td><%=list.get(i).getBbsID()%></td>
                     <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
                     <td><%=list.get(i).getBbsWriteuserID()%></td>
                     <td><%=list.get(i).getBbsTime().substring(0, 11) + list.get(i).getBbsTime().substring(11, 13)
                        + "시" + list.get(i).getBbsTime().substring(14, 16) + "분"%></td>
                  </tr>
                  <%
                     }
                  %>
               </tbody>
            </table>
            <%
               if (pageNumber != 1) {
            %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
            <%
               }
               if (bbsDAO.nextPage(pageNumber + 1)) {
            %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
            <%
               }
            %>
            <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
         </div>
      </div>
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
      <script src="js/bootstrap.js"></script>
</body>
</html>
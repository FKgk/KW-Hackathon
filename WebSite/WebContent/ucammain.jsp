<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="shs.Sec"%>
<%@ page import="shs.SecDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>

<head>
<title>U-Campus</title>

<style type="text/css">
    a:link {
        color: red;
        text-decoration: none;
    }

    a:visited {
        color: black;
        text-decoration: none;
    }

    a:hover {
        color: blue;
        text-decoration: underline;
    }
</style>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    body {
        font-family: 'Helvetica', sans-serif;
    }

    li {
        list-style: none;
    }

    a {
        text-decoration: none;
    }
</style>
<!-- 헤더 -->
<style>
    #main_header {
        height: 60px;
        line-height: 60px;
        width: 1200px;
        text-align: center;


        background: rgb(202, 84, 5);
        color: white;
    }
</style>
<!-- 네비게이션 -->
<style>
    #main_gnb {
        overflow: hidden;
        background: rgb(48, 0, 0);
        width: 1200px;
        color: white;
    }

    #main_gnb>ul.left {
        overflow: hidden;
        float: left;
    }

    #main_gnb>ul.right {
        overflow: hidden;
        float: right;
    }

    #main_gnb>ul.left>li {
        float: left;
    }

    #main_gnb>ul.right>li {
        float: left;
    }

    /* a 태그 설정 */

    #main_gnb a {
        display: block;
        padding: 10px 20px;
        color: white;
        font-weight: bold;
    }

    body {
        min-width: 1200px;
    }
</style>
<!-- 콘텐츠 -->
<style>
    #wrap {
        overflow: hidden;
    }

    #wrap>#main_lnb {
        float: left;
        width: 200px;
    }

    #wrap>#content_wrap {
        float: left;
        padding: 10px;
        width: 980px;
        margin-right: -200px;

    }

    #wrap>#content_wrap>#content {
        padding-right: 200px;
    }
</style>
<!-- 수직 목록 -->
<style>
    #wrap {
        width: 1200px;
        background: rgba(202, 84, 5, 0.712);
    }

    #main_lnb>ul>li>a {
        display: block;
        height: 40px;
        line-height: 40px;
        padding-left: 15px;
        color: white;
        font-weight: bold;
    }

    #main_lnb_bold {
        font-weight: bold;
        padding: 10px;
        font-size: 25px;
        text-align: center;
    }
</style>
<!-- 본문 -->
<style>
    #content {
        background: white;
        border: 1px solid rgb(255, 255, 255);
    }

    article {
        padding: 20px;
    }
</style>
<!-- 푸터 -->
<style>
    #main_footer {
        position: relative;
        width: 1180px;
        left: 0%;
        text-align: right;
        padding: 10px;
        background: rgb(48, 0, 0);
        color: white;
    }

    #footer_photo {
        float: left;
    }
</style>
<style>
    #detail_list {
        overflow: hidden;
        padding: 10px;
        background: rgb(200, 206, 206);
        padding-bottom: 15px;
        border: 10px solid white;
    }

    #detail_list>ul {
        float: left;
        width: 800px;
    }

    #detail_list>ul>li {
        height: 20px;
        margin-top: 5px;
        padding: 3px 5px;
        color: rgb(0, 0, 0);

        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;

    }

    #detail_list>ul>li.header {
        padding-left: 15px;
    }

    #detail_list>ul>li.header>p {
        font-weight: bold;
        color: rgb(48, 0, 0);
    }

    #table, th, td {
        text-align: center;
        border: 1px solid black;
    }

    #tableset {
        padding: 20px;
    }
</style>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<body>

   <%
      String userID = null; //로그인 안 한 사람들은 null 값에 담기게 되는 것
      if (session.getAttribute("userID") != null) {
    	  System.out.println("여기 유캠 userID : "+session.getAttribute("userID"));
         userID = (String) session.getAttribute("userID");
      }
      if (userID == null) { //그리고 로그인이 되어있다면 이미 로그인이 되었다고 화면을 보여주는 것.
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('로그인 하세요')");
    		script.println("location.href='main.jsp'");
    		script.println("</script>");
    	}
   %> 
   
      <% UserDAO userDAO = new UserDAO();
   User user = userDAO.getList(userID); %>

    <header id="main_header">
        <h1>
            <a href="ucammain.jsp">KW Mini U-Campus</h1>
        </a>
    </header>
    <nav id="main_gnb">
        <ul class="left">
            <li> 
         <a><%=user.getUserName()%></a>

            </li>
        </ul>
        <ul class="right">
            <li>
                <a href="main.jsp">광운대학교 홈페이지</a>
            </li>
            <li>
                <a href="logoutAction.jsp">로그아웃</a>
            </li>
        </ul>
    </nav>
    <div id="wrap">
        <nav id="main_lnb">
            <ul>
                <li id="main_lnb_bold">
                    <a>강의종합정보</a>
                </li>
                <li>
                    <a href="lectureData.jsp">강의자료실</a>
                </li>
                <% if(user.getUserIf()==0){%>
                <li>
                    <a href="#">수강과목 조회</a>
                </li>
                <%}else if(user.getUserIf()==1){ %>
                
                <li>
                    <a href="search.jsp">수강생 관리</a>
                </li>
                <%} %>
            </ul>

        </nav>
        <% if(user.getUserIf()==0){%>
        <div id="content_wrap">

            <div id="detail_list">
                <h2>수강과목</h2>
                <div id="tableset">
                    <table border="table1" width="800px" height="200px">
                        <thead>
                            <th>Name</th>
                            <th>Days / Time</th>
                            <th>Professor</th>
                        </thead>
                        <tbody>
                            <% 
                            SecDAO secDAO = new SecDAO();
                            ArrayList<Sec> secList = secDAO.getstuSec(userID); 
                             for(int i=0;i<secList.size();i++){
                            	 %>
                         <tr>
                            <td><%=secList.get(i).getSecName() %></td>
                            <td><%= secList.get(i).getSecDaysTime()%></td>
                            <td><%=secList.get(i).getSecUserName()%></td>
                        </tr>
                                 
                         <%
                             }
                           %>                
                            </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <% }else if(user.getUserIf()==1){ %>
    
            <div id="content_wrap">

            <div id="detail_list">
                <h2>강의과목</h2>
                <div id="tableset">
                    <table border="table1" width="800px" height="200px">
                        <thead>
                            <th>Name</th>
                            <th>DaysTime</th>
                            <th>Course</th>
                        </thead>
                        <tbody>
                            <% 
                            SecDAO secDAO = new SecDAO();
                            ArrayList<Sec> secList = secDAO.getproSec(userID); 
                             for(int i=0;i<secList.size();i++){
                            	 System.out.println("for문 여기 : "+secList.get(i).getSecName());
                            	 %>
                         <tr>
                            <td><%=secList.get(i).getSecName() %></td>
                            <td><%=secList.get(i).getSecDaysTime()%></td>
                            <td><%=secList.get(i).getSecCoCode() %></td>
                        </tr>
                                 
                         <%
                             }
                           %>                  
                            </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <%}%>
    
    <footer id="main_footer">
        <div id="footer_photo">
            <img src="images/kwu.png" width="180" height="56" />
        </div>
        <h4>　</h4>
        <h4>서울 노원구 광운로 20()월계동 447-1) 광운대학교 TEL. 02-940-5114 / Mail. webadmin@kw.ac.kr</h4>
        <address>COPYRIGHT (C) 2018 DATABASE PROJECT TEAM - KANG SEO CHOI LEE - ALL RIGHTS RESERVED</address>
    </footer>
</body>

</html>
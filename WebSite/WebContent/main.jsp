<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC">
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>MAIN Page</title>
</head>

<style>
#content {
	width: 1200px;
	margin: 0 auto;
	overflow: hidden;
}

#content>#main_section {
	width: 1200px;
	float: left;
}

#content>#hot_issue {
	width: 1200px;
	display: inline-block;
}
</style>
<style media="screen">
.columns {
	column-count: 3;
	border: 0px;
	column-gap: 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.columns figure {
	display: inline-block;
	margin: 10px;
}

.columns figure img {
	width: 350px;
}
</style>

<body>

<%
      String userID = null; //로그인 안 한 사람들은 null 값에 담기게 되는 것
      if (session.getAttribute("userID") != null) {
    	  System.out.println("여기 userID : "+session.getAttribute("userID"));
         userID = (String) session.getAttribute("userID");
      }
      //이 부분이 내가 나중에 유저 아이디를 가져올 때 써야 하는 부분이다!
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
                     <li> <a href="join.jsp">회원 가입</a></li>
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
                  aria-expanded="false"> 회원 관리<span class ="caret"></span></a>
               <ul class="dropdown-menu">
                     <li><a href="logoutAction.jsp">로그아웃</a></li>             
              </ul>
            </li>
         </ul>
         <%
         }
         %>
      </div>
   </nav>

	<div id="content">
		<section id="main_section">
			<div>
				<h1>
					<strong>KW NEWS</strong>
				</h1>
			</div>
			<div class="container">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="item active">
							<img src="images/1.jpg">
						</div>
						<div class="item">
							<img src="images/2.jpg">
						</div>
						<div class="item">
							<img src="images/3.jpg">
						</div>
					</div>
					<a class="left carousel-control" href="#myCarousel"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<div>
				<h1>
					<strong>HOT ISSUE</strong>
				</h1>
			</div>
			<div class="columns">
				<figure>
					<a href="#"> <img src="images/a.jpg">
					</a>
				</figure>
				<figure>
					<a href="#"> <img src="images/b.jpg">
					</a>
				</figure>
				<figure>
					<a href="#"> <img src="images/c.jpg">
					</a>
				</figure>
			</div>
		</section>
</body>

</html>
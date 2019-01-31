<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- UTF-8 이 대부분의 언어 문자열을 고를 수 있어서 자주 쓰인다 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!-- 위의 줄을 사용하면 어떤 기기로 로그인해도 맞춰서 잘 보이게 되는 거임-->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 위의 줄을 사용해서 CSS 파일을 가져오는 것 -->
<title>회원가입 페이지</title>
</head>
<body>

	<nav class="navbar navbar-default">
		<!-- navbar 클래스를 여기서 생성 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">KW UNIVERSITY</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">U-CAMPUS</a></li>
				<li><a href="bbs.jsp">KW LIFE</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"> 접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<!-- class="active" 가 빠진 걸 알 수 있다. -->
						<li class="active"><a href="join.jsp">회원가입</a></li>

						<!-- active 라는 건 현재 선택이 되었다는 것이다. 현재 페이지가 회원가입 페이지이기 때문에 화면 실행해보면 파랗게 이미 로그인이 선택된다는 걸 알 수 있따. -->

					</ul></li>
			</ul>
		</div>
	</nav>
<div class= "container">
      <div class = "col-lg-9" ></div>
      <div class = "col-lg-59">
         <div class = "jumbotron" style="padding-top : 20px;">
          <form method="post" action ="joinAction.jsp">
            <h3 style ="text-align:center;">회원가입 화면</h3>
            <div class="form-group">
               <input type="text" class="form-control" placeholder ="아이디 " name="userID" maxlength="20">
            </div>
            <div class="form-group">
               <input type="password" class="form-control" placeholder ="비밀번호" name="userPassword" maxlength="20">
            </div>
            <div class="form-group">
               <input type="text" class="form-control" placeholder ="이름 " name="userName" maxlength="20">
            </div>
            <div class="form-group">
               <input type="email" class="form-control" placeholder ="E-Mail" name="userEmail" maxlength="30">
            </div>
            
             <div class="form-group" style="text-align:center;">
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-default">
					<input type="radio" autocomplete="off" value="소프트웨어" name="deName">소프트웨어
					</label>
			
	                <label class="btn btn-default">
					<input type="radio" autocomplete="off" value="컴퓨터공학" name="deName">컴퓨터공학
					</label>
				</div>
			</div>
		<div class="container">
  			<div class="column">
            <div class="form-group"  style="text-align:center;">
                <label class="btn btn-default" >
					 <input type="checkbox" autocomplete="off" name="sec1" value="데이터베이스1">데이터 베이스1
				</label>
		
                <label class="btn btn-default">
					 <input type="checkbox" autocomplete="off" name="sec2" value="데이터베이스2">데이터 베이스2
				</label>
			
                <label class="btn btn-default">
					 <input type="checkbox" autocomplete="off" name="sec3" value="알고리즘1">알고리즘 1
				</label>
			
                <label class="btn btn-default">
					 <input type="checkbox" autocomplete="off" name= "sec4" value="알고리즘2">알고리즘 2
				</label>
			</div>
			</div>
			</div>
            <input type="submit" class="btn btn-primary form-control" value="회원가입">
         </form>
         </div>
      </div>
      <div class = "col-lg-4"></div>
      </div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<!-- 애니메이션을 위해서 추가한 jquery -->
	<script src="js/bootstrap.js"></script>
	<!-- bootstrap 에서 기본적으로 제공하는 자바스크립트? 라고 함 -->
</body>
</html>
<!-- placeholder 는 아무것도 입력받지 않았을 때 보여주는 역할 -->

<!-- 회원가입이나 로그인처럼 정보를 숨기고 싶을 때 method post 를 사용하고, 그걸 action 으로 loginactionjsp로 보내겠다는 의미임 -->
<!-- btn group 이랑 data-toggle 얘가 없으면 마치 체크박스를 누르는 것처럼 된다! 체크박스 관련해서 굳이 구현하고 싶다면 얘를 빼면 될 듯 -->

<!-- 로그인 버튼을 누르면 loginaction.jsp 로 넘어가는 걸 알 수 있다! -->
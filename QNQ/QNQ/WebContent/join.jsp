<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/722f172840.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/signup.css">
<meta name="viewpost" content="width=device-width" , initial-scale="1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<link rel="stylesheet" media="(max-device-width: 990px)" type="text/css"
	href="css/signupM.css" />
<title>QnQ</title>
<style>
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
}
</style>
</head>
<body>

	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('로그인' , '이미 로그인 되어있습니다.', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='main.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}
	%>
	<div id="wrapper">
		<div class="form-container">
			<span class="form-heading">회원가입</span>
			<form action="joinAction.jsp" method="post">
				<div class="input-group">
					<i class="fas fa-user"></i> <input type="text" placeholder="아이디"
						required name="userID"> <span class="bar"></span>
				</div>

				<div class="input-group">
					<i class="fas fa-lock"></i> <input type="password"
						placeholder="비밀번호" required name="userPassword"> <span
						class="bar"></span>
				</div>

				<div class="input-group">
					<button type="submit">
						<i class="fab fa-telegram-plane"> </i>
					</button>
				</div>
				<div class="switch-login">
					<a href="main.jsp">메인으로 돌아가기</a>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
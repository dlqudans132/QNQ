<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="js/jquery-1.12.3.min.js"></script>
<link rel="stylesheet" media="(max-device-width: 1000px)"
	type="text/css" href="css/main_m.css" />
<script src="js/main.js"></script>
<title>QnQ</title>

<style>
body {
background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
}

@font-face {
	font-family: 'Cafe24Ohsquare';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/Cafe24Ohsquare.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
</style>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int roomNumber = 0;
	if (session.getAttribute("roomNumber") != null) {
		roomNumber = (int) session.getAttribute("roomNumber");
	}

	if (userID == null) {
	%>


	<div class="main">
		<h1 id="logo" class="ir_text">YOUR CLASS</h1>
		<div id="container" class="container">
			<div id="content" class="content" style="padding-top: 100px">
				<div class="main_class_box">

					<div class="main_class_item join_class" title="JOIN"
						onclick="location.href='joinRoom.jsp'">
						<div class="inner">
							<h2 class="section_title">방 참가하기</h2>

						</div>
					</div>
					<div class="main_class_item login_class" title="LOGIN"
						onclick="location.href='login.jsp'">
						<div class="inner">
							<h2 class="section_title">로그인</h2>

						</div>
					</div>
					<div class="main_class_item create_class" title="SIGNUP"
						onclick="location.href='join.jsp'">
						<div class="inner">
							<h2 class="section_title">회원가입</h2>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<%
		} else {
	%>
	<div class="main">
		<h1 id="logo" class="ir_text">YOUR CLASS</h1>
		<div id="container" class="container">
			<div id="content" class="content" style="padding-top: 100px">
				<div class="main_class_box">
					<div class="main_class_item create_class" title="CREATE"
						onclick="location.href='makeRoom.jsp'">
						<div class="inner">
							<h2 class="section_title">방 생성하기</h2>
						</div>
					</div>
					<div class="main_class_item join_class" title="MY PAGE"
						onclick="location.href='myPage.jsp'">
						<div class="inner">
							<h2 class="section_title">마이페이지</h2>
						</div>
					</div>
					<div class="main_class_item login_class" title="LOGOUT"
						onclick="location.href='logoutAction.jsp'">
						<div class="inner">
							<h2 class="section_title">로그아웃</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<%
		}
	%>

	<script
		src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
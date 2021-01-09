<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="room.Room"%>
<jsp:useBean id="room" class="room.Room" scope="page">
	<jsp:setProperty name="room" property="*" />
</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpost" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/quizCreate.css">
<title>QnQ</title>
<script>
	
</script>
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
		int roomNumber = 0;
	if (session.getAttribute("roomNumber") != null) {
		roomNumber = (int) session.getAttribute("roomNumber");
	}

	// 익명
	String anonymousCode = null;
	if (session.getAttribute("anonymousCode") != null) {
		anonymousCode = (String) session.getAttribute("anonymousCode");
	}
	%>

	<div id="form-div">
		<p class="triangle">닉네임 설정</p>
		<form class="form" id="form1" action="setNickAction.jsp" method="post">
			<p class="email">
				<input name="anonymousNickname" type="text"
					class="validate[required,custom[email]] feedback-input" id="email"
					placeholder="설정을 원하지 않으면 공백을 입력하세요." style="padding-left: 0px;" />
			</p>

			<div class="submit">
				<input type="submit" value="완 료" id="button-blue" />
				<div class="ease"></div>
			</div>
		</form>
	</div>
	<script
		src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
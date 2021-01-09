<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="room.Room"%>
<%@ page import="user.User"%>

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
	background-image: url('image/discord.png'); background-repeat : repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
	background-repeat: repeat;
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
	%>


	<%
		if (userID == null) {
	%>

	<%
		} else {
	%>

	<%
		}
	%>


	<div id="form-div">
		<p class="triangle">방 참가하기</p>
		<form class="form" id="form1" action="joinRoomAction.jsp"
			method="post">
			<p class="email">
				<input name="roomJoinCode" type="text"
					class="validate[required,custom[email]] feedback-input" id="email"
					placeholder="방 코드를 입력하세요." style="padding-left: 0px;" />
			</p>
			<p class="email">
				<input name="roomPassword" type="text"
					class="validate[required,custom[email]] feedback-input" id="email"
					placeholder="방 비밀번호를 입력하세요." style="padding-left: 0px;" />
			</p>
			<div class="submit">
				<input type="submit" value="참가" id="button-blue" />
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
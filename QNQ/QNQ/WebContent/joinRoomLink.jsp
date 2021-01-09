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
		String code = null;
	if (request.getParameter("code") != null) {
		code = (String) request.getParameter("code");
	}
	%>



	<div id="form-div">
		<p class="triangle">방 참가하기</p>
		<form class="form" id="form1"
			action="joinRoomLinkAction.jsp?code=<%=code%>" method="post">

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
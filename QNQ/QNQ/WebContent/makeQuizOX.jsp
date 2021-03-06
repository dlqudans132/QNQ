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
	overflow:hidden;
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
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('퀴즈 생성' , '로그인이 필요한 기능입니다', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("location.href='login.jsp';");
			script.println("}});");
			script.println("});");
			script.println("</script>");
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
		<p class="triangle">OX 퀴즈 생성</p>
		<h2>퀴즈 제목</h2>
		<form class="form" id="form1" action="makeQuizActionOX.jsp" method="post">
			<p class="email">
				<input name="quizTitle" type="text"
					class="validate[required,custom[email]] feedback-input" id="email"
					placeholder="제목을 입력하세요" style="padding-left: 0px;" />
			</p>
			
			<div class="submit">
				<input type="submit" value="퀴즈생성" id="button-blue" />
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
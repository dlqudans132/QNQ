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
		script.println("swal ('퀴즈 생성' , '로그인이 필요한 기능입니다..', {");
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

	<div id="form-div">
		<p class="triangle" style="margin-bottom: 40px">퀴즈 유형 고르기</p>
		<form class="form" id="form1" action="makeQuizFormAction.jsp"
			method="post">
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizForm"
					value="M3">3지선다</button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizForm"
					value="M4">4지선다</button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizForm"
					value="M5">5지선다</button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizForm"
					value="OX">OX</button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizForm"
					value="S">주관식</button>
			</div>
		</form>
	</div>


	<script
		src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
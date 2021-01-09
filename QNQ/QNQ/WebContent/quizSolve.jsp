<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="quizresult.QuizResultDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="room.Room"%>
<%@ page import="room.RoomDAO"%>
<jsp:useBean id="quiz" class="quiz.Quiz" scope="page">
	<jsp:setProperty name="quiz" property="*" />
</jsp:useBean>
<jsp:useBean id="room" class="room.Room" scope="page">
	<jsp:setProperty name="room" property="*" />
</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpost" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/quizCreate.css" />
<title>QnQ</title>
<script>
	
</script>
<style>
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'NotoKR', 'Malgun Gothic', Arial, sans-serif;
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
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	int quizNumber = 0;
	if (request.getParameter("quizNumber") != null) {
		quizNumber = Integer.parseInt(request.getParameter("quizNumber"));
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('퀴즈 풀기' , '비로그인 기능입니다.', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='main.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}
	// 익명
	String anonymousCode = null;
	if (session.getAttribute("anonymousCode") != null) {
		anonymousCode = (String) session.getAttribute("anonymousCode");
	}

	QuizResultDAO quizResultDAO = new QuizResultDAO();
	int solveCheck = quizResultDAO.quizSolveCheck(quizNumber, anonymousCode);

	if (solveCheck == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('퀴즈 풀기' , '이미 퀴즈를 풀었습니다.', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='quizRoom.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}

	QuizDAO quizDAO = new QuizDAO();
	Quiz getQuiz = quizDAO.getQuiz(quizNumber);
	%>
	<div id="form-div">
		<p class="triangle" style="margin-bottom: 40px">문제 풀기</p>
		<h1 style="color: white; font-size: 30px; text-align: center"><%=getQuiz.getQuizTitle()%></h1>
		<form class="form" id="form1"
			action="quizSolveAction.jsp?quizNumber=<%=quizNumber%>" method="post">
			<%
				if (getQuiz.getQuizForm().equals("M3")) {
			%>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect1"
					value="1"><%=getQuiz.getQuizSelect1()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect2"
					value="1"><%=getQuiz.getQuizSelect2()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect3"
					value="1"><%=getQuiz.getQuizSelect3()%></button>
			</div>
			<%
				} else if (getQuiz.getQuizForm().equals("M4")) {
			%>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect1"
					value="1"><%=getQuiz.getQuizSelect1()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect2"
					value="1"><%=getQuiz.getQuizSelect2()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect3"
					value="1"><%=getQuiz.getQuizSelect3()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect4"
					value="1"><%=getQuiz.getQuizSelect4()%></button>
			</div>
			<%
				} else if (getQuiz.getQuizForm().equals("M5")) {
			%>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect1"
					value="1"><%=getQuiz.getQuizSelect1()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect2"
					value="1"><%=getQuiz.getQuizSelect2()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect3"
					value="1"><%=getQuiz.getQuizSelect3()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect4"
					value="1"><%=getQuiz.getQuizSelect4()%></button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizSelect5"
					value="1"><%=getQuiz.getQuizSelect5()%></button>
			</div>
			<%
				} else if (getQuiz.getQuizForm().equals("OX")) {
			%>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizO"
					value="1">O</button>
			</div>
			<div class="submit">
				<button style="margin-bottom: 8px" class="btn" name="quizX"
					value="1">X</button>
			</div>
			<%
				} else if (getQuiz.getQuizForm().equals("S")) {
			%>

			<p class="email">
				<input name="quizSub" type="text"
					class="validate[required,custom[email]] feedback-input" id="email"
					placeholder="주관식 정답을 입력하세요." style="padding-left: 0px;" />
			</p>

			<div class="submit">
				<input type="submit" value="제출" id="button-blue" />
			</div>


			<%
				}
			%>
		</form>
	</div>






	<script
		src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quizresult.QuizResultDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="quiz" class="quiz.Quiz" scope="page">
	<jsp:setProperty name="quiz" property="quizSelect1" />
	<jsp:setProperty name="quiz" property="quizSelect2" />
	<jsp:setProperty name="quiz" property="quizSelect3" />
	<jsp:setProperty name="quiz" property="quizSelect4" />
	<jsp:setProperty name="quiz" property="quizSelect5" />
	<jsp:setProperty name="quiz" property="quizO" />
	<jsp:setProperty name="quiz" property="quizX" />
	<jsp:setProperty name="quiz" property="quizSub" />
</jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
}
</style>
<title>QnQ</title>
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

	int quizNumber = 0;
	if (request.getParameter("quizNumber") != null) {
		quizNumber = Integer.parseInt(request.getParameter("quizNumber"));
	}

	String anonymousCode = null;
	if (session.getAttribute("anonymousCode") != null) {
		anonymousCode = (String) session.getAttribute("anonymousCode");
	}

	QuizDAO quizDAO = new QuizDAO();
	Quiz getQuiz = quizDAO.getQuiz(quizNumber);

	RoomDAO roomDAO = new RoomDAO();
	String roomMaker = roomDAO.getRoomMaker(roomNumber);

	QuizResultDAO quizResultDAO = new QuizResultDAO();
	int solveCheck = quizResultDAO.quizSolveCheck(quizNumber, anonymousCode);

	int result = quizResultDAO.write(quizNumber, roomNumber, roomMaker, anonymousCode, getQuiz.getQuizForm(),
			quiz.getQuizSelect1(), quiz.getQuizSelect2(), quiz.getQuizSelect3(), quiz.getQuizSelect4(),
			quiz.getQuizSelect5(), quiz.getQuizO(), quiz.getQuizX(), quiz.getQuizSub());
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('퀴즈 풀기' , '문제 풀기 실패.', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("history.back()");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		quizDAO.quizHitCntUp(quizNumber);
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('퀴즈 풀기' , '퀴즈 풀기 완료', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='quizRoom.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
		
		
	}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="quiz" class="quiz.Quiz" scope="page">
	<jsp:setProperty name="quiz" property="quizTitle" />
	<jsp:setProperty name="quiz" property="quizSelect1" />
	<jsp:setProperty name="quiz" property="quizSelect2" />
	<jsp:setProperty name="quiz" property="quizSelect3" />
	<jsp:setProperty name="quiz" property="quizSelect4" />
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
	int roomNumber = 0;
	if (session.getAttribute("roomNumber") != null) {
		roomNumber = (int) session.getAttribute("roomNumber");
	}

	if (quiz.getQuizTitle() == null || quiz.getQuizSelect1() == null || quiz.getQuizSelect2() == null
			|| quiz.getQuizSelect3() == null || quiz.getQuizSelect4() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('4지선다' , '입력이 안 된 사항이 있습니다', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("history.back()");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	} else {
		QuizDAO quizDAO = new QuizDAO();
		int result = quizDAO.write(quiz.getQuizTitle(), "M4", userID, quiz.getQuizSelect1(), quiz.getQuizSelect2(),
		quiz.getQuizSelect3(), quiz.getQuizSelect4(), "", roomNumber);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('4지선다' , '생성 실패', {");
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
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('4지선다' , '생성 성공', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("location.href='quizRoom.jsp'");
			script.println("}});");
			script.println("});");
			script.println("</script>");
		}
	}
	%>
</body>
</html>
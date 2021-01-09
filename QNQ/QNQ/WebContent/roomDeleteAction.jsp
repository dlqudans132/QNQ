<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quizstat.QuizStatDAO"%>
<%@ page import="anonymous.AnonymousDAO"%>
<%@ page import="qna.QnaDAO"%>
<%@ page import="quizresult.QuizResultDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

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
	if (request.getParameter("roomNumber") != null) {
		roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
	}

	RoomDAO roomDAO = new RoomDAO();
	QuizDAO quizDAO = new QuizDAO();
	QuizResultDAO quizResultDAO = new QuizResultDAO();
	QuizStatDAO quizStatDAO = new QuizStatDAO();
	AnonymousDAO anonymousDAO = new AnonymousDAO();
	QnaDAO qnaDAO = new QnaDAO();

	int a = roomDAO.roomDelete(roomNumber);
	quizDAO.removeConnectRoomQuiz(roomNumber);
	quizResultDAO.removeConnectRoomQuizResult(roomNumber);
	quizStatDAO.removeConnectRoomQuizStat(roomNumber);
	anonymousDAO.removeConnectRoomAnonymous(roomNumber);
	qnaDAO.removeConnectRoomQna(roomNumber);
	
	if (a == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('방삭제' , '퀴즈방 삭제 실패', {");
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
		script.println("swal ('방삭제' , '퀴즈방 삭제 성공', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='myPage.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}
	%>
</body>
</html>
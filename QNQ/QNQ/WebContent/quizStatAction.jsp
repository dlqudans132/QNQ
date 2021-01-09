<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="quizstat.QuizStatDAO"%>
<%@ page import="quizstat.QuizStat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="room.Room"%>
<%@ page import="room.RoomDAO"%>
<jsp:useBean id="quiz" class="quiz.Quiz" scope="page">
	<jsp:setProperty name="quiz" property="*" />
</jsp:useBean>
<jsp:useBean id="room" class="room.Room" scope="page">
	<jsp:setProperty name="room" property="*" />
</jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
		int quizNumber = 0;
		if (request.getParameter("quizNumber") != null) {
			quizNumber = Integer.parseInt(request.getParameter("quizNumber"));
		}

		QuizStatDAO quizStatDAO = new QuizStatDAO();
		quizStatDAO.updateStat(quizNumber, roomNumber);
		

		QuizDAO quizDAO = new QuizDAO();
		Quiz getQuiz = quizDAO.getQuiz(quizNumber);

		String quizForm = getQuiz.getQuizForm();

		if (quizForm.equals("M3")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='quizStatM3.jsp?quizNumber=" + quizNumber + "&roomNumber=" + roomNumber+"'");
			script.println("</script>");
		} else if (quizForm.equals("M4")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='quizStatM4.jsp?quizNumber=" + quizNumber + "&roomNumber=" + roomNumber+"'");
			script.println("</script>");
		} else if (quizForm.equals("M5")) {

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='quizStatM5.jsp?quizNumber=" + quizNumber + "&roomNumber=" + roomNumber+"'");
			script.println("</script>");
		} else if (quizForm.equals("OX")) {

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='quizStatOX.jsp?quizNumber=" + quizNumber + "&roomNumber=" + roomNumber+"'");
			script.println("</script>");
		} else if (quizForm.equals("S")) {

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='quizStatS.jsp?quizNumber=" + quizNumber + "&roomNumber=" + roomNumber+"'");
			script.println("</script>");
		}
	%>
</body>
</html>
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
		

		session.setAttribute("roomNumber", roomNumber);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='quizRoom.jsp'");
		script.println("</script>");
	%>
</body>
</html>
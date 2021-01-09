<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="quizresult.QuizResultDAO"%>
<%@ page import="quizresult.QuizResult"%>
<%@ page import="anonymous.Anonymous"%>
<%@ page import="anonymous.AnonymousDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="room.Room"%>
<%@ page import="room.RoomDAO"%>

<html>
<link rel="stylesheet" href="css/stat.css">
<link rel="stylesheet" href="css/quizroom.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>QNQ</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0">
	
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
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	int quizNumber = 0;
	if (request.getParameter("quizNumber") != null) {
		quizNumber = Integer.parseInt(request.getParameter("quizNumber"));
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 기능입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	QuizDAO quizDAO = new QuizDAO();
	Quiz getQuiz = quizDAO.getQuiz(quizNumber);
	%>
	<br>
	<h3 style="text-align: center; color: white">
		<%=getQuiz.getQuizTitle()%>
	</h3>
	<div class="wi">
		<form method="post" action="roomCloseAction.jsp">
			<table class="type10">
				<tr class="eve">
					<th>이름</th>
					<th>작성 답안</th>
				</tr>
				<tbody>
					<%
						AnonymousDAO anonymousDAO = new AnonymousDAO();
					QuizResultDAO quizResultDAO = new QuizResultDAO();
					ArrayList<QuizResult> list = quizResultDAO.getSubList(roomNumber, quizNumber);
					for (int i = 0; i < list.size(); i++) {
						int emp = i % 2;
						String anonymousID = list.get(i).getAnonymousID();
					%>

					<tr>
						<th scope="row" class="even<%=emp%>"><%=anonymousDAO.getNickname(anonymousID)%></th>
						<th scope="row" class="even<%=emp%>"><%=quizResultDAO.getSub(anonymousID, quizNumber)%></th>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</form>

		<section class="container" style="background: rgba(0, 0, 0, 0.0)">
			<div class="dropdown" onclick="history.back()">
				돌아가기
			</div>
			<div class="dropdown" onclick="quizStatS.jsp?quizNumber=<%=quizNumber%>">
				새로고침
			</div>


		</section>
	</div>

</body>
</html>
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
<html>
<link rel="stylesheet" href="css/stat.css">
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
	overflow:hidden;
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
	QuizStatDAO quizStatDAO = new QuizStatDAO();
	Quiz getQuiz = quizDAO.getQuiz(quizNumber);
	QuizStat getQuizStat = quizStatDAO.getQuizStat(quizNumber, roomNumber);
	%>
	<br>
	<h3 style="text-align: center; color: white">
		<%=getQuiz.getQuizTitle()%>
	</h3>

	<div class="container">
		<canvas id="myChart" style="background: white">


		</canvas>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous">
		
	</script>
	<!-- 차트 -->

	<script>
		var ctx = document.getElementById('myChart');
		var myChart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : [ 'O : <%=getQuizStat.getQuizO()%>명', 'X : <%=getQuizStat.getQuizX()%>명', ],
				datasets : [ {
					label : '통계',
					data : [<%=getQuizStat.getQuizO()%>,<%=getQuizStat.getQuizX()%> ],
					backgroundColor : [ 'rgba(255, 99, 132, 0.7)',
						'rgba(54, 162, 235, 0.7)',
							'rgba(255, 206, 86, 0.2)' ],
					borderColor : [ 'rgba(255, 99, 13	2, 1)',
							'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)' ],
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	</script>
	<div class="wi">
		<a class="button" href="quizStatAction.jsp?quizNumber=<%=quizNumber%>&roomNumber=<%=roomNumber%>">새로고침</a>
		<a class="button" href="javascript:window.history.back()">돌아가기</a>
	</div>

</body>
</html>
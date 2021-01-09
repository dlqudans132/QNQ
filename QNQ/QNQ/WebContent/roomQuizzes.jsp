<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="qna.QnaDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="quizresult.QuizResultDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="room.Room"%>
<%@ page import="room.RoomDAO"%>
<jsp:useBean id="quiz" class="quiz.Quiz" scope="page">
	<jsp:setProperty name="quiz" property="*" />
</jsp:useBean>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/quizroom.css">
<title>QnQ</title>
<style type="text/css">
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
}
</style>
<script>
	function goBack() {
	window.history.back();
	}
	</script>
</head>
<body>

	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	int roomNumber = 0;
	if (request.getParameter("roomNumber") != null) {
		roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
	}

	session.setAttribute("roomNumber", roomNumber);

	RoomDAO roomDAO = new RoomDAO();
	String roomTitle = roomDAO.getRoomTitle(roomNumber);
	%>
	<div class="wi">
		<form method="post" action="roomCloseAction.jsp">
			<table class="type10">
				<tr class="eve">
					<th>퀴즈 목록</th>
				</tr>
				<thead>
					<tr>
						<th scope="cols">퀴즈방 제목 : <%=roomTitle%></th>

					</tr>
				</thead>
				<tbody>
					<%
						QuizDAO quizDAO = new QuizDAO();
					ArrayList<Quiz> list = quizDAO.getList(pageNumber, roomNumber);
					for (int i = 0; i < list.size(); i++) {
						int emp = i % 2;
					%>

					<th scope="row" class="even<%=emp%>"><a
						onclick="location.href='quizStatAction.jsp?quizNumber=<%=list.get(i).getQuizNumber()%>&roomNumber=<%=roomNumber%>'"><%=list.get(i).getQuizTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%> [ 참가 : <%=list.get(i).getQuizHitCnt()%> ]</a></th>

					</tr>
					<%
						}
					%>

				</tbody>
			</table>
		</form>
		<div class="list_number">
			<div>
				<p>
				<div class="list_n_menu">

					<%
						int startPage = (pageNumber / 10) * 10 + 1;
					if (pageNumber % 10 == 0) {
						startPage -= 10;
					}
					int targetPage = new QuizDAO().targetPage(pageNumber, roomNumber);

					for (int i = startPage; i < pageNumber; i++) {
					%>
					<a href="roomQuizzes.jsp?pageNumber=<%=i%>"><%=i%></a>

					<%
						}
					%>
					<a style="background: blue"
						href="roomQuizzes.jsp?pageNumber=<%=pageNumber%>"><%=pageNumber%></a>


					<%
						for (int i = pageNumber + 1; i < targetPage + pageNumber; i++) {
						if (i < startPage + 10) {
					%>
					<a href="roomQuizzes.jsp?pageNumber=<%=i%>"><%=i%></a>
					<%
						}
					}
					%>
				</div>
				</p>

			</div>
		</div>
		<section class="container">
			<div class="dropdown"
				onclick="goBack()">이전 페이지</div>
			<%
				{
				QnaDAO qnaDAO = new QnaDAO();
				int qnaCntNum = qnaDAO.qnaCnt(roomNumber);
				if (qnaCntNum == 0) {
				} else if (qnaCntNum > 0) {
			%>
			<div class="dropdown"
				onclick="location.href='qnaList.jsp?roomNumber=<%=roomNumber%>'"
				style="color: red">
				질문 (<%=qnaCntNum%>)
			</div>
			<%
				}
			}
			%>

		</section>
	</div>
</body>
</html>
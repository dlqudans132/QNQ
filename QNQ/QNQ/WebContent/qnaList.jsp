<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="qna.QnaDAO"%>
<%@ page import="qna.Qna"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="anonymous.AnonymousDAO"%>
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
<meta name="viewpost" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/quizroom.css">
<script src="js/jquery-1.12.3.min.js"></script>
<script src="js/jquery-1.7.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap"
	rel="stylesheet">
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
		script.println("swal ('QNA' , '비정상적인 접근', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='main.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}

	RoomDAO roomDAO = new RoomDAO();
	String joinCode = roomDAO.getRoomJoinCode(roomNumber);
	String roomTitle = roomDAO.getRoomTitle(roomNumber);
	%>
	<div class="wi">
		<form method="post" action="roomCloseAction.jsp">
			<table class="type10">
				<tr class="eve">
					<th>질문 내용</th>
				<thead>
					<tr>
						<th scope="cols">퀴즈방 제목 : <%=roomTitle%></th>

					</tr>
				</thead>
				<tbody>
					<%
						QnaDAO qnaDAO = new QnaDAO();
					AnonymousDAO anonymousDAO = new AnonymousDAO();
					ArrayList<Qna> list = qnaDAO.getList(pageNumber, roomNumber);
					for (int i = 0; i < list.size(); i++) {
						int emp = i % 2;
						String name;
						if (anonymousDAO.getNickname(list.get(i).getAnonymousID()) == null) {
							name = "";
						} else {
							name = anonymousDAO.getNickname(list.get(i).getAnonymousID());
						}
					%>

					<tr>

						<th scope="row" class="even<%=emp%>">[ <%=name%> ] <%=list.get(i).getQnaQuestion()%></th>
						<%
							}
						%>
					</tr>


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
					int targetPage = new QnaDAO().targetPage(pageNumber, roomNumber);

					for (int i = startPage; i < pageNumber; i++) {
					%>
					<a href="qnaList.jsp?pageNumber=<%=i%>"><%=i%></a>

					<%
						}
					%>
					<a style="background: #343b4d; color: white"
						href="qnaList.jsp?pageNumber=<%=pageNumber%>"><%=pageNumber%></a>


					<%
						for (int i = pageNumber + 1; i < targetPage + pageNumber; i++) {
						if (i < startPage + 10) {
					%>
					<a href="qnaList.jsp?pageNumber=<%=i%>"><%=i%></a>
					<%
						}
					}
					%>
				</div>
				</p>

			</div>
		</div>
		<section class="container" style="background: rgba(0, 0, 0, 0.0)">

			<div class="dropdown"
				onclick="location.href='qnaList.jsp?roomNumber=<%=roomNumber%>'">새로고침
			</div>
			<div class="dropdown" onclick="goBack()">돌아가기</div>
	</div>
	</section>
	</div>
</body>
</html>
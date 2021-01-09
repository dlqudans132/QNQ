<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="qna.QnaDAO"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	background-repeat: repeat;
}
</style>
<script type="text/javascript">
	function autoRefresh_div() {
		var currentLocation = window.location;
		$("#container").load(currentLocation + ' #container');
	}
	setInterval('autoRefresh_div()', 3000);
	function autoRefresh_div2() {
		var currentLocation = window.location;
		$("#reload").load(currentLocation + ' #reload');
	}
	setInterval('autoRefresh_div2()', 3000);
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
	RoomDAO roomDAO2 = new RoomDAO();

	int result = roomDAO2.checkRunning(roomNumber);

	if (result == 0 && userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('퀴즈방' , '방이 닫혔습니다', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='roomCloseActionUnk.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}

	String anonymousCode = null;
	if (session.getAttribute("anonymousCode") != null) {
		anonymousCode = (String) session.getAttribute("anonymousCode");
	}
	RoomDAO roomDAO = new RoomDAO();
	String joinCode = roomDAO.getRoomJoinCode(roomNumber);
	String roomTitle = roomDAO.getRoomTitle(roomNumber);

	if (roomNumber == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('퀴즈방' , '방 참가 실패', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='main.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}
	%>

	<div class="wi" id="reload">
		<form method="post" action="roomCloseAction.jsp">
			<table class="type10" id="type10">
				<tr class="eve">
					<th>퀴즈 목록</th>
				</tr>
				<thead>
					<tr>

						<th scope="cols" <%if (userID == null) {%>
							style="background: linear-gradient(to left, #a655cf, #6955cf);"
							<%}%>>퀴즈방 제목 : <%=roomTitle%></th>

					</tr>
					<tr>
						<%
							if (userID != null) {
						%>
						<th scope="cols">퀴즈방 코드 : <%=joinCode%></th>

						<%
							} else {
						AnonymousDAO anonymousDAO = new AnonymousDAO();
						%>
						<th scope="cols" <%if (userID == null) {%>
							style="background: linear-gradient(to left, #a655cf, #6955cf);"
							<%}%>>이름 : <%=anonymousDAO.getNickname(anonymousCode)%></th>
						<%
							}
						%>
					</tr>
					<%
						if (userID != null) {
					%>
					<tr>
						<th scope="cols">http://210.101.230.148:8080/QNQ/joinRoomLink.jsp?code=<%=joinCode%></th>
					</tr>
					<%
						}
					%>
				</thead>
				<tbody>
					<%
						QuizDAO quizDAO = new QuizDAO();
					ArrayList<Quiz> list = quizDAO.getList(pageNumber, roomNumber);
					for (int i = 0; i < list.size(); i++) {
						int emp = i % 2;
					%>

					<tr>
						<%
							if (userID == null) {
							QuizResultDAO quizResultDAO = new QuizResultDAO();
							int solveCheck = quizResultDAO.quizSolveCheck(list.get(i).getQuizNumber(), anonymousCode);
							if (solveCheck == 1) {
						%>
						<th scope="row" class="even<%=emp%>"><a style="color: blue"><%=list.get(i).getQuizTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%> </a></th>

						<%
							} else {
						%>

						<th scope="row" class="even<%=emp%>"><a
							onclick="location.href='quizSolve.jsp?quizNumber=<%=list.get(i).getQuizNumber()%>'"><%=list.get(i).getQuizTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%></a></th>

						<%
							}
						} else {
						%>

						<th scope="row" class="even<%=emp%>"><a
							onclick="location.href='quizStatAction.jsp?quizNumber=<%=list.get(i).getQuizNumber()%>&roomNumber=<%=roomNumber%>'"><%=list.get(i).getQuizTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%> [ 참가 : <%=list.get(i).getQuizHitCnt()%> ]</a><a
							style="color: blue"
							onclick="location.href='quizDeleteAction.jsp?quizNumber=<%=list.get(i).getQuizNumber()%>'">
								[삭제]</a></th>
						<%
							}
						%>
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
					<a href="quizRoom.jsp?pageNumber=<%=i%>"><%=i%></a>

					<%
						}
					%>
					<a style="background: #343b4d; color: white"
						href="quizRoom.jsp?pageNumber=<%=pageNumber%>"><%=pageNumber%></a>


					<%
						for (int i = pageNumber + 1; i < targetPage + pageNumber; i++) {
						if (i < startPage + 10) {
					%>
					<a href="quizRoom.jsp?pageNumber=<%=i%>"><%=i%></a>
					<%
						}
					}
					%>
				</div>
				</p>

			</div>
		</div>
		<section style="background: rgba(0, 0, 0, 0.0)" class="container"
			id="container">
			<%
				if (userID == null) {
			%>
			<div class="dropdown" id="dropdown"
				onclick="location.href='roomCloseActionUnk.jsp'">닫기</div>
			<div class="dropdown" id="dropdown"
				onclick="location.href='quizRoom.jsp?roomNumber=<%=roomNumber%>'">새로고침
			</div>
			<div class="dropdown" id="dropdown"
				onclick="location.href='qnaQuestion.jsp?roomNumber=<%=roomNumber%>'">질문하기
			</div>
			<%
				} else {
			QnaDAO qnaDAO = new QnaDAO();
			int qnaCntNum = 0;
			qnaCntNum = qnaDAO.qnaCnt(roomNumber);
			%>
			<div class="dropdown" id="dropdown"
				onclick="location.href='quizRoom.jsp?roomNumber=<%=roomNumber%>'">새로고침
			</div>
			<div class="dropdown" id="dropdown"
				onclick="location.href='makeQuiz.jsp'">문제 생성</div>
			<div class="dropdown" id="dropdown"
				onclick="location.href='roomCloseAction.jsp'">닫기</div>
			<%
				if (qnaCntNum == 0) {
			} else if (qnaCntNum > 0) {
			%>
			<div class="dropdown" id="dropdown"
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
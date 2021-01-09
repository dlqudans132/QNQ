<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="quiz.QuizDAO"%>
<%@ page import="quiz.Quiz"%>
<%@ page import="quizresult.QuizResultDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="room.Room"%>
<%@ page import="room.RoomDAO"%>
<html>

<head>
<title>QNQ</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/myPage/assets/css/main.css" />
<noscript>
	<link rel="stylesheet" href="css/myPage/assets/css/noscript.css" />
</noscript>
</head>
<style>
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
}
</style>
<body class="is-preload">

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
	String anonymousCode = null;
	if (session.getAttribute("anonymousCode") != null) {
		anonymousCode = (String) session.getAttribute("anonymousCode");
	}
	RoomDAO roomDAO = new RoomDAO();
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('마이페이지' , '로그인이 필요한 기능입니다..', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='login.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}
	%>

	<%
		if (userID.equals("admin")) {
	%>
	<div id="wrapper">

		<!-- Nav -->
		<nav id="nav">
			<a href="#" class="icon solid fa-home"><span>Home</span></a> <a
				href="#work" class="icon solid fa-folder-plus"><span>방목록</span></a>

		</nav>
		<div id="main">

			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h1><%=userID%></h1>
					<p>
						모든 방의 수 :
						<%=roomDAO.getRoomCntAll()%></p>
					<p>
						<a href="main.jsp">메인</a>
					</p>
				</header>
				<a href="#work" class="jumplink pic"> <span
					class="arrow icon solid fa-chevron-right"><span>See
							my w</span></span> <img src="css/myPage/images/me.jpg" alt="" />
				</a>
			</article>

			<!-- Work -->
			<article id="work" class="panel">
				<div class="room_list_wrap">
					<table class="room_list" style="font-weight: bold">
						<caption>방목록</caption>
						<thead>
							<tr>

								<th>제목</th>
								<th>생성일</th>
								<th>상태</th>
								<th>만든이</th>
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList<Room> list = roomDAO.getListAdmin(pageNumber);
							for (int i = 0; i < list.size(); i++) {
							%>
							<tr>

								<%
									if (list.get(i).getRoomAvailable() == 0) {
								%>


								<td class="tit"><a style="color: black"
									href="roomQuizzes.jsp?roomNumber=<%=list.get(i).getRoomNumber()%>"><%=list.get(i).getRoomTitle()%></a><a
									style="color: blue"
									href="roomDeleteAction.jsp?roomNumber=<%=list.get(i).getRoomNumber()%>">
										[삭제]</a></td>
								<td style="color: black"><%=list.get(i).getRoomDate()%></td>
								<td style="color: black">결과</td>

								<%
									} else if (list.get(i).getRoomAvailable() == 2) {
								%>
								<td class="tit" style="color: blue"><%=list.get(i).getRoomTitle()%></td>
								<td style="color: blue"><%=list.get(i).getRoomDate()%></td>
								<td style="color: blue">삭제</td>
								<%
									} else if (list.get(i).getRoomAvailable() == 1) {
								%>
								<td class="tit" style="color: red"><a
									href="quizRoomConnectAction.jsp?roomNumber=<%=list.get(i).getRoomNumber()%>"><%=list.get(i).getRoomTitle()%>
								</a></td>
								<td style="color: red"><%=list.get(i).getRoomDate()%></td>
								<td style="color: red">진행 중</td>
								<%
									}
								%>
								<td style="color: black"><%=list.get(i).getUserID()%></td>



							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<div class="paging">
						<%
							int startPage = (pageNumber / 10) * 10 + 1;
						if (pageNumber % 10 == 0) {
							startPage -= 10;
						}
						int targetPage = new RoomDAO().targetPage(pageNumber, userID);

						for (int i = startPage; i < pageNumber; i++) {
						%>
						<a href="myPage.jsp?pageNumber=<%=i%>#work"><%=i%></a>

						<%
							}
						%>
						<a style="background: #343b4d; color: white"
							href="myPage.jsp?pageNumber=<%=pageNumber%>#work"><%=pageNumber%></a>


						<%
							for (int i = pageNumber + 1; i < targetPage + pageNumber; i++) {
							if (i < startPage + 10) {
						%>
						<a href="myPage.jsp?pageNumber=<%=i%>#work"><%=i%></a>
						<%
							}
						}
						%>
					</div>
				</div>
			</article>
		</div>

	</div>
	<%
		} else {
	%>



	<!-- Wrapper-->
	<div id="wrapper">

		<!-- Nav -->
		<nav id="nav">
			<a href="#" class="icon solid fa-home"><span>Home</span></a> <a
				href="#work" class="icon solid fa-folder-plus"><span>방목록</span></a>

		</nav>

		<!-- Main -->
		<div id="main">

			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h1><%=userID%></h1>
					<p>
						방의 수 :
						<%=roomDAO.getRoomCnt(userID)%></p>
					<p>
						<a href="main.jsp">메인</a>
					</p>
				</header>
				<a href="#work" class="jumplink pic"> <span
					class="arrow icon solid fa-chevron-right"><span>See
							my w</span></span> <img src="css/myPage/images/me.jpg" alt="" />
				</a>
			</article>

			<!-- Work -->
			<article id="work" class="panel">
				<div class="room_list_wrap">
					<table class="room_list" style="font-weight: bold">
						<caption>방목록</caption>
						<thead>
							<tr>

								<th>제목</th>
								<th>생성일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList<Room> list = roomDAO.getList(pageNumber, userID);
							for (int i = 0; i < list.size(); i++) {
							%>
							<tr>

								<%
									if (list.get(i).getRoomAvailable() == 0) {
								%>


								<td class="tit"><a style="color: black"
									href="roomQuizzes.jsp?roomNumber=<%=list.get(i).getRoomNumber()%>"><%=list.get(i).getRoomTitle()%></a><a
									style="color: blue"
									href="roomDeleteAction.jsp?roomNumber=<%=list.get(i).getRoomNumber()%>">
										[삭제]</a></td>
								<td style="color: black"><%=list.get(i).getRoomDate()%></td>
								<td style="color: black">결과</td>

								<%
									} else if (list.get(i).getRoomAvailable() == 2) {
								%>
								<td class="tit" style="color: blue"><%=list.get(i).getRoomTitle()%></td>
								<td style="color: blue"><%=list.get(i).getRoomDate()%></td>
								<td style="color: blue">삭제</td>
								<%
									} else if (list.get(i).getRoomAvailable() == 1) {
								%>
								<td class="tit" style="color: red"><a
									href="quizRoomConnectAction.jsp?roomNumber=<%=list.get(i).getRoomNumber()%>"><%=list.get(i).getRoomTitle()%>
								</a></td>
								<td style="color: red"><%=list.get(i).getRoomDate()%></td>
								<td style="color: red">진행 중</td>
								<%
									}
								%>



							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<div class="paging">
						<%
							int startPage = (pageNumber / 10) * 10 + 1;
						if (pageNumber % 10 == 0) {
							startPage -= 10;
						}
						int targetPage = new RoomDAO().targetPage(pageNumber, userID);

						for (int i = startPage; i < pageNumber; i++) {
						%>
						<a href="myPage.jsp?pageNumber=<%=i%>#work"><%=i%></a>

						<%
							}
						%>
						<a style="background: #343b4d; color: white"
							href="myPage.jsp?pageNumber=<%=pageNumber%>#work"><%=pageNumber%></a>


						<%
							for (int i = pageNumber + 1; i < targetPage + pageNumber; i++) {
							if (i < startPage + 10) {
						%>
						<a href="myPage.jsp?pageNumber=<%=i%>#work"><%=i%></a>
						<%
							}
						}
						%>
					</div>
				</div>
			</article>
		</div>

		<%
			}
		%>

		<!-- Footer -->
		<div id="footer">
			<ul class="copyright">
				<li>&copy; KnowLex</li>
			</ul>
		</div>
	</div>

	<!-- Scripts -->
	<script src="css/myPage/assets/js/jquery.min.js"></script>
	<script src="css/myPage/assets/js/browser.min.js"></script>
	<script src="css/myPage/assets/js/breakpoints.min.js"></script>
	<script src="css/myPage/assets/js/util.js"></script>
	<script src="css/myPage/assets/js/main.js"></script>

</body>

</html>
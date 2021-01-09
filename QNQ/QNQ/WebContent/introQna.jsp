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
<link rel="stylesheet" href="css/myPage/assets/css/main2.css" />
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

	<!-- Wrapper-->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<article id="home" class="panel intro">
				<header>
					<h2>익명</h2>
					<p>방에 참가할 때 익명으로 참가하거나 닉네임을 설정할 수 있습니다.</p>

				</header>
				<a href="#work" class="jumplink pic"> <img
					src="img/intro/anony1.png" alt="" />
				</a>
			</article>
		</div>

		<!-- Main -->
		<div id="main">
			<br>
		</div>


		<!-- Main -->
		<div id="main">
			<article id="home" class="panel intro">
				<a href="#work" class="jumplink pic"> <img
					src="img/intro/anony2.png" alt="" />
				</a>
				<header>
					<h1>익명으로 질문</h1>
					<p>익명으로 질문하면 자동 생성되는 코드로 입력됩니다.</p>

				</header>
			</article>
		</div>

		<!-- Main -->
		<div id="main">
			<br>
		</div>

		<div id="main">

			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h1>
						<a href="firstPage.jsp">돌아가기</a>
					</h1>
				</header>
			</article>

		</div>

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
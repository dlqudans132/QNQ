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
			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h1>온라인 활동과 오프라인 수업을 하나로</h1>
					<p>혼합형 학습(Blended Learning)을 통해 학습효과를 극대화</p>
				</header>
			</article>
		</div>
		
		<!-- Main -->
		<div id="main">
			<br>
		</div>
		
		<!-- Main -->
		<div id="main">
			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h2>학생들의 이해도 파악을 위한 기능을 제공</h2>
					<p>객관식 퀴즈와 OX퀴즈, 주관식 퀴즈를 지원합니다</p>
				</header>
				<a href="introQuiz.jsp" class="jumplink pic"><span
					class="arrow icon solid fas fa-images"></span><img
					src="img/intro/quiz2.png" alt="" /> </a>
			</article>
		</div>
		
		<!-- Main -->
		<div id="main">
			<br>
		</div>
		
		<!-- Main -->
		<div id="main">
			<!-- Me -->
			<article id="home" class="panel intro">
				<a href="introStat.jsp" class="jumplink pic"><span
					class="arrow icon solid fas fa-images"></span><img
					src="img/intro/stat.png" alt="" /> </a>
				<header>
					<h2>만들었던 퀴즈와 통계 확인 가능</h2>
					<p>통계를 확인하여 학생들의 부족한 부분을 파악할 수 있습니다</p>

				</header>
			</article>
		</div>
		
		<!-- Main -->
		<div id="main">
			<br>
		</div>
		
		<!-- Main -->
		<div id="main">
			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h2>익명으로 질문과 퀴즈 참가</h2>
					<p>퀴즈 참가와 질문하기가 망설여진다면 익명으로 참가가 가능합니다.</p>
				</header>
				<a href="introQna.jsp" class="jumplink pic"><span
					class="arrow icon solid fas fa-images"></span><img
					src="img/intro/anony1.png" alt="" /> </a>
			</article>
		</div>



		<!-- 마지막 부분 -->
		<div id="main">
			<article id="home" class="panel intro">
				<header>
					<h2>
						<a href="main.jsp">시작하기</a>
					</h2>
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
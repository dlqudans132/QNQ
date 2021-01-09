<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="anonymous.AnonymousDAO"%>
<%@ page import="anonymous.Anonymous"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="anonymous" class="anonymous.Anonymous" scope="page" />
<jsp:setProperty name="anonymous" property="anonymousNickname" />


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
}
</style>
<title>QnQ</title>
</head>
<body>
	<%
		int roomNumber = 0;
		if (session.getAttribute("roomNumber") != null) {
			roomNumber = (int) session.getAttribute("roomNumber");
		}

		// 익명
		String anonymousCode = null;
		if (session.getAttribute("anonymousCode") != null) {
			anonymousCode = (String) session.getAttribute("anonymousCode");
		}

		AnonymousDAO anonymousDAO = new AnonymousDAO();
		anonymousDAO.setNickname(anonymousCode, anonymous.getAnonymousNickname());
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('닉네임 설정' , '닉네임 설정 완료', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='quizRoom.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	%>
</body>
</html>
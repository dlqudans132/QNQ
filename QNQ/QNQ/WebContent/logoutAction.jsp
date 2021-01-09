<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>QnQ</title>
<style>
body {
	background-image: url('image/discord.png');
	background-repeat: repeat;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	overflow: hidden;
}
</style>
</head>
<body>
	<%
		session.removeAttribute("userID");

	PrintWriter script = response.getWriter();
	script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
	script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
	script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
	script.println("<script>");
	script.println("$(document).ready(function(){");
	script.println("swal ('로그아웃' , '로그아웃 되었습니다.', {");
	script.println("buttons: {");
	script.println("text: '확인',");
	script.println("}}).then(function(result) {");
	script.println("if(result){");
	script.println("location.href='main.jsp';");
	script.println("}});");
	script.println("});");
	script.println("</script>");
	%>
</body>
</html>
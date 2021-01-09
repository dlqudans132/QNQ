<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="room.Room"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	
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
<title>QnQ</title>
</head>
<body>
	<%
		int roomNumber = 0;
		if (session.getAttribute("roomNumber") != null) {
			roomNumber = (int) session.getAttribute("roomNumber");
		}
		RoomDAO roomDAO = new RoomDAO();

		int a = roomDAO.roomClose(roomNumber);

		if (a == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('퀴즈방' , '퀴즈방 닫기 실패', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("location.href='main.jsp';");
			script.println("}});");
			script.println("});");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			session.removeAttribute("roomNumber");
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('퀴즈방' , '퀴즈방 닫기 성공!', {");
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
</body>
</html>
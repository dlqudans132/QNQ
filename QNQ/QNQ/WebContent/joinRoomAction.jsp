<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="anonymous.AnonymousDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="room" class="room.Room" scope="page">
	<jsp:setProperty name="room" property="roomJoinCode" />
	<jsp:setProperty name="room" property="roomPassword" />
</jsp:useBean>
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
		// 방 생성자
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	// 퀴즈방
	int roomNumber = 0;
	if (session.getAttribute("roomNumber") != null) {
		roomNumber = (int) session.getAttribute("roomNumber");
	}

	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('방참가' , '비로그인 기능입니다', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='main.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}

	if (roomNumber != 0) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('방참가' , '이미 방에 참가되어있습니다', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("location.href='quizRoom.jsp';");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	}
	session.removeAttribute("roomNumber");
	session.removeAttribute("anonymousCode");
	// 익명
	String anonymousCode = null;
	if (session.getAttribute("anonymousCode") != null) {
		anonymousCode = (String) session.getAttribute("anonymousCode");
	}

	else {
		RoomDAO roomDAO = new RoomDAO();
		AnonymousDAO anonymousDAO = new AnonymousDAO();
		roomNumber = roomDAO.checkRoomNumber(room.getRoomJoinCode());
		int anonyCnt = anonymousDAO.anonymousCount();
		anonymousCode = anonymousDAO.anonymousCode(roomNumber, anonyCnt);
		anonymousDAO.join(roomNumber, anonyCnt);
		session.setAttribute("anonymousCode", anonymousCode);
	}
	if (room.getRoomJoinCode() == null || room.getRoomPassword() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
		script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
		script.println("<script>");
		script.println("$(document).ready(function(){");
		script.println("swal ('방참가' , '입력이 안 된 사항이 있습니다', {");
		script.println("buttons: {");
		script.println("text: '확인',");
		script.println("}}).then(function(result) {");
		script.println("if(result){");
		script.println("history.back()");
		script.println("}});");
		script.println("});");
		script.println("</script>");
	} else {
		RoomDAO roomDAO = new RoomDAO();
		int result = roomDAO.checkJoin(room.getRoomJoinCode(), room.getRoomPassword());
		if (result == 3) {
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('방참가' , '방이 존재하지 않거나 비밀번호 틀림', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("history.back()");
			script.println("}});");
			script.println("});");
			script.println("</script>");
		} else if (result == 2) {
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('방참가' , '오류 발생', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("history.back()");
			script.println("}});");
			script.println("});");
			script.println("</script>");
		} else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('방참가' , '닫혀진 방입니다', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("location.href='main.jsp';");
			script.println("}});");
			script.println("});");
			script.println("</script>");
		} else {
			session.setAttribute("roomNumber", roomNumber);
			PrintWriter script = response.getWriter();
			script.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
			script.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
			script.println("<script src='https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js'></script>");
			script.println("<script>");
			script.println("$(document).ready(function(){");
			script.println("swal ('방참가' , '참가 완료', {");
			script.println("buttons: {");
			script.println("text: '확인',");
			script.println("}}).then(function(result) {");
			script.println("if(result){");
			script.println("location.href='setNick.jsp';");
			script.println("}});");
			script.println("});");
			script.println("</script>");
		}

	}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 클래스명 : join_member_page.jsp //  회원가입 페이지 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>회원 가입</h1><br><br><br><br>
	<!-- 회원 가입 양식 -->
	<form action="join_member_process.jsp" method="post">		<!-- 회원가입 넘겨주고~ -->
	
	아이디&nbsp;&nbsp;&nbsp;<input type="text" name="id"><br><br>
	비밀번호&nbsp;&nbsp;&nbsp;<input type="password" name="pw"><br><br>
	이름&nbsp;&nbsp;&nbsp;<input type="text" name="name">	 <br><br>
	휴대전화&nbsp;&nbsp;&nbsp;<input type="text" name="phone"><br><br><br><br><br><br><br><br>
	<input type="submit" value="가입">
	
	</form>
	
	
</body>
</html>
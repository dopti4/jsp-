<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    
<%-- 클래스명 : join_member_process.jsp // 로그인정보 받자 --%>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	
	String sql = String.format("INSERT INTO RBT_Member VALUES(RBT_Member_seq.NEXTVAL, '%s', '%s', '%s', '%s', SYSDATE)", id, pw, name, phone);
	
	System.out.println("실행될 쿼리 : " + sql);
	
	//클래스 동적 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//7. url 변수 생성(깔끔하라고)
	String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";	
	String dbUser = "SCOTT";
	String dbPW = "TIGER";
	
	//8. DB 연결
	Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPW);
	Statement stm = conn.createStatement();	//실행 API
	
	//9. 쿼리 실행 INSERT DELETE UPDATE
	stm.executeUpdate(sql);
	
	//10. 닫아주자!
	stm.close();
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
     <%								//얼러트로 깔끄미
     	out.write("<script>");
		out.write("alert('회원가입에 성공했습니다.'); location.href='index.jsp';");
		out.write("</script>");
     %>
</body>
</html>


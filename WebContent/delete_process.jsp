<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
    
<%-- 클래스명 : delete_process.jsp // 삭제~~ --%>

<%
	request.setCharacterEncoding("utf-8");
	String b_no = request.getParameter("b_no");
	
	String sql = String.format("DELETE FROM RBT_Board WHERE b_no = %s", b_no);
	
	//
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
	
	response.sendRedirect("./board_list.jsp");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
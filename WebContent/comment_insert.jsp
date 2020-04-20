<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    
<%-- 클래스명 : comment_insert 댓글 입력~~ --%>    

<%
	request.setCharacterEncoding("utf-8");
	
	String b_no = request.getParameter("b_no");
	String content = request.getParameter("content");
	String member_no = (String)session.getAttribute("sessionNo");
	String member_name = (String)session.getAttribute("sessionName");
	
	String sql = String.format("INSERT INTO RBT_Comment VALUES (RBT_Comment_seq.NEXTVAL, %s, %s, '%s', '%s', SYSDATE)", 
					member_no, b_no, member_name, content);
	
	System.out.println("실행될 쿼리 : " + sql);
	
	
	
		//6. DB 연동
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
		
		
		response.sendRedirect("./board_view.jsp?b_no="+b_no);
		
		
		//10. 닫아주자!
		stm.close();
		conn.close();
		
		//'./board_view.jsp?b_no="+b_no+"'
		
		//response.sendRedirect("./index.jsp");


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
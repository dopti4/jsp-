<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    
<%-- 검색을 해보자. --%>    

<%
	request.setCharacterEncoding("utf-8");

	String select = request.getParameter("select");
	
	String word = request.getParameter("word");
	
	String sql = "";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";	
	String dbUser = "SCOTT";
	String dbPW = "TIGER";
		
	Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPW);	
	Statement stm = conn.createStatement();				//글목록 가져와야되니까 다시 오픈
														//원래는 위에 있었는데 조회수 때문에 순서 바꿈
	//
	//ResultSet rs = stm.executeQuery(sql);
	
	if(select.equals("title")){
		sql = String.format("SELECT * FROM RBT_Board b, RBT_Member m WHERE b.m_no = m.m_no AND b.b_title LIKE '%%%s%%'", word);
		
	}else if(select.equals("content")){
		sql = String.format("SELECT * FROM RBT_Board b, RBT_Member m WHERE b.m_no = m.m_no AND b.b_content LIKE '%%%s%%'", word);
		
	}else if(select.equals("m_name")){
		sql = String.format("SELECT * FROM RBT_Board b, RBT_Member m WHERE b.m_no = m.m_no AND m.m_name LIKE '%%%s%%'", word);
	}
	
	
	
	ResultSet rs = stm.executeQuery(sql);
		
		
	while(rs.next()){
			
			//변수 받자.
			String b_no = rs.getString("b_no");			//글번호
			String b_title = rs.getString("b_title");	//제목
			String m_name = rs.getString("m_name");		//작성자
			String b_writedate = rs.getString("b_writedate");
			String b_count = rs.getString("b_count"); 
			
			out.print("<tr>");
			
			out.print("<td class="+"col1"+">" + b_no + "</td>");
			out.print("<td class="+"col2"+"><a href='./board_view.jsp?b_no="+b_no+"'>" + b_title + "</a></td>");	//b_no로 링크
			out.print("<td class="+"col3"+">" + m_name + "</td>");
			out.print("<td class="+"col4"+">" + b_writedate + "</td>");
			out.print("<td class="+"col5"+">" + b_count + "</td>");
			
			out.print("</tr>");
			out.println();		
			
		}
		
  	System.out.println("실행된 쿼리 : " + sql);
	
	//
	rs.close();
	//로직 처리~
	
	stm.close();
	conn.close();
	
	
%>

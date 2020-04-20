<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    
<%-- 클래스명 : board_view.jsp // 게시글 내용 --%>    

<%
//
	request.setCharacterEncoding("utf-8");
	
	String b_no = request.getParameter("b_no");
	
	
	String sql = String.format("SELECT * FROM RBT_Member M, RBT_Board B WHERE M.m_no = B.m_no AND B.b_no=%s", b_no);
	
	System.out.println("실행될 쿼리 : " + sql);

	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";	
	String dbUser = "SCOTT";
	String dbPW = "TIGER";
		
	Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPW);
	Statement stm = conn.createStatement();	//실행 API //여기까진 똑같다!
	
	
	
	String sqlUpdate = String.format("UPDATE RBT_Board SET b_count = b_count + 1 WHERE b_no = %s", b_no);
	stm.executeUpdate(sqlUpdate);
	System.out.println("실행 : " + sqlUpdate);
		
	ResultSet rs = stm.executeQuery(sql);
	
	//7. 로직 처리~
	rs.next();	//어차피 글번호에 맞는 내용은 하나뿐이니 while이나 if 안써도 된다.
	
	String title = rs.getString("b_title");
	String content = rs.getString("b_content");
	String name = rs.getString("m_name");
	String count = rs.getString("b_count");
	String writedate = rs.getString("b_writedate");
	
	
	content = content.replaceAll("<", "&lt;");		//소스코드 악용 방지
	content = content.replaceAll(">", "&gt;");
	content = content.replaceAll("\n", "<br>");		//엔터를 br로 바꿔서 소스코드 적용 -> 엔터가 엔터로 인지
	
	//m_no 변수 받자. -> 삭제를 위한 본인확인
	String writerNo = rs.getString("m_no");
	
	//6. 닫어
	rs.close();
	stm.close();
	conn.close();

	 
	
%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8">
<title>클래식기타 커뮤니티</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/board_left.css">
<link rel="stylesheet" type="text/css" href="css/board_view_main.css">
</head>
<body>
<div id="wrap">
<header>
  <a href="index.jsp"><img id="logo" src="img/logo.png"></a>
<nav id="top_menu">
  HOME | LOGIN | JOIN | NOTICE
</nav>
<nav id="main_menu">
  <ul>
    <li><a href="board_list.jsp">자유 게시판</a></li>
    <li><a href="#">기타 연주</a></li>
    <li><a href="#">공동 구매</a></li>
    <li><a href="#">연주회 안내</a></li>
    <li><a href="#">회원 게시판</a></li>
  </ul>
</nav>
</header> <!-- header -->
<aside>
  
	<%
  	String sessionName = (String)session.getAttribute("sessionName");
  	if(sessionName == null){								//비로그인 상태
  	  	
  %>
  <form action="login_process.jsp" method="post">
    <img id="login_title" src="img/ttl_login.png">
    <div id="input_button">									<!-- 로그인 -->
    <ul id="login_input">
      <li><input type="text" name="id"></li>
      <li><input type="password" name="pw"></li>
    </ul>
    <!-- <img id="login_btn" src="img/btn_login.gif"> -->
    <input type="image" src="img/btn_login.gif">				<!-- 로그인버튼 - 인풋타입 이미지 -->
    </div> 
    <div class="clear"></div>
    <div id="join_search">
      <a href="./join_member_page.jsp"><img src="img/btn_join.gif"></a>			<!-- 회원 가입 -->
      <img src="img/btn_search.gif">
    </div>
  </form>
  </article>
  
  <%
  	}else{						//로그인 상태
  %>
	
  <article id="login_box">
    <img id="login_title" src="img/ttl_login.png">
   <%
   		out.print("<div> "+ sessionName + " 님 </div>" );
   %>
   	<br><br><br>
    <a href="./logout_process.jsp">로그아웃</a>
 </article>
	
	<% } %>

  <nav id="sub_menu">
    <ul>
      <li><a href="board_list.jsp">+ 자유 게시판</a></li>
      <li><a href="#">+ 방명록</a></li>
      <li><a href="#">+ 공지사항</a></li>
      <li><a href="#">+ 등업요청</a></li>
      <li><a href="#">+ 포토갤러리</a></li>
    </ul>
  </nav>
  <article id="sub_banner">
    <ul>
      <li><img src="img/banner1.png"></li>
      <li><img src="img/banner2.png"></li>		
      <li><img src="img/banner3.png"></li>
    </ul>	
  </article>
</aside> 

<section id="main">
  <img src="img/comm.gif">
  <h2 id="board_title">자유 게시판 </h2>
  <div id="view_title_box"> 
    <span><%=title %></span>				<!-- 게시글 내용 디테일! -->
    <span id="info"><%=name %> | 조회 : <%=count %> | <%=writedate %></span>
  </div>	
  <p id="view_content">
   <%= content %>
  </p>		
  
<%

	b_no = request.getParameter("b_no");

	String sqlComment = String.format("SELECT * FROM RBT_Comment WHERE b_no = %s", b_no);
	
	System.out.println("실행될 쿼리 : " + sql);
	
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	dbURL = "jdbc:oracle:thin:@localhost:1521:xe";	
	dbUser = "SCOTT";
	dbPW = "TIGER";
		
	conn = DriverManager.getConnection(dbURL, dbUser, dbPW);
	stm = conn.createStatement();	//실행 API //여기까진 똑같다!
	
	
	
		
	rs = stm.executeQuery(sqlComment);
	
	//7. 로직 처리~
	//rs.next();	//어차피 글번호에 맞는 내용은 하나뿐이니 while이나 if 안써도 된다.
	
	
	//content = rs.getString("c_content");
	//name = rs.getString("m_name");
	//writedate = rs.getString("c_writedate");
	
	//m_no 변수 받자. -> 삭제를 위한 본인확인
	//writerNo = rs.getString("m_no");
	
	
	//
	
	while(rs.next()){
			
			//변수 받자.
			content = rs.getString("c_content");
			name = rs.getString("m_name");
			writedate = rs.getString("c_writedate");
			
			
			out.print("<tr>");
			out.print("<td class="+"col3"+">" + name + "</td>  ");
			out.print("<td class="+"col4"+">" + writedate + "</td>  ");
			out.print("<td class="+"col5"+">" + content + "</td><br>");
			
			out.print("</tr>");
			out.println();	
	
	}
	
	
	
	//6. 닫어
	rs.close();
	stm.close();
	conn.close();

%>  
  
  
  <div id="comment_box">
  <form action="comment_insert.jsp" method="post">
    <img id="title_comment" src="img/title_comment.gif">
    <input type="hidden" name="b_no" value="<%=b_no %>">
    <textarea name="content"></textarea>
    <!--  <img id="ok_ripple" src="img/ok_ripple.gif">-->
    <!-- <input type="image" src="img/ok_ripple.gif"> -->	<!-- 망한거 -->
    <!-- <a href="comment_insert.jsp"><img id="ok_ripple" src="img/ok_ripple.gif"></a>  -->	<!-- 댓글 넘겨주자 -->
    
    
    <input type="image" src="img/ok_ripple.gif" id="ok_ripple"> <!-- 댓글 정상작동 -->
    
   </form>
  </div>
  
  
  <div id="buttons">	<!-- <a href='./delete_content_process.jsp?b_no="+b_no+"'> -->
    
    <%
    String sessionNo = (String)session.getAttribute("sessionNo");		//비로그인 삭제 숨겨주기!
	
	if(sessionNo != null && sessionNo.equals(writerNo)){	//앞쪽이 false면 뒤쪽은 검사 안하고 빠져나간다 -> 뒤쪽 널포인터익셉션 안뜸.
	%>
		
    <a href="board_write.jsp"><img src="img/write.png"></a>
    
    <a href="delete_process.jsp?b_no=<%=b_no %>"><img src="img/delete.png"></a>
    
    <%
	}
    %>			
    <a href="board_list.jsp"><img src="img/list.png"></a>
  </div>
</section> <!-- section main -->
<div class="clear"></div>
<footer>
  <img id="footer_logo" src="img/footer_logo.gif">
  <ul id="address">
    <li>서울시 강남구 삼성동 1234 우 : 123-1234</li>  
    <li>TEL : 031-123-1234  Email : email@domain.com</li>
    <li>COPYRIGHT (C) 루바토 ALL RIGHTS RESERVED</li>
  </ul>
  <ul id="footer_sns">
    <li><img src="img/facebook.gif"></li>  
    <li><img src="img/blog.gif"></li>
    <li><img src="img/twitter.gif"></li>
  </ul>
</footer> <!-- footer -->
</div> <!-- wrap -->
</body>
</html>
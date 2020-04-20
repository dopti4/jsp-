<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
    
<%-- 클래스명 : board_list.jsp // 게시판 리스트 --%>    

<%
			//완성된 문장이니까 String.format 쓸 필요 없다.
			//조회수 보이게끔 바꿈
			String sql = "SELECT b.b_no, b.b_title, m.m_name, b.b_writedate, b.b_count, (SELECT COUNT(*) FROM RBT_Comment c WHERE c.b_no=b.b_no) replyCnt FROM RBT_Board b, RBT_Member m WHERE M.m_no = B.m_no ORDER BY b.b_no";
			String sqlCount = "SELECT COUNT(*) AS cnt FROM RBT_Board";	//조회수 쿼리
			
			//복붙!
			System.out.println("실행될 쿼리 : " + sql);
			
			//
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			String dbURL2 = "jdbc:oracle:thin:@localhost:1521:xe";	
			String dbUser2 = "SCOTT";
			String dbPW2 = "TIGER";
				
			Connection conn2 = DriverManager.getConnection(dbURL2, dbUser2, dbPW2);
			Statement stm2 = conn2.createStatement();	//실행 API //여기까진 똑같다!
			
			//
			ResultSet rss = stm2.executeQuery(sqlCount);	//조회수 먼저 찍고 conn, stm, rs 닫고 밑에서 다시 실행해야된다.
			rss.next();										//쿼리 2개니까!
			String cnt = rss.getString("cnt");
			
			
			
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
  <link rel="stylesheet" type="text/css" href="css/board_list_main.css">
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
  	}else{			//로그인 상태
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
      <li><a href="#">+ 등업 요청</a></li>
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
    <div id="total_search">
    
<%
	
	

%>
    
    
      <div id="total">▷ 총 <%=cnt %>개의 게시물이 있습니다.</div>		<!-- 조회수 찍어주고 -->
      
      <%
      	rss.close();			//닫아주고~
      	stm2.close();
      	conn2.close();
      %>
    	
    			<!-- 검색! -->
    	  
      <%
      
      	String select = request.getParameter("select");
  	
  		String word = request.getParameter("word");
      	
      	if(select != null){
      		
      		if(select.equals("title")){
      			sql = String.format("SELECT * FROM RBT_Board b, RBT_Member m WHERE b.m_no = m.m_no AND b.b_title LIKE '%%%s%%'", word);
      			
      		}else if(select.equals("content")){
      			sql = String.format("SELECT * FROM RBT_Board b, RBT_Member m WHERE b.m_no = m.m_no AND b.b_content LIKE '%%%s%%'", word);
      			
      		}else if(select.equals("m_name")){
      			sql = String.format("SELECT * FROM RBT_Board b, RBT_Member m WHERE b.m_no = m.m_no AND m.m_name LIKE '%%%s%%'", word);
      		}
      	}
      %>
      
      <div id="search">
        <div id="select_img"><img src="img/select_search.gif"></div>
        
        <form action="board_list.jsp" method="get">
        <div id="search_select">
          <select name="select">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="m_name">글쓴이</option>
          </select>
          <%
          	//String sql = String.format("select *from board where %s like %'%s'% ",search_select,word);
          %>
        </div>
        <div id="search_input"><input type="text" name="word"></div>
        <div id="search_btn"><input type="image" src="img/search_button.gif"></div>
        </form> 
        
      </div>
    </div>
    
    
    
    <table>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>글쓴이</th>
        <th>일시</th>
        <th>조회수</th>
      </tr>
      
      <%
      	
      	     
		//
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";	
		String dbUser = "SCOTT";
		String dbPW = "TIGER";
			
		Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPW);	
		Statement stm = conn.createStatement();				//글목록 가져와야되니까 다시 오픈
															//원래는 위에 있었는데 조회수 때문에 순서 바꿈
		//
		ResultSet rs = stm.executeQuery(sql);
      
		//로직 처리~
		while(rs.next()){
			
			//변수 받자.
			String b_no = rs.getString("b_no");			//글번호
			String b_title = rs.getString("b_title");	//제목
			String m_name = rs.getString("m_name");		//작성자
			String b_writedate = rs.getString("b_writedate");
			String b_count = rs.getString("b_count"); 
			String b_reply = rs.getString("replyCnt");
			
			out.print("<tr>");
			
			out.print("<td class="+"col1"+">" + b_no + "</td>");
			out.print("<td class="+"col2"+"><a href='./board_view.jsp?b_no="+b_no+"'>" + b_title + " ("+b_reply+")" + "</a></td>");	//b_no로 링크
			out.print("<td class="+"col3"+">" + m_name + "</td>");
			out.print("<td class="+"col4"+">" + b_writedate + "</td>");
			out.print("<td class="+"col5"+">" + b_count + "</td>");
			
			out.print("</tr>");
			out.println();		
			
		}
      
		//
		rs.close();
		stm.close();
		conn.close();			//닫아주고
		
		
		
		
		
		
      %>
      
      <!-- 
      <tr>
        <td class="col1">1</td>
        <td class="col2">
          <a href="board_view.jsp">까스통님의 선물인 보드카가 정말 독하네요!!!</a>
        </td>
        <td class="col3">루바토</td>
        <td class="col4">2017-09-20</td>
        <td class="col5">15</td>
      </tr>
       -->
      
    </table>
    <div id="buttons">
      <div class="col1">◀ 이전 1 다음 ▶</div>
      <div class="col2">
        <img src="img/list.png"> 
        
        <%
			if(sessionName != null){		//로그인 안하면 글 못쓰게
				
		%>		
			<a href="board_write.jsp"><img src="img/write.png"></a>
		<%		
			}
		%>
        
      </div>
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
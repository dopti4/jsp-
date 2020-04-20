<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    

<%-- 클래스명 : index.jsp //  메인 페이지 --%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8">
<title>클래식기타 커뮤니티</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
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
  <article id="login_box">
  
  <%
  	String sessionName = (String)session.getAttribute("sessionName");	
  	if(sessionName == null){							//비로그인 상태
  	  	
  %>
  <form action="login_process.jsp" method="post">
    <img id="login_title" src="img/ttl_login.png">
    <div id="input_button">									
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
  
  <article id="guestbook">
    <div id="guestbook_title">
      <img src="img/ttl_memo.gif">
    </div>
    <ul>
      <li>안녕하세요!</li>
      <li>안녕하세요!</li>
      <li>안녕하세요!</li>
      <li>안녕하세요!</li>
    </ul>
  </article>
</aside>

<section id="main">
  <img src="img/main_img.png">
  <section id="notice_free_youtube">
    <article id="notice"> 	<!-- 공지사항 -->
      <div class="latest_title">
        <img class="latest_img" src="img/latest1.gif">
        <img class="more" src="img/more.gif">
        <div class="clear"></div>					
      </div>
      <div class="latest_content">
        <img class="image" src="img/book_pen.gif">
        <ul class="list">
          <li>
            <div class="subject">루바토 개편과 사이트 이용...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>								
          <li>
            <div class="subject">루바토 개편과 사이트 이용...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>		
          <li>
            <div class="subject">루바토 개편과 사이트 이용...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>	
          <li>
            <div class="subject">루바토 개편과 사이트 이용...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>				
        </ul>							
      </div>
    </article>
    
    		
    		<!-- 메인 퀵 서비스 -->
    		
    <article id="free"> 
    	<!-- 자유 게시판  -->	
      <div class="latest_title">
        <img class="latest_img" src="img/latest2.gif">
        <form action="./board_list.jsp">
        <!-- <img class="more" src="img/more.gif">  -->
        <input style='margin-left: 250px' type="image" src="img/more.gif">	<!-- more 클릭 가능! -->
        </form>
        
        <div class="clear"></div>					
      </div>
      <div class="latest_content">
        <img class="image" src="img/book_pen.gif">
        <ul class="list">
        
        
        <%	//메인에서 바로 게시글~
        	
        	//날짜 줄일려고 쿼리 좀 복잡
	       String sqlMain = "SELECT * FROM (SELECT RBT_Board.b_title, RBT_Board.b_no, to_char(TRUNC (RBT_Board.b_writedate)) b_writedate FROM RBT_Board ORDER BY b_no DESC) WHERE ROWNUM <5";
	      
	       System.out.println("실행될 쿼리 : " + sqlMain);
	 
	       Class.forName("oracle.jdbc.driver.OracleDriver");
	 
	       String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	       String dbUser = "SCOTT";
	       String dbPw = "TIGER";
	 
	       Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	       Statement stm = conn.createStatement();
	       ResultSet rs = stm.executeQuery(sqlMain);
	       
	       while (rs.next()) {
	        String b_title = rs.getString("b_title");
	        String b_writedate = rs.getString("b_writedate");
	        String b_no = rs.getString("b_no");
	     %>
        		
        		<!-- 게시글 누르면 이동! -->
        <li>
         <div class="subject" style="cursor: pointer;" onclick="location.href='./board_view.jsp?b_no=<%=b_no %>'"><%=b_title %></div>
         <div class="date"><%=b_writedate %></div>
         <div class="clear"></div>
       </li> 
       
       <% }
       
	       rs.close();
	       stm.close();
	       conn.close();       
      	%>
        
        
        <!-- 
          <li>
            <div class="subject">까스통님의 선물인 보드카...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>		
          </li>
          <li>
            <div class="subject">까스통님의 선물인 보드카...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>		
          <li>
            <div class="subject">까스통님의 선물인 보드카...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>	
          <li>
            <div class="subject">까스통님의 선물인 보드카...</div>
            <div class="date">2017-09-20</div>
            <div class="clear"></div>	
          </li>	
          -->
          
          							
        </ul>							
      </div>
    </article>		
    
    	
    <article id="youtube">	    <!—YOUTUBE 동영상 -->		
      <div class="latest_title">
        <img class="latest_img" src="img/latest3.gif">
        <img class="more" src="img/more.gif">
        <div class="clear"></div>					
      </div>				
      <img id="youtube_img" src="img/bach.jpg">
    </article>
  </section> <!-- notice_free_youtube -->
  <section id="gallery">
    <img src="img/latest4.gif">
    <div id="gallery_box">
      <div id="gallery_list">
        <div class="items">
          <ul>
            <li><img src="img/img1.jpg"></li>
            <li>기타 페스티벌 4중주</li>
          </ul>
        </div>
        <div class="items">
          <ul>
            <li><img src="img/img1.jpg"></li>
            <li>기타 페스티벌 4중주</li>
          </ul>
        </div>
        <div class="items">
          <ul>
            <li><img src="img/img1.jpg"></li>
            <li>기타 페스티벌 4중주</li>
          </ul>
        </div>
      </div> <!-- galley_list -->
    </div> <!-- gallery_box -->		
  </section> <!-- gallery -->
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
    
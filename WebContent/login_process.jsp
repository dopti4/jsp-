<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    
<%-- 클래스명 : login_process.jsp // 로그인 받자 --%>    

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String sql = String.format("SELECT * FROM RBT_Member WHERE m_id = '%s' AND m_pw = '%s'", id, pw);
	System.out.println("실행될 쿼리 : " + sql);
	
	
	
	//4. DB 연동(갖다 붙이자 똑같다) SELECT는 쪼꼼 다름.
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";	
		String dbUser = "SCOTT";
		String dbPW = "TIGER";
		
		Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPW);
		Statement stm = conn.createStatement();	//실행 API //여기까진 똑같다!
		
		//5. SELECT! -> executeQuery
		ResultSet rs = stm.executeQuery(sql);
		
		//7. 로직 처리~ (아이디 비번 맞는 거 뽑기)
		boolean isSuccess = true;	//변수 생성
		
		if(rs.next()){
			//로그인 성공
			isSuccess = true;
			
			//세션 메모리 할당(접속자당 각각 생성됨.)
			String no = rs.getString("m_no");		//데이터베이스의 기본키를 받겠다.
			session.setAttribute("sessionNo", no);	//해쉬맵 형태 String, Object : 키, 값(어떤 값이든 가능, 인덱스값 넣어주면 좋음.)		
			
			String name = rs.getString("m_name");		//데이터베이스의 기본키를 받겠다.
			session.setAttribute("sessionName", name);
			
		}else{
			//로그인 실패
			isSuccess = false;
		}
		
		//6. 닫어
		rs.close();
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

	<%
								//얼러트로 깔끄미~~ 하고 메인으로 다시
		
		if(isSuccess){
			out.write("<script>");
			out.write("alert('로그인 성공!'); location.href='index.jsp';");
			out.write("</script>");
			
		}else{
			out.write("<script>");
			out.write("alert('아이디 혹은 비밀번호를 다시 확인해주세요.'); location.href='index.jsp';");
			out.write("</script>");
		}
	%>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 클래스명 : logout_process.jsp // 로그아웃 --%>


<% 
	session.invalidate();

	response.sendRedirect("index.jsp");

%>

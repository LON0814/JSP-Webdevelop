<%@page import="java.sql.*"%>
<%@ page import="dbconnclose.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try
{
	Connection conn = null;
	conn = DbConnClose.getConnection();
    
    request.setCharacterEncoding("UTF-8");
    
    String num = request.getParameter("num");

    String insertQuery = "DELETE FROM notice WHERE num=" + num;
    
 	PreparedStatement psmt = conn.prepareStatement(insertQuery);

    psmt.executeUpdate();
 	
    response.sendRedirect("notice_list.jsp");
}
catch (Exception ex)
{
	out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
}
%>
</body>
</html>
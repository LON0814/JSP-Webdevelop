<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbconnclose.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 테이블 생성</title>
</head>
<body>
<%
 // 객체 참조 변수
 Connection conn = null;
 PreparedStatement pstmt = null;
 
 // JDBC 드라이버 로딩(loading JDBC driver) &
 // MariaDB 서버와 데이터베이스 연결(connect server & database)
 conn = DbConnClose.getConnection();
 
 try {
	 // SQL 질의어 처리(perform SQL query(DML))
	 String sql = "CREATE TABLE notice("
			 + "num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
			 + "title VARCHAR(50) NOT NULL,"
			 + "writer VARCHAR(50) NOT NULL,"
			 + "content TEXT NOT NULL,"
			 + "reg_date DATETIME NOT NULL)";
	 pstmt = conn.prepareStatement(sql);
	 pstmt.executeUpdate();
	 out.println("공지사항(notice) 생성 성공!<Br>");
	 
 } catch (SQLException sqlerr) {
	 out.println("SQL 질의처리 오류!" + sqlerr.getMessage());
 } finally {
	 //데이터베이스 연결 종료(close database)
	 DbConnClose.resourceClose(pstmt, conn);
 }
%>

</body>
</html>
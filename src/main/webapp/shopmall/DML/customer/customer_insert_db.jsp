<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>

<%@ page import="dbconnclose.*" %>

<% // 전송 한글 데이터 처리
  request.setCharacterEncoding("UTF-8"); %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객테이블(customer) 개인 고객정보 DB 삽입(customer_insert_db.jsp)</title>
</head>
<body>

<%
  // 전송 데이터(아이디) 확인 및 변수 할당
%>
 <%@ include file="../../common/include/jsp_id_check_irud.txt" %>
<%

 // 객체 참조 변수
 Connection conn = null;
 PreparedStatement pstmt = null;
 ResultSet rset = null;
 
 // JDBC 드라이버 로딩(loading JDBC driver) &
 // MariaDB 서버와 데이터베이스 연결(connection server & database )
 conn = DbConnClose.getConnection();
 
 try {
	 // 아이디 중복 확인
	 String sql = "SELECT * FROM customer WHERE (cust_id = ?)";
	 pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, cust_id);
	 rset = pstmt.executeQuery();
	 
	 if (rset.next()) { // 중복
		 out.print("<script>alret('사용할 수 없는 아이디입니다!!');"
		                + "history.back();"
		       + "</script>");
	 } else {
		 %>
		  <%@ include file="../../common/include/jsp_sql_dbset_iu.txt" %>
		 <%
		// SQL 질의어 처리(perform SQL query(DML))
		// 고객테이블(customer) 튜플 삽입
		sql = "INSERT INTO customer VALUES(?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, cust_id);
		   pstmt.setString(2, cust_pw);
		   pstmt.setString(3, cust_name);
		   pstmt.setString(4, cust_tel_no);
		   pstmt.setString(5, cust_addr);
		   pstmt.setString(6, cust_gender);
		   pstmt.setString(7, cust_email);
		   pstmt.setString(8, LocalDate.now().toString());
		   pstmt.setString(9, "1");
		pstmt.executeUpdate();
	 }
 } catch (SQLException sqlerr) {
	 out.println("SQL 질의처리 오류!" + sqlerr.getMessage());
 } finally {
	 // 데이터베이스 연결 종료(close database)
	 DbConnClose.resourceClose(rset, pstmt, conn);
 }
 
 // 튜플 삽입 후 고객정보 관리 메뉴
 out.println("고객테이블(customer) 튜플 저장 성공!" + "<Br>");
 out.println("<script>alert('회원 가입을 환영합니다!!');"
                 + "location.href = './customer_maintenance.jsp';"
        + "</script>"); 
%>
</body>
</html>
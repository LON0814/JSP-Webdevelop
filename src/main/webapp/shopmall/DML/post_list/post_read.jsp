<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbconnclose.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 열람</title>
</head>
<body>
   <h1>게시글 상세 열람</h1>
   <%
   try {
	   Connection conn = null;
	   conn = DbConnClose.getConnection();
	   
	   request.setCharacterEncoding("UTF-8");
	   
	   // 파라미터로 전해진 게시글 번호 받아오기
	   String num = request.getParameter("num");
	   
	   String insertQuery = "SELECT * FROM board WHERE num=" + num;
	   PreparedStatement psmt = conn.prepareStatement(insertQuery);
	   ResultSet rset = psmt.executeQuery();
   %>
   
   <table border="1">
     <%
     // 정보 있을 시
     while(rset.next()){
    	 %>
    	  <tr>
    	    <!-- 번호 <td> 옆에 DB에서 받아온 num 칼럼값 삽입 -->
    	    <td>번호</td>
    	    <td><%=rset.getInt("num") %></td>
    	  </tr>
    	  <tr>
    	    <!-- 작성일 <td> 옆에 DB에서 받아온 reg_date 칼럼값 삽입 -->
    	    <td>작성일</td>
    	    <td><%=rset.getTimestamp("reg_date") %></td>
    	  </tr>
    	  <tr>
    	    <!-- 작성자 <td> 옆에 DB에서 받아온 writer 칼럼값 삽입 -->
    	    <td>작성자</td>
    	    <td><%=rset.getString("writer") %></td>
    	  </tr>
    	  <tr>
    	    <td>제목</td>
    	    <td><%=rset.getString("title") %></td>
    	  </tr>
    	  <tr>
    	    <td>내용</td>
    	    <td><%=rset.getString("content") %></td>
    	  </tr>
    	  <tr>
    	    <td colspan="2">
    	      <button type=button onclick="location.href='post_list.jsp'">목록으로</button>
    	    </td>
    	  </tr>
    	  <%
     }
     %>
   </table> 
   <%
   } catch (Exception err) {
	   out.println("오류가 발생하였습니다. 오류 메시지 : " + err.getMessage());
   }
   %>

</body>
</html>

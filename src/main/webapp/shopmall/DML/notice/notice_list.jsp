<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbconnclose.*" %>

<%
   int itemsPerPage = 3; // 페이지당 표시할 항목 수
   int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
   int startRow = (currentPage - 1) * itemsPerPage + 1;
   int endRow = startRow + itemsPerPage - 1;

   try {
      Connection conn = DbConnClose.getConnection();
      String countQuery = "SELECT COUNT(*) AS total FROM notice";
      PreparedStatement countPsmt = conn.prepareStatement(countQuery);
      ResultSet countResultSet = countPsmt.executeQuery();
      countResultSet.next();
      int totalItems = countResultSet.getInt("total");

      String insertQuery = "SELECT * FROM notice ORDER BY num DESC LIMIT ?, ?";
      PreparedStatement psmt = conn.prepareStatement(insertQuery);
      psmt.setInt(1, startRow - 1); // Adjust startRow to 0-based index
      psmt.setInt(2, itemsPerPage);
      ResultSet rset = psmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>공지사항</title>
</head>
<body>
   <!-- 게시글 목록 -->
   <h1>공지사항</h1>
   <table border="1">
      <tr>
         <td colspan="5">
            <h3>게시글 제목 클릭시 상세 열람 가능</h3>
         </td>
      </tr>
      <tr>
         <td>번호</td>
         <td>작성자</td>
         <td>제목</td>
         <td>작성일</td>
      </tr>

      <%
         while (rset.next()){
      %>
      <tr>
         <td><%=rset.getInt("num") %></td>
         <td><%=rset.getString("writer") %></td>
         <td><a href="notice_read.jsp?num=<%=rset.getInt("num") %>"><%=rset.getString("title") %></a></td>
         <td><%=rset.getTimestamp("reg_date") %></td>
      </tr>
      <%
         }
      %>
   </table>

   <!-- 페이징 링크 출력 -->
   <%
      int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
      for (int i = Math.max(1, currentPage - 2); i <= Math.min(totalPages, currentPage + 2); i++) {
         if (i == currentPage) {
            out.println("<b>" + i + "</b> ");
         } else {
            out.println("<a href='?page=" + i + "'>" + i + "</a> ");
         }
      }
   %>
<Br><Br>
<a href="../../home/index.jsp">홈페이지</a><p>
</body>
</html>

<%
   } catch (Exception sqlerr) {
      out.println("오류가 발생하였습니다. 오류 메시지 : " + sqlerr.getMessage());
   }
%>
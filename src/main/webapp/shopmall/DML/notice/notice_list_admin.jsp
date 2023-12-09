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
<style>
     ul{
     text-style:none; text-align:center; border-top:1px solid red; border-bottom:1px solid red; padding:10px 0;
     }
     ul li{
     display:inline; text-transform:uppercase; padding:0 10px; letter-spacing:10px;
     }
     ul li a:link {
     text-decoration:none; color:black;
     }
     ul li a:visited {
     text-decoration:none; color:black;
     }
     ul li a:hover{
     text-decoration:underline; color:black;
     }
</style>
</head>
<body>
  <!--  세션 객체의 속성 확인 -->
  <%@ include file="../../common/include/home_ses_check.txt" %>
   <ul>
      <li><a href="../../home/index.jsp" target="_parent">홈페이지</a></li>
      <% 
      if (login) { // 로그인 경우 메뉴
	   out.print("<li><a href='../../DML/customer/customer_maintenance.jsp'" + "target='_parent'>고객정보 관리</a></li>");
      } else {     // 로그아웃 경우 메뉴
    	  out.print("<li><a href='../../DML/customer/customer_insert_form.jsp'" + "target='_parent'>회원가입</a></li>");
      }
      %>
      <li><a href="../../DML/order_sale/ShopMallMain.jsp" target="_parent">상품검색</a></li>
      <li><a href="../../DML/post_list/post_list.jsp" target="_parent">게시판</a></li>
      <li><a href="../../DML/notice/notice_list_admin.jsp" target="_parent">공지사항</a></li>
   </ul>
</body>
<head>
   <meta charset="UTF-8">
   <title>공지사항</title>
   <style>
     table { width:680px; text-align:center; }
     th { background-color:cyan; }
     .num { width:80px; }
     .title { width:300px; }
     .writer { width:100px; }
     .reg_time { width:180px; }
     .setting { width:100px; }
     a:link { text-decoration:none; color:blue; }
     a:visited { text-decoration:none; color:grey; }
     a:hover { text-deocration:none; color:red; }
   </style>
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
         <th class="num">번호</th>
         <th class="writer">작성자</th>
         <th class="title">제목</th>
         <th class="reg_date">작성일</th>
         <th class="setting">관리</th>
      </tr>

      <%
         while (rset.next()){
      %>
      <tr>
         <td><%=rset.getInt("num") %></td>
         <td><%=rset.getString("writer") %></td>
         <td><a href="notice_read.jsp?num=<%=rset.getInt("num") %>"><%=rset.getString("title") %></a></td>
         <td><%=rset.getTimestamp("reg_date") %></td>
         <td>
            <button type="button" value="수정" onClick="location.href='notice_modify.jsp?num=<%=rset.getString("num") %>'">수정</button>
            <button type="button" value="삭제" onClick="location.href='notice_delete_send.jsp?num=<%=rset.getString("num") %>'">삭제</button>
         </td>
      </tr>
      <%
         }
      %>
   <tr>
        <td colspan="5" style="text-align:center;">
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
       </td>
     </tr>
   </table>
   <Br>
   <button type="button" value="신규 글 작성" onClick="location.href='notice_new.jsp'">신규 글 작성</button>

</body>
</html>

<%
   } catch (Exception sqlerr) {
      out.println("오류가 발생하였습니다. 오류 메시지 : " + sqlerr.getMessage());
   }
%>
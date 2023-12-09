<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbconnclose.*" %>
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
    <% 
    String userType = (String) session.getAttribute("userType");
    // userType이 null이거나 "admin"이 아닌 경우 접근 거부
    if (userType == null || !userType.equals("admin")) { 
    	out.print("<li><a href='../../DML/notice/notice_list.jsp'" + "target='_parent'>공지사항</a></li>");
    } else {     
    	out.print("<li><a href='../../DML/notice/notice_list_admin.jsp'" + "target='_parent'>공지사항</a></li>");
    }
    %>
   </ul>
</body>
<head>
<meta charset="UTF-8">
<title>게시글 상세 열람</title>
<style>
   table { width:680px; text-align:center; }
   th { width:100px; background-color:cyan; }
   td { text-align:left; border:1px solid grey;}
</style>
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
	   
	   String insertQuery = "SELECT * FROM notice WHERE num=" + num;
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
    	    <th>번호</th>
    	    <td><%=rset.getInt("num") %></td>
    	  </tr>
    	  <tr>
    	    <!-- 작성일 <td> 옆에 DB에서 받아온 reg_date 칼럼값 삽입 -->
    	    <th>작성일</th>
    	    <td><%=rset.getTimestamp("reg_date") %></td>
    	  </tr>
    	  <tr>
    	    <!-- 작성자 <td> 옆에 DB에서 받아온 writer 칼럼값 삽입 -->
    	    <th>작성자</th>
    	    <td><%=rset.getString("writer") %></td>
    	  </tr>
    	  <tr>
    	    <th>제목</th>
    	    <td><%=rset.getString("title") %></td>
    	  </tr>
    	  <tr>
    	    <th>내용</th>
    	    <td><%=rset.getString("content") %></td>
    	  </tr>
    	  <%
     }
     %>
   </table> 
   <Br>
   <%
   // userType이 null이거나 "admin"이 아닌 경우 접근 거부
   if (userType == null || !userType.equals("admin")) { 
   %>
   <button type=button onclick="location.href='notice_list.jsp'">목록으로</button>
   <%
   } else {
   %>
   <button type="button" onclick="location.href='notice_list_admin.jsp'">목록으로</button>
   <% }
   } catch (Exception err) {
	   out.println("오류가 발생하였습니다. 오류 메시지 : " + err.getMessage());
   }
   %>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>공지사항 작성</title>
<style>
   table { width:680px; text-align:center; }
   th { width:100px; background-color:cyan; }
   input[type=text], textarea { width:100%; }
</style>
</head>
<body>
   <h1>공지사항 작성</h1>
   <!-- 입력값을 전송하기 위한 post method 방식의 form action 선언 -->
   <form action="notice_new_send.jsp" method="post">
     <table>
       <tr>
         <th>작성자</th>
         <td><input type="text" name="writer"></td>
       </tr>
       <tr>
         <th>제목</th>
         <td><input type="text" name="title"></td>
       <tr>
         <th>내용</th>
         <td><textarea rows="10" cols="20" name="content"></textarea></td>
       </tr>
       <tr>
         <td colspan="2">
           <!--  저장 버튼을 누르면 post_read_send.jsp로 연결 -->
           <!--  submit 형식의 button을 통해, post 방식으로 내용 전송 -->
           <button type="submit">저장</button>
           <!--  목록으로 버튼을 누르면 post_list.jsp로 연결 -->
           <button type="button" onclick="location.href='notice_list_admin.jsp'">목록으로</button>
           <!--  초기화 버튼을 누르면 text 입력값 초기화 -->
           <button type="reset">초기화</button>
         </td>
       </tr>
     </table>
   </form>
</body>
</html>
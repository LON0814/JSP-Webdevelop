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
<title>고객정보 갱신(customer_update_form.jsp)</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../common/CSS/common.css">
</head>
<body>
<form name="customer_form" method="post" action="customer_update_retrieval.jsp">
 <table>
  <caption>회원정보 갱신</caption>
  <tr style="border-style:hidden hidden solid hidden;">
   <td colspan="2" style="background-color:white; text-align:right;">
       <span class="msg_red"> * 부분은 필수입력 항목입니다!</span></td>
  </tr>
  
  <%@ include file="../../common/include/html_input1_irud.txt" %>
  <%@ include file="../../common/include/html_input2_rud.txt" %>
  
  <tr>
   <td colspan="2" style="text-align:center;">
       <input type="submit" value="회원정보 검색">
   </td>
  </tr>
 </table>
</form>

</body>
</html>
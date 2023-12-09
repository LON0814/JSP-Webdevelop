<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String[] img ={"clover.jpg", "jewelry.jpg", "cat.jpg", "amulet.jpg", "picture.jpg", "fortune.jpg", "clock.jpg", "bitcoin.jpg", "dreamcatcher.jpg"};
String[] name = {"행운의 네잎클로버", "행운을 부르는 돌", "행운을 부르는 고양이", "행운의 부적", "행운을 부르는 그림", "행운의 포츈쿠키", "행운을 부르는 시계", "행운을 부르는 동전", "행운을 부르는 드림캐쳐"};
String[] price = {"1,500", "3,000", "4,500", "8,000", "15,300", "1000", "35,000", "2000", "7,500"};
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
<title>ShopMallMain JSP</title>
<script type="text/javascript">
function fnCart(name, price) {
	//alert("Name : " + name + "\nPrice : " + price);
	if(confirm("장바구니에 담으시겠습니까?")) {
		location.href = "CartProcess.jsp?name=" + name + "&price=" + price;
	}
}

function fnView() {
	if(confirm("장바구니를 보시겠습니까?")){
		location.href = "CartView.jsp";
	}
}
</script>
</head>
<body>
<div align="center">
	<h3>[행운의 상점]</h3> 
	<table border="1">
		<tr align="right">
			<td colspan="3">
				<input type="button" value="장바구니 보기" onclick="fnView()" />
			</td>
		</tr>
		<%
		for(int i = 0; i < img.length; i++) {
			if(i % 3 == 0) { 
				out.println("<tr align='center'>");
			}
			out.println("<td>");
				out.println("<table>");
					out.println("<tr align='center'>");
						out.println("<td>");
							out.println("<img src = 'images/" + img[i] + "' width='150' height='150' />");
						out.println("</td>");
					out.println("</tr>");
					
					out.println("<tr align='center'>");
						out.println("<td>");
							out.println("<b>" + name[i] + "</b>");
						out.println("</td>");
					out.println("</tr>");
					
					out.println("<tr align='center'>");
						out.println("<td>");
							out.println("<b>￦" + price[i] + "원</b>");
						out.println("</td>");
					out.println("</tr>");
					
					out.println("<tr align='center'>");
						out.println("<td>");
							//한 줄로 쓰기
							//out.println("<input type='button' value='장바구니 담기' onclick='fnCart(\"" + name[i] + "\", \"" + price[i] + "\")' />");
							//두 줄로 쓰기, 닫는 큰 따옴표와 괄호 옆의 띄어쓰기 필수
							out.println("<input type='button' value='장바구니 담기' ");
							out.println("onclick='fnCart(\"" + name[i] + "\", \"" + price[i] + "\")' />");
						out.println("</td>");
					out.println("</tr>");
				out.println("</table>");
			out.println("</td>");
			if(i % 3 == 2) {
				out.println("</tr>");
			}
		}
		%>
	</table>
</div>
</body>
</html>

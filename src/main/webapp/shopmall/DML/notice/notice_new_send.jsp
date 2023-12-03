<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="dbconnclose.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 DB 보내기</title>
</head>
<body>
<%
try {
	Connection conn = null;
	conn = DbConnClose.getConnection();
	
	// 문자열 인코딩 방식
	request.setCharacterEncoding("UTF-8");
	
	// 오늘 날짜 정보 컴퓨터에서 받아올 객체 선언
	Timestamp today_date = new Timestamp(System.currentTimeMillis());
	
	// 파라미터를 통해 전해진 작성자, 제목, 내용 정보를 받아와 각 문자열 변수에 저장
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 게시글 번호를 결정하기 위한 임시 정수형 변수 선언
	int num = 0;
	
	// DB로 전송하기 위한 쿼리문인 insertQuery 문자열 선언(현재 등록된 게시글 갯수 파악)
	String insertQuery = "SELECT MAX(num) from notice";
	
	// SQL 쿼리문 실행 객체 선언
	PreparedStatement psmt = conn.prepareStatement(insertQuery);
	
	// 조회된 결과물 저장을 위한 객체 선언
	ResultSet rset = psmt.executeQuery();
	
	// 받아온 정보 존재시
	while(rset.next()){
		// 앞서 임시 선언한 num 변수에, 가져온 MAX(num) 칼럼값 + 1을 하여 저장
		num = rset.getInt("MAX(num)") + 1;
	}
	
	// DB로 전송을 위해 쿼리문 선언(사용자가 post_new.jsp 폼에서 작성 정보 전송)
	insertQuery = "INSERT INTO notice(num, title, writer, content, reg_date) VALUES (?, ?, ?, ?, ?)";
	
	// SQL 쿼리문을 새로운 내용을 토대로 재실행
	psmt = conn.prepareStatement(insertQuery);
	
	// VALUES ? 값에 하나씩 삽입 및 전송
	psmt.setInt(1, num);
	psmt.setString(2, title);
	psmt.setString(3, writer);
	psmt.setString(4, content);
	psmt.setTimestamp(5, today_date);
	
	// INSERT 하여 반영된 레코드 건수 결과 반환
	psmt.executeUpdate();
	
	// 모두 완료되면, post_list.jsp(글 목록) 폼으로 되돌리기
	response.sendRedirect("notice_list.jsp");
} catch (Exception sqlerr) {
	out.println("오류가 발생하였습니다. 오류 메시지 : " + sqlerr.getMessage());
}
%>

</body>
</html>

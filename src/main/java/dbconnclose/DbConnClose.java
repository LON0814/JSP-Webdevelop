package dbconnclose;         // 패키지이름(소문자)

import java.sql.*;

public class DbConnClose {  // 클래스 이름(대문자)
	
	public static Connection getConnection() {
		
	// JDBC 드라이버 로딩(loading JDBC driver)
	String driverClass = "org.mariadb.jdbc.Driver";
	
	try {
		Class.forName(driverClass);
	} catch (ClassNotFoundException err) {
		System.out.println("JDBC 드라이버 로딩 오류! " + err.getMessage());
	}
	
	// MariaDB 서버와 데이터베이스 연결(connect server & database )
	String url = "jdbc:mariadb://localhost:3306/shopmall";
	String id = "root";   // DB 사용자 아이디
	String pw = "admin";  // DB 사용자 패스워드
	
	Connection conn = null;
	
	try {
		conn = DriverManager.getConnection(url, id, pw);
	} catch (SQLException sqlerr) {
		System.out.println("데이터베이스 연결 오류! " + sqlerr.getMessage());
	}  
	return conn;
	}
	
	// 데이터베이스 연결 종료(close database) - ResultSet, Statement, Connection 순
	public static void resourceClose(ResultSet rset, Statement stmt, Connection conn) {
		
		try {
			if (rset != null) rset.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
			} catch (SQLException sqlerr) {
				System.out.println("데이터베이스 종료 오류! " + sqlerr.getMessage());
				}
		}
	
	public static void resourceClose(Statement stmt, Connection conn) {
		
		try {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
			} catch (SQLException sqlerr) {
				System.out.println("데이터베이스 종료 오류! " + sqlerr.getMessage());
			}
		}
	}
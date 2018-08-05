<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
request.setCharacterEncoding("UTF-8");
// request객체로 받아 올 값들에 대한 인코딩 방식 지정

String userId, userName;
userId = (String)session.getAttribute("userId");
userName = (String)session.getAttribute("userName");
boolean isLogin = false;
if (userId != null)	{ isLogin = true; }		// 로그인 여부를 판단하기 위한 변수
// 로그인 관련 변수들에 대한 설정

Connection conn = null;
String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/db_gg";
Statement stmt = null;
ResultSet rs = null;
// DB연결을 위한 설정
%>

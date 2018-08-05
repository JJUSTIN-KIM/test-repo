<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>

<%
if (userId == null) {
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}

String sql = "select m_pwd from member where m_id = '" + userId + "';";
String m_pwd = "";


try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if(rs.next()){
		m_pwd = rs.getString("m_pwd");
	}
}catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
p {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
}
</style>

<script>
function chkInfo(frm){
	var password = frm.pwd.value.trim();
	
	if(password != <%=m_pwd %>){
		alert("비밀번호가 틀렸습니다.");
		return false;
	}
	return true;
	
}
</script>
<title>Insert title here</title>
</head>
<body>
<div id="div_form">
	<hr width="30%" size="1" color="#d1d1d1" />
	<p align="center">비밀번호 확인</p>
	<hr width="30%" size="1" color="#d1d1d1" />

	<form action="info_form.jsp" name="info_check_form" method="post" onsubmit="return chkInfo(this);">
	<table>
	<tr>
		<td>아이디 :</td>
		<td> <%=userId %> </td>
	</tr>
	
	<tr>
		<td>비밀번호 :</td>
		<td><input type="password" name="pwd" id="pwd"></td>
	</tr>
	
	<tr><td colspan="2">
		<input type="submit" class="btn_style" value="수  정"/>
		<input type="reset"  class="btn_style" value="리  셋"/>
	</td></tr>
	</table>
	</form> 
</div>
</body>
</html>
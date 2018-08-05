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
String sql = "";
String isBasic = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function setAddr(addr) {
	var pos1 = addr.indexOf("|");
	var pos2 = addr.lastIndexOf("|");
	var zip = addr.substring(0, pos1);
	var addr1 = addr.substring(pos1 + 1, pos2);
	var addr2 = addr.substring(pos2 + 1);

	opener.frm_order_process.order_address_zip.value = zip;
	opener.frm_order_process.order_address1.value = addr1;
	opener.frm_order_process.order_address2.value = addr2;
	self.close();
}
</script>
</head>
<body>
<%
if (isLogin) {
%>
	<h3><%=userName %>님의 배송지 목록 입니다.</h3>
	<table border="1">
		<tr>
			<th>주소</th>
			<th>기본주소설정</th>
		</tr>
	<%
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		
		stmt = conn.createStatement();
		
		int num = 0;
		
		sql = "select * from member_address where m_id = '" + userId + "'";
		
		rs = stmt.executeQuery(sql);
		
		String addr = "";
		if (rs.next()) {
			do {
				isBasic = rs.getString("ma_isbasic");
				addr = rs.getString("ma_zip") + "|" + rs.getString("ma_addr1") + "|" + rs.getString("ma_addr2");
				num++;
	%>
	<tr align="center">
		<td><a href="#" onclick="setAddr('<%=addr%>');">[<%=rs.getString("ma_zip") %>] <%=rs.getString("ma_addr1") %> <%=rs.getString("ma_addr2") %></a></td>
		<td>
			<input type="radio" name="isBasic" <%=(isBasic.equals("Y")) ? "checked='checked'" : "" %>/>
		</td>
	</tr>
	<%
			} while (rs.next());
		} else {
			out.println("<tr>");
			out.println("<td colspan='2'>회원님의 주소록에 저장된 주소가 없습니다. MY PAGE -> 주소록 관리 메뉴에서 추가해 주세요.</td>");
			out.println("</tr>");
		}
	} catch(Exception e) {
		out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로고침]을 누르거나 첫 화면으로 이동하세요.");
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
} else {
	out.println("<script>");
	out.println("alert('로그인이 필요합니다.');");
	out.println("self.close();");
	out.println("</script>");
}
%>
	<tr align="center">
		<td colspan="6">
			<input type="button" value="닫기" onclick="self.close();" />
		</td>
	</tr>
</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<% int idx = Integer.valueOf(request.getParameter("idx"));
String id = "";
String sql_point = "", sql_member= "", sql_address = "";;
Statement stmt2 = null, stmt3 = null;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	String sql = "select m_id from member where m_idx = " + idx + ";";

	rs = stmt.executeQuery(sql);
	if(rs.next()){
		id = rs.getString("m_id");
	}
	
	
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();

	sql_member = "update member set ";
	sql_member += "m_pwd = '', m_name = '', m_birth = '', ";
	sql_member += "m_gender = '', m_phone = '', m_email='', ";
	sql_member += "m_point = null, m_isuse = 'N', m_level = ''";
	sql_member += " where m_id = '" + id + "';";
	
	sql_point = "delete from member_point where m_id = '" + id + "';";
	sql_address = "delete from member_address where m_id = '" + id + "';";

	int result = stmt.executeUpdate(sql_member);
	result += stmt2.executeUpdate(sql_point);
	result += stmt3.executeUpdate(sql_address);
	
	
	if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
		out.println("<script>");
		out.println("alert('" + id  + "님이 강제 탈퇴되었습니다.');");
		out.println("location.replace('admin_member.jsp');");
		out.println("</script>");
	}
	else{
		out.println("<script>");
		out.println("alert('잘못되었습니다.');");
		out.println("history.back()");
		out.println("</script>");
		
	}

	
	
	
}catch(Exception e) {
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
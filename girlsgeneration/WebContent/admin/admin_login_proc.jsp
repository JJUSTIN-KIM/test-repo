<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<%
String id = request.getParameter("id").trim();
String pwd = request.getParameter("pwd").trim();

String sql = "select al_name from admin_list where al_id = '" + id + "' and al_pwd = '" + pwd + "' and al_isuse = 'Y'";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		session.setAttribute("adminId", id);
		session.setAttribute("adminName", rs.getString("al_name"));
		response.sendRedirect("inc_admin_html_header.jsp");
	} else {
		out.println("<script>");
		out.println("alert('로그인 실패.');");
		out.println("location.replace('admin_login_form.jsp');");
		out.println("</script>");
	}
} catch(Exception e) {
	out.println("관리자 정보를 찾지 못했습니다.");
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

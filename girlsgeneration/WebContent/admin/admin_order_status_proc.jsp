<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<% 
String o_id = request.getParameter("o_id");
String status = request.getParameter("status");

String sql = "update orders set o_status = '" + status + "' where o_id = '" + o_id + "'";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	int result = stmt.executeUpdate(sql);
	
	if (result != 0) {
		out.println("<script>");
		out.println("alert('정상적으로 수정되었습니다.');");
		out.println("location.replace('admin_order.jsp');");
		out.println("</script>");
	}
} catch(Exception e) {
	out.println("주문 상태 변경 실패");
	e.printStackTrace();
} finally {
	try {
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="inc_header.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
// 사용자가 입력한 정보 받아오기
String name = request.getParameter("name");
String o_id = request.getParameter("o_id");



String sql = "select * from orders where o_name = '" + name + "' and o_id = '" + o_id + "'";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");

	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);

	String msg = "";	// 주문조회가 안되었을 경우 보여줄 메세지 
	
	if (rs.next()) {
		out.println("<script>");
		out.println("location.replace('order_check.jsp?o_id=" + o_id + "');");
		out.println("</script>");
	} else {
		msg = "이름과 주문번호를 다시 확인하시고 로그인해주세요.";
	}
	// 사용자의 아이디가 없을 경우
	if (!msg.equals("")) {
		out.println("<script>");
		out.println("alert('" + msg + "')");
		out.println("location.replace('order_login_form.jsp');");
		out.println("</script>");
	}

} catch(Exception e) {
	out.println("<h3>DB작업에 실패하였습니다.</h3>");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>

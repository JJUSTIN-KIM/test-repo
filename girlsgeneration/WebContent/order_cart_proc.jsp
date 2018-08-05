<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
Statement stmt2 = null;
ResultSet rs2 = null;
String m_id = "";

String idx = request.getParameter("count");
String p_id = request.getParameter("p_id");
if (p_id == null || p_id.equals("")) {
	p_id = request.getParameter("p_id" + idx);
}
String ctype = request.getParameter("ctype");	// 장바구니 추가 or 삭제 여부(in, del)
if (ctype == null || ctype.equals("")) {
	ctype = request.getParameter("ctype" + idx);
}
String selectcolor = request.getParameter("selectcolor");	// 넘어온 색상
if (selectcolor == null || selectcolor.equals("")) {
	selectcolor = request.getParameter("selectcolor" + idx);
}
String selectsize = request.getParameter("selectsize");		// 넘어온 사이즈
if (selectsize == null || selectsize.equals("")) {
	selectsize = request.getParameter("selectsize" + idx);
}
String amount = request.getParameter("selectamount");	// 넘어온 갯수
if (amount == null || amount.equals("")) {
	amount = request.getParameter("selectamount" + idx);
}
String sql = "";
String numSQL = "";
String productSQL = "select * from products where p_id = '" + p_id + "'";
String optionSQL = "select * from products_option where p_id = '" + p_id + "' and po_size = '" + selectsize + "' and po_color = '" + selectcolor + "'";
int height = 0, total_price = 0, delivery_price = 0, p_price = 0, reserve = 0, total_reserve = 0, count = 0, selectamount = 1, oc_num = 0;
String img = "", title = "";
String msg = "";

if (isLogin) {
	m_id = userId;
} else {
	m_id = "비회원";
}

if (amount == null || amount.equals("")) {
	selectamount = 1;
} else {
	selectamount = Integer.parseInt(amount);
}

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	
	stmt = conn.createStatement();
	
	if (ctype.equals("in")) {
		sql = "insert into order_cart (m_id, p_id, po_size, po_color, oc_count) values ";
		sql += "('" + m_id + "', '" + p_id + "', '" + selectsize + "', '" + selectcolor + "', " + selectamount + ")";
		msg = "장바구니에 추가되었습니다.";
	} else if (ctype.equals("up")) {
		sql = "update order_cart set oc_count = " + selectamount + " where m_id = '" + m_id + "' and p_id = '" + p_id + "'";
		sql += " and po_size = '" + selectsize + "' and po_color = '" + selectcolor + "'";
		msg = "수정이 완료되었습니다.";
	} else if (ctype.equals("del")) {
		sql = "delete from order_cart where m_id = '" + m_id + "' and p_id = '" + p_id + "'";
		sql += " and po_size = '" + selectsize + "' and po_color = '" + selectcolor + "'";
		msg = "삭제가 완료되었습니다.";
	} else if (ctype.equals("clear")) {
		sql = "delete from order_cart where m_id = '" + m_id + "'";
		msg = "모두 비웠습니다.";
	} else {
		out.println("<script>");
		out.println("location.replace('main.jsp');");
		out.println("</script>");
	}

	int result = stmt.executeUpdate(sql);

	
	if (result != 0) {
		out.println("<script>");
		out.println("alert('" + msg + "');");
		out.println("location.replace('order_cart.jsp');");
		out.println("</script>");
	} else if (ctype.equals("clear") && result == 0) {
		out.println("<script>");
		out.println("alert('이미 모두 비워진 상태 입니다.');");
		out.println("location.replace('order_cart.jsp');");
		out.println("</script>");
	}
	
} catch(Exception e) {
	out.println("DB작업 오류");
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
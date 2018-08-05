<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
Statement stmt2 = null;		Statement stmt3 = null;		Statement stmt4 = null;

String o_id = request.getParameter("o_id");
String status = request.getParameter("status");
String utype = request.getParameter("utype");
String reserve = request.getParameter("reserve");

String tempSql = "";
if (isLogin) {
	tempSql = "select m_point from member where m_id = '" + userId + "'";
}
int point = 0;

String sql = "";


try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	stmt4 = conn.createStatement();
	if (isLogin) {
		rs = stmt.executeQuery(tempSql);
	}
	if (isLogin && rs.next()) {
		point = rs.getInt("m_point");
		rs.close();
	}
	int result = 0;
	
	if (utype.equals("comp")) {
		if (!(status.equals("D"))) {
			out.println("<script>");
			out.println("alert('구매결정 할 수 없는 상태입니다.');");
			out.println("location.replace('order_conf.jsp');");
			out.println("</script>");
		} else if (!isLogin && status.equals("D")) {
			sql = "update orders set o_status = 'E' where o_id = '" + o_id + "'";
			result = stmt.executeUpdate(sql);
		} else if (isLogin && status.equals("D")) {
			sql = "update orders set o_status = 'E' where o_id = '" + o_id + "'";
			String pointSql = "update member set m_point = " + point + " + " + reserve + " where m_id = '" + userId + "'";
			String pointSql2 = "insert into member_point (m_id, mp_point, mp_isuse, mp_desc) values ('" + userId + "', " + reserve + ", 'N', '구매완료로 지급')";
			
			String levelSql = "select sum(o_totalprice) from orders where m_id = '" + userId + "' and o_status = 'E'";	// 구매결정된 총 액수를 구하여 회원 등급 업그레이드를 결정할 쿼리
			int accVal = 0;			// 구매결정된 총 액수를 담을 변수
			String modLevel = "";	// 변경될 회원 등급을 담을 변수
			rs = stmt.executeQuery(levelSql);
			if (rs.next()) accVal = rs.getInt(1); rs.close();
			
			if (150000 <= accVal && accVal < 300000) modLevel = "S";
			else if (300000 <= accVal && accVal < 500000) modLevel = "G";
			else if (500000 <= accVal && accVal < 1000000) modLevel = "V";
			else if (1000000 <= accVal) modLevel = "M";
			else modLevel = "N";
			
			String upLevelSql = "update member set m_level = '" + modLevel + "' where m_id = '" + userId + "'";
			int levelResult = stmt4.executeUpdate(upLevelSql);
			result = stmt.executeUpdate(sql) + stmt2.executeUpdate(pointSql) + stmt3.executeUpdate(pointSql2) + levelResult;
		}
	} else if (utype.equals("can")) {
		if (!(status.equals("A") || status.equals("B") || status.equals("K"))) {
			out.println("<script>");
			out.println("alert('주문을 취소할 수 없는 상태입니다.');");
			out.println("location.replace('order_conf.jsp');");
			out.println("</script>");
		} else if ((status.equals("A") || status.equals("B") || status.equals("K"))) {
			sql = "update orders set o_status = 'H' where o_id = '" + o_id + "'";
			result = stmt.executeUpdate(sql);
		}
	} else if (utype.equals("exc")) {
		if (!(status.equals("D"))) {
			out.println("<script>");
			out.println("alert('교환할 수 없는 상태입니다.');");
			out.println("location.replace('order_conf.jsp');");
			out.println("</script>");
		} else if (status.equals("D")) {
			sql = "update orders set o_status = 'F' where o_id = '" + o_id + "'";
			result = stmt.executeUpdate(sql);
		}
	} else if (utype.equals("ref")) {
		if (!(status.equals("D"))) {
			out.println("<script>");
			out.println("alert('환불할 수 없는 상태입니다.');");
			out.println("location.replace('order_conf.jsp');");
			out.println("</script>");
		} else if (status.equals("D")) {
			sql = "update orders set o_status = 'G' where o_id = '" + o_id + "'";
			result = stmt.executeUpdate(sql);
		}
	}
	
	if (result != 0) {
		out.println("<script>");
		out.println("alert('처리되었습니다.');");
		out.println("location.replace('order_conf.jsp');");
		out.println("</script>");
	}
} catch(Exception e) {
	out.println("DB작업 실패");
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
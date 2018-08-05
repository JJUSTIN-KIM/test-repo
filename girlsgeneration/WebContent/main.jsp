<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인페이지</title>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="main">
<%
int tmp_num = 0;
String main_pick = "select * from products where p_isnewbest = 'b' order by p_regdate desc, p_release desc, p_idx desc limit 4;";
String main_best = "select * from products where p_isnewbest = 'b' order by p_regdate desc, p_release desc, p_idx desc;";
String main_new = "select * from products where p_isnewbest = 'n' order by p_regdate desc, p_release desc, p_idx desc;";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(main_pick);
%>
<hr />
<table width="1000" cellpadding="0" cellspacing="5" id="main_pick">
<%
	if (rs.next()) {
		do {
%>
		<% tmp_num++; if (tmp_num % 2 == 1) { out.println("<tr align='center'>"); } %>
		<td>
			<a href="product_detail.jsp?p_id=<%=rs.getString("p_id") %>"><input type="image" src="<%=rs.getString("p_img1") %>" width="570" height="400" /></a><br />
		</td>
		<% if (tmp_num % 2 == 0) { out.println("</tr>"); } %>
<%
		} while (rs.next());
%>
</table>
<%
	} else {
		System.out.println("table id : main_pick, select 쿼리 실행 안됨");
		out.println("<script>");
		out.println("location.replace('main.jsp');");
		out.println("</script>");
	}
	rs.close();

	rs = stmt.executeQuery(main_best);
%>
<table width="1000" cellpadding="0" cellspacing="5" id="main_best">
<img src="images/bar_best.jpg" width="1150" height="180" />
<%
	tmp_num = 0;
	if (rs.next()) {
		do {
			tmp_num++;
			if (tmp_num % 4 == 1) { out.println("<tr align='center'>"); }
%>
			<td>
				[상품리뷰 : <%=rs.getString("p_reviewcnt") %> 건]
				<hr width="250" />
				<a href="product_detail.jsp?p_id=<%=rs.getString("p_id") %>"><input type="image" src="<%=rs.getString("p_img1") %>" width="250" height="300" /></a>
				<hr width="250" />
				<%=rs.getString("p_title") %><br />
				<%=rs.getInt("p_price") * ((100 - rs.getInt("p_discount")) / 100) %>원
				<hr width="250" />
			</td>
<%			if (tmp_num % 4 == 0) { out.println("</tr><br /><br />"); }
		} while (rs.next());
		if (tmp_num % 4 == 1) {
			out.println("<td colspan='3' width='750'></td></tr>");
		} else if (tmp_num % 4 == 2) {
			out.println("<td colspan='2' width='500'></td></tr>");
		} else if (tmp_num % 4 == 3) {
			out.println("<td width='250'></td></tr>");
		}
%>
</table>
<%
	} else {
		System.out.println("table id : main_best, select 쿼리 실행 안됨");
		out.println("<script>");
		out.println("location.replace('main.jsp');");
		out.println("</script>");
	}
	rs.close();

	rs = stmt.executeQuery(main_new);
%>
<table width="1000" cellpadding="0" cellspacing="5" id="main_new">
<img src="images/bar_new.jpg" width="1150" height="180" />
<%
	tmp_num = 0;
	if (rs.next()) {
		do {
			tmp_num++;
			if (tmp_num % 4 == 1) { out.println("<tr align='center'>"); }
%>
			<td>
				[상품리뷰 : <%=rs.getString("p_reviewcnt") %> 건]
				<hr width="250" />
				<a href="product_detail.jsp?p_id=<%=rs.getString("p_id") %>"><input type="image" src="<%=rs.getString("p_img1") %>" width="250" height="300" /></a>
				<hr width="250" />
				<%=rs.getString("p_title") %><br />
				<%=rs.getInt("p_price") * ((100 - rs.getInt("p_discount")) / 100) %>원
				<hr width="250" />
			</td>
<%			if (tmp_num % 4 == 0) { out.println("</tr><br /><br />"); }
		} while (rs.next());
		if (tmp_num % 4 == 1) {
			out.println("<td colspan='3' width='750'></td></tr>");
		} else if (tmp_num % 4 == 2) {
			out.println("<td colspan='2' width='500'></td></tr>");
		} else if (tmp_num % 4 == 3) {
			out.println("<td width='250'></td></tr>");
		}
%>
</table>
<%
	} else {
		System.out.println("table id : main_new, select 쿼리 실행 안됨");
		out.println("<script>");
		out.println("location.replace('main.jsp');");
		out.println("</script>");
	}
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		if (rs != null) { rs.close(); }
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>


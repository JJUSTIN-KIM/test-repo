<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String isnb = request.getParameter("nb");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>제품 NEW/BEST 목록 페이지</title>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="product_newbest">
<%
int tmp_num = 0;
String product_list_nb = "select * from products where p_isnewbest = '" + isnb + "' order by p_idx desc;";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	System.out.println(isnb);
	rs = stmt.executeQuery(product_list_nb);
%>
<div id="isnb_img">
<% if (isnb.equals("n")) { %>
<input type="image" src="images/top_menu_new.jpg" />
<% } else if (isnb.equals("b")) { %>
<input type="image" src="images/top_menu_best.jpg" />
<% } %>
</div>
<table width="1000" cellpadding="0" cellspacing="5" id="tbl_product_list">
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
				<hr width="250"/>
				<%=rs.getString("p_title") %><br />
				<%=rs.getInt("p_price") * ((100 - rs.getInt("p_discount")) / 100) %>원
				<hr width="250"/>
			</td>
<%			if (tmp_num % 4 == 0) { out.println("</tr>"); }
		} while (rs.next());
%>
</table>
<%
	} else {
		System.out.println("쿼리 실행 안됨");
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
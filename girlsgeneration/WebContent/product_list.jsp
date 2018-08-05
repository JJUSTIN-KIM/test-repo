<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String cb_idx = request.getParameter("cb");
String cm_idx = request.getParameter("cm");
String sort = request.getParameter("sort");
String tmpPage = request.getParameter("cpage");
String keyword = request.getParameter("keyword");

String heellow = request.getParameter("heellow");
String heelmid = request.getParameter("heelmid");
String heelhigh = request.getParameter("heelhigh");
String size210 = request.getParameter("size210");
String size215 = request.getParameter("size215");
String size220 = request.getParameter("size220");
String size225 = request.getParameter("size225");
String size230 = request.getParameter("size230");
String size235 = request.getParameter("size235");
String size240 = request.getParameter("size240");
String size245 = request.getParameter("size245");
String size250 = request.getParameter("size250");
String size255 = request.getParameter("size255");
String size260 = request.getParameter("size260");
String colorblack = request.getParameter("colorblack");
String colorblue = request.getParameter("colorblue");
String colorred = request.getParameter("colorred");
String colorwhite = request.getParameter("colorwhite");
String coloryellow = request.getParameter("coloryellow");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>제품 목록 페이지</title>
<script>
function submit_search() {
	
}
</script>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="product_list">
<%
int p_cnt = 0, tmp_num = 0, num = 0;
String categorybig_name = "", categorymedium_name = "", product_list = "", product_count = "";
String where = "", args = "";
String sortquery = "", sortquerystring = "", cmquery = "" , searchcmquerystring = "";
String limitquery = "", queryheel = "", querysize = "", querycolor = "", querygroup = "";
String searchname_category_big = "select * from categorybig where cb_idx = " + cb_idx;
String searchname_category_medium = "select * from categorymedium where cb_idx = " + cb_idx + " and cm_idx = " + cm_idx;
int cpage = 1, psize = 8, bsize = 10, sidx = 0;
querygroup = " group by p.p_id ";

if (cm_idx == null) {
	cmquery = "";
	searchcmquerystring = "";
} else if (cm_idx != null) {
	cmquery = " and cm_idx = " + cm_idx;
	searchcmquerystring = "&cm=" + cm_idx;
}

if (sort == null) {
	sort = "";
	sortquery = " order by p_idx desc";
	sortquerystring = "";
} else {
	if (sort.equals("new")) {
		sortquery = " order by p_release desc";
		sortquerystring = "&sort=new";
	} else if (sort.equals("hit")) {
		sortquery = " order by p_grade desc";
		sortquerystring = "&sort=hit";
	} else if (sort.equals("lowerprice")) {
		sortquery = " order by p_price asc";
		sortquerystring = "&sort=lowerprice";
	} else if (sort.equals("highprice")) {
		sortquery = " order by p_price desc";
		sortquerystring = "&sort=highprice";
	}
}

if (heellow != null || heelmid != null || heelhigh != null) {
	queryheel = " and p_height in (";
	if (heellow != null)	queryheel += "1, 2, 3, ";
	if (heelmid != null)	queryheel += "4, 5, 6, ";
	if (heelhigh != null)	queryheel += "7, 8, 9, ";
	queryheel = queryheel.substring(0, queryheel.length() - 2);
	queryheel += ")";
}

if (size210 != null || size215 != null || size220 != null || size225 != null || size230 != null || size235 != null ||
	size240 != null || size245 != null || size250 != null || size255 != null || size260 != null) {
	querysize = " and po_size in (";
	if (size210 != null)	querysize += "210, ";
	if (size215 != null)	querysize += "215, ";
	if (size220 != null)	querysize += "220, ";
	if (size225 != null)	querysize += "225, ";
	if (size230 != null)	querysize += "230, ";
	if (size235 != null)	querysize += "235, ";
	if (size240 != null)	querysize += "240, ";
	if (size245 != null)	querysize += "245, ";
	if (size250 != null)	querysize += "250, ";
	if (size255 != null)	querysize += "255, ";
	if (size260 != null)	querysize += "260, ";
	querysize = querysize.substring(0, querysize.length() - 2);
	querysize += ")";
}

if (colorblack != null || colorblue != null || colorred != null || colorwhite != null || coloryellow != null) {
	querycolor = " and po_color in (";
	if (colorblack != null)		querycolor += "'black', ";
	if (colorblue != null)		querycolor += "'blue', ";
	if (colorred != null)		querycolor += "'red', ";
	if (colorwhite != null)		querycolor += "'white', ";
	if (coloryellow != null)	querycolor += "'yellow', ";
	querycolor = querycolor.substring(0, querycolor.length() - 2);
	querycolor += ")";
}

//검색 조건 및 조건 쿼리스트링 작업
if (keyword != null && !keyword.equals("")) {
	where = " and p_title like '%" + keyword + "%' ";
} else {
	keyword = "";
}

if (tmpPage == null || tmpPage.equals("")) {	// 현재 페이지번호가 없을 경우 무조건 1페이지로 셋팅
	cpage = 1;
} else {	// 현재 페이지번호가 있을 경우 정수로 형변환함(여러 계산에서 사용되기도 하며, 인젝션(injection) 공격을 막기 위한 조치)
	cpage = Integer.valueOf(tmpPage);
}

sidx = (cpage - 1) * psize;	// limit의 시작인덱스
limitquery = " limit " + sidx + ", " + psize;

product_list = "select * from products p, products_option po where p.p_id = po.p_id and cb_idx = ";
product_list += cb_idx + cmquery + queryheel + querysize + querycolor + querygroup + sortquery + limitquery;
product_count = "select count(distinct(p.p_id)) cnt from products p, products_option po where p.p_id = po.p_id and cb_idx = ";
product_count += cb_idx + cmquery + queryheel + querysize + querycolor;

System.out.println("[1] cb_idx : " + cb_idx + " / cm_idx : " + cm_idx + " / sort : " + sort);
System.out.println("[2] cmquery : " + cmquery + " / searchcmquerystring : " + searchcmquerystring + " / sortquery : " + sortquery + " / querygroup : " + querygroup);
System.out.println("[3-1] product_list : " + product_list);
System.out.println("[3-2] product_count : " + product_count);
System.out.println("[4-1] [heel-height] heellow : " + heellow + " / heelmid : " + heelmid + " / heelhigh : " + heelhigh);
System.out.println("[4-2] [size] size210 : " + size210 + " / size215 : " + size215 + " / size220 : " + size220 + " / size225 : " + size225);
System.out.println("[4-2] [size] size230 : " + size230 + " / size235 : " + size235 + " / size240 : " + size240 + " / size245 : " + size245);
System.out.println("[4-2] [size] size250 : " + size250 + " / size255 : " + size255 + " / size260 : " + size260);
System.out.println("[4-3] [color] colorblack : " + colorblack + " / colorblue : " + colorblue + " / colorred : " + colorred);
System.out.println("[4-4] [color] colorwhite : " + colorwhite + " / coloryellow : " + coloryellow);
System.out.println("[5-1] queryheel : " + queryheel);
System.out.println("[5-2] querysize : " + querysize);
System.out.println("[5-3] querycolor : " + querycolor);

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	num = 0;
	rs = stmt.executeQuery(searchname_category_big);
	if (rs.next())	{ categorybig_name = rs.getString("cb_title"); }
	rs.close();
	rs = stmt.executeQuery(searchname_category_medium);
	if (rs.next())	{ categorymedium_name = rs.getString("cm_title"); }
	rs.close();
	rs = stmt.executeQuery(product_count);
	if (rs.next())	{ p_cnt = rs.getInt("cnt"); }
	rs.close();
	
	rs = stmt.executeQuery("select * from categorymedium where cb_idx = " + cb_idx);
%>
<div id="product_list_cate">
<hr />
	<ul class="pls_ul1">
		<li><a href="product_list.jsp?cb=<%=cb_idx %>"><%=categorybig_name %></a></li>
	</ul>
	<br />
	<ul class="pls_ul2">
		<li>
			<% while (rs.next()) { %>
				<a href="product_list.jsp?cb=<%=cb_idx %>&cm=<%=rs.getString("cm_idx") %>"><%=rs.getString("cm_title") %></a>&nbsp;&nbsp;&nbsp;
			<% } %>
		</li>
	</ul>
	<br />
	<ul class="pls_ul3">
		<li>
			현재위치 : <a href="main.jsp">HOME</a>
			<% if (categorybig_name != "") { %>
				<% if (categorymedium_name == "") { %>
					> <a href="product_list.jsp?cb=<%=cb_idx %>"><b><%=categorybig_name %></b></a>
				<% } else { %>
					> <a href="product_list.jsp?cb=<%=cb_idx %>"><%=categorybig_name %></a> > <b><%=categorymedium_name %></b>
				<% } %>
			<% } %>
		</li>
	</ul>
</div>
<hr />
<div id="product_list_search">
<form name="frm_pls" action="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %>" method="post">
	<table id="pls_tbl" border="0" cellpadding="0" cellspacing="1">
		<tr>
			<td width="*">
				<input type="checkbox" name="heellow" value="low" <%=(heellow == null) ? "" : "checked='checked'" %> />낮은힐(1cm ~ 3cm)<br /><br />
				<input type="checkbox" name="heelmid" value="mid" <%=(heelmid == null) ? "" : "checked='checked'" %> />중간힐(4cm ~ 6cm)<br /><br />
				<input type="checkbox" name="heelhigh" value="high" <%=(heelhigh == null) ? "" : "checked='checked'" %> />높은힐(7cm ~ 9cm)
			</td>
			<td width="30%">
				<b>사이즈검색</b><br /><br />
				<input type="checkbox" name="size210" value="210" <%=(size210 == null) ? "" : "checked='checked'" %> />210&nbsp;&nbsp;
				<input type="checkbox" name="size215" value="215" <%=(size215 == null) ? "" : "checked='checked'" %> />215&nbsp;&nbsp;
				<input type="checkbox" name="size220" value="220" <%=(size220 == null) ? "" : "checked='checked'" %> />220&nbsp;&nbsp;
				<input type="checkbox" name="size225" value="225" <%=(size225 == null) ? "" : "checked='checked'" %> />225&nbsp;&nbsp;
				<input type="checkbox" name="size230" value="230" <%=(size230 == null) ? "" : "checked='checked'" %> />230&nbsp;&nbsp;
				<input type="checkbox" name="size235" value="235" <%=(size235 == null) ? "" : "checked='checked'" %> />235&nbsp;&nbsp;<br /><br />
				<input type="checkbox" name="size240" value="240" <%=(size240 == null) ? "" : "checked='checked'" %> />240&nbsp;&nbsp;
				<input type="checkbox" name="size245" value="245" <%=(size245 == null) ? "" : "checked='checked'" %> />245&nbsp;&nbsp;
				<input type="checkbox" name="size250" value="250" <%=(size250 == null) ? "" : "checked='checked'" %> />250&nbsp;&nbsp;
				<input type="checkbox" name="size255" value="255" <%=(size255 == null) ? "" : "checked='checked'" %> />255&nbsp;&nbsp;
				<input type="checkbox" name="size260" value="260" <%=(size260 == null) ? "" : "checked='checked'" %> />260&nbsp;&nbsp;
			</td>
			<td width="25%">
				<input type="checkbox" name="colorblack" value="black" <%=(colorblack == null) ? "" : "checked='checked'" %> />&nbsp;&nbsp;
				<img src="images/color_black.jpg" width="30" height="30" />
				<input type="checkbox" name="colorblue" value="blue" <%=(colorblue == null) ? "" : "checked='checked'" %> />&nbsp;&nbsp;
				<img src="images/color_blue.jpg" width="30" height="30" />
				<input type="checkbox" name="colorred" value="red" <%=(colorred == null) ? "" : "checked='checked'" %> />&nbsp;&nbsp;
				<img src="images/color_red.jpg" width="30" height="30" /><br /><br />
				<input type="checkbox" name="colorwhite" value="white" <%=(colorwhite == null) ? "" : "checked='checked'" %> />&nbsp;&nbsp;
				<img src="images/color_white.jpg" width="30" height="30" />
				<input type="checkbox" name="coloryellow" value="yellow" <%=(coloryellow == null) ? "" : "checked='checked'" %> />&nbsp;&nbsp;
				<img src="images/color_yellow.jpg" width="30" height="30" />
			</td>
			<td width="5%">
				<input type="image" src="images/btn_search.jpg" onclick="return submit_search()" />
				<!-- <input type="submit" value="SEARCH" /> -->
			</td>
		</tr>
	</table>
</form>
</div>
<hr />
<div id="product_list_order">
	<ul class="plo_ul1">
		<li>
			<a href="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %>&sort=new">
			<% if (sort.equals("new")) { %><b>신상품</b><% } else { %>신상품<% } %></a>&nbsp;&nbsp;&nbsp;
			<a href="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %>&sort=hit">
			<% if (sort.equals("hit")) { %><b>인기상품</b><% } else { %>인기상품<% } %></a>&nbsp;&nbsp;&nbsp;
			<a href="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %>&sort=lowerprice">
			<% if (sort.equals("lowerprice")) { %><b>낮은가격</b><% } else { %>낮은가격<% } %></a>&nbsp;&nbsp;&nbsp;
			<a href="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %>&sort=highprice">
			<% if (sort.equals("highprice")) { %><b>높은가격</b><% } else { %>높은가격<% } %></a>&nbsp;&nbsp;&nbsp;
		</li>
	</ul>
	<ul class="plo_ul2">
		<li>TOTAL <b><%=p_cnt %> </b> EA OF ITEM LIST<br /></li>
	</ul>
</div>
<hr />
<table id="tbl_product_list">
<%
	rs.close();
	rs = stmt.executeQuery(product_list);

	String linkHead = "", linkTail = "";
	int product_price = 0, product_discount = 0, product_cal = 0;
	num = p_cnt;
	tmp_num = 0;
	if (rs.next()) {
		int lastPage = (num - 1) / psize + 1;	// 마지막 페이지 번호
		num = num - (cpage - 1) * psize;	// 게시물 개수 번호
		product_price = rs.getInt("p_price");
		product_discount = rs.getInt("p_discount");
		System.out.println("product_price : " + product_price + " / product_discount : " + product_discount + " / product_cal : " + product_cal);
		product_cal = (product_price * (100 - product_discount)) / 100;
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
				<%=product_cal %>원
				<hr width="250" />
			</td>
<%			if (tmp_num % 4 == 0) { out.println("</tr>"); }
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
<div id="pl_paging" align="center">
	<a href="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %><%=sortquerystring %>&cpage=1">&lt;&lt;</a><!-- 첫페이지로 이동 -->
<%
	linkHead = "";
	linkTail = "";
	if (cpage > 1) {
		linkHead = "<a href='product_list.jsp?cb=" + cb_idx + searchcmquerystring + sortquerystring + "&cpage=" + (cpage - 1) + "'>";
		linkTail = "</a>";
	}
	out.println(linkHead + "&lt;" + linkTail);
	int spage = (cpage - 1) / bsize * bsize + 1;
	for (int i = spage ; i < spage + bsize && i <= lastPage ; i++) {
		if (i == cpage) {
			out.println("&nbsp;<b>" + i + "</b>&nbsp;");
		} else {
			out.println("&nbsp;<a href='product_list.jsp?cb=" + cb_idx + searchcmquerystring + sortquerystring + "&cpage=" + i + "'>" + i + "</a>&nbsp;");
		}
	}
	linkHead = "";
	linkTail = "";
	if (cpage < lastPage) {
		linkHead = "<a href='product_list.jsp?cb=" + cb_idx + searchcmquerystring + sortquerystring + "&cpage=" + (cpage + 1) + "'>";
		linkTail = "</a>";
	}
	out.println(linkHead + "&gt;" + linkTail);
%>
	<a href="product_list.jsp?cb=<%=cb_idx %><%=searchcmquerystring %><%=sortquerystring %>&cpage=<%=lastPage %>">&gt;&gt;</a><!-- 마지막페이지로 이동 -->
</div>
<%
	} else {
		System.out.println("검색 결과 없음(0건)");
		%>
			<tr align="center">
				<td>검색 결과가 없습니다.</td>
			</tr>
		</table>
		<%
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
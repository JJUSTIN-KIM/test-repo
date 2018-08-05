<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_html_header.jsp" %>
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);

String select_cate_big = request.getParameter("select_cate_big");
String select_cate_medium = request.getParameter("select_cate_medium");
String select_newbest = request.getParameter("selectnb");
String select_searchname = request.getParameter("searchoption_nameinput");
String select_post = request.getParameter("postornot");
String start_regist_year = request.getParameter("start_regist_year");
String start_regist_month = request.getParameter("start_regist_month");
String start_regist_day = request.getParameter("start_regist_day");
String end_regist_year = request.getParameter("end_regist_year");
String end_regist_month = request.getParameter("end_regist_month");
String end_regist_day = request.getParameter("end_regist_day");

String choice_cm_idx = "", choice_cm_title = "";
String start_date = "", end_date = "";
String cate_cb_idx = "", cate_cm_idx = "", cb_idx = "", cm_idx = "";
int search_count = 0;
String product_image = "", product_post = "", product_p_id = "";
String query_search_catebig = "", query_search_catemedium = "", query_search_newbest = "", query_search_name = "", query_search_post = "", query_search_date = "";

String query_select_cate_medium = "select * from categorymedium where cb_idx = '" + select_cate_big + "'";
String query_search_main = "select * from products p, categorybig cb, categorymedium cm where cb.cb_idx = cm.cb_idx and p.cb_idx = cm.cb_idx and p.cm_idx = cm.cm_idx order by p_idx desc ";
String query_search_main_count = "select count(*) cnt from products p, categorybig cb, categorymedium cm where cb.cb_idx = cm.cb_idx and p.cb_idx = cm.cb_idx and p.cm_idx = cm.cm_idx order by p_idx desc ";

if (select_cate_big == null || select_cate_big.equals("")) {
	select_cate_big = "";
} else {
	query_search_catebig = " cm.cb_idx = " + select_cate_big + " and ";
}
if (select_cate_medium == null || select_cate_medium.equals("")) {
	select_cate_medium = "";
} else {
	query_search_catemedium = " cm.cm_idx = " + select_cate_medium + " and ";
}
if (select_newbest == null || select_newbest.equals("")) {
	select_newbest = "";
} else {
	if (!select_newbest.equals("a"))	query_search_newbest = " p_isnewbest = '" + select_newbest + "' and ";
}
if (select_searchname == null || select_searchname.equals("")) {
	select_searchname = "";
} else {
	query_search_name = " p_title like '%" + select_searchname + "%' and ";
}
if (select_post == null || select_post.equals("")) {
	select_post = "";
} else {
	query_search_post = " p_isview = '" + select_post + "' and ";
}

if (start_regist_year == null || start_regist_year.equals("") || start_regist_month == null || start_regist_month.equals("") || start_regist_day == null || start_regist_day.equals("")) {
	start_regist_year = "";
	start_regist_month = "";
	start_regist_day = "";
} else {
	if (Integer.parseInt(start_regist_month) < 10) start_regist_month = "0" + start_regist_month;
	if (Integer.parseInt(start_regist_day) < 10) start_regist_day = "0" + start_regist_day;
	start_date = start_regist_year + "-" + start_regist_month + "-" + start_regist_day;
}
if (end_regist_year == null || end_regist_year.equals("") || end_regist_month == null || end_regist_month.equals("") || end_regist_day == null || end_regist_day.equals("")) {
	end_regist_year = "";
	end_regist_month = "";
	end_regist_day = "";
} else {
	if (Integer.parseInt(end_regist_month) < 10) end_regist_month = "0" + end_regist_month;
	if (Integer.parseInt(end_regist_day) < 10) end_regist_day = "0" + end_regist_day;
	end_date = end_regist_year + "-" + end_regist_month + "-" + end_regist_day;
}

if (!start_date.equals("") && !end_date.equals("")) {
	query_search_date = " (date_format(p_regdate, '%Y-%m-%d') between '" + start_date + "' and '" + end_date + "') and ";
} else if (!start_date.equals("") && end_date.equals("")) {
	query_search_date = " (date_format(p_regdate, '%Y-%m-%d') >= '" + start_date + "') and ";
} else if (start_date.equals("") && !end_date.equals("")) {
	query_search_date = " (date_format(p_regdate, '%Y-%m-%d') <= '" + end_date + "') and ";
}

if (!query_search_catebig.equals("") || !query_search_catemedium.equals("") || !query_search_newbest.equals("")
		|| !query_search_name.equals("") || !query_search_post.equals("") || !query_search_date.equals("")) {
	query_search_main = "select * from products p, categorybig cb, categorymedium cm where cb.cb_idx = cm.cb_idx and p.cb_idx = cm.cb_idx and p.cm_idx = cm.cm_idx and ";
	query_search_main += query_search_catebig + query_search_catemedium + query_search_newbest + query_search_name + query_search_post + query_search_date;
	query_search_main = query_search_main.substring(0, query_search_main.length() - 4);
	query_search_main += " order by p_idx desc ";

	query_search_main_count = "select count(*) cnt from products p, categorybig cb, categorymedium cm where cb.cb_idx = cm.cb_idx and p.cb_idx = cm.cb_idx and p.cm_idx = cm.cm_idx and ";
	query_search_main_count += query_search_catebig + query_search_catemedium + query_search_newbest + query_search_name + query_search_post + query_search_date;
	query_search_main_count = query_search_main_count.substring(0, query_search_main_count.length() - 4);
	query_search_main_count += " order by p_idx desc ";
}

System.out.println("[1-1] select_cate_big : " + select_cate_big + " / select_cate_medium : " + select_cate_medium + " / select_newbest : " + select_newbest);
System.out.println("[1-2] query_search_catebig : " + query_search_catebig + " / query_search_catemedium : " + query_search_catemedium);
System.out.println("[1-3] query_search_newbest : " + query_search_newbest + " / query_search_name : " + query_search_name + " / query_search_post : " + query_search_post);
System.out.println("[1-4] query_search_date : " + query_search_date);
System.out.println("[1-5] query_search_main : " + query_search_main);
System.out.println("[1-6] query_search_main_count : " + query_search_main_count);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>상품 조회 페이지</title>
<link rel="stylesheet" type="text/css" href="css/admin_product.css" />
<script>
var cb1 = new Array();
cb1[0] = new Option("", "-- 중분류명 --");
cb1[1] = new Option("1", "일반");
cb1[2] = new Option("2", "오픈토");
cb1[3] = new Option("3", "통굽/가보시");

var cb2 = new Array();
cb2[0] = new Option("", "-- 중분류명 --");
cb2[1] = new Option("4", "플랫슈즈");
cb2[2] = new Option("5", "로퍼");
cb2[3] = new Option("6", "오픈토");

var cb3 = new Array();
cb3[0] = new Option("", "-- 중분류명 --");
cb3[1] = new Option("7", "스니커즈");
cb3[2] = new Option("8", "슬립온");
cb3[3] = new Option("9", "런닝슈즈");

var cb4 = new Array();
cb4[0] = new Option("", "-- 중분류명 --");
cb4[1] = new Option("10", "샌들");
cb4[2] = new Option("11", "웨지");
cb4[3] = new Option("12", "슬리퍼/쪼리");

var cb5 = new Array();
cb5[0] = new Option("", "-- 중분류명 --");
cb5[1] = new Option("13", "일반");
cb5[2] = new Option("14", "오픈토");
cb5[3] = new Option("15", "통굽/가보시");

function setCata(obj, target) {
	var x = obj.value;

	for (m = target.options.length - 1; m > 0 ; m--)
		target.options[m] = null;

	if (x != "") {
		selectedArray = eval("cb" + x);
		for (i = 0 ; i < selectedArray.length ; i++) 
			target.options[i] = new Option(selectedArray[i].value, selectedArray[i].text);
			
		target.options[0].selected = true;
	}
}

function search_select_option(val) {
	document.frm_product_search.action = "admin_product.jsp";
	document.frm_product_search.submit();
}

</script>
</head>
<body>
<div id="product_search">
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
%>
	<form method="post" name="frm_product_search" id="frm_product_search">
	<div id="ps_search_main">
		<table id="tbl_ps_main">
			<tr><td>&nbsp;&nbsp;PRODUCT SEARCH&nbsp;&nbsp;</td></tr>
		</table>
	</div>
	<div id="ps_search_main_btnregist">
		<table id="tbl_ps_search_main_btnregist">
			<tr><td><a href="admin_product_regist.jsp" ><img src="../images/btn_addproduct.jpg" /></a></td></tr>
		</table>
	</div>
	<div id="ps_searchoption">
		<table id="tbl_ps_basic">
			<tr>
				<td colspan="2" class="tbl_ps_headertitle">상품정보</td>
			</tr>
			<tr>
				<td width="200" class="tbl_ps_header">카테고리선택</td>
				<td width="*" class="tbl_ps_basic_category">
					<select name="select_cate_big" onChange="setCata(this, this.form.select_cate_medium);">
						<option value="">-- 대분류명 --</option>
						<option value="1" <%=(select_cate_big.equals("1")) ? " selected = 'selected'" : "" %>>HEEL/PUMPS</option>
						<option value="2" <%=(select_cate_big.equals("2")) ? " selected = 'selected'" : "" %>>LOAFER/FLAT</option>
						<option value="3" <%=(select_cate_big.equals("3")) ? " selected = 'selected'" : "" %>>SNEAKERS</option>
						<option value="4" <%=(select_cate_big.equals("4")) ? " selected = 'selected'" : "" %>>SANDALS</option>
						<option value="5" <%=(select_cate_big.equals("5")) ? " selected = 'selected'" : "" %>>BOOTS/WALKER</option>
					</select>
					<select name="select_cate_medium">
						<option value="">-- 중분류명 --</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="tbl_ps_header">NEW/BEST 여부</td>
				<td>
					<input type="radio" name="selectnb" value="n" <%=(select_newbest.equals("n")) ? " checked = 'checked'" : "" %> />NEW&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="selectnb" value="b" <%=(select_newbest.equals("b")) ? " checked = 'checked'" : "" %> />BEST&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="selectnb" value="x" <%=(select_newbest.equals("x")) ? " checked = 'checked'" : "" %> />NONE&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="selectnb" value="a" <%=(select_newbest.equals("a")) ? " checked = 'checked'" : "" %> />ALL
				</td>
			</tr>
			<tr>
				<td class="tbl_ps_header">검색어</td>
				<td>
					<select name="searchoption_title">
						<option value="title">상품명</option>
					</select>
					<input type="text" width="200" name="searchoption_nameinput" class="searchoption_nameinput" />
				</td>
			</tr>
			<tr>
				<td class="tbl_ps_header">게시여부</td>
				<td>
					<input type="radio" name="postornot" value="y" <%=(select_post.equals("y")) ? " checked = 'checked'" : "" %> />예&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="postornot" value="n" <%=(select_post.equals("n")) ? " checked = 'checked'" : "" %> />아니오
				</td>
			</tr>
			<tr>
				<td class="tbl_ps_header">등록일자</td>
				<td>
					<select name="start_regist_year">
						<option value="">YEAR</option>
					<% for (int i = 2000 ; i <= year ; i++ ) { %>
						<option value="<%=i %>" <%=(start_regist_year.equals(i)) ? " checked = 'checked'" : "" %>><%=i %></option>
					<% } %>
					</select>년&nbsp;
					<select name="start_regist_month">
						<option value="">MONTH</option>
					<% for (int i = 1 ; i <= 12 ; i++ ) { %>
						<option value="<%=i %>" <%=(start_regist_month.equals(i)) ? " checked = 'checked'" : "" %>><%=i %></option>
					<% } %>
					</select>월&nbsp;
					<select name="start_regist_day">
						<option value="">DAY</option>
					<% for (int i = 1; i <= 31 ; i++ ) { %>
						<option value="<%=i %>" <%=(start_regist_day.equals(i)) ? " checked = 'checked'" : "" %>><%=i %></option>
					<% } %>
					</select>일
					&nbsp;&nbsp;~&nbsp;&nbsp;
					<select name="end_regist_year">
						<option value="">YEAR</option>
					<% for (int i = 2000 ; i <= year ; i++ ) { %>
						<option value="<%=i %>" <%=(end_regist_year.equals(i)) ? " checked = 'checked'" : "" %>><%=i %></option>
					<% } %>
					</select>년&nbsp;
					<select name="end_regist_month">
						<option value="">MONTH</option>
					<% for (int i = 1 ; i <= 12 ; i++ ) { %>
						<option value="<%=i %>" <%=(end_regist_month.equals(i)) ? " checked = 'checked'" : "" %>><%=i %></option>
					<% } %>
					</select>월&nbsp;
					<select name="end_regist_day">
						<option value="">DAY</option>
					<% for (int i = 1; i <= 31 ; i++ ) { %>
						<option value="<%=i %>" <%=(end_regist_day.equals(i)) ? " checked = 'checked'" : "" %>><%=i %></option>
					<% } %>
					</select>일
				</td>
			</tr>
		</table>
	</div>
	<div id="ps_search_btnsearch">
		<table id="tbl_ps_search_btnsearch">
			<tr>
				<td colspan="2" class="tbl_ps_btnsearch"><input type="button" value="검색" onclick="search_select_option()" /></td>
			</tr>
		</table>
	</div>
	<hr />
	<%
	rs = stmt.executeQuery(query_search_main_count);
	if (rs.next())	search_count = rs.getInt("cnt");
	rs.close();
	int i = 1;
	%>
	<div id="ps_searchcount">
		<table id="tbl_ps_searchcount">
			<tr>
				<td colspan="2">검색결과 : <b><%=search_count %></b> 건</td>
			</tr>
		</table>
	</div>
	<div id="ps_searchview">
		<table id="tbl_ps_searchview">
			<tr>
				<td class="tbl_ps_searchview_header">NO</td>
				<td class="tbl_ps_searchview_header">상품이미지</td>
				<td class="tbl_ps_searchview_header">상품정보</td>
				<td class="tbl_ps_searchview_header">게시여부</td>
				<td class="tbl_ps_searchview_header">가격</td>
				<td class="tbl_ps_searchview_header">수정여부</td>
			</tr>
		<%
		rs = stmt.executeQuery(query_search_main);
		if (rs.next()) {
			do {
				product_image = "../" + rs.getString("p_img1");
				product_post = rs.getString("p_isview");
				product_p_id = rs.getString("p_id");
			%>
			<tr>
				<td class="tbl_ps_searchview_no"><%=i %></td>
				<td class="tbl_ps_searchview_content"><input type="image" src="<%=product_image %>" width="80" height="80" /></td>
				<td class="tbl_ps_searchview_content">
					<%=rs.getString("cb_title") %> > <%=rs.getString("cm_title") %><br />
					<%=rs.getString("p_title") %>
				</td>
				<td class="tbl_ps_searchview_content">
					<% if (product_post.equals("Y")) { %>
						노출함
					<% } else if (product_post.equals("N")) { %>
						노출안함
					<% } %>
				</td>
				<td class="tbl_ps_searchview_content">
					정가 : <%=rs.getString("p_price") %>원
				</td>
				<td class="tbl_ps_searchview_content">
					<a href="admin_product_regist.jsp?p_id=<%=product_p_id %>"><img src="../images/btn_modify.jpg" /></a>
				</td>
			</tr>	
			<%
			i++;
			} while(rs.next());
		}
		%>
		</table>
	</div>
	</form>
<%
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
</body>
</html>
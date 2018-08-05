<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp"%>
<%
Statement stmt2 = null;
Statement stmt3 = null;
Statement stmt4 = null;

// 배열 필요 없는 것들
String order_name = request.getParameter("order_name");
String order_email = request.getParameter("order_email");
String order_phone1 = request.getParameter("order_phone1");
String order_phone2 = request.getParameter("order_phone2");
String order_phone3 = request.getParameter("order_phone3");
String order_address_name = request.getParameter("order_address_name");
String order_address_phone1 = request.getParameter("order_address_phone1");
String order_address_phone2 = request.getParameter("order_address_phone2");
String order_address_phone3 = request.getParameter("order_address_phone3");
String order_address_zip = request.getParameter("order_address_zip");
String order_address1 = request.getParameter("order_address1");
String order_address2 = request.getParameter("order_address2");
String order_message = request.getParameter("order_message");
String order_address_depositer = request.getParameter("order_address_depositer");
String order_address_reg = request.getParameter("order_address_reg");
String order_method = request.getParameter("order_method");
String selectaccount = request.getParameter("selectaccount");
int delivery_price = Integer.parseInt(request.getParameter("delivery_price"));
int userPoint = 0;
String tmpPoint = request.getParameter("qty_point");
int qty_point = 0;
String tmpDiscount = request.getParameter("qty_membership");
int discount_price = 0;
int total_price = Integer.parseInt(request.getParameter("finalPrice"));

// 배열 필요한 것들 : p_id, od_count, p_price, od_size, od_height, od_color
int cartCount = Integer.parseInt(request.getParameter("cartCount"));
int[] countArr = new int[cartCount];
for (int i = 0 ; i < countArr.length ; i++) {
	countArr[i] = i + 1;
}

String[] p_id = new String[cartCount];
for (int j = 0 ; j < cartCount ; j++) {
	p_id[j] = request.getParameter("p_id" + countArr[j]);
}

String[] height = new String[cartCount];
for (int m = 0 ; m < cartCount ; m++) {
	height[m] = request.getParameter("height" + countArr[m]);
}

String[] selectsize = new String[cartCount];
for (int n = 0 ; n < cartCount ; n++) {
	selectsize[n] = request.getParameter("selectsize" + countArr[n]);
}

String[] selectcolor = new String[cartCount];
for (int o = 0 ; o < cartCount ; o++) {
	selectcolor[o] = request.getParameter("selectcolor" + countArr[o]);
}

int[] selectamount = new int[cartCount];
for (int p = 0 ; p < cartCount ; p++) {
	selectamount[p] = Integer.parseInt(request.getParameter("selectamount" + countArr[p]));
}

int[] p_price = new int[cartCount];
for (int q = 0 ; q < cartCount ; q++) {
	p_price[q] = Integer.parseInt(request.getParameter("p_price" + countArr[q]));
}

String m_id = "";
if (isLogin) {
	m_id = userId;
} else {
	m_id = "비회원";
}

if (tmpPoint == null || tmpPoint.equals("")) {
	tmpPoint = "0";
} else {
	qty_point = Integer.parseInt(tmpPoint);
}


if (tmpDiscount == null || tmpDiscount.equals("")) {
	tmpDiscount = "0";
} else {
	discount_price = Integer.parseInt(tmpDiscount);
}

if (order_address_depositer == null || order_address_depositer.equals("")) {
	order_address_depositer = order_name;
}

String o_phone = order_phone1 + "-" + order_phone2 + "-" + order_phone3;
String o_rphone = order_address_phone1 + "-" + order_address_phone2 + "-" + order_address_phone3;

String insertSql = "", updateSql = "", detailSql = "", addressSql = "", countSql = "", msg = "";

Calendar today = Calendar.getInstance();
int tempYear = today.get(Calendar.YEAR);
int tempMonth = today.get(Calendar.MONTH) + 1;
int tempDate = today.get(Calendar.DATE);

String year = "" + tempYear;
String month = "";
String date = "";

if (tempMonth < 10) {
	month = "" + tempMonth;
	month = "0" + month;
} else {
	month = "" + tempMonth;
}

if (tempDate < 10) {
	date = "" + tempDate;
	date = "0" + date;
} else {
	date = "" + tempDate;
}

String yyyymmdd = year + month + date;

String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
int stringLength = 8;
String randomString = "";
Random r = new Random();
for (int i = 0 ; i < stringLength ; i++) {
	int rNum = r.nextInt(62);
	randomString += chars.substring(rNum, rNum + 1);
}
String o_id = yyyymmdd + "-" + randomString;
%>
<form name="frm_multi_oid" action="order_multi_comp.jsp" method="post">
<input type="hidden" name="o_id" value="<%=o_id %>" />
<script>document.frm_multi_oid.submit();</script>
</form>
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	stmt4 = conn.createStatement();
	
	if (isLogin) {
		rs = stmt.executeQuery("select m_point from member where m_id = '" + m_id + "'");
		if (rs.next()) {
			userPoint = rs.getInt("m_point");
			rs.close();
		}
	}
	

	if (order_method.equals("D")) {
		insertSql = "insert into orders (o_id, m_id, o_name, o_phone, o_email, o_rname, o_rphone, o_rzip, o_raddr1, o_raddr2, ";
		insertSql += "o_totalprice, o_deliprice, o_paymethod, o_depositor, o_account, o_comment, o_point, o_membership) ";
		insertSql += "values ('" + o_id + "', '" + m_id + "', '" + order_name + "', '" + o_phone + "', '" + order_email + "', '";
		insertSql += order_address_name + "', '" + o_rphone + "', '" + order_address_zip + "', '" + order_address1 + "', '" + order_address2 + "', '";
		insertSql += total_price + "', '" + delivery_price + "', '" + order_method + "', '" + order_address_depositer + "', '" + selectaccount + "', '"+ order_message + "', '";
		insertSql += qty_point + "', '" + discount_price + "')";
	} else if (order_method.equals("C")) {
		insertSql = "insert into orders (o_id, m_id, o_name, o_phone, o_email, o_rname, o_rphone, o_rzip, o_raddr1, o_raddr2, ";
		insertSql += "o_totalprice, o_deliprice, o_paymethod, o_depositor, o_account, o_comment, o_point, o_membership, o_status) ";
		insertSql += "values ('" + o_id + "', '" + m_id + "', '" + order_name + "', '" + o_phone + "', '" + order_email + "', '";
		insertSql += order_address_name + "', '" + o_rphone + "', '" + order_address_zip + "', '" + order_address1 + "', '" + order_address2 + "', '";
		insertSql += total_price + "', '" + delivery_price + "', '" + order_method + "', '" + order_address_depositer + "', '" + selectaccount + "', '"+ order_message + "', '";
		insertSql += qty_point + "', '" + discount_price + "', 'K')";
	}
	int insertResult = stmt.executeUpdate(insertSql);
	
	int detailResult = 0;
	for (int a = 0 ; a < cartCount ; a++) {
		detailSql = "insert into orderdetail (o_id, p_id, od_count, p_price, od_size, od_height, od_color) ";
		detailSql += "values ('" + o_id + "', '" + p_id[a] + "', '" + selectamount[a] + "', '" + p_price[a] + "', '" + selectsize[a] + "', '" + height[a] + "', '" + selectcolor[a] + "')";
		detailResult = stmt.executeUpdate(detailSql);
	}
	
	int updateResult = 0;
	for (int b = 0 ; b < cartCount ; b++) {
		updateSql = "update products_option set po_stock = po_stock - " + selectamount[b] + " where p_id = '" + p_id[b] + "' and po_size = " + selectsize[b] + " and po_color = '" + selectcolor[b] + "'";
		updateResult = stmt.executeUpdate(updateSql);
	}

	
	String pointSql = "";
	String pointSql2 = "";
	int pointResult = 1;
	int pointResult2 = 1;
	if (isLogin && qty_point > 0) {
		pointSql = "update member set m_point = " + userPoint + " - " + qty_point + " where m_id = '" + m_id + "'";
		pointSql2 = "insert into member_point (m_id, mp_point, mp_isuse, mp_desc) values ('" + m_id + "', " + qty_point + ", 'Y', '" + cartCount + "개 주문')";
		pointResult = stmt3.executeUpdate(pointSql);
		pointResult2 = stmt4.executeUpdate(pointSql2);
	}
	
	int addressResult = 1;
	int addressCount = 0;
	if (isLogin && order_address_reg.equals("Y")) {
		countSql = "select count(*) from member_address where m_id = '" + m_id + "'";
		rs = stmt.executeQuery(countSql);
		if (rs.next()) {
			addressCount = rs.getInt(1);
			rs.close();
		} 
		if (addressCount >= 1) {
			addressSql = "insert into member_address (m_id, ma_zip, ma_addr1, ma_addr2) ";
			addressSql += "values ('" + userId + "', '" + order_address_zip + "', '" + order_address1 + "', '" + order_address2 + "')";
			addressResult = stmt2.executeUpdate(addressSql);
		} else {
			addressSql = "insert into member_address (m_id, ma_zip, ma_addr1, ma_addr2, ma_isbasic) ";
			addressSql += "values ('" + userId + "', '" + order_address_zip + "', '" + order_address1 + "', '" + order_address2 + "', 'Y')";
			addressResult = stmt2.executeUpdate(addressSql);
		}
	}
	
	if (insertResult != 0 && detailResult != 0 && updateResult != 0 && pointResult != 0 && pointResult2 != 0) {
		out.println("<script>");
		out.println("location.replace('order_multi_comp.jsp');");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("history.back();");
		out.println("</script>");
	}

} catch(Exception e) {
	out.println("<h3>레코드 등록에 실패하였습니다.</h3>");
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
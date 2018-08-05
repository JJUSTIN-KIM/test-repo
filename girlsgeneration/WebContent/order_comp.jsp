<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>
<%
Statement stmt2 = null;		Statement stmt3 = null;
ResultSet rs2 = null;		ResultSet rs3 = null;
String o_id = request.getParameter("o_id");
String orderSql = "select * from orders where o_id = '" + o_id + "'";
String detailSql = "select * from orderdetail where o_id = '" + o_id + "'";
String productSql = "";
String img = "", title = "", p_id = "", p_method = "";
int p_price = 0, p_count = 0, multi_price = 0, point = 0, membership = 0, delivery_price = 0, total_price = 0;

if (o_id == null || o_id.equals("")) {
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	
	rs = stmt.executeQuery(orderSql);
	if (rs.next()) {
		total_price = rs.getInt("o_totalprice");
		delivery_price = rs.getInt("o_deliprice");
		point = rs.getInt("o_point");
		membership = rs.getInt("o_membership");
		p_method = rs.getString("o_paymethod");
	}
	
	rs2 = stmt2.executeQuery(detailSql);
	
	if (rs2.next()) {
		p_id = rs2.getString("p_id");
		productSql = "select * from products where p_id = '" + p_id + "'";
		rs3 = stmt3.executeQuery(productSql);
		if (rs3.next()) {
			img = rs3.getString("p_img1");
			title = rs3.getString("p_title");
			rs3.close();
		}
		p_price = rs2.getInt("p_price");
		p_count = rs2.getInt("od_count");
		multi_price = p_price * p_count;
	}
%>
<link rel="stylesheet" type="text/css" href="css/order.css" />
	<div class="contents_area">
		<div class="page_title">
			<span>ORDER COMPLETE</span>
		</div>
		<div class="section_order_list">
			<h3>주문리스트 확인</h3>
			<table class="table_order_list">
				<thead>
					<tr>
						<th colspan="2">product</th>
						<th>price</th>
						<th>qty</th>
						<th>total.price</th>
						<th>reserve</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="td_product_image" width="5%">
							<a href="product_detail.jsp?pid=<%=p_id %>"><img src="<%=img %>" /></a>
						</td>
						<td class="td_product_info" width="*">
							<div class="box_product"><%=title %></div>
							<div class="box_product_height"><%=rs2.getInt("od_height") %> cm</div>
						</td>
						<td class="td_price" width="10%">
							<div class="box_product_price"><%=p_price %> 원</div>
						</td>
						<td class="td_product" width="15%">
							<div class="box_product_ea"><%=rs2.getInt("od_count") %> ea</div>
						</td>
						<td class="td_price" width="15%">
							<div class="box_product_price"><%=multi_price %> 원</div>
						</td>
						<td class="td_reserve" width="15%">
							<div class="box_product_reserve"><%=multi_price / 10 %></div>
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<div class="option">
								option : color - <%=rs2.getString("od_color") %>, size : <%=rs2.getString("od_size") %>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="6" class="order_comp_price">
						결제금액 : <strong><%=multi_price %>원 + 배송료 <%=delivery_price %>원 - 할인 <%=point + membership %>원 = 총 <%=total_price %>원</strong>
						<% if (isLogin) { %> (배송 후 <%=multi_price / 10 %>원 적립) <% } %>
						</td>
					</tr>				
				</tbody>
			</table>
		</div>
		<ul class="order_comp_account">
			<% if (p_method.equals("D")) { %>
			<li>무통장 입금 : <strong class="account_name"><%=rs.getString("o_account") %> 예금주 : 소녀시대-<%=rs.getString("o_name") %></strong></li>
			<li>입금 확인 후 배송이 됩니다.</li>
			<li>입금자명 : <strong class="account_name2"><%=rs.getString("o_depositor") %></strong></li>
			<% } else if (p_method.equals("C")){ %>
			<li>신용카드 결제 - <strong class="account_name"><%=rs.getString("o_name") %></strong>님 확인 완료!</li>
			<li>빠른 배송이 될 수 있도록 바로 준비하겠습니다.</li>
			<% } %>
		</ul>
		<div class="order_basic">
			<h3>주문자정보 확인</h3>
			<table class="table_order_basic">
				<tr>
					<th width="10%">이름</th>
					<td width="*"><%=rs.getString("o_name") %></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=rs.getString("o_email") %></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><%=rs.getString("o_phone") %></td>
				</tr>
			</table>
		</div>
		<div class="order_address">
			<h3>배송 정보 확인</h3>
			<table class="table_order_address">
				<tr>
					<th width="10%">이름</th>
					<td width="*"><%=rs.getString("o_rname") %></td>
				</tr>
				<tr>
					<th>연락처 1</th>
					<td colspan="3"><%=rs.getString("o_rphone") %></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3" class="order_address_delivery"><%=rs.getString("o_raddr1") + " " + rs.getString("o_raddr2") %></td>
				</tr>
				<tr>
					<th>주문메세지</th>
					<td colspan="3"><%=rs.getString("o_comment") %></td>
				</tr>
			</table>
		</div>
		<ul class="order_number_info">
			<li class="order_number_info_first"><%=rs.getString("o_name") %>님의 주문이 완료되었습니다.</li>
			<li>귀하의 주문확인 번호는 <strong><%=o_id %></strong>입니다.</li>
			<% if (isLogin) { %>
			<li>귀하의 제품 구입에 따른 적립금 <strong><%=multi_price / 10 %></strong>포인트 구매결정 완료 후 바로 적립됩니다.</li>
			<% } %>
			<li>결제방식이 무통장입금인 경우 계좌번호를 메모하세요.</li>
			<li>입금 확인 후 상품을 준비하여 배송해 드리겠습니다.</li>
		</ul>
		<div class="order_btn">
			<input type="button" value="홈으로" onclick="location.href='main.jsp';" />&nbsp;&nbsp;
			<input type="button" value="주문 리스트" onclick="location.href='order_conf.jsp';" />
		</div>
	</div>
<%
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로고침]을 누르거나 첫 화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		stmt.close();	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="inc_html_footer.jsp" %>
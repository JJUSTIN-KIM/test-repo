<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>
<%
Statement stmt2 = null;		Statement stmt3 = null;
ResultSet rs2 = null;		ResultSet rs3 = null;
String o_id = request.getParameter("o_id");
String p_id = request.getParameter("p_id");
String orderSql = "select * from orders where o_id = '" + o_id + "'";
String detailSql = "select * from orderdetail where o_id = '" + o_id + "'";
String productSql = "select * from products where p_id = '" + p_id + "'";
String joinSql = "";	// 해당 주문의 구매 상품 개수를 뽑기 위한 쿼리
String p_method = "", deposit = "", status = "", addr = "", addr1 = "", addr2 = "";
String img = "", title = "";
boolean isDeposit = false;
int p_price = 0, p_count = 0, point = 0, membership = 0, delivery_price = 0, total_price = 0;
int multi_price = 0, multi_reserve = 0, total_exp_price = 0;
int orderCount = 0;		// 해당 주문번호의 구매 상품 개수를 저장하기 위한 변수

// join을 위한 변수 선언
String join_pid = "", join_oid = "", join_image = "", join_title = "", join_size = "", join_color = "", join_height = "", join_status = "";
int join_price = 0, join_count = 0, join_deliprice = 0, join_point = 0, join_membership = 0, join_totalprice = 0;
int join_multiprice = 0, join_multireserve = 0, join_totalexpprice = 0;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	rs = stmt.executeQuery(orderSql);
	rs2 = stmt2.executeQuery(detailSql);
	rs3 = stmt3.executeQuery(productSql);
	
	
	if (rs.next()) {
		total_price = rs.getInt("o_totalprice");
		delivery_price = rs.getInt("o_deliprice");
		point = rs.getInt("o_point");
		membership = rs.getInt("o_membership");
		p_method = rs.getString("o_paymethod");
		status = rs.getString("o_status");
		addr1 = rs.getString("o_raddr1");
		addr2 = rs.getString("o_raddr2");
		addr = addr1 + " " + addr2;
	}	
	
	if (rs2.next()) {
		p_price = rs2.getInt("p_price");
		p_count = rs2.getInt("od_count");
		multi_price = p_price * p_count;
		multi_reserve = multi_price / 10;
	}
	
	if (rs3.next()) {
		img = rs3.getString("p_img1");
		title = rs3.getString("p_title");
		rs3.close();
	}
	
	if (p_method.equals("C")) {
		p_method = "신용카드";
	} else if (p_method.equals("D")) {
		p_method = "무통장";
	}
	
	if (status.equals("A")) { deposit = "미입금"; status = "결제대기"; }
	else if (status.equals("B")) { deposit = "결제 완료"; status = "배송준비중"; }
	else if (status.equals("C")) { deposit = "결제 완료"; status = "배송중"; }
	else if (status.equals("D")) { deposit = "결제 완료"; status = "배송완료"; }
	else if (status.equals("E")) { deposit = "결제 완료"; status = "구매결정완료"; }
	else if (status.equals("F")) { deposit = "결제 완료"; status = "교환요청"; } 
	else if (status.equals("G")) { deposit = "결제 완료"; status = "환불요청"; }
	else if (status.equals("H")) { deposit = "결제 완료"; status = "주문취소요청"; }
	else if (status.equals("I")) { deposit = "결제 완료"; status = "교환완료"; }
	else if (status.equals("L")) { deposit = "결제 완료"; status = "환불완료"; }
	else if (status.equals("J")) { deposit = "결제 완료"; status = "주문취소완료"; }
	else if (status.equals("K")) { deposit = "결제 완료"; status = "결제완료"; }
	
	total_price = (p_price * p_count) + delivery_price - (point + membership);
	
%>
<link rel="stylesheet" type="text/css" href="css/order.css" />
<script>
function orderUpdate(utype) {
	if (utype == 'comp') {
		if (confirm('구매결정 하시겠습니까?')) {
			document.frm_order_check.utype.value = "comp";
			document.frm_order_check.submit();
		}
	}
	if (utype == 'can') {
		if (confirm('주문 취소 하시겠습니까?')) {
			document.frm_order_check.utype.value = "can";
			document.frm_order_check.submit();
		}
	}
	if (utype == 'exc') {
		if (confirm('교환요청 하시겠습니까?')) {
			document.frm_order_check.utype.value = "exc";
			document.frm_order_check.submit();
		}
	}
	if (utype == 'ref') {
		if (confirm('환불요청 하시겠습니까?')) {
			document.frm_order_check.utype.value = "ref";
			document.frm_order_check.submit();
		}
	}
}
</script>
	<form name="frm_order_check" action="order_update_proc.jsp" method="post">
	<input type="hidden" name="utype" />
	<div class="contents_area">
		<div class="page_title">
			<span>ORDER INFORMATION</span>
		</div>
		<div class="order_basic">
			<h3>주문자정보</h3>
			<input type="hidden" name="o_id" value="<%=o_id %>" />
			<input type="hidden" name="status" value="<%=rs.getString("o_status") %>" />
			<table class="table_order_basic">
				<tr>
					<th width="10%">주문번호</th>
					<td width="*"><%=o_id %></td>
					<th width="10%">주문일자</th>
					<td width="20%"><%=rs.getString("o_date") %></td>
				</tr>
				<tr>
					<th>주문자</th>
					<td><%=rs.getString("o_name") %></td>
					<th>주문서 입금현황</th>
					<td><%=deposit %></td>
				</tr>
			</table>
		</div>
		<div class="order_address">
			<h3>배송지정보</h3>
			<table class="table_order_address">
			<tr>
				<th width="10%">수취인</th>
				<td width="*"><%=rs.getString("o_rname") %></td>
				<th width="10%">연락처</th>
				<td width="20%"><%=rs.getString("o_rphone") %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3"><%=addr %></td>
			</tr>
			<tr>
				<th>배송메시지</th>
				<td colspan="3"><%=rs.getString("o_comment") %></td>
			</tr>
			</table>
		</div>
		<div class="section_order_list2">
			<h3>주문상품정보</h3>
			<table class="table_order_list2">
				<thead>
					<tr>
						<th colspan="2">주문상품정보</th>
						<th>1켤레당 가격</th>
						<th>수량</th>
						<th>총 가격</th>
						<th>총 적립금</th>
						<th>처리상태</th>
					</tr>
				</thead>
				<tbody>
					<%
					joinSql = "select p.p_id, o.o_id, p.p_img1, p.p_title, d.p_price, d.od_count, d.od_size, d.od_color, d.od_height, "; 
					joinSql += "o.o_status, o.o_deliprice, o.o_point, o.o_membership, o.o_totalprice from products p, orderdetail d, orders o ";
					joinSql += " where d.o_id = o.o_id and p.p_id = d.p_id and o.o_id = '" + o_id + "'";
					rs3 = stmt3.executeQuery(joinSql);
					if (rs3.next()) {
						join_deliprice = rs3.getInt("o.o_deliprice");
						join_point = rs3.getInt("o.o_point");
						join_membership = rs3.getInt("o.o_membership");
						join_totalprice = rs3.getInt("o.o_totalprice");
						do {
							join_pid = rs3.getString("p.p_id");
							join_oid = rs3.getString("o.o_id");
							join_image = rs3.getString("p.p_img1");
							join_title = rs3.getString("p.p_title");
							join_size = rs3.getString("d.od_size");
							join_color = rs3.getString("d.od_color");
							join_height = rs3.getString("d.od_height");
							join_status = rs3.getString("o.o_status");
							join_price = rs3.getInt("d.p_price");
							join_count = rs3.getInt("d.od_count");
							join_multiprice = join_price * join_count;
							join_multireserve = join_multiprice / 10;
							join_totalexpprice += join_multiprice;
					%>
					<tr>
						<td class="td_product_image" width="5%">
							<a href="product_detail.jsp?p_id=<%=join_pid %>"><img src="<%=join_image %>" /></a>
						</td>
						<td class="td_product_info" width="*">
							<div class="box_product"><%=join_title %></div>
							<div class="box_product_height"><%=join_height %> cm</div>
							<div class="box_product_option">
								<img src="images/order_optionicon.gif" />
								color : <%=join_color %>, size : <%=join_size %>
							</div>
						</td>
						<td class="td_order_number" width="10%"><%=join_price %></td>
						<td class="td_product" width="5%">
							<div class="box_product_ea"><%=join_count %></div>
						</td>
						<td class="td_price" width="10%">
							<div class="box_product_price"><strong><%=join_multiprice %> 원</strong></div>
						</td>
						<td class="td_reserve" width="10%">
							<div class="box_product_reserve"><%=join_multireserve %></div>
						</td>
						<td class="td_delivery" width="10%">
							<div class="box_product_delivery"><%=status %></div>
						</td>
					</tr>
					<%
						} while (rs3.next());
					}
					%>
					<tr>
						<td colspan="7">
							<div class="total_payment">
								<strong><%=join_totalexpprice %>원(상품구매금액) + <%=join_deliprice %>원(배송료) - <%=join_point + join_membership %>원(할인금액) = <%=join_totalprice %>원</strong>
							</div>
						</td>
					</tr>			
				</tbody>
			</table>
		</div>
		<div class="order_payment_info">
			<h3>결제정보</h3>
			<table class="table_payment_info">
				<tr>
					<th>결제수단</th>
					<th>결제금액</th>
					<th>세부내역</th>
				</tr>
				<tr>
					<td>사용한 적립금</td>
					<td><%=join_point %></td>
					<td></td>
				</tr>
				<tr>
					<td><strong><%=p_method %></strong></td>
					<td><strong><%=join_totalprice %> (<%=deposit %>)</strong></td>
					<% if (p_method.equals("무통장")) { %>
					<td><strong><%=rs.getString("o_account") %> (예금주 : 소녀시대 - <%=rs.getString("o_name") %>) </strong></td>
					<% } else { %>
					<td></td>
					<% } %>
				</tr>
			</table>
		</div>
		<div class="order_btn">
			<input type="button" value="홈으로" onclick="location.href='main.jsp';" />&nbsp;&nbsp;<input type="button" value="구매결정" onclick="orderUpdate('comp');" />
			&nbsp;<input type="button" value="주문 취소" onclick="orderUpdate('can');"/>&nbsp;&nbsp;<br /><br />
			<input type="button" value="교환요청" onclick="orderUpdate('exc');"/>&nbsp;&nbsp;<input type="button" value="환불요청" onclick="orderUpdate('ref');"/>
		</div>
		<div class="order_update_info">
			<span><strong>1. 주문 취소는 처리상태가 배송 이전(입금 전, 결제완료, 배송준비중일 경우)일 때만 가능하며,<br />
			주문 상품이 여러 개일 경우 전체 취소 후 취소할 상품을 제외한 상품을 다시 주문해 주시기 바랍니다.</strong></span><br />
			<span><strong>2. 교환, 환불은 배송 완료 후 1주일 내에 가능합니다.</strong></span><br />
			<span><strong>3. 구매 결정 후에는 적립금이 지급되며, 교환 및 환불이 불가합니다. 받으신 상품을 다시 한 번 확인하시고 신중하게 눌러 주세요.</strong></span>
		</div>
	</div>
	<input type="hidden" name="reserve" value="<%=join_totalexpprice / 10 %>" />
	</form>
<%
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로고침]을 누르거나 첫 화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		stmt.close();	conn.close();
		rs2.close();	stmt2.close();
		rs3.close();	stmt3.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="inc_html_footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>
<%
if (!isLogin) {
	out.println("<script>");
	out.println("location.replace('order_login_form.jsp');");
	out.println("</script>");
}

Statement stmt2 = null;		Statement stmt3 = null;
ResultSet rs2 = null;		ResultSet rs3 = null;
String o_id = "", p_id = "";
String memberSql = "select * from orders where m_id = '" + userId + "' order by o_date desc";
String detailSql = "";
String productSql = "";
String countSql = "";	// 해당 주문의 구매 상품 개수를 뽑기 위한 쿼리
String title = "", orderDate = "", status = "";
int total_price = 0, count = 0, height = 0;
int orderCount = 0;		// 해당 주문번호의 구매 상품 개수를 저장하기 위한 변수
%>
<link rel="stylesheet" type="text/css" href="css/order.css" />
	<script>
	</script>
	<div class="contents_area">
		<div class="page_title">
			<span>ORDER CONFIRM</span>
		</div>
		<div class="section_order_conf">
			<h3>주문내역</h3>
			<table class="table_order_conf">
				<thead>
					<tr>
						<th>번호</th>
						<th>주문일자</th>
						<th>상품명</th>
						<th>결제금액</th>
						<th>주문상태</th>
						<th>주문상세</th>
					</tr>
				</thead>
				<tbody>
<% 
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	rs = stmt.executeQuery(memberSql);
	if (rs.next()) {
		do {
			count++;
			o_id = rs.getString("o_id");
			total_price = rs.getInt("o_totalprice");
			orderDate = rs.getString("o_date").substring(0, 11);
			status = rs.getString("o_status");
			detailSql = "select * from orderdetail where o_id = '" + o_id + "'";
			rs2 = stmt2.executeQuery(detailSql);
			if (rs2.next()) {
				p_id = rs2.getString("p_id");
				height = rs2.getInt("od_height");
				productSql = "select * from products where p_id = '" + p_id + "'";
				rs3 = stmt3.executeQuery(productSql);
				if (rs3.next()) {
					title = rs3.getString("p_title");
					rs3.close();
				}
			}
			
			if (status.equals("A")) status = "결제대기";
			else if (status.equals("B")) status = "배송준비중";
			else if (status.equals("C")) status = "배송중";
			else if (status.equals("D")) status = "배송완료";
			else if (status.equals("E")) status = "구매결정완료";
			else if (status.equals("F")) status = "교환요청"; 
			else if (status.equals("G")) status = "환불요청";
			else if (status.equals("H")) status = "주문취소요청";
			else if (status.equals("I")) status = "교환완료";
			else if (status.equals("L")) status = "환불완료";
			else if (status.equals("J")) status = "주문취소완료";
			else if (status.equals("K")) status = "결제완료";
			
			
			countSql = "select count(od_idx) from orderdetail where o_id = '" + o_id + "'";
			rs3 = stmt3.executeQuery(countSql);
			if (rs3.next()) orderCount = rs3.getInt(1);
%>
				<form name="frm_op<%=count %>" action="order_check.jsp" method="post">
				<input type="hidden" name="o_id" value="<%=o_id %>" />
				<input type="hidden" name="p_id" value="<%=p_id %>" />
					<tr>
						<td width="5%"><%=count %></td>
						<td width="10%"><%=orderDate %></td>
						<td width="50%" class="order_conf_name">
							<div><a href="#" onclick="showOrder('frm_op<%=count %>');"><%=title %></a></div>
							<div>
							<a href="#" onclick="showOrder('frm_op<%=count %>');"><%=height %>cm
							<% if (orderCount >= 2) { %> 외 <%=orderCount - 1 %> 건 <% } %></a>
							</div>
						</td>
						<td width="10%"><strong><%=total_price %>원</strong></td>
						<td width="*"><%=status %></td>
						<td width="10%">
							<input type="button" value="조회" onclick="showOrder('frm_op<%=count %>');"/>
						</td>
					</tr>
				</form>		
				</tbody>
				
<%
		} while (rs.next());		
	} else {
%>
	<tr><td colspan="6" align="center">회원님의 주문 내역이 없습니다.</td></tr>
<%
	}
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로고침]을 누르거나 첫 화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		rs2.close();	rs3.close();		
		stmt.close();	stmt2.close();	stmt3.close();	
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
				</table>
			</div>
			
		<div class="order_conf_info">
			<span>상품명 또는 주문상세의 조회버튼을 클릭하시면, 주문상세 내역을 확인하실 수 있습니다.</span>
		</div>
	</div>
<%@ include file="inc_html_footer.jsp" %>
<script>
	function showOrder(frm) {
		var obj = eval("document." + frm);
		obj.submit();
	}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<style>
#mypage_table{
    border-top:2px solid black;
    border-bottom:2px solid black;

}

#mypage_table th, #mypage_table td {
    border-top:1px solid gray;
    padding:7px 0 7px 0;
    text-align:center;
}

</style>
<script>
	function showOrder(frm) {
		var obj = eval("document." + frm);
		obj.submit();
	}
</script>

<%
Statement stmt2 = null;		Statement stmt3 = null;
ResultSet rs2 = null;		ResultSet rs3 = null;
String o_id = "", p_id = "";
String memberSql = "select * from orders where m_id = '" + userId + "' ";
memberSql += " and (o_status = 'A' or o_status = 'B' or o_status = 'C' or o_status = 'D' or o_status = 'E' or o_status = 'K')";
String detailSql = "";
String productSql = "";
String countSql = "";
String title = "", orderDate = "", status = "";
int total_price = 0, count = 0, height = 0;
int orderCount = 0;
%>
<table id="mypage_table" width="1150px" align="center" >
	<tr background="#FFA5C3" bgcolor="#FFA5C3" >
		<th>번호 </th>
		<th>주문일자</th>
		<th>상품명</th>
		<th>결제 금액</th>
		<th>주문상태</th>
		<th>상세조회</th>
	</tr>
	
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
			
			if (status.equals("A"))	{		status = "결제대기";		}
			else if (status.equals("B")) {	status = "배송준비중";		} 
			else if (status.equals("C")) {	status = "배송중";		}
			else if (status.equals("D")) {	status = "배송완료";		}
			else if (status.equals("E")) {	status = "구매결정완료";	}
			else if (status.equals("K")) {	status = "결제완료";		}
			
			countSql = "select count(od_idx) from orderdetail where o_id = '" + o_id + "'";
			rs3 = stmt3.executeQuery(countSql);
			if (rs3.next()) { orderCount = rs3.getInt(1);	rs3.close(); }
%>
				<form name="frm_op<%=count %>" action="order_check.jsp" method="post">
				<input type="hidden" name="o_id" value="<%=o_id %>" />
				<input type="hidden" name="p_id" value="<%=p_id %>" />
					<tr>
						<td width="10%"><%=count %></td>
						<td width="15%"><%=orderDate %></td>
						<td width="30%" class="order_conf_name">
							<div><a href="#" onclick="showOrder('frm_op<%=count %>');"><%=title %></a></div>
							<div>
								<a href="#" onclick="showOrder('frm_op<%=count %>');"><%=height %>cm
								<% if (orderCount >= 2) { %> 외 <%=orderCount - 1 %> 건 <% } %></a>
							</div>
						</td>
						<td width="10%"><strong><%=total_price %>원</strong></td>
						<td width="*"><%=status %></td>
						<td width="15%">
							<input type="button" class="btn_style" value="조회" onclick="showOrder('frm_op<%=count %>');"/>
						</td>
					</tr>
					
				</form>	
							
<%
		} while (rs.next());		
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
			
<div class="order_conf_info">
	<span>상품명 또는 주문상세의 조회버튼을 클릭하시면, 주문상세 내역을 확인하실 수 있습니다.</span>
</div>
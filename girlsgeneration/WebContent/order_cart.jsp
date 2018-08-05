<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장바구니 페이지</title>
<%@ include file="inc_html_header.jsp" %>
<link rel="stylesheet" type="text/css" href="css/order.css" />
<script>
function checkAll(allChk) {
	var isChk = allChk.checked;
	for (var i = 0 ; i < chkbox.length ; i++) {
		chkbox[i].checked = isChk;
	}
}


function countChange(changeType, idx) {
	var obj = eval("document.frm_cart.qtyCart" + idx);
	var amount = parseInt(obj.value);
	var obj2 = eval("document.frm_cart.min_add_amount" + idx);
	
	if (typeof obj2 == 'undefined') {
		var min_add_amount = 1;
	} else {
		var min_add_amount = parseInt(obj2.value);
	}
	if (changeType == 1) {
        amount += min_add_amount;
    } else if (changeType == 0) {
        if (amount > 1) {
            amount -= min_add_amount;
        } else {
        	alert("더 줄일 수 없습니다.");
        }
    }
	obj.value = amount;
}


function send_cart(ctype, idx) {
	var ctypeObj = eval("document.frm_cart.ctype" + idx);
	var qtyObj = eval("document.frm_cart.qtyCart" + idx);
	var pidObj = eval("document.frm_cart.p_id" + idx);
	var sizeObj = eval("document.frm_cart.selectsize" + idx);
	var colorObj = eval("document.frm_cart.selectcolor" + idx);
	
	document.frm_cart.count.value = idx;
	
	if (ctype == 'del') {
		if (confirm('삭제하시겠습니까?')) {
			ctypeObj.value = 'del';
			document.frm_cart.action = 'order_cart_proc.jsp';
			document.frm_cart.submit();
		}
	} else if (ctype == 'up') {
		qtyObj.value = qtyObj.value.replace(/-/g, '');
		if (isNaN(qtyObj.value) || qtyObj.value == '0') {
			alert('수량을 정확히 입력하세요.');
			return;
		} else {
			ctypeObj.value = 'up';
			document.frm_cart.action = 'order_cart_proc.jsp?selectamount=' + qtyObj.value;
			document.frm_cart.submit();
		}
	}
	
}

function clear_cart() {
	var frm = document.getElementById("frm_clear");
	if (confirm('정말 비우시겠습니까?')) {
		frm.ctype.value = 'clear';
		frm.action = 'order_cart_proc.jsp';
		frm.submit();
	}
}

function multi_process() {
	document.frm_cart.action = "order_multi_process.jsp";
	document.frm_cart.submit();
}

</script>
</head>
<body>
<%
Statement stmt2 = null;
ResultSet rs2 = null;
String m_id = "";
String p_id = "";
String selectcolor = "";
int height = 0, total_price = 0, delivery_price = 0, p_price = 0, multi_price = 0, reserve = 0, multi_reserve = 0, total_reserve = 0, count = 0, selectamount = 0, selectsize = 0;
String img = "", title = "";
String productSQL = "";

if (isLogin) {
	m_id = userId;
} else {
	m_id = "비회원";
}

String cartSQL = "select * from order_cart where m_id = '" + m_id + "'";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	
	rs = stmt.executeQuery(cartSQL);
	
%>
<div class="contents_area">
	<div class="page_title">
		<span>CART LIST</span>
	</div>
	<div class="section_cart_list">
		<h3>SHOPPING CART</h3>
		<form name="frm_cart" method="post">
		<input type="hidden" name="count" />
		<table class="table_cart_list">
		<tr>
			<th>NO.</th>
			<th>THUMBNAIL</th>
			<th>PRODUCT NAME</th>
			<th>QTY</th>
			<th>PRICE</th>
			<th>TOTAL</th>
			<th>RESERVE</th>
			<th>REMOVE</th>
		</tr>
		<%
		if (rs.next()) {
			do {
				count++;
				p_id = rs.getString("p_id");
				selectcolor = rs.getString("po_color");
				selectsize = rs.getInt("po_size");
				selectamount = rs.getInt("oc_count");
				productSQL = "select * from products where p_id = '" + p_id + "'";
				rs2 = stmt2.executeQuery(productSQL);
				if (rs2.next()) {
					img = rs2.getString("p_img1");
					title = rs2.getString("p_title");
					height = rs2.getInt("p_height");
					p_price = rs2.getInt("p_price");
				}
				multi_price = p_price * selectamount;
				multi_reserve = multi_price / 10;
				reserve = p_price / 10;
				total_price += multi_price;
				total_reserve = total_price / 10;
				if (total_price >= 50000) {
					delivery_price = 0;
				} else {
					delivery_price = 2500;
				}
		%>
		<input type="hidden" name="p_id<%=count %>" value="<%=p_id %>" />
		<input type="hidden" name="img<%=count %>" value="<%=img %>" />
		<input type="hidden" name="title<%=count %>" value="<%=title %>" />
		<input type="hidden" name="height<%=count %>" value="<%=height %>" />
		<input type="hidden" name="selectsize<%=count %>" value="<%=selectsize %>" />
		<input type="hidden" name="selectcolor<%=count %>" value="<%=selectcolor %>" />
		<input type="hidden" name="selectamount<%=count %>" value="<%=selectamount %>" />
		<input type="hidden" name="p_price<%=count %>" value="<%=p_price %>" />
		<input type="hidden" name="multi_price<%=count %>" value="<%=multi_price %>" />
		<input type="hidden" name="reserve<%=count %>" value="<%=reserve %>" />
		<input type="hidden" name="multi_reserve<%=count %>" value="<%=multi_reserve %>" />
		<input type="hidden" name="chkbox" />
		<input type="hidden" name="ctype<%=count %>" />
		<input type="hidden" name="min_add_amount<%=count %>" value="1" />
		<tr>
			<td>
				<%=count %>
			</td>
			<td class="td_product_image" width="5%">
				<a href="product_detail.jsp?p_id=<%=p_id %>"><img src="<%=img %>" /></a>
			</td>
			<td class="td_product_info">
				<div class="box_product"><a href="product_detail.jsp?p_id=<%=p_id %>"><%=title %></a></div>
				<div class="box_product_height"><a href="product_detail.jsp?p_id=<%=p_id %>"><%=height %> cm</a></div>
				<div class="box_product_option">
					<img src="images/order_optionicon.gif" />
					color : <%=selectcolor %>, size : <%=selectsize %>
				</div>
			</td>
			<td>
				<div class="cart_qty">
					<a href="javascript:countChange(0, <%=count %>);"><img src="images/btn_down.gif" /></a>
					<input type="text" name="qtyCart" class="qtyCart" id="qtyCart<%=count %>" value="<%=selectamount %>" readonly="readonly" />
					<a href="javascript:countChange(1, <%=count %>);"><img src="images/btn_up.gif" /></a>
				</div>
				<div class="cart_qty_modify">
					<a href="javascript:send_cart('up', <%=count %>)"><img src="images/btn_qty.png" /></a>
				</div>
			</td>
			<td><%=p_price %>원</td>
			<td><strong><%=multi_price %>원</strong></td>
			<td><%=multi_reserve %>원</td>
			<td>
				<a href="javascript:send_cart('del', <%=count %>)"><img src="images/btn_remove.png" /></a>
			</td>
		</tr>
		<%
			} while (rs.next());
		%>
		<tr>
			<td colspan="8" class="cart_total">
				TOTAL PRICE : <%=total_price %>원 + 배송비 <%=delivery_price %>원 = <strong><%=total_price + delivery_price %>원</strong>(적립금 <%=total_reserve %>원)
			</td>
		</tr>
		</table>
		<input type="hidden" name="cart_count" value="<%=count %>" />
		</form>
		<%
		} else {
		%>
		<tr><td colspan="8">장바구니에 담긴 상품이 없습니다.</td></tr></table>
		<%
		}
		%>
	</div>
	<div class="delivery_info"><span>50,000원 미만의 주문은 배송비를 청구합니다</span></div>
	<form name="frm_clear" id="frm_clear" method="post">
	<input type="hidden" name="ctype" value="clear" />
	<div class="order_btn">
		<a href="javascript:multi_process(<%=count %>)"><img src="images/btn_order.png" /></a>
		<a href="main.jsp"><img src="images/shop_again.png" /></a>
		<a href="javascript:clear_cart();"><img src="images/clear_cart.png" /></a>
	</div>
	</form>
</div>
<%
} catch(Exception e) {
	out.println("DB작업 오류");
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
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>

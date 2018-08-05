<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Statement stmt2 = null;
ResultSet rs2 = null;
String p_id = request.getParameter("p_id");
String selectcolor = request.getParameter("selectcolor");	// 넘어온 색상
String selectsize = request.getParameter("selectsize");		// 넘어온 사이즈
String amount = request.getParameter("selectamount");	// 넘어온 갯수
int selectamount = 1;
String productSQL = "select * from products where p_id = '" + p_id + "'";
String optionSQL = "select * from products_option where p_id = '" + p_id + "' and po_size = '" + selectsize + "' and po_color = '" + selectcolor + "'";
String msg = "";

String img = "", title = "";
int height = 0, p_price = 0, multi_price = 0, reserve = 0, delivery_price = 0, discountRate = 0, discount_price = 0, total_price = 0;
int point = 0, qty_point = 0;

if (amount == null || amount.equals("")) {
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
} else {
	selectamount = Integer.parseInt(amount);
}


String name = "", email = "", level = "";
String phone = "", phone1 = "", phone2 = "", phone3 = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문 진행 페이지</title>
<link rel="stylesheet" type="text/css" href="css/order.css" />
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(productSQL);
	
	stmt2 = conn.createStatement();
	rs2 = stmt2.executeQuery(optionSQL);

	if (rs.next()) {
		img = rs.getString("p_img1");
		title = rs.getString("p_title");
		height = rs.getInt("p_height");
		p_price = rs.getInt("p_price");
		multi_price = p_price * selectamount;
		reserve = multi_price / 10;
		if (multi_price >= 50000) {
			delivery_price = 0;
		} else {
			delivery_price = 2500;
		}
	}
	
	if (rs2.next()) {
		selectsize = rs2.getString("po_size");
		selectcolor = rs2.getString("po_color");
	}

%>
	<form name="frm_order_process" action="order_proc.jsp" method="post" onsubmit="return chkOrderForm(this);">
	<input type="hidden" name="p_id" value="<%=p_id %>" />
	<input type="hidden" name="p_price" value="<%=p_price %>" />
	<input type="hidden" name="img" value="<%=img %>" />
	<input type="hidden" name="title" value="<%=title %>" />
	<input type="hidden" name="height" value="<%=height %>" />
	<input type="hidden" name="selectsize" value="<%=selectsize %>" />
	<input type="hidden" name="selectcolor" value="<%=selectcolor %>" />
	<input type="hidden" name="selectamount" value="<%=selectamount %>" />
	<input type="hidden" name="isChk" />
	<div class="contents_area">
		<div class="page_title">
			<span>ORDER PROCESS</span>
		</div>
		<div class="section_order_list">
			<h3>주문리스트</h3>
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
							<a href=""><img src="<%=img %>" /></a>
						</td>
						<td class="td_product_info" width="*">
							<div class="box_product"><%=title %></div>
							<div class="box_product_height"><%=height %> cm</div>
						</td>
						<td class="td_price" width="10%">
							<div class="box_product_price"><%=p_price %> 원</div>
						</td>
						<td class="td_product" width="10%">
							<div class="box_product_ea"><%=selectamount %> ea</div>
						</td>
						<td class="td_price" width="15%">
							<div class="box_product_price"><%=multi_price %> 원</div>
						</td>
						<td class="td_reserve" width="10%">
							<div class="box_product_reserve"><%=reserve %></div>
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<div class="option">
								option : color - <%=selectcolor %>, size : <%=selectsize %>
							</div>
						</td>
					</tr>				
				</tbody>
			</table>
			<%
			rs.close();
			
			if (isLogin) {
				rs = stmt.executeQuery("select * from member where m_id = '" + userId + "'");
			}

			if (isLogin && rs.next()) {
				point = rs.getInt("m_point");
				name = rs.getString("m_name");
				email = rs.getString("m_email");
				phone = rs.getString("m_phone");
				phone1 = phone.split("-")[0];
				phone2 = phone.split("-")[1];
				phone3 = phone.split("-")[2];
				level = rs.getString("m_level");
				
				if (level.equals("N")) {
					level = "일반회원"; 
				} else if (level.equals("S")) {
					level = "실버회원";	
					discountRate = 3;
				} else if (level.equals("G")) {
					level = "골드회원";
					discountRate = 5;
				} else if (level.equals("V")) {
					level = "VIP회원";
					discountRate = 7;
				} else if (level.equals("M")) {
					level = "마스터회원";
					discountRate = 10;
				}
				
				discount_price = multi_price * discountRate / 100;
			}
			
			total_price = multi_price + delivery_price - discount_price;
			
			if (isLogin) {
			%>
			<div class="membership_order">
				<span class="membership_order_image"><img src="images_product/1132.jpg" /></span>
				<div class="membership_order_info"><%=userName %>님은 <strong>[<%=level %>]</strong>입니다.</div>
				<div class="membership_discount_info"><%=userName %>님의 할인 예정 금액은 <strong><input type="text" name="qty_membership" id="qty_membership" value="<%=discount_price %>" />원</strong>입니다.</div>
			</div>
			<div class="ask_point">
				<span>보유 적립금 사용</span>
				<span>
					&nbsp;&nbsp;&nbsp;<input type="text" name="qty_point" id="qty_point" class="text_point" value="0" onKeyUp=" onlyNumber(this); checkPoint(this.value); removeChar(event);" />
					 <strong>원</strong>	
					&nbsp;&nbsp;&nbsp;회원님의 총 할인 예정 금액은 <strong><span id="discountPrice"></span></strong>원입니다.
				</span>
			</div>
			<div class="info_point">
				<span>현재 회원님이 보유하고 계신 적립금은 <strong><%=point %></strong>원입니다.</span>
			</div>
		</div>
		<%
			}
		%>
		<div class="order_basic">
			<h3>주문자정보</h3>
			<table class="table_order_basic">
				<tr>
					<th width="10%">이름</th>
					<td width="*">
						<input type="text" name="order_name" class="order_name" id="order_name" value="<%=name %>" <%=(isLogin) ? "readonly='readonly'" : "" %>/>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="order_email" class="order_email" value="<%=email %>" /></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input type="text" name="order_phone1" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" value="<%=phone1 %>" maxlength="3" /> - 
						<input type="text" name="order_phone2" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" value="<%=phone2 %>" maxlength="4" /> -
						<input type="text" name="order_phone3" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" value="<%=phone3 %>" maxlength="4" />
					</td>
				</tr>
			</table>
		</div>
		<div class="order_address">
			<h3>배송 정보</h3>
			<span>
				<input type="checkbox" name="order_isSame" id="order_isSame" value="S" onclick="sameInfo(this.form);" />
				<label for="order_isSame">주문자 정보와 같음</label>
			</span>
			<table class="table_order_address">
				<tr>
					<th width="10%">이름</th>
					<td width="*">
						<input type="text" name="order_address_name" class="order_address_name" />
					</td>
				</tr>
				<tr>
					<th>연락처 1</th>
					<td>
						<input type="text" name="order_address_phone1" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" maxlength="3" /> - 
						<input type="text" name="order_address_phone2" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" maxlength="4" /> -
						<input type="text" name="order_address_phone3" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" maxlength="4" />
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3" class="order_address_delivery">
						<input type="radio" name="order_address_choice" id="order_address_choice1" value="saved" onChange="addrChoice(this.form);" <%=(isLogin) ? "" : "disabled='disabled'" %> /> 
							<label for="order_address_choice1"><strong>기존주소</strong></label>&nbsp;
						<input type="button" name="order_address_btn" value="배송지 목록" onclick="chkDelivery();"/>&nbsp;&nbsp;&nbsp;
						<input type="radio" name="order_address_choice" id="order_address_choice2" value="new" onclick="deleteAddr(this.form); <% if (isLogin) { %> addrChoice(this.form); <% } %> "/>
							<label for="order_address_choice2"><strong>신규 배송지</strong></label><br />
						<input type="text" name="order_address_zip" class="order_phone" onKeyUp="onlyNumber(this); removeChar(event);" maxlength="5" />
						<input type="button" name="order_zip_btn" value="우편번호" /> <br />
						<input type="text" name="order_address1" class="order_address_text" />
						<input type="text" name="order_address2" class="order_address_text" />
					</td>
				</tr>
				<tr>
					<th>주문메세지</th>
					<td colspan="3"><textarea class="order_message" name="order_message" placeholder="100자 이내로 작성해 주세요."></textarea></td>
				</tr>
				<tr>
					<th>무통장 입금자명</th>
					<td colspan="3">
						<input type="text" name="order_address_depositer" class="order_address_depositer" value="<%=name %>" />
						(주문자와 같을 경우 생략 가능)
					</td>
				</tr>
			</table>
			<span>
				<input type="checkbox" name="order_address_reg" id="order_address_reg" value="Y" <%=(isLogin) ? "" : "disabled='disabled'" %> />
				<label for="order_address_reg">해당 배송지 정보를 나의 회원정보로 등록합니다.</label>
			</span>
		</div>
		<div class="order_discount">
			<h3>주문상품 할인적용</h3>
			<table class="table_order_discount">
				<tr>
					<th width="20%"><font color="white">상품금액</font></th>
					<th width="3%"></th>
					<th width="20%"><font color="white">배송비</font></th>
					<th width="3%"></th>
					<th width="20%"><font color="white">할인금액</font></th>
					<th width="4%"></th>
					<th width="*"><font color="white">결제 예정금액</font></th>
				</tr>
				<tr>
				<td><input type="text" name="multi_price" class="price" value=<%=multi_price %> readonly="readonly" />원</td>
				<td>+</td>
				<td><input type="text" name="delivery_price" class="price" value=<%=delivery_price %> readonly="readonly" />원</td>
				<td>-</td>
				<td><span id="discountPrice2"><%=discount_price %></span>원</td>
				<td>=</td>
				<td><strong><input type="text" name="finalPrice" class="finalPrice" id="finalPrice" value="<%=total_price %>" readonly="readonly" /></strong>원</td>
				</tr>
			</table>
		</div>
		<div class="order_paymethod">
			<h3>결제 정보</h3>
			<table class="table_order_paymethod">
				<tr>
				<th rowspan="2" width="10%">결제 방법</th>
				<td width="*">
					<input type="radio" name="order_method" id="order_method_cash" value="D" onclick="printAccount(this.value, 'account');" /><label for="order_method_cash">무통장입금</label>
				</td>
				<td width="80%">
					<div id="account" style="display:none">
						<select name="accountlist" id="account_list" onchange="getAccountValue(this.form, this.value);">
							<option value="">계좌번호를 선택하세요.</option>
							<option value="농협 XXX-XXXX-XXXX-XX">농협 XXX-XXXX-XXXX-XX (예금주 : 소녀시대)</option>
							<option value="국민 XXXXXX-XX-XXXXXX">국민 XXXXXX-XX-XXXXXX (예금주 : 소녀시대)</option>
							<option value="우리 XXXX-XXX-XXXXXX">우리 XXXX-XXX-XXXXXX (예금주 : 소녀시대)</option>
							<option value="신한 XXX-XXX-XXXXXX">신한 XXX-XXX-XXXXXX (예금주 : 소녀시대)</option>
						</select>
						<input type="text" name="selectaccount" style="display:none" />
					</div>
				</td>
				</tr>
				<tr>
				<td>
					<input type="radio" name="order_method" id="order_method_card" value="C" onclick="printAccount(this.value, 'account');" /><label for="order_method_card">신용카드</label>
				</td>
				<td>
					<input type="button" name="btn_confirm" value="본인 확인" onclick="cardConfirm();" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="confirm_message" id="confirm_message" value="신용카드 결제를 위해서는 본인 확인이 필요합니다." readonly="readonly" />
				</td>
				</tr>
			</table>
		</div>
		<div class="order_confirm">
			<h3>주문자 동의</h3>
			<table class="table_order_confirm">
				<tr>
				<th width="10%">주문동의</th>
				<td width="*">
					<input type="checkbox" name="order_agree" id="order_agree" value="Y" onclick="agreeClick(this.form);" />
					<label for="order_agree">상기 결제정보를 확인하였으며, 구매진행에 동의합니다.</label>
				</td>
				</tr>
			</table>
			<table class="table_order_final">
				<tr>
				<th width="10%">최종 결제금액</th>
				<td width="*"><strong id="price"><input type="text" name="finalPrice" class="finalPrice" id="finalPrice2" value="<%=total_price %>" readonly="readonly" /></strong><strong id="won">원</strong> (적립예정 : <%=reserve %>원)</td>
				</tr>
			</table>
		<div class="order_btn">
			<input type="submit" name="smt" value="주문하기" disabled="disabled" />&nbsp;&nbsp;<input type="button" value="주문 취소" />
		</div>
		</div>
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
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
<script>
function chkOrderForm(frm) {
	var name = frm.order_name.value.trim();
	var email = frm.order_email.value.trim();
	var phone1 = frm.order_phone1.value.trim();
	var phone2 = frm.order_phone2.value.trim();
	var phone3 = frm.order_phone3.value.trim();
	var rname = frm.order_address_name.value.trim();
	var rphone1 = frm.order_address_phone1.value.trim();
	var rphone2 = frm.order_address_phone2.value.trim();
	var rphone3 = frm.order_address_phone3.value.trim();
	var choice = frm.order_address_choice.value;
	var zip = frm.order_address_zip.value.trim();
	var addr1 = frm.order_address1.value.trim();
	var addr2 = frm.order_address2.value.trim();
	var reg = frm.order_address_reg.value;
	var method = frm.order_method.value;
	var account = frm.selectaccount.value;
	var isChk = frm.isChk.value;
	
	if (name == "") {
		alert("이름은 필수 입력 항목입니다.");
		frm.order_name.value = "";
		frm.order_name.focus();
		return false;
	}
	
	if (email == "") {
		alert("이메일은 필수 입력 항목입니다.");
		frm.order_name.value = "";
		frm.order_name.focus();
		return false;
	}
	
	if (phone1 == "") {
		alert("전화번호는 필수 입력 항목입니다.");
		frm.order_phone1.value = "";
		frm.order_phone1.focus();
		return false;
	} else if (phone1.length < 3) {
		alert("전화번호를 다시 한 번 확인해 주세요.");
		frm.order_phone1.value = "";
		frm.order_phone1.focus();
		return false;
	}
	
	if (phone2 == "") {
		alert("전화번호는 필수 입력 항목입니다.");
		frm.order_phone2.value = "";
		frm.order_phone2.focus();
		return false;
	} else if (phone2.length < 3) {
		alert("전화번호를 다시 한 번 확인해 주세요.");
		frm.order_phone2.value = "";
		frm.order_phone2.focus();
		return false;
	}
	
	if (phone3 == "") {
		alert("전화번호는 필수 입력 항목입니다.");
		frm.order_phone3.value = "";
		frm.order_phone3.focus();
		return false;
	} else if (phone3.length < 4) {
		alert("전화번호를 다시 한 번 확인해 주세요.");
		frm.order_phone3.value = "";
		frm.order_phone3.focus();
		return false;
	}
	
	if (rname == "") {
		alert("받는 분 이름은 필수 입력 항목입니다.");
		frm.order_address_name.value = "";
		frm.order_address_name.focus();
		return false;
	}
	
	if (rphone1 == "") {
		alert("받는 분 전화번호는 필수 입력 항목입니다.");
		frm.order_address_phone1.value = "";
		frm.order_address_phone1.focus();
		return false;
	} else if (rphone1.length < 3) {
		alert("받는 분 전화번호를 다시 한 번 확인해 주세요.");
		frm.order_address_phone1.value = "";
		frm.order_address_phone1.focus();
		return false;
	}
	
	if (rphone2 == "") {
		alert("받는 분 전화번호는 필수 입력 항목입니다.");
		frm.order_address_phone2.value = "";
		frm.order_address_phone2.focus();
		return false;
	} else if (rphone2.length < 3) {
		alert("받는 분 전화번호를 다시 한 번 확인해 주세요.");
		frm.order_rphone2.value = "";
		frm.order_rphone2.focus();
		return false;
	}
	
	if (rphone3 == "") {
		alert("받는 분 전화번호는 필수 입력 항목입니다.");
		frm.order_rphone3.value = "";
		frm.order_rphone3.focus();
		return false;
	} else if (rphone3.length < 4) {
		alert("받는 분 전화번호를 다시 한 번 확인해 주세요.");
		frm.order_address_phone3.value = "";
		frm.order_address_phone3.focus();
		return false;
	}
	
	if (zip == "") {
		alert("주소는 필수 입력 항목입니다.");
		frm.order_address_zip.value = "";
		frm.order_address_zip.focus();
		return false;
	} else if (zip.length < 5) {
		alert("우편번호를 다시 한 번 확인해 주세요.");
		frm.order_address_zip.value = "";
		frm.order_address_zip.focus();
		return false;
	}
	
	if (addr1 == "") {
		alert("주소는 필수 입력 항목입니다.");
		frm.order_address1.value = "";
		frm.order_address1.focus();
		return false;
	}
	
	if (addr2 == "") {
		alert("주소는 필수 입력 항목입니다.");
		frm.order_address2.value = "";
		frm.order_address2.focus();
		return false;
	}
	
	if (method == "") {
		alert("결제수단을 선택해주세요.");
		frm.order_method[0].focus();
		return false;
	}
	
	if (method == "D" && account == "") {
		alert("입금할 계좌를 선택해주세요.");
		frm.accountlist.focus();
		return false;
	}
	
	if (method == "C" && isChk != "Y") {
		alert("본인 확인이 완료되어야 합니다.");
		frm.btn_confirm.focus();
		return false;
	}
}

function addrChoice(frm) {
	if (frm.order_address_choice.value == "saved") {
		frm.order_address_reg.disabled = true;	
	} else if (frm.order_address_choice.value == "new") {
		frm.order_address_reg.disabled = false;
	}
}

function getAccountValue(frm, val) {
	frm.selectaccount.value = val;
}

function cardConfirm() {
	var isOK = confirm("신용카드로 결제하시겠습니까?");
	if (isOK) {
		alert("본인 확인 창으로 이동합니다.");
		window.open("card_confirm.jsp", "a", "width=500,height=300,top=50,left=50");
	}
}

function printAccount(value, id) {
	if (value == "D") {
		document.getElementById(id).style.display = "block";
	} else {
		document.getElementById(id).style.display = "none";
	}
}

function deleteAddr(frm) {
	var chkRadio = document.getElementsByName("order_address_choice");
		for (var i = 0 ; i < chkRadio.length ; i++) {
			if (chkRadio[i].checked == true) {
				frm.order_address_zip.value = "";
				frm.order_address1.value = "";
				frm.order_address2.value = "";
			}
		}
}

function chkDelivery() {
	window.open("delivery_list.jsp", "a", "width=800,height=500,top=50,left=50")
}

function checkPoint(inputPoint) {
	var p_price = <%=multi_price %>;
	var d_price = <%=delivery_price %>;
	var user_point = <%=point %>;
	var discount = <%=discount_price %>;
	var obj = document.getElementById("discountPrice");
	var obj2 = document.getElementById("discountPrice2");
	var obj3 = document.getElementById("finalPrice");
	var obj4 = document.getElementById("finalPrice2");

	if (inputPoint > user_point) {
		alert('보유 적립금을 초과하였습니다.');
		qty_point.value = 0;
		obj.innerHTML = "0";
		obj2.innerHTML = "0";
	} else {
		obj.innerHTML = parseInt(inputPoint) + parseInt(discount);
		obj2.innerHTML = parseInt(inputPoint) + parseInt(discount);
		obj3.value = parseInt(p_price) + parseInt(d_price) - (parseInt(inputPoint) + parseInt(discount));
		obj4.value = obj3.value;
		if (isNaN(obj.innerHTML)) {
			obj.innerHTML = parseInt(discount);
			obj2.innerHTML = parseInt(discount);
			obj3.value = parseInt(p_price) + parseInt(d_price) - parseInt(discount);
			obj4.value = obj3.value;
		}
	}
}
/*
		function onlyNumber(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) {} 
				return;
			}
			else {
				return false;
			}
		}
		
		function finalConfirm(frm) {
			var qty_point = frm.qty_point.value;
			var total_price = ;
			var finalPrice = total_price - qty_point;
			var payMethod = "";
	
			var chkRadio = document.getElementsByName("order_method");
			for (var i = 0 ; i < chkRadio.length ; i++) {
				if (chkRadio[i].checked == true) {
					payMethod = chkRadio[i].value;
					break;
				}
			}
			
			if (payMethod == "C") {
				payMethod = "신용카드";
			} else if (payMethod == "D") {
				payMethod = "무통장 입금";
			}
			
			var msg = "다음 주문 정보가 맞습니까? 결제 금액 : ";
			msg += finalPrice;
			msg += ", 결제 방식 : ";
			msg += payMethod;
			
			var isOK = confirm(msg);
			if (isOK) {
				alert("주문이 완료되었습니다. 주문 확인창으로 이동합니다.");
			} else {
				location.replace("order_process.jsp");
			}
			//document.frm_order_process.submit();
		}
*/
function onlyNumber(obj) {
	if (isNaN(obj.value)) {
		alert("숫자만 입력가능 합니다.");
		obj.value = "";
	}
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function saveVariables(frm) {
	order_name = frm.order_name.value;	order_phone1 = frm.order_phone1.value;	
	order_phone2 = frm.order_phone2.value;	order_phone3 = frm.order_phone3.value;
}

function sameInfo(frm) {
	var order_name = "";	var order_phone1 = "";
	var order_phone2 = "";	var order_phone3 = "";
	if (frm.order_isSame.checked) {
		saveVariables(frm);
		frm.order_address_name.value = frm.order_name.value;
		frm.order_address_phone1.value = frm.order_phone1.value;
		frm.order_address_phone2.value = frm.order_phone2.value;
		frm.order_address_phone3.value = frm.order_phone3.value;
	} else {
		frm.order_address_name.value = order_name;
		frm.order_address_phone1.value = order_phone1;
		frm.order_address_phone2.value = order_phone2;
		frm.order_address_phone3.value = order_phone3;
	}
}

function agreeClick(frm) {
	if (frm.order_agree.checked == true) {
		frm.smt.disabled = false;
	} else {
		frm.smt.disabled = true;
	}
}
</script>
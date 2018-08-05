<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_html_header.jsp" %>
<%
Statement stmt2 = null;
ResultSet rs2 = null;

int orderCount = 0;
String countSql = "";

Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);
int month = today.get(Calendar.MONTH) + 1;
int date = today.get(Calendar.DATE);

String cb = request.getParameter("cb");		// 대분류 콤보박스에서 선택한 카테고리
String cm = request.getParameter("cm");		// 중분류 콤보박스에서 선택한 카테고리
String nb = request.getParameter("nb");
String cateSql = "";	// 검색조건에서 카테고리 선택 시 추가할 쿼리문

String ktype = request.getParameter("ktype");	// 검색어 콤보박스에서 선택한 카테고리(keyword type)
String keyword = request.getParameter("keyword");	// 검색어에 관리자가 직접 입력한 키워드

String statusArr[] = request.getParameterValues("option_status");	// 주문상태 체크박스에서 체크한 항목을 가져올 배열 생성
String statusSql = "";	// 주문 상태 조건 쿼리는 substring이 필요하기 때문에 따로 선언

String sorting = request.getParameter("sorting");	// 정렬방식

String limit = request.getParameter("limit");	// 목록개수

String startYear = request.getParameter("startYear");
String startMonth = request.getParameter("startMonth");
String startDay = request.getParameter("startDay");
String endYear = request.getParameter("endYear");
String endMonth = request.getParameter("endMonth");
String endDay = request.getParameter("endDay");


if (startMonth == null || startMonth.equals("")) {
	startMonth = "01";
} else if ((startMonth != null || !startMonth.equals("")) && startMonth.length() == 1) {
	startMonth = "0" + startMonth;
}

if (startDay == null || startDay.equals("")) {
	startDay = "01";
} else if ((startDay != null || !startDay.equals("")) && startDay.length() == 1) {
	startDay = "0" + startDay;
}

if (endMonth == null || endMonth.equals("")) {
	endMonth = "" + month;
} else if ((endMonth != null || !endMonth.equals("")) && endMonth.length() == 1) {
	endMonth = "0" + endMonth;
}

if (endDay == null || endDay.equals("")) {
	endDay = "" + date;
} else if ((endDay != null || !endDay.equals("")) && endDay.length() == 1) {
	endDay = "0" + endDay;
}

String startDate = startYear + "-" + startMonth + "-" + startDay;	// 날짜를 yyyy-mm-dd로 표현
String endDate = endYear + "-" + endMonth + "-" + endDay;


String o_id = "", o_date = "", m_id = "", p_id = "", title = "", status = "";
int totalPrice = 0, count = 0;

String sql = "select o.o_id, p.p_id, o.o_date, o.m_id, o.o_totalprice, p.p_title, o.o_status from orders o, products p, orderdetail d where o.o_id = d.o_id and p.p_id = d.p_id ";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문 관리 페이지</title>
<link rel="stylesheet" type="text/css" href="css/admin_order.css" />
<script src="//code.jquery.com/jquery.min.js"></script>
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

function showOrder(idx) {
	document.frm_order_search.count.value = idx;
	document.frm_order_search.action = "admin_order_detail.jsp";
	document.frm_order_search.submit();
}
</script>
</head>
<body>
<form name="frm_order_search" action="" method="get">
<div class="contents_area">
	<div class="page_title">
		<span>ORDER MANAGEMENT</span>
	</div>
	<div class="section_searchBox">
		<h3>주문목록</h3>
		<input type="hidden" name="count" />
		<table class="table_searchBox">
			<tr>
				<th>카테고리 선택</th>
				<td colspan="3">
					<select name="cb" onChange="setCata(this, this.form.cm);">
						<option value="">-- 대분류명 --</option>
						<option value="1">HEEL/PUMPS</option>
						<option value="2">LOAFER/FLAT</option>
						<option value="3">SNEAKERS</option>
						<option value="4">SANDALS</option>
						<option value="5">BOOTS/WALKER</option>
					</select>
					<select name="cm">
						<option value="">-- 중분류명 --</option>
					</select>
					<select name="nb">
						<option value="">-- New/Best여부 --</option>
						<option value="n">New</option>
						<option value="b">Best</option>
						<option value="nb">New/Best 모두</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>검색어</th>
				<td colspan="3">
					<select name="ktype">
						<option value="">-- 검색조건 선택 --</option>
						<option value="o_id">주문번호</option>
						<option value="m_id">주문자 아이디</option>
						<option value="p_id">상품코드</option>
					</select>
					<input type="text" name="keyword" placeholder="검색어 입력" />
				</td>
			</tr>
			<tr>
				<th>주문처리상태
				<td colspan="3" class="checkbox">
					<input type="checkbox" name="option_status" value="A" id="A" /><label for="A">결제대기</label>&nbsp;
					<input type="checkbox" name="option_status" value="B" id="B" /><label for="B">배송준비중</label>&nbsp;
					<input type="checkbox" name="option_status" value="C" id="C" /><label for="C">배송중</label>&nbsp;
					<input type="checkbox" name="option_status" value="D" id="D" /><label for="D">배송완료</label>&nbsp;
					<input type="checkbox" name="option_status" value="E" id="E" /><label for="E">구매결정</label>&nbsp;
					<input type="checkbox" name="option_status" value="F" id="F" /><label for="F">교환요청</label>&nbsp;
					<input type="checkbox" name="option_status" value="G" id="G" /><label for="G">환불요청</label>&nbsp;
					<input type="checkbox" name="option_status" value="H" id="H" /><label for="H">주문취소요청</label>&nbsp;
					<input type="checkbox" name="option_status" value="I" id="I" /><label for="I">교환완료</label>&nbsp;
					<input type="checkbox" name="option_status" value="L" id="L" /><label for="L">환불완료</label>&nbsp;
					<input type="checkbox" name="option_status" value="J" id="J" /><label for="J">주문취소완료</label>&nbsp;
					<input type="checkbox" name="option_status" value="K" id="K" /><label for="K">결제완료</label>
				</td>
			</tr>
			<tr>
				<th>정렬방식</th>
				<td>
					<select name="sorting">
						<option value="latest">최신순</option>
						<option value="highP">구매금액 높은순</option>
						<option value="lowP">구매금액 낮은순</option>
					</select>
				</td>
				<th width="10%">목록갯수</th>
				<td><input type="text" value="10" name="limit" id="limit" />
			</tr>
			<tr>
				<th>주문일자</th>
				<td colspan="3">
					<select name="startYear" id="startYear">
						<%
						for (int i = 2000 ; i <= year ; i++) {
						%>
							<option value="<%=i %>" <% if (i == year) { %> selected="selected" <% } %>><%=i %></option>
						<%
						}
						%>
					</select> 년
					<select name="startMonth" id="startMonth">
						<%
						for (int i = 1 ; i <= 12 ; i++) {
						%>
							<option value="<%=i %>"><%=i %></option>
						<%
						}
						%>
					</select> 월
					<select name="startDay" id="startDay">
						<%
						for (int i = 1 ; i <= 31 ; i++) {
						%>
							<option value="<%=i %>"><%=i %></option>
						<%
						}
						%>
					</select> 일 ~
					<select name="endYear" id="endYear">
						<%
						for (int i = 2000 ; i <= year ; i++) {
						%>
							<option value="<%=i %>" <% if (i == year) { %> selected="selected" <% } %>><%=i %></option>
						<%
						}
						%>
					</select> 년
					<select name="endMonth" id="endMonth">
						<%
						for (int i = 1 ; i <= 12 ; i++) {
						%>
							<option value="<%=i %>" <% if (i == month) { %> selected="selected" <% } %>><%=i %></option>
						<%
						}
						%>
					</select> 월
					<select name="endDay" id="endDay">
						<%
						for (int i = 1 ; i <= 31 ; i++) {
						%>
							<option value="<%=i %>" <% if (i == date) { %> selected="selected" <% } %>><%=i %></option>
						<%
						}
						%>
					</select> 일
				</td>
			</tr>
			<tr>
				<td colspan="4" class="btn_search">
					<input type="submit" value="검 색" />&nbsp;&nbsp;
					<input type="button" value="초기화면" onclick="location.replace('admin_order.jsp');" />
				</td>
			</tr>
		</table>
	</div>
	<div class="section_searchResult">
		<h3>검색 결과</h3>
		<table class="table_searchResult">
			<tr>
				<th>번호</th>
				<th>주문번호</th>
				<th>주문일자</th>
				<th>주문아이디</th>
				<th>주문금액</th>
				<th>주문상품</th>
				<th>주문상태</th>
			</tr>
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	
	// 카테고리 검색 관련 쿼리 조건문 시작
	if (!cb.equals("") && !cm.equals("")) {
		sql += " and p.cb_idx = '" + cb + "' and p.cm_idx = '" + cm + "'";
	} 
	if (!cb.equals("") && cm.equals("")) {
		sql += " and p.cb_idx = '" + cb + "'";
	} 
	if (cb.equals("") && cm.equals("")) {
		sql += "";
	}
	// 카테고리 검색 관련 쿼리 조건문 종료
	
	// New/Best 조건검색 관련 쿼리 조건문 시작
	if (nb.equals("n")) {
		sql += " and p.p_isnewbest = 'n'";
	}
	if (nb.equals("b")) {
		sql += " and p.p_isnewbest = 'b'";
	}
	if (nb.equals("nb")) {
		sql += " and (p.p_isnewbest = 'n' or p.p_isnewbest = 'b')";
	}
	if (nb.equals("")) {
		sql += "";
	}
	
	// New/Best 조건검색 관련 쿼리 조건문 시작
	
	// 검색어로 검색 관련 쿼리 조건문 시작
	if (ktype.equals("o_id")) {
		sql += " and o.o_id like '%" + keyword + "%'";
	}
	if (ktype.equals("m_id")) {
		sql += " and m_id like '%" + keyword + "%'";
	}
	if (ktype.equals("p_id")) {
		sql += " and p.p_id like '%" + keyword + "%'";
	}
	if (ktype.equals("")) {
		sql += "";
	}
	// 검색어로 검색 관련 쿼리 조건문 종료
	
	// 주문처리상태 체크박스 검색 관련 쿼리 조건문 시작
	if (statusArr != null) {
		statusSql += " and (";
		for (int j = 0 ; j < statusArr.length ; j++ ) {
			statusSql += "o.o_status = '" + statusArr[j] + "' or ";
		}
		statusSql += " )";
		statusSql = statusSql.substring(0, statusSql.length() - 5) + ")";
		sql += statusSql;
	}
	// 주문처리상태 체크박스 검색 관련 쿼리 조건문 종료
	
	// 주문일자 관련 쿼리 조건문 시작
		sql += " and o.o_date between '" + startDate + " 00:00:00' and '" + endDate + " 23:59:59'";
	// 주문일자 관련 쿼리 조건문 종료
	
	// 정렬방식 쿼리 조건문 시작
	if (sorting.equals("latest")) {
		sql += " group by o.o_id order by o.o_date desc ";
	}
	if (sorting.equals("highP")) {
		sql += " group by o.o_id order by o.o_totalprice desc ";
	}
	if (sorting.equals("lowP")) {
		sql += " group by o.o_id order by o.o_totalprice ";
	}
	// 정렬방식 쿼리 조건문 종료
	
	// 목록 개수 쿼리 조건문 시작
		//sql += " limit " + limit;
	// 목록 개수 쿼리 조건문 종료
	
	out.println(sql);
	
	rs = stmt.executeQuery(sql);
	
	
	if (rs.next()) {
		do {
			count++;
			o_id = rs.getString("o.o_id");
			p_id = rs.getString("p.p_id");
			o_date = rs.getString("o.o_date");
			m_id = rs.getString("o.m_id");
			totalPrice = rs.getInt("o.o_totalprice");
			title = rs.getString("p.p_title");
			status = rs.getString("o.o_status");
			
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
			rs2 = stmt2.executeQuery(countSql);
			if (rs2.next()) orderCount = rs2.getInt(1);
%>
			<input type="hidden" name="o_id<%=count %>" value="<%=o_id %>" />
			<tr>
				<td><%=count %></td>
				<td><a href="javascript:showOrder(<%=count %>);"><%=o_id %></a></td>
				<td><%=o_date %></td>
				<td><%=m_id %></td>
				<td><%=totalPrice %></td>
				<td>
				<a href="javascript:showOrder(<%=count %>);">
				<%=title %>
				<% if (orderCount >= 2) { %> 외 <%=orderCount - 1 %> 건 <% } %>
				</a>
				</td>
				<td><%=status %></td>
			</tr>
<%
		} while (rs.next());
	} else {
%>
			<tr><td colspan="7" align="center">검색 결과가 없습니다.</td></tr>
<%
	}
} catch(Exception e) {
	out.println("조건 선택 후 [검색]버튼을 누르세요. 조건을 선택하지 않으면 전체 주문 목록이 출력됩니다.");
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
		</table>
	</div>
</div>
</form>
</body>
</html>
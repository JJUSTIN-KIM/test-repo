<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_html_header.jsp" %>
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);
int month = today.get(Calendar.MONTH) + 1;
int date = today.get(Calendar.DATE);

String[] statusArr = { "A", "K", "B", "C", "D", "E", "F", "G", "H", "I", "L", "J" };
String orderSql = "";
int status = 0;
String args = "?count=&cb=&cm=&nb=&ktype=&keyword=&sorting=latest&limit=10&";
args += "startYear=2018&startMonth=1&startDay=1&endYear=2018&endMonth=" + month + "&endDay=" + date + "&option_status=";

String[] dateArr = new String[4];
String dateSql = "";

int[] priceArr = new int[12];
int[] countArr = new int[12];
String pcSql = "";
String statusSql[] = { "and (o_status = 'A')", "and (o_status = 'K' or o_status = 'B' or o_status = 'C' or o_status = 'D' or o_status = 'E')",
		"and (o_status = 'F' or o_status = 'G' or o_status = 'H' or o_status = 'I' or o_status = 'L' or o_status = 'J')" };

String avgSql = "";
int[] avgWeekPriceArr = new int[3];
double[] avgWeekCountArr = new double[3];

int[] avgMonthPriceArr = new int[3];
double[] avgMonthCountArr = new double[3];

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 메인 페이지</title>
<style>
.contents_area {
	position:relative;
	width:1150px;
	top:-100px;
	margin:50px auto 50px auto;
	border:1px solid black;
}

.faq_box {
	float:left;
	padding:0 1px 5px 0;
	margin-bottom:-3px;
}

h3 {
    font-size:1.5em;
    font-weight:bold;
    padding-top:30px;
    padding-bottom:15px;
}

.table_todoList {
    width:100%;
    border-top:2px solid black;
    border-bottom:2px solid black;
}

.table_todoList th {
    font-weight:bold;
    text-align:center;
    font-size:0.8em;
    background:#99cccc;
}

.table_todoList td {
    font-size:0.9em;
    text-align:center;
    height:50px;
}

.table_todoList th, .table_todoList td {
    border-top:1px solid gray;
    padding:10px;
}

</style>
<script>

function change_banner(type) {
	var main_sales = document.getElementById("section_main_sales");
	var button1 = document.getElementById("banner_button_1");

    var main_order = document.getElementById("section_main_order");
    var button2 = document.getElementById("banner_button_2");

    var main_member = document.getElementById("section_main_member");
    var button3 = document.getElementById("banner_button_3");
      
    if (type == null) {
    	main_sales.style.display = "block";
	} else {
    	if (type == 1) {
    		main_sales.style.display = "block";
            button1.src = "../images/admin_main_sales2.png";
            
            main_order.style.display = "none";
            button2.src = "../images/admin_main_order.png";
            
            main_member.style.display = "none";
            button3.src = "../images/admin_main_member.png";
        } else if (type == 2) {
        	main_sales.style.display = "none";
            button1.src = "../images/admin_main_sales.png";

            main_order.style.display = "block";
            button2.src = "../images/admin_main_order2.png";
	
            main_member.style.display = "none";
            button3.src = "../images/admin_main_member.png";
    	} else if (type == 3) {
        	main_sales.style.display = "none";
            button1.src = "../images/admin_main_sales.png";

            main_order.style.display = "none";
            button2.src = "../images/admin_main_order.png";
	
            main_member.style.display = "block";
            button3.src = "../images/admin_main_member2.png";
		} else {
			return;
		}
	}
}
</script>
</head>
<body>
<div class="contents_area">
	<div class="section_todoList">
		<h3>To-do List</h3>
		<table class="table_todoList">
		<tr>
			<th>주문완료/결제대기</th>
			<th>주문완료/결제완료</th>
			<th>배송준비중</th>
			<th>배송중</th>
			<th>배송완료</th>
			<th>구매결정</th>
			<th>교환요청</th>
			<th>환불요청</th>
			<th>취소요청</th>
			<th>교환완료</th>
			<th>환불완료</th>
			<th>취소완료</th>
		</tr>
		<tr>
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	for (int i = 0 ; i < statusArr.length; i++) {
		orderSql = "select count(*) from orders where o_status = '" + statusArr[i] + "'";
		rs = stmt.executeQuery(orderSql);
		if (rs.next()) {
			status = rs.getInt(1);
%>
			<td><a href="admin_order.jsp?<%=args %><%=statusArr[i] %>"><%=status %>건</a></td>
<%			
			rs.close();
			status = 0;
			orderSql = "";
		}
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
		</tr>
		</table>
	<div class="section_overall">
		<h3>쇼핑몰 현황</h3>
		<div class="faq_box"><a href='javascript:change_banner(1);'>
		<img id='banner_button_1' src='../images/admin_main_sales2.png' alt='매출 현황' border=0></a>
		</div>
	
		<div class="faq_box"><a href='javascript:change_banner(2);'>
		<img id='banner_button_2' src='../images/admin_main_order.png'  alt='주문상태 현황' border=0></a>
		</div>
		
		<div class="faq_box"><a href='javascript:change_banner(3);'>
		<img id='banner_button_3' src='../images/admin_main_member.png' alt='회원/포인트 현황' border=0></a>
		</div>
		
		<div id="section_main_sales" class="banner">
			<jsp:include page="admin_main_sales.jsp" />
		</div>
		
		<div id="section_main_order" class="banner" style="display:none;">
			<jsp:include page="admin_main_order.jsp" />
		</div>
		
		<div id="section_main_member" class="banner" style="display:none;">
			<jsp:include page="admin_main_member.jsp" />
		</div>
	</div>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
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
<style>
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
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	

%>
		<table class="table_todoList">
			<tr>
				<th>날짜</th>
				<th>주문</th>
				<th>결제</th>
				<th>교환/환불/취소</th>
			</tr>
<%
	for (int j = 4 ; j > 0; j--) {
		dateSql = "select DATE_ADD(now(), interval -" + (j - 1) + " day)";
		rs = stmt.executeQuery(dateSql);
		if (rs.next()) {
			dateArr[4-j] = rs.getString(1).substring(0, 11);
		}
	}
	rs.close();
%>
<%
	for (int k = 0 ; k < dateArr.length; k++) {
%>
			<tr>
				<td><%=dateArr[k] %><% if (k == 3) { %>(오늘)<% } %></td>
<%
		for (int l = 0 ; l < 3; l++) {
			pcSql = "select sum(o_totalprice), count(*) from orders where o_date between '" + dateArr[k] + " 00:00:00' and '";
			pcSql += dateArr[k] + " 23:59:59' " + statusSql[l];
			rs = stmt.executeQuery(pcSql);
			if (rs.next()) {
				priceArr[k] = rs.getInt(1);
				countArr[k] = rs.getInt(2);
			} else {
				priceArr[k] = 0;
				countArr[k] = 0;
			}
		
%>		
				<td><%=priceArr[k] %>원(<%=countArr[k] %>건)</td>
<%
		}
	}
	rs.close();
%>
			</tr>
			<tr>
				<td>최근 7일 평균</td>
<%
	for (int m = 0 ; m < statusSql.length ; m++) {
		avgSql = "select round(sum(o_totalprice)/7), round(count(*)/7, 2) from orders ";
		avgSql += "where o_date between DATE_ADD(now(), interval -1 week) and now() ";
		avgSql += statusSql[m];
		rs = stmt.executeQuery(avgSql);
		if (rs.next()) {
			avgWeekPriceArr[m] = rs.getInt(1);
			avgWeekCountArr[m] = rs.getDouble(2);
		} else {
			avgWeekPriceArr[m] = 0;
			avgWeekCountArr[m] = 0;
		}
%>
				<td><%=avgWeekPriceArr[m] %>원(<%=avgWeekCountArr[m] %>건)</td>
<%				
	}
	rs.close();
				
%>
			
			</tr>
			<tr>
				<td>최근 30일 평균</td>
<%
	for (int m = 0 ; m < statusSql.length ; m++) {
		avgSql = "select round(sum(o_totalprice)/30), round(count(*)/30, 2) from orders ";
		avgSql += "where o_date between DATE_ADD(now(), interval -1 month) and now() ";
		avgSql += statusSql[m];
		rs = stmt.executeQuery(avgSql);
		if (rs.next()) {
			avgMonthPriceArr[m] = rs.getInt(1);
			avgMonthCountArr[m] = rs.getDouble(2);
		} else {
			avgMonthPriceArr[m] = 0;
			avgMonthCountArr[m] = 0;
		}
%>
				<td><%=avgMonthPriceArr[m] %>원(<%=avgMonthCountArr[m] %>건)</td>
<%				
	}			
%>	
			</tr>
		</table>
<%
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
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);
int month = today.get(Calendar.MONTH) + 1;
int date = today.get(Calendar.DATE);

String[] statusArr = { "A", "K", "B", "C", "D", "E", "F", "G", "H", "I", "L", "J" };
String orderSql = "";
int[] statusArr2 = new int[60];

String totalSql = "";
int[] totalArr = new int[12];


String[] dateArr = new String[5];
String dateSql = "";

%>
<style>
h3 {
    font-size:1.5em;
    font-weight:bold;
    padding-top:30px;
    padding-bottom:15px;
}

.table_todoList {
	top:200px;
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
<body>
		<table class="table_todoList">
		<tr>
			<th>날짜</th>
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
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	for (int j = 5 ; j > 0; j--) {
		dateSql = "select DATE_ADD(now(), interval -" + (j - 1) + " day)";
		rs = stmt.executeQuery(dateSql);
		if (rs.next()) {
			dateArr[5-j] = rs.getString(1).substring(0, 11);
		}
	}
	rs.close();
%>
<%
	for (int i = 0 ; i < dateArr.length ; i++) {
%>
		<tr>
			<td><%=dateArr[i] %></td>
		
<%
		for (int k = 0 ; k < statusArr.length ; k++) {
			orderSql = "select count(*) from orders where o_date between '" + dateArr[i] + " 00:00:00' and '";
			orderSql += dateArr[i] + " 23:59:59' and o_status = '" + statusArr[k] + "'";
			rs = stmt.executeQuery(orderSql);
			if (rs.next()) {
				statusArr2[i] = rs.getInt(1);
			} else {
				statusArr2[i] = 0;
			}
%>
			<td><%=statusArr2[i] %>건</td>
<%
		}
	}
	rs.close();
%>
		</tr>
		<tr>
			<td>합계</td>
<%
		for (int l = 0 ; l < statusArr.length ; l++) {
			totalSql = "select count(*) from orders where o_date between '" + dateArr[0] + " 00:00:00' and '";
			totalSql += dateArr[4] + " 23:59:59' and o_status = '" + statusArr[l] + "'";
			rs = stmt.executeQuery(totalSql);
			if (rs.next()) {
				totalArr[l] = rs.getInt(1);
			} else {
				totalArr[l] = 0;
			}
%>
			<td><%=totalArr[l] %>건</td>
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
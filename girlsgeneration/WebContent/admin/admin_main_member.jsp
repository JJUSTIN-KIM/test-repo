<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<%
Statement stmt2 = null;		Statement stmt3 = null;
ResultSet rs2 = null;		ResultSet rs3 = null;

Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);
int month = today.get(Calendar.MONTH) + 1;
int date = today.get(Calendar.DATE);

String memberSql = "";
int[] memberArr = new int[5];

String pointPlusSql = "";
String pointMinusSql = "";
int[] pointPlusArr = new int[5];
int[] pointMinusArr = new int[5];
int[] pointTotalArr = new int[5];

String totalMemberSql = "";
String totalPointSql = "";
int totalMember = 0;
int totalPoint = 0;


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
			<th>신규 회원 가입 현황</th>
			<th>적립금 적용 현황</th>
		</tr>
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	
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
		memberSql = "select count(*) from member where m_joindate between '" + dateArr[i] + " 00:00:00' and '";
		memberSql += dateArr[i] + " 23:59:59'";
		rs = stmt.executeQuery(memberSql);
		if (rs.next()) memberArr[i] = rs.getInt(1);
		else memberArr[i] = 0;
		pointPlusSql = "select sum(mp_point) from member_point where mp_date between '" + dateArr[i] + " 00:00:00' and '";
		pointPlusSql += dateArr[i] + " 23:59:59' and mp_isuse = 'N'";	// 지급 포인트
		pointMinusSql = "select sum(mp_point) from member_point where mp_date between '" + dateArr[i] + " 00:00:00' and '";
		pointMinusSql += dateArr[i] + " 23:59:59' and mp_isuse = 'Y'";	// 고객 사용 포인트
		rs2 = stmt2.executeQuery(pointPlusSql);
		rs3 = stmt3.executeQuery(pointMinusSql);
		if (rs2.next()) pointPlusArr[i] = rs2.getInt(1);
		else pointPlusArr[i] = 0;
		if (rs3.next()) pointMinusArr[i] = rs3.getInt(1);
		else pointMinusArr[i] = 0;
		
		pointTotalArr[i] = pointPlusArr[i] - pointMinusArr[i];
%>
		<tr>
			<td><%=dateArr[i] %></td>
			<td><%=memberArr[i] %>건</td>
			<td><%=pointTotalArr[i] %> 포인트</td>
		</tr>
<%
			totalMember += memberArr[i];
			totalPoint += pointTotalArr[i];
	}
	rs.close();
	rs2.close();
	rs3.close();
%>

		<tr>
			<td>합계</td>
			<td><%=totalMember %>건</td>
			<td><%=totalPoint %> 포인트</td>
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
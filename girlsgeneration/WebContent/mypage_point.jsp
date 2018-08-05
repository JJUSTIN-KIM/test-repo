<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ include file="inc_header.jsp" %>
<%
String pointSql="select * from member_point where m_id = '" + userId + "'";

int count = 0, point = 0, total_point = 0;
String isuse = "", point_Date = "", desc = "";


%>


<table id="mypage_table" width="1150px" align="center" >
	<tr background="#FFA5C3" bgcolor="#FFA5C3" >
		<th>번호</th>
		<th>구분</th>
		<th>점수</th>
		<th>내역 </th>
		<th>발생일</th>
	</tr>
<% 
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	
	rs = stmt.executeQuery(pointSql);
	if (rs.next()) {
		do{
			count++;
			isuse = rs.getString("mp_isuse");	//구분(N : 적립, Y:사용)
			point = rs.getInt("mp_point");		//적립 또는 사용 적립금
			desc = rs.getString("mp_desc");		//적립 또는 사용 내역
			point_Date = rs.getString("mp_date").substring(0, 11);
			
			

			if(isuse.equals("N")){
				isuse = "적립";
				total_point += point;
			} else if(isuse.equals("Y")){
				isuse = "사용";
				total_point -= point;
			}
			
			
			%>
			<tr>
			<td width="15%"><%=count %></td>
			<td width="15%"><%=isuse %></td>
			<td width="10%"><%=point %></td>
			<td width="30%"><%=desc %></td>
			<td width="*%"><%=point_Date %></td>
			
			
			</tr>
			
			<%
			
		}
		while(rs.next());
		
	}
	
	
	
	
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로고침]을 누르거나 첫 화면으로 이동하세요.");
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
<div id="order_conf_info" float="right">
*총 적립금액은 <%=total_point %> 입니다.<br />

<input type="button" class="btn_style" value="사용하러 가기" onclick="location.href='product_newbest.jsp?nb=b'"/>
</div>

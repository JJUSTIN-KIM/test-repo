<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
int idx = 0;
String sql = "", zip = "", addr1 = "", addr2 = "", isbasic = "", add = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/admin_member.css" />
<style>
#delivery_table th{
    font-weight:bold;
    text-align:center;
    background:#99cccc;
}
#delivery_table td {
    font-size:0.9em;
    text-align:center;
    height:50px;
}
.#delivery_table th, #delivery_table td {
    border-top:1px solid gray;
    padding:10px;
}
h3 {
    font-size:1.5em;
    font-weight:bold;
    padding-top:30px;
    padding-bottom:15px;
}

</style>
</head>
<body>
<%@ include file="inc_admin_html_header.jsp" %>
<div id="div_form">
	<hr width="30%" size="1" color="#d1d1d1" />
	<p align="center">배송지</p>
	<hr width="30%" size="1" color="#d1d1d1" />
	
	<table id="delivery_table" width="1150">
	<tr><td colspan="3"><%=id %>님의 주소지</td></tr>
	<tr>
		<th>우편번호</th>
		<th>주소지</th>
		<th>기본주소 여부</th>
		<th>주소지 삭제</th>
	</tr>
	<%
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		stmt = conn.createStatement();
	
		sql = "select ma_idx, m_id, ma_zip, ma_addr1, ma_addr2, ma_isbasic from member_address where m_id = '" + id + "';";
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			do{
				idx = rs.getInt("ma_idx");
				zip = rs.getString("ma_zip");
				addr1 = rs.getString("ma_addr1");
				addr2 = rs.getString("ma_addr2");
				isbasic =rs.getString("ma_isbasic");
				add = addr1 + " " + addr2; 
				
				if(isbasic.equals("Y")){
					isbasic = "기본주소";
				}else if(isbasic.equals("N")){
					isbasic = "나머지주소";
				}
				
				%>
				<tr>
					<td width="20%"><%=zip %></td>
					<td widht="50%"><%=add %></td>
					<td width="30%"><%=isbasic %></td>
					<td width="*">
						<input type="button" class="btn_style" value="삭제" onclick="location.href='delivery_proc.jsp?idx=<%=idx %>&id=<%=id %>'" />
					</td>
				</tr>
				
				<%
					}
			while(rs.next());
		}else{
			out.println("<tr><td colspan='5'>주소가 존재하지 않습니다.</td></tr>");
		}
	}catch(Exception e) {
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

</div>

</body>
</html>
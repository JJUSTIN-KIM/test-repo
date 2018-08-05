<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>

<%
int count = 0;
String zip = ""; 					// 우편번호
String addr1 = "",  addr2 = "";	// 기본주소, 상세주소
String isbasic = "";			// 기본주소 여부(N:나머지주소 ,Y :기본주소 )
int idx = 0;
%>


<table id="mypage_table" width="1150px" align="center" >
	<tr background="#FFA5C3" bgcolor="#FFA5C3" >
		<th>번호</th>
		<th>우편번호</th>
		<th>기본주소</th>
		<th>상세주소</th>
		<th>기본주소로 설정</th>
		<th>주소수정</th>
		<th>주소삭제</th>
	</tr>
<%
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		stmt = conn.createStatement();
		
		String sql = "select * from member_address where m_id = '" + userId + "'";
		
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			do{
				idx = rs.getInt("ma_idx");
				zip = rs.getString("ma_zip");
				addr1 = rs.getString("ma_addr1");
				addr2 = rs.getString("ma_addr2");
				isbasic =rs.getString("ma_isbasic");
				
				count++;
				%>
				<tr>
				<td width="5%"><%=count %></td>
				<td width=""><%=zip %></td>
				<td><%=addr1 %></td>
				<td><%=addr2 %></td>
				<td>
					<%if(!isbasic.equals("Y")){ %>
					<input type="button" class="btn_style" value="기본주소" onclick="location.href='delivery_proc.jsp?wtype=ch&ma_idx=<%=idx %>'" />
					<%}else{ %>
						기본주소입니다.^^
					<%} %>
				</td>
				<td>
					<input type="button" class="btn_style" value="수정" onclick="location.href='delivery_form.jsp?wtype=up&ma_idx=<%=idx %>'" />
				</td>
				<td>
					<input type="button" class="btn_style" value="삭제" onclick="location.href='delivery_proc.jsp?wtype=del&ma_idx=<%=idx %>'" />
				</td>
				</tr>
				
				<%
					}
			while(rs.next());
		}else{
			out.println("<tr><td colspan='7'>주소가 존재하지 않습니다.</td></tr>");
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
<div id="order_conf_info" float="right">
	<input type="button" class="btn_style" value="주소지 추가" onclick="location.href='delivery_form.jsp?wtype=in'"/>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int count = 0;

Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);
int month = today.get(Calendar.MONTH) + 1;
int date = today.get(Calendar.DATE);


String member_level = request.getParameter("member_level");//등급
String gender_search = request.getParameter("gender_search");
String ktype = request.getParameter("ktype");
String keyword = request.getParameter("keyword");
String limit = request.getParameter("limit"); //목록개수
String where = " where m.m_isuse = 'Y' and not(m.m_id = 'admin') " ; // 탈퇴하지 않은 회원만 보여주기, 관리자 제외

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


String name = "", level ="", gender = "";
String joindate = "", id = "";
int point = 0, idx = 0;
String addr = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/admin_member.css" />

<style>

</style>
  
</head>
<body>
<%@ include file="inc_admin_html_header.jsp" %>

<div id="div_form">
	<hr width="35%" size="1" color="#d1d1d1" />
	<p align="center">Member Management</p>
	<hr width="35%" size="1" color="#d1d1d1" />


<div id="member_search">
<form name="frm_member_search" method="get">

<table id="search_table" border="1px solid red">
	<tr>
		<th width = "10%">회원그룹</th>
		<td width = "40%">
			<select name="member_level" id="member_level">
				<option value="">전체보기</option>
				<option value="N">일반회원</option>
				<option value="S">실버회원</option>
				<option value="G">골드회원</option>
				<option value="V">vip 회원</option>
				<option value="M">Master 회원</option>
		</select>
		</td>
		<th width = "10%">성별검색</th>
		<td widthd = "40%">
			<input type="radio" name="gender_search" value="" checked="checked"/>전체
			<input type="radio" name="gender_search" value="F" />여자
			<input type="radio" name="gender_search" value="M" />남자
		</td>
		</tr>

	<tr>
		<th>가입일자</th>
		<td>
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
		
		<th>조건검색</th>
		<td>
			<select name="ktype">
				<option value=""></option>
				<option value="m_name">고객명</option>
				<option value="m_id">아이디</option>
				<option value="m_email">이메일</option>
			</select>
			<input type="text" name="keyword" value=""/>
		</td>
	</tr>
	
	<tr>
		<td colspan="4">
			<input type="submit" value="검색" />
			<input type="reset" value="초기화면"/>
		</td>
	</tr>
</table>
</form>
</div>
<div class="member_result">
	<table id="member_table" text-align="center" width="1150"> 
	
	<tr><td colspan="8" >검색 결과</td></tr>
	<tr align="center">
		<th>번호</th>
		<th>등급</th>
		<th>이름</th>
		<th>성별</th>
		<th>주소지</th>
		<th>포인트</th>
		<th>가입일자</th>
		<th>탈퇴</th>
	</tr>
	<%
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		stmt = conn.createStatement();
		
		
		//멤버쉽 조건
		if(member_level.equals("") || member_level == null){
			where += "";
		}else if(member_level.equals("N")){
			where += " and m.m_level = 'N'";
		}else if(member_level.equals("S")){
			where += " and m.m_level = 'S'";
		}else if(member_level.equals("G")){
			where += " and m.m_level = 'G'";
		}else if(member_level.equals("V")){
			where += " and m.m_level = 'V'";
		}else if(member_level.equals("M")){
			where += " and m.m_level = 'M'";
		}
		
		
		
		// 성별 조건
		if(gender_search.equals("")){
			where += "";
		}else if(gender_search.equals("F")){
			where += " and m.m_gender = 'F'";
		}else if(gender_search.equals("M")){
			where += " and m.m_gender = 'M'";
		}
		
		//keyword 조건
		if(ktype.equals("")){
			where += "";
		}else if(ktype.equals("m_name")){
			where += " and m.m_name = '" + keyword + "'";
		}else if(ktype.equals("m_id")){
			where += " and m.m_id = '" + keyword + "'";
		}else if(ktype.equals("m_email")){
			where += " and m.m_email = '" + keyword + "'";
		}
		
		if(!startDate.equals("") && !endDate.equals("")){
			where += " and m.m_joindate between '" + startDate + " 00:00:00' and '" + endDate + " 23:59:59'";
		}
		
		
		
			String sql = "select * from member m left outer join member_address a on m.m_id = a.m_id "+ where + " group by m.m_id";
			out.println(sql);
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				do{
					idx = rs.getInt("m.m_idx");
					id = rs.getString("m.m_id");
					level = rs.getString("m.m_level");
					name = rs.getString("m.m_name");
					addr = rs.getString("a.ma_addr1");
					addr += " ";
					addr += rs.getString("a.ma_addr2");
					gender = rs.getString("m.m_gender");
					point = rs.getInt("m.m_point");
					joindate = rs.getString("m.m_joindate").substring(0, 11);
					
					count++;
					
					if(addr.equals("null null")){
						addr = "주소지가 없습니다.";
					}else if(addr.equals("null")){
						addr = "주소지가 없습니다.";
					}
					
					if(gender.equals("F")){
						gender = "여자";
					}else if(gender.equals("M")){
						gender = "남자";
					}
					
					if(level.equals("N")){
						level = "일반회원";
					}else if(level.equals("S")){
						level = "실버회원";
					}else if(level.equals("G")){
						level = "골드회원";
					}else if(level.equals("V")){
						level = "vip회원";
					}else if(level.equals("M")){
						level = "Master회원";
					}			
					
	
					%>
					<tr>
					<td><%=count %></td>
					<td><%=level %></td>
					<td><%=name %></td>
					<td><%=gender %></td>
					<td><a href="admin_delivery.jsp?id=<%=id%>"><%=addr %></a></td>
					<td><%=point %></td>
					<td><%=joindate %></td>
					<td>
						<input type="button" value="탈퇴" onclick="location.href='leave_member.jsp?idx=<%=idx %>';" />
					</td>
					</tr>
		<%
						}
				while(rs.next());
			}else{
				out.println("<tr><td colspan='8'>주소가 존재하지 않습니다.</td></tr>");
			}
		}catch(Exception e) {
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
</body>
</html>
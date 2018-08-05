<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Calendar today = Calendar.getInstance();

int year = today.get(Calendar.YEAR);
int month = today.get(Calendar.MONTH) + 1;
int date = today.get(Calendar.DATE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="inc_admin_html_header.jsp" %>
<link rel="stylesheet" type="text/css" href="css/admin_board.css" />
<div class="contents_area">
	<div class="adnt_frm">
		<span>BOARD MANAGEMENT</span>
	</div>
		<div id="catebox">
			<h2>1:1질문목록</h2>
			<table class="ad_tbl_free">
				<tr><th>질문유형</th>
				<td colspan="2">
					<select>
						<option value="">-- 질문유형 --</option>
						<option value="a">주문/결제</option>
						<option value="b">교환/반품</option>
						<option value="c">환불</option>
						<option value="d">배송관련</option>
						<option value="e">적립금</option>
						<option value="f">사이트이용/기타</option>
					</select>
				</td></tr>
				<tr><th>답변여부</th>
				<td colspan="2">
					<input type="checkbox" name="option_status" value="A" id="A" /><label for="A">전체</label>&nbsp;
					<input type="checkbox" name="option_status" value="B" id="B" /><label for="B">답변예정</label>&nbsp;
					<input type="checkbox" name="option_status" value="C" id="C" /><label for="C">답변완료</label>
				</td></tr>
				<tr><th>작성자</th>
					<td colspan="2"><input type="text" name="keyword" placeholder="작성자 입력" /></td>
				</tr>
				<tr>
					<th>게시일자</th>
				<td colspan="2">
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
			<tr><th>정령방식</th>
			<td>
				<select>
					<option>최신순</option>
					<option>답변예정먼저</option>
				</select>
			</td>
			<td class="ad_btn_search">
					<input type="submit" value="검 색" />&nbsp;&nbsp;
					<input type="button" value="초기화면" onclick="location.replace('admin_board.jsp');" />
				</td>
			</tr>
		</table>
	</div>
	<div id="ad_qnabox">
		<h3>검색 결과</h3>
		<table class="ad_tbl_result">
			<tr>
				<th width="10%">번호</th>
				<th width="*">제목</th>
				<th width="15%">작성자</th>
				<th width="15%">작성일</th>
				<th width="10%">전체선택</th>
			<tr>
		</table>
	</div>
</div>
</body>
</html>
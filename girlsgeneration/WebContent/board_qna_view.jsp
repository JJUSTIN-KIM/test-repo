<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String tmpIdx = request.getParameter("idx");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null)	tmpPage = "";
if (schkind == null)	schkind = "";
if (keyword == null)	keyword = "";
String args = "?cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;


int idx = 0;
String isAns = "";	// 답변여부
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function isDel() {
	if (confirm("정말 삭제하시겠습니까?")) {
		window.open("board_delete.jsp?idx=" + <%=idx%>, "a", "width=200,height=100,top=50,left=100");
	}
}
</script>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<%
if (tmpIdx == null) {	// 글번호가 없으면
	out.println("<script>");
	out.println("location.replace('board_qna.jsp');");
	out.println("</script>");
} else {
	idx = Integer.valueOf(tmpIdx);
	// 값이 숫자이면 반드시 request로 받은 다음에 숫자로 형변환을 시킴
}

String sql = "select bq_title, bq_contents, bq_writer, bq_date, bq_kind, bq_status ";
sql += " from boardqna where bq_idx = " + idx;

String title = "", contents = "", writer = "", date = "", kind = "";
int isView = 0;
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		isView = 1;
		// 글번호에 해당하는 데이터가 있다는 표시로서의 변수값
		title = rs.getString("bq_title");	// 제목
		contents = rs.getString("bq_contents").replace("\r\n", "<br />");
		// 글 내용으로 사용자가 입력한 엔터키를 <br />태그로 변환
		writer = rs.getString("bq_writer");	// 작성자
		date = rs.getString("bq_date");		// 작성일
		kind = rs.getString("bq_kind");		// 질문 분류
		
		if (kind.equals("a")) kind = "주문/결제";
		else if (kind.equals("b")) kind = "교환/반품";
		else if (kind.equals("c")) kind = "환불";
		else if (kind.equals("d")) kind = "배송관련";
		else if (kind.equals("e")) kind = "적립금";
		else if (kind.equals("f")) kind = "사이트이용/기타";
		isAns = rs.getString("bq_status");
		if (isAns.equals("A")) isAns = "답변예정";
		else if (isAns.equals("B")) isAns = "답변완료";
%>
<div class="contents_area">
	<div id="searchbox_qnaview" align="center">
		<div id="notice_title">
			<ul>
				<li>
					QNA&nbsp;&nbsp;&nbsp;&nbsp;
				</li>
			</ul>
		</div>
		<div id="tbl_bnv_free">
		<table width="500" border="1" cellpadding="5" cellspacing="0" id="free_bfview">
			<tr>
			<th>제목</th>
			<td colspan="3"><%=title %></td>
			</tr>
			<tr>
			<th>질문유형</th>
			<td><%=kind %></td>
			<th>답변여부</th>
			<td><%=isAns %></td>
			</tr>
			<tr>
			<th colspan="4" align="left">내용</th>
			</tr>
			<tr>
			<td colspan="4" width="300">
			<div id="area">
			<%=contents.replace("\r\n", "<br />") %>			
			</div>
			</td>
			</tr>
			<tr>
				<th height="10%">작성일</th>
				<td><%=date.substring(0, date.length() - 2) %></td>
				<th>작성자</th>
				<td align="center"><%=writer %></td>
			</tr>
		</table>
		</div>
		<div id="smt">
			<input type="button" value="글 목 록" onclick="location.href='board_qna.jsp<%=args %>&idx=<%=idx %>';" />&nbsp;&nbsp;
			<input type="button" value="글 수 정" onclick="location.href='board_qna_form.jsp<%=args %>&idx=<%=idx %>&wtype=up';" />&nbsp;&nbsp;&nbsp;
			<% if (isLogin && userId.equals("admin")) { %>
			<input type="button" value="답글 달기" onclick="location.href='board_qna_form.jsp<%=args %>&idx=<%=idx %>&wtype=re';" />
			<% } %>
		</div>
	</div>
</div>
<%
	} else {
		out.println("등록된 댓글이 없습니다.");
	}
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
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
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
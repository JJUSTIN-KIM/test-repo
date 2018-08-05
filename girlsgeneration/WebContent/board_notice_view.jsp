<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String tmpIdx = request.getParameter("idx");
String tmpPage = request.getParameter("cpage");

if (tmpPage == null)	tmpPage = "";

String args = "?cpage=" + tmpPage;

int idx = 0;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
</style>
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
	out.println("location.replace('board_notice.jsp');");
	out.println("</script>");
} else {
	idx = Integer.valueOf(tmpIdx);
	// 값이 숫자이면 반드시 request로 받은 다음에 숫자로 형변환을 시킴
}

String sql = "select bn_title, bn_contents, bn_date ";
sql += " from boardnotice where bn_idx = " + idx;

String title = "", contents = "", date = "";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		// 글번호에 해당하는 데이터가 있다는 표시로서의 변수값
		title = rs.getString("bn_title");	// 제목
		contents = rs.getString("bn_contents").replace("\r\n", "<br />");
		// 글 내용으로 사용자가 입력한 엔터키를 <br />태그로 변환
		date = rs.getString("bn_date");		// 작성일
%>
<div class="contents_area">
	<div id="searchbox_ntview" align="center">
		<div id="notice_title">
			<ul>
				<li>
					NOTICE&nbsp;&nbsp;&nbsp;&nbsp;
				</li>
			</ul>
		</div>
		<div id="tbl_bnv_free">
		<table width="500" border="1" cellpadding="5" cellspacing="0" id="free_bnview">
			<tr><th height="10%">제목</th><td><%=title %></td></tr>
			<tr><th colspan="2" id="content" height="10%">내용</th></tr>
			<tr>
			<td colspan="2" width="300">
			<div id="area">
			<%=contents.replace("\r\n", "<br />") %>
			
			</div>
			</td></tr>
			<tr>
				<th height="10%">작성일</th><td><%=date.substring(0, date.length() - 2) %></td>
			</tr>
		</table>
		</div>
		<div id="smt">
			<input type="button" value="글 목 록" onclick="location.href='board_notice.jsp<%=args %>';" />&nbsp;&nbsp;&nbsp;
			<% if (isLogin && userId.equals("admin")) { %>
			<input type="button" value="글 수 정" onclick="location.href='board_notice_form.jsp<%=args %>&idx=<%=idx %>&wtype=up';" />&nbsp;&nbsp;&nbsp;
			<input type="button" value="글 삭 제" onclick="isDel();" />
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
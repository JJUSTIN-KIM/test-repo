<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tmpIdx = request.getParameter("idx");
String wtype = request.getParameter("wtype");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");
String title = "", contents = "", kind = "", sql = "";
int idx = 0;
String args = "&cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<%
if (wtype == null)
{
	out.println("<script>");
	out.println("location.replace('board_qna.jsp')");
	out.println("</script>");
	
} else if (wtype.equals("re")) {
	if (tmpIdx == null || tmpIdx.equals("")) {
		out.println("<script>");
		out.println("location.replace('board_qna.jsp')");
		out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
			args += "&idx=" + idx;
		}
}
if(wtype == null)
	{
		out.println("<script>");
		out.println("location.replace('board_notice.jsp')");
		out.println("</script>");
		
	} else if (wtype.equals("up")) {
		// 게시글 수정 요청이면
		if (tmpIdx == null || tmpIdx.equals("")) {
		// 수정요청에서 게시글 번호가 비어 있으면
			out.println("<script>");
			out.println("location.replace('board_notice.jsp')");
			out.println("</script>");
			} else {
				idx = Integer.valueOf(tmpIdx);
				args += "&idx=" + idx;
			}
		sql = "select bq_title, bq_contents, bq_kind";
		sql += " from boardqna where bq_idx = " + idx;
		


		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "1234");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				title = rs.getString("bq_title");	// 제목
				contents = rs.getString("bq_contents");	// 내용
				kind = rs.getString("bq_kind");	// 질문유형
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
}
%>
<div class="contents_area">
	<div id="searchBox_qna_form">
		<div id="notice_title" style="text-align:center;">
			<ul>
				<li>
					QNA&nbsp;&nbsp;&nbsp;&nbsp;
				</li>
			</ul>
		</div>
	<form name="frm_free" action="board_qna_proc.jsp?wtype=<%=wtype + args %> %>" method="post">
	<div id="tbl_qnaform_free" align="center">
	<% if (wtype.equals("in") || wtype.equals("up")) { %>
	<table width="700" border="0" cellpadding="5" cellspacing="0" id="free_qna_form">
	<tr>
		<th>문의유형</th>
	<td>
		<select name="kind">
			<option value="">-- 질문유형 --</option>
			<option value="a">주문/결제</option>
			<option value="b">교환/반품</option>
			<option value="c">환불</option>
			<option value="d">배송관련</option>
			<option value="e">적립금</option>
			<option value="f">사이트이용/기타</option>
		</select>
	</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" id="title_qna" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="contents" id="contents_qna"></textarea>
	</tr>
	</table>
	<% } else if (wtype.equals("re")) { %>
	<table width="700" border="0" cellpadding="5" cellspacing="0" id="free_qna_form">
	<tr>
		<th>문의유형</th>
	<td>
		<select name="kind">
			<option value="">-- 질문유형 --</option>
			<option value="a" <%=(kind.equals("a")) ? "selected='selected'" : "" %>>주문/결제</option>
			<option value="b" <%=(kind.equals("b")) ? "selected='selected'" : "" %>>교환/반품</option>
			<option value="c" <%=(kind.equals("c")) ? "selected='selected'" : "" %>>환불</option>
			<option value="d" <%=(kind.equals("d")) ? "selected='selected'" : "" %>>배송관련</option>
			<option value="e" <%=(kind.equals("e")) ? "selected='selected'" : "" %>>적립금</option>
			<option value="f" <%=(kind.equals("f")) ? "selected='selected'" : "" %>>사이트이용/기타</option>
		</select>
	</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" id="title_qna" value="Re: <%=title %>" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="contents" id="contents_qna">
		
		
		
		-----------------원글 내용입니다.-------------
		<%=contents.replace("\r\n", "<br>") %></textarea></td>
	</tr>
		<tr>
		<th>이미지첨부1</th>
		<td><input type="file" name="img1" id="img1" /></td>
	</tr>
	<tr>
		<th>이미지첨부2</th>
		<td><input type="file" name="img2" id="img2" /></td>
	</tr>
	</table>
	<% } %>
	</div>
		<div id="buttonBox_qna">
	
		<% if (wtype.equals("in")) { %>
		<input type="submit" value="글 등 록" />&nbsp;&nbsp;&nbsp;
		<% } else if (wtype.equals("re")) { %>
		<input type="submit" value="답 글 등 록" />&nbsp;&nbsp;&nbsp;
		<% } else if (wtype.equals("up")) { %>
		<input type="submit" value="글 수 정" />&nbsp;&nbsp;&nbsp;
		<% } %>
		</div>
	</form>
	</div>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>

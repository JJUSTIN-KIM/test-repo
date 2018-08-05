<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tmpIdx = request.getParameter("idx");
String wtype = request.getParameter("wtype");
String tmpPage = request.getParameter("cpage");

String title = "", contents = "", sql = "";
int idx = 0;
String args = "&cpage=" + tmpPage;

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
		sql = "select bn_title, bn_contents";
		sql += " from boardnotice where bn_idx = " + idx;

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "1234");
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				title = rs.getString("bn_title");	// 제목
				contents = rs.getString("bn_contents");
				
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
	<form name="frm_free" action="board_notice_proc.jsp?wtype=<%=wtype + args %>" method="post">
		<div id="searchbox2" align="center">
			<div id="notice_title">
				<ul>
					<li>
						NOTICE&nbsp;&nbsp;&nbsp;&nbsp;
					</li>
				</ul>
			</div>
			<div id="tbl_bnf_free">
			<table width="700" border="0" cellpadding="5" cellspacing="0" id="free">
			<tr>
				<th style="text-align:center;">제목</th>
				<td colspan="3"><input type="text" name="title" id="title" value="<%=title %>" /></td>
			</tr>
			<tr>
				<th style="text-align:center;">내용</th>
				<td colspan="3"><textarea name="contents" id="contents" ><%=contents %></textarea></td>
			</tr>
			</table>
			</div>
			
			<div id="buttonBox_ntform">
			<% if (wtype.equals("in")) { %>
				<input type="submit" class="btn_write" value="글 등 록" />&nbsp;
			<% } else if (wtype.equals("up")) { %>
				<input type="submit" class="btn_write" value="글 수 정" />&nbsp;
			<% } %>
				&nbsp;<input class="btn_write" type="button" value="취소" onclick="history.back();"/>
			</div>
		</div>
	</form>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
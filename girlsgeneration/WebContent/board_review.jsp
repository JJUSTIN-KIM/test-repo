<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div class="contents_area">
	<div id = "searchbox_review" align="center" >
		<div id="notice_title">
			<ul>
				<li>
					<a href="board_notice.jsp">NOTICE</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_qna.jsp">QNA</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_faq.jsp">FAQ</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_review.jsp">REVIEW</a>
				</li>
			</ul>
		</div>
		<div>
			<table id="tbl_rv_free">
			<tr>
				<th width="*" style="text-align:center;">제목</th>
				<th width="15%" style="text-align:center;">작성자</th>
				<th width="20%" style="text-align:center;">작성일</th>
			</tr>
			</table>
		</div>
	</div>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
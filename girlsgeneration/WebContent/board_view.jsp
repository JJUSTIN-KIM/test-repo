<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#free td, #free th { border-bottom:1px solid #c1c1c1; }
#buttonBox { width:700px; margin-top:20px; text-align:center; }

/* 댓글 관련 스타일 */
.ipt { width:100px; height:20px; border:1px #c1c1c1 solid; }
#contents { width:500px; height:100px; border:1px #c1c1c1 solid; }
#smt { width:100px; height:100px; }
#replyForm { border:1px black solid; }
.replyList { border:1px black solid; margin-bottom:20px; }
.replyList td { padding:5px 15px; }
.con { border-top:1px c1c1c1 solid; }
.hand { cursor:pointer; }
</style>
</head>
<body>
<table width="700" border="0" cellpadding="5" cellspacing="0" id="free">
<tr><th>제목</th><td colspan="5"></tr>

</table>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
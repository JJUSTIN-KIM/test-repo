<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String idx = request.getParameter("idx");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="frm_pwd" action="board_qna_proc.jsp?idx=<%=idx %>&wtype=del" method="post">
<input type="password" name="pwd" /><br /><br />
<input type="submit" value="암호입력" />
<input type="button" value="닫 기" onclick="self.close();" />
</form>
</body>
</html>




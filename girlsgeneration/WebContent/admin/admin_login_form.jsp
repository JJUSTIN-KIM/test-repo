<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>관리자 로그인 폼</h2>
<form name="frm_login" action="admin_login_proc.jsp" method="post">
<table width="300">
<tr>
<th width="28%">ID</th>
<td width="*%"><input type="text" name="id" class="txt" /></td>
</tr>
<tr>
<th>비밀번호</th>
<td><input type="password" name="pwd" class="txt" /></td>
</tr>
<tr><td colspan="2" align="center"><br />
	<input type="submit" value="로그인" />&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>


	function chkReason(frm){
		var reason = frm.reason.value.trim();
	
		if(reason == ""){
			alert("사유를 쓰지 않았습니다.");
			frm.reason.value="";
			frm.reason.focus();
			return false;
		}
		return true;
	}
</script>
<style>
p {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
}
#leave_table{
	margin:auto;
	font-size:30px;
}

</style>
</head>
<body>

<div id="div_form">
	<hr width="20%" size="1" color="#d1d1d1" />
	<p align="center">회원 탈퇴</p>
	<hr width="20%" size="1" color="#d1d1d1" />
	
	<form name="delete_member_form" action="join_proc.jsp" onsubmit="return chkReason(this)">
	<table align="center" id="leave_table">
	<input type="hidden" name="wtype" value="del" />
		<tr><td colspan="2"><img src="images/leave.png"></td></tr>
		<tr><td align="center" bgcolor="#FFA5C3">사유</td>
		<td><textarea name="reason" rows="10" cols="80"></textarea></td></tr>
		<tr><td colspan="2" align="center">
			<input type="submit" class="btn_style" value="회원 탈퇴">
			<input type="button" class="btn_style" value="취소하기" onclick="location.replace('main.jsp');">
		</td></tr>
	</table>
	</form>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
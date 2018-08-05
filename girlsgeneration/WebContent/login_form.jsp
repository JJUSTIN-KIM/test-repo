<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#btn_login { 
background-color:black; 
color:white; 	

}
#login{
	width:1150px;
	height:250px;
}

#login .login_form {
	float:left;
	width:200px;
	font-size:20px;
	color:#FFA5C3;
	margin-left:80px;
	
}


#login .memberInfo {
	position:relative;
	float:right;
	font-size:23px;
	padding-top:30px;
	padding-right:100px;
	margin-right:80px;
	color:#c1c1c1;
}
p {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
}

</style>
<script>
	function chkJoin(frm){
		var uidValue = frm.id.value.trim();
		var pwdValue = frm.pwd.value.trim();
		
		if(uidValue == ""){
			alert("ID를 입력하시오.");
			frm.id.value="";
			frm.id.focus();
			return false;
		}
		
		if(pwdValue == ""){
			alert("비밀번호를 입력하시오.");
			frm.id.value="";
			frm.id.focus();
			return false;
		}
		
		return true;
		
	}

</script>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="div_form">
	<hr width="20%" size="1" color="#d1d1d1" />
	<p align="center">로그인 화면</p>
	<hr width="20%" size="1" color="#d1d1d1" />
	<div id="login">
		<div class="login_form">
		<form name="frm_login" action="login_proc.jsp" method="post" onsubmit="return chkJoin(this)">
			<table cellpadding="1" cellspacing="1" align="center">
				<tr><td><label for="id">ID</label></td></tr>
				<tr><td><input type="text" name="id" id="id" placeholder="ID입력"></td></tr>
				
				<tr><td><label for="pw">Password</label></td></tr>
				<tr><td><input type="password" name="pwd" id="pwd" placeholder="비밀번호 입력"></td></tr><br />
				<tr><td colspan="2">
				<input type="submit" style="font-size:25;  color:#FFA5C3; border-color:#FFA5C3; background-color:white" value="로 그 인" />
				</td></tr>
			</table>
		</form>
		</div>
		<div class="memberInfo" style="border:1">
			<h2>회원가입을 하시면 더 많은 <strong style="color:black">혜택</strong>을 받으실 수 있습니다.</h2>
			<input type="button" style="font-size:25;  color:#FFA5C3; border-color:#FFA5C3; background-color:white" onclick="location.href='join_agree.jsp'" value="회원가입">
			<h2><strong style="color:black;">아이디</strong> 또는 <strong style="color:black;">비밀번호</strong>를 잃어버렸나요?</h2>
			<input type="button" style="font-size:25;  color:#FFA5C3; border-color:#FFA5C3; background-color:white" onclick="location.href='find_form.jsp'" value="아이디/비밀번호 찾기">
		</div>
	</div>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
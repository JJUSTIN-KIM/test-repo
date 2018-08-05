<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>

#pp {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
}


b{
	margin-left:30px;
}

</style>
<script>
function chkID(frm){
	var name = frm.name.value.trim();
	var e1 = frm.e1.value.trim();
	var e2 = frm.e2.value;
	
	if(name == ""){
		alert("이름을 입력하지 않았습니다.");
		frm.name.value="";
		frm.name.focus();
		return false;
	}
	
	if(e1 == ""){
		alert("이메일을 입력하지 않았습니다.");
		frm.e1.value= "";
		frm.e1.focus();
		return false;
	}
	
	if(e2 == ""){
		alert("이메일을 선택하지 않았습니다.");
		frm.e1.value= "";
		frm.e1.focus();
		return false;
	}
	
	return true;
}

function chkpwd(frm){
	var id = frm.id.value.trim();
	var e1 = frm.e1.value.trim();
	var e2 = frm.e2.value;
	
	if(id == ""){
		frm.id.value= "";
		frm.id.fouces();
	}
	
	if(e1 == ""){
		alert("이메일을 입력하지 않았습니다.");
		frm.e1.value= "";
		frm.e1.focus();
		return false;
	}
	
	if(e2 == ""){
		alert("이메일을 선택하지 않았습니다.");
		frm.e1.value= "";
		frm.e1.focus();
		return false;
	}
	
	return true;
	
}
</script>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="div_form">
	<div id="id_find">
	<hr width="20%" size="1" color="#d1d1d1" />
	<p id="pp" align="center">아이디찾기</p>
	<hr width="20%" size="1" color="#d1d1d1" />
		<form action="find_proc.jsp" method="post" onsubmit="return chkID(this)">
		<table id="search_table" align="center">
			<input type="hidden" name="search" value="id_find">
			<b font-size="30px" color="#c1c1c1" >회원가입 시, 입력하신 이름과 이메일로 아이디를 확인하실 수 있습니다.</b>
			<tr><td><input type="radio" checked="checked">이메일로 찾기</td></tr>
			<tr>
			<th><label for="name">이름</label></th>
			<td><input type="text" name="name" id="name" /></td></tr>
	
			<tr>
			<th><label for="e1">이메일</label></th>
			<td><input type="text"  name="e1" id="e1" /> @
			<select name="e2" id="e2">
				<option value="">메일을 선택하세요.</option>
				<option value="naver.com">네 이 버</option>
				<option value="nate.com">네 이 트</option>
				<option value="gmail.com">지 메 일</option>
			</select>
			</td></tr>
			<tr><td colspan="2" align="center">
				<input type="submit" class="btn_style" value="ID찾기"/>
				<input type="button"  class="btn_style" value="로그인 " onclick="location.href='login_form.jsp'"/>
			</td></tr>
		</table>
		</form>
	</div>












	<div id="pwd_find">
		<form action="find_proc.jsp" method="post"  onsubmit="return chkpwd(this)">
		
		<hr width="20%" size="1" color="#d1d1d1" />
		<p id="pp" align="center">비밀번호찾기</p>
		<hr width="20%" size="1" color="#d1d1d1" />
		
		<table id="search_table" align="center">
			<input type="hidden" name="search" value="pwd_find">
			<b font-size="30px" color="#c1c1c1" >가입하신 아이디와 이메일 혹은 휴대전화를 통해 임시비밀번호를 알려드립니다.</b><br/>
			<b> 확인 후 로그인하셔서 반드시 비밀번호를 변경하시기 바랍니다.</b>
			<tr><td><input type="radio" checked="checked">이메일로 찾기</td></tr>
			<tr>
			<th><label for="id">아이디</label></th>
			<td><input type="text" name="id" id="id" /></td></tr>
	
			<tr>
			<th><label for="e1">이메일</label></th>
			<td><input type="text" name="e1" id="e1" /> @
			<select name="e2" id="e2">
				<option value="">메일을 선택하세요.</option>
				<option value="naver.com">네 이 버</option>
				<option value="nate.com">네 이 트</option>
				<option value="gmail.com">지 메 일</option>
			</select>
			</td></tr>
			<tr><td colspan="2" align="center">
				<input type="submit" class="btn_style" value="비밀번호찾기"/>
				<input type="button"  class="btn_style" value="로그인 " onclick="location.href='login_form.jsp'">
			</td></tr>
		</table>
		</form>
	</div></div>
<!-- https://www.youtube.com/watch?v=yrZmN26Jb8s -->
<%@ include file="inc_html_footer.jsp" %>

</body>
</html>
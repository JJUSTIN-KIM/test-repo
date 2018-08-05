<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);

if (userId == null) {
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}
String m_pwd = "", p1 = "",  e1 = "", e2 = "", gender = "";
int y = 0, m = 0, d = 0, p2 = 0, p3 = 0;
String sql = "select * from member where m_id = '" + userId + "'";

	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			m_pwd = rs.getString("m_pwd");
			String[] cell = rs.getString("m_phone").split("-");
			p1 = cell[0];
			p2 = (int)Integer.valueOf(cell[1]);
			p3 = (int)Integer.valueOf(cell[2]);
			
			String birth = rs.getString("m_birth");
			
			y = Integer.valueOf((birth.substring(0, 4)));
			m = Integer.valueOf((birth.substring(4, 6)));
			d = Integer.valueOf((birth.substring(6, 8)));
			
			
			gender = rs.getString("m_gender");
			
			String[] mail = rs.getString("m_email").split("@");
			e1 = mail[0];
			e2 = mail[1];

		}else {	// 해당하는 회원이 없을 경우
			out.println("<script>");
			out.println("history.back();");
			out.println("</script>");
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
p {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
}
	#info{
		border-top:1px solid #000;
		border-right:1px solid #000;
		border-bottom:1px solid #000;
		width:1000px;
		margin:0 auto;	
	 }
	 
	#info th td{
		height:100px;
	 }
	 
	 #info td{
	 	padding-left:5px;
			
	 }
	 
	#info th {
		background-color:black; 
		color:#FFA5C3;
		padding:5px;
		text-align:center;
			
	 }
	#frm_info {
		padding-left:20px;
		padding-top:50px;
		margin-left:30px;
		font-size:18px;
		margin-bottom:15px;
		margin-left:3px;
	}


</style>
<script>
function onlyNumber(obj) {
	if (isNaN(obj.value)) {
		alert("전화번호는 숫자로만 입력해야 합니다.");
		obj.value = "";
		obj.focus();
	}
}

function chkInfoForm(frm){
	var name = frm.name.value.trim();
	var pwd = frm.pwd.value.trim();
	var check_pwd = frm.check_pwd.value.trim();
	var p2 = frm.p2.value.trim();
	var p3 = frm.p3.value.trim();
	var e1 = frm.e1.value.trim();
	var e2 = frm.e2.value;
	
	/* 이름 확인 */
	if (name == "") {
		alert("이름을 입력하세요.");
		frm.name.focus();
		return false;
	}
	
	/* 비밀번호 확인 */
	if(pwd == ""){
		alert("비밀번호를 입력하세요.");
		frm.pwd.focus();
		return false;
	} else if (pwd.length < 4) {
		alert("비밀번호는 4자 이상 입력하세요.");
		frm.pwd.value = "";
		frm.pwd.focus();
		return false;
	}else if (pwd != check_pwd) {
		alert("비밀번호가 일치하지 않습니다. ");
		frm.pwd.value = "";
		frm.check_pwd.value = "";
		frm.check_pwd.focus();
		return false;
	}	
	
	/* 휴대 전화 확인 */
	if (p2 == "") {
		alert("휴대전화를 2번째 자리를 입력하지 않았습니다.");
		frm.p2.focus();
		return false;
	} else if (p2.length < 3) {
		alert("휴대전화 2번째 자리가 3자리 이상이어야 합니다.");
		frm.p2.value = "";
		frm.p2.focus();
		return false;
	}
	if (p3 == "") {
		alert("휴대전화를 3번째 자리를 입력하지 않았습니다.");
		frm.p3.focus();	
		return false;
	} else if (p3.length < 4) {
		alert("휴대전화 3번째 자리가 4자리 이상이어야 합니다.");
		return false;
	}
	
	/* 이메일 확인 */
	if(e1 == ""){
		alert("이메일을 입력하지 않았습니다.");
		frm.e1.focus();
		return false;
	}
	if(e2 == ""){
		alert("이메일을 선택하지 않았습니다.");
		return false;
	}
	
	
	return true;
	
}

</script>
</head>
<body>

<div id="div_form">

	<hr width="30%" size="1" color="#d1d1d1" />
	<p align="center">회원 정보 수정</p>
	<hr width="30%" size="1" color="#d1d1d1" />

	<form name="frm_info" id="frm_info" action="join_proc.jsp" method="post" onsubmit="return chkInfoForm(this);">
	<input type="hidden" name="wtype" value="up" />
	<table width="500" cellspacing="0" cellpadding="5" id="info">
	<tr height="50" >
	<th width="30%"><label for="id">아이디</label></th>
	<td width="*"><%=userId %></td></tr>

	<tr height="50" >
	<th><label for="pwd">비밀번호</label></th>
	<td><input type="password" style="height:25px;" name="pwd" id="pwd" value="<%=m_pwd %>" /></td>
	</tr>
	<tr height="50" >
	<th><label for="check_pwd">비밀번호 확인</label></th>
	<td><input type="password" style="height:25px;" name="check_pwd" id="check_pwd" value="<%=m_pwd %>" /></td>
	</tr>


	<tr height="50" >
	<th><label for="name">이름</label></th>
	<td><input type="text" style="height:25px;" name="name" id="name" value="<%=userName %>" /></td>
	</tr>
	<tr height="50" >
	<th><label for="cell1">휴대폰</label></th>
	<td>
	
	
	<select name="p1" id="p1">
		<option value="010" <%=(p1.equals("010")) ? "selected='selected'" : "" %>>010</option>
		<option value="011" <%=(p1.equals("011")) ? "selected='selected'" : "" %>>011</option>
		<option value="016" <%=(p1.equals("016")) ? "selected='selected'" : "" %>>016</option>
		<option value="019" <%=(p1.equals("019")) ? "selected='selected'" : "" %>>019</option>
	</select> -
	<input type="text" style="height:25px;" name="p2" id="p2" maxlength="4" size="4"  value="<%=p2 %>"  onkeyup="onlyNumber(this);" /> -
	<input type="text" style="height:25px;" name="p3" id="p3" maxlength="4" size="4"  value="<%=p3 %>"  onkeyup="onlyNumber(this);" />
	</td></tr>
	
	<tr>
	<th><label for="birth">생년월일 </label></th>
	<td>
	<%
	out.println(y +  "년 " + m + "월 " + d + "일");
	%>
	</td></tr>
	
	
	<tr height="50" >
	<th><label for="e1">이메일</label></th>
	<td>
	<input type="text" style="height:25px;" name="e1" id="e1" value="<%=e1 %>" /> @
	<select name="e2" style="height:25px;" id="e2">
		<option value="">메일을 선택하세요.</option>
		<option value="naver.com" <%=(e2.equals("naver.com")) ? "selected='selected'" : "" %> >네이버</option>
      <option value="nate.com" <%=(e2.equals("nate.com")) ? "sqelected='selected'" : "" %> >네이트</option>
      <option value="gmail.com" <%=(e2.equals("gmail.com")) ? "selected='selected'" : "" %> >지메일</option>
	</select>
	</td></tr>
	<tr>
	<th><label for="g1">성   별</label></th>
	<td>
	<%
	if(gender.equals("F")){
		out.print("여자");
	}
	else if(gender.equals("M")){
		out.print("남자");
	}
	%>
	</td></tr>
	</table>
	<div align="center">
	<br>
	<input type="submit" class="btn_style" value="수정" />&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" class="btn_style" value="다시 입력" />
	</div>
	</form></div>

<%@ include file="inc_html_footer.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);

String isAgree = request.getParameter("isAgree");

if (isAgree == null) {	// 약관에 동의하지 않았으면
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script>
	function chkID() {
		window.open("id_chk.jsp", "a", "width=300,height=100,top=50,left=50");
	}
	
	function onlyNumber(obj) {
		if (isNaN(obj.value)) {
			alert("전화번호는 숫자로만 입력해야 합니다.");
			obj.value = "";
			obj.focus();
		}
	}


	function chkJoinForm(frm) {
		var id = frm.id.value.trim();
		var pwd = frm.pwd.value.trim();
		var check_pwd = frm.check_pwd.value.trim();
		var name = frm.name.value.trim();
		var p2 = frm.p2.value.trim();
		var p3 = frm.p3.value.trim();
		var e1 = frm.e1.value.trim();
		var e2 = frm.e2.value;
		
		
		/* ID 확인*/
		if (id == "") {
			alert("ID를 입력하세요.");
			frm.id.focus();
			return false;
		} else if (id == "admin"){
			alert("사용할 수 없는 아이디입니다");
			frm.id.focus();
			return false;
		} 
		else if (id.length < 4) {
			alert("ID는 4자 이상 입력하세요.");
			frm.id.value = "";
			frm.id.focus();
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
		
		/* 이름 확인 */
		if (name == "") {
			alert("이름을 입력하세요.");
			frm.name.focus();
			return false;
		}
		
		/* 휴대 전화 확인 */
		if (p2 == "") {
			alert("휴대전화를 2번째 자리를 입력하지 않았습니다.");
			frm.p2.focus();		return false;
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
	
	
	
	<style>
	
	#join{
		border-top:1px solid #000;
		width:1000px;
		margin:0 auto;	
	 }
	 
	#join th td{
		height:100px;
	 }
	 
	 #join td{
	 	padding-left:5px;
		border-right:1px solid #000;
		border-bottom:1px solid #000;
			
	 }
	 
	#join th {
		background-color:black; 
		color:#FFA5C3;
		padding:5px;
		text-align:center;
			
	 }
	#frm_join {
		padding-left:20px;
		padding-top:50px;
		margin-left:30px;
		font-size:18px;
		margin-bottom:15px;
		margin-left:3px;
	}	
	p {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
	}
	
	</style>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
	<div id="div_form">
	<hr width="30%" size="1" color="#d1d1d1" />
	<p align="center">회원가입</p>
	<hr width="30%" size="1" color="#d1d1d1" />
	
		<form name="frm_join" id="frm_join" action="join_proc.jsp" method="post" onsubmit="return chkJoinForm(this);">
		<input type="hidden" name="wtype" value="in" />
		<table width="500" cellspacing="0" cellpadding="5" id="join">
		<tr height="50" >
		<th width="30%"><label for="id">아이디</label></th>
		<td width="*">
		<input type="text" style="height:25px;" name="id" id="id" readonly="readonly" onclick="chkID();" />
		<input type="button" class="btn_style" value="아이디 중복 확인" onclick="chkID();" />
		</td></tr>
		<tr height="50" >
		<th><label for="pwd">비밀번호</label></th>
		<td><input type="password" style="height:25px;" name="pwd" id="pwd" /></td>
		</tr>
		<tr height="50" >
		<th><label for="check_pwd">비밀번호 확인</label></th>
		<td><input type="password" style="height:25px;" name="check_pwd" id="check_pwd" /></td>
		</tr>
		<tr height="50" >
		<th><label for="name">이름</label></th>
		<td><input type="text" style="height:25px;" name="name" id="name" /></td>
		</tr>
		<tr height="50" >
		<th><label for="cell1">휴대폰</label></th>
		<td>
		<select name="p1" id="p1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="019">019</option>
		</select> -
		<input type="text" style="height:25px;" name="p2" id="p2" maxlength="4" size="4" onkeyup="onlyNumber(this);" /> -
		<input type="text" style="height:25px;" name="p3" id="p3" maxlength="4" size="4" onkeyup="onlyNumber(this);" />
		</td></tr>
		
		<tr height="50" >
		<th><label for="e1">이메일</label></th>
		<td>
		<input type="text" style="height:25px;" name="e1" id="e1" /> @
		<select name="e2" style="height:25px;" id="e2">
			<option value="">메일을 선택하세요.</option>
			<option value="naver.com">네 이 버</option>
			<option value="nate.com">네 이 트</option>
			<option value="gmail.com">지 메 일</option>
		</select>
		</td></tr>
		<tr height="50" >
		<th><label for="b1">생년월일</label></th>
		<td>
		<select name="b1" style="height:25px;" id="b1">
			<% 
			String slt = "";
			
			for (int i = 1930 ; i <= year ; i++) {
				slt = (i == year) ? "selected='selected'" : "";
		         out.println("<option value='" + i + "' " + slt + " >" + i + "</option>");
			}
		    %>
		</select>년
		
		<select name="b2" id="b2">
	      <%
	      String str ="";
	      
	      for(int i = 1 ; i <= 12; i++){
	            if (i < 10) {
	               str = "0" + i;
	               out.println("<option value='" + i + "'"+ i + " >" + str + "</option>");
	            } else {
	               str = i + "";
	               out.println("<option value='" + i + "'"+ i + " >" + str + "</option>");
	            }
	      }
	      %>
		</select>월
		
		<select name="b3" id="b3">
	      <%
	      str ="";
	      
	      for(int i = 1 ; i <=31; i++){
	            if (i < 10) {
	               str = "0" + i;
	               out.println("<option value='" + i + "'"+ i + " >" + str + "</option>");
	            } else {
	               str = i + "";
	               out.println("<option value='" + i + "'"+ i + " >" + str + "</option>");
	            }
	      }
	      %>
		</select>일
		</td></tr>
		<tr>
		<th><label for="g1">성 별</label></th>
		<td>
		<input type="radio" name="gender" id="g1" value="M" />남
		<input type="radio" name="gender" id="g2" value="F" checked="checked" />여
		</td></tr>
		</table>
		<div align="center">
		<br>
		<input type="submit" class="btn_style" value="회원 가입" />&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" class="btn_style" value="다시 입력" />&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="btn_style" value="가입 취소" onclick="location.href='main.jsp'" /> 
		</div>
		</form>
	</div>

<%@ include file="inc_html_footer.jsp" %>
</body>
</html>

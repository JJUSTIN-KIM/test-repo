<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function chk(){
	var req = agree_frm.req.value;
	var num;
	
	if(req == "agree"){
		num = 1;
	}
	else if(req == "unagree"){
		num = 2;
	}
	else{
		num = 3;
	}
	
	if(num == 1){
		document.agree_frm.isAgree.value = "Y";
		document.agree_frm.submit();
	}
	else if(num == 2){
		alert("동의하지 않으면 가입하실 수 없습니다");
		location.href="main.jsp";
	}
	
	else{
		alert("개인정보 약관에 동의하셔야 합니다.");
	}
}
</script>
<style>
#agree_form {
	margin-top:30px;
	margin-left:130px;
	padding-bottom:30px;
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
<div id="join_agree">
<form name="agree_frm" id="agree_form" action="join_form.jsp">
<input type="hidden" name="isAgree" />
	<hr width="40%" size="1" color="#d1d1d1" />
	<p align="center">개인정보 수집화면</p>
	<hr width="40%" size="1" color="#d1d1d1" />
<%
BufferedReader reader1 = null, reader2 = null;


try{
	String filePath1 = application.getRealPath("text/이용약관.txt");
	String filePath2 = application.getRealPath("text/개인정보 수집 및 이용동의.txt");
	reader1 = new BufferedReader(new InputStreamReader(new FileInputStream(filePath1), "EUC-KR"));
	reader2 = new BufferedReader(new InputStreamReader(new FileInputStream(filePath2), "EUC-KR"));
 %>
<img src="images/access1.png" width="132" height="34" border="0" alt="이용 약관"><br />
<textarea rows="10" cols="133" readonly="readonly">
<%
while(true){
	String str = reader1.readLine();
	
	if(str == null){
		break;
	}
	out.println(str + "\n");	
}
%>
</textarea><br /><br /><br /><br /><br />

<img src="images/access2.png" width="365" height="39" border="0" alt="개인정보 수집 및 이용 동의"><br />
<textarea rows="10" cols="133" readonly="readonly">
<%

while(true){
	String str = reader2.readLine();
	
	if(str == null){
		break;
	}	
	out.println(str + "\n");	
}
%>
</textarea>
<%
}catch(FileNotFoundException finfe){//파일이 존재하지 않을 때
	out.println("파일이 존재하지 않습니다.");
}catch(IOException ioe){//파일을 읽을 수 없을 때
	out.println("파일을 읽을수 없습니다.");
}finally{
	try{
		reader1.close();
		reader2.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
 %>
 <br />
<input type="radio" name="req" value="agree"><label name="req">약관에 동의합니다.</label>
<input type="radio" name="req" value="unagree"><label name="req">약관에 동의하지 않습니다.</label>
<br />
	<input type="button" value="확   인" class="btn_style" onclick="chk()"/>
 </form>
 </div>
<%@ include file="inc_html_footer.jsp" %>

</body>
</html>
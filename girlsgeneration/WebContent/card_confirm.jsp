<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script>
function showRandom() {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var stringLength = 6;
	var randomString = "";
	var obj = document.getElementById("randomString");

	for (var i = 0 ; i < stringLength ; i++) {
		var rnum = Math.floor(Math.random() * 62);
		randomString += chars.substring(rnum, rnum + 1);
	}
	obj.value = randomString;
}

function chkCode(frm) {
	var rCode = frm.randomString.value;
	var uCode = frm.userInput.value;
	
	if (!uCode) {
		alert('코드를 입력해주세요.');
		var isChk = "N"
	} else if (rCode == uCode) {
		alert('본인 확인이 완료되었습니다.');
		var isChk = "Y";
		self.close();
	} else {
		alert('코드를 정확하게 입력해 주세요.');
		var isChk = "N";
	}
	document.frm_code.isChk.value = isChk;
	
	if (isChk == "Y") {
		opener.frm_order_process.confirm_message.value = "본인확인이 완료되었습니다."
		opener.document.getElementById("confirm_message").style.color = "blue";
		opener.document.frm_order_process.isChk.value = "Y";
		document.frm_code.submit();
	}
}
</script>
<style>
#randomString { border:0; text-align:right; width:250px; font-size:1.0em;}
#userInput { text-align:right; width:250px; }
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신용카드 본인 확인</title>
</head>
<body>
<h4>본인확인을 위해 아래 코드를 입력해 주세요.(대소문자 구별)</h4>
<form name="frm_code" action="order_multi_process.jsp" method="post">
<input type="hidden" name="isChk" />
<table width="400" border="1">
<tr>
<td>
<input type="text" name="randomString" id="randomString" readonly="readonly" />
</td>
<td>
<input type="button" value="코드 생성" onclick="showRandom();" />
</td>
</tr>
<tr>
<td colspan="2">
<input type="text" name="userInput" id="userInput" placeholder="코드 입력" />
</td>
</tr>
<tr align="center">
<td>
<input type="button" value="코드 제출" onclick="chkCode(this.form)"/>
&nbsp;&nbsp;&nbsp;<input type="button" value="닫기" onclick="self.close();" />
</td>
</tr>
</table>
</form>
</body>
</html>
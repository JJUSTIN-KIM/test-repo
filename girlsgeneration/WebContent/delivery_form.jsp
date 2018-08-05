<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String wtype = request.getParameter("wtype");
String tmp_idx = "", zip="", addr1="", addr2="", isBasic="n";
int ma_idx = 0;
if(wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("location.href='mypage.jsp'");
	out.println("</script>");
}
else if (wtype.equals("up"))
{
	tmp_idx = request.getParameter("ma_idx");
	if(tmp_idx == null || tmp_idx.equals(""))
	{
		out.println("<script>");
		out.println("location.href='mypage.jsp'");
		out.println("</script>");
	}
	else
	{
		ma_idx = Integer.valueOf(tmp_idx);
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function chkAddr(form)
{
	var zip = form.zip.value.trim();
	var addr1 = form.addr1.value.trim();
	var addr2 = form.addr2.value.trim();
	
	if(zip == "")
	{
		alert("우편번호를 입력하지 않았습니다.");
		form.zip.focus();
		return false;
	}
	else if (addr1 == "")
	{
		alert("주소를 입력해주세요.");
		form.addr1.focus();
		return false;
	}
	else if (addr2 == "")
	{
		alert("나머지 주소를 입력해주세요.");
		form.addr2.focus();
		return false;
	}
	return true;
	
}

</script>
<style>
p {
	font-size:30px;
	color:#FFA5C3;
	align-content:left;	
}

.btn_style{
	font-size:25;
	color:#FFA5C3;
	border-color:#FFA5C3;
	background-color:white;
}


</style>
</head>
<body>
	<%
	if(userId == null)
	{
		out.println("<script>");
		out.println("location.href='login_form.jsp';");
		out.println("</script>");
	}
	%>
<%
if(wtype.equals("up"))
{
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		stmt = conn.createStatement();
		
		String sql = "select * from member_address where ma_idx = "+ ma_idx;
		
		rs = stmt.executeQuery(sql);
		
		if(rs.next())
		{
			isBasic =rs.getString("ma_isbasic");
			zip = rs.getString("ma_zip");
			addr1 = rs.getString("ma_addr1");
			addr2 = rs.getString("ma_addr2");
		}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try
		{
			rs.close();
			stmt.close();
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
%>
<div id="addr_Form" style>
	<%if(wtype.equals("in")){ %>
		<p align="left">주소지 입력</p>
	<%}else if(wtype.equals("up")){ %>
		<p align="left">주소지 수정</p>
	<%}%>
	<form action="delivery_proc.jsp" method="post" name="addr_frm" onsubmit="return chkAddr(this);">
		<input type="hidden" name="wtype" value="<%=wtype %>" />
		<input type="hidden" name="ma_idx" value="<%=tmp_idx %>" />
		<table width="500" id="tb_addr" cellpadding="5" cellspacing="0">
		<tr>
			<td align="left">
				우편번호 : <input type= "text" size="5" maxlength="5" name="zip" value="<%=zip%>" />
			</td>
		</tr>
		<tr>
			<td>
				기본주소 : <input type="text" size="30" name="addr1" value="<%=addr1%>" />&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				상세주소 : <input type="text" size="30" name="addr2" value="<%=addr2%>" />
			</td>
		</tr>
		<tr>
			<tdalign="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="isBasic" id = "yb" value="Y"  <%=(isBasic.equals("Y")) ? "checked='checked'" :"" %>/>
				<label for="yb">기본주소</label>
					<input type="radio" name="isBasic" id = "nb" value="N" <%=(isBasic.equals("N")) ? "checked='checked'" :"" %>/>
				<label for="nb">추가주소</label>
			</td> 
		</tr>
		</table><br />
		
		<div id="box_addr">
			<input type="submit" class="btn_style" value="OK" />&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn_style" value="CANCEL" onclick="history.back();"/>
		</div>
		
	</form>
	</div>
</body>
</html>
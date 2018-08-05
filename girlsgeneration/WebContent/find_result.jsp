<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>

<% 
String search = request.getParameter("search");
String id = request.getParameter("id");
String idx = request.getParameter("idx");
String pwd = "";

String sql;
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	if(search.equals("pwd_find")){
		Random random = new Random();
		String[] interim_pwd = {"gvji123", "jerj734", "setr378", "eshr925", "kert835", "awge356"};
		 pwd = interim_pwd[random.nextInt(6)];

		
		sql = "update member set m_pwd = '" + pwd + "' where m_idx = '" + idx + "'; ";
		
		
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			
		}
		
		else{
			out.println("<script>");
			out.println("location.replace('find_form.jsp');");
			out.println("</script>");
		}
		
	}
	
}catch(Exception e){
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
</style>
</head>
<body>
<div id="div_form">
<%
if(search.equals("id_find")){
	%>
	<hr width="40%" size="1" color="#d1d1d1" />
	<p align="center">아이디찾기 결과</p>
	<hr width="40%" size="1" color="#d1d1d1" />
	
	<%
	int id_cipher = 0;
	String id_find = null;
	
	if(id != null){
		id_cipher = id.length() - 2;
		id_find = id.substring(0, id_cipher);
		out.println("<b style='align-self:auto;'>아이디 : " + id_find + "**</b>");
		out.println("<b style='align-self:auto;'>전체 아이디는 고객센터로 문의해 주십시오</b>");
	}else{
		out.println("<b style='align-self:center;'>고객님이 찾는 아이디가 없습니다. 다시 확인하여 주십시요.</b>");
		
	}
	
%>
	

	

<%}else if(search.equals("pwd_find")){%>
	<hr width="40%" size="1" color="#d1d1d1" />
	<p align="center">비밀번호찾기결과</p>
	<hr width="40%" size="1" color="#d1d1d1" />
	
	<b style ="align-self:auto;">패스 워드 : <%=pwd %></b><br/>
	<b style ="align-self:auto;">임시 비밀번호가 발급되었습니다. 로그인 후 비밀번호를 바꿔주세요~</b>
	
	
<%} %>

<input type="button" class="btn_style" value="로그인 " onclick="location.replace('login_form.jsp');" />



</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
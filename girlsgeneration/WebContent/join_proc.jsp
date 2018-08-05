<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>

<%
String wtype = request.getParameter("wtype");
String id = request.getParameter("id");

if (wtype.equals("del")) {
	id = userId;
}

String pwd = request.getParameter("pwd");
String name = request.getParameter("name");
String c1 = request.getParameter("p1");
String c2 = request.getParameter("p2");
String c3 = request.getParameter("p3");
String e1 = request.getParameter("e1");
String e2 = request.getParameter("e2");
String gender = request.getParameter("gender");

String phone = "", email = "", birth = "";
int b1 = 0, b2 = 0, b3 = 0;

String sql = "";
String sql_point = "";
if (wtype.equals("in") && (pwd == null || c1 == null || c2 == null || c3 == null || e1 == null || e2 == null || gender == null)) {


	
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}
if(wtype.equals("in")){
	b1 = Integer.valueOf(request.getParameter("b1"));
	b2 = Integer.valueOf(request.getParameter("b2"));
	b3 = Integer.valueOf(request.getParameter("b3"));

}
if(wtype.equals("in") || wtype.equals("up")) {
	phone = c1 + "-" + c2 + "-" + c3;
	email = e1 + "@" + e2;
	
	if(b2 < 10 && b3 >= 10){
		birth = b1 + "0" + b2 + "" + b3;
	}else if(b2 < 10 && b3 < 10){
		birth = b1 + "0" + b2 + "0" + b3;
	}else if(b2 >= 10 && b3 >= 10){
		birth = b1 + "" + b2 + "" + b3;
	}
}
	
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	
	if(wtype.equals("in")){
		sql = "insert into member (m_id, m_pwd, m_name, m_birth, m_gender, ";
		sql += "m_phone, m_email, m_point) values ('" + id + "', '" + pwd + "', '";
		sql += name + "', '" + birth + "', '" + gender + "', '" + phone + "', '";
		sql += email + "', " + 1000 + ");";
			
		int result = stmt.executeUpdate(sql);
		
		sql_point = "insert into member_point (m_id, mp_point, mp_isuse, mp_desc) ";
		sql_point += "values ('"+id+"', " + 1000 + ", 'N', '회원가입' );";
		
		int result_point = stmt.executeUpdate(sql_point);
		
		
		if (result != 0 && result_point != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('login_form.jsp');");
			out.println("</script>");
		}
	}
	
	else if(wtype.equals("up")){
		sql  = "update member set " ;
		sql += "m_pwd = '" + pwd + "', ";
		sql += "m_name = '" + name + "' , ";
		sql += "m_phone = '" + phone + "' , ";
		sql += "m_email='" + email + "' ";
		sql += "where m_id = '" + userId + "';";
		
		int result = stmt.executeUpdate(sql);
		
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("alert('정상적으로 바뀌었습니다.');");
			out.println("location.replace('main.jsp');");
			out.println("</script>");
		}

	}
	
	
	else if(wtype.equals("del")){
		sql = "update member set ";
		sql += "m_pwd = '', m_name = '', m_birth = '', ";
		sql += "m_gender = '', m_phone = '',m_email='', m_isuse = 'N' ";
		sql += "where m_id = '" + userId + "'";
		
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('logout.jsp');");
			out.println("</script>");
		}
		
		else{
			out.println("<script>");
			out.println("location.replace('main.jsp');");
			out.println("</script>");
		}
	}
	
	
}catch(Exception e) {
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

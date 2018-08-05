<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="inc_header.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
// 사용자가 입력한 정보 받아오기
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
Statement stmt2 = null;
ResultSet rs2 = null;


String sql_member = "select m_pwd, m_name from member where m_id = '" + id + "';";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");

	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql_member);

	String msg = "";	// 로그인이 안되었을 경우 보여줄 메세지 
	
	if (rs.next()) {
	// 사용자가 입력한 아이디와 비밀번호에 해당하는 회원이 있으면(로그인 시켜줌)
		if (pwd.equals(rs.getString("m_pwd"))) {
		// 사용자가 입력한 아이디에 해당하는 회원이 있으면(암호를 검사함)
			session.setAttribute("userId", id);
			session.setAttribute("userName", rs.getString("m_name"));
			// 다른 페이지에서도 로그인 되었다는 것을 알기 위해 세션변수(속성)으로 설정
			if (id.equals("admin")) {
				out.println("<script>");
				out.println("location.replace('admin/admin_main.jsp');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("location.replace('main.jsp');");
				out.println("</script>");
			}
		} else {
			msg = "아이디와 비밀번호를 다시 확인하시고 로그인해주세요.";
		}
	}

	if (!msg.equals("")) {
		out.println("<script>");
		out.println("alert('" + msg + "')");
		out.println("location.replace('login_form.jsp');");
		out.println("</script>");
	}

} catch(Exception e) {
	out.println("<h3>DB작업에 실패하였습니다.</h3>");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		rs2.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>

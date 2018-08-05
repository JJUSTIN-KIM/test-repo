<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String search = request.getParameter("search");
String name = request.getParameter("name");
String e1 = request.getParameter("e1");
String e2 = request.getParameter("e2");
String id = request.getParameter("id");
String email = "";
String sql = "";

	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "1234");
		stmt = conn.createStatement();
	

		if(search.equals("id_find")){

			email = e1 + "@" +e2;
			
			sql = "select m_id from member where m_name = '" + name + "' and m_email = '" + email + "';";
			rs = stmt.executeQuery(sql);
			

			if(rs.next()){
				out.println("<script>");
				out.println("location.replace('find_result.jsp?search="+search+"&id="+rs.getString(1)+"');");
				out.println("</script>");
			}else{
				out.println("<script>");
				out.println("location.replace('find_result.jsp?search="+search+"');");
				out.println("</script>");				
			}
				
			
		}else if(search.equals("pwd_find")){
			email = e1 + "@" +e2;
			sql = "select m_idx from member where m_id = '" + id + "'and m_email = '" + email + "';";
			rs = stmt.executeQuery(sql);
			

			if(rs.next()){
				out.println("<script>");
				out.println("location.replace('find_result.jsp?search="+search+"&idx="+rs.getInt(1)+"');");
				out.println("</script>");
			}else{
				out.println("<script>");
				out.println("location.replace('main.jsp');");
				out.println("</script>");				
			}

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
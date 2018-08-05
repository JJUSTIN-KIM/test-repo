<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<%
int idx = Integer.valueOf(request.getParameter("idx"));
String basicCheck = "";
int num  = 0;
String sql = "";
String id = request.getParameter("id");


try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	

	//주소가 기본주소인지 아닌지 확인
	sql = "select ma_isbasic from member_address where ma_idx = " + idx + " and m_id= '" + id + "';";
	rs = stmt.executeQuery(sql);
	if(rs.next()){
		basicCheck = rs.getString("ma_isbasic");
	}
	
	
	//기본주소가  Y일때
	if(basicCheck.equals("Y")){
		sql = "select count(*) from member_address where m_id = '" + id + "';";
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			num = rs.getInt(1);
		}
		if(num == 0 || num == 1){
			out.println("<script>");
			out.println("alert('지울 수 없습니다.');");
			out.println("history.back()");
			out.println("</script>");
		}
		
		//삭제
		sql = "delete from member_address where ma_idx = " + idx + " and m_id = '" + id + "';";
		stmt.executeUpdate(sql);
		
		//삭제 후 나머지 주소 중  처음주소를 가지고 옴
		sql = "select ma_idx from member_address where m_id = '" + id + "' limit 1;";
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			num = rs.getInt("ma_idx");
		}
		//처음주소를 기본주소로 바꾸기...
		sql = "update member_address set ma_isbasic = 'Y' where m_id = '" + id + "' and ma_idx = " + num;
		int result = stmt.executeUpdate(sql);
		
		
	
		if(result != 0){
			out.println("<script>");
			out.println("location.replace('admin_member.jsp')");
			out.println("</script>");
		}		
	}
	
	
	//기본주소가  N일때(그냥 삭제)
	else if(basicCheck.equals("N")){
		sql = "delete from member_address where ma_idx = " + idx + " and m_id = '" + id + "';";
		int result = stmt.executeUpdate(sql);
	
		if(result != 0){
			out.println("<script>");
			out.println("location.href='admin_member.jsp'");
			out.println("</script>");
		}
	
	}
}catch(Exception e)
{ 	
   e.printStackTrace();
}
finally
{
   try
   {
      stmt.close();
      conn.close();
   }
   catch(Exception e)
   {
      e.printStackTrace();
   }
}
%>
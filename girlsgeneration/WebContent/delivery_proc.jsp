<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String wtype = request.getParameter("wtype");
String zip = request.getParameter("zip");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");
String isbasic = request.getParameter("isBasic");
String idx = request.getParameter("ma_idx");
int num = 0;


try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	String sql = "";
	
	if(wtype.equals("in")){
		sql = "select count(*) from member_address where m_id = '" + userId + "';";
		out.println(sql);
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			num = rs.getInt(1);
		}
		
		// 주소가 아예 없을 경우 기본주소로 바꾸어주기....
		if(num == 0){
			isbasic = "Y";			
		}
		
		if(isbasic.equals("Y")){
			sql = "update member_address set ma_isbasic = 'N' where ma_isbasic = 'Y' and m_id= '" + userId +"';";
			stmt.executeUpdate(sql);

			sql = "insert into member_address (m_id, ma_zip, ma_addr1, ma_addr2, ma_isbasic)";
			sql += "values ('"+ userId +"', '"+ zip +"','"+ addr1 +"','"+ addr2 + "', 'Y');";

		}else if(isbasic.equals("N")){
	         sql = "insert into member_address (m_id, ma_zip, ma_addr1, ma_addr2) ";
	         sql += "values ('"+ userId +"', '"+ zip +"','"+ addr1 +"','"+ addr2 +"');";
		}
		
		int result = stmt.executeUpdate(sql);

		if(result != 0){
			out.println("<script>");
			out.println("location.href='mypage.jsp'");
			out.println("</script>");
		}
		
	//수정할때
	}else if(wtype.equals("up")){
		if(isbasic.equals("Y")){
			sql = "update member_address set ma_isbasic = 'N' where ma_isbasic = 'Y' and m_id= '" + userId +"';";

			stmt.executeUpdate(sql);

			sql = "update member_address set ma_zip = '" + zip + "', ma_addr1 = '" + addr1 + "', ma_addr2 = '" + addr2;
			sql += "', ma_isbasic = 'Y' where ma_idx = " + idx + " and m_id = '" + userId + "';";
			out.println(sql);

			int result = stmt.executeUpdate(sql);
			
			if(result != 0){
				out.println("<script>");
				out.println("location.href='mypage.jsp'");
				out.println("</script>");
			}
			
			
		}else if(isbasic.equals("N")){
			String basicCheck = "";
			num  = 0;
			
			
			sql = "select ma_isbasic from member_address where ma_idx = " + idx + " and m_id= '" + userId + "';";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				basicCheck = rs.getString("ma_isbasic");
			}
			
			if(basicCheck.equals("N")){
				sql = "update member_address set ma_zip = '" + zip + "', ma_addr1 = '" + addr1 + "', ma_addr2 = '" + addr2;
				sql += "', ma_isbasic = 'N' where ma_idx = " + idx + " and m_id = '" + userId + "';";
				out.println(sql);
			
				int result = stmt.executeUpdate(sql);
				if(result != 0){
					
					out.println("<script>");
					out.println("location.href='mypage.jsp'");
					out.println("</script>");
				}
				
			}
			else if(basicCheck.equals("Y")){
				
				sql = "select count(*) from member_address where m_id = '" + userId + "';";
				rs = stmt.executeQuery(sql);
				
				if(rs.next()){
					num = rs.getInt(1);
				}
				
				if(num == 0){
					out.println("alert('잘못된 수식입니다.')");
					out.println("<script>");
					out.println("location.href='main.jsp'");
					out.println("</script>");
				}
				
				else if(num == 1){
					out.println("alert('~~를 바꿀수 없습니다..')");
					out.println("<script>");
					out.println("location.href='main.jsp'");
					out.println("</script>");
				}
				
				
				sql = "select ma_idx from member_address where m_id = '" + userId + "' limit 1;";
				rs = stmt.executeQuery(sql);
				if(rs.next()){
					num = rs.getInt("ma_idx");
					sql = "update member_address set ma_isbasic = 'Y' where m_id = '" + userId + "' and ma_idx = " + num;
					stmt.executeUpdate(sql);
				}
				sql = "update member_address set ma_zip = '" + zip + "', ma_addr1 = '" + addr1 + "', ma_addr2 = '" + addr2;
				sql += "', ma_isbasic = 'N' where ma_idx = " + idx + " and m_id = '" + userId + "';";
				out.println(sql);

				int result = stmt.executeUpdate(sql);
				
				out.println(sql);
				if(result != 0){
					
					out.println("<script>");
					out.println("location.href='mypage.jsp'");
					out.println("</script>");
				}
			}
		}
	}
	
	//삭제할때
	else if(wtype.equals("del")){
		String basicCheck = "";
		num  = 0;
		
		
		//주소가 기본주소인지 아닌지 확인
		sql = "select ma_isbasic from member_address where ma_idx = " + idx + " and m_id= '" + userId + "';";
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			basicCheck = rs.getString("ma_isbasic");
		}

		
		//기본주소가  Y일때
		if(basicCheck.equals("Y")){
			sql = "select count(*) from member_address where m_id = '" + userId + "';";
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
			sql = "delete from member_address where ma_idx = " + idx + " and m_id = '" + userId + "';";
			stmt.executeUpdate(sql);
			
			//삭제 후 나머지 주소 중  처음주소를 가지고 옴
			sql = "select ma_idx from member_address where m_id = '" + userId + "' limit 1;";
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				num = rs.getInt("ma_idx");
			}
			//처음주소를 기본주소로 바꾸기...
			sql = "update member_address set ma_isbasic = 'Y' where m_id = '" + userId + "' and ma_idx = " + num;
			int result = stmt.executeUpdate(sql);
			
			

			if(result != 0){
				out.println("<script>");
				out.println("location.href='mypage.jsp'");
				out.println("</script>");
			}		
		}
		
		
		//기본주소가  N일때(그냥 삭제)
		else if(basicCheck.equals("N")){
			sql = "delete from member_address where ma_idx = " + idx + " and m_id = '" + userId + "';";
			int result = stmt.executeUpdate(sql);

			if(result != 0){
				out.println("<script>");
				out.println("location.href='mypage.jsp'");
				out.println("</script>");
			}

		}
	}
	
	
	else if(wtype.equals("ch")){
		sql = "update member_address set ma_isbasic = 'N' where ma_isbasic = 'Y' and m_id= '" + userId +"';";
		stmt.executeUpdate(sql);
		
		sql = "update member_address set ma_isbasic = 'Y' where ma_idx = " + idx + " and m_id= '" + userId +"';";
		int result = stmt.executeUpdate(sql);
		
		if(result != 0){
			out.println("<script>");
			out.println("location.href='mypage.jsp'");
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
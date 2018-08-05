<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ include file="inc_header.jsp" %>
<%
String p_id = "", wtype = "", contents = "", grade = "";
String filename1 = "", orifilename1 = "";
String query_review_insert = "";

String uploadPath = "D:/ksh/jsp/work/db_gg/WebContent/images_review";
int size = 10 * 1024 * 1024;

try {
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
	
	p_id = multi.getParameter("p_id");
	wtype = multi.getParameter("wtype");
	contents = multi.getParameter("tbl_rm_contents");
	grade = multi.getParameter("tbl_add_review_grade");
	
	Enumeration files = multi.getFileNames();
	String file1 = (String)files.nextElement();
	filename1 = multi.getFilesystemName(file1);
	orifilename1 = multi.getOriginalFileName(file1);
	
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");

	stmt = conn.createStatement();
	
	query_review_insert = "insert into productsreview (p_id, m_id, pr_img, pr_contents, pr_grade)";
	query_review_insert += " values ('" + p_id + "', '" + userId + "', 'images_review/" + filename1 + "', '" + contents + "', " + grade + ");";
	
	System.out.println("[product_detail_proc][1-1] p_id : " + p_id);
	System.out.println("[product_detail_proc][1-2] wtype : " + wtype);
	System.out.println("[product_detail_proc][1-3] contents : " + contents);
	System.out.println("[product_detail_proc][1-4] grade : " + grade);
	System.out.println("[product_detail_proc][2-1] query_review_insert : " + query_review_insert);

	if (wtype.equals("rin")) {
		int result = stmt.executeUpdate(query_review_insert);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			System.out.println("wtype:rin => 실행완료");
			out.println("<script>");
			out.println("location.replace('product_detail.jsp?p_id=" + p_id + "');");
			out.println("</script>");
		} else {	// 쿼리의 실행결과가 레코드 하나라도 적용이 안되었다면
			System.out.println("wtype:rin => 쿼리실행안됨");
			out.println("<script>");
			out.println("location.replace('main.jsp');");
			out.println("</script>");
		}
	} else {	// 잘못 들어왔을 경우
		System.out.println("wtype 자체를 먹지않음");
		out.println("<script>");
		out.println("location.replace('main.jsp');");
		out.println("</script>");
	}
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		if (rs != null) { rs.close(); }
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>




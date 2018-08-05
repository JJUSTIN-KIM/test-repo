<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");
String title = request.getParameter("title");
String contents = request.getParameter("contents");

int idx = 1;

String tmpPage = request.getParameter("cpage");

if (tmpPage == null)	tmpPage = "";
String args = "&cpage=" + tmpPage;
// 작업(수정, 삭제) 후 돌아갈 페이지의 정보를 알기위해

String sql = "";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	if (wtype.equals("in")) {	// 게시글 등록 이면
		
		title = title.trim();
		contents = contents.trim();

		sql = "select max(bn_idx) from boardnotice";
		rs = stmt.executeQuery(sql);
		if (rs.next())	idx = rs.getInt(1) + 1;

		sql = "insert into boardnotice (bn_title, bn_contents) ";
		sql += "values ('" + title + "', '" + contents + "')";

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_notice_view.jsp?idx=" + idx + "');");
			out.println("</script>");
		}

	} else if (wtype.equals("up")) {	// 게시글 수정 이면

		title = title.trim();
		contents = contents.trim();
		// 수정하려는 게시글이 회원글인지 비회원글인지 여부를 판단

		if (tmpIdx == null) {
			out.println("<script>");
			out.println("location.replace('board_notice.jsp');");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
			sql = "update boardnotice set bn_title = '"+title+"', bn_contents = '"+contents+"' where bn_idx = "+ idx;

			int result = stmt.executeUpdate(sql);
			if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
				out.println("<script>");
				out.println("location.replace('board_notice.jsp');");
				out.println("</script>");
			}
		}
		
	} else if (wtype.equals("del")) {	// 게시글 삭제 이면
		if (tmpIdx == null) {
			out.println("<script>");
			out.println("self.close();");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
		}
		/*
		sql = "select bn_writer from boardnotice where bn_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			writer = rs.getString("bn_writer");
		} else {
			out.println("<script>");
			out.println("location.replace('main.jsp');");
			out.println("</script>");
		}
		*/
	} else {	// 잘못 들어왔을 경우
		out.println("<script>");
		out.println("location.replace('board_notice.jsp');");
		out.println("</script>");
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








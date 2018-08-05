<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String m_id = userId;
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
String writer = request.getParameter("writer");
String kind = request.getParameter("kind");
if(kind == null || kind.equals(""))
{
	kind = "a";
}
System.out.println(kind);
int idx = 1;

String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null)	tmpPage = "";
if (schkind == null)	schkind = "";
if (keyword == null)	keyword = "";
String args = "&cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;
// 작업(수정, 삭제) 후 돌아갈 페이지의 정보를 알기위해

String sql = "";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	if (wtype.equals("in")) {	// 게시글 등록 이면
		
		title = title.trim();
		contents = contents.trim();

		sql = "select max(bq_idx) from boardqna";
		rs = stmt.executeQuery(sql);
		if (rs.next())	idx = rs.getInt(1) + 1;

		sql = "insert into boardqna (m_id, bq_kind, bq_title, bq_contents, bq_writer) ";
		sql += "values ('" + m_id + "', '" + kind + "', '" + title + "', '" + contents + "', '" + m_id + "')";

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_qna_view.jsp?idx=" + idx + "');");
			out.println("</script>");
		}

	} else if (wtype.equals("re")) {	// 게시글 답글 등록 이면
		title = title.trim();
		contents = contents.trim();

		sql = "select max(bn_idx) from boardqna";
		rs = stmt.executeQuery(sql);
		if (rs.next())	idx = rs.getInt(1) + 1;

		sql = "insert into boardqna (bq_kind, bq_title, bq_contents) ";
		sql += "values ('" + kind + "', '" + title + "', '" + contents + "')";

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_qna_view.jsp?idx=" + idx + "');");
			out.println("</script>");
		}

	} else if (wtype.equals("up")) {	// 게시글 수정 이면
		
		title = title.trim();
		contents = contents.trim();

		if (tmpIdx == null) {
			out.println("<script>");
			out.println("location.replace('board_qna.jsp');");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
		}
		if (writer.equals("n")) {	// 회원글이면(bq_writer의 값과 현재 로그인한 id의 값을 이용하여 수정)
			sql = "update boardqna set ";
			sql += " bq_title = '" + title + "', ";
			sql += " bq_contents = '" + contents + "' ";
			sql += " bq_kind = '" + kind + "' ";
			sql += " where bq_idx = " + idx + " and bq_writer = '" + userId + "' ";
		}
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_qna_view.jsp?idx=" + idx + args + "');");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

	} else if (wtype.equals("del")) {	// 게시글 삭제 이면
		if (tmpIdx == null) {
			out.println("<script>");
			out.println("self.close();");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
		}
	
		sql = "select bq_writer from boardqna where bq_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			writer = rs.getString("bq_writer");
		} else {
			out.println("<script>");
			out.println("location.replace('main.jsp');");
			out.println("</script>");
		}

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
		} else {
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

	} else {	// 잘못 들어왔을 경우
		out.println("<script>");
		out.println("location.replace('board_qna.jsp');");
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








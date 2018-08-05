<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
String writer = request.getParameter("writer");
String pwd = request.getParameter("pwd");
int idx = 1;

String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null)	tmpPage = "";
if (schkind == null)	schkind = "";
if (keyword == null)	keyword = "";
String args = "&cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;
// 작업(수정, 삭제) 후 돌아갈 페이지의 정보를 알기위해

String sql = "", ismem = "n";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	if (wtype.equals("in")) {	// 게시글 등록 이면
		if (isLogin) {	// 현재 로그인 상태이면
			writer = userId;
			pwd = "";
			ismem = "y";	// 회원글이라는 표식
		} else {	// 로그인이 안된 상태이면
			writer = writer.trim();
			pwd = pwd.trim();
		}
		title = title.trim();
		contents = contents.trim();

		sql = "select max(bn_idx) from boardnotice";
		rs = stmt.executeQuery(sql);
		if (rs.next())	idx = rs.getInt(1) + 1;

		sql = "insert into boardnotice (bn_idx, bn_title, bn_contents) ";
		sql += "values (" + idx + ", '" + title + "', '" + contents + "')";

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_view.jsp?idx=" + idx + "');");
			out.println("</script>");
		}

	} else if (wtype.equals("up")) {	// 게시글 수정 이면
		if (!isLogin) {	// 로그인이 안된 상태이면
			writer = writer.trim();
			pwd = pwd.trim();
		}
		title = title.trim();
		contents = contents.trim();
		ismem = request.getParameter("ismem");
		// 수정하려는 게시글이 회원글인지 비회원글인지 여부를 판단

		if (tmpIdx == null) {
			out.println("<script>");
			out.println("location.replace('board_list.jsp');");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
		}
		if (ismem.equals("n")) {	// 비회원 글이면(writer와 pwd의 값을 이용하여 수정)
		sql = "update boardnotice set ";
		sql += " bn_title = '" + title + "', ";
		sql += " bn_contents = '" + contents + "', ";
		sql += " bn_writer = '" + writer + "' ";
		sql += " where bn_idx = " + idx + " and bn_pwd = '" + pwd + "' ";
		} else {	// 회원글이면(bn_writer의 값과 현재 로그인한 id의 값을 이용하여 수정)
			sql = "update boardnotice set ";
			sql += " bn_title = '" + title + "', ";
			sql += " bn_contents = '" + contents + "' ";
			sql += " where bn_idx = " + idx + " and bn_writer = '" + userId + "' ";
		}
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('free_view.jsp?idx=" + idx + args + "');");
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
	
		sql = "select bn_writer, bn_ismem from boardnotice where bn_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			writer = rs.getString("bn_writer");
			ismem = rs.getString("bn_ismem");
		} else {
			out.println("<script>");
			out.println("location.replace('main.jsp');");
			out.println("</script>");
		}
		
		if (ismem.equals("n")) {	// 비회원 글이면(입력받은 비밀번호와 비교하여 삭제)
			sql = "delete from boardnotice where bn_idx = " + idx + " and bn_pwd = '" + pwd + "' ";
		} else {	// 회원 글이면(입력한 아이디와 현재 로그인한 아이디를 비교하여 삭제)
			sql = "delete from boardnotice where bn_idx = " + idx + " and bn_writer = '" + userId + "' ";
		}

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			if (ismem.equals("n")) {
			out.println("opener.location.replace('board_list.jsp');");
			out.println("self.close();");
			} else {
				out.println("location.replace('board_list.jsp')");
			}
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

	} else {	// 잘못 들어왔을 경우
		out.println("<script>");
		out.println("location.replace('board_list.jsp');");
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








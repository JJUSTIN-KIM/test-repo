<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tmpPage = request.getParameter("cpage");
String tmpIdx = request.getParameter("idx");
String wtype = request.getParameter("wtype");

String args="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<%
//페이지 번호 설정(페이지 번호는 게시판 전체에서 필수요소로 사용됨)
int cpage = 1, psize = 10, bsize = 10, sidx = 0;
//cpage : 현재 페이지번호, psize : 페이지크기, bsize : 블록크기, sidx : limit의 시작인덱스
if (tmpPage == null || tmpPage.equals("")) {
// 현재 페이지번호가 없을 경우 무조건 1페이지로 셋팅
	cpage = 1;
} else {
// 현재 페이지번호가 있을 경우 정수로 형변환함(여러 계산에서 사용되기도 하며, 인젝션 공격을 막기 위한 조치)
	cpage = Integer.valueOf(tmpPage);
}
sidx = (cpage - 1) * psize;	// limit의 시작인덱스

String sql = "select bn_idx, bn_title, bn_date ";
sql += "from boardnotice order by bn_idx desc limit " + sidx + ", " + psize;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

	int num = 0;
	rs = stmt.executeQuery("select count(*) from boardnotice ");
	if (rs.next())	num = rs.getInt(1);
	// rs.getInt(1) : rs라는 ResultSet에서 첫번째 컬럼의 값을 int형으로 리턴
	rs.close();	// ResultSet은 한 번 사용후 닫아주는 것이 좋다.
	// 게시판의 전체 레코드 개수(게시물 번호와 페이지 수 등을 구하기 위한 값)

	rs = stmt.executeQuery(sql);
	
%>
<div class="contents_area">
	<div id="searchbox" align="center">
		<div id="notice_title">
			<ul>
				<li>
					<a href="board_notice.jsp">NOTICE</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_qna.jsp">QNA</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_faq.jsp">FAQ</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</li>
			</ul>
		</div>
		<div id="tbl_bn_free">
		<form name="frm_search" method="post">
		<table width="800" cellpadding="5" border="1" cellspacing="0" id="free">
		<tr>
			<th width="10%"><img src="./images/board_num.JPG" width="41" height="23" alt ="Num"/></th>
			<th width="*"><img src="./images/board_title.JPG" width="41" height="23" alt ="title"/></th>
			<th width="15%"><img src="./images/board_date.JPG" width="41" height="23" alt ="date"/></th>
		</tr>
	<%
		String title, date, linkHead = "", linkTail = "";
		if(rs.next()) {		// 검색된 게시물이 있으면
			int lastPage = (num - 1) / psize + 1;	// 마지막 페이지 번호
			num = num - (cpage - 1) * psize;	// 게시물 개수 번호
			do {
				linkHead = "<a href ='board_notice_view.jsp?&idx=" + rs.getInt("bn_idx") + "'>";
				if (rs.getString("bn_title").length() > 28) {
				// 제목이 28자를 넘으면(제목이 너무 길어서 두줄로 나올 상황이면 자른후 말줄임표를 붙여줌)
					title = rs.getString("bn_title").substring(0, 28) + "...";
				} else {
					title = rs.getString("bn_title");
				}
	%>
		<tr align="center">
		<td style="text-align:center;"><%=num %></td>
		<td align="left">&nbsp;<%=linkHead + title %></td>
		<td style="text-align:center;"><%=rs.getString("bn_date").substring(0,10) %></td>
		<%
				num--;
			} while(rs.next());
		%>
		</table>
		</div>
		<div id="paging">
		<a href="board_notice.jsp?cpage=1<%=args %>">&lt;&lt;</a><!-- 마지막페이지로 이동 -->
		<%
			linkHead = "";
			linkTail = "";
			if (cpage > 1) {
			// 현재 페이지번호가 1보다 크면(현재 페이지의 이전 페이지가 존재하면)
				linkHead = "<a href='board_notice.jsp?cpage=" + (cpage - 1) + args + "'>";
				linkTail = "</a>";
			}
			out.println(linkHead + "&lt;" + linkTail);
			// 이전페이지로 이동
	
			int spage = (cpage - 1) / bsize * bsize + 1;
			// 각 블록의 시작 페이지 번호
			for (int i = spage ; i < spage + bsize && i <= lastPage ; i++) {
			// 시작 페이지 번호 부터 블록의 크기만큼 또는 마지막 페이지까지 루프를 돔
				if (i == cpage) {
				// 현재 페이지번호이면(링크를 생략하고, 굵게 표현)
					out.println("&nbsp;<b>" + i + "</b>&nbsp;");
				} else {
					out.println("&nbsp;<a href='board_notice.jsp?cpage=" + i + args + "'>" + i + "</a>&nbsp;");
				}
			}
			linkHead = "";
			linkTail = "";
			// 기존의 값이 남아 있지 않게 다시 빈 문자열로 초기화
			if (cpage < lastPage) {
			// 현재 페이지 번호가 마지막 페이지 번호보다 작으면(현재 페이지의 다음 페이지가 존재하면)
				linkHead = "<a href='board_notice.jsp?cpage=" + (cpage + 1) + args + "'>";
				linkTail = "</a>";
			}
			out.println(linkHead + "&gt;" + linkTail);
			// 다음페이지로 이동
	%>
	
	<a href="board_notice.jsp?cpage=<%=lastPage + args %>">&gt;&gt;</a><!-- 마지막페이지로 이동 -->
	</div>
	<%
		} else {	// 검색된 게시물이 없으면
			out.println("<tr><td align='center'></td></tr></table>");
		}
	%>
		<div id="writing">
			<% if (isLogin && userId.equals("admin")) { %>
			<input type="button" value="글 쓰 기" onclick="location.href='board_notice_form.jsp?wtype=in';" />
			<% } else { 
			} %>
		</div>
		</form>
	</div>
</div>
<%
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
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
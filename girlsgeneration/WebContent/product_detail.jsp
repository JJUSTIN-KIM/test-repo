<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String p_id = request.getParameter("p_id"); 
String s_color = request.getParameter("selectcolor");
String s_size = request.getParameter("selectsize");
String s_amount = request.getParameter("selectamount");
//String temp_yn_applychoice = request.getParameter("temp_yn_applychoice");

String temp_yn_applychoice = "n";
int getprice = 0, getpoint = 0;
int grade_count = 0, grade_score_1 = 0, grade_score_2 = 0, grade_score_3 = 0, grade_score_4 = 0, grade_score_5 = 0;
int width_stick_grade1 = 0, width_stick_grade2 = 0, width_stick_grade3 = 0, width_stick_grade4 = 0, width_stick_grade5 = 0;
int choicestock = 0;
String grade_score_total = "";
String product_img1 = "", product_img2 = "", product_img3 = "";
String choicecolor = "", choicesize = "";
String query_part_selectcolor = "", query_part_selectsize = "";

if(temp_yn_applychoice == null || temp_yn_applychoice.equals("")) temp_yn_applychoice = "n";
if(s_color == null || s_color.equals("")) {
	s_color = "";
} else {
	query_part_selectcolor = " and po_color = '" + s_color + "'";
}
if(s_size == null || s_size.equals("")) {
	s_size = "";
} else {
	query_part_selectsize = " and po_size = " + s_size;
}
if(s_amount == null || s_amount.equals(""))	s_amount = "";

String query_choicecolor = "select distinct po_color from products_option where p_id = '" + p_id + "'";
String query_choicesize = "select distinct po_size from products_option where p_id = '" + p_id + "'" + query_part_selectcolor;
String query_choicestock = "select po_stock from products_option where p_id = '" + p_id + "'" + query_part_selectcolor + query_part_selectsize;

String query_grade_score_total = "select sum(pr_grade)/count(pr_grade) grade from productsreview where p_id = '" + p_id + "'";
String query_grade_count = "select count(*) cnt from productsreview where p_id = '" + p_id + "'";
String query_grade_score_1 = "select count(*) cnt from productsreview where p_id='" + p_id + "' and pr_grade = 1";
String query_grade_score_2 = "select count(*) cnt from productsreview where p_id='" + p_id + "' and pr_grade = 2";
String query_grade_score_3 = "select count(*) cnt from productsreview where p_id='" + p_id + "' and pr_grade = 3";
String query_grade_score_4 = "select count(*) cnt from productsreview where p_id='" + p_id + "' and pr_grade = 4";
String query_grade_score_5 = "select count(*) cnt from productsreview where p_id='" + p_id + "' and pr_grade = 5";

System.out.println("[1] 받아온 데이터 p_id : " + p_id);
System.out.println("[1-1] s_color : " + s_color + " / s_size : " + s_size + " / s_amount : " + s_amount);
System.out.println("[2-1] query_part_selectcolor : " + query_part_selectcolor);
System.out.println("[2-2] query_part_selectsize : " + query_part_selectsize);
System.out.println("[2-3] query_part_selectsize : " + query_part_selectsize);
System.out.println("[2-4] query_choicecolor : " + query_choicecolor);
System.out.println("[2-5] query_choicesize : " + query_choicesize);
System.out.println("[2-6] query_choicestock : " + query_choicestock);
System.out.println("[2-7] start => temp_yn_applychoice : " + temp_yn_applychoice);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>제품 상세 페이지</title>
<script>
function applychoice(frm_choice) {
	var select_color = frm_choice.selectcolor.value;
	var select_size = frm_choice.selectsize.value;
	var select_amount = frm_choice.selectamount.value;
	var get_price = frm_choice.productprice.value;
	var select_check = document.getElementById("selectcheck");
	var last_set = document.getElementById("lastset");
	var check = "", last = "";
	
	if (frm_choice.selectcolor.value == "" || frm_choice.selectsize.value == "" || frm_choice.selectamount.value == "") {
		alert("옵션을 선택해주세요.");
	} else if (frm_choice.selectamount.value == 0) {
		alert("해당 상품은 품절입니다. 선택할 수 없습니다.");
	} else {
		check = select_color + " / " + select_size + " / " + select_amount;
		select_check.innerHTML = check;
		last_set.innerHTML = get_price * select_amount + "원";
		frm_choice.temp_yn_applychoice.value = "y";
	}
}

function submit_pd_order(frm_choice) {
	var temp = frm_choice.temp_yn_applychoice.value;
	if (temp == "y") {
		document.frm_choice.action = "order_process.jsp";
		document.frm_choice.submit();
	} else if (temp == "n") {
		alert("적용을 눌러주세요.");
	}
}

function submit_pd_cart(frm_choice) {
	var temp = frm_choice.temp_yn_applychoice.value;
	if (temp == "y") {
		document.frm_choice.action = "order_cart_proc.jsp";
		document.frm_choice.submit();
	} else if (temp == "n") {
		alert("적용을 눌러주세요.");
	}
}

function submit_add_review() {
	document.frm_review_make.action = "product_detail_proc.jsp";
	document.frm_review_make.submit();
}

function option_selectcolor(val) {
	if (val == "") {
		alert("색상을 선택해주세요.");
		document.frm_choice.action = "product_detail.jsp";
		document.frm_choice.submit();
	} else {
		document.frm_choice.action = "product_detail.jsp";
		document.frm_choice.submit();
	}
}

function option_selectsize(val) {
	if (val == "") {
		alert("사이즈를 선택해주세요.");
		document.frm_choice.action = "product_detail.jsp";
		document.frm_choice.submit();
	} else {
		document.frm_choice.action = "product_detail.jsp";
		document.frm_choice.submit();
	}
}

function option_selectamount(val) {
	if (val == "") {
		alert("수량을 선택해주세요.");
		document.frm_choice.action = "product_detail.jsp";
		document.frm_choice.submit();
	} else {
		document.frm_choice.action = "product_detail.jsp";
		document.frm_choice.submit();
	}
}
</script>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="product_detail">
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery("select * from products where p_id = '" + p_id + "'");
	if (rs.next()) {
		getprice = rs.getInt("p_price") * ((100 - rs.getInt("p_discount")) / 100);
		getpoint = getprice / 100;
		
		product_img1 = rs.getString("p_desc");
		product_img2 = rs.getString("p_img2");
		product_img3 = rs.getString("p_img3");
	}
%>
	<div id="product_thumb_option">
		<div id="product_thumbnail">
			<img src="<%=rs.getString("p_img1") %>" width="750" height="600" />
		</div>
		<!-- 상품 옵션 선택 시작 -->
		<div id="product_option_select">
			<form name="frm_choice" method="post" id="frm_choice">
			<input type="hidden" name="p_id" value="<%=p_id %>" />
			<input type="hidden" name="ctype" value="in" />
			<input type="hidden" name="productprice" value=<%=getprice %> />
			<input type="hidden" name="temp_yn_applychoice" value="<%=temp_yn_applychoice %>" />
				<table id="tbl_frm_choice">
					<tr>
						<td class="fc_phead" colspan="2"><%=rs.getString("p_title") %></td>
					</tr>
					<tr>
						<td class="fc_head">가격</td>
						<td class="fc_val"><%=getprice %>원</td>
					</tr>
					<tr>
						<td class="fc_head">적립포인트</td>
						<td class="fc_val"><%=getpoint %>P</td>
					</tr>
					<tr>
						<td class="fc_head">색상</td>
						<td class="fc_val">
							<select name="selectcolor" onchange="option_selectcolor(this.value)">
								<option value="" > -- 선택 -- </option>
							<%
								rs.close();
								rs = stmt.executeQuery(query_choicecolor);
								if (rs.next())	{
									do {
										choicecolor = rs.getString("po_color");
										%>
										<option value="<%=choicecolor %>"<%=(s_color.equals(choicecolor)) ? " selected = 'selected'" : "" %>><%=choicecolor %></option>
										<%
									} while(rs.next());
								}
								rs.close();
							%>
							</select>
						</td>
					</tr>
					<tr>
						<td class="fc_head">사이즈</td>
						<td class="fc_val">
							<select name="selectsize" onchange="option_selectsize(this.value)">
								<option value=""> -- 선택 -- </option>
							<%
								if (!s_color.equals("")) {
									rs = stmt.executeQuery(query_choicesize);
									if (rs.next())	{
										do {
											choicesize = rs.getString("po_size");
											%>
											<option value="<%=choicesize %>"<%=(s_size.equals(choicesize)) ? " selected = 'selected'" : "" %>><%=choicesize %></option>
											<%
										} while(rs.next());
									}
									rs.close();
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<td class="fc_head">수량</td>
						<td class="fc_val">
							<select name="selectamount" onchange="option_selectamount(this.value)">
								<option value=""> -- 선택 -- </option>
							<%
								if (!s_color.equals("") && !s_size.equals("")) {
									rs = stmt.executeQuery(query_choicestock);
									if (rs.next())	{
										choicestock = rs.getInt("po_stock");
										if (choicestock == 0) {
											%>
											<option value="0" selected = 'selected'>품절</option>
											<%
										} else if (choicestock != 0) {
											for (int i = 1 ; i <= choicestock ; i++) {
												%>
												<option value="<%=i %>"<%=(s_amount.equals(i + "")) ? " selected = 'selected'" : "" %>><%=i %></option>
												<%
										 	}
										}
									}
									rs.close();
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<td class="fc_apl" colspan="2">
							<input type="button" value="적용" onclick="applychoice(this.form);" />
							<!-- <input type="image" src="images/btn_select.jpg" width="150" height="30" onclick="applychoice(this.form);" /> -->
						</td>
					</tr>
					<tr>
						<td class="fc_head">선택한 색상/사이즈/수량</td>
						<td class="fc_val"><span id="selectcheck"></span></td>
					</tr>
					<tr>
						<td class="fc_head">총 상품금액</td>
						<td class="fc_val"><span id="lastset"></span></td>
					</tr>
					<tr>
						<td class="fc_deli" colspan="2" align="center">50,000원 이상 구매시 무료배송</td>
					</tr>
					<tr>
						<td class="fc_buy"><input type="image" src="images/bar_buyitnow.jpg" width="150" height="50" onclick="submit_pd_order(this.form)" /></td>
						<td class="fc_cart"><input type="image" src="images/bar_addtocart.jpg" width="150" height="50" onclick="submit_pd_cart(this.form)" /></td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 상품 옵션 선택 종료 -->
	</div>
	<div id="product_detail_img">
	<%
		if (product_img1 != null) out.println("<img src='" + product_img1 + "' />");
		if (product_img2 != null) out.println("<img src='" + product_img2 + "' />");
		if (product_img3 != null) out.println("<img src='" + product_img3 + "' />");
	%>
	</div>
	<div id="review_grade">
		<%
			rs = stmt.executeQuery(query_grade_count);
			if (rs.next())	grade_count = rs.getInt("cnt");
			rs.close();
			rs = stmt.executeQuery(query_grade_score_total);
			if (rs.next())	{
				grade_score_total = rs.getString("grade");
				if (grade_score_total != null) grade_score_total = grade_score_total.substring(0, 3);
			}
			rs.close();
			rs = stmt.executeQuery(query_grade_score_1);
			if (rs.next())	grade_score_1 = rs.getInt("cnt");
			rs.close();
			rs = stmt.executeQuery(query_grade_score_2);
			if (rs.next())	grade_score_2 = rs.getInt("cnt");
			rs.close();
			rs = stmt.executeQuery(query_grade_score_3);
			if (rs.next())	grade_score_3 = rs.getInt("cnt");
			rs.close();
			rs = stmt.executeQuery(query_grade_score_4);
			if (rs.next())	grade_score_4 = rs.getInt("cnt");
			rs.close();
			rs = stmt.executeQuery(query_grade_score_5);
			if (rs.next())	grade_score_5 = rs.getInt("cnt");
			rs.close();
			
			if (grade_count != 0) {
				width_stick_grade1 = 500 * grade_score_1 / grade_count;
				width_stick_grade2 = 500 * grade_score_2 / grade_count;
				width_stick_grade3 = 500 * grade_score_3 / grade_count;
				width_stick_grade4 = 500 * grade_score_4 / grade_count;
				width_stick_grade5 = 500 * grade_score_5 / grade_count;
			}
		%>
		<table id="tbl_review_grade">
			<tr>
				<td class="grade_score_total" rowspan="4">
				<%
					if (grade_score_total != null) out.println(grade_score_total);
					else if (grade_score_total == null) out.println("0");
				%>
				</td>
				<td class="grade_score">5 stars</td>
				<td class="grade_stick"><img src="images/grade_stick.jpg" width="<%=width_stick_grade5 %>" height="20" /></td>
				<td class="grade_people_count">(<%=grade_score_5 %>)</td>
			</tr>
			<tr>
				<td class="grade_score">4 stars</td>
				<td class="grade_stick"><img src="images/grade_stick.jpg" width="<%=width_stick_grade4 %>" height="20" /></td>
				<td class="grade_people_count">(<%=grade_score_4 %>)</td>
			</tr>
			<tr>
				<td class="grade_score">3 stars</td>
				<td class="grade_stick"><img src="images/grade_stick.jpg" width="<%=width_stick_grade3 %>" height="20" /></td>
				<td class="grade_people_count">(<%=grade_score_3 %>)</td>
			</tr>
			<tr>
				<td class="grade_score">2 stars</td>
				<td class="grade_stick"><img src="images/grade_stick.jpg" width="<%=width_stick_grade2 %>" height="20" /></td>
				<td class="grade_people_count">(<%=grade_score_2 %>)</td>
			</tr>
			<tr>
				<td class="grade_score_count"><%=grade_count %>개 리뷰 평점</td>
				<td class="grade_score">1 stars</td>
				<td class="grade_stick"><img src="images/grade_stick.jpg" width="<%=width_stick_grade1 %>" height="20" /></td>
				<td class="grade_people_count">(<%=grade_score_1 %>)</td>
			</tr>
		</table>
	</div>
	<div id="review_make">
	<!-- 리뷰 게시판 시작 -->
		<!-- 리뷰 작성 시작 -->
		<form name="frm_review_make" method="post" id="frm_review_make" enctype="multipart/form-data">
		<input type="hidden" name="p_id" value="<%=p_id %>" />
		<input type="hidden" name="wtype" value="rin" />
			<table id="tbl_review_make">
				<tr>
					<td colspan="3" class="tbl_td_addcontent"><textarea name="tbl_rm_contents" id="tbl_rm_contents"></textarea></td>
				</tr>
				<tr>
					<td class="tbl_td_addpicture">
						<!-- <a href="#">+ 사진추가</a> -->
						<!-- <input type="image" src="images/btn_addpicture.jpg" width="150" height="25" onclick="submit_add_review()" /> -->
						<input type="file" name="fileName1" id="fileName1" />
					</td>
					<td class="tbl_td_addgrade">
						<select name="tbl_add_review_grade">
								<option value="5">★★★★★ 아주 좋아요</option>
								<option value="4">★★★★☆ 맘에 들어요</option>
								<option value="3">★★★☆☆ 보통이에요</option>
								<option value="2">★★☆☆☆ 그냥 그래요</option>
								<option value="1">★☆☆☆☆ 별로에요</option>
						</select>
					</td>
					<td class="tbl_td_addreview">
						<!-- <a href="#">@ 리뷰 등록하기</a> -->
						<input type="image" src="images/btn_addreview.jpg" width="150" height="25" onclick="submit_add_review()" />
					</td>
				</tr>
			</table>
		</form>
		<!-- 리뷰 작성 종료 -->
		<!-- 리뷰 보여주기 시작 -->
		<%
		//sql = "select pr_idx, pr_img, pr_contents, pr_grade, pr_date, m_name from productsreview pr, member m where pr.m_id = m.m_id and p_id = 'PL1';";
		String query_add_review = "select pr_idx, pr_img, pr_contents, pr_grade, pr_date, m_name";
		query_add_review += " from productsreview pr, member m where pr.m_id = m.m_id and p_id = '" + p_id + "' order by pr_idx desc";
		String query_review_count = "select count(*) cnt from productsreview where p_id='" + p_id + "'";
				
		String temp_pr_img = "";
		int pr_grade = 0, review_count = 0;
		
		rs = stmt.executeQuery(query_review_count);
		if (rs.next())	review_count = rs.getInt("cnt");
		rs.close();
		
		int result_update_reviewcnt = stmt.executeUpdate("update products set p_reviewcnt = " + review_count + " where p_id = '" + p_id + "'");
		if (result_update_reviewcnt != 0) {
			System.out.println("reviewcnt_update => 실행완료");
		} else {
			System.out.println("reviewcnt_update => 실행안됨");
		}
		
		rs = stmt.executeQuery(query_add_review);
		%>
		<%
		if (rs.next()) {
			pr_grade = rs.getInt("pr_grade");
		%>
		<form name="frm_review_count" method="post" id="frm_review_count">
			<table id="tbl_review_count">
				<tr>
					<td class="tbl_rc_view">리뷰(<%=review_count %>)</td>
				</tr>
			</table>
		</form>
		<table id="tbl_review_show">
		<%
			do {
				temp_pr_img = rs.getString("pr_img");
				if (temp_pr_img == null) temp_pr_img = "";
			%>
			<tr class="tbl_tr_grade">
				<td colspan="2" class="tbl_rs_content">
					<% if (rs.getInt("pr_grade") == 5) {
						out.println("★★★★★  - 아주 좋아요");
					} else if (rs.getInt("pr_grade") == 4) {
						out.println("★★★★☆  - 맘에 들어요");
					} else if (rs.getInt("pr_grade") == 3) {
						out.println("★★★☆☆  - 보통이에요");
					} else if (rs.getInt("pr_grade") == 2) {
						out.println("★★☆☆☆  - 그냥 그래요");
					} else if (rs.getInt("pr_grade") == 1) {
						out.println("★☆☆☆☆  - 별로에요");
					}
					%>
				</td>
			</tr>
			<tr>
				<td rowspan="4" class="tbl_rs_con_contents"><pre><%=rs.getString("pr_contents") %></pre></td>
				<td class="tbl_rs_writer_head">작성자</td>
			</tr>
			<tr>
				<td class="tbl_rs_writer_body"><%=rs.getString("m_name") %></td>
			</tr>
			<tr>
				<td class="tbl_rs_date_head">작성일</td>
			</tr>
			<tr>
				<td class="tbl_rs_date_body"><%=rs.getString("pr_date").substring(0, 10) %></td>
			</tr>
			<tr>
				<td colspan="2" class="tbl_rs_image">
				<% if (temp_pr_img.equals("")) { %>

				<% } else { %>
					<input type="image" src="<%=temp_pr_img %>" width="80" height="80" />
				<% } %>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="tbl_rs_reply">댓글을 작성해주세요 || 이 리뷰 어떠신가요?</td>
			</tr>
			<%
			} while(rs.next());
		%>
		</table>
		<%
		}
		rs.close();
		%>
		<!-- 리뷰 보여주기 종료 -->
	<!-- 리뷰 게시판 종료 -->
	</div>
	<div id="qna_view">
	<% /* %>
	<%
		String tmpPage = request.getParameter("cpage");
		// 현재 페이지번호와 검색 조건을 받는 부분으로 게시판 전체에서 달고 다녀야 하는 쿼리스트링 값

		String where = "";	// 검색 조건을 저장하기 위한 변수
		String args = "";	// 쿼리스트링을 저장하기 위한 변수

		// 페이지 번호 설정(페이지 번호는 게시판 전체에서 필수요소로 사용됨)
		int cpage = 1, psize = 10, bsize = 10, sidx = 0;
		// cpage : 현재 페이지번호, psize : 페이지크기, bsize : 블록크기, sidx : limit의 시작인덱스
		if (tmpPage == null || tmpPage.equals("")) {	// 현재 페이지번호가 없을 경우 무조건 1페이지로 셋팅
			cpage = 1;
		} else {	// 현재 페이지번호가 있을 경우 정수로 형변환함(여러 계산에서 사용되기도 하며, 인젝션(injection) 공격을 막기 위한 조치)
			cpage = Integer.valueOf(tmpPage);
		}
		sidx = (cpage - 1) * psize;	// limit의 시작인덱스
	%>
		<form name="frm_qna_view" method="post">
			<table width="800" id="tbl_qna_view">
				<tr>
					<th class="tbl_qv_num">번호</th>
					<th class="tbl_qv_cate">문의유형</th>
					<th class="tbl_qv_title">제목</th>
					<th class="tbl_qv_writer">작성자</th>
					<th class="tbl_qv_date">작성일</th>
				</tr>
			<%
				int num = 0;
				rs = stmt.executeQuery("select count(*) from boardqna " + where);
				if (rs.next()) { num = rs.getInt(1); }
				rs.close();
				
				String sql = "select bq_idx,  ";
				sql += " order by f_idx desc limit " + sidx + ", " + psize;
				rs = stmt.executeQuery(sql);
				String title, date, linkHead = "", linkTail = "", reply = "";
				if (rs.next()) {	// 검색된 게시물이 있으면
					int lastPage = (num - 1) / psize + 1;	// 마지막 페이지 번호
					num = num - (cpage - 1) * psize;	// 게시물 개수 번호
					do {
						linkHead = "<a href='free_read.jsp?cpage=" + cpage + args + "&idx=" + rs.getInt("f_idx") + "'>";
						if (rs.getString("f_title").length() > 28) {
						// 제목이 28자를 넘으면(제목이 너무 길어서 두줄로 나올 상황이면 자른 후 말줄임표를 붙여줌)
							title = rs.getString("f_title").substring(0, 28) + "...";
						} else {
							title = rs.getString("f_title");
						}
						
						// 댓글의 개수를 구하는 것은 중요한 것이 아니다.
						// 정석대로(중요한 값)라면 루프문 안에서 쿼리를 실행할 때마다 count(*)를 하여 갯수를 구해야 한다.
						// 루프의 실행횟수만큼 쿼리가 실행되기 때문에, 부하가 걸리게된다.
						// 중요한 것이라면 부하가 걸리더라도, 루프문안에서 쿼리를 실행하여 카운트를 해야한다. 이것이 정석.
						// 그러나 중요하지 않기 때문에, brd_free 테이블에 컬럼으로 추가하여 갯수를 구한다.
						// 정석과는 반하지만 효율적으로는 훨씬 좋다. 꼭 정석이 효율적이진 않기 때문에, 중요하지 않은 기능은 효율을 우선한다.
						
						reply = "";
						if (rs.getInt("f_reply") > 0) {	// 댓글이 하나라도 있으면
							reply = "<span class='reply'>[" + rs.getInt("f_reply") + "]</span>";
						}
						
						date = rs.getString("f_date").substring(2, 10).replace('-', '.');
						// '2018-05-02 12:33:00.0'을 '18.05.02'로 보이게 만드는 작업임 
			%>
				<tr align="center">
					<td><%=num %></td>
					<td align="left">&nbsp;<%=linkHead + title %></a><%=reply %></td>
					<td><%=rs.getString("f_writer") %></td>
					<td><%=date %></td>
					<td><%=rs.getInt("f_read") %></td>
				</tr>
			<%
						num--;
					} while (rs.next());
			%>
			</table>
		</form>
		<% */ %>
	</div>
	<div id="delivery_exchange">
		<table id="tbl_delivery_exchange">
			<tr>
				<td class="tbl_de_head_deli">배송 안내</td>
				<td class="tbl_de_head_exc">교환/환불 안내</td>
			</tr>
			<tr>
				<td class="tbl_de_contents_deli">
				- 배송기간은 결제 확인 후 1 ~ 3일 정도 소요됩니다.<br />
				  &nbsp;&nbsp;(주말, 공휴일 제외)<br /><br />
			
				- 주문 시 상품 합계 금액이 50,000원 이상은 무료배송이며,<br />
				  &nbsp;&nbsp;미만일 경우 2,500원의 배송비가 추가 됩니다.<br /><br />
			
				- 제주도 및 도서 산간 지역은 따로 추가 운임비가 없으며,<br />
				  &nbsp;&nbsp;배송기간이 1~2일 정도 추가로 소요됩니다.<br /><br />
			
				- 주문폭주, 입고지연, 배송업체 또는 생산업체 문제 등으로<br />
				  &nbsp;&nbsp;예기치 않게 지연, 품절이 될 경우 개별 연락을 드립니다.<br />
				</td>
				<td class="tbl_de_contents_exc">
				- 상품 수령일로부터 7일 이내에 교환/반품이 가능합니다.<br />
				  &nbsp;&nbsp;(게시판 또는 고객센터(1544-2767)를 통해 접수해주시면 됩니다.)<br /><br />
					  
				- 상품 불량/오배송으로 인한 교환/반품의 경우<br />
				  &nbsp;&nbsp;동일상품으로 무상교환 해드리며, 전액 환불이 가능합니다.<br /><br />
				  
				- 아래의 사유는 교환/반품이 불가합니다.<br />
				  &nbsp;&nbsp;&nbsp;&nbsp;1. 제품을 훼손한 경우<br />
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(제품을 확인하기 위해 포장 훼손한 경우는 제외)<br />
				  &nbsp;&nbsp;&nbsp;&nbsp;2. 사용 및 시간의 경과로 상품의 가치가 현저히 감소한 경우<br />
				  &nbsp;&nbsp;&nbsp;&nbsp;3. 복제가 가능한 제품의 포장을 훼손한 경우<br /><br />
			
				- 반품주소 : 서울시 XX구 XX로 XX-X 소녀시대<br />
				  &nbsp;&nbsp;반품요청 : XX택배(XXXX-XXXX)<br />		 	
				</td>
			</tr>
		</table>
	</div>
	</form>
</div>
<%
System.out.println("[3-1] query_grade_score_total : " + query_grade_score_total);
System.out.println("[3-2] grade_score_1 : " + grade_score_1 + " / grade_score_2 : " + grade_score_2 + " / grade_score_3 : " + grade_score_3);
System.out.println("[3-3] grade_score_4 : " + grade_score_4 + " / grade_score_5 : " + grade_score_5);
System.out.println("[3-4] width_stick_grade1 : " + width_stick_grade1 + " / width_stick_grade2 : " + width_stick_grade2 + " / width_stick_grade3 : " + width_stick_grade3);
System.out.println("[3-5] width_stick_grade4 : " + width_stick_grade4 + " / width_stick_grade5 : " + width_stick_grade5);
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
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>
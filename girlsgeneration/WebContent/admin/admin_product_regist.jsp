<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_admin_html_header.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);
String p_id = request.getParameter("p_id");

String regist_cate_big = "", regist_cate_medium = "", regist_newbest = "", regist_post = "";

regist_cate_big = request.getParameter("regist_cate_big");
regist_cate_medium = request.getParameter("regist_cate_medium");
regist_newbest = request.getParameter("registnb");
regist_post = request.getParameter("postornot");

String choice_cm_idx = "", choice_cm_title = "";
String query_product_modify = "";

if (p_id == null || p_id.equals("")) {
	p_id = "";
} else {

}
if (regist_cate_big == null || regist_cate_big.equals("")) {
	regist_cate_big = "";
} else {

}
if (regist_cate_medium == null || regist_cate_medium.equals("")) {
	regist_cate_medium = "";
} else {

}
if (regist_newbest == null || regist_newbest.equals("")) {
	regist_newbest = "";
} else {

}
if (regist_post == null || regist_post.equals("")) {
	regist_post = "";
} else {

}

query_product_modify = "select * from products_option";

System.out.println("[1-1] regist_cate_big : " + regist_cate_big + " / regist_cate_medium : " + regist_cate_medium + " / regist_newbest : " + regist_newbest);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록 페이지</title>
<link rel="stylesheet" type="text/css" href="css/admin_product.css" />
<script>
function regist_select_cate_big(val) {
	document.frm_product_regist.action = "admin_product_regist_proc.jsp";
	document.frm_product_regist.submit();
}

function regist_select_cate_medium(val) {
	document.frm_product_regist.action = "admin_product_regist.jsp";
	document.frm_product_regist.submit();
}

function submit_add_product() {
	document.frm_product_regist.action = "admin_product_regist_proc.jsp";
	document.frm_product_regist.submit();
}

var cb1 = new Array();
cb1[0] = new Option("", "-- 중분류명 --");
cb1[1] = new Option("1", "일반");
cb1[2] = new Option("2", "오픈토");
cb1[3] = new Option("3", "통굽/가보시");

var cb2 = new Array();
cb2[0] = new Option("", "-- 중분류명 --");
cb2[1] = new Option("4", "플랫슈즈");
cb2[2] = new Option("5", "로퍼");
cb2[3] = new Option("6", "오픈토");

var cb3 = new Array();
cb3[0] = new Option("", "-- 중분류명 --");
cb3[1] = new Option("7", "스니커즈");
cb3[2] = new Option("8", "슬립온");
cb3[3] = new Option("9", "런닝슈즈");

var cb4 = new Array();
cb4[0] = new Option("", "-- 중분류명 --");
cb4[1] = new Option("10", "샌들");
cb4[2] = new Option("11", "웨지");
cb4[3] = new Option("12", "슬리퍼/쪼리");

var cb5 = new Array();
cb5[0] = new Option("", "-- 중분류명 --");
cb5[1] = new Option("13", "일반");
cb5[2] = new Option("14", "오픈토");
cb5[3] = new Option("15", "통굽/가보시");

function setCata(obj, target) {
	var x = obj.value;

	for (m = target.options.length - 1; m > 0 ; m--)
		target.options[m] = null;

	if (x != "") {
		selectedArray = eval("cb" + x);
		for (i = 0 ; i < selectedArray.length ; i++) 
			target.options[i] = new Option(selectedArray[i].value, selectedArray[i].text);
			
		target.options[0].selected = true;
	}
}

</script>
</head>
<body>
<div id="product_regist">
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();

%>
	<form method="post" name="frm_product_regist" id="frm_product_regist" enctype="multipart/form-data">
	<input type="hidden" name="wtype" value="in" />
	<div id="pr_main">
		<table id="tbl_pr_main">
			<tr><td>&nbsp;&nbsp;PRODUCT REGIST&nbsp;&nbsp;</td></tr>
		</table>
	</div>
	<div id="pr_basic">
		<table id="tbl_pr_basic">
			<tr>
				<td colspan="2" class="tbl_pr_headertitle">기본정보</td>
			</tr>
			<tr>
				<td width="200" class="tbl_pr_header">카테고리선택</td>
				<td width="*" class="tbl_pr_basic_category">
					<select name="regist_cate_big" onChange="setCata(this, this.form.regist_cate_medium);">
						<option value="">-- 대분류명 --</option>
						<option value="1">HEEL/PUMPS</option>
						<option value="2">LOAFER/FLAT</option>
						<option value="3">SNEAKERS</option>
						<option value="4">SANDAL</option>
						<option value="5">BOOTS/WALKER</option>
					</select>
					<select name="regist_cate_medium">
						<option value="">-- 중분류명 --</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="tbl_pr_header">NEW/BEST 여부</td>
				<td>
					<input type="radio" name="registnb" value="n" />NEW&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="registnb" value="b" />BEST&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="registnb" value="x" />NONE
				</td>
			</tr>
			<tr>
				<td class="tbl_pr_header">제목명</td>
				<td><input type="text" width="300" name="product_title" class="product_title" /></td>
			</tr>
			<tr>
				<td class="tbl_pr_header">게시여부</td>
				<td>
					<input type="radio" name="postornot" value="Y" />예&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="postornot" value="N" />아니오
				</td>
			</tr>
			<tr>
				<td class="tbl_pr_header">굽높이</td>
				<td><input type="text" width="300" name="heelheight" class="heel_height" />&nbsp;cm</td>
			</tr>
			<tr>
				<td class="tbl_pr_header">발매일</td>
				<td>
					<select name="releaseyear">
					<% for (int i = 2000 ; i <= year ; i++ ) { %>
						<option value="<%=i %>"><%=i %></option>
					<% } %>
					</select>&nbsp;년&nbsp;&nbsp;
					<select name="releasemonth">
					<% for (int i = 1 ; i <= 12 ; i++ ) { %>
						<option value="<%=i %>"><%=i %></option>
					<% } %>
					</select>&nbsp;월&nbsp;&nbsp;
					<select name="releaseday">
					<% for (int i = 1; i <= 31 ; i++ ) { %>
						<option value="<%=i %>"><%=i %></option>
					<% } %>
					</select>&nbsp;일
				</td>
			</tr>
		</table>
	</div>
	<div id="pr_price">
		<table id="tbl_pr_price">
			<tr>
				<td colspan="2" class="tbl_pr_headertitle">가격정보</td>
			</tr>
			<tr>
				<td width="200" class="tbl_pr_header">정가</td>
				<td width="*"><input type="text" name="sell_price" class="sell_price" />&nbsp;원</td>
			</tr>
		</table>
	</div>
	<div id="pr_stock">
		<table id="tbl_pr_stock">
			<tr>
				<td colspan="3" class="tbl_pr_headertitle">재고등록</td>
			</tr>
			<tr>
				<td width="200" class="tbl_pr_header">색상</td>
				<td width="*" class="tbl_pr_header">사이즈 / 재고</td>
				<td width="100" class="tbl_pr_btn"><input type="button" name="add_product" value="추가" onclick="" /></td>
			</tr>
			<tr>
				<td class="tbl_pr_btn">
					<select name="option_color">
						<option value="">-- 색상선택 --</option>
						<option value="black">black</option>
						<option value="blue">blue</option>
						<option value="red">red</option>
						<option value="white">white</option>
						<option value="yellow">yellow</option>
					</select>
				</td>
				<td>
					210&nbsp;<input type="text" name="stock_210" class="stock_size" value="0" />&nbsp;&nbsp;
					215&nbsp;<input type="text" name="stock_215" class="stock_size" value="0" />&nbsp;&nbsp;
					220&nbsp;<input type="text" name="stock_220" class="stock_size" value="0" />&nbsp;&nbsp;
					225&nbsp;<input type="text" name="stock_225" class="stock_size" value="0" />&nbsp;&nbsp;
					230&nbsp;<input type="text" name="stock_230" class="stock_size" value="0" />&nbsp;&nbsp;
					235&nbsp;<input type="text" name="stock_235" class="stock_size" value="0" />&nbsp;&nbsp;<br />
					240&nbsp;<input type="text" name="stock_240" class="stock_size" value="0" />&nbsp;&nbsp;
					245&nbsp;<input type="text" name="stock_245" class="stock_size" value="0" />&nbsp;&nbsp;
					250&nbsp;<input type="text" name="stock_250" class="stock_size" value="0" />&nbsp;&nbsp;
					255&nbsp;<input type="text" name="stock_255" class="stock_size" value="0" />&nbsp;&nbsp;
					260&nbsp;<input type="text" name="stock_260" class="stock_size" value="0" />&nbsp;&nbsp;
				</td>
				<td class="tbl_pr_btn"><input type="button" name="deleteproduct" value="삭제" onclick="" /></td>
			</tr>
		</table>
	</div>
	<div id="pr_image">
		<table id="tbl_pr_image">
			<tr>
				<td colspan="2" class="tbl_pr_headertitle">상품 이미지 등록</td>
			</tr>
			<tr>
				<td width="200" class="tbl_pr_header">상품이미지1</td>
				<td width="*"><input type="file" name="pr_image_fileName1" id="pr_image_fileName1" /> * 상품이미지1은 필수입니다.</td>
			</tr>
			<tr>
				<td class="tbl_pr_header">상품이미지2</td>
				<td><input type="file" name="pr_image_fileName2" id="pr_image_fileName2" /></td>
			</tr>
			<tr>
				<td class="tbl_pr_header">상품이미지3</td>
				<td><input type="file" name="pr_image_fileName3" id="pr_image_fileName3" /></td>
			</tr>
			<tr>
				<td class="tbl_pr_header">상품 설명이미지</td>
				<td><input type="file" name="pr_desc_image_fileName" id="pr_desc_image_fileName" /></td>
			</tr>
		</table>
	</div>
	<div id="pr_regist">
		<table id="tbl_pr_regist">
			<tr>
				<td>
					<input type="button" value="상품등록" onclick="submit_add_product()" />&nbsp;&nbsp;
					<input type="reset" value="다시입력" />&nbsp;&nbsp;
					<input type="button" value="취소" onclick="location.href='admin_product.jsp'" />
				</td>
			</tr>
		</table>
	</div>
	</form>
<%
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
</div>
</body>
</html>
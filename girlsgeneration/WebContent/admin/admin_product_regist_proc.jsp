<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ include file="inc_admin_header.jsp" %>
<%
String wtype = "", regist_cate_big = "", regist_cate_medium = "", registnb = "", product_title = "", postornot = "", heelheight = "";
String releaseyear = "", releasemonth = "", releaseday = "", sell_price = "", discount_rate = "", option_color = "";
String file1 = "", filename1 = "", orifilename1 = "", file2 = "", filename2 = "", orifilename2 = "";
String file3 = "", filename3 = "", orifilename3 = "", file4 = "", filename4 = "", orifilename4 = "";
String release_date = "";
String stock_210 = "", stock_215 = "", stock_220 = "", stock_225 = "", stock_230 = "", stock_235 = "";
String stock_240 = "", stock_245 = "", stock_250 = "", stock_255 = "", stock_260 = "";

String query_insert_product = "", query_insert_product_option_210 = "", query_insert_product_option_215 = "", query_insert_product_option_220 = "";
String query_insert_product_option_225 = "", query_insert_product_option_230 = "", query_insert_product_option_235 = "", query_insert_product_option_240 = "";
String query_insert_product_option_245 = "", query_insert_product_option_250 = "", query_insert_product_option_255 = "", query_insert_product_option_260 = "";

String uploadPath = "D:/kwj/jsp/study/girlsgeneration/WebContent/images_product";
int size = 10 * 1024 * 1024;

try {
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
	
	wtype = multi.getParameter("wtype");
	regist_cate_big = multi.getParameter("regist_cate_big");
	regist_cate_medium = multi.getParameter("regist_cate_medium");
	registnb = multi.getParameter("registnb");
	product_title = multi.getParameter("product_title");
	postornot = multi.getParameter("postornot");
	heelheight = multi.getParameter("heelheight");
	releaseyear = multi.getParameter("releaseyear");
	releasemonth = multi.getParameter("releasemonth");
	releaseday = multi.getParameter("releaseday");
	sell_price = multi.getParameter("sell_price");
	option_color = multi.getParameter("option_color");
	
	stock_210 = multi.getParameter("stock_210");
	stock_215 = multi.getParameter("stock_215");
	stock_220 = multi.getParameter("stock_220");
	stock_225 = multi.getParameter("stock_225");
	stock_230 = multi.getParameter("stock_230");
	stock_235 = multi.getParameter("stock_235");
	stock_240 = multi.getParameter("stock_240");
	stock_245 = multi.getParameter("stock_245");
	stock_250 = multi.getParameter("stock_250");
	stock_255 = multi.getParameter("stock_255");
	stock_260 = multi.getParameter("stock_260");
	
	Enumeration files = multi.getFileNames();
	file1 = (String)files.nextElement();
	filename1 = multi.getFilesystemName(file1);
	orifilename1 = multi.getOriginalFileName(file1);
	file2 = (String)files.nextElement();
	filename2 = multi.getFilesystemName(file2);
	orifilename2 = multi.getOriginalFileName(file2);
	file3 = (String)files.nextElement();
	filename3 = multi.getFilesystemName(file3);
	orifilename3 = multi.getOriginalFileName(file3);
	file4 = (String)files.nextElement();
	filename4 = multi.getFilesystemName(file4);
	orifilename4 = multi.getOriginalFileName(file4);
	
	if (regist_cate_big == null || regist_cate_big.equals("")) {
		regist_cate_big = "";
	} else {

	}
	if (regist_cate_medium == null || regist_cate_medium.equals("")) {
		regist_cate_medium = "";
	} else {

	}
	if (registnb == null || registnb.equals("")) {
		registnb = "";
	} else {

	}
	if (product_title == null || product_title.equals("")) {
		product_title = "";
	} else {

	}
	if (postornot == null || postornot.equals("")) {
		postornot = "";
	} else {

	}
	if (heelheight == null || heelheight.equals("")) {
		heelheight = "";
	} else {

	}
	if (releaseyear == null || releaseyear.equals("") || releasemonth == null || releasemonth.equals("") || releaseday == null || releaseday.equals("")) {
		releaseyear = "";
		releasemonth = "";
		releaseday = "";
	} else {
		if (Integer.parseInt(releasemonth) < 10) releasemonth = "0" + releasemonth;
		if (Integer.parseInt(releaseday) < 10) releaseday = "0" + releaseday;
		release_date = releaseyear + "-" + releasemonth + "-" + releaseday;
	}
	if (sell_price == null || sell_price.equals("")) {
		sell_price = "";
	} else {

	}
		
	if (filename1 == null || filename1.equals("") || orifilename1 == null || orifilename1.equals("")) {
		filename1 = "";
		orifilename1 = "";
	} else {
		filename1 = "images_product/" + filename1;
	}
	if (filename2 == null || filename2.equals("") || orifilename2 == null || orifilename2.equals("")) {
		filename2 = "";
		orifilename2 = "";
	} else {
		filename2 = "images_product/" + filename2;
	}
	if (filename3 == null || filename3.equals("") || orifilename3 == null || orifilename3.equals("")) {
		filename3 = "";
		orifilename3 = "";
	} else {
		filename3 = "images_product/" + filename3;
	}
	if (filename4 == null || filename4.equals("") || orifilename4 == null || orifilename4.equals("")) {
		filename4 = "";
		orifilename4 = "";
	} else {
		filename4 = "images_product/" + filename4;
	}
	
	if (option_color == null || option_color.equals("")) {
		option_color = "";
	} else {

	}
	if (stock_210 == null || stock_210.equals("")) {
		stock_210 = "0";
	} else {

	}
	if (stock_215 == null || stock_215.equals("")) {
		stock_215 = "0";
	} else {

	}
	if (stock_220 == null || stock_220.equals("")) {
		stock_220 = "0";
	} else {

	}
	if (stock_225 == null || stock_225.equals("")) {
		stock_225 = "0";
	} else {

	}
	if (stock_230 == null || stock_230.equals("")) {
		stock_230 = "0";
	} else {

	}
	if (stock_235 == null || stock_235.equals("")) {
		stock_235 = "0";
	} else {

	}
	if (stock_240 == null || stock_240.equals("")) {
		stock_240 = "0";
	} else {

	}
	if (stock_245 == null || stock_245.equals("")) {
		stock_245 = "0";
	} else {

	}
	if (stock_250 == null || stock_250.equals("")) {
		stock_250 = "0";
	} else {

	}
	if (stock_255 == null || stock_255.equals("")) {
		stock_255 = "0";
	} else {

	}
	if (stock_260 == null || stock_260.equals("")) {
		stock_260 = "0";
	} else {

	}
		
	System.out.println("[1-1] wtype : " + wtype + " / regist_cate_big : " + regist_cate_big + " / regist_cate_medium : " + regist_cate_medium);
	System.out.println("[1-2] registnb : " + registnb + " / product_title : " + product_title + " / postornot : " + postornot);
	System.out.println("[1-3] heelheight : " + heelheight + " / releaseyear : " + releaseyear + " / releasemonth : " + releasemonth + " / releaseday : " + releaseday);
	System.out.println("[1-4] sell_price : " + sell_price + " / option_color : " + option_color);
	System.out.println("[1-5] release_date : " + release_date);
	
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	int max_count = 0;
	rs = stmt.executeQuery("select max(p_idx) max_p_idx from products");
	if (rs.next())	{
		max_count = rs.getInt("max_p_idx") + 1;
	}
	rs.close();
	
	String max_count_string = "PL" + max_count;
	
	query_insert_product = "insert into products (p_id, p_title, cb_idx, cm_idx, p_isnewbest, p_price, p_height,";
	query_insert_product += " p_release, p_desc, p_img1, p_img2, p_img3, p_isview, p_regadmin)";
	query_insert_product += " values ('" + max_count_string + "', '" + product_title + "', '" + regist_cate_big + "', '" + regist_cate_medium + "', '" + registnb;
	query_insert_product += "', '" + sell_price + "', '" + heelheight + "', '" + release_date;
	query_insert_product += "', '" + filename3 + "', '" + filename4 + "', '" + filename2 + "', '" + filename1;
	query_insert_product += "', '" + postornot + "', 'admin');";
	
	query_insert_product_option_210 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_210 += " values ('" + max_count_string + "', '210', '" + option_color + "', '" + stock_210 + "') ";
	query_insert_product_option_215 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_215 += " values ('" + max_count_string + "', '215', '" + option_color + "', '" + stock_215 + "') ";
	query_insert_product_option_220 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_220 += " values ('" + max_count_string + "', '220', '" + option_color + "', '" + stock_220 + "') ";
	query_insert_product_option_225 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_225 += " values ('" + max_count_string + "', '225', '" + option_color + "', '" + stock_225 + "') ";
	query_insert_product_option_230 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_230 += " values ('" + max_count_string + "', '230', '" + option_color + "', '" + stock_230 + "') ";
	query_insert_product_option_235 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_235 += " values ('" + max_count_string + "', '235', '" + option_color + "', '" + stock_235 + "') ";
	query_insert_product_option_240 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_240 += " values ('" + max_count_string + "', '240', '" + option_color + "', '" + stock_240 + "') ";
	query_insert_product_option_245 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_245 += " values ('" + max_count_string + "', '245', '" + option_color + "', '" + stock_245 + "') ";
	query_insert_product_option_250 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_250 += " values ('" + max_count_string + "', '250', '" + option_color + "', '" + stock_250 + "') ";
	query_insert_product_option_255 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_255 += " values ('" + max_count_string + "', '255', '" + option_color + "', '" + stock_255 + "') ";
	query_insert_product_option_260 = "insert into products_option (p_id, po_size, po_color, po_stock)";
	query_insert_product_option_260 += " values ('" + max_count_string + "', '260', '" + option_color + "', '" + stock_260 + "') ";
	
	if (wtype.equals("in")) {
		int result = stmt.executeUpdate(query_insert_product);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			int result_210 = stmt.executeUpdate(query_insert_product_option_210);
			int result_215 = stmt.executeUpdate(query_insert_product_option_215);
			int result_220 = stmt.executeUpdate(query_insert_product_option_220);
			int result_225 = stmt.executeUpdate(query_insert_product_option_225);
			int result_230 = stmt.executeUpdate(query_insert_product_option_230);
			int result_235 = stmt.executeUpdate(query_insert_product_option_235);
			int result_240 = stmt.executeUpdate(query_insert_product_option_240);
			int result_245 = stmt.executeUpdate(query_insert_product_option_245);
			int result_250 = stmt.executeUpdate(query_insert_product_option_250);
			int result_255 = stmt.executeUpdate(query_insert_product_option_255);
			int result_260 = stmt.executeUpdate(query_insert_product_option_260);
			
			System.out.println("wtype:in => 실행완료");
			out.println("<script>");
			out.println("location.replace('admin_product.jsp');");
			out.println("</script>");
		} else {	// 쿼리의 실행결과가 레코드 하나라도 적용이 안되었다면
			System.out.println("wtype:in => 쿼리실행안됨");
			out.println("<script>");
			out.println("location.replace('../main.jsp');");
			out.println("</script>");
		}
	} else {	// 잘못 들어왔을 경우
		System.out.println("wtype 자체를 먹지않음");
		out.println("<script>");
		out.println("location.replace('../main.jsp');");
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




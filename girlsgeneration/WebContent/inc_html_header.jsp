<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css" href="css/layout.css" />
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/order.css" />
<link rel="stylesheet" type="text/css" href="css/board.css" />
<link rel="stylesheet" type="text/css" href="css/member.css" />
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
/*
$(document).ready(function(){
    var ms = "";
    
    $(".header li", $(this)).bind('mouseover',function(){
        if(this.id == "my_l_1"){
            ms = ".my_u_1";
        }else if(this.id == "my_l_2"){
            ms = ".my_u_2";
        }else if(this.id == "my_l_3"){
            ms = ".my_u_3";
        }
    });
    
    $(".header li",$(this)).hover(
        function(){
            $(ms).addClass('show');
        },
        function(){
            $(ms).removeClass('show');    
        }
    )
});
*/
</script>
<%
String cartCountSql = "";
if (isLogin) {
	cartCountSql = "select count(*) from order_cart where m_id = '" + userId + "'";
} else {
	cartCountSql = "select count(*) from order_cart where m_id = '비회원'";
}


int cart_count = 0;
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(cartCountSql);
	if (rs.next()) cart_count = rs.getInt(1);
	
} catch(Exception e) {
	out.println("DB작업 오류");
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
<div id="header">
	<h1 class="logo"><a href="main.jsp"><img src="images/logo_gg4.png" /></a></h1>
	<ul class="my">
	     <li id="my_l_1"><a href="main.jsp"><img src="images/top_my_mypage.jpg" /></a>
	     	<ul class="my_u_1">
	     		<% if (!isLogin) { %>
	     		<li><a href="login_form.jsp">LOGIN</a></li>
	     		<li><a href="join_agree.jsp">JOIN</a></li>
	     		<% } else { %>
	     		<li><a href="logout.jsp">LOGOUT</a></li>
	     		<li><a href="info_check.jsp">MODIFY</a></li>
	     		<% } %>
	     		<li><a href="order_conf.jsp">ORDER</a></li>
	     		<li><a href="mypage.jsp">MYPAGE</a></li>
	     		<li><a href="membership.jsp">MEMBERSHIP</a></li>
	     	</ul>
	     </li>
	     <li id="my_l_2"><a href="order_cart.jsp"><img src="images/top_my_cart.jpg" />(<%=cart_count %>)</a>
	     </li>
	     <li id="my_l_3"><a href="main.jsp"><img src="images/top_my_community.jpg" /></a>
	     	<ul class="my_u_3">
	     		<li><a href="board_notice.jsp">NOTICE</a></li>
	     		<li><a href="board_faq.jsp">FAQ</a></li>
	     		<li><a href="board_qna.jsp">Q&A</a></li>
	     		<li><a href="board_review.jsp">REVIEW</a></li>
	     	</ul>
	     </li>
	     <% if (isLogin && userId.equals("admin")) { %>
	     <li id="my_l_4"><a href="admin/admin_main.jsp"><img src="images/gotoAdmin.png" /></a>
	     <% } %>
	</ul>
	<ul class="cate">
		<li><a href="product_newbest.jsp?nb=n"><img src="images/top_menu_new.jpg" /></a></li>
	  	<li><a href="product_newbest.jsp?nb=b"><img src="images/top_menu_best.jpg" /></a></li>
		<li><a href="product_list.jsp?cb=1"><img src="images/top_menu_heelpumps.jpg" /></a>
			<ul>
				<li><a href="product_list.jsp?cb=1&cm=1">일반</a></li>
				<li><a href="product_list.jsp?cb=1&cm=2">오픈토</a></li>
				<li><a href="product_list.jsp?cb=1&cm=3">통굽/가보시</a></li>
			</ul>
		</li>
		<li><a href="product_list.jsp?cb=2"><img src="images/top_menu_loaferflat.jpg" /></a>
			<ul>
				<li><a href="product_list.jsp?cb=2&cm=4">플랫슈즈</a></li>
				<li><a href="product_list.jsp?cb=2&cm=5">로퍼</a></li>
				<li><a href="product_list.jsp?cb=2&cm=6">오픈토</a></li>
			</ul>
		</li>
		<li><a href="product_list.jsp?cb=3"><img src="images/top_menu_sneakers.jpg" /></a>
			<ul id="sn">
				<li><a href="product_list.jsp?cb=3&cm=7">스니커즈</a></li>
				<li><a href="product_list.jsp?cb=3&cm=8">슬립온</a></li>
				<li><a href="product_list.jsp?cb=3&cm=9">런닝슈즈</a></li>
			</ul>
		</li>
		<li><a href="product_list.jsp?cb=4"><img src="images/top_menu_sandal.jpg" /></a>
			<ul id="sd">
				<li><a href="product_list.jsp?cb=4&cm=10">샌들</a></li>
				<li><a href="product_list.jsp?cb=4&cm=11">웨지</a></li>
				<li><a href="product_list.jsp?cb=4&cm=12">슬리퍼/쪼리</a></li>
			</ul>
		</li>
		<li><a href="product_list.jsp?cb=5"><img src="images/top_menu_bootswalker.jpg" /></a>
			<ul id="bw">
				<li><a href="product_list.jsp?cb=5&cm=13">일반</a></li>
				<li><a href="product_list.jsp?cb=5&cm=14">오픈토</a></li>
				<li><a href="product_list.jsp?cb=5&cm=15">통굽/가보시</a></li>
			</ul>
		</li>
	</ul>
</div>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_admin_header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/base.css" />
<link rel="stylesheet" type="text/css" href="../css/layout.css" />
<link rel="stylesheet" type="text/css" href="../css/reset.css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
a:link { color:black; text-decoration:none; }
a:visited { color:black; text-decoration:none; }
#menu { font-size:12px; }
</style>
</head>
<body>
<div id="header">
	<h1 class="logo"><a href="admin_main.jsp"><img src="../images/admin_main.png" /></a></h1>
	<ul class="my">
		<% if (!isLogin) { %>
	    <li id="my_l_1"><a href="../login_form.jsp"><img src="../images/admin_login.png" /></a></li>
	    <% } else { %>
	    <li id="my_l_2"><a href="../logout.jsp"><img src="../images/admin_logout.png" /></a></li>
	    <li id="my_l_3"><a href="../main.jsp"><img src="../images/gotoFront.png" /></a></li>
	    <% } %>
	</ul>
	<ul class="cate">
		<li><a href="admin_product.jsp"><img src="../images/admin_products.png" /></a></li>
		<li><a href="admin_order.jsp"><img src="../images/admin_order.png" /></a></li>
		<li><a href="admin_member.jsp"><img src="../images/admin_member.png" /></a></li>
		<li><a href="admin_board.jsp"><img src="../images/admin_board.png" /></a></li>
		<li><a href="#"><img src="../images/admin_stats.png" /></a></li>
	</ul>
</div>
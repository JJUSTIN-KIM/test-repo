<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp"%>
<% 
String isChk = request.getParameter("isChk");
%>
<form name="frm_ischk" method="post" action="order_multi_process.jsp">
<input type="hidden" name="isChk" value="<%=isChk %>" />
</form>
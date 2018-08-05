<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
/*
하나씩 지우고자 할 때
session.removeAttribute("userId");
session.removeAttribute("userName");
*/
%>

<script>
location.replace("admin_login_form.jsp");
</script>
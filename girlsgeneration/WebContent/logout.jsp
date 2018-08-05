<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
// session객체의 모든 속성을 삭제
%>
<script>
location.replace("main.jsp");
</script>

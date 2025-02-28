
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.mail.*" %>
<%@ page import="jakarta.mail.internet.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Random" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
</head>
<body>
<h2>비밀번호 찾기</h2>
<form action="<%=request.getContextPath() %>/member/SendTempPassword.do" method="get">
    <label for="email">아이디:</label>
    <input type="email" id="email" name="email" placeholder="아이디를 입력하세요." required><br><br>

    <button type="submit">임시 비밀번호 발급받기</button>
</form>

<%
    if (request.getAttribute("message") != null) {
        out.println("<p style='color: red;'>" + request.getAttribute("message") + "</p>");
    }
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.project.nadaum.member.model.vo.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
%>
<!DOCTYPE html>
<html>
<head>
    <title>결제 실패</title>
    <meta http equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="/stylesheets/style.css" />
</head>
<body>
<section>
    <h1>결제 실패</h1>
    <p>${message}</p>
    <span>에러코드: ${code}</span>
</section>
</body>
</html>
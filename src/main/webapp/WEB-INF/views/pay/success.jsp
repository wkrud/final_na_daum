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
<title>결제 성공</title>
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay/pay.css" />
</head>
<style>
div.pay-container{text-align:center;}
</style>
<body>
	<section>
		<div class="pay-container">
		<h1>결제 성공</h1>
		<h3>상품명: 나 다움 결제</h3>
		<h3>주문번호: ${orderId}</h3>
		</div>
	</section>
</body>
</html>
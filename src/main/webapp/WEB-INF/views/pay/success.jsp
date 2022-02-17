<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.project.nadaum.member.model.vo.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.project.nadaum.member.model.vo.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();%>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="imgPath" value="/resources/images/audiobook"/>
<!DOCTYPE html>
<html>
<head>
<title>결제 성공</title>
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay/pay.css" />
</head>
<style>
div.pay-container{text-align:center;margin-top:10vh;}
body {font-family:'Pretendard-Regular';}
h1 {font-size:30px;}
@font-face {font-family: 'Pretendard-Regular';src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');font-weight: 400;font-style: normal;}
</style>
<body>
	<section>
		<div class="pay-container">
			<h1>결제 성공</h1>
			<h3>상품명: 나 다움 정기결제</h3>
			<h3>${member.nickname}님의 결제가 완료되었습니다.</h3>
			<%-- <h3>주문번호: ${orderId}</h3> --%>
			<button type="button" class="btn btn-primary" id="payment-button-modal" onclick="location.href='http://localhost:9090/nadaum/main/main.do'">돌아가기</button>
		</div>
	</section>
<script>
/* $(() => {	
	$(layerpop)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${referer}';
		});	
}); */

</script>	
	<%-- <div class="modal fade" id="layerpop">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title"></h4>
				</div>
				<!-- body -->
				<div class="modal-body pay-container">
					<div class="pay-container">
						<h1>결제 성공</h1>
						<h3>상품명: 나 다움 결제</h3>
						<h3>${customerName}님의결제가 완료되었습니다.</h3>
						<h3>주문번호: ${orderId}</h3>
					</div>
				</div>
				<!-- Footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="payment-button-modal" onclick="location.href='${referer}'">돌아가기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='${contextPath}'">메인으로</button>
				</div>
			</div>
		</div>
	</div> --%>
</body>
</html>
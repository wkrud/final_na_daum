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
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="imgPath" value="/resources/images/audiobook"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>구매하기</title>
    <meta charset="utf-8"/>
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay/pay.css" />
</head>
<style>
div.pay-container{text-align:center;margin-top:10vh;}
body {font-family:'Pretendard-Regular';}
h1 {font-size:30px;}
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

</style>
<body>
<section>
	<div class="pay-container">
	    <h1>구매하기</h1>
	    <img src="${contextPath}${imgPath}/nadaum_pay.jpg" style="height:25vh; width:20vh;" />
	    <h3>나다움 정기결제</h3>
	    <span>5000 원</span>
	    <p>----------------------</p>
	    <div><label><input type="radio" name="method" value="카드" checked/>신용카드</label></div>
	    <div><label><input type="radio" name="method" value="가상계좌"/>가상계좌</label></div>
	    <p>----------------------</p>
	    <button id="payment-button">결제하기</button>
    </div>
</section>
<script src="https://js.tosspayments.com/v1"></script>
<script>
    var tossPayments = TossPayments("test_ck_JQbgMGZzorzzXdypGB7rl5E1em4d");
    var button = document.getElementById("payment-button");

    var orderId = new Date().getTime();

    button.addEventListener("click", function () {
        var method = document.querySelector('input[name=method]:checked').value; // "카드" 혹은 "가상계좌"

        var paymentData = {
            amount: 20,
            orderId: orderId,
            orderName: "정기결제",
            customerName: "이렇게",
            successUrl: window.location.origin + "/nadaum/payment/success",
            failUrl: window.location.origin + "/nadaum/payment/fail",
        };

        if (method === '가상계좌') {
            paymentData.virtualAccountCallbackUrl = window.location.origin + '/virtual-account/callback'
        }

        tossPayments.requestPayment(method, paymentData);
    });
</script>
</body>
</html>

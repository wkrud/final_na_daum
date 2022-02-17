<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<html lang="ko">
<head>
    <title>구매하기</title>
    <meta charset="utf-8"/>
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay/pay.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
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
	    <h1>나다움 정기결제</h1>
	    <br/><br/>
	    <img src="${contextPath}${imgPath}/nadaum_pay.jpg" style="height:480px; width:360px;" />
	    <br/><br/>
	    <h3>${referer}</h3>
	    <%-- <input type="hidden" name="referer" value="${referer}" /> --%>
	    <!--
	    <span>5000 원</span>
	    <p>----------------------</p>
	    <div><label><input type="radio" name="method" value="카드" checked/>신용카드</label></div>
	    <div><label><input type="radio" name="method" value="가상계좌"/>가상계좌</label></div>
	    <p>----------------------</p>
	    <button class="btn btn-default" id="payment-button">결제하기</button> -->
    </div>
</section>
<script src="https://js.tosspayments.com/v1"></script>
<script>
    var tossPayments = TossPayments("test_ck_JQbgMGZzorzzXdypGB7rl5E1em4d");
    var button = document.getElementById("payment-button");
    var orderId = new Date().getTime();
	console.log(referer);
    button.addEventListener("click", function () {
        var method = document.querySelector('input[name=method]:checked').value; // "카드" 혹은 "가상계좌"
        var paymentData = {
            amount: 5000,
            orderId: orderId,
            orderName: "정기결제",
            successUrl: window.location.origin + "/nadaum/payment/success",
            failUrl: window.location.origin + "/nadaum/payment/fail",
        };
        if (method === '가상계좌') {
            paymentData.virtualAccountCallbackUrl = window.location.origin + '/virtual-account/callback'
        }
        tossPayments.requestPayment(method, paymentData);
    });
</script>
<div style="text-align:center;">
	<button class="btn btn-primary" id="popupbutton"data-target="#layerpop" data-toggle="modal" >결제하기</button><br/>
</div>

<div class="modal fade" id="layerpop" >
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
            <h1>나다움멤버십</h1>
	    	<img src="${contextPath}${imgPath}/nadaum_pay.jpg" style="height:25vh; width:20vh;" />
	    	<h3></h3>
	    	<span>5,000 원</span>
	    	<p>----------------------</p>
	    	<div><label><input type="radio" name="method" value="카드" checked/>신용카드</label></div>
	    	<div><label><input type="radio" name="method" value="가상계좌"/>가상계좌</label></div>
	    	<p>----------------------</p>
	    	<!-- <p>(실제인출은 이뤄지지 않으니 안심하고 테스트하세요)</p> --> 
      </div>
      <!-- Footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="payment-button-modal">결제하기</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
  <script>
    var tossPayments = TossPayments("test_ck_JQbgMGZzorzzXdypGB7rl5E1em4d");
    var button = document.getElementById("payment-button");
	var payButton = document.getElementById("payment-button-modal");
    var orderId = new Date().getTime();
    
	console.log(orderId);
	console.log(payButton);

	payButton.addEventListener("click", function () {
		/* console.log($(e.target).prop('tagName'));
		console.log($(e.target));
		console.log($(e.target).prop('value'));  */
        var method = document.querySelector('input[name=method]:checked').value; // "카드" 혹은 "가상계좌"
        var paymentData = {
            amount: 5000,
            orderId: orderId,
            orderName: "정기결제",
            successUrl: window.location.origin + "/nadaum/payment/success",
            failUrl: window.location.origin + "/nadaum/payment/fail",
        };
        if (method === '가상계좌') {
            paymentData.virtualAccountCallbackUrl = window.location.origin + '/virtual-account/callback'
        }
        	tossPayments.requestPayment(method, paymentData);
    	}
	);
</script>
</div>
</body>
</html>

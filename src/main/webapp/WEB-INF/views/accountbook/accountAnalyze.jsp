<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부 차트" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 M월 d일");
	SimpleDateFormat sdf2 = new SimpleDateFormat("M월");
	String today = sdf.format(date);
	String today_m = sdf2.format(date);
%>

<div class="accountWrapper">
<!-- 본문 영역 -->
	<div class="analyze-account box">
		<!-- 헤더 -->
		<div class="analyze-account-header">
			<button class="defaultBtn" onclick="count('minus')"><i class="fas fa-arrow-left"></i></button>
			<p>${today}월의 나:다운 가계부</p>
			<button class="defaultBtn" onclick="count('plus')"><i class="fas fa-arrow-right"></i></button>
		</div>
		<!-- 수입 -->
		<div class="incomeArea">
			<div class="incomeArea-title">
				<p>${loginMember.name}님의 <span>수입 </span>패턴 분석</p>
			</div>
			<div class="incomeArea-payment-count">
				<ul>
				<c:forEach items="${paymentList_I}" var = "payment_I">
					<c:choose>
						<c:when test="${payment_I.payment eq 'cash'}">
							<li>현금 : ${payment_I.count}건</li>
						</c:when>
						<c:when test="${payment_I.payment eq 'card'}">
							<li>카드 : ${payment_I.count}건</li>
						</c:when>
						<c:when test="${payment_I.payment eq 'blank'}">
							<li>미등록 : ${payment_I.count}건</li>
						</c:when>
					</c:choose>
				</c:forEach>
				</ul>
			</div>
			<div class="income-category-ranking">
				<p>이달의 최애! 수입 카테고리</p>
				<ul>
				<c:forEach items="${categoryList_I}" var = "category_I" varStatus="vs">
					<li>${vs.count}. ${category_I.category} : <fmt:formatNumber value="${category_I.sum}" type="number"/>원
						(${category_I.count}건)</li>
				</c:forEach>
				</ul>
			</div>
			<div class="income-category-chart" id="income-category-chart">
			</div>
		</div>
		<!-- 지출 -->
		<div class="expenseArea">
			<div class="expenseArea-title">
				<p>${loginMember.name}님의 <span>지출 </span>패턴 분석</p>
			</div>
			<div class="expenseArea-payment-count">
				<ul>
				<c:forEach items="${paymentList_E}" var = "payment_E">
					<c:choose>
						<c:when test="${payment_E.payment eq 'cash'}">
							<li>현금 : ${payment_E.count}건</li>
						</c:when>
						<c:when test="${payment_E.payment eq 'card'}">
							<li>카드 : ${payment_E.count}건</li>
						</c:when>
						<c:when test="${payment_E.payment eq 'blank'}">
							<li>미입력 : ${payment_E.count}건</li>
						</c:when>
					</c:choose>
				</c:forEach>
				</ul>
			</div>
			<div class="expense-category-chart" id="expense-category-chart">
			</div>
			<div class="expense-category-ranking">
				<p>이달의 최애! 지출 카테고리</p>
				<ul>
				<c:forEach items="${categoryList_E}" var = "category_E" varStatus="vs">
					<li>${vs.count}. ${category_E.category} : <fmt:formatNumber value="${category_E.sum}" type="number"/>원
						(${category_E.count}건)</li>
				</c:forEach>
				</ul>
			</div>
		</div>
		<!-- 월별차트 -->
		<div class="monthlyArea">
			<div class="monthlyArea-title">
				<p>한눈에 보는 ${loginMember.name}님의 월별 사용량</p>
			</div>
			<div class="monthly-total-chart" id="monthly-total-chart">월별 차트영역</div>
		</div>
	</div>
</div>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/chart.js'></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" /> 
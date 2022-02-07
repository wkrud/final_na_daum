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
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/main2.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<style>
.analyze-ac{
background-image:
url('${pageContext.request.contextPath}/resources/images/accountbook/image-from-rawpixel-id-3875546-original.png');
background-size : cover;
text-align : center;
}
</style>

<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 M월 d일");
	SimpleDateFormat sdf2 = new SimpleDateFormat("M월");
	String today = sdf.format(date);
	String today_m = sdf2.format(date);
%>

<div class="accountWrapper">
	<form action="">
	<div class="analyze-ac">
		<div class="analyze-header">
			<p>${loginMember.name}님의</p> 
			<p><%= today_m %> 가계부가 도착했어요♪</p>
		</div>
		<div class="analyze-income">
			<h3>이 달의 수입 패턴</h3>
			<table>
				<tr>
					<td>현금 %</td>
					<td>카드 %</td>
				</tr>
			</table>
			<div id="incomeChartArea" class="box"></div>
			<div class="incomeAnalyzeArea box"></div>
		</div>
		<div class="analyze-expense">
			<h3>이 달의 지출 패턴</h3>
			<table>
				<tr>
					<td>현금 %</td>
					<td>카드 %</td>
				</tr>
			</table>
			<div id="expenseChartArea" class="box"></div>
			<div class="expenseAnalyzeArea box"></div>
		</div>
		<div class="analyze-monthly">
			<h3>한눈에 보는 월별 차트</h3>
			<div id="monthly_chart"></div>
		</div>
	</div> 
	</form>
</div>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/chart.js'></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" /> 
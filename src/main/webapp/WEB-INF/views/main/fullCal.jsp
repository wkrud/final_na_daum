<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/main/main.css' rel='stylesheet' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar/vendor/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar/vendor/fullcalendar.min.css" />
<link rel="stylesheet" href='${pageContext.request.contextPath}/resources/css/calendar/vendor/select2.min.css' />
<link rel="stylesheet" href='${pageContext.request.contextPath}/resources/css/calendar/vendor/bootstrap-datetimepicker.min.css' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>

<article class="calWrapper">

<div id="mini-cal"></div>

</article>
<input type="hidden" id="id" value="${loginMember.id}" />
<input type="hidden" id="nickName" value="${loginMember.nickname}" />
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<input type="hidden" id ="csrfToken" name="${_csrf.parameterName}" value="${_csrf.token}"/>	
<input type="hidden" id ="csrfParameterName" value="${_csrf.parameterName}"/>	
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/fullcalendar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/ko.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar/vendor/bootstrap-datetimepicker.min.js"></script>
<script src='${pageContext.request.contextPath}/resources/js/main/main.js'></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
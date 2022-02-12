<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/main/main.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>

<article class="mainWrapper">
	<section class="main box" id="dragZone" droppable="true" ondrop="drop(event)" ondragover="dragOver(event)">
		<div class="add-widget">
			<span style="--i:0;--x:-1;--y:0" class="accept-drag" id="feed-widget">
				<i class="far fa-comments"></i>
			</span>
			<span style="--i:1;--x:1;--y:0" class="accept-drag" id="calendar-widget">
				<i class="far fa-calendar-alt"></i>
			</span>
			<span style="--i:2;--x:0;--y:-1" class="accept-drag" id="todo-widget">
				<i class="fas fa-clipboard-list"></i>
			</span>
			<span style="--i:3;--x:0;--y:1" class="accept-drag" id="memo-widget">
				<i class="far fa-edit"></i>
			</span>
			<span style="--i:4;--x:1;--y:1" class="accept-drag" id="account-widget">
				<i class="fas fa-calculator"></i>
			</span>
			<span style="--i:5;--x:-1;--y:-1" class="accept-drag" id="culture-widget">
				<i class="far fa-images"></i>
			</span>
			<span style="--i:6;--x:0;--y:0" class="accept-drag" id="movie-widget">
				<i class="fas fa-film"></i>
			</span>
			<span style="--i:7;--x:-1;--y:1" class="accept-drag" id="game-widget">
				<i class="fas fa-gamepad"></i>
			</span>
			<span style="--i:8;--x:1;--y:-1" class="accept-drag" id="audio-widget">
				<i class="far fa-play-circle"></i>
			</span>
		</div>
		<c:forEach items="${widgetList}" var="widget">
			<div class="widget_form ${widget.widgetName}">${widget.widgetName}${widget.no}</div>
		</c:forEach>
	</section>
</article>
<input type="hidden" id="id" value="${loginMember.id}" />
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/main/main.js'></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
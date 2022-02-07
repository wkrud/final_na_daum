<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 관리자페이지" name="title"/>
</jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/admin/chart.js"></script>
<div class="admin-body">
	<div class="admin-main-body">
		<div class="admin-main-sidebar">
			<div class="absolute-left">
				<ul class="list-group">
					<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/admin/adminAllHelp.do">질문관리</a></li>
					<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/admin/adminManagingAnnouncement.do">공지사항관리</a></li>
					<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/admin/adminManagingUser.do">회원관리</a></li>
				</ul>
			</div>
		</div>
		<div class="admin-main-section">
			<div class="admin-main-title-wrap">
				<span>홈페이지 관리</span>
			</div>
			<div class="admin-chart-wrap">
				<div id="member-hobby-chart"></div>
				<div id="member-help-chart"></div>
				<div id="member-enroll-chart"></div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
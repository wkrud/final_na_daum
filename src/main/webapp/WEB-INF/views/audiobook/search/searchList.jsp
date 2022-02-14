<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="imgPath" value="/resources/upload/audiobook/img/" />
<%-- <link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/audiobook/track.css" /> --%>
<style>
.card-title {
	text-align: center;
}

img {
	border: 0px;
}

.search-card {
	margin-left: 3.5vw;
	margin-right: 3.5vw;
}

.list {
	margin-left: 20vw;
	margin-right: 20vw;
	text-align: center;
}

.search-box {
	margin-bottom: 0.1vh;
	margin-left: auto;
	margin-right: auto;
}

.btn {
	margin-left: 10px;
	margin-right: 10px;
}
/* Boostrap Buttons Styling */
.search-container {
	margin-bottom: 20px;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-weight: 700;
	font-style: normal;
}
/* 
.btn-info {
	font-family: Raleway-SemiBold;
	font-size: 13px;
	color: rgba(91, 192, 222, 0.75);
	letter-spacing: 1px;
	line-height: 15px;
	border: 2px solid transparent;
	border-radius: 40px;
	background: transparent;
	transition: all 0.3s ease 0s;
}

.btn-info:hover {
	color: #FFF;
	background: rgba(91, 192, 222, 0.75);
	border: 2px solid rgba(91, 192, 222, 0.75);
} */
</style>
<fmt:requestEncoding value="utf-8" />

<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="Le Café Livres" name="title" />
</jsp:include>
<div class="col-lg-12 text-center mt-5">
	<h1><a href="${contextPath}/audiobook/search/list" style="color: black; text-decoration:none;">Search List</a> </h1>
</div>
<!-- <div class="col-md-4 offset-md-4 mt-5 border border-success pt-3 search-box">
	<div class="input-group mb-3">
		<input type="text" class="form-control" placeholder="지금 뜨는 작품!"
			aria-label="">
		<button id="search-album" class="btn btn-online-secondary"
			type="button">검색</button>
		<div class="input-group-append">
			<span class="input-group-text"><i class="fa fa-search"></i></span>
		</div>
	</div>
</div> -->

<!-- ${_csrf.parameterName}=${_csrf.token}  -->
<div id="search-container" class="search-container text-center">
	<form name="albumSearchFrm" action="${contextPath}/audiobook/search/list/select?" method="get">
		<div class="col-md-7 mt-5 border pt-3 search-box">
			<select name="searchType" class="form-select" required>
				<option value="">검색타입</option>
				<!-- required여부를 판단할 value="" 반드시 있어야함.-->
				<option value="title" ${'title' eq param.searchType? "selected" : ""}>타이틀</option>
				<option value="kind" ${'kind' eq param.searchType? "selected" : ""}>장르</option>
				<option value="creator" ${'creator' eq param.searchType? "selected" : ""}>크리에이터</option>
				<option value="provider" ${'provider' eq param.searchType? "selected" : ""}>제공자</option>
				<option value="content" ${'content' eq param.searchType? "selected" : ""}>컨텐츠</option>
			</select> <input type="search" name="searchKeyword" value="${param.searchKeyword}" required /> 
			<input type="submit" value="검색" class="btn btn-dark" />
		</div>
	</form>
	<div class="buttons">
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Classic" role="button">#클래식</a> 
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Novel"role="button">#소설</a> 
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=ASMR" role="button">#ASMR</a> 
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Fairy" role="button">#동화책</a>
	</div>
</div>



<div class="row row-cols-1 row-cols-md-4 g-5 list">
	<c:forEach var="album" items="${searchList}">
		<div class="col col-md-2">
			<div class="card h-100">
				<input id="code" name="code" type="hidden" value="${album.code}" />
				<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
				<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}"> 
				<img src="${contextPath}${imgPath}${album.renamedFilename}" class="card-img-top" alt=""></a>
				<div class="card-body">
					<h5 class="card-title">${album.title}</h5>
					<p class="card-text"></p>
				</div>
			</div>
		</div>
	</c:forEach>
</div>



<!-- ajax로 페이지 새로고침 영역-->
<c:forEach var="album" items="${albumList}">
	<div class="col-md-4 offset-md-4 mt-5 border border-success pt-3">
		<div class="search-list">
			<div class="list-group"></div>
		</div>
	</div>
</c:forEach>
<!--비동기 통신 페이지 새로고침(미완성)-->
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>
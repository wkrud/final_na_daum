<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="imgPath" value="/resources/upload/audiobook/img/"/>
<%-- <link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/audiobook/track.css" /> --%>
<style>
.card-title{text-align:center;}
img{border:0px;}
.search-card{margin-left:3.5vw;margin-right:3.5vw;}
.list{margin-left:20vw; margin-right: 20vw; text-align:center;}
.search-box{margin-bottom:4vw; margin-left:auto; margin-right:auto;}
</style>
<fmt:requestEncoding value="utf-8" />

<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="Le Café Livres" name="title" />
</jsp:include>
<div class="col-lg-12 text-center mt-5">
	<h1>Search List</h1>
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
<div id="search-container" class="text-center">
		<form 
			name="albumSearchFrm"
			action="${contextPath}/audiobook/search/list/select?"	
			method="get"
		>
		<div class="col-md-7 mt-5 border pt-3 search-box">
			<select name="searchType" class="form-select" required>
				<option value="">검색타입</option>
				<!-- required여부를 판단할 value="" 반드시 있어야함.-->
				<option value="kind" <c:if test="${'emp_id' eq param.searchType}">selected</c:if>>장르</option>
				<option value="creator" ${'creator' eq param.searchType? "selected" : ""}>크리에이터</option>
				<option value="provider" ${'provider' eq param.searchType? "selected" : ""}>제공자</option>
				<option value="content" ${'content' eq param.searchType? "selected" : ""}>컨텐츠</option>
			</select>
			<div class="md-form active-purple-2 mb-3">
			<input type="search" name="searchKeyword"  value="${param.searchKeyword}" required/>
			</div>	
			<input type="submit" value="검색" class="btn btn-dark"/>
		</div>
		</form>
</div>



<div class="row row-cols-1 row-cols-md-4 g-4 list">
	<c:forEach var="album" items="${searchList}">
		<div class="col col-md-2 search-card">
			<div class="card h-100">
				<input id="code" name="code" type="hidden" value="${album.code}"/> 
				<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
				<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}">
				<img src="${contextPath}${imgPath}${album.renamedFilename}"  class="card-img-top" alt=""></a>
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
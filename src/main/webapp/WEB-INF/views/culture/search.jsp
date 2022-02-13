<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.project.nadaum.culture.movie.controller.GetMovieApi"%>

<sec:authentication property="principal" var="loginMember" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 영화리스트 " name="movieList" />
</jsp:include>

<style>
section#content {
	
}

.search-form label {
	padding-right: 8px;
}

div#culture-container {
	width: 100%;
	margin: 0 auto;
	text-align: center;
}

.thumnail {
	width: 20%;
}

#culture_code {
	display: none;
}

.culture-card {
	height: 300px;
	padding: 15px;
}

.card-title {
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
	width: 300px;
}

.paging li {
	list-style: none;
}

.paging a {
	color: black;
}

.form-group {
	padding-left: 20px;
}
/*card img 크기 고정*/
.culture-card-img {
	height: 15rem;
	object-fit: cover;
	opacity: 0.8;
}

/* 페이지 설정 */
container {
	padding: 0;
}

.container {
	padding: 0;
}

section {
	background-color: #FFFBF5;
}

body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100vh;
	background-color: #EEEEEE;
}

/* 썸네일 이미지 설정*/
.culture-thumnail {
	position: relative;
	padding: 0;
}

.culture-thumnail img {
	height: 450px;
	width: 100%;
	opacity: 0.75;
}

.title {
	position: absolute;
	top: 30%;
	left: 60%;
}
/*검색 폼 */
.search-form {
	position: absolute;
	background: #F2F2F2;
	bottom: -10%;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 5px 5px 10px grey;
	margin-bottom: 20px;
}

/* 오렌지색 버튼*/
.btn {
	border-radius: 10px;
	text-decoration: none;
	color: #fff;
	position: relative;
	display: inline-block;
	margin-left: 30px;
}

.btn:active {
	transform: translate(0px, 5px);
	-webkit-transform: translate(0px, 5px);
	box-shadow: 0px 1px 0px 0px;
}

.orange {
	background-color: #F6953C;
	box-shadow: 0px 4px 0px 0px #CD6509;
}

.orange:hover {
	background-color: #FF983C;
}
</style>
<script>
//cultureDetail
$(() => {
		
		//날짜 넣기
		 const value = new Date();
		
		const f = n => n < 10 ? "0" + n : n;
		// yyyy-mm-dd
		const today = `\${value.getFullYear()}-\${f(value.getMonth() + 1)}-\${f(value.getDate())}`;
		console.log(today);
		
		start = document.getElementById("startDate");
		start.value = today;
		
		const after_month = `\${value.getFullYear()}-\${f(value.getMonth() + 2)}-\${f(value.getDate())}`;
		console.log(after_month);
		end = document.getElementById("endDate");
		end.value = after_month; 
		
		
}); 
</script>
<div class="container">
	<div class="culture-thumnail">
		<!-- 썸네일 그림, 타이틀  -->
		<img
			src="${pageContext.request.contextPath}/resources/images/culture/festival.jpg"
			alt="문화썸네일" />
		<h1 class="title">Culture</h1>

		<!-- 검색창 -->
		<div class="search-group">
			<form class="form-inline search-form" id="searchFrm"
				action="${pageContext.request.contextPath}/culture/search.do?${_csrf.parameterName}=${_csrf.token}"
				method="post">
				<input type="text" class="form-control form-control-sm"
					name="keyword" id="keyword">

				<div class="form-group" id="period">
					<label for="Date" class="control-label">기간</label> <input
						type="date" class="form-control" id="startDate" name="startDate">
					<input type="date" class="form-control" id="endDate" name="endDate">
				</div>
				<div class="form-group" id="area">
					<label for="area" class="control-label">지역</label> <select
						class="form-control" name="searchArea" id="searchArea">
						<option value="">모두</option>
						<option value="서울">서울</option>
						<option value="경기">경기</option>
					</select>
				</div>
				<div class="form-group" id="genre">
					<label for="genre" class="control-label">장르</label> <select
						class="form-control" name="searchGenre" id="searchGenre">
						<option value="">모두</option>
						<option value="A000">연극</option>
						<!-- A연극 -->
						<option value="B000">음악</option>
						<!-- B 음악  -->
						<option value="C000">무용</option>
						<!-- C 무용-->
						<option value="D000">미술</option>
						<!-- D 미술  -->
					</select>
				</div>
				<button type="submit" class="btn orange btn-default" id="search-btn">Search</button>
			</form>

		</div>
	</div>
	<form
		action="${pageContext.request.contextPath}/culture/likes.do?${_csrf.parameterName}=${_csrf.token}"
		method="post">
		<input type="hidden" name="id" value="${loginMember.id}" />
		<button type="submit" class="btn btn-dark">나다운 찜 목록</button>
	</form>

	<div id="culture-container">
		<div class="py-5">
			<div class="container">
				<div class="row hidden-md-up">
					<!-- api 꺼내기 위한 반복문 시작 -->
					<c:forEach var="culture" items="${perforList}">
						<div class="col-md-4">
							<div class="card mb-3 shadow-sm">
								<img src="${culture.thumbnail}"
									class="card-img-top embed-responsive-item culture-card-img"
									onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">
								<input type="hidden" name="movieCode" value="{}" />
								<div class="card-body"
									onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">
									<h4 class="card-text">${culture.title}</h4>
									<p class="card-text">${culture.area}</p>
									<p class="card-text">${culture.place}</p>
									<p class="card-text">${culture.realmName}</p>
								</div>
							</div>
						</div>
					</c:forEach>
					<c:if test="${empty perforList}">
					<h1>원하시는 전시회가 없어요 😥</h1>
					</c:if>
				</div>

			</div>
		</div>
	</div>
</div>
</body>
<script>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
<link href='${pageContext.request.contextPath}/resources/css/movie/movieList.css' rel='stylesheet' />
<style>
.scrap-title{text-align:center;}
.movie-card{margin-left: 30px;}
.scrap-image{height: 400px;}
</style>
<div class="movie-container">
	<!-- 썸네일 그림, 타이틀  -->
	<div class="movie-banner">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<div class="banner-div">
						<iframe class="banner-img" width="560" height="315"
							src="https://www.youtube.com/embed/Yh87974T6hk?autoplay=1&mute=1&loop=1"
							title="YouTube video player" frameborder="0"
							allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
							allowfullscreen></iframe>
					</div>
				</div>
				<div class="carousel-item">
					<div class="banner-div">
						<img class="banner-img"
							src="https://ncache.ilbe.com/files/attach/new/20190216/377678/8829971779/11021379500/625fd49d7d96bd378920dd480f1467a3.jpg"
							alt="" />
					</div>
					<div class="container">
						<div class="carousel-caption">
							<h1>“내 사랑의 유통기한은 만 년으로 하고 싶다”</h1>
							<p>만우절의 이별 통보가 거짓말이길 바라며 술집을 찾은 경찰 223</p>
							
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<div class="banner-div">
						<img class="banner-img"
							src="https://pbs.twimg.com/media/EirK5NvX0AADXtp?format=jpg&name=medium"
							alt="" />
					</div>
					<div class="container">
						<div class="carousel-caption">
							<h1> "그녀가 떠난 후 이 방의 모든 것들이 슬퍼한다"</h1>
							<p>편지 속에 담긴 그의 아파트 열쇠를 손에 쥔 단골집 점원 페이</p>
							
						</div>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#myCarousel" role="button"
				data-slide="prev"> <span class="carousel-control-prev-icon"
				aria-hidden="true"></span> <span class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#myCarousel" role="button"
				data-slide="next"> <span class="carousel-control-next-icon"
				aria-hidden="true"></span> <span class="sr-only">Next</span>
			</a>
		</div>


		<!-- 검색창 -->
		<nav class="navbar navbar-light bg-light justify-content-between movie-nav">
			<button type="button" class="btn btn-outline-dark"
				onclick="location.href='${pageContext.request.contextPath}/movie/movieScrap.do'">스크랩
				목록</button>
			<a class="navbar-brand"></a>
			<form class="form-inline" action="${pageContext.request.contextPath}/movie/movieSearch.do?${_csrf.parameterName}=${_csrf.token}" method="post">
				<input class="form-control mr-sm-2" type="text" name="keyword" placeholder="검색하고 싶은 영화를 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</nav>
	</div>
		
		<h1 class="scrap-title">🎬${loginMember.nickname} 님의 영화 스크랩 목록🎬</h1>
		<!-- TMDB api -->
	<div class="upcoming-movie">
		<c:forEach var="movie" items="${scrapList}">
		<div class="card movie-card" style="width: 18rem;">
			
  			<img class="card-img-top scrap-image" src="https://image.tmdb.org/t/p/w500${movie.posterPath}" alt="Card image cap" onclick="location.href='${pageContext.request.contextPath}/movie/movieDetail/${movie.apiCode}'">
            						
  			<div class="card-body">
   			 <p class="card-text">${movie.title}</p>
  			</div>
		</div>
		</c:forEach>
	</div>
		

</div>
		

<script>
/* the movie api 에서 top_rated  불러오기*/


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
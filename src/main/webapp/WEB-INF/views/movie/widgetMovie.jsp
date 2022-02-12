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
	<jsp:param value="위젯영화" name="widget-movie" />
</jsp:include>

<style>

.widget_form {
	width: 350px;
	height: 400px;
	position: relative;
	background: white;
	box-shadow: 0 25px 45px rgb(0 0 0/ 10%);
	border: 1px solid rgba(225, 225, 225, 0.5);
	border-radius: 10px;
	top: 30px;
	left: 50px;
	padding: 10px;
	margin: 20px;
	backdrop-filter: blur(25px);
	display: inline-block;
}

/*post slider*/
.post-slider {
	width:95%;
	margin: 0px auto;
	position: relative;
}

.post-slider .silder-title{
	text-align: center;
	margin: 0;
}
.silder-title{
	font-size:20px !important;
}
.post-slider .next {
	position: absolute;
	top: 50%;
	right: -2px;
	font-size: 1em;
	color: gray;
	cursor: pointer;
}

.post-slider .prev {
	position: absolute;
	top: 50%;
	left: -2px;
	font-size: 1em;
	color: gray;
	cursor: pointer;
}

.post-slider .post-wrapper {
	width:95%;
  	height:100%;
	margin: 0px auto;
	overflow: hidden;
	padding: 10px 0px 10px 0px;
}

.post-slider .post-wrapper .post {
	width:400px;
  	height:300px;
	margin: 0px 1px;
	display: inline-block;
	background: white;
	border-radius: 5px;
}

.post-slider .post-wrapper .post .post-info {
	height:30%;
	font-size: 15px;
	padding: 1px;
}

.post-slider .post-wrapper .post .slider-image {
	/* width:60%; */
  	height:80%;
	display: inline-block;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.widget-movie-title{
	margin:0;
	text-align: center;
}
.widget-movie-rating{
	margin:0;
	font-size:12px !important;
	text-align: right;
	display:block;
	
}
.post-subject {
	text-align: right;
	display: block;
	color:black;
}
</style>
<div class="movie-container">


	<!-- 슬라이드 시작 -->
	<!-- 위젯 안에 들어갈 영화 (upcoming movie) -->
	<div class="widget_form">
		<div class="upcoming-movie-item">

			<div class="page-wrapper" style="position: relative;">
				<!--page slider -->
				<div class="post-slider">
					<h1 class="silder-title">Upcoming Movies</h1>
					<a href="${pageContext.request.contextPath}/movie/movieList.do"
						class="post-subject">+더보기</a> 
						
					<!-- 왼쪽 방향 버튼 -->
					<i class="fas fa-chevron-left prev"></i>
					<!-- 오른쪽 방향 버튼 -->
					<i class="fas fa-chevron-right next"></i>

					<div class="post-wrapper">

						<c:forEach var="movie" items="${widgetMovieList}">

							<div class="card post" style="width: 18rem;">
								<img class="card-img-top slider-image"
									src="https://image.tmdb.org/t/p/w500${movie.posterPath}"
									alt="Card image cap">
								<div class="card-body post-info">
									<p class="card-text widget-movie-title">${movie.title}</p>
									<p class="card-text widget-movie-rating">평점 : ${movie.voteAverage}</p>
								</div>
							</div>

						</c:forEach>

					</div>

				</div>
				<!--post slider-->
			</div>
		</div>
		<!-- 슬라이드 끝 -->
	</div>



</div>


<script>
/* 슬라이드 스크립트*/
$('.post-wrapper').slick({
  slidesToShow: 2,
  slidesToScroll: 1,
  autoplay: true,
  autoplaySpeed: 2000,
  nextArrow:$('.next'),
  prevArrow:$('.prev'),
});


 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
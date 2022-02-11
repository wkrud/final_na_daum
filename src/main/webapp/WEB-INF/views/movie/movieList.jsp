<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.project.nadaum.culture.movie.controller.GetMovieApi"%>

	<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 영화리스트 " name="movieList" />
</jsp:include>

<style>

/* 썸네일 이미지 설정*/
.movie-banner {
	top:50px;
	padding: 0;
}

/*검색 폼 */
.search-form {
	/* position: absolute; */
	position: relative;
	background: #F2F2F2;
	left: 30%;
	bottom: -10%;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 5px 5px 10px grey;
	margin-bottom: 20px;
	width: 50%
}

/* 오렌지색 버튼*/
.btn-default {
	border-radius: 10px;
	text-decoration: none;
	color: #fff;
	position: relative;
	display: inline-block;
}

.btn-default:active {
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

.movieapi-container{
padding : 100px;
}

.movie-card{
display:inline-block;
}

.blog .carousel-indicators {
	left: 0;
	top: auto;
    bottom: -40px;

}

/* The colour of the indicators */
.blog .carousel-indicators li {
    background: #a3a3a3;
    border-radius: 50%;
    width: 8px;
    height: 8px;
}

.blog .carousel-indicators .active {
background: #707070;
}
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
						<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
							<rect width="100%" height="100%" fill="#777" /></svg>
						<div class="container">
							<div class="carousel-caption text-left">
								<h1>Example headline.</h1>
								<p>Cras justo odio,</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Sign
										up today</a>
								</p>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
							<rect width="100%" height="100%" fill="#777" /></svg>
						<div class="container">
							<div class="carousel-caption">
								<h1>Another example headline.</h1>
								<p>Cras justo odio,</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Learn
										more</a>
								</p>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
							<rect width="100%" height="100%" fill="#777" /></svg>
						<div class="container">
							<div class="carousel-caption text-right">
								<h1>One more for good measure.</h1>
								<p>Cras justo odio, dapibus ac facilisis in,</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev"> 
				<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
				<span class="sr-only">Previous</span>
				</a> 
				
				<a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next"> 
				<span class="carousel-control-next-icon" aria-hidden="true"></span> 
				<span class="sr-only">Next</span>
				</a>
			</div>


			<!-- 검색창 -->
			<form class="form-inline search-form">
				<div class="form-group">
					<label for="Date" class="control-label">검색</label> <input
						type="text" class="form-control" id="keyword"
						placeholder="검색어를 입력하세요.">
				</div>
				<button type="submit" class="btn orange btn-default" id="search-btn">검색</button>
			</form>
			
			<a href="${pageContext.request.contextPath}/scrap/scrapList.do">스크랩</a>
			<a href="${pageContext.request.contextPath}/movie/widgetMovie.do">위젯</a>
		</div>

		<%-- <!-- 영화정보진흥원 api -->
		<div id="movieapi-container">
			<div class="py-5">
				<div class="container">
					<div class="row hidden-md-up">
						<!-- api 꺼내기 위한 반복문 시작 -->
						<c:forEach var="movie" items="${list}">
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<svg class="bd-placeholder-img card-img-top" width="100%"
										height="225" xmlns="http://www.w3.org/2000/svg"
										preserveAspectRatio="xMidYMid slice" focusable="false"
										role="img" aria-label="Placeholder: Thumbnail">
            						<title>Placeholder</title>
            						<rect width="100%" height="100%" fill="#55595c" />
            						<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
           		 					</svg>		
            						<input type="hidden" name="movieCode" value="{}"/>
									<div class="card-body">
										<p class="card-text">${movie.movieCd}</p>
										<p class="card-text">${movie.movieNm}</p>
										<p class="card-text">${movie.prdYear}</p>
										<p class="card-text">${movie.typeNm}</p>
										<p class="card-text">${movie.genreAlt}</p>
										<p class="card-text">${movie.peopleNm}</p>
										<p class="card-text"></p>
										<div class="d-flex justify-content-between align-items-center">
											<small class="text-muted">${movie.nationAlt}</small>
											<div class="btn-group">
												
												<button type="button" class="btn btn-sm btn-outline-secondary goDetail" name="apiCode" value="${movie.movieCd }">+More</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

				</div>
			</div>
		</div> --%>
		
		
		<!-- TMDB api -->
	<div class="upcoming-movie">
		<c:forEach var="movie" items="${list}">
		<div class="card movie-card" style="width: 18rem;">
			
  			<img class="card-img-top" src="https://image.tmdb.org/t/p/w500${movie.posterPath}" alt="Card image cap" onclick="location.href='${pageContext.request.contextPath}/movie/movieDetail/${movie.apiCode}'">
            						
            						<rect width="100%" height="100%" fill="#55595c" />
           		 					</svg>	
  			
  			<div class="card-body">
   			 <p class="card-text">${movie.title}</p>
  			</div>
		</div>
		</c:forEach>
	</div>
		
		<!-- 슬라이더 -->
		<div class="row blog">
                <div class="col-md-12">
                    <div id="blogCarousel" class="carousel slide" data-ride="carousel">

                        <ol class="carousel-indicators">
                            <li data-target="#blogCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#blogCarousel" data-slide-to="1"></li>
                        </ol>

                        <!-- Carousel items -->
                        <div class="carousel-inner">

                            <div class="carousel-item active">
                                <div class="row">
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                </div>
                                <!--.row-->
                            </div>
                            <!--.item-->

                            <div class="carousel-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img src="http://placehold.it/250x250" alt="Image" style="max-width:100%;">
                                        </a>
                                    </div>
                                </div>
                                <!--.row-->
                            </div>
                            <!--.item-->

                        </div>
                        <!--.carousel-inner-->
                        
                    </div>
                    <!--.Carousel-->

                </div>
            </div>


</div>
		

<script>
/* the movie api 에서 top_rated  불러오기*/


/* 페이지 로딩 될때 영화 */
// optional
		$('#blogCarousel').carousel({
				interval: 5000
		});
 
 /*  버튼 누를 시 영화 상세보기로 이동 */
$(".goDetail").click((e) => {
	const apiCode = $(e.target).val();
	console.log(e.target);
	console.log(apiCode);
	
 	location.href = `${pageContext.request.contextPath}/movie/movieDetail/\${apiCode}`;
	
 });
 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
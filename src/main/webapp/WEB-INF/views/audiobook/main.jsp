<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="Le Café Livres" name="title" />
</jsp:include>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="imgPath" value="/resources/upload/audiobook/img/" />
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* Make the image fully responsive */
.carousel-inner {
	width: "1100";
	height: "500";
}

.banner {
	margin-bottom: 2vw;
}

#body{
	justify-content: center;
	font-family: 'Pretendard-Regular';
	/* background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab); */
	background: linear-gradient(-45deg,#3D0605,  #0A1F33, #660B09, #12536B, #3D0605);
	background-color: #0A1F33;
    background-size: cover;
    animation: gradient 15s ease infinite;
	
}
header, body, footer{
	
}
/* html, body {
  width: 100%;
  height:100%;
} */
.carousel, .subList{
	margin-left:10vw;
}
.card-body {
	background-color: #0A1F33;
}
span{
	color: #fff;
}
.mainlist{
	border-color: #0A1F33;
}
@keyframes gradient {
    0% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
    100% {
        background-position: 0% 50%;
    }
}


@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 700;
    font-style: normal;
}

/* width: 100%;
	height: 100%; */
</style>
<div id="demo" class="carousel slide banner" data-ride="carousel">
	<!-- 	<ul class="carousel-indicators">
		<li data-target="#demo" data-slide-to="0" class="active"></li>
		<li data-target="#demo" data-slide-to="1"></li>
		<li data-target="#demo" data-slide-to="2"></li>
	</ul> -->
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src="https://img.sbs.co.kr/newimg/news/20161117/200997114_1280.jpg" id="center-image" alt="배너1" class="d-block mx-auto mt-5" 
			onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'"/>
			<div class="carousel-caption d-none d-md-block">
				<h3></h3>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img src="https://img.sbs.co.kr/newimg/news/20161117/200997114_1280.jpg" id="center-image" alt="배너2" class="d-block mx-auto mt-5">
			<div class="carousel-caption">
				<h3>.</h3>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img src="https://img.sbs.co.kr/newimg/news/20161117/200997114_1280.jpg" id="center-image" alt="배너3" class="d-block mx-auto mt-5">
			<div class="carousel-caption">
				<h3>.</h3>
				<p></p>
			</div>
		</div>
	</div>
	<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span class="carousel-control-prev-icon"></span>
	</a> <a class="carousel-control-next" href="#demo" data-slide="next"> <span class="carousel-control-next-icon"></span>
	</a>
</div>

<div id="subList" class ="subList" >

	<span>오디오북 듣기</span>
	<div class="row row-cols-1 row-cols-md-4 g-4 list">
		<c:forEach var="album" items="${novelList}">
			<div class="col col-md-2 search-card">
				<div class="card h-100">
					<input id="code" name="code" type="hidden" value="${album.code}" />
					<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
					<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}">
					<img src="${contextPath}${imgPath}${album.renamedFilename}" class="card-img-top" alt=""></a>
					<div class="card-body">
						<h5 class="card-title"><span>${album.title}</span></h5>
						<p class="card-text"></p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<span>최근 추가된 음악</span>
	<div class="row row-cols-3 row-cols-md-4 mainlist">
		<%-- <c: forEach></c:forEach> --%>
		<c:forEach var="album" items="${recentList}">
			<div class="col col-md-2 search-card">
				<div class="card h-100">
					<input id="code" name="code" type="hidden" value="${album.code}" />
					<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
					<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}">
					<img src="${contextPath}${imgPath}${album.renamedFilename}" class="card-img-top" alt="">
					</a>
					<div class="card-body">
						<h5 class="card-title"><span> ${album.title}</span></h5>
						<p class="card-text"></p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<span>추천클래식</span>
	<div class="row row-cols-1 row-cols-md-4 g-4 list">

		<c:forEach var="album" items="${classicList}">
			<div class="col col-md-2 search-card">
				<div class="card h-100">
					<input id="code" name="code" type="hidden" value="${album.code}" />
					<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
					<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}">
					<img src="${contextPath}${imgPath}${album.renamedFilename}" class="card-img-top" alt="">
					</a>
					<div class="card-body">
						<h5 class="card-title"><span>${album.title}</span></h5>
						<p class="card-text"></p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<span>추전재즈</span>
	<div class="row row-cols-1 row-cols-md-4 g-4 list">

		<c:forEach var="album" items="${jazzList}">
			<div class="col col-md-2 search-card">
				<div class="card h-100">
					<input id="code" name="code" type="hidden" value="${album.code}" />
					<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
					<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}"><img src="${contextPath}${imgPath}${album.renamedFilename}" class="card-img-top" alt=""></a>
					<div class="card-body">
						<h5 class="card-title"><span>${album.title}</span></h5>
						<p class="card-text"></p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<span>추천asmr</span>
	<div class="row row-cols-1 row-cols-md-4 g-4 list">
		<c:forEach var="album" items="${asmrList}">
			<div class="col col-md-2 search-card">
				<div class="card h-100">
					<input id="code" name="code" type="hidden" value="${album.code}" />
					<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
					<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}">
					<img src="${contextPath}${imgPath}${album.renamedFilename}" class="card-img-top" alt=""></a>
					<div class="card-body">
						<h5 class="card-title"><span>${album.title}</span></h5>
						<p class="card-text"></p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	


	<!-- 결제 모달 영역  -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">결제요청</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary">진행</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$('#testBtn').on(
			'click',
			function() {
				const $test = $('#testBtn');
				const data = $test.parent().parent().children('div.card-body')
						.first().children('h5');
				console.log(data);
				$('#staticBackdrop').modal('show');
			});
</script>
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>
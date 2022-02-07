<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Dev등록" name="title" />
</jsp:include>
<br>
<style type="text/css">
@font-face {
	font-family: 'CookieRun-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/CookieRun-Regular.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

#nadaumgg {
	text-align: center;
}

#nadaumgg h1 {
	font-family: 'CookieRun-Regular';
	color: #00f0f7
}

#aaa {
	text-align: center;
}

#bbb {
	width: 500px;
	height: 500px;
	position: absolute;
	right: 5%;
}

input[type="text"] {
	width: 70%;
	height: 100%;
	font-size: 1em;
	padding-left: 5px;
	font-style: oblique;
	display: inline;
	box-sizing: border-box;
	color: black;
}

input[type=button] {
	width: 30%;
	height: 100%;
	background-color: lightgray;
	border: none;
	background-color: white;
	font-size: 1em;
	color: #042AaC;
	outline: none;
	display: inline;
	margin-left: -10px;
	box-sizing: border-box;
}

input[type=button]:hover {
	background-color: lightgray;
}
</style>

<div id="nadaumgg">
	<h1>Nadaum.gg</h1>
</div>

<div id="aaa">
	<div id="bbb">
		<form id="riotnick" method="GET">
			<input type="text" id="nickname" name="nickname"
				placeholder="소환사명을 입력하세요" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg" />
			<button type="button" onclick="submit('riot1')"
				class="btn btn-sm btn-outline-secondary">전적검색</button>

		</form>

	</div>
</div>
<br>
<br>

<div class="jumbotron p-3 p-md-3 text-white rounded bg-blue">
	<div class="col-md-6 px-0">
		<img alt="아이콘" src=${ img} style="width: 200px">
	</div>
	<div class="col-md-6 px-0">
		<h1 class="display-4 font-italic">${summoner.name}</h1>
	</div>
</div>

<div class="row mb-2">
	<div class="col-md-6">
		<div
			class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-auto d-none d-lg-block">
				<c:choose>
					<c:when test="${leagueentry.tier != null}">
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/${leagueentry.tier}.png"
							style="width: 200px">
					</c:when>
					<c:otherwise>
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/unranked.png"
							style="width: 200px; height: 229.3px;">
					</c:otherwise>
				</c:choose>

			</div>
			<div class="col p-4 d-flex flex-column position-static">
				<h3 class="d-inline-block mb-2 text-dark">솔로랭크</h3>
				<h3 class="mb-2 text-primary">${leagueentry.tier}
					${leagueentry.rank} ${leagueentry.leaguePoints} LP</h3>

				<h3 class="mb-0">${leagueentry.wins}승${leagueentry.losses}패</h3>

			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div
			class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-auto d-none d-lg-block">
				<c:choose>
					<c:when test="${leagueentries.tier != null}">
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/${leagueentries.tier}.png"
							style="width: 200px">
					</c:when>
					<c:otherwise>
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/unranked.png"
							style="width: 200px; height: 229.3px;">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col p-4 d-flex flex-column position-static">
				<h3 class="d-inline-block mb-2 text-dark">자유랭크</h3>
				<h3 class="mb-2 text-primary">${leagueentries.tier}
					${leagueentries.rank} ${leagueentries.leaguePoints} LP</h3>

				<h3 class="mb-0">${leagueentries.wins}승${leagueentries.losses}패</h3>

			</div>
		</div>
	</div>

</div>



<main role="main" class="container">
	<div
		class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		<div class="col-md-6 blog-main">
			<c:forEach items="${test}" var="list" begin="0" end="0">
				<c:forEach items="${list}" var="map" begin="0" end="0">
				<c:forEach  var="j" begin="0" end="9">
					<p>${map.value.get(0).getInfo().getParticipants().get(j).getSummonerName()}</p>
					</c:forEach>
				</c:forEach>
			</c:forEach>
			<br><br><br><br>
			<p>${summoner.name}</p>
			<img alt="아이콘" src=${ img}>
			<p>${leagueentry.tier}${leagueentry.rank}</p>
			<img alt="랭크"
				src="${pageContext.request.contextPath}/resources/images/riot/${leagueentry.tier}.png">
			<p>${matchDtolist.get(0).getInfo().getParticipants().get(0).getAssists()}</p>

		</div>
	</div>
</main>





<script>
const submit => {
	$(riotnick)
		.attr("action", `${pageContext.request.contextPath}/riot/\${name}.do`)
		.submit();
		


};



</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />
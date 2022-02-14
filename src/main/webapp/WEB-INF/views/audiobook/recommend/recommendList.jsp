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
	padding-left:7vw;
	padding-right:7vw;
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
</style>
<fmt:requestEncoding value="utf-8" />

<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="Le Café Livres" name="title" />
</jsp:include>
<div class="col-lg-12 text-center mt-5">
	<h1><a href="${contextPath}/audiobook/recommend/list" style="color: black; text-decoration:none;">오늘의 추천</a> </h1>
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
<%-- div id="search-container" class="text-center search-container">
	<form name="albumSearchFrm" action="${contextPath}/audiobook/search/list/select?" method="get">
		<div class="col-md-7 mt-5 border pt-3 search-box">
			<select name="searchType" required>
				<option value="">검색타입</option>
				<!-- required여부를 판단할 value="" 반드시 있어야함.-->
				<option value="kind" <c:if test="${'emp_id' eq param.searchType}">selected</c:if>>장르</option>
				<option value="creator" ${'creator' eq param.searchType? "selected" : ""}>크리에이터</option>
				<option value="provider" ${'provider' eq param.searchType? "selected" : ""}>제공자</option>
				<option value="content" ${'content' eq param.searchType? "selected" : ""}>컨텐츠</option>
			</select> <input type="search" name="searchKeyword" value="${param.searchKeyword}" required /> <input type="submit" value="검색" class="btn btn-dark" />
		</div>
	</form>
	<div class="buttons">
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Classic" role="button">#클래식</a> 
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Novel"role="button">#소설</a> 
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=ASMR" role="button">#ASMR</a> 
		<a class="btn btn-outline-info" href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=creator&searchKeyword=페퍼톤스" role="button">#페퍼톤스</a>
	</div>
</div> --%>
<!-- <h1 style="text-align:center;">selectList확인</h1> -->
<%-- <div class="row row-cols-1 row-cols-md-4 g-4 list">
	<c:forEach var="album" items="${selectList}">
		<div class="col col-md-2">
			<div class="card h-100">
				<input id="code" name="code" type="hidden" value="${album.code}" />
				<img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt="">
				<a href="${pageContext.request.contextPath}/audiobook/detail?code=${album.code}"> 
				<img src="${contextPath}${imgPath}" class="card-img-top" alt="">
				</a>
				<div class="card-body">
					<h5 class="card-title">${album.title}</h5>
					<p class="card-text"></p>
				</div>
			</div>
		</div>
	</c:forEach>
</div> --%>

<div class="row row-cols-md-4 g-4 list">
	<div class="col col-md-3 row-md-4" >
		<div class="card h-100">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=as103001"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Cafe.jpg" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
	<div class="col col-md-3 row-md-4" >
		<div class="card h-100 row-md-4">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=nv303002"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Novel.gif" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>

	
	<div class="col col-md-3">
		<div class="card h-100">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Fairy"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Fairy.jpg" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
	
	<div class="col col-md-3">
		<div class="card h-100">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=fr305002"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Wonderland.jpg" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
</div>	
<div class="row  row-cols-md-4 g-4 list">	
<div class="col-lg-12 text-center mt-5">
	<h1><a href="${contextPath}/audiobook/recommend/list" style="color: black; text-decoration:none;">추천연주곡</a></h1>
</div>	
	<div class="col col-md-3">
		<div class="card h-100">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=cl105001"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Classic1.gif" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	

	<div class="col col-md-3">
		<div class="card h-100">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/search/list/select?searchType=kind&searchKeyword=Jazz"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_JazzList.gif" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
	
	
	<div class="col col-md-3 row-md-4">
		<div class="card h-100 row-md-4">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=jz107003"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Jazz2.gif" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
	<div class="col col-md-3 row-md-4">
		<div class="card h-100 row-md-4">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=cl105002"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Classic2.jpg" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
	
	
</div>
<div class="col-lg-12 text-center mt-5">
	<h1><a href="${contextPath}/audiobook/recommend/list" style="color: black; text-decoration:none;">인디음악</a> </h1>
</div>
<div class="row  row-cols-md-4 g-4 list justify-content-center">	
	<div class="col col-md-3 row-md-4">
		<div class="card h-100 row-md-4">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=in111004"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Indies.jpg" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
	
	<div class="col col-md-3 row-md-4">
		<div class="card h-100 row-md-4">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=in111002"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Travel.jpg" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
</div>

<div class="col-lg-12 text-center mt-5">
	<h1><a href="${contextPath}/audiobook/recommend/list" style="color: black; text-decoration:none;">애니메이션</a> </h1>
</div>
<div class="row  row-cols-md-4 g-4 list justify-content-center">
	<div class="col col-md-3 row-md-4">
		<div class="card h-100 row-md-4">
			<input id="code" name="code" type="hidden" value="${album.code}" />
			<%-- <img src="resources/upload/audiobook/img/${album.renamedFilename}"  class="card-img-top" alt=""> --%>
			<a href="${pageContext.request.contextPath}/audiobook/detail?code=an305002"> 
			<img src="${contextPath}${imgPath}recommend/Recommend_Good Night Child.gif" class="card-img-top" alt="">
			</a>
			<div class="card-body">
				<h5 class="card-title">${album.title}</h5>
				<p class="card-text"></p>
			</div>
		</div>
	</div>
</div>

<!-- ajax로 페이지 새로고침 영역-->
<%-- <c:forEach var="album" items="${selectList}">
	<div class="col-md-4 offset-md-4 mt-5 border border-success pt-3">
		<div class="search-list">
			<div class="list-group">
			</div>
		</div>
	</div>
</c:forEach> --%>


<!--비동기 통신 페이지 새로고침용-->
<script>
	/* $("#search").click((e)=>{
	 if($("#keyword").val()==null or $("#keyword").val()==''){
	 alert("검색어를 입력해 주세요.");
	 return false;
	 }
	 let keyword =$("#keyword").val();
	 $.ajax({
	 url:`{pageContext.request.contextPath}/audiobook/album/search/list?\${keyword}`,
	 success(resp){
	 let msg ='';
	 const $resultArea = $(".search-list").find("div");
	 $resultArea.empty();
	 if(resp =='0'){
	 msg = `<span>결과가 없습니다ㅠㅠ<span>`;
	 $resultArea.append(msg);
	 return;
	 }else{
	 $(resp).each((i,{code,id,}))
	
	 }
	 }
	 });
	 }); */
</script>

</section>

</div>
</body>

</html>
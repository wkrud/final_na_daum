<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/culture/cultureBoardList.css" />
<style>
section#content{
}
.search-form label{
padding-right: 8px;
}
div#culture-container{width:100%; margin:0 auto;text-align:center;}
.thumnail{width: 20%; }
#culture_code{
	display:none;
}
.card{
height: 300px;
padding: 15px;
}
.card-title{
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    width: 300px;
}
.paging li{

    list-style: none;
}
.paging a{
    color: black;
}
.form-group{
padding-left: 20px;
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
<body>
	<div class="container">
		<div class="culture-thumnail">
			<!-- 썸네일 그림, 타이틀  -->
			<img src="${pageContext.request.contextPath}/resources/images/culture/festival.jpg" alt="문화썸네일" />
			<h1 class="title">Culture</h1>
			<form class="form-inline" id="searchFrm">
				 <input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
				 
				 	
				  <div class="form-group" id="period">
				    <label for="Date" class="control-label">기간</label>
				    <input type="date" class="form-control" id="startDate" name="startDate">
				    <input type="date" class="form-control" id="endDate" name="endDate">
				  </div>
				  <div class="form-group" id="area">
				    <label for="area" class="control-label">지역</label>
				      <select class="form-control" name="searchArea" id="searchArea">
				        <option value="">모두</option>
				        <option value="서울">서울</option>
				        <option value="경기">경기</option>
				      </select>
				  </div>
				  <div class="form-group" id="genre">
				    <label for="genre" class="control-label">장르</label>
				      <select class="form-control" name="searchGenre" id="searchGenre">
				      	<option value="">모두</option>
				        <option value="A000">연극</option><!-- A연극 -->
				        <option value="B000">음악</option><!-- B 음악  -->
				        <option value="C000">무용</option><!-- C 무용-->
				        <option value="D000">미술</option><!-- D 미술  -->
				        
				      </select>
				  </div>
				  <button type="submit" class="btn orange btn-default">Search</button>
					<button type="button" class="btn btn-dark">나다운 찜 목록</button>
			</form>
		</div>
	<div id="culture-container">
	    <br />
	    
	     <div class="py-5">
	    <div class="container">
	      <div class="row hidden-md-up">
	       
	     <c:forEach var="culture" items="${list}">
	    	<div class="col-md-4" style="padding: 15px;">
	         <div class="card"> 
	            <div class="card-block" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">
	              <h4 class="card-title" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.title}</h4>
	              <p class="card-text p-y-1" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.area}</p>
	              <p class="card-text p-y-1" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.place}</p>
	              <p class="card-text p-y-1" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.realmName}</p>
	              <img class="thumnail" src="${culture.thumbnail}" alt="" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`"/>
	               </div>
	          </div>
	        </div>
		   </c:forEach>
	    			</div>
	    		</div>
	    	</div>
	    	<div class="paging">
	    		<ul>
	    			<c:if test="${page != 1}">
	    				<li><a href="${pageContext.request.contextPath}/culture/board/1">첫 페이지</a></li>	    			
	    			</c:if>
	    			<c:if test="${page-1 != 0}">
	    				<li><a href="${pageContext.request.contextPath}/culture/board/${page-1}">이전 페이지</a></li>	    			
	    			</c:if>
	    			<li>${page}/20</li>
	    			<c:if test="${page+1 < 21}">
	    				<li><a href="${pageContext.request.contextPath}/culture/board/${page+1}">다음 페이지</a></li>
	    			</c:if>
	    			<c:if test="${page != 20}">
	    				<li><a href="${pageContext.request.contextPath}/culture/board/20">마지막 페이지</a></li>	    			
	    			</c:if>
	    		</ul>
	    	</div>
		<!-- culture-container 끝 -->
		</div>
	</div>
</body>
<script>
 $(searchFrm).submit((e) => {
	e.preventDefault();
	
	
/* 	const startDate = $(e.target).find("[id=startDate]").val();
	console.log(startDate); */
	
/* 	var area_opt = document.getElementById("search-area");
	var area = area_opt.options[area_opt.selectedIndex].value;
	
	console.log(area); */

	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    
    
	$.ajax({
		headers : headers, 
		url: `${pageContext.request.contextPath}/culture/board/${page}/search`,
		method: "POST",
		data : $(searchFrm).serialize(),
		success(resp){
			console.log(resp);
		},
		error: console.log
	});
	
}); 
</script>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
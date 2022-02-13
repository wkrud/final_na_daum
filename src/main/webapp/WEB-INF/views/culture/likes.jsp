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
.culture-list{
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

<body>
	<div class="container">
		<div class="culture-thumnail">
			<!-- 썸네일 그림, 타이틀  -->
			<img src="${pageContext.request.contextPath}/resources/images/culture/festival.jpg" alt="문화썸네일" />
			<h1 class="title">Culture</h1>
		</div>
		<h1>나다운 찜 목록</h1>
		<br />
		  <div class="py-5">
	    <div class="container">
	      <div class="row hidden-md-up" id="result">
			     <c:forEach var="culture" items="${scrapList}">
			    	<div class="col-md-4" style="padding: 15px;">
			         <div class="card culture-list"> 
			            <div class="card-block" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">
			              <h4 class="card-title" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.title}</h4>
			              <p class="card-text p-y-1" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.area}</p>
			              <p class="card-text p-y-1" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.place}</p>
			              <p class="card-text p-y-1" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`">${culture.realmName}</p>
			              <img class="thumnail" src="${culture.imgUrl}" alt="" onclick="location.href=`${pageContext.request.contextPath}/culture/board/view/${culture.seq}`"/>
			               </div>
			          </div>
			        </div>
		       	 </c:forEach>
	        </div>
	        </div>
		</div>
		
		<button></button>
	</div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
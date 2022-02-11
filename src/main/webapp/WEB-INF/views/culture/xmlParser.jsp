<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>
<title>Insert title here</title>

</head>
<script>
</script>
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
@charset "UTF-8";
/* 페이지 설정 */
#container{
padding: 0;
}
.container{
	padding: 0;
}
section{
	background-color: #FFFBF5;
	
}
body{
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100vh;
    background-color: #EEEEEE;
}

/* 썸네일 이미지 설정*/

.culture-thumnail{
	position: relative;
	padding: 0;
}
.culture-thumnail img{
	height: 450px;
	width: 100%;
	opacity: 0.75;
}
.title{
	position: absolute;
	top: 30%;
    left: 60%;
}
/*검색 폼 */
.search-form{
	position: absolute;
    background: #F2F2F2;
    left: 10%;
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
<body>
	<div class="container">
		<div class="culture-thumnail">
			<!-- 썸네일 그림, 타이틀  -->
			<img src="${pageContext.request.contextPath}/resources/images/culture/festival.jpg" alt="문화썸네일" />
			<h1 class="title">Culture</h1>
			<form class="form-inline" id="searchFrm">
				 <input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
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
</html>
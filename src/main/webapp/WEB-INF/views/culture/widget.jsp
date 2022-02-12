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

/*schedule toggle button*/
body {
    font-family: sans-serif;
    font-weight: 800;
    background: #eee;
  }
  .switch {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 150px;
    height: 50px;
    text-align: center;
    margin: -30px 0 0 -75px;
    background: #00bc9c;
    transition: all 0.2s ease;
    border-radius: 25px;
  }
  .switch span {
    position: absolute;
    width: 20px;
    height: 4px;
    top: 50%;
    left: 50%;
    margin: -2px 0px 0px -4px;
    background: #fff;
    display: block;
    transform: rotate(-45deg);
    transition: all 0.2s ease;
  }
  .switch span:after {
    content: "";
    display: block;
    position: absolute;
    width: 4px;
    height: 12px;
    margin-top: -8px;
    background: #fff;
    transition: all 0.2s ease;
  }
  input[type=radio] {
    display: none;
  }
  .switch label {
    cursor: pointer;
    color: rgba(0,0,0,0.2);
    width: 60px;
    line-height: 50px;
    transition: all 0.2s ease;
  }
  label[for=yes] {
    position: absolute;
    left: 0px;
    height: 20px;
  }
  label[for=no] {
    position: absolute;
    right: 0px;
  }
  #no:checked ~ .switch {
    background: #eb4f37;
  }
  #no:checked ~ .switch span {
    background: #fff;
    margin-left: -8px;
  }
  #no:checked ~ .switch span:after {
    background: #fff;
    height: 20px;
    margin-top: -8px;
    margin-left: 8px;
  }
  #yes:checked ~ .switch label[for=yes] {
    color: #fff;
  }
  #no:checked ~ .switch label[for=no] {
    color: #fff;
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
	<div class="schedule-button">
		<div class="toggle-radio">
		  <input type="radio" name="rdo" id="yes" checked>
		  <input type="radio" name="rdo" id="no">
		  <div class="switch">
		    <label for="yes">Yes</label>
		    <label for="no">No</label>
		    <span></span>
		  </div>
		</div>
	</div>
	
	</div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
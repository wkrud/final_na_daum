<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="롤 전적검색" name="title" />
</jsp:include>
<br>

<style type="text/css">

@font-face {
    font-family: 'CookieRun-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/CookieRun-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}





#nadaumgg {
	text-align: center;
}

#nadaumgg h1{
	font-family: 'CookieRun-Regular';
	color: #00f0f7

}

#aaa {
	width: 100%;
	height: 900px;
	background-image:
		url('${pageContext.request.contextPath}/resources/images/riot/riotbackground.jpg');
	background-attachment: fixed;
	background-size: 100% 100%;
	text-align: center;
}

#bbb {
	 width:500px;
    height:500px;
    position:absolute;
    left:37%;
    top:50%;
 
}

#nickname {
    height:50px;
    font-size: 2rem;
 
}


</style>

<div id="nadaumgg">
	<h1>Nadaum.gg</h1>
</div>


<div id="aaa">
	<div id="bbb">
		<form id="riotnick" method="GET">
			<input type="text" id="nickname" name="nickname" placeholder="소환사명을 입력하세요" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"/>
		</form>
		<br>
		<button type="button" onclick="submit('riot1')" class="btn btn-light btn-lg">전적검색</button>
	</div>
</div>

<script>
const submit = (name) => {
	$(riotnick)
		.attr("action", `${pageContext.request.contextPath}/riot/\${name}.do`)
		.submit();
		


};



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

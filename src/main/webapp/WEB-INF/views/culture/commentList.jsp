<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<sec:authentication property="principal" var="loginMember"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
</style>
<script>

var xhr = new XMLHttpRequest();
var url = 'http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period'; /*URL*/
var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D'; /*Service Key*/
queryParams += '&' + encodeURIComponent('keyword') + '=' + encodeURIComponent(''); /**/
queryParams += '&' + encodeURIComponent('MsgBody') + '=' + encodeURIComponent(''); /**/
queryParams += '&' + encodeURIComponent('cPage') + '=' + encodeURIComponent('1'); /**/
queryParams += '&' + encodeURIComponent('rows') + '=' + encodeURIComponent('10'); /**/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
    }
};

xhr.send('');



</script>
<body>


</body>
</html>
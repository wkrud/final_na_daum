<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.project.nadaum.member.model.vo.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
%>
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="album 삭제" name="pageTitle" />
</jsp:include>

<sec:authentication property="principal" var="loginMember"/>
<style>
div#board-container {
	width: 800px;
	margin: 0 auto;
	text-align: center;
}

div#board-container input {
	margin-bottom: 15px;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}

.albumFrm {
	margin-top: 20px;
}
</style>
<div id="board-container">
	
	<form name="albumFrm" action="${pageContext.request.contextPath}/audiobook/album/delete?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		<input type="text" class="form-control" placeholder="코드" name="code" id="code" readonly value="${code}">
		<span>삭제하는 이유를 알려주세요.</span>
		<textarea class="form-control" name="content" placeholder="내용" required></textarea>
		<br/>
		<input type="hidden" name="member" value="${loginMember.id}"/> 
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		<input type="submit" class="btn btn-outline-success" value="제출">
	</form>
</div>
<script>
/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
function albumValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>

<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>
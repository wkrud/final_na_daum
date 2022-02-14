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
	<jsp:param value="게시판" name="title" />
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<style>
/*글쓰기버튼*/
input#btn-add {
	float: right;
	margin: 0 0 15px;
}

tr[data-no] {
	cursor: pointer;
	text-align:center;
}
th {width: 20px; text-align:center;}

</style>
<script>
/* function goAlbumForm(){
	location.href = `${pageContext.request.contextPath}/audiobook/album/enroll`;
} */

/* $(() => {
	/* $("tr[data-no]").click((e) => {
		// console.log(e.target); // td
		const $tr = $(e.target).parent();
		
		const code = $tr.data("code");
		location.href = `${pageContext.request.contextPath}/audiobook/detail?code=\${code}`;
	});  
	$("tr[data-no]").click((e) => {
		// console.log(e.target); // td
		const $tr = $(e.target).parent();
		
		const code = $tr.data("code");
		location.href = `${pageContext.request.contextPath}/audiobook/detail?code=\${code}`;
	});
	
}); */
</script>
<section id="board-container" class="container">
	<input type="button" value="앨범등록하기" id="btn-add"
		class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/audiobook/album/enroll'" />
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>코드</th>
			<th style="width:30px;">제목</th>
			<th>장르</th>
			<th>창작자</th>
			<th>작성일</th>
			<!-- <th>플레이타임</th> -->			
			<th>제작사</th>
			<th style="width:20px;">상태</th>
			<th style="width:20px;">수정</th>
			<!-- <th style="width:40px;">삭제</th> -->
			<!-- 상태에 따라 /resources/images/ok.png 또는 bad.png 표시 width: 16px-->
		</tr>
		<c:forEach items="${list}" var="album" varStatus="status">
			<tr data-no="${status.index}" data-code="${album.code}">
				<td style="width:20px;" onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'">${album.code}</td>
				<td style="width:40px;" onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'">${fn:substring(album.title,0,10)}</td>
				<td style="width:20px;" onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'">${album.kind}</td>
				<td onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'">${fn:substring(album.creator,0,10)}</td>
				<td onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'"><fmt:formatDate value="${album.regDate}"
						pattern="yy/MM/dd HH:mm" /></td>
				<%-- <td>${album.playTime}</td> --%>
				<td onclick="location.href='${pageContext.request.contextPath}/audiobook/detail?code=${album.code}'">
					<c:if test="${not empty album.provider}">
						${fn:substring(album.provider,0,10)}
					</c:if>
				</td>
				<td>
				 <c:choose>
					<c:when test="${'N'==album.status}">
						X
					</c:when>
					<c:otherwise>
						O
					</c:otherwise>
					</c:choose>
				</td>
				<td><button type="button" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/audiobook/album/update?code=${album.code}'">수정</button></td>
				<%-- <td><button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/audiobook/album/delete?code=${album.code}'">삭제</button></td> --%>
			</tr>
		</c:forEach>
	</table>
	${pagebar}
</section>

<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>

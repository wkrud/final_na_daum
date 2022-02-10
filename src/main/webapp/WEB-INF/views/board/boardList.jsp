<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title" />
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<style>
input#btn-add {
	float: right;
	margin: 0 0 15px;
}

.board-title {
	cursor: pointer;
}

.my.pagination > .active > span:focus {
  background: red;
  border-color: red;
}
 .movetodetail:link { color: black; text-decoration: none;}
 .movetodetail:visited { color: black; text-decoration: none;}
 .movetodetail:hover { color: blue; text-decoration: none;}

</style>
<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardEnroll.do";
}



</script>
<body>
	<section id="board-container" class="container">
	
			<%-- <nav class="navbar navbar-light bg-light">
  			<form class="form-inline">
    			<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
    			<button class="btn btn-warning" type="submit">Search</button>
  			</form>
			</nav> --%>
			
			<table id="tbl-board" class="table table-striped table-hover ">
				<tr class="bg-warning">
					<th>번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			<c:forEach items="${list}" var="board">
				<tr value="${board.code}">
					<td class="boardCode">${board.code}</td>
					<td>${board.category}</td>
					<td>
						<a class="movetodetail" href="${pageContext.request.contextPath}/board/boardDetail.do?code=${board.code}">${board.title} </a>
						<c:if test="${board.commentCount gt 0 }">{board.commentCount}</c:if>
					</td>
					<td><c:out value="${board.nickname}"></c:out></td>
					<td><fmt:formatDate value="${board.regDate}" pattern="yy/MM/dd" /></td>
					<td>${board.readCount}</td>
				</tr>
			</c:forEach>
			</table>
			<input type="hidden" name="id" id="id" value="${loginMember.id}" />
			<sec:authentication property="principal" var="loginMember" />
			<input type="button" value="글쓰기" id="btn-add"	class="btn btn-outline-warning" onclick="goBoardForm();" />
			<br />
		${pagebar}
	</section>
</body>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
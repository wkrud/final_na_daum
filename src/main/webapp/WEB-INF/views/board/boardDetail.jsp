<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<%@ page import="com.project.nadaum.member.model.vo.MemberEntity" %>
<sec:authentication property="principal" var="loginMember"/>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<sec:authentication property="principal" var="loginMember" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판상세보기" name="title" />
</jsp:include>

<sec:authentication property="principal" var="loginMember" />

<style>
div#board-container {
	
	width: 1000px;
}

input, button, textarea {
	margin-bottom: 15px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}

div.col>.detail{
border:none;
border-right:0px;
 border-top:0px; 
 boder-left:0px; 
 boder-bottom:0px;
 background-color:transparent;
 display:inline-block;
margin : 0px;
pointer-events: none; 
}
.id-detail{border:none;
border-right:0px;
 border-top:0px; 
 boder-left:0px; 
 boder-bottom:0px;
 background-color:transparent;
 display:inline-block;
margin : 0px;
font-size:20px;
pointer-events: none; 


div.col>.detail {
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	background-color: transparent;
	display: inline-block;
	margin: 0px;

}

.id-detail {
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	background-color: transparent;
	display: inline-block;
	margin: 0px;
	font-size: 20px;
}

.detailcontent {
	padding: 10px;
}
</style>
<!-- 게시글 상세보기 -->

<div id="board-container" class="mx-auto text-center">
	<div id="detail-container">

		<div id="detailcontent-container" class="form-horizontal">
			<!-- 넘겨주어야하는 값 -->
			<input type="hidden" name="code" id="countcode" value="${board.code}" /> <input
				type="hidden" name="id" id="id" value="${loginMember.id}" /> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />


			<h1 class="display-3" readonly>${board.title}</h1>

			<div class="container">

 			<div class="row row-cols-4">
    		<div class="col">작성자 : <input type="text" class="detail" id="nickname" name="nickname" value="${board.nickname}" readonly></div>
    		<div class="col">등록일자 : <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/></div>
    		<div class="col">조회수 : <input type="number" class="detail" id="readCount" name="readCount" title="조회수" value="${board.readCount}" readonly></div>
  			</div>
			</div>			
			
			

				<div class="row row-cols-4">
					<div class="col">
						작성자 : <input type="text" class="detail" id="writer" name="id"
							value="${board.id}" readonly>
					</div>
					<div class="col">
						등록일자 :
						<fmt:formatDate value="${board.regDate}"
							pattern="yyyy-MM-dd'T'HH:mm" />
					</div>
					<div class="col">
						조회수 : <input type="number" class="detail" id="readCount"
							name="readCount" title="조회수" value="${board.readCount}" readonly>
					</div>
				</div>
			</div>



			<%-- <label for="writer" class="col-sm-2 control-label">작성자</label> 
			<input type="text" class="form-control" id="writer" name="id" value="${board.id}" readonly> 
			<label for="regDate" class="col-sm-2 control-label">등록일자</label> 
			<input type="datetime-local" class="form-control" name="regDate" id="regDate" value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd'T'HH:mm"/>'readonly> 
			<label for="readCount" class="col-sm-2 control-label">조회수</label> 
			<input type="number" class="form-control" id="readCount" name="readCount" title="조회수" value="${board.readCount}" readonly> --%>


			<!-- <label for="content" class="col-sm-2 control-label">내용</label> -->
			<div class="form-control mt-3 detailcontent" name="content"
				placeholder="내용" id="content" readonly>
				<p>${board.content}</p>
			</div>

			<!-- 좋아요 -->
			<br />
			<div class="like-container">
				<button type="button" class="btn btn-primary" id="likeButton"
					data-board-code="${board.code}" data-id="${board.id}"
					data-like-yes-no="${likeYesNo}">좋아요</button>
				<br /> <span class="countlikes">${selectCountLikes}</span>
			</div>
			<!-- 좋아요 -->

		</div>
		<br />
		<div id="btn-container">
			<input type="button" class="btn btn-warning" id="listbtn" value="목록 "
				onclick="location.href ='${pageContext.request.contextPath}/board/boardList.do'">

			<%-- 작성자와 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<c:if test="${loginMember.id eq board.id}">
				<input type="button" class="btn btn-warning" id=" updatebtn"
					value="수정"
					onclick="location.href ='${pageContext.request.contextPath}/board/boardUpdateView.do?code=${board.code}'">
				<input type="button" class="btn btn-warning" id="deletebtn"
					value="삭제" onclick="deleteBoard()">
			</c:if>
		</div>

	</div>
	<hr style="margin-top: 30px;" />

	<!-- 댓글 -->
	<div class="comment-container">
		<div class="comment-editor">
			<div class="card mb-2">
				<div class="card-header bg-light">
					<i class="fa fa-comment fa"></i> 댓글 작성
				</div>
				<div class="card-body">
					<ul class="list-group list-group-flush">
						<li class="list-group-item" id="comment-li">
							<div class="form-inline mb-2">
								<label for="replyId"><i

									class="fa fa-user-circle-o fa-2x">
									<input type="text" class="id-detail" name="id" id="id" value="${loginMember.nickname}" /></i>
									</label>

									class="fa fa-user-circle-o fa-2x"> <input type="text"
										class="id-detail" name="id" id="id" value="${loginMember.id}" /></i>
								</label>

							</div>
							<form
								action="${pageContext.request.contextPath}/board/boardCommentEnroll.do"
								method="post" name="boardCommentFrm" id="insertCommentFrm">

								<!-- 현재게시글 코드 -->
								<input type="hidden" name="code" value="${board.code}" />
								<%-- <input type="hidden" name="id" value="${loginMember.id}" /> --%>
								<input type="hidden" name="id"
									value="<c:if test="${loginMember ne null}">${loginMember.id}</c:if>" />

								<!-- 댓글인 경우 1 -->
								<input type="hidden" name="commentLevel" value="1" />
								<!-- 대댓글인 경우 써여져야함 -->
								<input type="hidden" name="commentRef" value="" />

								<textarea name="content" cols="60" rows="3" id="content"
									class="form-control"></textarea>
								<button type="submit" id="btn-comment-enroll1"
									class="btn btn-warning" onClick="fn_comment('${board.code}')">등록</button>

								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
							</form>
						</li>
					</ul>
				</div>
			</div>
		</div>


		<!-- 댓글 목록 시작 -->
		<c:if test="${null ne commentList  && not empty commentList}">
			<div class="card mb-2">
				<div class="card-header bg-light">
					<i class="fa fa-comment fa"></i> 댓글 목록
				</div>
				<div class="card-body">

					<%-- 댓글이 하나가 되었다면 if구문으로 들어올꺼임 for문 돌면서 level1, ldecel2 태그를 고르고 출력--%>
					<c:forEach items="${commentList}" var="comment">
						<c:choose>

							<%-- 댓글 1단계 --%>
							<c:when test="${comment.commentLevel eq 1 }">
								<ul class="list-group list-group-flush" id="level1">
									<li class="list-group-item" id="commentList">
										<div class="form-inline mb-2">
											<label for="replyId"> <i
												class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${comment.nickname}</strong>
											</label> &nbsp;&nbsp;
											<fmt:formatDate value="${comment.regDate}"
												pattern="yyyy-MM-dd HH:mm" />
										</div> <textarea class="form-control"
											id="exampleFormControlTextarea1" rows="1" readonly="readonly">${comment.content}</textarea>

										<%-- 회원일때만 답글 버튼이 나타남 --%>
										<div class="row float-right">
											<button type="button" onclick="firstReply()"
												class="btn btn-warning btnReComment btn-reply"
												value="${comment.commentCode}">답글</button>
											&nbsp;
											<%-- 회원이고 글쓴이 본인일 경우 댓글 삭제 버튼--%>
											<c:if test="${comment.id eq loginMember.id}">
												<button type="button"
													class="btn btn-warning btnCommentDelete btn-delete"
													value="${comment.commentCode}">삭제</button>
											&nbsp;
											</c:if>
										</div>

									</li>
								</ul>
							</c:when>

							<%-- 댓글 2단계 --%>
							<c:otherwise>
								<ul class="list-group list-group-flush" id="level2">
									<li class="list-group-item" id=level2Reply
										style="padding-left: 100px;">
										<div class="form-inline mb-2">
											<label for="replyId"> <i
												class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${comment.id}</strong>
											</label> &nbsp;&nbsp;
											<fmt:formatDate value="${comment.regDate}"
												pattern="yyyy-MM-dd HH:mm" />
										</div> <textarea class="form-control"
											id="exampleFormControlTextarea1" rows="1" readonly="readonly">${comment.content}</textarea>
										<div class="row float-right">

											<!-- 회원이고 글쓴이 본인일 경우 -->

											<c:if test="${loginMember.id eq comment.id}">
												<button type="button"
													class="btn btn-warning btnCommentDelete btn-delete"
													value="${comment.commentCode}">삭제</button>
												&nbsp;
											 </c:if>

										</div>
									</li>
								</ul>
							</c:otherwise>
						</c:choose>
					</c:forEach>
		</c:if>
	</div>
</div>
<!-- 댓글 목록 끝 -->


</div>


</div>
</body>
<form name="boardDelFrm" method="POST"
	action="${pageContext.request.contextPath}/board/boardDelete.do">
	<input type="hidden" name="code" value="${board.code}" /> <input
		type="hidden" name="id" id="id" value="${loginMember.id}" /> <input
		type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<form
	action="${pageContext.request.contextPath}/board/boardCommentDelete.do"
	name="boardCommentDelFrm" method="POST">
	<input type="hidden" name="commentCode" value="${comment.commentCode}" />
	<input type="hidden" name="code" value="${board.code}" /> 
	<input type="hidden" name="id" id="id" value="${loginMember.id}" /> 
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<script>
$(document).ready(function() {
	const $code = $('#countcode').val();
	const $id = $('#id').val();
	console.log($code);
	console.log($id);
	console.log("123");
	
	
	var data = {"code":$code, "id":$id}
	$.ajax({
		url : "${pageContext.request.contextPath}/board/boardLikeTotalAdd.do",
		method : "GET",
		data : {
			id : $id,
			code : $code
		},
		success(data){
			const result = data["result"]
			const selectCountLikes = data["selectCountLikes"];
			console.log(`result : \${result}`);
			console.log(`selectCountLikes : \${selectCountLikes}`);
			
				$('#likeButton').data("likeYesNo", selectCountLikes);
				
				$(".countlikes").text(selectCountLikes);
				console.log("selectCountLikes = " + selectCountLikes);
				
					
			
		},
		error : function(xhr, status, err){
			console.log(xhr, status, err);
				alert("에러");
		}
	});
	
	
});




	//회원아이디와 글쓴이 아이디와 같은때 보임.
	//삭제 버튼을 눌렀을 때 처리
const deleteBoard = () => {
	if(confirm("이 게시물을 정말 삭제하시겠습니까?")){
		$(document.boardDelFrm).submit();		
	}
};
	//수정 버튼을 눌렀을 때 처리
const updateBoard = () => {
	location.href = "${pageContext.request.contextPath}/board/boardUpdateView.do?code=${board.code}";
};

$(".btn-delete").click(function(){
	if(confirm("해당 댓글을 삭제하시겠습니까?")){
		var $frm = $(document.boardCommentDelFrm);
		var commentCode = $(this).val();
		$frm.find("[name=commentCode]").val(commentCode);
		$frm.submit();
	}
});	

/* 대댓글 입력 */
$(".btn-reply").click((e) => {
	
	const commentRef = $(e.target).val();
	console.log(commentRef);
	
	const div = `
		<div class="" id="replycomment">
		<ul class="list-group list-group-flush" id="level2">
		<div class="card-body">
		<ul class="list-group list-group-flush">
			<li class="list-group-item" id="comment-li">
				<div class="form-inline mb-2">
					<label for="replyId"><i
						class="fa fa-user-circle-o fa-2x"></i></label>
				</div>
				<form
					action="${pageContext.request.contextPath}/board/boardCommentEnroll.do"
					method="post" id="commentForm">

					<!-- 현재게시글 코드 -->
					<input type="hidden" name="code" value="${board.code}" /> <input
						type="hidden" name="id" value="${loginMember.id}" />
					<%-- <input type="hidden" name="writer" value="<c:if test="${loginMember ne null loginMember.id }"/>" /> --%>
					<!-- 대댓글인 경우 2 -->
					<input type="hidden" name="commentLevel" value="2" />
					<!-- 대댓글인 경우 써여져야함 -->
					<input type="hidden" name="commentRef" value="\${commentRef}" />

					<textarea name="content" cols="60" rows="2" id="content" class="form-control"></textarea>
					<button type="submit" class ="btn btn-warning btn-comment-enroll2"
						onClick="fn_comment('${board.code }')">등록</button>

					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
				</form>
			</li>
		</ul>
		</div>
		</ul>
		</div>`;
	
		console.log(div);
		
		// e.target의 부모의 부모 div (등록 전체 div를 지칭)
		const $divbtn = $(e.target).parent();
		// jQuery 객체 $divOfBtn 이 div 다음으로 들어가게끔 조치
		$(div)
			.insertAfter($divbtn)
			.find("form")
			.submit((e) => {
				const $content = $("[name=content]", e.target); //여기서 e.target은 form임 (버튼이 아님)
				if(!/^(.|\n)+$/.test($content.val())){
					alert("댓글을 작성해주세요.");
					e.preventDefault();
				}
			});
		//클릭 이벤트 핸들러 (클릭시 여러번 실행되지 못하고 한번만 실행 될 수 있게)
		$(e.target).off("click");
});

/* 좋아요 */
 $(document).on('click', '#likeButton', function(e) {
	console.log("좋아요 나왕?");
	
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	const $code = $(e.target).data("boardCode");
	const $id = $('#id').val();

	var data = {"code":$code, "id":$id}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/board/boardLikeIdCount.do",
		method : "GET",
		data : {
			id : $id,
			code : $code
		},
		success(data){
			
			const selectIdCountLikes = data["selectIdCountLikes"];
			
			console.log(`selectIdCountLikes : ${selectIdCountLikes}`);
			
			if(selectIdCountLikes == 0) {
				
				$.ajax({
					url : "${pageContext.request.contextPath}/board/boardLikeAdd.do",
					method : "GET",
					data : {
						id : $id,
						code : $code
					},
					success(data){
						const result = data["result"]
						const selectCountLikes = data["selectCountLikes"];
						console.log(`result : \${result}`);
						console.log(`selectCountLikes : \${selectCountLikes}`);
						
						if(result == 1) {
							$(e.target).data("likeYesNo", selectCountLikes);
							console.log($(e.target).data("likeYesNo"));
							
							$(".countlikes").text(selectCountLikes);
							console.log("selectCountLikes = " + selectCountLikes);
							console.log("좋아요 등록!");
							alert("좋아요를 등록했습니다.");
								
						}
					},
					error : function(xhr, status, err){
						console.log(xhr, status, err);
							alert("좋아요 안됩니꽈,,,?");
					}
				});
				
				
					
			}else{
				
				$.ajax({
					url : "${pageContext.request.contextPath}/board/boardLikeDelete.do",
					method : "GET",
					data : {
						id : $id,
						code : $code
					},
					success(data){
						const result = data["result"];
						const selectCountLikes = data["selectCountLikes"];
						console.log(`result : \${result}`);
						console.log(`selectCountLikes : \${selectCountLikes}`);
						
						if(result == 1) {
							$(e.target).data("likeYesNo", selectCountLikes);
							console.log($(e.target).data("likeYesNo"));
							
							$(".countlikes").text(selectCountLikes);
							console.log("selectCountLikes = " + selectCountLikes);
							console.log("좋아요 취소!");
							alert("좋아요를 취소했습니다.");
						}
					},
					error : console.log
				})
			}
			
		},
		error : function(xhr, status, err){
			console.log(xhr, status, err);
				alert("에러");
		}
	});
	
	
});

$("#likeButton").click((e) => {
	
});
/* ajax 비동기로 처리 */
/*  $(insertCommentFrm).submit((e) => {
				e.preventDefault();
				
				const csrfHeader = "${_csrf.headerName}";
		        const csrfToken = "${_csrf.token}";
		        const headers = {};
		        headers[csrfHeader] = csrfToken;
				$.ajax({
					headers : headers,
					url: `${pageContext.request.contextPath}/board/boardCommentEnroll.do`,
					method: "POST",
					data: $(insertCommentFrm).serialize(),
					success(resp){
						console.log(resp)
						location.reload();
						alert(resp.msg);
						
					},
					error: console.log
				});
				
			}); */
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){    
    getCommentList();  
});



</script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
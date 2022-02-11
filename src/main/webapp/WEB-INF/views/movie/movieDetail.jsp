<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.project.nadaum.culture.movie.controller.GetMovieApi"%>

<sec:authentication property="principal" var="loginMember" />
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 영화상세보기 " name="movieDetail" />
</jsp:include>
<style>
.movie-detail-container {
	width: 80%;
	margin: 0 auto;
	padding-right: 15px;
	padding-left: 80px;
}

input, button, textarea {
	margin-bottom: 15px;
}

.col-sm-10 {
	vertical-align: middle;
	text-align: left;
	padding: 0px;
	display: inline-block;
}

.col-form-label {
	width: 70px;
}

.movie-detail {
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	display: inline-block;
	margin: 0px;
	background-color: transparent;
	pointer-events: none;
	height: 38px;
	font-size: 24px;
}

#movieCd-detail {
	width: 300px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}

#exampleFormControlTextarea1 {
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	background-color: transparent;
	display: inline-block;
	margin: 0px;
	pointer-events: none;
	font-size: 22px;
}

#category-select {
	width: 100px;
}

#category-select-commentList {
	width: 100px;
	display: inline-block;
	pointer-events: none;
	border: none;
	appearance: none;
}

.star-2 {
	position: relative;
	font-size: 4rem;
	color: #ddd;
}

.star-2 span {
	position: absolute;
	left: 0;
	color: #ffd400;
	overflow: hidden;
	pointer-events: none;
}

.star-count {
	position: relative;
	font-size: 1.5rem;
	color: #ddd;
}

.star-count span {
	position: absolute;
	left: 0;
	color: #ffc57d;
	overflow: hidden;
	pointer-events: none;
}

/* .rating svg:nth-child(1){
	color:#F05522; */
}
</style>

<div class="movie-detail-container">
	<!-- 영화상세보기 정보 -->
	<div class="movie-detail-content">

		<!-- 상세정보 -->
		<%-- <c:forEach var="movie" items="${list}"> --%>
		<div class="row featurette"><<%-- div class="col-md-7
			order-md-2"> <h2 class="featurette-heading"> <input type="text"
			class="form-control- movie-detail" placeholder="제목" name="title"
			id="title" value="${movie.title}" readonly> </h2> <p class="lead">
			<div class="form-group row"> <label for="date" class="col-sm-2
			col-form-label">개봉일 : </label> <div class="col-sm-10"> <input
			type="text" class="form-control- movie-detail" name="openDt"
			title="개봉일" id="date" value="${movie.releaseDate}" readonly> </div>
			</div> --%> <%-- <div class="form-group row"> <label for="nationNm"
			class="col-sm-2 col-form-label">제작국가 : </label> <div
			class="col-sm-10"> <input type="text" class="form-control-
			movie-detail" name="nation" title="제작국가" id="nationNm"
			value="${movie.nation}" readonly> </div> </div> --%> <div
			class="form-group row"> <label for="genreNm" class="col-sm-2
			col-form-label">장르 : </label> <div class="col-sm-10"> <input
			type="text" class="form-control- movie-detail" name="genreNm"
			title="장르" id="genreNm" value="${genre}" readonly> </div></div>

		<%-- <div class="form-group row">
						<label for="director" class="col-sm-2 col-form-label">감독 :
						</label>
						<div class="col-sm-10">
							<input type="text" class="form-control- movie-detail"
								name="director" title="감독" id="director"
								value="${movie.director}" readonly>
						</div>
					</div> --%>

		<%-- <div class="form-group row" >
						<label for="date" class="col-sm-2 col-form-label">개봉일 : </label>
						<div class="col-sm-10">
							<input type="text" class="form-control- movie-detail" name="openDt" title="개봉일" id="date" value="${movie.openDt}" readonly>
						</div>
					</div> --%>


	</div>
	<%-- <div class="col-md-5 order-md-1">
					<svg
						class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
						width="500" height="500" xmlns="http://www.w3.org/2000/svg"
						preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
						aria-label="Placeholder: 500x500">
						<img class="card-img-top" src="https://image.tmdb.org/t/p/w500${movie.posterPath}" alt="Card image cap" >
					<title>Placeholder</title>
					<rect width="100%" height="100%" fill="#eee" />
					</svg>
				</div> --%>
</div>
<%-- </c:forEach> --%>
<!-- 캘린더 약속 버튼 -->
<br />
<button type="button" class="btn btn-secondary" data-toggle="modal"
	data-target="#add-calander">캘린더&raquo;</button>

<!-- 스크랩 버튼 -->

<c:if test="${ loginMember.id != null }">
	<button type="button" class="btn btn-success"
		onclick="scrap(); return false;" value="${apiCode}">
		스크랩<i class="fas fa-check-double ml-1"></i>
	</button>

</c:if>


<!-- 영화 줄거리 -->
<hr />
<h2 class="blog-post-title">영화 줄거리</h2>
<p class="blog-post-meta">
	January 1, 2014 by <a href="#">Mark</a>
</p>

<p>${overview}</p>

</div>
<hr class="featurette-divider" />

<!-- 영화 평점 -->
<div class="movie-rating">
	<h2 class="blog-post-title">영화 평점</h2>
	<p class="blog-post-meta">참여자 평점 :
	<div>
		<span class="star-2"> ★★★★★ <c:if test="${rating ne null}">
				<span style="width:calc(18.9%*${rating })">★★★★★</span>
			</c:if>
		</span>
		<fmt:formatNumber value="${rating}" pattern="0.00" />
		(${totalStartComment}건)
	</div>


	<div>
		5점 : <span class="star-count"> ■■■■■■■■■■ <c:if
				test="${ starCount5 ne null}">
				<span style="width:calc(5%*${starCount5})">■■■■■■■■■■</span>
			</c:if>
		</span> (
		<fmt:formatNumber value="${starCount5}" pattern="0" />
		건)
	</div>
	<div>
		4점 : <span class="star-count"> ■■■■■■■■■■ <c:if
				test="${ starCount5 ne null}">
				<span style="width:calc(5%*${starCount4})">■■■■■■■■■■</span>
			</c:if>
		</span>(
		<fmt:formatNumber value="${starCount4}" pattern="0" />
		건)
	</div>
	<div>
		3점 : <span class="star-count"> ■■■■■■■■■■ <c:if
				test="${ starCount5 ne null}">
				<span style="width:calc(5%*${starCount3})">■■■■■■■■■■</span>
			</c:if>
		</span>(
		<fmt:formatNumber value="${starCount3}" pattern="0" />
		건)
	</div>
	<div>
		2점 : <span class="star-count"> ■■■■■■■■■■ <c:if
				test="${ starCount5 ne null}">
				<span style="width:calc(5%*${starCount2})">■■■■■■■■■■</span>
			</c:if>
		</span>(
		<fmt:formatNumber value="${starCount2}" pattern="0" />
		건)
	</div>
	<div>
		1점 : <span class="star-count"> ■■■■■■■■■■ <c:if
				test="${ starCount5 ne null}">
				<span style="width:calc(5%*${starCount1})">■■■■■■■■■■</span>
			</c:if>
		</span>(
		<fmt:formatNumber value="${starCount1}" pattern="0" />
		건)
	</div>
	<br />
</div>

<hr class="featurette-divider" />

<!-- 총 영화 댓글 -->
<div class="movie-comments">
	<!-- 댓글 작성 부분 -->
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
									class="fa fa-user-circle-o fa-2x"> <input type="text"
										class="id-detail movie-detail" name="id" id="id"
										value="${loginMember.nickname}" readonly /></i> </label>
							</div>

							<form id="insertCommentFrm">

								<!-- api 코드 -->
								<input type="hidden" name="apiCode" value="${apiCode}" />
								<%-- <input type="hidden" name="id" value="${loginMember.id}" /> --%>
								<input type="hidden" name="id"
									value="<c:if test="${loginMember ne null}">${loginMember.id}</c:if>" />
								<!-- 댓글인 경우 1 -->
								<input type="hidden" name="commentLevel" value="1" />
								<!-- 대댓글인 경우 써여져야함 -->
								<input type="hidden" name="commentRef" value="" /> <label
									for="star" class="col-sm-2 col-form-label">평점 : </label>
								<div class="col-sm-10">
									<input type="hidden" class="form-control" name=""> <select
										id="category-select" class="form-control" name="star"
										aria-label="Default select example">
										<option selected>0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
									</select>

								</div>
								<textarea name="content" cols="60" rows="3" id="content"
									class="form-control"></textarea>

								<button type="submit" id="btn-comment-enroll1"
									class="btn btn-outline-primary"
									onClick="fn_comment('${apiCode}')">등록</button>
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
						<%-- 댓글 1단계 --%>
						<c:if test="${comment.commentLevel eq 1 }">
							<ul class="list-group list-group-flush" id="level1">
								<li class="list-group-item" id="commentList">
									<div class="form-inline mb-2">
										<label for="replyId"> <i
											class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${comment.id}</strong>
										</label> &nbsp;&nbsp;
										<fmt:formatDate value="${comment.regDate}"
											pattern="yyyy-MM-dd HH:mm" />
									</div>

									<div class="col-sm-10">
										<label for="star" class="col-sm-2 col-form-label">평점 :</label>
										<input type="hidden" class="form-control" name="star">

										<select id="category-select-commentList" class="form-control"
											aria-label="Default select example">
											<option selected>${comment.star}</option>
										</select>
									</div> <textarea class="form-control"
										id="exampleFormControlTextarea1" rows="1" readonly="readonly">${comment.content}</textarea>

									<%-- 회원일때만 답글 버튼이 나타남 --%>
									<div class="row float-right">
										&nbsp;
										<%-- 회원이고 글쓴이 본인일 경우 댓글 삭제/수정 버튼--%>
										<c:if test="${comment.id eq loginMember.id}">

											<%-- 댓글 삭제 --%>
											<form id="deleteCommentFrm">
												<input type="hidden" name="code" value="${comment.code}"></input>
												<button type="submit"
													class="btn btn-outline-secondary disabled btnCommentDelete btn-delete"
													id="deleteComment-btn" value="${comment.code}">삭제</button>
											</form>
											&nbsp;
											
												<!-- 댓글 수정 -->
											<form id="findUpdateComment">
												<input type="hidden" name="code" value="${comment.code}" />
												<button type="button"
													class="btn btn-outline-dark updateCommmentBtn"
													data-toggle="modal" data-target="#updateComment"
													value="${comment.code}">수정</button>
											</form>
										</c:if>


									</div>

								</li>
							</ul>
						</c:if>
					</c:forEach>
				</div>
			</div>

		</c:if>
	</div>
</div>
<!-- 댓글 목록 끝 -->

<!-- 댓글 수정 Modal -->
<div class="modal fade" id="updateComment" tabindex="-1" role="dialog"
	aria-labelledby="updateCommentTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Comment
					update</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<form id="updateCommentFrm">
				<div class="modal-body">
					<div class="form-group row">
						<label for="star" class="col-sm-2 col-form-label">평점</label>
						<div class="col-sm-10">
							<input type="hidden" class="form-control">
							<div class="review  make_star">
								<select id="category-select" class="form-control makeStar"
									name="star" aria-label="Default select example" id="makeStar">
									<option value="">평점</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
								</select>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label for="title" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="content">
						</div>
					</div>


					<input type="hidden" name="code" value="${comment.code}" readonly />
					<input type="hidden" name="apiCode" value="${apiCode}" /> <input
						type="hidden" name="id" value="${loginMember.id}" />
					<!-- 댓글인 경우 1 -->
					<input type="hidden" name="commentLevel" value="1" />
					<!-- 대댓글인 경우 써여져야함 -->
					<input type="hidden" name="commentRef" value="" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-outline-dark"
						id="updateComment-btn" value="${comment.code}">수정</button>
				</div>
			</form>

		</div>
	</div>
</div>

<hr class="featurette-divider" />

</div>

<!-- 캘린더 Modal -->
<div class="modal fade" id="add-calander" tabindex="-1" role="dialog"
	aria-labelledby="add-calander" aria-hidden="true">
	<form id="promiseFrm">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="add-calanderTitle">약 속</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!-- 모달 내용 시작 -->
				<div class="modal-body">
					<div class="form-group row">
						<label for="title" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title" name="title"
								placeholder="제목을 입력해주세요" required>
						</div>
					</div>
					
					<div class="form-group row">
						<label for="title" class="col-sm-2 col-form-label">약속일</label>
						<div class="col-sm-10">
							<input type="date" class="form-control" id="alarmDate" name="alarmDate" required>
						</div>
					</div>
						<div class="friend-list-wrap">
							<div class="friends-list">
								<div class="friend">
									<div class="form-group row">
										<label for="title" class="col-sm-2 col-form-label">친구</label>
										<div class="col-sm-10">
											<div class="input-group mb-3">
												<div class="input-group-prepend">
												<input id="searchFriend" type="text" name="nickname" class="form-control" placeholder="닉네임을 입력하세요" aria-label="" aria-describedby="basic-addon1" required>
												<button id="search-friend-start" class="btn btn-outline-secondary" type="button">검색</button>
												</div>
											</div>
										</div>
									</div>
								<div class="search-result-list">
									<div class="list-group"></div>
								</div>
								<hr />
								<!-- 친구닉네임 검색 -->
								<div class="friends-section">
									<c:forEach items="${memberList}" var="ml">
										<c:forEach items="${friends}" var="fr">
											<c:if test="${ml.id eq fr.friendId}">
												<div class="friend-wrap">
													<div class="friend-name-wrap">
														<span class="friend-name">${ml.nickname}</span>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</c:forEach>
								</div>
								
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">추가</button>
					</div>
				</div>
				<!-- 모달 내용 끌 -->
			</div>
		</div>
	</form>
</div>

<script>

/* 댓글 등록 */
$(insertCommentFrm).submit((e) => {
	e.preventDefault();
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    
	$.ajax({
		url: `${pageContext.request.contextPath}/movie/movieDetail/${apiCode}`,
		method: "POST",
		headers : headers,
		data: $(insertCommentFrm).serialize(),
		success(resp){
			console.log(resp)
			location.reload();
			alert(resp.msg);
			
		},
		error: console.log
	});
	
});

/* 댓글 삭제 */
 $(deleteCommentFrm).submit((e) => {
				e.preventDefault();
				const code = $(e.target).find("[name=code]").val();
				console.log(code);
				
				const csrfHeader = "${_csrf.headerName}";
		        const csrfToken = "${_csrf.token}";
		        const headers = {};
		        headers[csrfHeader] = csrfToken;
				var data = {"code" : code};
		        
				$.ajax({
					url:`${pageContext.request.contextPath}/movie/movieDetail/${apiCode}/\${code}`,
					method: "DELETE",
					headers : headers, 
					type : "POST",
					data : JSON.stringify(data),
					success(resp){
						console.log(resp);
						location.reload();
						alert(resp.msg);
					},
					error(xhr,statusText){
						switch(xhr.status){
						case 404: alert("해당 댓글이 존재하지않습니다."); break;
						default: console.log(xhr, statusText);
						}				
					}
				});
			});  
 
 	/* 댓글 수정  */
 $(updateCommentFrm).submit((e) => {	
	 
 		e.preventDefault();
 		const code = $(e.target).val();
 		console.log(e.target);
 		console.log(code);
 		
		const obj = {
			id : $("[name=id]", e.target).val(),
			code : $("[name=code]", e.target).val(),
			star : $("[name=star]", e.target).val(),
			content : $("[name=content]", e.target).val(),
			apiCode : $("[name=apiCode]", e.target).val(),
			commentLevel : $("[name=commentLevel]", e.target).val(),
			commentRef : $("[name=commentRef]", e.target).val(),
		};
		
		const csrfHeader = "${_csrf.headerName}";
    	const csrfToken = "${_csrf.token}";
    	const headers = {};
     	headers[csrfHeader] = csrfToken;
     	
     	//var data = {"code": code, "star": star, "content": content};
     	const jsonStr = JSON.stringify(obj);
     	
		$.ajax({
			url: `${pageContext.request.contextPath}/movie/movieDetail/${apiCode}`,
			method: "PUT",
			headers : headers,
			data: jsonStr,
			contentType: 'application/json; charset=utf-8',
			success(resp){
				console.log(resp)
				location.reload();
				alert(resp.msg);
			},
			error: console.log
		});
		
	});
 	
 	$(".updateCommmentBtn").click((e)=> {
 		const code = $(e.target).val();
 		console.log(e.target);
 		console.log(code);
 		
 		$.ajax({
 			url : `${pageContext.request.contextPath}/movie/movieDetail/${apiCode}/\${code}`,
 			method: "GET",
 			success(resp){
 				console.log(resp);
 				const {content, star, code} = resp;
 				const $frm = $(updateCommentFrm);
 				$frm.find("[name=content]").val(content);
 				$frm.find("[name=star]").val(star);
 				$frm.find("[name=code]").val(code);
 			},
 			error(xhr, textStatus, err) {
 				if(xhr.status == 404)
 					alert("수정할 댓글을 조회하지 못했습니다.");
 				else
 					console.log(xhr, textStatus, err);
 			}
 		});
 	});
 
	//친구검색	========================================================================================
	var dest = '${loginMember.nickname}';
	const $search = $("#searchFriend");
	$search.on('keyup', function(e){
		if($search.val() != ''){
			if(e.key === 'Enter' || e.keyCode === 13){
				$("#search-friend-start").trigger('click');
			}
		}
	});
	$("#search-friend-start").click((e) => {
		if($("#searchFriend").val() == ''){
			alert("닉네임을 입력해주세요");
			return false;
		};
		let friend = $("#searchFriend").val();
		$.ajax({
			url: `${pageContext.request.contextPath}/member/mypage/searchStartFriend.do?friend=\${friend}`,
			success(resp){
				let searched = '';
				const $resultDiv = $(".search-result-list").find("div");
				$resultDiv.empty();
				if(resp == '0'){
					searched = `<span>그런 친구는 없어요</span>`;
					$resultDiv.append(searched);
					return;
				}else{
					if(resp.check == 'friend'){
						searched = `<span>\${resp.nickname}</span>
							<button type="button" class="btn btn-success btn-sm friend">친구</button>`;
					}else if(resp.check == 'follower'){
						searched = `<span>\${resp.nickname}</span>
							<button type="button" class="btn btn-outline-warning btn-sm follower">맞팔하기</button>`;
					}else if(resp.check == 'following'){
						searched = `<span>\${resp.nickname}</span>
							<button type="button" class="btn btn-warning btn-sm following">친구신청중</button>`;
					}else if(resp.check == 'free'){
						searched = `<span>\${resp.nickname}</span>
							<button type="button" class="btn btn-outline-warning btn-sm free">친구추가</button>`;
					}
				}
				
				$resultDiv.append(searched);
				
			},
			error: console.log
		});
	});

</script>
<script>
/* 별점 */
const drawStar = (target) => {
	document.querySelector(`.star span`).style.width = `${target.value * 10}%`;
	
	if(document.querySelector(`.star span`).style.width == '10%'){
		$("#section-rating #rating-3").text("0.5");
		$("#section-rating #rating-result").val("0.5");
	} else if(document.querySelector(`.star span`).style.width == '20%'){
		$("#section-rating #rating-3").text("1.0");
		$("#section-rating #rating-result").val("1.0");
	} else if(document.querySelector(`.star span`).style.width == '30%'){
		$("#section-rating #rating-3").text("1.5");
		$("#section-rating #rating-result").val("1.5");
	} else if(document.querySelector(`.star span`).style.width == '40%'){
		$("#section-rating #rating-3").text("2.0");
		$("#section-rating #rating-result").val("2.0");
	} else if(document.querySelector(`.star span`).style.width == '50%'){
		$("#section-rating #rating-3").text("2.5");
		$("#section-rating #rating-result").val("2.5");
	} else if(document.querySelector(`.star span`).style.width == '60%'){
		$("#section-rating #rating-3").text("3.0");
		$("#section-rating #rating-result").val("3.0");
	} else if(document.querySelector(`.star span`).style.width == '70%'){
		$("#section-rating #rating-3").text("3.5");
		$("#section-rating #rating-result").val("3.5");
	} else if(document.querySelector(`.star span`).style.width == '80%'){
		$("#section-rating #rating-3").text("4.0");
		$("#section-rating #rating-result").val("4.0");
	} else if(document.querySelector(`.star span`).style.width == '90%'){
		$("#section-rating #rating-3").text("4.5");
		$("#section-rating #rating-result").val("4.5");
	} else if(document.querySelector(`.star span`).style.width == '100%'){
		$("#section-rating #rating-3").text("5.0");
		$("#section-rating #rating-result").val("5.0");
	}
}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

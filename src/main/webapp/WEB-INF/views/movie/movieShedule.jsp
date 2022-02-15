<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.project.nadaum.culture.movie.controller.GetMovieApi"%>
<%@ page import="com.project.nadaum.member.model.vo.MemberEntity"%>
<%@ page import="com.project.nadaum.culture.movie.model.vo.*"%>

<sec:authentication property="principal" var="loginMember" />
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 영화상세보기 " name="movieDetail" />
</jsp:include>
<link href='${pageContext.request.contextPath}/resources/css/movie/moviedetail.css' rel='stylesheet' />

<div class="movie-detail-container">
	<!-- 영화상세보기 정보 -->
	<div class="movie-detail-content">

		<!-- 상세정보 -->
		<c:forEach var="movie" items="${list}">
			<div class="row featurette top-detail">
				<div class="col-md-7 order-md-2">
					<h1 class="featurette-heading">${movie.title}</h1>
					<div class="form-group row">
						<label for="date" class="col-sm-2 col-form-label">개봉일
							: </label>
						<div class="col-sm-10">
							<input type="text" class="form-control- movie-detail"
								name="openDt" title="개봉일" id="date" value="${movie.releaseDate}"
								readonly>
						</div>
					</div>
					
					<div class="form-group row">
						<label for="genreNm" class="col-sm-2 col-form-label">장르 :
						</label>
						<div class="col-sm-10">

							<input type="text" class="form-control- movie-detail"
								name="genreNm" title="장르" id="genreNm" value="${movie.genre}"
								readonly>

						</div>
					</div>
					
					<div class="form-group row">
						<label for="nationNm" class="col-sm-2 col-form-label">영화 줄거리
							: </label>
						<div class="col-sm-10">
							
								<p class="blog-post-meta overView">
			${movie.overview}
		</p>
						</div>
					</div> 
					

				</div>
				<div class="col-md-5 order-md-1 movie-detail-poster">
					
					<img
						class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto movie-detail-poster-image"
						src="https://image.tmdb.org/t/p/w500${movie.posterPath}" 
						alt="Card image cap">
				</div>
			</div>
		</c:forEach>
		<br />
		<!-- 스크랩 버튼 -->
		<c:if test="${ loginMember.id != null }">
			<button type="button" class="btn btn-success" value="${apiCode}" id="scrapButton"
					data-api-code ="${apiCode}" data-id="${loginMember.id}" >
				스크랩<i class="fas fa-check-double ml-1"></i>
			</button>
		</c:if>
		
		<!-- 캘린더 확인 모달 버튼 -->
		<button type="button" class="btn btn-secondary" data-toggle="modal"data-target="#check-calander">약속확인&raquo;</button>
		
		<!-- 비슷한 영화 -->
		<hr />
		<div class="widget_form">
		<div class="upcoming-movie-item">

			<!-- 슬라이드 시작 -->
			<div class="page-wrapper" style="position: relative;">
				<!--page slider -->
				<div class="post-slider">
					<h1 class="silder-title">비슷한 영화들</h1>

					<!-- 왼쪽 방향 버튼 -->
					<i class="fas fa-chevron-left prev"></i>
					<!-- 오른쪽 방향 버튼 -->
					<i class="fas fa-chevron-right next"></i>
					<div class="post-wrapper">
						<c:forEach var="movie" items="${similarList}">
							<div class="card post movie-card" >
								<img class="card-img-top movie-img"
									src="https://image.tmdb.org/t/p/w500${movie.posterPath}"
									alt="Card image cap"
									onclick="location.href='${pageContext.request.contextPath}/movie/movieDetail/${movie.apiCode}'">
								<div class="card-body post-info">
									<p class="card-text widget-movie-title">${movie.title}</p>
								</div>
							</div>

						</c:forEach>

					</div>

				</div>
				<!--post slider-->
			</div>
		</div>
		<!-- 슬라이드 끝 -->
	</div>
	<br />
	<br />
	<br />
<!-- 비슷한 영화 끝 -->

	</div>
	<hr class="featurette-divider" />

	<!-- 영화 평점 -->
	<div class="movie-rating">
		<h2 class="blog-post-title">영화 평점</h2>
		<p class="blog-post-meta">
			<c:forEach items="${list }" var="movie">영화 평점 : ${movie.voteAverage}</c:forEach>
		</p>
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
									<div class="form-inline mb-2">
										<div class="profileimg1">
											<div class="profileimg-detail1"
												style="border-radius: 50%; width: 45px; height: 45px; overflow: hidden; padding: 0;">
												<c:if test="${loginMember.loginType eq 'K'}">
													<img src="${loginMember.profile}" alt=""
														style="width: 45px; height: 45px; object-fit: cover;" />
												</c:if>
												<c:if test="${loginMember.loginType eq 'D'}">
													<c:if test="${loginMember.profileStatus eq 'N'}">
														<img
															src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png"
															alt=""
															style="width: 45px; height: 45px; object-fit: cover;" />
													</c:if>
													<c:if test="${loginMember.profileStatus eq 'Y'}">
														<img
															src="${pageContext.request.contextPath}/resources/upload/member/profile/${loginMember.profile}"
															alt=""
															style="width: 45px; height: 45px; object-fit: cover;" />
													</c:if>
												</c:if>
											</div>

										</div>
										<div class="profileimg2">
											<label for="replyId"> <input type="text"
												class="id-detail" name="id" id="replyId"
												value="${loginMember.nickname}" />
											</label>
										</div>
									</div>
								</div>

								<form id="insertCommentFrm">

									<!-- api 코드 -->
									<input type="hidden" name="apiCode" value="${apiCode}" />
									<input type="hidden" name="id" value="${loginMember.id}" />
									<!-- 댓글인 경우 1 -->
									<input type="hidden" name="commentLevel" value="1" />
									<!-- 대댓글인 경우 써여져야함 -->
									<input type="hidden" name="commentRef" value="" /> <label
										for="star" class="col-sm-2 col-form-label comment-rating">평점 : </label>


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
										class="btn btn-outline-primary">등록</button>
									
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
											<label for="replyId">
												<div class="form-inline mb-2">
													<div class="profileimg1">
														<div class="profileimg-detail1"
															style="border-radius: 50%; width: 45px; height: 45px; overflow: hidden; padding: 0;">
															<c:if test="${comment.loginType eq 'K'}">
																<img src="${comment.profile}" alt=""
																	style="width: 45px; height: 45px; object-fit: cover;" />
															</c:if>
															<c:if test="${comment.loginType eq 'D'}">
																<c:if test="${comment.profileStatus eq 'N'}">
																	<img
																		src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png"
																		alt=""
																		style="width: 45px; height: 45px; object-fit: cover;" />
																</c:if>
																<c:if test="${comment.profileStatus eq 'Y'}">
																	<img
																		src="${pageContext.request.contextPath}/resources/upload/member/profile/${comment.profile}"
																		alt=""
																		style="width: 45px; height: 45px; object-fit: cover;" />
																</c:if>
															</c:if>
														</div>

													</div>
													<div class="profileimg2">
														<label for="replyId"> <input type="text"
															class="id-detail" name="id" id="replyId"
															value="&nbsp;&nbsp;${comment.nickname}" />
														</label>
													</div>
												</div>

											</label> &nbsp;&nbsp;
											<fmt:formatDate value="${comment.regDate}"
												pattern="yyyy-MM-dd HH:mm" />
										</div>

										<div class="col-sm-10">
											<label for="star" class="col-sm-2 col-form-label">평점
												:</label> <input type="hidden" class="form-control" name="star">

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
											<c:if test="${loginMember.id eq comment.id}">

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
							id="updateCommmentBtn" value="${comment.code}">수정</button>
					</div>
				</form>

			</div>
		</div>
	</div>

	<hr class="featurette-divider" />

</div>

<!-- 캘린더 확인 모달 시작 -->
<div class="modal fade" id="check-calander" tabindex="-1" role="dialog"
		aria-labelledby="check-calander" aria-hidden="true">
		<form id="promiseReceiveFrm">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="add-calanderTitle">약 속</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="form-group row">
							<label for="title" class="col-sm-2 col-form-label">상대<br>닉네임</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="mynickname"  id="receive-mynickname"/>
								<input type="hidden" class="form-control" name="friendnickname"  id="receive-friendnickname"/>
							</div>
						</div>
					
						<div class="form-group row">
							<label for="title" class="col-sm-2 col-form-label">내용</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="receive-title" name="title">
							</div>
						</div>

						<div class="form-group row">
							<label for="title" class="col-sm-2 col-form-label">약속일</label>
							<div class="col-sm-10">
								<input type="date" class="form-control" id="receive-startDate"
									name="startDate">
									<input type="date" id="receive-endDate" name="endDate" style="display:none"/>
							</div>
						</div>
							<input type="hidden" name="allDay" id="receive-allDay" /> 
							<input type="hidden" name="type"  value="lol"/>
							<input type="hidden" name="borderColor"  value="#9775fa"/>
							<input type="hidden" name="backgroundColor"  value="#9775fa"/>
							<input type="hidden" name="textColor"  value="#ffffff"/>
							<input type="hidden" name="id" value="${loginMember.id}" />
							<input type="hidden" name="friendid" id="receive-friendId" />
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">추가</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
<!-- 캘린더 확인 모달 끝 -->
<script>
$(document).ready(function() {
	
	const timeConvert = (t) => {
	    var unixTime = Math.floor(t / 1000);
	    var date = new Date(unixTime*1000);
	    var year = date.getFullYear();
	    var month = "0" + (date.getMonth()+1);
	    var day = "0" + date.getDate();
	    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
	}
			
	const $scheduleCheckCode ='${schedulecode}';
			
		 	var data = {"schedulecode":$scheduleCheckCode}
			$.ajax({
				url : "${pageContext.request.contextPath}/movie/movieScheduleCheck.do",
				method : "GET",
				data : {
					schedulecode : $scheduleCheckCode
					
				},
				success(data){
					const accept = data["accept"];
					const allDay = data["allDay"];
					const friendnickname = data["friendnickname"];
					const mynickname = data["mynickname"];
					const startDate = data["startDate"];
					const content = data["content"];
					const friendid = data["friendid"];
					
					$('#receive-title').val(content);
					$('#receive-startDate').val(timeConvert(startDate));
					$('#receive-endDate').val(timeConvert(startDate));
					$('#receive-mynickname').val(mynickname);
					$('#receive-friendnickname').val(friendnickname);
					$('#receive-allDay').val(allDay);
					$('#receive-friendId').val(friendid);
					
					 $(promiseReceiveFrm).submit((e) => {
							e.preventDefault();
					
					     
								$.ajax({
									url:`${pageContext.request.contextPath}/movie/movieReceiveSchedule.do`,
									method: "POST",
									headers : headers, 
									data : $(promiseReceiveFrm).serialize(),
									success(resp){
										location.reload();
										const msg = resp["msg"];
										alert(msg);
										
										},
									error: console.log
									});
						}); 
				},
				error : function(xhr, status, err){
					console.log(xhr, status, err);
						alert("에러");
				}
			}); 
});	

$('.post-wrapper').slick({
	slidesToShow : 7,
	slidesToScroll : 1,
	autoplay : true,
	autoplaySpeed : 2000,
	nextArrow : $('.next'),
	prevArrow : $('.prev'),
});

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
<c:forEach items="${commentList}" var="comment">
    <c:if test="${comment.id eq loginMember.id}">
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
      </c:if>
</c:forEach>
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
</script>
<script>
$(document).on('click', '#scrapButton', function(e) {
	console.log("스크랩 찍힘?");
	
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	headers[csrfHeader] = csrfToken;
	
	const $apiCode = $(e.target).data("apiCode");
	const $id = $(e.target).data("id");
	
	
	var data = {"apiCode" : $apiCode, "id":$id}
	console.log("data");
	console.log(data);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/movie/movieCheckScrap.do",
		method : "GET",
		data : {
			apiCode : $apiCode,
			id : $id
		},
		success(data){
			const checkScrap = data["checkScrap"];
			console.log(`checkScrap : ${checkScrap}`);
			
			if(checkScrap == 0) {
				$.ajax({
					url : "${pageContext.request.contextPath}/movie/movieInsertScarp.do",
					method : "get",
					data : {
						apiCode : $apiCode,
						id : $id
					},
					success(data){
						const result = data["result"];
						console.log(`result : \${result}`);
						
						if(result == 1) {
							$(e.target).data("scrapYesNo", checkScrap);
							console.log($(e.target).data("scrapYesNo"));
							console.log("스크랩 성공!");
							alert("해당 영화를 스크랩 하였습니다.");
						}
					},
					error : function(xhr, status, err){
						console.log(xhr, status, err);
							alert("스크랩 안 되 나 욥,,?");
					}
					
					}); //두번째 ajax 괄호		
			} //if(checkScrap == 0) 괄호
			else{
				$.ajax({
					url : "${pageContext.request.contextPath}/movie/movieDeleteScrap.do",
					method : "GET",
					data : {
						apiCode : $apiCode,
						id : $id
					},
					success(data){
						const result = data["result"];
						console.log(`result : \${result}`);
						
						if(result == 1) {
							$(e.target).data("scrapYesNo", checkScrap);
							console.log($(e.target).data("scrapYesNo"));
							
							console.log("스크랩 취소!");
							alert("해당 영화를 스크랩 취소 하였습니다.");
						}
					},
					error : console.log
				});
			}
		}, //첫번째 ajax success 괄호
		error : function(xhr, status, err){
			console.log(xhr, status, err);
			alert("스크랩 자체 에러~ㅠ")
		}
	}); //첫번째 ajax 괄호
				
}); //끝 괄호

</script>
<script src="${pageContext.request.contextPath}/resources/js/movie/rating.js"></script>

<%-- <jsp:include page="/WEB-INF/views/movie/movieScheduleDetail.jsp"></jsp:include> --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

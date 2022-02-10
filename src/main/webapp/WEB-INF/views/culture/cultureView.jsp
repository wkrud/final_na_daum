<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
 <script src="https://kit.fontawesome.com/4123702f4b.js" crossorigin="anonymous"></script>
<style>
.form-control{
display: inline-block;
}

#culture-container{
    padding: 60px;
    margin: 120px;
    background: white;
    width: 50%;
    border-radius: 5%;
    box-shadow: lightgrey 2px 10px 30px 5px;
}

}
.fa-heart{
font-size: 30px;
}
.wrap{
margin: 0 auto;
/* position: relative;
z-index: 1; */
}
#insertCommentFrm{
text-align: center;
}
#comment-table{
    margin-left: 10%;
    width: 100%;
    margin-top: 50px;
}
#comment-delete{
	width: 30%;
}
.kakao-map:before{
margin: 0 auto;
}
#promiseFrm{
    margin-top: 180px;
}
</style>

<script>
//cultureDetail
$(() => {
		
		//날짜 넣기
		const value = new Date();
		
		const f = n => n < 10 ? "0" + n : n;
		// yyyy-mm-dd
		const today = `\${value.getFullYear()}-\${f(value.getMonth() + 1)}-\${f(value.getDate())}`;
		console.log(today);
		
		schedule = document.getElementById("schedule-date");
		schedule.value = today;
});



</script>
	<div class="wrap" style="">
	<div id="culture-container" class="mx-auto text-center">
		<!-- 상세내용 -->
		 <c:forEach var="culture" items="${list}">
			<div class="culture_detail">
			<h1 id="culture-title">${culture.title}</h1>
				<fmt:parseDate value="${culture.startDate}" var="startDateParse" pattern="yyyyMMdd"/>
				<fmt:formatDate value="${startDateParse}" pattern="yyyy년 MM월 dd일"/>
				<span>~</span>
				<fmt:parseDate value="${culture.endDate}" var="endDateParse" pattern="yyyyMMdd"/>
				<fmt:formatDate value="${endDateParse}" pattern="yyyy년 MM월 dd일"/>
				<br />
				<img src="${culture.imgUrl}" alt="" style="width: 50%;"/>
				<br />
				<span>${culture.area}</span>
				<span>${culture.realmName}</span>
				<br />
				<span id="placeAddr">${culture.placeAddr}</span>
				<br />
				<span>${culture.price}</span>
				<br />
				<a href="${culture.placeUrl}">${culture.placeUrl}</a>
			</div>
		 <button type="button" class="btn btn-secondary" onclick="location.href='${culture.bookingUrl}'">예매하기</button>
		</c:forEach>
		<br />
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#add-calander">
 		캘린더에 추가
		</button>
		<!-- scrap.api_code eq apiCode -->
		<form id="likeFrm">
			<input type="hidden" name="apiCode" value="${apiCode}" />
			<input type="hidden" name="id" value="${loginMember.id}" />
		 	<button type="submit" class="btn btn-danger" id="like-btn" data-like-yes-no="${likeYesNo}">스크랩 하기
		 	</button>
		</form>
		${selectCountLikes}
		
	<hr>
	<!-- kakao 지도 -->
	<div class="kakao-map">
		<p >
		    <em class="link">
		        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
		        </a>
		    </em>
		</p>
		<div id="map" style="width:80%;height:400px; margin: 0 auto;"></div>
	</div>
		
	</div>
	<!-- culture-container 끝 -->
	
	<div class="container">
	<hr />
	<br />
		<div class="insert-comment">
			<form id="insertCommentFrm">
				<input type="hidden" name="apiCode" value="${apiCode}"/>
	            <input type="hidden" name="id" value="${loginMember.id}" />
	            <input type="hidden" name="commentLevel" value="1" />
	            <input type="hidden" name="commentRef" value="" />    
		           <select name="star">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				<textarea name="content"class="form-control col-sm-6" rows="3" id="comment-area"></textarea>
	            <button type="submit" class="btn btn-light" id="comment-enroll-btn">등록</button>
			</form>
		</div>
		<table id="comment-table">
		<c:forEach var="comment" items="${commentList}">
				<tr class="level1">
					<td id="comment">
						
						<sub class="comment-writer"></sub>
						<sub class="comment-date">
						<fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd"/>
						</sub>
						<sub class="star">${comment.star}</sub>
						<br />
						${comment.content}
						<br />
						
				    	<%-- <form id="updateCommentFrm">
				    		<input type="hidden" name="code" value="${comment.code}"/>
				    		<input type="submit" id="updateComment-btn" value="수정" >
				    	</form>
				    	 --%>
					</td>		
					<td id="comment-delete">
						<form id="deleteCommentFrm">
							<input type="hidden" name="code" value="${comment.code}"></input>
							<c:if test="${comment.id eq loginMember.id}">
							<button type="submit" class="btn btn-outline-danger" id="deleteComment-btn">삭제</button>
				    		</c:if>
				    	</form>
					</td>
				</tr>
				
				</c:forEach>
				</table>
				</div>
						<!-- Modal -->
		<div class="modal fade" id="add-calander" tabindex="-1" role="dialog" aria-labelledby="add-calander" aria-hidden="true">
		  <form id="promiseFrm">
		    <div class="modal-dialog modal-dialog-centered" role="document">
		      <div class="modal-content">
		        <div class="modal-header">
		          <h5 class="modal-title" id="add-calanderTitle">약 속</h5>
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">&times;</span>
		          </button>
		        </div>
		        <div class="modal-body">
		        <span>제목</span>
		        <input type="text" />
		         <span>약속일</span>
		         <input type="date" id="schedule-date" />
		         <br />
		         <br />
		         <div>
		         	<div class="friend-list-wrap">
						<div class="friends-list">
							<div class="friend">
								<span>친구</span>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<input id="searchFriend" type="text" name="title" class="form-control" required placeholder="닉네임을 입력하세요" aria-label="" aria-describedby="basic-addon1">
									<button id="search-friend-start" class="btn btn-outline-secondary" type="button">검색</button>
								</div>
							</div>
							<div class="search-result-list">
								<div class="list-group">
								</div>
							</div>
							<hr />
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
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		          <button type="button" class="btn btn-primary">추가</button>
		        </div>
		      </div>
		    </div>
		    </div>
		  </form>
		</div>
	<script>
	//스크랩===========================================================================================
	$(likeFrm).submit((e) => {
		e.preventDefault();

		const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
        

		const likeYesNo = $(e.target).data("likeYesNo");
		console.log(likeYesNo);
		
		if(likeYesNo == 1){ 
			$.ajax({
				url:`${pageContext.request.contextPath}/culture/board/view/${apiCode}/likes`,
				method: "POST",
				headers : headers, 
				data : $(likeFrm).serialize(),
				success(resp){
					const result = data["result"]
					const selectCountLikes = data["selectCountLikes"];
					console.log(`result : \${result}`);
					console.log(`selectCountLikes : \${selectCountLikes}`);
					if(result == 1) {
						$(e.target).data("likeYesNo", 1);
						console.log($(e.target).data("likeYesNo"));
						
						console.log("selectCountLikes = " + selectCountLikes);
						console.log("좋아요 등록!");
						alert("좋아요를 등록했습니다.");
						}
					console.log(resp);
					location.reload();
					alert(resp.msg);
					},
				error: console.log
				})
			};
		});

	
	//댓글 공백 방지
	$("#comment-enroll-btn").click((e) => {
		if($("#comment-area").val() == ''){
			alert('댓글을 작성해 주세요');
			return false;
		}
		return true;
	});

			//댓글 등록
			$(insertCommentFrm).submit((e) => {
				
				e.preventDefault();

				const csrfHeader = "${_csrf.headerName}";
			    const csrfToken = "${_csrf.token}";
			    const headers = {};
			    headers[csrfHeader] = csrfToken;
			    
				$.ajax({
					headers : headers, 
					url: `${pageContext.request.contextPath}/culture/board/view/${apiCode}`,
					method: "POST",
					data: $(insertCommentFrm).serialize(),
					success(resp){
						console.log(resp)
						location.reload();
						alert(resp.msg);
						
					},
					error: console.log
				});
				
			});
			
			
			
			//댓글삭제
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
					url:`${pageContext.request.contextPath}/culture/board/view/${apiCode}/\${code}`,
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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=457ac91e7faa203823d1c0761486f8d7&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var placeList = new Array();

<c:forEach var="culture" items="${list}">
	placeList.push("${culture.place}");
	placeList.push("${culture.placeAddr}");
</c:forEach>
console.log(placeList);

var place = placeList[0];
var placeAddr = placeList[1];
console.log(place);
console.log(placeAddr);

// 주소로 좌표를 검색합니다
geocoder.addressSearch(placeAddr, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+ place +
            '</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

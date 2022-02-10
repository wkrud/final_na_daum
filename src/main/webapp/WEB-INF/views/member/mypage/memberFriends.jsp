<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 친구관리" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<div class="member-body">
	<div class="find-friend-page-button">
		<button type="button" class="btn btn-outline-warning" id="searchFriendBtn">친구검색</button>
	</div>
	<div class="friend-list-wrap">
		<div class="friends-list">
			<div class="friend">
				<span>친구</span>
			</div>
			<div class="friends-section">
				<c:forEach items="${memberList}" var="ml">
					<c:forEach items="${friends}" var="fr">
						<c:if test="${ml.id eq fr.friendId}">
							<div class="friend-wrap">
								<div class="login-member-thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
									<c:if test="${ml.loginType eq 'K'}">
										<img src="${ml.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />								
									</c:if>
									<c:if test="${ml.loginType eq 'D'}">									
										<c:if test="${ml.profileStatus eq 'N'}">							 		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
										</c:if>						
										<c:if test="${ml.profileStatus eq 'Y'}">		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${attach.renamedFilename}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
										</c:if>	
									</c:if>
								</div>
								<div class="friend-name-wrap">
									<span class="friend-name">${ml.nickname}</span>								
								</div>
								<div class="friend-btn">
									<button type="button" class="btn btn-outline-danger end-friend">친구삭제</button>
								</div>							
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
		<div class="followers-list">
			<div class="follower">
				<span>팔로워</span>
			</div>
			<div class="followers-section">
				<c:forEach items="${memberList}" var="ml">
					<c:forEach items="${follower}" var="fo">
						<c:if test="${ml.id eq fo.followerId}">
							<div class="follower-wrap">
								<div class="login-member-thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
									<c:if test="${ml.loginType eq 'K'}">
										<img src="${ml.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />								
									</c:if>
									<c:if test="${ml.loginType eq 'D'}">									
										<c:if test="${ml.profileStatus eq 'N'}">							 		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
										</c:if>						
										<c:if test="${ml.profileStatus eq 'Y'}">		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${attach.renamedFilename}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
										</c:if>	
									</c:if>
								</div>
								<div class="follower-name-wrap">
									<span class="follower-name">${ml.nickname}</span>
								</div>		
								<div class="follower-btn">
									<button type="button" class="btn btn-outline-warning friend-with-follower">친구추가</button>
								</div>					
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="search-right-wrap">
		<div class="search-right">
			<label for="search">검색여부</label>
			<input type="checkbox" name="search" id="search" ${loginMember.search eq 'T' ? 'checked' : ''} />			
		</div>
	</div>
</div>
<script>
const $search = $("#search");
$search.change((e) => {
	let searchCheck = '';
	let id = '${loginMember.id}';
	if($search.is(':checked')){
		searchCheck = 'T';
	}else{
		searchCheck = 'F';
	}
	$.ajax({
		url: '/nadaum/member/memberUpdate.do',
		method: 'POST',
		headers: headers,
		data: {id,search:searchCheck},
		success(resp){
			console.log(resp);
		},
		error: console.log
	});
});

$(function(){
	$(".friends-section").slick({
		infinite: true,
		slidesToShow: 10,
		slidesToScroll: 1,
		speed: 100,
		arrows: true,
		autoplay: false,
		vertical: false,
		prevArrow : "<button type='button' class='slick-prev'>Previous</button>",		
		nextArrow : "<button type='button' class='slick-next'>Next</button>"
	});
	$(".followers-section").slick({
		infinite: true,
		slidesToShow: 10,
		slidesToScroll: 1,
		speed: 100,
		arrows: true,
		autoplay: false,
		vertical: false,
		prevArrow : "<button type='button' class='slick-prev'>Previous</button>",		
		nextArrow : "<button type='button' class='slick-next'>Next</button>"
	});
});

/* $(".friend-wrap").click((e) => {
	let guest = $(e.currentTarget).find('span.friend-name').html();
	if(confirm(guest + '님과 DM을 하시겠습니까?')){
		var room = Math.floor(Math.random() * 100000);
		console.log('room = ' + room);
		
		const name = `chatRoom\${room}`;
		const spec = "left=500px, top=500px, width=450px, height=620px";
		const url = `${pageContext.request.contextPath}/member/mypage/chat.do?room=\${room}`;
		
		chatInvite('chat', '${loginMember.nickname}', guest, room);
		windowObjHistorySearch = window.open(url, name, spec);	
	}
}); */

$(searchFriendBtn).click((e) => {
	const spec = "left=500px, top=500px, width=265px, height=285px";
	const popup = open('${pageContext.request.contextPath}/member/mypage/memberFindFriend.do', '친구찾기', spec);
});

$(".friend-with-follower").click((e) => {
	let nickname = $(e.target).parent().parent().find('span').text();
	friendAlarm('friend', 'follower', '${loginMember.nickname}', nickname);
	updateFriend('follower', nickname);
});

$(".end-friend").click((e) => {
	let nickname = $(e.target).parent().parent().find('span').text();
	friendAlarm('friend', 'friend', '${loginMember.nickname}', nickname);
	updateFriend('friend', nickname);
});

const updateFriend = (check, friendNickname) => {
	
	/* const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken; */
	
	$.ajax({
		url: '${pageContext.request.contextPath}/member/mypage/updateFriend.do',
		data: {check, friendNickname},
		headers: headers,
		method: "POST",
		success(resp){
			if(resp == '0')
				location.reload();
			else{
				console.log("change success");
				location.reload();
			}
		},
		error: console.log
	});
};

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
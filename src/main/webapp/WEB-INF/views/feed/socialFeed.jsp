<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 내 피드" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<script src="${pageContext.request.contextPath}/resources/js/feed/socialFeed.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feed/onePersonFeed.css" />
<div class="feed-section-wrap">
	<div class="one-person-feed-wrap">
		<div class="one-person-profile-area">
			<div class="profile-img-area">
				<div class="profile-div">
					<c:if test="${member.loginType eq 'K'}">
						<img src="${member.profile}" alt="" />
					</c:if>
					<c:if test="${member.loginType eq 'D'}">
						<c:if test="${member.profileStatus eq 'N'}">							
							<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" />
						</c:if>
						<c:if test="${member.profileStatus eq 'Y'}">
							<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.profile}" alt="" />
						</c:if>
					</c:if>					
				</div>
			</div>
			<div class="profile-info-area">
				<div class="host-nickname-area">
					<div class="host-nickname">
						<div class="host-nickname-span">
							<span>${member.nickname}</span>
						</div>
						<div class="contact-host-wrap">
							<i id="make-chat-room" class="fa fa-comments-o" aria-hidden="true"></i>
						</div>
					</div>
				</div>
				<div class="host-friends-area">
					<div class="friends-count"><span>팔로잉 : ${socialCount.FOLLOWING}</span></div>
					<div class="following-count"><span>팔로워 : ${socialCount.FOLLOWER}</span></div>
				</div>				
				<div class="host-introduce-area">
					<div class="host-hobby-wrap">
						<div class="host-hobby-title">
							<span>취미 : </span>
						</div>
						<div class="hobby-list-wrap">
							<c:forEach items="${hobby}" var="h">
								<div class="host-hobby">${h}</div>
							</c:forEach>
						</div>
					</div>
					<div class="host-introduce-wrap">
						${member.introduce}
					</div>
				</div>
			</div>
		</div>
		<hr />
		<div class="one-person-feed-area">
			<div class="feed-limit-area">
				<c:forEach items="${feed}" var="f">
					<!-- 사진이 있다면 -->
					<c:if test="${not empty f.attachments}">
						<div class="one-feed">
							<div class="hidden-likes-comment">
								<input type="hidden" class="code" value="${f.code}"/>
								<div class="likes-count">
									<i class="fas fa-heart"></i>
									${f.likes}
								</div>
								<div class="comments-count">
									<i class="far fa-comment"></i>
									${f.commentCount}
								</div>
							</div>
							<div class="feed-area">
								<img class="change-profile" src="${pageContext.request.contextPath}/resources/${f.attachments[0].renamedFilename}" alt="" />
							</div>
						</div>
					</c:if>
					<!-- 사진이 없다면 -->
					<c:if test="${empty f.attachments}">
						<div class="one-feed">
							<div class="hidden-likes-comment">
								<input type="hidden" class="code" value="${f.code}"/>
								<div class="likes-count">
									<i class="fas fa-heart"></i>
									${f.likes}
								</div>
								<div class="comments-count">
									<i class="far fa-comment"></i>
									${f.commentCount}
								</div>
							</div>
							<div class="feed-area">
								<div class="feed-content-hidden">${f.content}</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>	


	<!-- 게시물 상세보기 모달 -->
	<div class="modal fade" id="feedViewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body feed-detail-modal-body">
					
				</div>
			</div>
		</div>
	</div>
</div>
<script>
const $chatRoom = $("#make-chat-room");
$chatRoom.click((e) => {
	console.log(1);
	var room = Math.floor(Math.random() * 100000);
	
	let guest = '${member.nickname}';
	if(confirm(guest + '님과 DM을 하시겠습니까?')){
		var room = Math.floor(Math.random() * 100000);
		console.log('room = ' + room);
		
		const name = `chatRoom\${room}`;
		const spec = "left=500px, top=500px, width=450px, height=620px";
		const url = `${pageContext.request.contextPath}/member/mypage/chat.do?room=\${room}`;
		
		chatInvite('chat', '${loginMember.nickname}', guest, room);
		windowObjHistorySearch = window.open(url, name, spec);	
	}
});

const $detailBody = $(".feed-detail-modal-body");
$(".one-feed").click((e) => {
	let code = $(".one-feed").find("input.code").val();
	console.log(code);
	console.log('${member.id}' + " " + code);
	selectedFeed('${member.id}',code);
});
</script>	
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
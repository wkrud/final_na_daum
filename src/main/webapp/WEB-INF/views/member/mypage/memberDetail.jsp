<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.project.nadaum.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	System.out.println("member = " + member);
	String[] hobby = member.getHobby();
	System.out.println("hobby = " + hobby);
	List<String> hobbyList = hobby != null ? Arrays.asList(hobby) : null;
	System.out.println("hobbyList = " + hobbyList);
	pageContext.setAttribute("hobbyList", hobbyList);
%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 회원정보" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="member-body">
	<div class="section">
		<!-- 왼쪽 메뉴list -->
		<div class="absolute-left">
			<ul class="list-group">
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">마이페이지</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=alarm">알림</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberMyHelp.do">내가 한 질문</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberFriends.do">친구관리</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberHelp.do">질문모음</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberAnnouncement.do">공지사항</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/changePassword.do">비밀번호 수정</a></li>
				<sec:authorize access="hasRole('ROLE_SUPER')">
					<li class="list-group-item"><a class="text-danger" href="${pageContext.request.contextPath}/member/admin/adminMain.do">관리자페이지</a></li>
				</sec:authorize>
			</ul>
			<!-- 메뉴리스트 하단 작게 -->
			<div class="phone-update-frm">
				<form action="${pageContext.request.contextPath}/member/mypage/enrollPhone.do">
					<div class="enroll-phone-wrap">
						<div class="enroll-phone-wrap-title">
							<span>핸드폰 등록</span>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<button class="btn btn-outline-secondary" id="enrollPhone" type="submit">등록</button>
							</div>
							<input type="tel" name="ePhone" id="ePhone" placeholder="-없이 번호만 입력해주세요" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
						</div>
					</div>
				</form>
			</div>
			<div class="out">
				<a href="${pageContext.request.contextPath}/member/mypage/membershipWithdrawal.do">회원탈퇴</a>
			</div>
		</div>
		
		<!-- 메인 -->
		<div class="main-section">
			<c:if test="${param.tPage eq 'myPage'}">
				<div class="info-profile-wrap">
					<div class="profile-div-wrap">
						<div class="profile-div">
							<c:if test="${loginMember.loginType eq 'K'}">
								<img src="${loginMember.profile}" alt="" />
							</c:if>
							<c:if test="${loginMember.loginType eq 'D'}">
								<c:if test="${loginMember.profileStatus eq 'N'}">							
									<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" />
								</c:if>
								<c:if test="${loginMember.profileStatus eq 'Y'}">
									<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/${loginMember.profile}" alt="" />
								</c:if>
							</c:if>
						</div>
						<div class="nickname-wrap">
							<p>
								별명 : <span>${loginMember.nickname}</span>
								<button type="button" id="modify-nickname-modal" class="btn btn-outline-warning">별명 수정</button>
							</p>
						</div>
					</div>
					<div class="info-form">
						<form id="memberUpdateFrm">
							<input type="text" class="form-control" name="id" id="id" value="${loginMember.id}" readonly required/>
							<input type="text" class="form-control" placeholder="이름" name="name" id="name" value="${loginMember.name}" readonly required/>
							<input type="text" class="form-control" placeholder="이메일" name="email" id="email" value="${loginMember.email}" readonly required/>
							<input type="text" class="form-control" placeholder="주소" name="address" id="address" value="${loginMember.address}" readonly required/>
							<input type="text" class="form-control" placeholder="전화번호" name="phone" id="phone" value="${loginMember.phone}" readonly required/>
							<label for="birthday">생일</label>
							<input type="date" name="birthday" id="birthday" value='<fmt:formatDate value="${loginMember.birthday}" pattern="yyyy-MM-dd"/>' />
							
							<div class="info-update-btn">
								<input type="submit" class="btn btn-outline-success" value="수정" >
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
						
					</div>				
				</div>
				<hr />
				<div class="hobby-wrap">
					<div class="selected-hobby-wrap">
						<div class="my-hobby-wrap-title">
							<span>내 취미</span>
							<div class="hobby-edit-btn">
								<i class="far fa-edit hobby-edit"></i>
							</div>
						</div>
						<div class="my-hobby-wrap">							
							<c:forEach items="${hobbyList}" var="hobby">
								<c:if test="${hobby eq '롤'}">								
									${hobby}
								</c:if>
								<c:if test="${hobby eq '게임'}">
									${hobby}
								</c:if>
								<c:if test="${hobby eq '독서'}">
									${hobby}
								</c:if>
								<c:if test="${hobby eq '글쓰기'}">
									${hobby}
								</c:if>
								<c:if test="${hobby eq '코딩'}">
									${hobby}
								</c:if>
								<c:if test="${hobby eq '볼링'}">
									${hobby}
								</c:if>
								<c:if test="${hobby eq '농구'}">
									${hobby}
								</c:if>
								<c:if test="${hobby eq '맛집탐방'}">
									${hobby}
								</c:if>
								<c:if test="${hobby ne '맛집탐방' && hobby ne '롤' && hobby ne '게임' && hobby ne '독서' && hobby ne '글쓰기' && hobby ne '코딩' && hobby ne '볼링' && hobby ne '농구'}">
									${hobby}
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="modify-hobby-wrap">
						<div class="hobby-wrap-title">
							<span>취미</span>
						</div>
						<div class="hobby-select-form">
							<form id="modifyHobbyFrm" method="post" onsubmit="return false;">
								<input type="hidden" name="id" value="${loginMember.id}" />
								<div class="check-hobby">
									<label for="lol">롤</label>
									<input type="checkbox" name="hobby" id="lol" value="롤" ${hobbyList.contains('롤') ? 'checked' : ''}/>
									<label for="game">게임</label>
									<input type="checkbox" name="hobby" id="game" value="게임" ${hobbyList.contains('게임') ? 'checked' : ''}/>
									<label for="book">독서</label>
									<input type="checkbox" name="hobby" id="book" value="독서" ${hobbyList.contains('독서') ? 'checked' : ''}/>
									<label for="write">글쓰기</label>
									<input type="checkbox" name="hobby" id="write" value="글쓰기" ${hobbyList.contains('글쓰기') ? 'checked' : ''}/>
									<label for="coding">코딩</label>
									<input type="checkbox" name="hobby" id="coding" value="코딩" ${hobbyList.contains('코딩') ? 'checked' : ''}/>
									<label for="bowling">볼링</label>
									<input type="checkbox" name="hobby" id="bowling" value="볼링" ${hobbyList.contains('볼링') ? 'checked' : ''}/>
									<label for="basketball">농구</label>
									<input type="checkbox" name="hobby" id="basketball" value="농구" ${hobbyList.contains('농구') ? 'checked' : ''}/>
									<label for="goodrestaurant">맛집탐방</label>
									<input type="checkbox" name="hobby" id="goodrestaurant" value="맛집탐방" ${hobbyList.contains('맛집탐방') ? 'checked' : ''}/>
								<c:forEach items="${hobbyList}" var="hobby" varStatus="vs">
									<c:if test="${hobby ne '' && hobby ne '맛집탐방' && hobby ne '롤' && hobby ne '게임' && hobby ne '독서' && hobby ne '글쓰기' && hobby ne '코딩' && hobby ne '볼링' && hobby ne '농구'}">
										<label for="etc${vs.count}">${hobby}</label>
										<input type="checkbox" name="hobby" id="etc${vs.count}" value="${hobby}" ${hobbyList.contains(hobby) ? 'checked' : ''}/>
									</c:if>
								</c:forEach>
								</div>
								<div class="write-hobby-self-wrap">
									<label for="etc">직접입력</label>
									<input type="text" name="hobby" id="etc"/>		
									<i class="far fa-edit self-btn"></i>					
								</div>
							</form>
						</div>
					</div>
				</div>	
				<hr />
				<div class="member-introduce-wrap">
					<div class="introduce-wrap">
						<div class="introduce-title-wrap">
							<span>소개</span>
							<div class="introduce-edit-wrap">
								<i class="far fa-edit intro-edit"></i>
							</div>
						</div>
						<div class="member-introduce">${loginMember.introduce}</div>
					</div>
					<div class="modify-introduce-wrap">
						<div class="introduce-content-wrap">
							<div class="introduce-content">
								<textarea name="" id="member-self-introduce" placeholder="소개를 해보세요" >${loginMember.introduce}</textarea>
							</div>
							<div class="introduce-modify-btn-wrap">
								<i class="far fa-edit"></i>
							</div>
						</div>
						<div class="introduce-size-check">
							<span class="size-check"></span>
						</div>
					</div>
				</div>	
				
				<script>
				$(() => {
					/* db에서 불러온 소개에서 <br/>을 \r\n으로 변경하여 코드가 보이지 않도록 수정 */
					$intro.val($intro.val().split('<br/>').join('\r\n'));
					/* 소개 사이즈 체크 */
					$sizeCheck.text($intro.val().length + '/100');
					$(".modify-introduce-wrap").hide();
					$(".modify-hobby-wrap").hide();
				});
				
				$(".hobby-edit").on('click',function(e) {
					$(".modify-hobby-wrap").slideToggle();
				});
				
				$(".intro-edit").on('click',function(e) {
					$(".modify-introduce-wrap").slideToggle();
				});
				
				/* $(".modify-hobby-wrap").hide(); */
				const $intro = $("#member-self-introduce");
				const $sizeCheck = $(".size-check");
				$intro.on('keyup', function(e) {
					$sizeCheck.text($intro.val().length + '/100');
					if($intro.val().length > 100){
						$sizeCheck.css("color","red");						
					}else{
						$sizeCheck.css("color","black");
					}
					if($intro.val().length < 102 && $intro.val().length > 1 && ((e.keyCode === 13 || e.key === 'Enter') && !e.shiftKey)){
						/* 엔터시에 개행 제거 */
						$intro.val($intro.val().replace(/\r|\n$/g,''));
						modifyIntroduce($intro.val().replace(/(?:\r\n|\r|\n)/g, '<br/>'), '${loginMember.id}');
					}else{
						console.log('너무 크다');
					}
				});
				
								
				const modifyIntroduce = (intro, id) => {
					
					$.ajax({
						url: '${pageContext.request.contextPath}/member/mypage/modifyMemberIntroduce.do',
						data : {intro, id},
						headers: headers,
						method: 'POST',
						success(resp){
							console.log(resp);
							location.reload();
						},
						error: console.log
					});
				};
				
				/* 취미 수정 */
				$(".self-btn").on('click', function(e){
					if($("#etc").val() != ''){
						modifyAjax();
					}
				});
				
				$(".hobby-select-form input").change((e) => {					
					modifyAjax();
				});
				
				const modifyAjax = () => {
					
					$.ajax({
						url:'${pageContext.request.contextPath}/member/mypage/modifyMemberHobby.do',
						data: $("#modifyHobbyFrm").serialize(),
						headers: headers,
						method: 'POST',
						success(resp){
							
							let hobbyInput = `<label for="lol">롤</label>
								<input type="checkbox" name="hobby" id="lol" value="롤" ${hobbyList.contains('롤') ? 'checked' : ''}/>`;
							console.log(resp);
							location.reload();
						},
						error: console.log
					});
				};
				
				
				$("#enrollPhone").click((e) => {
					if(!/01[016789][^0][0-9]{2,3}[0-9]{3,4}/.test($("#ePhone").val())){
						alert('유효하지 않은 번호입니다.');
						return false;
					}
					return true;
				});
				
				const changePw = () => {
					location.href="${pageContext.request.contextPath}/member/mypage/changePassword.do";
				};
				
				$(memberUpdateFrm).submit((e) => {
					e.preventDefault();
					
					const csrfHeader = "${_csrf.headerName}";
					const csrfToken = "${_csrf.token}";
					const headers = {};
					headers[csrfHeader] = csrfToken;
					
					$.ajax({
						url: "${pageContext.request.contextPath}/member/memberUpdate.do",
						data: $(e.target).serialize(),
						headers: headers,
						method: "POST",
						success(resp){
							console.log(resp);
						},
						error:console.log
					});
				});
				
				$("#modify-nickname-modal").click((e) => {
					location.href="${pageContext.request.contextPath}/member/mypage/memberModifyNickname.do";
				});
				</script>
			</c:if>
			<c:if test="${param.tPage eq 'alarm'}">
				<div class="alarm-wrap">
					<ul class="list-group"></ul>
				</div>
	  			<div class="more-alarm-btn-wrap">
	  				<button type="button" id="more-alarm-btn" class="btn btn-primary">더보기</button>
	  			</div>
			</c:if>
		</div>
	</div>
</div>
<script>
<c:if test="${param.tPage eq 'alarm'}">
var cPage = 1;
$(() => {
	moreAlarm();
});
$("#more-alarm-btn").click((e) => {
	moreAlarm();
});
const moreAlarm = () => {
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/mypage/memberAlarm.do",
		data: {'cPage':cPage},
		success(resp){
			
			const $alarmUl = $(".alarm-wrap ul");
			
			$(resp).each((i, v) => {
				const {no, code, id, status, content, reg_date} = v;
				
				let alarmLi = '';	
			 	if(code.substring(0,2) == 'he' && status == 'F'){
					alarmLi = `<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${code}">\${content}</a></li>`;
				}else if(code.substring(0,2) == 'he' && status == 'T'){
					alarmLi = `<li class="list-group-item list-group-item-secondary"><a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${code}">\${content}</a></li>`;
				}else if(code.substring(0,2) == 'fr' && status == 'F'){
					alarmLi = `<li class="list-group-item">\${content}</li>`;
				}else if(code.substring(0,2) == 'fr' && status == 'T'){
					alarmLi = `<li class="list-group-item list-group-item-secondary">\${content}</li>`;
				}else{
					alarmLi = `<li class="list-group-item list-group-item-secondary">\${content}</li>`;
				}
				$alarmUl.append(alarmLi);
			});
			
			
		},
		error: console.log
	});
	cPage++;
};
</c:if>

$(".change-profile").click((e) => {
	if(confirm('프사를 바꾸시게요?')){
		location.href="${pageContext.request.contextPath}/member/mypage/memberChangeProfile.do";
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
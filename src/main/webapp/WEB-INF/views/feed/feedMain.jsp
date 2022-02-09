<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/main/main.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 feed" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<style>
.userPic img {
	width: 50px;
}
.feedPic img {
	width: 300px;
}
#mainArticle{
	display: flex;
    flex-direction: column;
    align-items: center;
}
.feedList{
	display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 20px;
}
.feedItem {
	border: solid 1px; 
	width: 660px;
}
.writeFeed{
	width: 660px;
    border: solid 1px;
}
.writeFeedHeader{border: solid 1px;}
</style>
<article id="mainArticle" class="mainArticle">
	<!-- 피드 작성하기 -->
	<div class="writeFeed">
		<!-- 피드 작성하기 : 헤더 -->
		<div class="writeFeedHeader">
			<div class="title">피드 작성하기</div>
		</div>
		<!-- 피드 작성하기 : 프로필 사진과 피드 내용 -->
		<div class="writeFeedBody">
			<div class="pic">
				<div class="thumbnail-wrap"
					style="border-radius: 50%; width: 45px; height: 45px; overflow: hidden; padding: 0;">
					<c:if test="${loginMember.loginType eq 'K'}">
						<img src="${loginMember.profile}" alt=""
							style="width: 45px; height: 45px; object-fit: cover;" />
					</c:if>
					<c:if test="${loginMember.loginType eq 'D'}">
						<c:if test="${loginMember.profileStatus eq 'N'}">
							<img
								src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png"
								alt="" style="width: 45px; height: 45px; object-fit: cover;" />
						</c:if>
						<c:if test="${loginMember.profileStatus eq 'Y'}">
							<img
								src="${pageContext.request.contextPath}/resources/upload/member/profile/${loginMember.profile}"
								alt="" style="width: 45px; height: 45px; object-fit: cover;" />
						</c:if>
					</c:if>
				</div>
			</div>
			<div class="text">
				<textarea name="" id="writeFeedTextArea" cols="30" rows="3"
					placeholder="사람들과 소통하세요! (최대 3000글자, 사진 최대 6장)" spellcheck="false"></textarea>
			</div>
		</div>
		<!-- 피드 작성하기 : 푸터 -->
		<div class="writeFeedFooter">
			<!-- 피드에 올릴 사진 목록 -->
			<div class="feedUploadPic" style="display: none;">
				<!-- 피드에 올릴 사진들 -->
			</div>
			<!-- 버튼 모음([사진 올리기], [작성] 버튼) -->
			<div class="btnSet">
				<input type="file" id="feedWriteImgInput" multiple=""> <label
					class="feedWriteImgInputBtn" for="feedWriteImgInput"
					id="feedWriteImgInputBtn"> <i
					class="material-icons imageAddBtn"
					style="margin-right: 5px; pointer-events: none">wallpaper</i> 사진
					올리기
				</label>
				<button type="button" class="btn btn-primary feedWriteBtn"
					disabled="">작성</button>
			</div>
		</div>
	</div>
	<!-- 피드 목록 -->
	<div class="feedList">
		<!-- 피드 출력되는 부분 -->
		<div class="feedItem" id="941">
			<div class="feedHeader">
				<user class="user" data-user="8186">
				<div class="userPic">
					<img
						src="https://indiz.kr/folder-image/2021-10/2021-10-24/profile-image/20211024215709-8186.png">
				</div>
				<div class="userInfo">
					<div class="userNickname">ENTER</div>
					<div class="userUploadDate">2022-02-07</div>
				</div>
				</user>
				<div class="moreBtn">
					<a class="btn" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <i
						class="fa fa-ellipsis-h"></i>
					</a>
					<!-- dropdown-menu -->
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item feedReport">신고하기</a>
					</div>
				</div>
			</div>
			<div class="feedBody">
				<div class="feedPic">
					<img
						src="https://indiz.kr/folder-image/2022-02/2022-02-07/feed-image/20220207220534-8186-0.jpg">
				</div>
				<div class="feedBodyBtn">
					<div class="likeBtn like">
						<i class="fa fa-thumbs-up"></i>
						<div class="likeNum">2</div>
					</div>
					<div class="commentBtn">댓글(0)</div>
				</div>
				<div class="feedContent">(대충 오랜만이라는 글)</div>
			</div>
		</div>
		<div class="feedItem" id="940">
			<div class="feedHeader">
				<user class="user" data-user="1273">
				<div class="userPic">
					<img
						src="https://indiz.kr/folder-image/2021-04/2021-04-05/profile-image/20210405220523-1273.jpg">
				</div>
				<div class="userInfo">
					<div class="userNickname">백영</div>
					<div class="userUploadDate">2022-02-03</div>
				</div>
				</user>
				<div class="moreBtn">
					<a class="btn" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <i
						class="fa fa-ellipsis-h"></i>
					</a>
					<!-- dropdown-menu -->
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item feedReport">신고하기</a>
					</div>
				</div>
			</div>
			<div class="feedBody">
				<div class="feedPic"></div>
				<div class="feedBodyBtn">
					<div class="likeBtn like">
						<i class="fa fa-thumbs-up"></i>
						<div class="likeNum">8</div>
					</div>
					<div class="commentBtn">댓글(7)</div>
				</div>
				<div class="feedContent">드라마 '그 해 우리는' 을 보고 작곡한 '네 마음은 파도같아'의
					영상을 라이브&amp;영상 섹션에 올려놓았습니다. 함께 드라마를 본 채화가 팬뮤비를 만들어주었어요. 인디즈에도 공식
					음원을 올려 놓았으니 많이 들어주시고 댓글도 많이 달아주세요! 감동적인 감상평과 해석을 써주셔서 저도 제 노래를 더
					좋아하게 되는 것 같습니다. 감사해요!</div>
			</div>
		</div>
		<div class="feedItem" id="939">
			<div class="feedHeader">
				<user class="user" data-user="13536">
				<div class="userPic">
					<img src="https://indiz.kr//utill_image/default_profile.png">
				</div>
				<div class="userInfo">
					<div class="userNickname">addition</div>
					<div class="userUploadDate">2022-01-28</div>
				</div>
				</user>
				<div class="moreBtn">
					<a class="btn" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <i
						class="fa fa-ellipsis-h"></i>
					</a>
					<!-- dropdown-menu -->
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item feedReport">신고하기</a>
					</div>
				</div>
			</div>
			<div class="feedBody">
				<div class="feedPic carousel slide" data-ride="carousel"
					data-interval="false" id="carousel_939">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img
								src="https://indiz.kr/folder-image/2022-01/2022-01-28/feed-image/13536-20220128000924-0.png">
						</div>
						<a class="carousel-control-prev" href="#carousel_939"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carousel_939"
							role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"></span> <span
							class="sr-only">Next</span>
						</a>
						<div class="carousel-item">
							<img
								src="https://indiz.kr/folder-image/2022-01/2022-01-28/feed-image/13536-20220128000924-1.png">
						</div>
						<a class="carousel-control-prev" href="#carousel_939"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carousel_939"
							role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"></span> <span
							class="sr-only">Next</span>
						</a>
					</div>
				</div>
				<div class="feedBodyBtn">
					<div class="likeBtn">
						<i class="fa fa-thumbs-o-up"></i>
						<div class="likeNum">7</div>
					</div>
					<div class="commentBtn">댓글(4)</div>
				</div>
				<div class="feedContent">
					‘addition’이 기획하는 신진 인디펜던트 · 아티스트 인지도 제고를 위한 크라우드 펀딩 아티스트를 모집합니다! <br>
					<br>
					<br>
					<br> 안녕하세요. 저희는 신진 · 인디펜던트 아티스트 인지도 제고를 위한 크라우드 펀딩을 진행 중인
					‘addition’입니다. <br>
					<br>
					<br>
					<br> ‘addition’은 국내 최대 크라우드 펀딩 사이트인 ‘와디즈’에서 아티스트 ‘홍지희’님과 함께 신진
					아티스트 홍보를 위한 첫 크라우드 펀딩을 12월 3일부터 진행하였습니다. <br>
					<br> 1차 펀딩 아티스트로 참여하신 ‘홍지희’님의 브랜딩과 펀딩 준비를 ‘additor’ 서비스를 통해
					진행하였습니다.<br>
					<br> ‘additor’ 서비스란 펀딩에 참여하는 아티스트의 브랜딩과 펀딩 성공을 위해 기획에서부터 펀딩
					심사, 리워드 제공 등 모든 영역을 프로듀싱하는 서비스입니다.<br>
					<br> ‘addition’이 진행하고 ‘홍지희’님이 참여한 1차 펀딩은 1월 3일 성공적으로 종료되었으며,
					현재 후원자님들에게 제공할 리워드 제작을 마치고 발송 중입니다.<br> <br> 동일한 테마로 신진 ·
					인디펜던트 아티스트 인지도 제고를 위한 2차 크라우드 펀딩을 기획 중이며 참여할 다양한 분야의 여러 멋진 아티스트들의
					지원을 받고 있습니다. <br>
					<br> 첨부된 지원양식을 작성하여 addition210912@gmail.com로 2월 9일 자정까지 발송
					해주신 메일을 확인한 후 면접 대상자인 아티스트분들께 2월 11일까지 연락 드리겠습니다.<br>
					<br> 펀딩과 관련된 또는 ‘adition’에게 궁금하신 사항은 위의 메일을 통해 보내주시면 최선을 다해
					도움을 드리겠습니다.<br>
					<br> 긴 글 읽어주셔서 감사드리며 여러분의 많은 관심과 지원 부탁드립니다.<br>
					<br>*인디즈 사이트 내 한글파일이 업로드 되지 않아 메일 주시면 보내드리겠습니다.
				</div>
				<div class="readMore">더보기...</div>
			</div>
		</div>
		<div class="feedItem" id="938">
			<div class="feedHeader">
				<user class="user" data-user="680">
				<div class="userPic">
					<img
						src="https://indiz.kr/folder-image/2022-01/2022-01-08/profile-image/20220108221506-680.jpg">
				</div>
				<div class="userInfo">
					<div class="userNickname">쎈코(SSENCO)</div>
					<div class="userUploadDate">2022-01-26</div>
				</div>
				</user>
				<div class="moreBtn">
					<a class="btn" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <i
						class="fa fa-ellipsis-h"></i>
					</a>
					<!-- dropdown-menu -->
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item feedReport">신고하기</a>
					</div>
				</div>
			</div>
			<div class="feedBody">
				<div class="feedPic">
					<img
						src="https://indiz.kr/folder-image/2022-01/2022-01-26/feed-image/20220126232205-680-0.jpg">
				</div>
				<div class="feedBodyBtn">
					<div class="likeBtn">
						<i class="fa fa-thumbs-o-up"></i>
						<div class="likeNum">6</div>
					</div>
					<div class="commentBtn">댓글(6)</div>
				</div>
				<div class="feedContent">
					안녕하세요! 쎈코(SSENCO)입니다!<br>
					<br>다들 잘 지내고 계신가요??<br>저는 요즘 슬럼프와 번아웃과 무기력증이 같이 손잡고 저한테
					와서 곡 작업도 안 하고 있어요…<br>지금은 조금 괜찮아졌어요!!<br>
					<br>그래서 제가 하고 싶은 말은 “쎈코가 이런 장르해주면 좋겠다!” 라는 게 있는지 궁금해용!!<br>혹시
					있으시다면 댓글로 부탁드려요!! <br>
					<br>그리고 언제든지 근황이나 저한테 궁금한 거 있으시면 인스타 DM 아니면 피드 댓글에 달아주세요! 여러분
					이제 설날이 다가오네요.. 설날이 맛난 음식 많이 드셨으면 좋겠어요!! <br>그리고 제가 인디즈에 노래 업로드
					잘 안 한다고 서운해 하지마세용..😭😭 <br>지니 멜론과 같은 뮤직플랫폼 같은 곳에서도 활동하고 있으니
					기대해주시고 많은 응원 부탁드려요!! 감사합니다!!<br>
					<br>정말 정말 꼭 쎈코가 이런 장르 했으면 좋겠다 하는 거 댓글에 올려주세용!! 감사합니다!
				</div>
				<div class="readMore">더보기...</div>
			</div>
		</div>
		<div class="feedItem" id="937">
			<div class="feedHeader">
				<user class="user" data-user="13465">
				<div class="userPic">
					<img src="https://indiz.kr//utill_image/default_profile.png">
				</div>
				<div class="userInfo">
					<div class="userNickname">유량</div>
					<div class="userUploadDate">2022-01-26</div>
				</div>
				</user>
				<div class="moreBtn">
					<a class="btn" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <i
						class="fa fa-ellipsis-h"></i>
					</a>
					<!-- dropdown-menu -->
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item feedReport">신고하기</a>
					</div>
				</div>
			</div>
			<div class="feedBody">
				<div class="feedPic"></div>
				<div class="feedBodyBtn">
					<div class="likeBtn">
						<i class="fa fa-thumbs-o-up"></i>
						<div class="likeNum">6</div>
					</div>
					<div class="commentBtn">댓글(0)</div>
				</div>
				<div class="feedContent">예술 협력 프로젝트에 참가해주실 인디음악가 분들을 찾습니다. 현재
					시인, 소설가, 현대미술작가, 영화감독 랩퍼 등 다양한 아티스트 섭외 완료하였습니다. 프로젝트의 컨셉에 따라 참여 조건은
					90년대생이어야 합니다. 그외에는 만드신 음악만 보고 결정하고자합니다. 현재 자세히 밝힐 순 없지만 기업에서 일정 지원을
					약속받은 프로젝트입니다. 메일 &lt;sinthomeyou@gmail.com&gt;으로 연락주세요.</div>
			</div>
		</div>
	</div>
	<!-- 피드 읽기 모달 -->
	<div class="modal fade" id="readFeedModal" tabindex="-1" role="dialog"
		aria-labelledby="readFeedModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content readFeedModal">
				<div class="feedContent"></div>
			</div>
		</div>
	</div>
</article>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
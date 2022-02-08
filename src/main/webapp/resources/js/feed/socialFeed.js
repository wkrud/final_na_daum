const csrfToken = $("meta[name='_csrf']").attr("content");
const csrfHeader = $("meta[name='_csrf_header']").attr("content");
const headers = {};
headers[csrfHeader] = csrfToken;

const f = n => n < 10 ? "0" + n : n;

const selectedFeed = (id) => {
	$.ajax({
		url: '/nadaum/feed/selectedFeed.do',
		data: {id},
		success(resp){
			
			$detailBody.empty();
			let hostProfile = '';
			var commentDiv = '';
			let commenterProfileImg = '';
			let commentDate = '';
			let likes = '';		
			
			
			if(resp.likeCheck > 0){
				likes = `
				<label for="like">좋아요<i class="fas fa-heart"></i></label>
				<input type="checkbox" id="like" checked="checked"/>
				`;
			}else{
				likes = `
				<label for="like">좋아요<i class="far fa-heart"></i></label>
				<input type="checkbox" id="like"/>
				`;				
			}
			
			
			if(resp.member.profile != '' && resp.member.loginType == 'D'){
				hostProfile = '/nadaum/resources/upload/member/profile/default_profile_cat.png';
			}else if(resp.member.profile == '' && v.loginType == 'D'){
				hostProfile = `/nadaum/resources/upload/member/profile/${resp.member.profile}`;
			}else if(resp.member.loginType == 'K'){
				hostProfile = resp.member.profile;							
			}
			
			console.log(resp);
			let feedDiv = '';
			if(resp.feed.attachCount > 0){
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-wrap">
							<div clsas="feed-host-profile">
								<img src="${hostProfile}" alt="" />
							</div>
							<div class="feed-host-nickname">
								<span>${resp.member.nickname}</span>
							</div>
						</div>
						<div class="feed-pic-area-wrap">
							<div class="feed-pic-area">
								<img src="" alt="" />
							</div>
						</div>
						<div class="feed-content-area-wrap">
							<div class="feed-content-area">
								${resp.feed.content}
							</div>
						</div>
					</article>
					<article class="one-feed-comment-area-wrap">
						<div class="feed-comment-title">댓글</div>
						<div class="feed-comment-area"></div>
						<div class="feed-comment-write-area">
							<div class="like-btn-area">
								${likes}
							</div>
							<div class="input-group mb-3" style="margin-bottom: 0!important;">
								<textarea class="form-control feed-textarea" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2"></textarea>
								<div class="input-group-append">
									<button id="write-comment-btn" class="btn btn-outline-secondary" type="button">Button</button>
								</div>
							</div>
						</div>
					</article>
				</div>
				`;
				
			}else{
				
				if(resp.feed.comments.length){				
				}
				
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-wrap">
							<div clsas="feed-host-profile">
								<img src="${hostProfile}" alt="" />
							</div>
							<div class="feed-host-nickname">
								<span>${resp.member.nickname}</span>
							</div>
						</div>
						
						<div class="only-content-feed-area-wrap">
							<div class="only-content-feed">
								${resp.feed.content}
							</div>
						</div>
					</article>
					<article class="one-feed-comment-area-wrap">
						<div class="feed-comment-title">댓글</div>
						<div class="feed-comment-area">
							${commentDiv}
						</div>
						<div class="feed-comment-write-area">
							<div class="like-btn-area">
								${likes}
							</div>
							<div class="input-group mb-3" style="margin-bottom: 0!important;">
								<textarea class="form-control feed-textarea" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2"></textarea>
								<div class="input-group-append">
									<button id="write-comment-btn" class="btn btn-outline-secondary" type="button">Button</button>
								</div>
							</div>
						</div>
					</article>
				</div>
				`;
			}
						
			$detailBody.append(feedDiv);
			
			let $commetArea = $(".feed-comment-area");		
			console.log($commetArea.html());
			
			$(resp.feed.comments).each((i, v) => {
				
				let rd = new Date(v.regDate);
				commentDate = `${rd.getFullYear()}.${f(rd.getMonth() + 1)}.${f(rd.getDate())}`;
				
				if(v.profile != '' && v.loginType == 'D'){
					commenterProfileImg = '/nadaum/resources/upload/member/profile/default_profile_cat.png';
				}else if(v.profile == '' && v.loginType == 'D'){
					commenterProfileImg = `/nadaum/resources/upload/member/profile/${v.profile}`;
				}else if(v.loginType == 'K'){
					commenterProfileImg = v.profile;							
				}
				
				commentDiv = `
				<div class="commenter-area-wrap">
					<div class="commenter-profile-area">
						<div class="commenter-profile-img">
							<img src="${commenterProfileImg}" alt="" />
						</div>
						<div class="commenter-nickname-area">
							<span>${v.nickname}</span>
						</div>
					</div>
					<div class="commenter-comment-area">
						<span>${v.content}</span>
					</div>
					<div class="comment-date-area">
						<span>${commentDate}</span>
					</div>
				</div>
				`;
				$commetArea.append(commentDiv);
			});
							
			$(feedViewModal)
				.modal()
				.on("hide.bs.modal", (e) => {
				location.href='/nadaum/feed/socialFeed.do';
			});
			
			likeHtml(resp.feed.code);
			
			
			$("#write-comment-btn").on('click',function(){	
				let $content = $(".feed-textarea");
				if($content.val() == ''){
					alert('내용을 입력하세요');
				}else{
					writeComment($content.val(), resp.feed.code);
					$content.val('');										
				}
			});				
					
		},
		error: console.log
	});
};

const writeComment = (content, code) => {
	console.log(content);
	
	$.ajax({
		url: '/nadaum/feed/writeComment.do',
		data: {content, code},
		type: "POST",
		headers: headers,
		success(resp){
			console.log(resp);
			
			let rd = new Date(resp.regDate);
			let newCommentDate = `${rd.getFullYear()}.${f(rd.getMonth() + 1)}.${f(rd.getDate())}`;
			let newcommenterProfileImg = '';
			
			if(resp.profile != '' && resp.loginType == 'D'){
				newcommenterProfileImg = '/nadaum/resources/upload/member/profile/default_profile_cat.png';
			}else if(resp.profile == '' && resp.loginType == 'D'){
				newcommenterProfileImg = `/nadaum/resources/upload/member/profile/${resp.profile}`;
			}else if(resp.loginType == 'K'){
				newcommenterProfileImg = resp.profile;							
			}
			
			let newComment = `
			<div class="commenter-area-wrap">
				<div class="commenter-profile-area">
					<div class="commenter-profile-img">
						<img src="${newcommenterProfileImg}" alt="" />
					</div>
					<div class="commenter-nickname-area">
						<span>${resp.nickname}</span>
					</div>
				</div>
				<div class="commenter-comment-area">
					<span>${resp.content}</span>
				</div>
				<div class="comment-date-area">
					<span>${newCommentDate}</span>
				</div>
			</div>
			`;
			$(".feed-comment-area")
				.append(newComment)
				.scrollTop($(".feed-comment-area")[0].scrollHeight);
		},
		error: console.log
	});
};


const likeHtml = (code) => {
	$("#like").on('change',function(){
	
		console.log('hi');
						
		let check = '';
		if($("#like").is(':checked')){
			console.log($("#like").is(':checked'));
			check = '1';
			$("label[for='like']").html('좋아요<i class="fas fa-heart"></i>');
			$("#like").prop("checked", true);
		}else {
			console.log($("#like").is(':checked'));
			check = '0';
			$("label[for='like']").html('좋아요<i class="far fa-heart"></i>');
			$("#like").prop("checked", false);
		}				
		feedLikeChange(check,code);		
	});
};

const feedLikeChange = (check, code) => {
	
	$.ajax({
		url: '/nadaum/feed/feedLikeChange.do',		
		data: {check, code},
		type: "POST",
		headers: headers,
		success(resp){
			if(resp > 0)
				console.log('success');
		},
		error: console.log
	});
};





const selectedFeed = (id) => {
	$.ajax({
		url: '/nadaum/feed/selectedFeed.do',
		data: {id},
		success(resp){
			
			$detailBody.empty();
			let profile = '';
			var commentDiv = '';
			let commenterProfileImg = '';
			let commentDate = '';
			const f = n => n < 10 ? "0" + n : n;
			
			if(resp.member.loginType == 'K')
				profile = resp.member.profile;
			else if(resp.member.loginType == 'D' && resp.member.profileStatus == 'N')
			console.log(resp);
			let feedDiv = '';
			if(resp.feed.attachCount > 0){
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-wrap">
							<div clsas="feed-host-profile">
								<img src="${resp.member.profile}" alt="" />
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
								<label for="like">좋아요</label>
								<input type="checkbox" id="like"/>
							</div>
							<div class="input-group mb-3" style="margin-bottom: 0!important;">
								<textarea class="form-control feed-textarea" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2"></textarea>
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="button">Button</button>
								</div>
							</div>
						</div>
					</article>
				</div>
				`;
				
			}else{
				
				if(resp.feed.comments.length){				
				}
					$(resp.feed.comments).each((i, v) => {
						console.log(i, v);
						
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
					});
				
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-wrap">
							<div clsas="feed-host-profile">
								<img src="${resp.member.profile}" alt="" />
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
								<label for="like">좋아요</label>
								<input type="checkbox" id="like"/>
							</div>
							<div class="input-group mb-3" style="margin-bottom: 0!important;">
								<textarea class="form-control feed-textarea" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2"></textarea>
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="button">Button</button>
								</div>
							</div>
						</div>
					</article>
				</div>
				`;
			}
			
			
			$detailBody.append(feedDiv);
			
				
			$(feedViewModal)
				.modal()
				.on("hide.bs.modal", (e) => {
				location.href='/nadaum/feed/socialFeed.do';
			});
		},
		error: console.log
	});
};
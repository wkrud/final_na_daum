


const selectedFeed = (id) => {
	$.ajax({
		url: '/nadaum/feed/selectedFeed.do',
		data: {id},
		success(resp){
			
			$detailBody.empty();
			let profile = '';
			if(resp.member.loginType == 'K')
				profile = resp.member.profile;
			else if(resp.member.loginType == 'D' && resp.member.profileStatus == 'N')
			console.log(resp);
			let feedDiv = '';
			if(resp.feed.attachCount > 0){
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-wrap"><img src="${resp.member.profile}" alt="" /></div>
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
							<div class="input-group mb-3">
								<textarea class="form-control feed-textarea" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2">
								</textarea>
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="button">Button</button>
								</div>
							</div>
						</div>
					</article>
				</div>
				`;
				
			}else{
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-wrap"><img src="${resp.member.profile}" alt="" /></div>
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
							<div class="input-group mb-3">
								<textarea class="form-control feed-textarea" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2">
								</textarea>
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
			
			$(feedViewModal).modal().on("hide.bs.modal", (e) => {
				location.href='/nadaum/feed/socialFeed.do';
			});
		},
		error: console.log
	});
};
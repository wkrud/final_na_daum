const f = n => n < 10 ? "0" + n : n;

const selectedFeed = (id, code) => {
	$.ajax({
		url: '/nadaum/feed/selectedFeed.do',
		data: {id, code},
		success(resp){
			
			$detailBody.empty();
			let hostProfile = '';
			var commentDiv = '';
			let commenterProfileImg = '';
			let commentDate = '';
			let likes = '';		
			let dmDiv = '';
			
			
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
			
			if(resp.feed.writer == resp.guest.id){
				dmDiv = `
				<div clsas="feed-host-profile">
					<img src="${hostProfile}" alt="" />
				</div>
				`;
			}else{
				dmDiv = `
				<div clsas="dropdown feed-host-profile">
					<img src="${hostProfile}" alt="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"/>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="click-send-chat" href='javascript:void(0);' onclick="startChatNow('${resp.guest.nickname}', '${resp.member.nickname}');">채팅하기</a>
					</div>
				</div>
				`;
			}
			
			
			
			console.log(resp);
			let feedDiv = '';
			if(resp.feed.attachCount > 0){
				feedDiv = `
				<div class="one-feed-detail-area-wrap">
					<article class="one-feed-detail-area">
						<div class="feed-profile-delete-wrap">
							<div class="feed-profile-wrap">
								${dmDiv}
								<div class="feed-host-nickname">
									<span>${resp.member.nickname}</span>
								</div>
							</div>							
						</div>
						<div class="feed-pic-area-wrap">
							<div class="feed-pic-area">
								<img src="/nadaum/resources/upload/feed/img/${resp.feed.attachments[0].renamedFilename}" alt="" />
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
								<textarea class="form-control feed-textarea" placeholder="댓글을 입력하세요" aria-label="Recipient's username" aria-describedby="basic-addon2"></textarea>
								<div class="input-group-append">
									<button id="write-comment-btn" class="btn btn-outline-secondary" type="button">댓글작성</button>
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
						<div class="feed-profile-delete-wrap">
							<div class="feed-profile-wrap">
								${dmDiv}
								<div class="feed-host-nickname">
									<span>${resp.member.nickname}</span>
								</div>
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
								<textarea class="form-control feed-textarea" placeholder="댓글을 입력하세요" aria-label="Recipient's username" aria-describedby="basic-addon2"></textarea>
								<div class="input-group-append">
									<button id="write-comment-btn" class="btn btn-outline-secondary" type="button">댓글작성</button>
								</div>
							</div>
						</div>
					</article>
				</div>
				`;
			}
						
			$detailBody.append(feedDiv);
			
			let $deleteFeedArea = $(".feed-profile-delete-wrap");
			if(resp.guest.id == resp.feed.writer){
				let feedDeleteBtn = `
				<div class="feed-delete-wrap">
					<div class="dropdown comment-setting-btn-wrap">
						<i data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="fas fa-ellipsis-v comment-setting-btn"></i>
						<div class="dropdown-menu" onclick="deleteFeedBtn('${resp.feed.code}');" aria-labelledby="dropdownMenuButton">피드삭제</div>
					</div>
				</div>`;
				$deleteFeedArea.append(feedDeleteBtn);
			}
			
			
			let $commetArea = $(".feed-comment-area");		
			let deleteBtn = '';
			let profileOptionBtn = '';
			
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
				
				if(v.commentWriter == resp.guest.id){
					deleteBtn = `
					<div class="dropdown comment-setting-btn-wrap">
						<i data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="fas fa-ellipsis-v comment-setting-btn"></i>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton"><input type="hidden" class="comment-no" value="${v.no}"/><button class="dropdown-item delete-btn">댓글 삭제</button></div>
					</div>`;
					
					profileOptionBtn = `
					<div class="commenter-profile-img">
						<img src="${commenterProfileImg}" />
					</div>
					`;
				}else{					
					profileOptionBtn = `
					<div class="dropdown commenter-profile-img">
						<img src="${commenterProfileImg}" alt="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"/>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							<a href='/nadaum/feed/socialFeed.do?id=${v.commentWriter}'>피드 구경하기</a>
							<a href='javascript:void(0);' onclick="startChatNow('${resp.guest.nickname}', '${v.nickname}');">채팅하기</a>
						</div>
					</div>
					`;
				}
								
				commentDiv = `
				<div class="commenter-area-wrap">
					<div class="commenter-profile-area-wrap">
						<div class="commenter-profile-area">
							${profileOptionBtn}
							<div class="commenter-nickname-area">
								<span>${v.nickname}</span>
							</div>
						</div>							
						${deleteBtn}						
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
				.modal();
			/*$(feedViewModal)
				.modal()
				.on("hide.bs.modal", (e) => {
				location.href=`/nadaum/feed/socialFeed.do?id=${resp.feed.writer}`;
			});*/
			
			likeHtml(resp.feed.code, resp.feed.writer, resp.guest.nickname);			
			
			$(".feed-textarea").on('keyup',function(e){
				if($(".feed-textarea").val() != '' && $(".feed-textarea").val() != '\n'){
					if(e.key === 'Enter' || e.keyCode === 13){
						$("#write-comment-btn").trigger('click');
					}
				}
			});
			
			$("#write-comment-btn").on('click',function(){	
				let $content = $(".feed-textarea");
				if($content.val() == ''){
					alert('내용을 입력하세요');
				}else{
					writeComment($content.val(), resp.feed.code, resp.feed.writer);
					$content.val('');										
				}
			});		
			
			$(".delete-btn").on('click',function(e){
				let val = $(e.target).parent().find('input').val();
				deleteComment(val, resp.guest.id, resp.feed.code);
			});				
					
		},
		error: console.log
	});
};

const startChatNow = (host, guest) => {
	if(confirm(guest + '님과 DM을 하시겠습니까?')){
		var room = Math.floor(Math.random() * 100000);
		console.log('room = ' + room);
		
		const name = `chatRoom${room}`;
		const spec = "left=500px, top=500px, width=450px, height=620px";
		const url = `/nadaum/member/mypage/chat.do?room=${room}`;
		
		chatInvite('chat', host, guest, room);
		windowObjHistorySearch = window.open(url, name, spec);
	}
};

const deleteFeedBtn = (code) => {
	console.log(code);
	$.ajax({
		url: '/nadaum/feed/deleteFeed.do',
		data: {code},
		type: "POST",
		headers: headers,
		success(resp){
			console.log(resp);
			location.reload();
		},
		error: console.log
	});
};

const deleteComment = (no, id, code) => {
	
	$.ajax({
		url: '/nadaum/feed/deleteComment.do',
		data: {no, id, code},
		type: "POST",
		headers: headers,
		success(resp){
			console.log(resp);
			location.reload();
		},
		error: console.log
	});
};

const writeComment = (content, code, id) => {
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
			
			let newDeleteBtn = `<input type="hidden" class="comment-no" value="${resp.no}"/><button class="dropdown-item delete-btn">댓글 삭제</button>`;
						
			let newComment = `			
			<div class="commenter-area-wrap">
				<div class="commenter-profile-area-wrap">
					<div class="commenter-profile-area">
						<div class="commenter-profile-img">
							<img src="${newcommenterProfileImg}" alt="" />
						</div>
						<div class="commenter-nickname-area">
							<span>${resp.nickname}</span>
						</div>
					</div>
					<div class="dropdown comment-setting-btn-wrap">
						<i data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="fas fa-ellipsis-v comment-setting-btn"></i>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">${newDeleteBtn}</div>
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
				
			$(".delete-btn").on('click',function(e){
				let val = $(e.target).parent().find('input').val();
				deleteComment(val, resp.commentWriter, resp.fcode);
			});	
			
			let content = `<a href='/nadaum/feed/socialFeed.do?id=${id}&code=${resp.fcode}&type=alarmMessage'>${resp.nickname}님이 회원님의 피드에 댓글을 작성했습니다.</a>`;
			let ranNo = Math.floor(Math.random() * 10000);
			let alarmCode = 'fcomment-' + resp.no + ranNo;
			sendAndInsertAlarm('I',id, alarmCode, content);
			
		},
		error: console.log
	});
};


const likeHtml = (code, writer, guestNickname) => {
	$("#like").on('change',function(){
	
		console.log('hi');
		let ranNo = Math.floor(Math.random() * 10000);
		let alarmCode = 'flike-' + ranNo;
		let content = '';
		
		let check = '';
		if($("#like").is(':checked')){
			console.log($("#like").is(':checked'));
			check = '1';
			$("label[for='like']").html('좋아요<i class="fas fa-heart"></i>');
			$("#like").prop("checked", true);
			let i = $(".likes-count").val();
			
			content = `<a href='/nadaum/feed/socialFeed.do?id=${writer}&code=${code}&type=alarmMessage'>${guestNickname}님이 회원님의 피드에 좋아요를 눌렀습니다.</a>`;
			sendAndInsertAlarm('I',writer,alarmCode,content);
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


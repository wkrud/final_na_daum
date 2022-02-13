<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/main/main.css' rel='stylesheet' />
<script src="${pageContext.request.contextPath}/resources/js/feed/socialFeed.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feed/onePersonFeed.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 feed" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<style>

.userPic img {
	border-radius: 50%; 
	width: 45px; 
	height: 45px; 
	overflow: hidden; 
	padding: 0;
}
.userPic{padding-right: 8px;}
.feedPic img {
	width: 650px;
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
	padding: 10px;
    border: solid 1px;
    width: 660px;
    margin: 12px;
}
.writeFeed{
	width: 660px;
    border: solid 1px;
}
.writeFeedHeader{   
	display: flex;
    align-items: baseline;
    justify-content: space-between;
    margin: 8px;
}
.writeFeedBody{
	display: flex;
    padding: 6 6 0 6px;
}
.feedHeader{    
	display: flex;
    justify-content: space-between;
    padding-bottom: 8px;
}
.user {display: flex;} 
.feedBodyBtn{
	display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    padding-top: 5px;
    padding-bottom: 5px;
}
.likeBtn {
    display: flex;
    align-items: center;
}
.feedPic{
	display: flex;
    justify-content: center;
}
.likeNum{padding-left: 5px;}
#writeFeedTextArea {
	width: 580px;
    height: 120px;
    overflow: auto;
    margin-left: 5px;
}
/* #feedWriteImgInput{display: none;} */
.btnSet{    
	display: flex;
    justify-content: space-between;
    margin: 5px 10 5px 10px;
}
.feedWriteBtn{cursor: pointer;}
.feedWriteImgInputBtn{cursor: pointer;}
.writeFeedFooter{
	display: flex;
    flex-direction: column;
}
/* 첨부파일 */
#preview-image{
	margin: 9px;
    width: 200px;
}
.commentBtn{cursor: pointer;}
</style>

<script>
// 피드내용 체크
function feedValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

// 사진 미리보기
$(document).ready(function (e){
    $("input[type='file']").change(function(e){
      //div 내용 비워주기
      $('#preview').empty();     
      var files = e.target.files;
      var arr =Array.prototype.slice.call(files);
      
      //업로드 가능 파일인지 체크
      for(var i=0;i<files.length;i++){
        if(!checkExtension(files[i].name,files[i].size)){
          return false;
        }
      }
      preview(arr);     
    });
    
    function checkExtension(fileName,fileSize){
      var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
      var maxSize = 20971520;  //20MB
      
      if(fileSize >= maxSize){
        alert('파일 사이즈 초과');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }   
      if(regex.test(fileName)){
        alert('업로드 불가능한 파일이 있습니다.');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }
      return true;
    }  
    function preview(arr){
      arr.forEach(function(f){       
        //파일명이 길면 파일명...으로 처리
        var fileName = f.name;
        if(fileName.length > 10){
          fileName = fileName.substring(0,7) + "...";
        }    
        //div에 이미지 추가
        var str = '<div style="display: inline-flex; padding: 10px; list-style: none;"><li>';
        
        //이미지 파일 미리보기
        if(f.type.match('image.*')){
          var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
          reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
            //str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
            str += '<img src="'+e.target.result+'" title="'+f.name+'" width=200 />';
            str += '</li></div>';
            $(str).appendTo('#preview');
          } 
          reader.readAsDataURL(f);
        }else{
          str += '<img src="/resources/img/fileImg.png" title="'+f.name+'" width=200 />';
          $(str).appendTo('#preview');
        }
      });
    }
  });
</script>
<article id="mainArticle" class="mainArticle">
<!-- 피드 작성하기 -->
<div class="writeFeed">
	<form 
		name="feedFrm" 
		action="${pageContext.request.contextPath}/feed/feedEnroll.do?${_csrf.parameterName}=${_csrf.token}" 
		method="post" 
		enctype="multipart/form-data" 
		onsubmit="return feedValidate();">
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
                <textarea id="writeFeedTextArea" name="content" cols="30" rows="3"
                    placeholder="사람들과 소통하세요! (최대 1000글자)" spellcheck="false"></textarea>
            </div>
		</div>
		<!-- 피드 작성하기 : 푸터 -->
		<div class="writeFeedFooter">
			<!-- 피드에 올릴 사진 -->
			<div id="preview">
			</div>
			<!-- <img id="preview-image"/> -->
			<!-- 버튼 모음([사진 올리기], [작성] 버튼) -->
			<div class="btnSet">
				<input type="file" class="feedWriteImgInput" id="feedWriteImgInput" name="upFile" accept=".gif, .jpg, .png, .jpeg" onchange="readURL(this);"/> 
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="writer" class="writer" value="${loginMember.id}"/>
				<input type="hidden" name="nickname" class=nickname value="${loginMember.nickname}"/>
				<button type="submit" class="btn btn-primary feedWriteBtn">작성</button>
			</div>
		</div>
	</form>
</div>
<div class="feedList" id="feedList">
<!-- 피드 출력되는 부분 --> 	 
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
</article>
<script>
$(document).ready(function(){ 
	addFeedPageMain(1);
}); 
var id = $(".writer").val();
var nickname = $(".nickname").val();

function getFormatDate(date){
    var year = date.getFullYear();              
    var month = (1 + date.getMonth());          
    month = month >= 10 ? month : '0' + month;  
    var day = date.getDate();                   
    day = day >= 10 ? day : '0' + day;          
    return  year + '-' + month + '-' + day;      
}

const $feedArea = $(".feedList");
const $chatRoom = $("#make-chat-room");
const $detailBody = $(".feed-detail-modal-body");

var loading = false;
var page = 1;

//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
$(window).on("scroll",function(){
    //위로 스크롤된 길이
    let scrollTop = $(window).scrollTop();
    //웹브라우저의 창의 높이
    let windowHeight = $(window).height();
    //문서 전체의 높이
    let documentHeight = $(document).height();
    //바닥까지 스크롤 되었는 지 여부를 알아낸다.
    let isBottom=scrollTop+windowHeight + 100 >= documentHeight;

    if(isBottom){
        //만일 현재 마지막 페이지라면
        if(page == ${totalPageCount} || loading){
            return; //함수를 여기서 끝낸다.
        }

        loading = true;
        page++;
        console.log("scroll" + page);
        
        addFeedPageMain(page);
    }; 
});


/* 페이징 id, page */
const addFeedPageMain = (page) => {
	$.ajax({
		url: '${pageContext.request.contextPath}/feed/addFeedPageMain.do',
		data: {page},
		success(resp){
			const $resp = $(resp);
			let feedDiv = ``;	
			let like = ``;
			let moreBtn = ``;
			
			$resp.each((i,{CODE,WRITER,NICKNAME,CONTENT,REGDATE,PROFILE,FILENAME,COMMENTS,LIKES,LOGINTYPE,PROFILESTATUS,LIKECHECK}) => {
				let rd = new Date(REGDATE);
				feedDate = getFormatDate(rd);
				
				if(LOGINTYPE == 'K'){
					profile = `<img src="\${PROFILE}" alt="" />`;
				}
				else {
					if(PROFILESTATUS == 'N'){
						profile = `<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/image.png" alt="" />`;
					}
					else {
						profile = `<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/\${PROFILE}" alt="" />`;
					}
				}
				
				if(LIKECHECK == 1){
					like = `<span> <a idx="\${CODE}" href="javascript:"
	                    class="heart-click heart_icon\${CODE}"><svg
                        xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                        fill="currentColor" class="bi bi-suit-heart-fill"
                        viewBox="0 0 16 16">
                              <path
                            d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />
                            </svg></a>
            		</span>`;
				}
				else {
					like = `<span> <a idx="\${CODE}" href="javascript:"
	                    class="heart-click heart_icon\${CODE}"><svg
                        xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                        fill="currentColor" class="bi bi-suit-heart"
                        viewBox="0 0 16 16">
                              <path
                            d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
                            </svg></a>
           			 </span>`;
				}
				

				if(FILENAME != null){
					feedDiv = `
						<div class="feedItem" id="\${CODE}">
							<div class="feedHeader">
								<div class="user" data-user="\${WRITER}">
									<div class="userPic">
									<a href='${pageContext.request.contextPath}/feed/socialFeed.do?id=\${WRITER}'>  
									\${profile}	
									</a>
									</div>
									<div class="userInfo">
										<div class="userNickname">\${NICKNAME}</div>
										<div class="userUploadDate">\${feedDate}</div>
									</div>
								</div>
								\${moreBtn}
							</div>
							<div class="feedBody">
								<div class="feedPic">
									<img
										src="${pageContext.request.contextPath}/resources/upload/feed/img/\${FILENAME}">
								</div>
							</div>
								<div class="feedBodyBtn">
								<input type="hidden" class="code" value="\${CODE}"/>
								<input type="hidden" class="id" value="\${WRITER}"/>
									<div class="likeBtn">
									<input type="hidden" class="code" value="\${CODE}"/>
										\${like}
										<span id="m_heart\${CODE}">\${LIKES}</span>	
									</div>
									<div class="commentBtn">댓글(\${COMMENTS})</div>
								</div>
								<div class="feedContent">\${CONTENT}</div>
							</div>
						</div> `;
				} else {
					feedDiv = `
							<div class="feedItem" id="\${CODE}">
								<div class="feedHeader">
									<div class="user" data-user="\${WRITER}">
										<div class="userPic">
										<a href='${pageContext.request.contextPath}/feed/socialFeed.do?id=\${WRITER}'>  
										\${profile}
										</a>
										</div>
										<div class="userInfo">
											<div class="userNickname">\${NICKNAME}</div>
											<div class="userUploadDate">\${feedDate}</div>
										</div>
									</div>
								</div>
								<div class="feedBody">
									<div class="feedPic">
									</div>
								</div>
									<div class="feedBodyBtn">
									<input type="hidden" class="code" value="\${CODE}"/>
									<input type="hidden" class="id" value="\${WRITER}"/>
										<div class="likeBtn">
										<input type="hidden" class="code" value="\${CODE}"/>
											\${like}
											<span id="m_heart\${CODE}">\${LIKES}</span>	
										</div>
										<div class="commentBtn">댓글(\${COMMENTS})</div>
									</div>
									<div class="feedContent">\${CONTENT}</div>
								</div>
							</div> `;
				}
				
				$feedArea.append(feedDiv);
				
				$(".heart-click").on("click",function(){
				    // idx로 전달받아 저장
				    let code = $(this).attr('idx');
				    /* let id = ${loginMember.id}; */
				    console.log("heart-click");

				    // 빈하트를 눌렀을때
				    if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
				        console.log("빈하트 클릭" + code);

				        $.ajax({
				            url : '${pageContext.request.contextPath}/feed/feedMainLikeSave.do',
				            type : 'get',
				            data : {
				                code : code
				            },
				            success : function(e) {
				                //페이지 새로고침
				                //document.location.reload(true);

				                let heart = e.likes;
				                console.log(e);
				                console.log("heart = " + heart);

				                // 페이지에 하트수 갱신
				                $('#m_heart'+code).text(heart);
				                //$('#heart'+code).text(heart);
				                
				                let ranNo = Math.floor(Math.random() * 10000);
				    			let alarmCode = 'fe-' + ranNo;
				    			let content = '';
				    			let writer = $(".writer").val();
				    			let nickname = $(".nickname").val();
				    	        content = `<a href='/nadaum/feed/socialFeed.do?id=${writer}&code=${code}&type=alarmMessage'>\${nickname}님이 회원님의 피드에 좋아요를 눌렀습니다.</a>`;
				    	        sendAndInsertAlarm('I',writer,alarmCode,content);
				                console.log("하트추가 성공");
				            },
				            error : function() {
				                alert('서버 에러');
				            }
				        });
				        console.log("꽉찬하트!");

				        // 꽉찬하트로 바꾸기
				        $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
				        //$('.heart_icon'+code).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

				    // 꽉찬 하트를 눌렀을 때
				    }else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
				        console.log("꽉찬하트 클릭" + code);

				        $.ajax({
				            url : '${pageContext.request.contextPath}/feed/feedMainLikeRemove.do',
				            type : 'get',
				            data : {
				                code : code
				            },
				            success : function(e) {
				                //페이지 새로고침
				                //document.location.reload(true);
								
				                console.log(e);
				                let heart = e.likes;
				                console.log("heart = " + heart);
				                // 페이지에 하트수 갱신
				                $('#m_heart'+code).text(heart);
				                //$('#heart'+code).text(heart);

				                console.log("하트삭제 성공");
				            },
				            error : function() {
				                alert('서버 에러');
				            }
				        });
				        console.log("빈하트");

				        // 빈하트로 바꾸기
				        $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
				        //$('.heart_icon'+code).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
				    }

				});
				
				$(".commentBtn").click((e) => {
					feedDetailModalView(e);
				});	
							
			});
			console.log(page);
			loading = false;
			if($resp.length === 0){
				loading = true;
			}
			console.log(loading);
		},
		error: console.log
	});
};

/* const feedMainLikeCheck = (e) => {
let code = '';
let writer = '';
let guestNickname = ${loginMember.id};

	if($(e.target).attr('class') != 'feedBodyBtn'){
		code = $(e.target).parent().parent().find("input.code").val();
		writer = $(e.target).parent().parent().parent().find("input.id").val();
	}else{
		code = $(e.target).find("input.code").val();
		writer = $(e.target).find("input.id").val();
	}
	
	feedMainLikeSave(code, writer, guestNickname);
	console.log(code, writer, guestNickname);
}  */



// 피드모달
let $hidden = $(".feedBodyBtn");
$(".commentBtn").click((e) => {
	feedDetailModalView(e);
});

const feedDetailModalView = (e) => {
	let code = '';
	let id = '';
	if($(e.target).attr('class') != 'feedBodyBtn'){
		code = $(e.target).parent().parent().find("input.code").val();
		id = $(e.target).parent().parent().find("input.id").val();
	}else{
		code = $(e.target).find("input.code").val();
		id = $(e.target).find("input.id").val();
	}
	console.log(id + " " + code);
	selectedFeed(id, code);
};

 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
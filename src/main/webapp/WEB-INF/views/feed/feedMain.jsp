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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 feed" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feed/onePersonFeedMain.css" />
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
	width: 637px;
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
    border-radius: 2px;
    background-color: #a2bffe4f;
    color: #4c536c;
}
.writeFeed{
	width: 660px;
    border: solid 1px;
    background-color: #e2e8f8;
    color: #4c536c;
    border-radius: 2px;
}
.writeFeedHeader {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    margin: 8px;
    font-size: 20px;
    margin-left: 17px;
    margin-top: 13px;
}
.writeFeedBody{
	display: flex;
    padding: 6 6 0 8px;
    margin-left: 5px
}
.feedHeader{    
	display: flex;
    justify-content: space-between;
    padding-bottom: 8px;
}
.user { display: flex;} 
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
.btnSet {
    display: flex;
    justify-content: space-between;
    margin: 3px 18px 5px 15px;
    align-items: center;
}
.feedWriteBtn{cursor: pointer;}
.feedWriteImgInputBtn{cursor: pointer;}
.writeFeedFooter{
	display: flex;
    flex-direction: column;
}
/* 첨부파일 */

#preview{margin-left: 5px;}
#preview-image{
	margin: 9px;
    width: 200px;
}
.commentBtn{cursor: pointer;}
.btn-primary {
    color: #fff;
    background-color: #0a1f33;
    border-color: #0a1f33;
    height: 36px;
}
textarea {resize: none;}

.uploadBox input[type="file"] {
	position: absolute;
  	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

.uploadBox label {
   display: inline-block;
   padding: 7px 13px;
   color: #e3e5e8;
   vertical-align: middle;
   background-color: #0a1f33;
   cursor: pointer;
   border-radius: 5px;
   height: 36.99px;
   width: 55.18px;
   margin-top: 7px;
}

/* named upload */
.uploadBox .upload-name {
  display: inline-block;
  height: 39px;
  font-size:18px; 
  padding: 0 10px;
  vertical-align: middle;
  background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-radius: 5px;
}

hr {
    margin-top: 0;
    margin-bottom: 0;
    border: 0;
    border-top: 1px solid rgba(0,0,0,.1);
}
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
  
$(document).ready(function(){ 
	 var fileTarget = $('#feedWriteImgInput'); 
	 fileTarget.on('change', function(){ // 값이 변경되면
	     var cur=$(".uploadBox input[type='file']").val();
	   $(".upload-name").val(cur);
	 }); 
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
			<!-- 버튼 모음([사진 올리기], [작성] 버튼) -->
			<div class="btnSet">
				<div class="uploadBox">
					<label for="feedWriteImgInput">사진</label> 
	  				<input class="upload-name" value="첨부파일 없당 😩" disabled="disabled">
					<input type="file" class="feedWriteImgInput" id="feedWriteImgInput" name="upFile" accept=".gif, .jpg, .png, .jpeg" onchange="readURL(this);"/> 
				</div>
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

$(".contentWrapper").scroll(function(){
    
    let wrapper = $(".contentWrapper"); // scroll이 있는 wrapper
    let feedSection = $("#mainArticle"); // wrapper 하위의 실제로 늘어나는 공간
    if(wrapper.scrollTop() >= feedSection.height() - wrapper.height() + 110){
        if(!loading){
            loading = true;
            page++
            addFeedPageMain(page);
        }
    }
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
	                    class="heart-click heart_icon\${CODE}" onclick="likeCheck(this);"><svg
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
	                    class="heart-click heart_icon\${CODE}" onclick="likeCheck(this);"><svg
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
							<hr />
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
										<span id="m_heart\${CODE}" style="padding-left: 3px;">\${LIKES}</span>	
									</div>
									<div class="commentBtn" onclick="feedDetailModalView(this);">댓글(\${COMMENTS})</div>
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
								<hr />
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
											<span id="m_heart\${CODE}" style="padding-left: 3px;">\${LIKES}</span>	
										</div>
										<div class="commentBtn" onclick="feedDetailModalView(this);">댓글(\${COMMENTS})</div>
									</div>
									<div class="feedContent">\${CONTENT}</div>
								</div>
							</div> `;
				}			
				$feedArea.append(feedDiv);		
							
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

onclick="commentView(this);"

function likeCheck(e){
	    let code = $(e).attr('idx');
		let writer = '';
		
		if($(e.target).attr('class') != 'feedBodyBtn'){
			writer = $(e).parent().parent().parent().find("input.id").val();
		}else{
			writer = $(e).find("input.id").val();
		}
		console.log(writer + " " + code);
	    console.log("heart-click");

	    // 빈하트를 눌렀을때
	    if($(e).children('svg').attr('class') == "bi bi-suit-heart"){
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
	                console.log("heart = " + heart);

	                // 페이지에 하트수 갱신
	                $('#m_heart'+code).text(heart);
	                //$('#heart'+code).text(heart);
	                
	                let ranNo = Math.floor(Math.random() * 10000);
	    			let alarmCode = 'fe-' + ranNo;
	    			let content = '';
	    			let nickname = $(".nickname").val();
	    	        content = `<a href='/nadaum/feed/socialFeed.do?id=\${writer}&code=\${code}&type=alarmMessage'>\${nickname}님이 회원님의 피드에 좋아요를 눌렀습니다.</a>`;
	    	        sendAndInsertAlarm('I',writer,alarmCode,content);
	                console.log("하트추가 성공");
	            },
	            error : function() {
	                alert('서버 에러');
	            }
	        });
	        console.log("꽉찬하트!");

	        // 꽉찬하트로 바꾸기
	        $(e).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
	        //$('.heart_icon'+code).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

	    // 꽉찬 하트를 눌렀을 때
	    }else if($(e).children('svg').attr('class') == "bi bi-suit-heart-fill"){
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
	        $(e).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
	        //$('.heart_icon'+code).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
	    }

	};


// 피드모달
let $hidden = $(".feedBodyBtn");
/* $(".commentBtn").click((e) => {
	feedDetailModalView(e);
}); */

const feedDetailModalView = (e) => {
	console.log($(e).parent());
	let code = '';
	let id = '';
	if($(e.target).attr('class') != 'feedBodyBtn'){
		code = $(e).parent().parent().find("input.code").val();
		id = $(e).parent().parent().find("input.id").val();
	}else{
		code = $(e).find("input.code").val();
		id = $(e).find("input.id").val();
	}
	console.log(id + " " + code);
	selectedFeed(id, code);
};

 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
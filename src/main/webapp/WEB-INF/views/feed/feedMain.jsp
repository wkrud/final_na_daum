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
          fileName = fileName.substring(0,7)+"...";
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
				<input type="hidden" name="writer" value="${loginMember.id}"/>
				<button type="submit" class="btn btn-primary feedWriteBtn">작성</button>
			</div>
		</div>
	</form>
</div>
	<!-- 피드 목록 -->
	<div class="feedList" id="feedList">
	<!-- 피드 출력되는 부분 -->
	</div>
	<div class="paginaiton"></div>
		<div class="feedItem" id="941">
			<div class="feedHeader">
				<div class="user" data-user="8186">
					<div class="userPic">
						<img
							src="https://indiz.kr/folder-image/2021-10/2021-10-24/profile-image/20211024215709-8186.png">
					</div>
					<div class="userInfo">
						<div class="userNickname">ENTER</div>
						<div class="userUploadDate"><fmt:formatDate value="" pattern="yyyy-MM-dd"/></div>
					</div>
				</div>
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
<script>
function YesScroll () {
	const pagination = document.querySelector('.paginaiton'); // 페이지네이션 정보획득
	const fullContent = document.querySelector('.infinite'); // 전체를 둘러싼 컨텐츠 정보획득
	const screenHeight = screen.height; // 화면 크기
	let oneTime = false; // 일회용 글로벌 변수
	document.addEventListener('scroll',OnScroll,{passive:true}) // 스크롤 이벤트함수정의
	 function OnScroll () { //스크롤 이벤트 함수
	   const fullHeight = fullContent.clientHeight; // infinite 클래스의 높이   
	   const scrollPosition = pageYOffset; // 스크롤 위치
	   if (fullHeight-screenHeight/2 <= scrollPosition && !oneTime) { // 만약 전체높이-화면높이/2가 스크롤포지션보다 작아진다면
	     oneTime = true; // oneTime 변수를 true로 변경해주고,
	     madeBox(); // 컨텐츠를 추가하는 함수
	   }
	 }
	 }
	YesScroll();

//스크롤 페이징
fnPaging();
function fnPaging(Start) {
    var LimitCount = 3;  // 몇개의 데이터를 가져올지 설정
    var Start = 1;
    var IndexStart = (Start - 1) * LimitCount; // 몇번째 인덱스 부터 데이터를 가져올지 설정
 
    //controller에 설정된 페이지 정보를 전달
    var objData = { "IndexStart" : IndexStart, "limit" : LimitCount }; 
 
    const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
    $.ajax( {
        url : "${pageContext.request.contextPath}/feed/feedMain.do",
        type : "POST",
        headers: headers,
        data : objData,
        dataType : 'json',
        async : false,   // async 는 반드시 false로 사용
        success : function(data){
        	var f = document.getElementById(feedList);
        	for (var i = 0; i < data.length; i++){
        		console.log(data[i].content);
        		
        	    }   
        	$('.feedList').append(data);
        },
        error : console.log
    });

} 
$(window).scroll(function() { 
	if($(window).scrollTop() == $(document).height() - $(window).height()){ 
		fnPaging();
	} 
});


 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
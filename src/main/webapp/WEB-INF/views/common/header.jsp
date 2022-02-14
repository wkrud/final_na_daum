<%@page import="com.project.nadaum.common.NadaumUtils"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.project.nadaum.member.model.vo.Member"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    Date now = new Date();
    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM");
     if(!"anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getPrincipal())){
	    Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    if(member.getBirthday() != null){
		    Date birth = member.getBirthday();
		    boolean isBirth = NadaumUtils.isBirthday(birth);
		    pageContext.setAttribute("isBirth", isBirth);
	    }    	
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<title>${param.title}</title>

<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!-- 제이쿼리 ui js -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- datepicker css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/datepicker.css" /> 
<!-- datepicker bcg img -->
<style>
 .ui-widget-header .ui-icon { background-image: url('${pageContext.request.contextPath}/resources/images/common/btns.png'); } 
</style>
<!-- datepicker js -->
<script src="${pageContext.request.contextPath}/resources/js/common/datepicker.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
	
<!-- 부트스트랩 js/css -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script> 

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<!-- 써머노트 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- 스톰프 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/checkAlarmJs.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member/stomp.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member/info.js"></script>

<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/cd5e4bcf92.js" crossorigin="anonymous"></script>

<!-- movie widget slide css/js -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/style.css" /> 
<!-- member -->
<link href='${pageContext.request.contextPath}/resources/css/member/admin/admin.css' rel='stylesheet' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/profile.css" />
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/member.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/help.css' rel='stylesheet' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage/memberDetail.css" />

<%-- RedirectAttriutes가 session에 저장한 msg를 꺼내서 출력(바로 제거) --%>
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
</head>
<style>
@font-face {
    font-family: 'InfinitySans-RegularA1';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
html{
 background-color: #FFFBF5;
  scroll-behavior: smooth;
}
.mainpage-container{
    margin: 0 auto;
    margin-top: 100px;
    background-color: #FFFBF5;
     font-family: 'InfinitySans-RegularA1';
       scroll-behavior: smooth;
}
.mainpage-container p {
padding: 20px;
}
.mainpage-content{
    margin-left: 200px;
    margin-right: 200px;	
}
.mainpage-image{
    margin-top: 100px;
    box-shadow: 5px 5px 20px lightgrey;
    width: 90%;
}
.mainpage-title{
    font-size: 100px;
}

.mainpage-btn-wrap {
  text-align: center;
}

.mainpage-btn {
  width: 150px;
    height: 55px;
    color: #000;
    background-color: #e2b9f0;
    border: none;
    border-radius: 30px;
    box-shadow: 0px 8px 15px rgb(0 0 0 / 10%);
    transition: all 0.3s ease 0s;
    cursor: pointer;
    outline: none;
    border: 0;
    outline: 0;
    margin-top: 50px;
  }

.mainpage-btn:hover {
  background-color: #a34dbf;
  color: #fff;
  transform: translateY(-7px);
  border: 0;
  outline: 0;
}
</style>
<body>
<!-- 비회원 / 로그인 X -->
<sec:authorize access="isAnonymous()">
<div class="mainpage-container">
  <h1 class="text-center mainpage-title" id="mainpage-title">나 : 다움</h1>
  <br />
   <h1 class="text-center">모두가 나다워지는 그날까지</h1>
	<h5 class="text-center">내 취향에 맞춘 웹사이트를 구성해보세요.</h5>
	<div class="mainpage-btn-wrap">
  <button class="mainpage-btn" id="mainpage-btn"onclick="location.href=`${pageContext.request.contextPath}/member/memberLogin.do`">시작하기</button>
</div>
	<div class="mainpage-content">
		<!--  image left  -->
  <div class="row">
    <div class="col-md-6">
		<img class="mainpage-image"src="${pageContext.request.contextPath}/resources/images/common/1.png" />
	    </div>
	    <!-- /.col-md-6 -->
	    <div class="col-md-6">
	
	      <div class="row align-items-center h-100">
	        <div class="col">
	          <h1 class="display-10">웹 사이트도 내 스타일대로! 😎</h1>
	          <br /><br />
	          <p class="lead"> 내 취향에 맞춘 웹사이트를 구성해보세요.
	            <br /><br />
	            보고싶은 위젯만 쏙쏙 골라 커스터마이징해보세요!
	            <br /><br />
	            영화, 음악, 전시, 롤 등 관심있는 정보를 바로 파악할 수 있어요. 
	          </p>
	        </div>
	      </div>
	    </div>
	  </div>
	  <!--  image right  -->
	  <div class="row">
	    <div class="col-md-6 order-md-6">
	
	      <img class="mainpage-image"src="${pageContext.request.contextPath}/resources/images/common/2.png" />
	    </div>
	    <!-- /.col-md-6 -->
	    <div class="col-md-6 order-md-1" style="text-align: right;">
	
	      <div class="row align-items-center h-100">
	        <div class="col">
	          <h1 >나다움과 함께 생산성을 높여보세요 🏃</h1>
	          <br /><br />
	          <p class="lead">체크리스트, 일기, 가계부의 다양한 기능을 활용하여 
	          <br />
	          나만의 기록을 쌓아보세요. 
	            <br /><br />
	            작심삼일 멈춰!🙅
	          </p>
	        </div>
	      </div>
	    </div>
	  </div>
	   <div class="row">
    <div class="col-md-6">
		<img class="mainpage-image"src="${pageContext.request.contextPath}/resources/images/common/3.png" />
	    </div>
	    <!-- /.col-md-6 -->
	    <div class="col-md-6">
	
	      <div class="row align-items-center h-100">
	        <div class="col">
	        <br />
	          <h1 class="display-10">친구들에게 하루를 공유해보세요 💃</h1>
	          <br /><br />
	          <p class="lead">내가 좋아하는 사진을 올리고,
	          <br /><br />
	           친구들의 사진에 좋아요를 눌러보세요 💖 
	            <br /><br />
	            알람을 받은 친구는 바로 달려올거에요! 
	            <br /><br />
	            친구와 영화, 전시회, 롤 약속을 잡을 수 있고,
	            <br /><br />
	            같이 채팅도 할 수 있어요! &#128145;
	          </p>
	          
	        </div>
	      </div>
	    </div>
	  </div>
	  <div style="text-align:end;">
	  	<a href="#mainpage-title" style="color: black; text-decoration: none;">
  		 <h2>↑ TOP</h2>
  		</a>
	  </div>
	   
	</div>
  
</div>
</sec:authorize>

<!-- 로그인 O -->
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="loginMember"/>
 <!-- 전체 영역 -->
  <div class="wrapper">
    <!-- 내비게이션 영역 -->
      <nav class="nadaum-nav">
    <ul>
      <li class="nadaum-logo">
        <a href="${pageContext.request.contextPath}">
          <span class="nav-icon"></span>
          <span class="nav-title">나:다움</span>
        </a>
      </li>
      <li class="nav-list">
        <a href="${pageContext.request.contextPath}/main/main.do">
          <span class="nav-icon"><i class="fas fa-home header-icon"></i></span>
          <span class="nav-title">홈</span>
        </a>
      </li>
      <li class="nav-list">
        <a href="${pageContext.request.contextPath}/feed/feedMain.do">
          <span class="nav-icon"><i class="fas fa-comment-dots header-icon"></i></span>
          <span class="nav-title">피드</span>
        </a>
      </li>
      <li class="nav-list">
        <a href="${pageContext.request.contextPath}/calendar/calendarView.do">
          <span class="nav-icon"><i class="far fa-calendar-alt header-icon"></i></span>
          <span class="nav-title">캘린더</span>
        </a>
      </li>
      <li class="nav-list personal-main contain-li">
          <span class="nav-icon"><i class="far fa-address-book header-icon"></i></span>
          <span class="nav-title">다이어리</span>
      </li>
        <div class="personal-sub">
          <ul>
            <li class="nav-list">
              <a href="${pageContext.request.contextPath}/diary/diaryMain.do?date=<%= date.format(now) %>-01">      
                <span class="nav-icon"></span>
                <span class="nav-title">일기</span>
              </a>
            </li>
            <li class="nav-list">
              <a href="${pageContext.request.contextPath}/accountbook/accountbook.do">      
                <span class="nav-icon"></span>
                <span class="nav-title">가계부</span>
              </a>
            </li>
          </ul>
          </div>
      <li class="nav-list culture-main contain-li">
          <span class="nav-icon"><i class="fas fa-user-friends header-icon"></i></span>
          <span class="nav-title">문화</span>
      </li>
        <div class="culture-sub">
          <ul>
            <li class="nav-list">
              <a href="${pageContext.request.contextPath}/culture/board/1">      
                <span class="nav-icon"></span>
                <span class="nav-title">전시</span>
              </a>
            </li>
            <li class="nav-list">
              <a href="${pageContext.request.contextPath}/movie/movieList.do">      
                <span class="nav-icon"></span>
                <span class="nav-title">영화</span>
              </a>
            </li>
          </ul>
        </div>
      <li class="nav-list game-main contain-li">
          <span class="nav-icon"><i class="fas fa-gamepad header-icon"></i></span>
          <span class="nav-title">게임</span>
      </li>
      	<div class="game-sub">
          <ul>
            <li class="nav-list">
              <a href="${pageContext.request.contextPath}/riot/riotheader.do">      
                <span class="nav-icon"></span>
                <span class="nav-title">롤 전적 검색</span>
              </a>
            </li>
            <li class="nav-list">
		        <a href="${pageContext.request.contextPath}/board/boardList.do">
		          <span class="nav-icon"></span>
		          <span class="nav-title">게시판</span>
		        </a>
		    </li>
          </ul>
        </div>
      <li class="nav-list">
        <a href="${pageContext.request.contextPath}/audiobook/">
          <span class="nav-icon"><i class="far fa-play-circle header-icon"></i></span>
          <span class="nav-title">오디오북</span>
        </a>
      </li>
    </ul>
    <div class="factors">
      <div>
        <a class="nav-link" href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">
          <i class="fas fa-cog"></i>
        </a>
      </div>
      <div>
        <a id="help" class="nav-link">
          <i class="far fa-question-circle"></i>
        </a>
      </div>
      <div>
          <form
            name="logoutFrm"
            method="POST"
            action="${pageContext.request.contextPath}/member/memberLogout.do">
            <button id="sign-out" class="nav-link" type="submit">
            <i class="fas fa-sign-out-alt"></i>
          </button>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          </form>	
      </div>
    </div>
  </nav>
  <!-- 헤더 -->
  <section class="mainSection">
    <div class="nadaum-header">
      <div class="nav-toggle">
        <i class="fas fa-bars"></i>
      </div>
      <div class="user-factors">
        <span class="head-nickname-span">
          <a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">
            <c:if test="${isBirth}"><i class="fa fa-birthday-cake" aria-hidden="true"></i>&nbsp;</c:if><sec:authentication property="principal.nickname"/>님의 나:다움
          </a>
        </span>
      </div>
      <div class="profile-wrap user-factors">
        <button id="profile" type="button"
          data-toggle="collapse" data-target="#alarmList" aria-expanded="false" aria-controls="alarmList">
          <div class="badge-wrap"></div>
          <div class="login-member-thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
            <c:if test="${loginMember.loginType eq 'K'}">
              <img src="${loginMember.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />
            </c:if>	
            <c:if test="${loginMember.loginType eq 'D'}">
              <c:if test="${loginMember.profileStatus eq 'N'}">							 		
                <img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
              </c:if>						
              <c:if test="${loginMember.profileStatus eq 'Y'}">		
                <img src="${pageContext.request.contextPath}/resources/upload/member/profile/${loginMember.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
              </c:if>								
            </c:if>								
          </div>						    
        </button>
        <div class="collapse" id="alarmList">
        	<div class="card card-body my-feed"><a href="${pageContext.request.contextPath}/feed/socialFeed.do?id=${loginMember.id}">내 피드 가기</a></div>
        	<div class="card card-body my-feed"><a href="javascript:void(0);" onclick="checkBadge(0);">알림 모두비우기</a></div>
        	<div class="alarms-wrap"></div>
        </div>
      </div>
    </div>
    <!-- 도움말 창 -->
      <div id="infowrap" style="display:none;">
		<div id="infowrapheader">
			<div class="info-title">			
				<h1>도움말</h1>
				<button type="button" id="closeInfo" class="close" data-dismiss="modal" aria-label="Close">
		        	<span aria-hidden="true">&times;</span>
		        </button>
			</div>
			<iframe id="nadaumInfo" title="Nadaum Info" src="${pageContext.request.contextPath}/member/mypage/memberInfo.do" >
			</iframe>
		</div>
	</div>
  <script>  	
    //메뉴 토글
    let toggle = document.querySelector('.nav-toggle');
    let nav = document.querySelector('.nadaum-nav');
    let main = document.querySelector('.mainSection');

    toggle.onclick = function() {
      nav.classList.toggle('activation');
      main.classList.toggle('activation');
    }

    //선택한 메뉴에 hoverd 클래스 추가
    let list = document.querySelectorAll('.nav-list');
    function activeLink() {
      list.forEach((item) => 
        item.classList.remove('hovered'));
        this.classList.add('hovered');
      }

    list.forEach((item) => {
      item.addEventListener('mouseover', activeLink )
    });

    $(".personal-main").click((e) => {
    	$(".personal-sub").slideToggle();
    });
    
    $(".culture-main").click((e) => {
    	$(".culture-sub").slideToggle();
    });
    
    $(".game-main").click((e) => {
    	$(".game-sub").slideToggle();
    });
    
    //알림
    $(() => {	
		connect();
		countBedge();
	});
	var dest = '${loginMember.nickname}';
	
	/* 샘플코드 */
	$("#sign-out").click(function(){
		alert("로그아웃되었습니다.");
	});
	const countBedge = () => {
    	$.ajax({
			url: `${pageContext.request.contextPath}/websocket/wsCountAlarm.do`,
			success(resp){
				const $alarmList = $(".alarms-wrap");
				const $badgeWrap = $(".badge-wrap");
				let alarmDiv = '';
				
				$alarmList.empty();
				$badgeWrap.empty();
								
				let count = 0;
				$(resp).each((i, v) => {
					const {no, code, id, status, content, regDate} = v;
					count++;					
					
					if(code.substring(0,2) == 'he'){
						alarmDiv = `<div class="card card-body alarmContent">
						<input type="hidden" name="no" value="\${no}" />
						<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${code}">\${content}</a>								
						</div>`;
					}else if(code == 'fr'){
						alarmDiv = `<div class="card card-body alarmContent"><input type="hidden" name="no" value="\${no}" />						
						\${content}</div>`;
					}else if(code.substring(0,4) == 'chat' || code.substring(0,4) == 'fcom' || code.substring(0,4) == 'flik'){
						alarmDiv = `<div class="card card-body alarmContent"><input type="hidden" name="no" value="\${no}" />\${content}</div>`;
					}else{
						alarmDiv = `<div class="card card-body alarmContent"><input type="hidden" name="no" value="\${no}" />\${content}</div>`;
					}
					$alarmList.append(alarmDiv);
					
				});
				
				if(count > 0){
					let badge = `
					<span id='bg-alarm' class='badge rounded-pill bg-danger'>\${count}</span>
					`;
					
					$badgeWrap.append(badge);
				}		
				
				$(".alarmContent").click((e) => {
			    	let no = $(".alarmContent").find('input').val();
			    	checkBadge(no);
			    });
																			
			},
			error: console.log
		});		
    };
    
    /* iframe보이기 */
    $("#help").click((e) => {
    	$("#infowrap").css("display","block");
    });
    $("#closeInfo").click((e) => {
    	$("#infowrap").css("display","none");
	});
    /* iframe 드래그 */
    dragElement(document.getElementById("infowrap"));
  </script>
  </sec:authorize>

<!-- 각자 페이지 영역 -->
<section class="contentWrapper">
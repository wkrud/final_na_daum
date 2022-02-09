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
	<jsp:param value="나:다움" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>

<article class="mainWrapper">
	<section class="main box" id="dragZone" droppable="true" ondrop="drop(event)" ondragover="dragOver(event)">
		<div class="add-widget">
			<span style="--i:0;--x:-1;--y:0" class="accept-drag" id="feed-widget">
				<i class="far fa-comments"></i>
			</span>
			<span style="--i:1;--x:1;--y:0" class="accept-drag" id="calendar-widget">
				<i class="far fa-calendar-alt"></i>
			</span>
			<span style="--i:2;--x:0;--y:-1" class="accept-drag" id="todo-widget">
				<i class="fas fa-clipboard-list"></i>
			</span>
			<span style="--i:3;--x:0;--y:1" class="accept-drag" id="memo-widget">
				<i class="far fa-edit"></i>
			</span>
			<span style="--i:4;--x:1;--y:1" class="accept-drag" id="account-widget">
				<i class="fas fa-calculator"></i>
			</span>
			<span style="--i:5;--x:-1;--y:-1" class="accept-drag" id="culture-widget">
				<i class="far fa-images"></i>
			</span>
			<span style="--i:6;--x:0;--y:0" class="accept-drag" id="movie-widget">
				<i class="fas fa-film"></i>
			</span>
			<span style="--i:7;--x:-1;--y:1" class="accept-drag" id="game-widget">
				<i class="fas fa-gamepad"></i>
			</span>
			<span style="--i:8;--x:1;--y:-1" class="accept-drag" id="audio-widget">
				<i class="far fa-play-circle"></i>
			</span>
		</div>
	</section>
</article>
<script>
//클릭시 커지게
 let addWidget = document.querySelector('.add-widget');
 addWidget.onclick = function() {
	 addWidget.classList.toggle('enlargement');
 }

 //홈 진입시 draggable 속성 추가
 $(() => {
   $(".accept-drag").attr('draggable', 'true');
   $(".accept-drag").attr('ondragstart', 'drag(event)');
 })

 //드래그 이벤트
 function drag(ev) {
   ev.dataTransfer.setData("text", ev.target.id);
 }
 
 function dragOver(ev) {
   ev.preventDefault();
 }

 function drop(ev) {
   ev.preventDefault();
   var widgetName = ev.dataTransfer.getData("text");
   console.log(widgetName);

   if(widgetName == 'feed-widget') {
     widget = `
     <div class="widget_form `+widgetName+`">
     	`+widgetName+`
     	<button onclick="deleteWidget()">지우기</button>
     </div>`
   } else if(widgetName == 'calendar-widget') {
     widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
   } else if(widgetName == 'todo-widget') {
     widget = `
     <div class="widget_form `+widgetName+`">
     	`+widgetName+`
     </div>`
   } else if(widgetName == 'memo-widget') {
     widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
     
   } else if(widgetName == 'account-widget') {
	   widget = `<div class="widget_form `+widgetName+`"></div>`
		  
	   $.ajax({
    	url : "${pageContext.request.contextPath}/accountbook/widget",
     	method : 'GET',
     	contentType : "application/json; charset=UTF-8",
     	dataType : "json",
     	success(data) { `
        <table style="margin : auto;">
          <tr>
            <td colspan="2" style="text-align : center; font-size : 20px;">${loginMember.name}님의 이번 달 미니 가계부</td>
          </tr>`
          for(const list in data) {
   		let accountList = `
		  <tr>
			<td style="font-size : 20px; text-align : center;">`+IE(list)+` : `+numberWithCommas(data[list])+`</td>   				
    	  </tr>
          }
		</table>`
   	$('.widget_form').append(accountList);
       }
        
     	},error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
     });
	   
   } else if(widgetName == 'culture-widget') {
     widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
   } else if(widgetName == 'movie-widget') {
     widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
   } else if(widgetName == 'game-widget') {
     widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
   } else if(widgetName == 'audio-widget') {
     widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
   } 
   $("#dragZone").append(widget);
 }
 
 function deleteWidget() {
	 console.log("외않데 ㅠㅠ");
 }
 
//수입 지출 변환 함수
function IE(x) {
	if(x == 'income')
		return "수입";
	else if(x == 'expense')
		return "지출";
}

//원화표시 정규식
function numberWithCommas(n) {
	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
 
</script>







<jsp:include page="/WEB-INF/views/common/footer.jsp" />
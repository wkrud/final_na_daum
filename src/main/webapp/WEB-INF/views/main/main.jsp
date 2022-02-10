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
		<div class="account">
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

 //드롭하면서 생기는 이벤트
 function drop(ev) {
   ev.preventDefault();
   var widgetName = ev.dataTransfer.getData("text");
   console.log(widgetName);
	
   	//피드
   if(widgetName == 'feed-widget') {
	   if(document.querySelector('.feed-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
   //캘린더
   else if(widgetName == 'calendar-widget') {
	   if(document.querySelector('.calendar-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
   //투두리스트
   else if(widgetName == 'todo-widget') {
	   if(document.querySelector('.todo-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`

			$.ajax({
		    	url : "${pageContext.request.contextPath}/main/insertTodoList.do",
		     	method : 'GET',
		     	contentType : "application/json; charset=UTF-8",
		     	dataType : "json",
		     	success(data) {
		     		console.log(data);
		     		if(data == 1) {
		     			$.ajax({
		     				url : "${pageContext.request.contextPath}/main/userTodoList.do",
		     				method : 'GET',
		    		     	contentType : "application/json; charset=UTF-8",
		    		     	dataType : "json",
		    		     	success(resp) {
		    		     		console.log(resp);
		    		     		console.log(resp.length);

		    		     		let todoList = "";
				    		   	todoList = `<ul class="todoListRoom">
				    		   					<li><input type="text" name="title" id="title" value="`+resp[0].title+`" /></li>
				    		   					<li><input type="text" name="regDate" value="`+timeConvert(resp[0].regDate)+`" /></li>
				    		   				</ul>
				    		   					`
				    		   				$(".widget_form").append(todoList);
		    		     		//for문으로 투두리스트 목록
	    		   				for(let i = 0; i < resp.length; i++) {		    		     			
		    		     		todoList = `
		    		     			<li>
		    		     				<input type="checkbox" name="no" id="" value="`+resp[i].no+`" />
		    		     				<input type="text" name="content" id="" value="`+resp[i].content+`" />
		    		     				<button onclick="delTodoList(`+resp[i].no+`)">삭제하기</button>
		    		     			</li>
		    		     		`
   		     					$(".todoListRoom").append(todoList);
   		     					}
	    		   				//버튼 추가
	    		   				todoList = `<button class="`+resp[0].title+`">+ 일정을 추가하세요</button>`
	    		   				$(".todoListRoom").append(todoList);
		    		     	},error(xhr, testStatus, err) {
		    					console.log("error", xhr, testStatus, err);
		    					alert("위젯 로딩에 실패했습니다.");
		    				}
		     			});
		     		} else {
		     			alert("위젯 등록에 실패했습니다.");
		     		} //success 끝
		     	},error(xhr, testStatus, err) {
					console.log("error", xhr, testStatus, err);
					alert("조회에 실패했습니다.");
				}
		     });
	   } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   }    
	//메모
   else if(widgetName == 'memo-widget') {
	   if(document.querySelector('.memo-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
     
   } 
   	//가계부
   else if(widgetName == 'account-widget') {
	   if(document.querySelector('.account-widget') == null) {
		   widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)"><button onclick="delWidget(`+widgetName+`)">삭제하기</button></div>`
			  
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
	   } else {
		   alert('위젯은 하나만 생성할 수 있습니다.');
	       return;
	   }  
   } 
 	//전시
 	else if(widgetName == 'culture-widget') {
 		if(document.querySelector('.culture-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//영화
 	else if(widgetName == 'movie-widget') {
 		if(document.querySelector('.movie-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//게임
 	else if(widgetName == 'game-widget') {
 		if(document.querySelector('.game-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//오디오북
 	else if(widgetName == 'audio-widget') {
 		if(document.querySelector('.audio-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//생성한 내용을 dragZone에 추가
   $("#dragZone").append(widget);
 }
 
 //위젯 이름으로 지우기
 function delWidget(name) {
	 console.log("외않데 ㅠㅠ");
 }
 
 //투두리스트 삭제
 function delTodoList(no) {
	 let no = {"no" : no};
	 $.ajax({
    	url : "${pageContext.request.contextPath}/main/deleteTodoList.do",
     	method : 'POST',
     	data : JSON.stringify(no),
     	contentType : "application/json; charset=UTF-8",
     	dataType : "json",
		headers : headers,
     	success(data) {
				location.reload();
		}, 
		error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	 });
	};
 
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

//시간 변환
function timeConvert(t){
	var unixTime = Math.floor(t / 1000);
    var date = new Date(unixTime*1000);
    var year = date.getFullYear();
    var month = "0" + (date.getMonth()+1);
    var day = "0" + date.getDate();
    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
}
 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
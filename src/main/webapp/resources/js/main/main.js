
//기본값
 let $id = $("#id").val();
 let $contextPath = $("#contextPath").val();



//클릭시 커지게
 let addWidget = document.querySelector('.add-widget');
 addWidget.onclick = function() {
	 addWidget.classList.toggle('enlargement');
 }

 //홈 진입시 draggable 속성 추가, 만들어진 위젯 존재하면 띄워주기
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
		   //내려놓을 때 db 등록
		  	$.ajax({
		    	url : $contextPath+"/main/insertWidget.do",
		     	method : 'GET',
		     	data : {
		     		"widgetName" : widgetName
		     	},
		     	contentType : "application/json; charset=UTF-8",
		     	dataType : "json",
		     	success(data) {
		     		console.log(data);
		     		alert("등록 성공");
		     	}, error(xhr, testStatus, err) {
    					console.log("error", xhr, testStatus, err);
    					alert("위젯 등록에 실패했습니다.");
    				}
     			});
		   
		  //위젯 박스 생성
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`
	        		<button onclick="delWidget(`+widgetName+`)">위젯 삭제</button></div>`
		   
			//투두리스트 자동 등록
			$.ajax({
		    	url : $contextPath+"/main/insertTodoList.do",
		     	method : 'GET',
		     	contentType : "application/json; charset=UTF-8",
		     	dataType : "json",
		     	success(data) {
		     		console.log(data);
		     		//투두리스트 insert 성공시 리스트 로딩
		     		if(data == 1) {
		     			$.ajax({
		     				url : $contextPath+"/main/userTodoList.do",
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
	    	url : $contextPath+"/accountbook/widget",
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
	   	$('.account-widget').append(accountList);
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
	      
	      $.ajax({
		 	url : $contextPath+"/movie/widgetMovie.do",
		 	method : 'GET',
	     	contentType : "application/json; charset=UTF-8",
	     	dataType : "json",
	     	success(data) {
				console.log(data);
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	      
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//게임
 	else if(widgetName == 'game-widget') {
 		if(document.querySelector('.game-widget') == null) {
	        widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)">`+widgetName+`</div>`
		    data = { "member_id" : $id}; 
	        $.ajax({
		    	url : $contextPath+"/riot/riotWidget.do",
		     	method : 'POST',
		     	contentType : "application/json; charset=UTF-8",
		     	dataType : "json",
		     	headers : headers,
		     	data : JSON.stringify(data),
		     	success(resp) { 
		     		console.log(resp);
		     	}, error(xhr, testStatus, err) {
					console.log("error", xhr, testStatus, err);
					alert("조회에 실패했습니다.");
				}
		    }); 
 		 
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
 function delWidget(w) {
	 console.log(w);
 }
 
 //투두리스트 삭제
 function delTodoList(no) {
	 $.ajax({
    	url : $contextPath+"/main/deleteTodoList.do",
     	method : 'POST',
     	data : {
     		"no" : no,
     	},
		headers : headers,
     	success(data) {
			//div 새고하니까 날라가는데?????????
				$('.todo-widget').load(location.href+' .todo-widget');
				$.ajax({
     				url : $contextPath+"/main/userTodoList.do",
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
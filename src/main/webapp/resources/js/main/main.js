
//기본값
 let $id = $("#id").val();
 let $contextPath = $("#contextPath").val();
 let $nickName = $("#nickName").val();

//클릭시 커지게
 let addWidget = document.querySelector('.add-widget');
 addWidget.onclick = function() {
	 addWidget.classList.toggle('enlargement');
 };

 $(() => {
 	//홈 진입시 draggable 속성 추가, 만들어진 위젯 존재하면 띄워주기
   $(".accept-drag").attr('draggable', 'true');
   $(".accept-drag").attr('ondragstart', 'drag(event)');
   
   //위젯이 존재하면 해당 내용 로딩
    if(document.querySelector('.game-widget') != null) {
 	  gameWidgetInfo();
   } 
	if (document.querySelector('.todo-widget') != null) {
  	 todoListWidgetInfo();	
   } 
    if (document.querySelector('.account-widget') != null) {
  	 accountbookWidgetInfo();	
   }
   	if (document.querySelector('.culture-widget') != null){
	cultureWidgetInfo();
   }
   	if (document.querySelector('.audio-widget') != null) {
	audiobookWidgetInfo();
   }
   if (document.querySelector('.movie-widget') != null) {
	movieWidgetInfo();
   }
   
 })

 //드래그 이벤트
const drag = (ev) => {
   ev.dataTransfer.setData("text", ev.target.id);
 }
 
const dragOver = (ev) => {
   ev.preventDefault();
 }

 //드롭하면서 생기는 이벤트
const drop = (ev) => {
   ev.preventDefault();
   let widgetName = ev.dataTransfer.getData("text");
   let widget = `<div class="widget_form `+widgetName+`"draggable=true" "ondragstart=drag(event)"></div>`

   
	//내려놓을 때 db 등록
   const insertWidget = () => {
	  	$.ajax({
	    	url : $contextPath+"/main/insertWidget.do",
	     	method : 'GET',
	     	data : {
	     		"widgetName" : widgetName
	     	},
	     	contentType : "application/json; charset=UTF-8",
	     	dataType : "json",
	     	success(data) {
				if(data==1) {
		     		alert("위젯 등록 성공");					
				} 
	     	}, error(xhr, testStatus, err) {
					console.log("error", xhr, testStatus, err);
					alert("위젯 등록에 실패했습니다.");
				}
 			});
	}
	
	//위젯 생성
   	//피드
   if(widgetName == 'feed-widget') {
	   if(document.querySelector('.feed-widget') == null) {
	        insertWidget(); 
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
   //캘린더
   else if(widgetName == 'calendar-widget') {
	   if(document.querySelector('.calendar-widget') == null) {
	        insertWidget(); 
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
   //투두리스트
   else if(widgetName == 'todo-widget') {
	   if(document.querySelector('.todo-widget') == null) {
		   insertWidget();   
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
		     			todoListWidgetInfo();
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
	        insertWidget(); 
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
     
   } 
   	//가계부
   else if(widgetName == 'account-widget') {
	   if(document.querySelector('.account-widget') == null) {
		   insertWidget();
		   accountbookWidgetInfo();
	   } else {
		   alert('위젯은 하나만 생성할 수 있습니다.');
	       return;
	   }  
   } 
 	//전시
 	else if(widgetName == 'culture-widget') {
 		if(document.querySelector('.culture-widget') == null) {
	        insertWidget(); 
	        cultureWidgetInfo();
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//영화
 	else if(widgetName == 'movie-widget') {
 		if(document.querySelector('.movie-widget') == null) {
	        insertWidget(); 
	      	movieWidgetInfo();
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//게임
 	else if(widgetName == 'game-widget') {
 		if(document.querySelector('.game-widget') == null) {
			insertWidget();
		    gameWidgetInfo();
 		 } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//오디오북
 	else if(widgetName == 'audio-widget') {
 		if(document.querySelector('.audio-widget') == null) {
	        insertWidget(); 
	        audiobookWidgetInfo();
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
 	//생성한 내용을 dragZone에 추가
   $("#dragZone").append(widget);

 }
 
 //위젯 delete
 const delWidget = (no) => {
	$.ajax({
    	url : $contextPath+"/main/deleteWidget.do",
     	method : 'POST',
     	data : {
     		"no" : no,
     	},
		headers : headers,
     	success(data) {
			console.log(data);
			alert("위젯 삭제 완료");
			location.reload();
		},error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("위젯 로딩에 실패했습니다.");
		}
	});
	}
 
 //투두리스트 삭제
const delTodoList = (no) => {
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


//위젯 정보 로딩용

//게임
const gameWidgetInfo = () => {
	//정보 로딩
   member_Id = {"member_Id" : $id};
   $.ajax({
		url : $contextPath+"/riot/riotWidget.do",
	 	method : 'POST',
	 	contentType : "application/json; charset=UTF-8",
	 	dataType : "json",
	 	headers : headers,
	 	data : JSON.stringify(member_Id),
	 	success(resp) { 
	 		console.log(resp);
	 		console.log(resp.widgetinfo.leaguePoints);
				let content = `
				<table>
					<tr>
						<td>닉네임 : `+resp.widgetinfo.name+`</td>
						<td>리그포인트 : `+resp.widgetinfo.leaguePoints+`</td>
						<td>랭크 : `+resp.widgetinfo.rank+`</td>
					</tr>
					<tr>
						<td>티어 : `+resp.widgetinfo.tier+`</td>
						<td>승 : `+resp.widgetinfo.wins+`</td>
						<td>패 : `+resp.widgetinfo.losses+`</td>
					</tr>
				</table>
				`
				$(".game-widget").append(content);
	 	}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	});
}

//투두리스트
const todoListWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/main/userTodoList.do",
		method : 'GET',
	 	contentType : "application/json; charset=UTF-8",
	 	dataType : "json",
	 	success(resp) {
	 		console.log(resp);
	 		console.log(resp.length);
	 		console.log(resp[0].title);
	 		let content = "";
	 		content = `
	 			<div>
	 				<p>투두리스트 제목 : `+resp[0].title+`</p>
	 				<p>등록일 : `+timeConvert(resp[0].regDate)+`</p>
	 				<ul class="todoListContent">
	 				<ul>
	 			</div>
	 		`
	 		$(".todo-widget").append(content);
	 		for(data in resp) {
				content = `
					<li> 
						<input type="checkbox" name="finish" id="doing" />
						<label for="doing">
						<p>`+resp[data].content+`</p>	
						</label>
					</li>
				`
				$(".todoListContent").append(content);
			}
	 	}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	});
}

//가계부
const accountbookWidgetInfo = () => {
	$.ajax({
    	url : $contextPath+"/accountbook/widget",
     	method : 'GET',
     	contentType : "application/json; charset=UTF-8",
     	dataType : "json",
     	success(resp) {
			console.log(resp);
			let content = "";
			content = `
				<div>
					<table>
						<tr>
							<th colspan="2">`+$nickName+`님의 이번 달 가계부</th>
						</tr>
						<tr class="accountList">
						</tr>
					</table>
				</div>
			`;
			$(".account-widget").append(content);
			for(let i = 0; i < 1; i++) {
				content = `
				<td>수입 : `+numberWithCommas(resp.income)+`</td>
				<td>지출 : `+numberWithCommas(resp.expense)+`</td>
				`
				$(".accountList").append(content);
			}
		}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	});
}

//전시
const cultureWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/culture/widget.do",
		method : 'POST',
		contentType : "application/json; charset=UTF-8",
     	dataType : "json",
     	headers : headers,
     	success(resp) {
			console.log(resp);
			let content = "";
			for(data in resp) {
				content = `
					<div style="text-align : center; display:inline-block;">
						<img style="width : 300px; height : 400px"src=`+resp[data].imgUrl+`>
						<p>`+resp[data].title+`</p>
						<p>전시 기간 : `+resp[data].startDate+`~`+resp[data].endDate+`</p>
					</div>
				`
				$(".culture-widget").append(content);
			}
		}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
     	
	});
}


//캘린더
const calendarWidgetInfo = () => {
	
}


//오디오북
const audiobookWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/audiobook/widget",
		method : 'POST',
		contentType : "application/json; charset=UTF-8",
     	dataType : "json",
     	headers : headers,
     	success(resp) {
			console.log(resp);
				let content = `
				<p>`+resp.albumInfo.kind+` 장르의 이런 오디오북 감상은 어떠세요?</p>
				<p>이미지 링크: `+resp.imgLink+`</p>
				<p>링크는 잘 불러오는데 제 컴터에 사진이 안 올라와서 안 떠여~~</p>
				<img src=`+resp.imgLink+`>
				<p>제목 : `+resp.albumInfo.title+`</p>
				<p>creator : `+resp.albumInfo.creator+`</p>
				<p>provider : `+resp.albumInfo.provider+`</p>				
				`
				$(".audio-widget").append(content);
		}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
     	
	});
}


//영화 
const movieWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/movie/widgetMovie.do",
		method : 'GET',
		contentType : "application/json; charset=UTF-8",
     	dataType : "json",
     	headers : headers,
     	success(resp) {
			console.log(resp);
				let content = ""; 
				content	= `
				<div class="page-wrapper" style="position: relative;">
				<div class="post-slider">
					<h1 class="silder-title">Upcoming Movies</h1>
					<a href="`+$contextPath+`/movie/movieList.do"
						class="post-subject">+더보기</a> 
					<i class="fas fa-chevron-left prev"></i>
					<i class="fas fa-chevron-right next"></i>

					<div class="post-wrapper">
					`
				$(".movie-widget").append(content);
				for(data in resp) {
					content = `<div class="card post" style="width: 18rem;">
								<img class="card-img-top slider-image"
									src="https://image.tmdb.org/t/p/w500`+resp[data].posterPath+`"
									alt="Card image cap">
								<div class="card-body post-info">
									<p class="card-text widget-movie-title">`+resp[data].title+`</p>
									<p class="card-text widget-movie-rating">평점 : `+resp[data].voteAverage+`</p>
								</div>
							</div>`
					$(".movie-widget").append(content);
				}
				content = `</div>
						</div>
					</div>
				</div>`
				$(".movie-widget").append(content);
		}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
     	
	});
}

	
 
//수입 지출 변환 함수
const IE = (x) => {
	if(x == 'income')
		return "수입";
	else if(x == 'expense')
		return "지출";
}

//원화표시 정규식
const numberWithCommas = (n) => {
	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//시간 변환
const timeConvert = (t) => {
	var unixTime = Math.floor(t / 1000);
    var date = new Date(unixTime*1000);
    var year = date.getFullYear();
    var month = "0" + (date.getMonth()+1);
    var day = "0" + date.getDate();
    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
}


/* 슬라이드 스크립트*/
	$('.post-wrapper').slick({
	  slidesToShow: 2,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	  nextArrow:$('.next'),
	  prevArrow:$('.prev'),
	});


//기본값
 let $id = $("#id").val();
 let $contextPath = $("#contextPath").val();
 let $nickName = $("#nickName").val();
 let $csrfToken = $("#csrfToken").val();
 let $csrfParameterName = $("#csrfParameterName").val();

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
   /*if (document.querySelector('.memo-widget') != null) {
	memoWidgetInfo();
   }*/
   if (document.querySelector('.alert-widget') != null) {
	alertWidgetInfo();
   }
   if (document.querySelector('.friend-widget') != null) {
	friendWidgetInfo();
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
   	//친구
   if(widgetName == 'friend-widget') {
	   if(document.querySelector('.friend-widget') == null) {
	        insertWidget(); 
	        friendWidgetInfo();
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } 
   //캘린더
/*   else if(widgetName == 'calendar-widget') {
	   if(document.querySelector('.calendar-widget') == null) {
	        insertWidget(); 
	      } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   } */
   //알림 불러오기
   else if(widgetName == 'alert-widget') {
	   if(document.querySelector('.alert-widget') == null) {
		   insertWidget();   
		   alertWidgetInfo();
	   } else {
	        alert('위젯은 하나만 생성할 수 있습니다.');
	        return;
	      }
   }    
	//메모
/*   else if(widgetName == 'memo-widget') {
	   if(document.querySelector('.memo-widget') == null) {
	        insertWidget(); 
	        //메모 자동 등록
			$.ajax({
		    	url : $contextPath+"/main/insertMemo.do",
		     	method : 'GET',
		     	contentType : "application/json; charset=UTF-8",
		     	dataType : "json",
		     	success(data) {
		     		console.log(data);
		     		//메모 insert 성공시 리스트 로딩
		     		if(data == 1) {
		     			memoWidgetInfo();
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
     
   } */
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
			alert("위젯 삭제에 실패했습니다.");
		}
	});
}


//위젯 정보 로딩용
//친구 위젯
const friendWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/member/mypage/memberFriendWidget.do",
		method : 'GET',
		contentType : "application/json; charset=UTF-8",
	 	dataType : "json",
		success(resp) {
		console.log(resp);		
			let content = "";
			content = `
			<div style="display : flex; text-align : center; width : 200px;">
				<div class="friendTogetherInfo" style="margin : 0px 30px;">
					<p style="border-bottom : 1px solid gray; margin : 10px auto;">친구</p>
				</div>
				<div class="friendStraightInfo">
					<p style="border-bottom : 1px solid gray; margin : 10px auto;">팔로워</p>
				</div>
			</div>
			`
			$(".friend-widget").append(content);

			if(resp.widgetFriends.length == 0) {
				content = `
					<span>친구 목록이<br/>존재하지<br/>않습니다.</span>
				`			
				$(".friendTogetherInfo").append(content);	
			} else {
			//맞팔
			for(let i = 0; i <resp.widgetFriends.length; i++) {
				//D타입 각자 프사
				if(resp.widgetFriends[i].loginType == 'D' && resp.widgetFriends[i].profile != null) {
					content = `
						<div class="activeWithFriends" style="width : 50px; height : 80px; margin : 10px auto; border-bottom : 1px solid gray;">
						<a style="text-decoration : none; color : black;" href="`+$contextPath+`/feed/socialFeed.do?id=`+resp.widgetFriends[i].id+`")>
						<div class="friendProfileImg">
							<img style = "width : 50px; height : 50px; border-radius : 50%;" src="`+$contextPath+`/resources/upload/member/profile/`+resp.widgetFriends[i].profile+`">
						</div>
						<span>`+resp.widgetFriends[i].nickname+`</span>
						</a>
						</div>
					`
					$(".friendTogetherInfo").append(content);
					//d타입 기본 고양이 프사
				} else if(resp.widgetFriends[i].loginType == 'D' && resp.widgetFriends[i].profile == null) {
					content = `
						<div class="activeWithFriends" style="width : 50px; height : 80px; margin : 10px auto; border-bottom : 1px solid gray;">
						<a style="text-decoration : none; color : black;" href="`+$contextPath+`/feed/socialFeed.do?id=`+resp.widgetFriends[i].id+`")>
						<div class="friendProfileImg">
							<img style = "width : 50px; height : 50px; border-radius : 50%;" src="`+$contextPath+`/resources/upload/member/profile/default_profile_cat.png">
						</div>
						<span>`+resp.widgetFriends[i].nickname+`</span>
						</a>
						</div>
					`
					$(".friendTogetherInfo").append(content);
					}
					//k타입은 주소 필요 없이 이미지 경로
					else {
					content = `
						<div class="activeWithFriends" style="width : 50px; height : 80px; margin : 10px auto; border-bottom : 1px solid gray;">
						<a style="text-decoration : none; color : black;" href="`+$contextPath+`/feed/socialFeed.do?id=`+resp.widgetFriends[i].id+`")>
						<div class="friendProfileImg">
							<img style = "width : 50px; height : 50px; border-radius : 50%;" src=`+resp.widgetFriends[i].profile+`>
						</div>
						<span>`+resp.widgetFriends[i].nickname+`</span>
						</a>
						</div>
					`
					$(".friendTogetherInfo").append(content);

				}
			}
		}
			//팔로워
			if(resp.widgetFollowers.length == 0) {
				content = `
					<span>팔로워 목록이<br/>존재하지<br/>않습니다.</span>
				`			
				$(".friendStraightInfo").append(content);	
			} else {
			for(let i = 0; i <resp.widgetFollowers.length; i++) {
				if(resp.widgetFollowers[i].loginType == 'D' && resp.widgetFollowers[i].profile != null) {
					content = `
						<div class="activeWithFriends" style="width : 50px; height : 80px; margin : 10px auto; border-bottom : 1px solid gray;">
						<a style="text-decoration : none; color : black;" href="`+$contextPath+`/feed/socialFeed.do?id=`+resp.widgetFollowers[i].id+`")>
						<div class="friendProfileImg">
							<img style = "width : 50px; height : 50px; border-radius : 50%;" src="`+$contextPath+`/resources/upload/member/profile/`+resp.widgetFollowers[i].profile+`">
						</div>
						<span>`+resp.widgetFollowers[i].nickname+`</span>
						</a>
						</div>
					`
					$(".friendStraightInfo").append(content);
				} else if(resp.widgetFollowers[i].loginType == 'D' && resp.widgetFollowers[i].profile == null) {
					content = `
						<div class="activeWithFriends" style="width : 50px; height : 80px; margin : 10px auto; border-bottom : 1px solid gray;">
						<a style="text-decoration : none; color : black;" href="`+$contextPath+`/feed/socialFeed.do?id=`+resp.widgetFollowers[i].id+`")>
						<div class="friendProfileImg">
							<img style = "width : 50px; height : 50px; border-radius : 50%;" src="`+$contextPath+`/resources/upload/member/profile/default_profile_cat.png">
						</div>
						<span>`+resp.widgetFollowers[i].nickname+`</span>
						</a>
						</div>
					`
					$(".friendStraightInfo").append(content);
				} else {
					content = `
						<div class="activeWithFriends" style="width : 50px; height : 80px; margin : 10px auto; border-bottom : 1px solid gray;">
						<a style="text-decoration : none; color : black;" href="`+$contextPath+`/feed/socialFeed.do?id=`+resp.widgetFollowers[i].id+`")>
						<div class="friendProfileImg">
							<img style = "width : 50px; height : 50px; border-radius : 50%;" src=`+resp.widgetFollowers[i].profile+`>
						</div>
						<span>`+resp.widgetFollowers[i].nickname+`</span>
						</a>
						</div>
					`
					$(".friendStraightInfo").append(content);

				}
			}
		}
			
		}, //success 끝
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}	
	})
}

//알림 불러오기
const alertWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/websocket/wsCountAlarm.do",
		method : 'GET',
		contentType : "application/json; charset=UTF-8",
	 	dataType : "json",
		success(resp) {
			let content = "";
			if(resp.length == 0) {
				content = `
					<p>최신 알림 내역이 존재하지 않습니다 :(<br/>지금 나:다움에서 친구들과 소통해 보는 건 어떠세요?</p>
					<p><a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/feed/feedMain.do">나:다움 피드 구경가기</a></p>
				`
				$(".alert-widget").append(content);
			} else {
			content = `
				<div style="width : 360px; padding : 10px; border-radius : 5px;" class="alertList"></div>
			`
			$(".alert-widget").append(content);
			$(resp).each((i, v) => {
				if(i < 5) {
					content = `
					<div style="border-bottom: 1px solid lightgray;">
				      <p style="margin : 5px 0px;"><span style="color : rgb(238, 210, 88);"><i class="fas fa-bell"></i></span> 
				       `+resp[i].content+`<br><span style="color : gray; margin-left : 20px;">`+timeConvert(resp[i].regDate)+`</span>
				      </p>
				    </div>
				`
				$(".alertList").append(content);
				}
			});
			content = `
				<span style="margin:10px; float : right;"><a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/member/mypage/memberDetail.do?tPage=alarm"> + 지난 알림 보러 가기 </a></span>
			`
			$(".alertList").append(content);
			}
		}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	})
}

/*//메모
const memoWidgetInfo = () => {
	$.ajax({
		url : $contextPath+"/main/userMemoList.do",
		method : 'GET',
	 	contentType : "application/json; charset=UTF-8",
	 	dataType : "json",
	 	success(resp) {
	 		console.log(resp);
	 		console.log(resp.length);
	 		let content = `
	 			<div class="memoContentDiv">
	 			<form 
	 				action="`+$contextPath+`/main/updateMemoList.do"
	 				method="POST">
	 				<textarea name="content" id="memoBox" cols="20" rows="10" style="resize:none;">`+resp[0].content+`</textarea>
	 				<input type="hidden" id ="csrfToken" name="`+$csrfParameterName+`" value="`+$csrfToken+`"/>
	 				<input type="hidden" name="code" value="`+resp[0].code+`">
	 			<button type="submit">메모 저장</button>
	 			</form>
	 			</div>
	 		`
	 		$(".memo-widget").append(content);
	 	}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	});
}*/

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
		let content = "";
			if(resp.widgetinfo == null) {
				if(resp.widgetnullcheck == null) {					
				content = `
					<div>
						<p>아직 즐겨찾기한 롤 유저가 없어요 :(<br/>지금 마음에 드는 유저를 즐겨찾기 해 보는 건 어떨까요?</p>
						<p><a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/riot/riotheader.do">LOL 유저 검색하러 가기</a><span style="color : rgb(238, 210, 88);"> <i class="fas fa-star"></i></span></p>
					</div>
					`
					$(".game-widget").append(content);
				} else {
					content = `
					<div style="width : 450px; height: 160px; padding : 10px; box-sizing : border-box;">
					    <div style="text-align: center; font-size : 20px;">
					    	<a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/riot/riot1.do?nickname=`+resp.widgetnullcheck.name+`"><h4>`+resp.widgetnullcheck.name+`</h4></a>
					    </div>
					    <div style="display: inline-flex;"><img src="`+$contextPath+`/resources/images/riot/unranked.png" alt="" style="width : 70px; height: 70px; margin-left : 20px;"></div>
					    <div style="display: inline-flex; position: relative; bottom : 40px; left : 10px;">
					      <p>즐겨찾기한 유저의 랭크 정보가 존재하지 않아요 :(<br>지금 친구와 함께 즐거운 게임 한 판 어떨까요?</p>
					    </div>
					    <div style="text-align: center; position : relative; bottom : 40px;">
					      <span>
					        <a style="text-decoration : none;" href="`+$contextPath+`/board/boardList.do">친구와 약속 잡기</a>
					      </span>
					    </div>
					  </div>
					`
					$(".game-widget").append(content);
				}
			} else {
				content = `
				<div style="width : 360px; height: 140px; padding : 5px; display : flex;">
				  <div style="width : 120px; height : 120px; margin-top : 5px;">
				    <img style="width : 120px; height : 120px;"src="`+$contextPath+`/resources/images/riot/`+resp.widgetinfo.tier+`.png" alt="롤 랭킹 이미지">
				  </div>
				   <div style="font-size : 18px; margin-left : 10px;">
				    <ul style="list-style: none;">
				      <li style="margin : 10px;">
				      	<a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/riot/riot1.do?nickname=`+resp.widgetinfo.name+`"><h4 style="margin : 0">`+resp.widgetinfo.name+`</h4></a>
				      </li>
				      <li style="margin : 10px;">`+resp.widgetinfo.tier+` `+resp.widgetinfo.rank+` `+resp.widgetinfo.leaguePoints+`LP</li>
				      <li style="margin : 10px;"><span style="color : #00BFFF;">승리 : `+resp.widgetinfo.wins+`</span><span style="color : #CD5C5C; margin : 0 15px;">패배 : `+resp.widgetinfo.losses+`</span></li>
				    </ul>
				  </div>
				</div>
				`
			$(".game-widget").append(content);
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
			let content = "";
				content = `
					<div style="padding : 15px;">
						<div style="margin : auto; text-align : center;">
							<a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/accountbook/accountbook.do">
								<h4>`+$nickName+`님의 이번 달 가계부</h4>
							</a>
						</div>
						<table style="text-align : center; font-size : 20px;">
							<tr>
								<td><span>수입</span></td>
								<td><span>지출</span></td>
							</tr>
							<tr class="accountList">
							</tr>
						</table>
					</div>
				`;
				$(".account-widget").append(content);
				for(let i = 0; i < 1; i++) {
					content = `
					<td style="width : 150px;"><span style="color : green;">+`+numberWithCommas(resp.income)+`원</span></td>
					<td style="width : 150px;"><span style="color : red;">-`+numberWithCommas(resp.expense)+`원</span></td>
					`
					$(".accountList").append(content);
				}
		}, //success 끝
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
				if(resp.length == 0) {
					content = `
					<div>
						<p>스크랩한 전시가 없어요 :(<br/>지금 나:다움과 함께 전시회 나들이 어떠세요?</p>
						<p><a style="text-decoration : none; color : #0D5FB7;" href="`+$contextPath+`/culture/board/1">문화생활 즐기기</a><span style="color : rgb(238, 210, 88);"> <i class="fas fa-star"></i></span></p>
					</div>
					`
					$(".culture-widget").append(content);
				} else {
					content	= `
					<div class="page-wrapper" style="position: relative;">
					<div class="post-slider" style="width:300px; height : 360px; margin: 0px auto; 
						position: relative; text-align: center; margin: 0; overflow : hidden;">
						<a href="`+$contextPath+`/culture/board/1"class="post-subject" style="text-decoration : none; color : black;">
							<h1 class="slider-title" style="text-align: center; margin: 0; font-size:20px !important;">CultureScrap</h1>
						</a> 
						<i class="fas fa-chevron-left prevC" style="position: absolute; top: 50%; left: -2px; font-size: 1em;
						color: gray; cursor: pointer; z-index : 5;"></i>
						<i class="fas fa-chevron-right nextC" style="position: absolute; top: 50%; right: -2px; font-size: 1em;
						color: gray; cursor: pointer; z-index : 5;"></i>
						<div class="culture-wrapper" style="width:300px; height : 400px; margin: 0px auto; left : 10%; overflow: hidden; padding: 10px 0px 10px 0px;">
						</div>
					</div>
					</div>
						`
					$(".culture-widget").append(content);
					for(data in resp) {
						content = `<div class="card post" style="background-color : #E2DFDA; border : none;">
									<img style = "width : 120px; height : 180px;"class="card-img-top slider-image"
										src="`+resp[data].imgUrl+`"
										alt="Card image cap">
									<p class="card-text widget-movie-title">`+resp[data].title+`</p>
								</div>`
						$(".culture-wrapper").append(content);
					}
						$('.culture-wrapper').slick({
						  slidesToShow: 2,
						  slidesToScroll: 1,
						  autoplay: true,
						  autoplaySpeed: 2000,
						  nextArrow:$('.nextC'),
						  prevArrow:$('.prevC'),
						});
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
				let content = `
				<div style="width : 360px; height : 120px; padding : 10px; box-sizing: border-box;">
				    
				    <div style="display: inline-flex;">
				      <div style="margin : 0px 20px"><img src="`+$contextPath+``+resp.imgLink+`" style="width : 100px; height : 100px; border-radius: 5px;" alt=""></div>
				      <div>
				        <span style="font-size: 20px; display: block;">`+resp.albumInfo.title+`</span>
				        <span style="color : gray;">`+resp.albumInfo.creator+`</span>
				        <a style="text-decoration : none; color : black;" href="`+$contextPath+`/audiobook/detail?code=`+resp.albumInfo.code+`">
					        <div style="font-size : 18px; justify-content: space-between; width : 150px; display: flex; margin : 20px;">
					          <i class="fas fa-step-backward"></i>
					          <i class="fas fa-play"></i>
					          <i class="fas fa-fast-forward"></i>
					        </div>
				        </a>
				    </div>
				    </div>
				  </div>			
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
			let content = ""; 
			content	= `
			<div class="page-wrapper" style="position: relative;">
			<div class="post-slider" style="width:300px; height : 360px; margin: 0px auto; 
				position: relative; text-align: center; margin: 0; overflow : hidden;">
				<a href="`+$contextPath+`/movie/movieList.do" class="post-subject" style="text-decoration : none; color : black;">
					<h1 class="silder-title" style="text-align: center; margin: 0; font-size:20px !important;">Upcoming Movies</h1>
				</a> 
				<i class="fas fa-chevron-left prevM" style="position: absolute; top: 50%; left: -2px; font-size: 1em;
				color: gray; cursor: pointer; z-index : 5;"></i>
				<i class="fas fa-chevron-right nextM" style="position: absolute; top: 50%; right: -2px; font-size: 1em;
				color: gray; cursor: pointer; z-index : 5;"></i>
				<div class="post-wrapper" style="width:300px; height : 400px; margin: 0px auto; left : 10%; overflow: hidden; padding: 10px 0px 10px 0px;">
				</div>
			</div>
			</div>
				`
			$(".movie-widget").append(content);
			for(data in resp) {
				content = `<div class="card post" style="background-color : #E2DFDA; border : none;">
							<img class="card-img-top slider-image" stlye="width : 120px; height : 180px;"
								src="https://image.tmdb.org/t/p/w500`+resp[data].posterPath+`"
								alt="Card image cap"
								onclick="location.href='`+$contextPath+`/movie/movieDetail/`+resp[data].apiCode+`'">
							<div class="card-body post-info">
								<p class="card-text widget-movie-title">`+resp[data].title+`</p>
								<p class="card-text widget-movie-rating">평점 : `+resp[data].voteAverage+`</p>
							</div>
						</div>`
				$(".post-wrapper").append(content);
			}
				$('.post-wrapper').slick({
				  slidesToShow: 2,
				  slidesToScroll: 1,
				  autoplay: true,
				  autoplaySpeed: 2000,
				  nextArrow:$('.nextM'),
				  prevArrow:$('.prevM'),
				});
		}, 
	 	error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
     	
	});
}


//위젯 삭제 버튼
$(".clearWidgetBtn").on('click', function(){
		$(".delWidgetBtn").toggle();
	});

//친구 누르면 창 뜨게
$(document).on("click", ".activeWithFriends", function() {
	
});
 
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


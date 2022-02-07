var windowObjHistorySearch = null;

function connect(){
	var socket = new SockJS("http://localhost:9090/nadaum/chat");
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, function(frame){
		stompClient.subscribe("/topic/" + dest, function(response){
			var resp = JSON.parse(response.body);
			console.log('resp = ', resp);
			
			if(resp.type == 'friend'){
				countBedge();
				console.log('count');
			}else if(resp.type == 'chat'){
				
				const name = "chatRoom";
				const spec = "left=500px, top=500px, width=450px, height=620px";
				const url = `http://localhost:9090/nadaum/member/mypage/chat.do?room=${resp.room}&guest=guest`;
								
				if(windowObjHistorySearch == null){
					if(confirm(resp.host + '님이 채팅을 신청하셨습니다.')){
						windowObjHistorySearch = window.open(url, name, spec);
					}
				}else if(windowObjHistorySearch.closed){
					if(confirm(resp.host + '님이 채팅을 신청하셨습니다.')){
						windowObjHistorySearch = window.open(url, name, spec);
					}
				}else{
					alert('채팅방은 한개만 열 수 있습니다.');				
				}
								
			}else if(resp.type == 'help'){
				countBedge();
				console.log('카운트배지실행됨');
			}
		});
	});
};

function chatInvite(type, host, guest, room){
	var sendData = {
		'type':type,
		'host':host,
		'guest':guest,
		'room': room
	};
	stompClient.send("/nadaum/chat/invite/" + guest,{},JSON.stringify(sendData));
};

function friendAlarm(type, status, myNickname, friendNickname){
	var sendData = {
		'type':type,
		'status':status,
		'myNickname':myNickname,
		'friendNickname': friendNickname
	};
	stompClient.send("/nadaum/chat/friendStatus/" + friendNickname,{},JSON.stringify(sendData));
};

function answerAlarm(type, code, guest, title){
	var sendData = {
		'type':type,
		'flag':code,
		'guest':guest,
		'title': title,
	};
	stompClient.send("/nadaum/chat/answerAlarm/" + guest,{},JSON.stringify(sendData));
};











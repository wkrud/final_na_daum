const csrfToken = $("meta[name='_csrf']").attr("content");
const csrfHeader = $("meta[name='_csrf_header']").attr("content");
const headers = {};
headers[csrfHeader] = csrfToken;

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
				
				const name = `chatRoom${resp.room}`;
				const spec = "left=500px, top=500px, width=450px, height=620px";
				const url = `http://localhost:9090/nadaum/member/mypage/chat.do?room=${resp.room}&guest=guest`;
				
				let message = `<a href="javascript:void(window.open('${url}', '${name}','${spec}'))">${resp.host}님이 채팅방에 초대하셨습니다.</a>`;
				let code = resp.type + Math.floor(Math.random() * 10000);
				sendInviteChatRoom(code,message);
				/*
				if(confirm(resp.host + '님이 채팅을 신청하셨습니다.')){
					window.open(url, name, spec);
				}
				*/
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

const sendInviteChatRoom = (code,content) => {
	$.ajax({
		url: '/nadaum/member/mypage/insertChatAlarm.do',
		headers: headers,
		method:"POST",
		data:{code,content},
		success(resp){
			console.log(resp);
		},
		error:console.log
	});
};









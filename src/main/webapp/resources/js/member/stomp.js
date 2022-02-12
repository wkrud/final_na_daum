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
			countBedge();
			console.log('resp = ', resp);
			if(resp.type == 'friend'){				
				console.log('필요가 없네');
			}else if(resp.type == 'chat'){
				console.log('필요가 없네');				
			}else if(resp.type == 'help'){				
				console.log('필요가 없네');
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
	
	const name = `chatRoom${room}`;
	const spec = "left=500px, top=500px, width=450px, height=620px";
	const url = `http://localhost:9090/nadaum/member/mypage/chat.do?room=${room}&guest=guest`;
	
	let message = `<a href="javascript:void(window.open('${url}', '${name}','${spec}'))">${host}님이 채팅방에 초대하셨습니다.</a>`;
	let code = type + Math.floor(Math.random() * 10000);
	sendAndInsertAlarm('N',guest,code,message);
	
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

const sendAndInsertAlarm = (type,id,code,content) => {
	$.ajax({
		url: '/nadaum/member/mypage/sendAndInsertAlarm.do',
		headers: headers,
		method:"POST",
		data:{type,id,code,content},
		success(resp){
			console.log(resp);
		},
		error:console.log
	});
};

const commonAlarmSystem = (code, guest, content) => {
	var commonData = {
		'code':code,
		'guest':guest,
		'content':content
	};	
	sendAndInsertAlarm('C',guest,code,content);
	stompClient.send("/nadaum/chat/commonAlarm/" + guest,{},JSON.stringify(commonData));
};







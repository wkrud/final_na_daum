const checkBadge = (no) => {
	$.ajax({
		url: `/nadaum/websocket/checkAlarm.do`,
		method:'POST',
		data: {no},
		headers:headers,
		success(resp){
			countBedge();
		},
		error: console.log
	});	
};

$(window).click(() => {
	$("#alarmList").attr('class','collapse');
});
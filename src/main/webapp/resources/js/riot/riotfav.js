
var member_id = $('#id').val();
var nickname = $('#nickname').val();
var summonerId = $('#summonerId').val();
var summonerNameCheck = $('#summonerNameCheck').val();


$(document).ready(function() {


	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;


	var data = {
		member_id: member_id,
		summoner_id: summonerId

	};
	$.ajax({
		type: "post",
		headers: headers,
		url: '/nadaum/riot/riotTotalFav.do',
		dataType: "json",
		contentType: "application/json; charset=utf-8;",
		data: JSON.stringify(
			data
		),
		success: function(response) {
			const resultcount = response["favcount"];

			if (resultcount == 1) {

				$('.fav-btn').css("background-color", "#ffc107");
				$('.fav-btn').css("color", "#1d2124");


			}
			else {


			}



		},
		error: function(xhr, status, err) {
			console.log(xhr, status, err);
			alert("에러");
		}

	});



});



$(".fav-btn").click((e) => {

	console.log(id);


	var favData = {
		member_id: member_id,
		summoner_id: summonerId

	};

	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;

	$.ajax({
		type: "post",
		headers: headers,
		url: '/nadaum/riot/riotTotal2Fav.do',
		dataType: "json",
		contentType: "application/json; charset=utf-8;",
		data: JSON.stringify(
			favData
		),
		success: function(response) {
			const resultcount = response["favcount"];

			console.log(resultcount);

			if (resultcount == 1) {

				$.ajax({
					type: "post",
					headers: headers,
					url: '/nadaum/riot/riotOneFav.do',
					dataType: "json",
					contentType: "application/json; charset=utf-8;",
					data: JSON.stringify(
						favData
					),
					success: function(response) {

						const Oneresult = response["Oneresult"];
						const summonerName = response["summonerName"];

						if (Oneresult > 0) {

							$.ajax({
								type: "post",
								headers: headers,
								url: '/nadaum/riot/riotdelFav.do',
								dataType: "json",
								contentType: "application/json; charset=utf-8;",
								data: JSON.stringify(
									favData
								),
								success: function(response) {
									const result = response["result"];

									if (result > 0) {
										alert(">>" + summonerNameCheck + "<< 즐겨찾기 해제 하였습니다!");
										$('.fav-btn').css("background-color", "#e9ecef");
										$('.fav-btn').css("color", "#ffc107");
										$('.fav-btn').css("border-color", "##ffc107");
									}


								},
								error: function(response) {
									console.log("실패");
								}
							});

						}
						else {
							alert(">>" + summonerName + "<< 즐겨찾기가 되어있는 상태입니다!\n먼저 즐겨찾기해제후 눌러주세요!");

						}


					},
					error: function(response) {
						console.log("실패");
					}
				});




			}
			else {

				$.ajax({
					type: "post",
					headers: headers,
					url: '/nadaum/riot/riotAddFav.do',
					dataType: "json",
					contentType: "application/json; charset=utf-8;",
					data: JSON.stringify(
						favData
					),
					success: function(response) {

						const result = response["result"];
						const sm_Id = response["sm_Id"];
						const summonerName = response["summonerName"];
						if (result > 0) {
							alert(">>" + summonerName + "<< 즐겨찾기 하였습니다!");
							$('.fav-btn').css("background-color", "#ffc107");
							$('.fav-btn').css("color", "#1d2124");
						}


					},
					error: function(response) {
						console.log("실패");
					}
				});


			}



		},
		error: function(xhr, status, err) {
			console.log(xhr, status, err);
			alert("에러");
		}

	});




});


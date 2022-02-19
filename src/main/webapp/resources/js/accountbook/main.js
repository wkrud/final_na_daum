	
//ajax 로딩시 필요한 값 변수 선언
var $contextPath = $("#contextPath").val();
var $today = $("#today").val();
	
//option 배열
var income = ["급여","용돈","기타"];
var expense = ["식비","쇼핑", "생활비", "자기계발", "저축", "유흥", "기타"];
	
//csfr토큰 headers (post 전송시 필요)
/*	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;*/
	
// 유닉스 시간 -> 타임스탬프 -> 기존 date 변환
const timeConvert = (t) => {
	var unixTime = Math.floor(t / 1000);
    var date = new Date(unixTime*1000);
    var year = date.getFullYear();
    var month = "0" + (date.getMonth()+1);
    var day = "0" + date.getDate();
    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
}

/*모달 버튼*/
$(".modalCloseBtn").on('click', function(){
	$(".modal-background").fadeOut();
});
	
$("#insertBtn").on('click', function(){
	$(".insertModal").fadeIn();
});

$("#excelModalBtn").on('click', function(){
	$(".excelModal").fadeIn();
});

$("#excelDownlaodBtn").on('click', function() {
	$(".excelModal").fadeOut();
})
		
//수입 지출 변환 함수
const IE = (x) => {
	if(x == 'I')
		return "수입";
	else if(x == 'E')
		return "지출";
}
	
//페이지 처음 로딩시 실행 함수
window.onload = $(() => {
	//가계부 insert 모달창에 date 기본값 오늘 날짜로 뜨게 설정
	today = new Date();
	today = today.toISOString().slice(0, 10);
	bir = document.getElementById("regDate");
	bir.value = today;
});

//원화표시 정규식
const numberWithCommas = (n) => {
	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/* 수정/삭제창 토글 */
$('.accountListDiv').click(function() {
	const code = this.className.split(" ")[1];
	$('#'+code+'').slideToggle();
});

	
//대분류 선택에 따른 소분류 출력 - 검색
$(document).on("change", "#mainCategory", function() {
	const $mainCategory = $("#mainCategory").val();

	$('#subCategory').empty();
	$('#subCategory').append(`<option value="">카테고리</option>`);

	if($mainCategory == "I") {
		for (let i = 0; i < income.length; i++) {
			$('#subCategory').append(`<option value=`+income[i]+`>`+income[i]+`</option>`);
		}
	}
	else if($mainCategory == "E") {
		for (let i = 0; i < expense.length; i++) {
			$('#subCategory').append(`<option value=`+expense[i]+`>`+expense[i]+`</option>`);
		}
	} else {
	}
});
	
//대분류 선택에 따른 소분류 출력 - 모달
$(document).on("change", ".main", function() {
	const $mainCategory = $(".main").val();

	$('.sub').empty();
	$('.sub').append(`<option value="">카테고리</option>`);

	if($mainCategory == "I") {
		for (let i = 0; i < income.length; i++) {
			$('.sub').append(`<option value=`+income[i]+`>`+income[i]+`</option>`);
		}
	}
	else if($mainCategory == "E") {
		for (let i = 0; i < expense.length; i++) {
			$('.sub').append(`<option value=`+expense[i]+`>`+expense[i]+`</option>`);
		}
	} else {
	}
});
	
   //가계부 전체 리스트 조회
  const AllList = () => {	
 	$.ajax({
		url: $contextPath+"/accountbook/selectAllAccountList.do",
		type: "GET",
		data: {
			id : $id
		},
		contentType : "application/json; charset=UTF-8",
		success : function(result){
			$("#account_list").html(result);

		},
		error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}	
	});
};
	//삭제
	const deleteDetail = (code) => {
		var code = {"code" : code};
  		$.ajax ({
			url : $contextPath+"/accountbook/accountDelete.do",
			type : "POST",
			data : JSON.stringify(code),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			success(result) {
				location.reload();
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	};
	
	//수정
	const updateDetail = (code) => {
		$.ajax ({
			url : $contextPath+"/accountbook/selectOneAccount",
			type : "Get",
			dataType : "json",
			data : {
				"code" : code
			},
			contentType : "application/json; charset=UTF-8",
			success(result) {
				console.log(result);
				$('.updateAccountTable').empty();
				for(const detail in result) {
					let detailList = "";
					detailList = `
					<thead>
					<tr>
						<th colspan="4" style="margin : 10px; padding : 10px; text-align : center; font-size : 20px;">거래내역 수정</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td colspan="2" rowspan="2" style="margin : 10px; padding : 10px; text-align : center;">
							<input type="date" name="regDate" id="regDate" value="`+timeConvert(result[detail].regDate)+`"/>
						</td>
					</tr>
					<tr>
						<td style="margin : 10px; padding : 10px; text-align : center;">
							<select name="incomeExpense" class="main">
							`
					if(result[detail].incomeExpense == "I") {
						detailList += `
									<option value="I" selected>수입</option>
									<option value="E">지출</option>
								</select>
							</td>
							<td style="margin : 10px; padding : 10px; text-align : center;">
								<select name="category" class="sub">
							`
							if(result[detail].category == "급여") {
								detailList += `
											<option value="">카테고리</option>
											<option value="급여" selected>급여</option>
											<option value="용돈">용돈</option>
											<option value="기타">기타</option>
										`
							} else if(result[detail].category == "용돈") {
								detailList += `
											<option value="">카테고리</option>
											<option value="급여">급여</option>
											<option value="용돈" selected>용돈</option>
											<option value="기타">기타</option>
										`
							} else if(result[detail].category == "기타")	{
								detailList += `
											<option value="">카테고리</option>
											<option value="급여">급여</option>
											<option value="용돈">용돈</option>
											<option value="기타" selected>기타</option>
										`
							} else {
								detailList += `
											<option value="">카테고리</option>
											<option value="급여">급여</option>
											<option value="용돈">용돈</option>
											<option value="기타">기타</option>
										`
							}	
					} else if(result[detail].incomeExpense == "E"){
						detailList += `
								<option value="I">수입</option>
								<option value="E" selected>지출</option>
							</select>
						</td>
						<td style="margin : 10px; padding : 10px; text-align : center;">
							<select name="category" class="sub">
						`	
						if(result[detail].category == "식비") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비" selected>식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축">저축</option>
											<option value="기타">기타</option>
										`
						} else if(result[detail].category == "쇼핑") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑" selected>쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축">저축</option>
											<option value="기타">기타</option>
										`
						} else if(result[detail].category == "생활비") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비" selected>생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축">저축</option>
											<option value="기타">기타</option>
										`
						} else if(result[detail].category == "자기계발") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발" selected>자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축">저축</option>
											<option value="기타">기타</option>
										`
						} else if(result[detail].category == "유흥") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥" selected>유흥</option>
											<option value="저축">저축</option>
											<option value="기타">기타</option>
										`
						} else if(result[detail].category == "저축") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축" selected>저축</option>
											<option value="기타">기타</option>
										`
						} else if(result[detail].category == "기타") {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축">저축</option>
											<option value="기타" selected>기타</option>
										`
						} else {
							detailList += `
											<option value="">카테고리</option>
											<option value="식비">식비</option>
											<option value="쇼핑">쇼핑</option>
											<option value="생활비">생활비</option>
											<option value="자기계발">자기계발</option>
											<option value="유흥">유흥</option>
											<option value="저축">저축</option>
											<option value="기타">기타</option>
										`
						}
					} else {
						detailList += `
									<option value="I">수입</option>
									<option value="E">지출</option>
								</select>
							</td>
							<td style="margin : 10px; padding : 10px; text-align : center;">
								<select name="category" class="sub">
									<option value="">카테고리</option>
									<option value="급여">급여</option>
									<option value="용돈">용돈</option>
									<option value="기타">기타</option>
									`
						
					}
					detailList += `
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="margin : 10px; padding : 10px; text-align : center; position : relative; top : 5px; left : 15px;">
							<label for="detail">
								<input type="text" name="detail" id="" placeholder="내역을 입력하세요" value="`+result[detail].detail+`" />
							</label>
						</td>
						<td style="margin : 10px; padding : 10px; text-align : center;">
							<select name="payment">`
							if(result[detail].payment == "cash") {
								detailList += `
								<option value="">결제수단</option>
								<option value="cash" selected>현금</option>
								<option value="card">카드</option>
								`
							} else if(result[detail].payment == "card") {
								detailList += `
								<option value="">결제수단</option>
								<option value="cash">현금</option>
								<option value="card" selected>카드</option>
								`
							} else {
								detailList += `
								<option value="">결제수단</option>
								<option value="cash">현금</option>
								<option value="card">카드</option>
								`
							}
							detailList += `
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="margin : 10px; padding : 10px; text-align : center;">
							<label for="price">
								<input type="text" name="price" id="insertPrice" placeholder="금액을 입력하세요" onkeyup="numberWithCommas(this.value)" value=`+result[detail].price+` />
							</label>
						</td>
						<td style="margin : 10px; padding : 10px; text-align : center;">
							<input type="hidden" name="code" id="code" value="`+result[detail].code+`"/>
					</tr>
					</tbody>
					`
				$('.updateAccountTable').append(detailList);
				}
					$(".updateModal").fadeIn();
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	};

	
	//차트
	//차트 로딩하는 메소드
	google.charts.load('visualization', '1', {'packages':['corechart']});
	//구글 시각화 api가 로딩되면 인자로 전달된 콜백함수를 내부적으로 호출해서 차트를 그림
	google.charts.setOnLoadCallback(drawExpenseChart);
	google.charts.setOnLoadCallback(drawIncomeChart);
		
	//수입 카테고리 차트
	function drawIncomeChart() {
		var firstData = {"incomeExpense" : "I", date : $today};
		//차트에 구성되는 데이터 [['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/incomeChart.do',
			type : "POST",
			data : JSON.stringify(firstData),
			contentType : "application/json; charset=UTF-8",
			dataType : "json",
			headers : headers,
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(data) {
				console.log(data);
				let outer =[['Category', 'Total']];
				for(const obj in data) {
					let inner = [];
					inner.push(data[obj].category);
					inner.push(data[obj].total);
					outer.push(inner);
				}
			var chartData = google.visualization.arrayToDataTable(outer);
			var options = { 
			//차트 상단의 제목
			title: '이달의 수입',
			 //차트 크기 설정
			 width : 400,
			 height : 300,
			 pieHole : 0.4,
			 backgroundColor : '#FFFBF5',
			};
			var chart = new google.visualization.PieChart(document.getElementById('incomeChart'));
			chart.draw(chartData, options);
			}
		});
	};
	
	//지출 카테고리 차트
	function drawExpenseChart() {
		let firstData = {"incomeExpense" : "E", date : $today};
		//차트에 구성되는 데이터는 [['Header','Header']['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//Header는 각 배열을 설명할 수 있는 필수값. ['String', 'String']
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/incomeChart.do',
			type : "POST",
			data : JSON.stringify(firstData),
			contentType : "application/json; charset=UTF-8",
			dataType : "json",
			headers : headers,
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(data) {
				console.log(data);
				let outer =[['Category', 'Total']];
				for(const obj in data) {
					let inner = [];
					inner.push(data[obj].category);
					inner.push(data[obj].total);
					outer.push(inner);
				}
			var chartData = google.visualization.arrayToDataTable(outer);
			var options = { 
			//차트 상단의 제목
			title: '이달의 지출',
			 //차트 크기 설정
			 width : 400,
			 height : 300,
			 pieHole : 0.4,
			 backgroundColor : '#FFFBF5',
			};
			var chart = new google.visualization.PieChart(document.getElementById('expenseChart'));
			chart.draw(chartData, options);
			}
		});
	};

//datepicker
$(() => {
	$("#excelDate1").datepicker();
	$("#excelDate2").datepicker();
});
	
// 월별 조회 ㅠㅠ
let year = $today.slice(0, 4);
let month = $today.slice(5, 7);
let searchDay = "";

const monthly = (m) => {
	$.ajax({
		url : $contextPath+'/accountbook/searchDate.do',
		type : "POST",
		contentType : "application/json; charset=UTF-8",
		dataType : "json",
		headers : headers,
		success(resp) {
			let array = [];
			for(obj in resp) {
				array.push(resp[obj].monthly);
			}
			if(m == "before") {
				if($today === array[0]) {
					alert("기록에 없는 데이터는 조회할 수 없습니다.");
					return;
				} else if( 1 < month) {
					month = parseInt(month) -1;
				} else {
					month = 12;
					year = parseInt(year) - 1;
				}
			} else if(m == "next") {
				if($today === array[array.length-1]) {
					alert("기록에 없는 데이터는 조회할 수 없습니다.");
					return;
				} else if(month < 12) {
					month = parseInt(month) + 1;
				} else {
					month = 1;
					year = parseInt(year) + 1;
				}
			}
			searchDay = year+'-'+(month >= 10? month : '0'+month);
			location.href = $contextPath+`/accountbook/accountbook.do?date=`+searchDay;
		},
		error(xhr, testStatus, err) {
			console.log("error", xhr, testStatus, err);
			alert("조회에 실패했습니다.");
		}
	});	
}
    
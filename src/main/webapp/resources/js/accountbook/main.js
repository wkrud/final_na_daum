	
	
	//ajax 로딩시 필요한 값 변수 선언
	var $contextPath = $("#contextPath").val(); //contextPath jsp에서 가져온 값(js파일에서 el을 못 씀)
	
	//option 배열
	var income = ["급여","용돈","기타"];
	var expense = ["식비","쇼핑", "생활비", "자기계발", "저축", "유흥", "기타"];
	
	//csfr토큰 headers (post 전송시 필요)
/*	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;*/
	
	// 유닉스 시간 -> 타임스탬프 -> 기존 date 변환
	function timeConvert(t){
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
	function IE(x) {
		if(x == 'I')
			return "수입";
		else if(x == 'E')
			return "지출";
	}
	
	//페이지 처음 로딩시 실행 함수
	window.onload = function() {
		//가계부 insert 모달창에 date 기본값 오늘 날짜로 뜨게 설정
		today = new Date();
		today = today.toISOString().slice(0, 10);
		bir = document.getElementById("regDate");
		bir.value = today;
	}

	//원화표시 정규식
	function numberWithCommas(n) {
    	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	
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
	$(document).on("change", "#main", function() {
		const $mainCategory = $("#main").val();

		$('#sub').empty();
		$('#sub').append(`<option value="">카테고리</option>`);

		if($mainCategory == "I") {
			for (let i = 0; i < income.length; i++) {
				$('#sub').append(`<option value=`+income[i]+`>`+income[i]+`</option>`);
			}
		}
		else if($mainCategory == "E") {
			for (let i = 0; i < expense.length; i++) {
				$('#sub').append(`<option value=`+expense[i]+`>`+expense[i]+`</option>`);
			}
		} else {
		}
	});
	
   //가계부 전체 리스트 조회
  function AllList() {	
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
}
	//삭제
	function deleteDetail(code) {
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
	function updateDetail(code) {
		$.ajax ({
			url : $contextPath+"/accountbook/selectOneAccount",
			type : "Get",
			dataType : "json",
			data : {
				"code" : code
			},
			contentType : "application/json; charset=UTF-8",
			success(result) {
				$('.updateAccountTable').empty();
				for(const detail in result) {
					let detailList = `
					<thead>
					<tr>
						<th colspan="4">거래내역 수정</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td colspan="2" rowspan="2">
							<input type="date" name="regDate" id="regDate" value="`+timeConvert(result[detail].regDate)+`"/>
						</td>
						<td>
							<input class="checkbox-tools" type="radio" name="payment" id="cash" value ="cash"/>
							<label class="for-checkbox-tools" for="cash">
								<span><i class="far fa-money-bill-alt"></i></span>
							</label>
						</td>
						<td>
							<input class="checkbox-tools" type="radio" name="payment" id="card" value ="card"/>
							<label class="for-checkbox-tools" for="card">
								<span><i class="far fa-credit-card" id="card"></i></span>
							</label>
						</td>
					</tr>
					<tr>
						<td>
							<select name="incomeExpense" id="main">
								<option value="">대분류</option>
								<option value="I">수입</option>
								<option value="E">지출</option>
							</select>
						</td>
						<td>
							<select name="category" id="sub">
								<option value="">소분류</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<label for="detail">
								<input type="text" name="detail" id="" placeholder="내역을 입력하세요" value="`+result[detail].detail+`" />
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<label for="price">
								<input type="text" name="price" id="insertPrice" placeholder="금액을 입력하세요" onkeyup="numberWithCommas(this.value)" value=`+result[detail].price+` />
							</label>
						</td>
						<td>
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
	
	//차트 그리는 함수
	function drawExpenseChart() {
		var firstData = {"incomeExpense" : "E"};
		//차트에 구성되는 데이터는 [['Header','Header']['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//Header는 각 배열을 설명할 수 있는 필수값. ['String', 'String']
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/incomeChart.do',
			type : "POST",
			data : JSON.stringify(firstData),
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			dataType : "json",
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
	
	
	//차트 그리는 함수
	function drawIncomeChart() {
		var firstData = {"incomeExpense" : "I"};
		//차트에 구성되는 데이터 [['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/incomeChart.do',
			type : "POST",
			data : JSON.stringify(firstData),
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			dataType : "json",
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
	
	/* 코드 찍기 */
	$('.accountListDiv').click(function() {
		const code = this.className.split(" ")[1];
		$('#'+code+'').slideToggle();
	});

//datepicker
	$(function(){
		$("#excelDate1").datepicker();
		$("#excelDate2").datepicker();
	});

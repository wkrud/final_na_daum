	var $contextPath = $("#contextPath").val(); //contextPath jsp에서 가져온 값(js파일에서 el을 못 씀)
	var $today = $("#today").val(); // 오늘 날짜
	
	//차트 로딩하는 메소드
	google.charts.load('visualization', '1', {'packages':['corechart']});
	//구글 시각화 api가 로딩되면 인자로 전달된 콜백함수를 내부적으로 호출해서 차트를 그림
	google.charts.setOnLoadCallback(drawYearlyChart);
	google.charts.setOnLoadCallback(drawCategoryIChart);
	google.charts.setOnLoadCallback(drawCategoryEChart);
	
	
	//차트 그리는 함수 - 월별 차트
	function drawYearlyChart() {
		//차트에 구성되는 데이터는 [['Header','Header']['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//Header는 각 배열을 설명할 수 있는 필수값. ['String', 'String']
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/detailMonthlyChart.do',
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			dataType : "json",
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(data) {
				let outer =[['Year-Month', '수입', '지출']];
				for(const obj in data) {
					let inner = [];
					inner.push(data[obj].monthly);
					inner.push(data[obj].income);
					inner.push(data[obj].expense);
					outer.push(inner);
				}
			var chartData = google.visualization.arrayToDataTable(outer);
			var options = { 
			//차트 상단의 제목
			/*title: '월별 차트',*/
			 //차트 크기 설정
			 width : 700,
			 height : 300,
			 backgroundColor : '#FFFBF5',
			};
			var chart = new google.visualization.LineChart(document.getElementById('monthly-total-chart'));
			chart.draw(chartData, options);
			}
		});
	};
	
	//차트 그리는 함수 - 수입 카테고리 카운트
	function drawCategoryIChart() {
			let data = {"incomeExpense" : "I"};
			console.log(data);
		$.ajax({
			url : $contextPath+'/accountbook/categoryChart.do',
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			data : JSON.stringify(data),
			dataType : "json",
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(resp) {
				let outer =[['카테고리', '횟수']];
				for(const obj in resp) {
					let inner = [];
					inner.push(resp[obj].category);
					inner.push(resp[obj].count);
					outer.push(inner);
				}
			var chartData = google.visualization.arrayToDataTable(outer);
			var options = { 
			//차트 상단의 제목
			/*title: '월별 차트',*/
			 //차트 크기 설정
			 width : 550,
			 height : 300,
			 backgroundColor : '#FFFBF5',
			};
			var chart = new google.visualization.ColumnChart(document.getElementById('income-category-chart'));
			chart.draw(chartData, options);
			}
		});
	};
	
	
	//차트 그리는 함수 - 지출 카테고리 카운트
	function drawCategoryEChart() {
			let data = {"incomeExpense" : "E"};
			console.log(data);
		$.ajax({
			url : $contextPath+'/accountbook/categoryChart.do',
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			data : JSON.stringify(data),
			dataType : "json",
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(resp) {
				let outer =[['카테고리', '횟수']];
				for(const obj in resp) {
					let inner = [];
					inner.push(resp[obj].category);
					inner.push(resp[obj].count);
					outer.push(inner);
				}
			var chartData = google.visualization.arrayToDataTable(outer);
			var options = { 
			//차트 상단의 제목
			/*title: '월별 차트',*/
			 //차트 크기 설정
			 width : 550,
			 height : 300,
			 backgroundColor : '#FFFBF5',
			};
			var chart = new google.visualization.ColumnChart(document.getElementById('expense-category-chart'));
			chart.draw(chartData, options);
			}
		});
	};


	// 월별 조회
let year = $today.slice(0, 4);
let month = $today.slice(5, 7);
let searchDay = "";

const monthly = (m) => {
	if(m == "before") {
		if( 1 < month) {
			month = parseInt(month) -1;
		} else {
			month = 12;
			year = parseInt(year) - 1;
		}
	} else if(m == "next") {
		if(month < 12) {
			month = parseInt(month) + 1;
		} else {
			month = 1;
			year = parseInt(year) + 1;
		}
	}
	searchDay = year+'-'+(month >= 10? month : '0'+month);
	location.href = $contextPath+`/accountbook/accountAnalyze.do?date=`+searchDay;		
}
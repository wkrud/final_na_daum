/* 차트 */
window.onload = function colData(){
	$.ajax({
		url:'http://localhost:9090/nadaum/member/admin/chart.do',
		success(resp){			
			const {list, hobbyCount} = resp;
			console.log(hobbyCount);
			var pieCols = [['취미','명']];
			pieCols.push(['롤', hobbyCount.lol]);
			pieCols.push(['게임', hobbyCount.game]);
			pieCols.push(['독서', hobbyCount.book]);
			pieCols.push(['글쓰기', hobbyCount.write]);
			pieCols.push(['코딩', hobbyCount.coding]);
			pieCols.push(['볼링', hobbyCount.bowling]);
			pieCols.push(['농구', hobbyCount.basketball]);
			pieCols.push(['맛집탐방', hobbyCount.goodRestaurant]);
			pieCols.push(['기타', hobbyCount.etc]);
			console.log(pieCols);
			
			let count = '';
			let day = '';
			var columnCols = [['월', '명']];
			$(list).each((i, {REGDATE, CNT}) => {
				count = CNT;
				day = i + 1 + '월';
				let columnCol = [day, count];
				columnCols.push(columnCol);
			});
			google.charts.load('current', {'packages':['corechart']});	
			/* 월별 가입자 */
			google.charts.setOnLoadCallback(drawChart);
			function drawChart(){
				var data = new google.visualization.arrayToDataTable(columnCols);
				
				var options = {'title':'월 별 가입 회원 수',
								'width':650,
								'height':300,
								backgroundColor:{fill:'#FFFBF5'}};
				
				var chart = new google.visualization.ColumnChart(document.getElementById('member-enroll-chart'));
				chart.draw(data, options);
			};
			
			/* 취미 */
			google.charts.setOnLoadCallback(draws);
			function draws(){
				var data = google.visualization.arrayToDataTable(pieCols);
				
				var options = {
					title: '회원 취미',
					backgroundColor:{fill:'#FFFBF5'}
				};
				
				var chart = new google.visualization.PieChart(document.getElementById('member-hobby-chart'));
				
				chart.draw(data, options);
			}
		},
		error:console.log
	});
};

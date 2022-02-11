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
			
			/* 질문 */
			/*function helpChart(){
			google.charts.setOnLoadCallback(helpChart);
				var data = new google.visualization.arrayToDataTable([
			        ['ID', '질문 공감수', '답변 공감수', '카테고리',     '질문 수'],
			        ['CAN',    80.66,              1.67,      'North America',  33739900],
			        ['DEU',    79.84,              1.36,      'Europe',         81902307],
			        ['DNK',    78.6,               1.84,      'Europe',         5523095],
			        ['EGY',    72.73,              2.78,      'Middle East',    79716203],
			        ['GBR',    80.05,              2,         'Europe',         61801570],
			        ['IRN',    72.49,              1.7,       'Middle East',    73137148],
			        ['IRQ',    68.09,              4.77,      'Middle East',    31090763],
			        ['ISR',    81.55,              2.96,      'Middle East',    7485600],
			        ['RUS',    68.6,               1.54,      'Europe',         141850000],
			        ['USA',    78.09,              2.05,      'North America',  307007000]
      			]);
				
				var options = {'title':'카테고리별 질문 만족도',
								hAxis:{title:'질문 공감수'},
								vAxis:{title:'답변 공감수'},
								bubble:{textStyle:{fontSize:11}},
								backgroundColor:{fill:'#FFFBF5'}};
				
				var chart = new google.visualization.BubbleChart(document.getElementById('member-help-chart'));
				chart.draw(data, options);
			};*/
			google.charts.load('upcoming', {'packages': ['vegachart']}).then(helpChart);
			function helpChart() {
				/*
		        var data = google.visualization.arrayToDataTable([
		            ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
		            ['2004/05',  165,      938,         522,             998,           450,      614.6],
		            ['2005/06',  135,      1120,        599,             1268,          288,      682],
		            ['2006/07',  157,      1167,        587,             807,           397,      623],
		            ['2007/08',  139,      1110,        615,             968,           215,      609.4],
		            ['2008/09',  136,      691,         629,             1026,          366,      569.6]
		        ]);
		
		        var options = {
		            title : 'Monthly Coffee Production by Country',
		            vAxis: {title: 'Cups'},
		            hAxis: {title: 'Month'},
		            seriesType: 'bars',
		            series: {5: {type: 'line'}},
		            backgroundColor:{fill:'#FFFBF5'}
		        };
		
		        var chart = new google.visualization.ComboChart(document.getElementById('member-help-chart'));
		        chart.draw(data, options);
		        */
		        const dataTable = new google.visualization.DataTable();
        dataTable.addColumn({type: 'string', 'id': 'category'});
        dataTable.addColumn({type: 'number', 'id': 'amount'});
        dataTable.addRows([
          ['A', 28],
          ['B', 55],
          ['C', 43],
          ['D', 91],
          ['E', 81],
          ['F', 53],
          ['G', 19],
          ['H', 87],
        ]);

        const options = {
          "vega": {
            "$schema": "https://vega.github.io/schema/vega/v4.json",
            "width": 500,
            "height": 200,
            "padding": 5,

            'data': [{'name': 'table', 'source': 'datatable'}],

            "signals": [
              {
                "name": "tooltip",
                "value": {},
                "on": [
                  {"events": "rect:mouseover", "update": "datum"},
                  {"events": "rect:mouseout",  "update": "{}"}
                ]
              }
            ],

            "scales": [
              {
                "name": "xscale",
                "type": "band",
                "domain": {"data": "table", "field": "category"},
                "range": "width",
                "padding": 0.05,
                "round": true
              },
              {
                "name": "yscale",
                "domain": {"data": "table", "field": "amount"},
                "nice": true,
                "range": "height"
              }
            ],

            "axes": [
              { "orient": "bottom", "scale": "xscale" },
              { "orient": "left", "scale": "yscale" }
            ],

            "marks": [
              {
                "type": "rect",
                "from": {"data":"table"},
                "encode": {
                  "enter": {
                    "x": {"scale": "xscale", "field": "category"},
                    "width": {"scale": "xscale", "band": 1},
                    "y": {"scale": "yscale", "field": "amount"},
                    "y2": {"scale": "yscale", "value": 0}
                  },
                  "update": {
                    "fill": {"value": "steelblue"}
                  },
                  "hover": {
                    "fill": {"value": "red"}
                  }
                }
              },
              {
                "type": "text",
                "encode": {
                  "enter": {
                    "align": {"value": "center"},
                    "baseline": {"value": "bottom"},
                    "fill": {"value": "#333"}
                  },
                  "update": {
                    "x": {"scale": "xscale", "signal": "tooltip.category", "band": 0.5},
                    "y": {"scale": "yscale", "signal": "tooltip.amount", "offset": -2},
                    "text": {"signal": "tooltip.amount"},
                    "fillOpacity": [
                      {"test": "datum === tooltip", "value": 0},
                      {"value": 1}
                    ]
                  }
                }
              }
            ]
          }
        };

        const chart = new google.visualization.VegaChart(document.getElementById('chart-div'));
        chart.draw(dataTable, options);
      
		        
		    };
		    
		    
			
			
			
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

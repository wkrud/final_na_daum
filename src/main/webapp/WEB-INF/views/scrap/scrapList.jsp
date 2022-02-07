<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 스크랩" name="title" />
</jsp:include>

<style>
section#content {
	
}

.search-form label {
	padding-right: 8px;
}

div#culture-container {
	width: 100%;
	margin: 0 auto;
	text-align: center;
}

.thumnail {
	width: 20%;
}

#culture_code {
	display: none;
}

.card {
	height: 300px;
	padding: 15px;
}

.card-title {
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
	width: 300px;
}

.paging li {
	list-style: none;
}

.paging a {
	color: black;
}

.form-group {
	padding-left: 20px;
}
</style>
<script>
//cultureDetail
$(() => {
		$(".card").click((e) => {
			/* const code = $card.data("code"); */
			const code = $(e.target).find("[name=code]").val();
			const $card = $(e.target).parent().parent();
			location.href = `${pageContext.request.contextPath}/culture/board/view/\${code}`;
		});
		
		//날짜 넣기
		const value = new Date();
		
		const f = n => n < 10 ? "0" + n : n;
		// yyyy-mm-dd
		const today = `\${value.getFullYear()}-\${f(value.getMonth() + 1)}-\${f(value.getDate())}`;
		console.log(today);
		
		start = document.getElementById("startDate");
		start.value = today;
		
		const after_month = `\${value.getFullYear()}-\${f(value.getMonth() + 2)}-\${f(value.getDate())}`;
		console.log(after_month);
		end = document.getElementById("endDate");
		end.value = after_month;
});



</script>
<body>
	<div class="scrap-container">

			<div class="btn-group btn-group-toggle" data-toggle="buttons">
				<label class="btn btn-secondary active"> <input type="radio" name="options" id="option1" autocomplete="off" checked>
					문화
				</label> 
				<label class="btn btn-secondary"> <input type="radio" name="options" id="option2" autocomplete="off"> 영화
				</label> 
				<label class="btn btn-secondary"> <input type="radio" name="options" id="option3" autocomplete="off"> Radio
				</label>
			</div>

			<div class="py-5">
				<div class="container">
					<div class="row hidden-md-up">

						<c:forEach var="scrap" items="${list}">
							<div class="col-md-4" style="padding: 15px;">
								<div class="card">
									<div class="card-block">
										<input type="hidden" name="code" value="${scrap.seq}" />
										<h4 class="card-title">${scrap.title}</h4>
										<p class="card-text p-y-1">${scrap.area}</p>
										<p class="card-text p-y-1">${scrap.place}</p>
										<p class="card-text p-y-1">${scrap.realmName}</p>
										<img class="thumnail" src="${scrap.thumbnail}" alt="" />
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			${pagebar }

		</div>
	</div>
</body>
<script>





</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
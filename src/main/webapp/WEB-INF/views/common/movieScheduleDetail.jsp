<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#detail-calender">더보기</button> -->

<!-- 캘린더 Modal -->
<div class="modal fade" id="detail-calender" tabindex="-1" role="dialog"
	aria-labelledby="detail-calender" aria-hidden="true">
	<form id="insertPromiseFrm">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="detail-calenderTitle">약 속</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!-- 모달 내용 시작 -->
				<div class="modal-body">
					

					<div class="form-group row">
						<label for="title" class="col-sm-2 col-form-label">약속일</label>
						<div class="col-sm-10">
							<input type="date" class="form-control" id="startDate"
								name="startDate" value="<c:out>${schedule.startDate}</c:out> " readonly>
						</div>
					</div>
					
					<div class="form-group row">
						<label for="title" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title" name="title" value="${schedule.title }"
								placeholder="제목을 입력해주세요" readonly>
						</div>
					</div>
					
					<div class="friend-list-wrap">
						<div class="friends-list">
							<div class="friend">
								<div class="form-group row">
									<label for="title" class="col-sm-2 col-form-label">약속 잡은 친구</label>
									<div class="col-sm-10">
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<input id="friendId" type="text" name="id" class="form-control id" placeholder="닉네임을 입력하세요" aria-label="" aria-describedby="basic-addon1" readonly>
												<input type="text" name="apiCode" value="${schedule.apiCode}" /> 
												<input type="text" name="apiCode" value="${apiCode}" /> 
												<input type="text" name="allDay" value="0" /> 
												<input type="text" name="id" value="${loginMember.id}" />
												<input type="text" name="code" value="${schedule.id}" />
												
											</div>
										</div>
									</div>
								</div>
								<div class="search-result-list">
									<div class="list-group"></div>
								</div>
								<hr />

							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary" value="${schedule.code}">수락</button>
					</div>
				</div>
				<!-- 모달 내용 끌 -->
			</div>
		</div>
	</form>
</div>

<script>
/* $(."schedule-detail-btn").click((e)=> {
	const code = $(e.target).val();
		console.log(e.target);
		console.log(code);
		
		$.ajax({
			url : `${pageContext.request.contextPath}/movieDetail/{apiCode}/schedule/{code}`,
			method: "GET",
			success(resp){
				console.log(resp);
				const {code, friendName, startDate, apiCode, title, id} = resp;
				const $frm = $(insertPromiseFrm);
				$frm.find("[name=code]").val(code);
				$frm.find("[name=friendName]").val(friendName);
				$frm.find("[name=startDate]").val(startDate);
				$frm.find("[name=apiCode]").val(apiCode);
				$frm.find("[name=title]").val(title);
				$frm.find("[name=id]").val(id);
			},
			error(xhr, textStatus, err) {
				if(xhr.status == 404)
					alert("약속을 조회하지 못했습니다.");
				else
					console.log(xhr, textStatus, err);
			}
		});
}); */
/* $(schedule-detail).click((e) => {
	const spec = "left=500px, top=500px, width=265px, height=285px";
	const popup = open('${pageContext.request.contextPath}/movie/insertCalendarMovie.do', '약속수락', spec);
}); */

/* $(."schedule-detail-btn").click((e) => {
	const spec = "left=500px, top=500px, width=265px, height=285px";
	const popup = open('${pageContext.request.contextPath}/movie/insertCalendarMovie.do', '약속수락', spec);
}); */
/* 캘린더 */
</script>
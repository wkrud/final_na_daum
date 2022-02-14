<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#detail-calender">더보기</button> -->

<!-- 캘린더 확인 모달 시작 -->
<div class="modal fade" id="check-calander" tabindex="-1" role="dialog"
		aria-labelledby="check-calander" aria-hidden="true">
		<form id="promiseReceiveFrm">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="add-calanderTitle">약 속</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="form-group row">
							<label for="title" class="col-sm-2 col-form-label">상대<br>닉네임</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="mynickname"  id="receive-mynickname"/>
								<input type="hidden" class="form-control" name="friendnickname"  id="receive-friendnickname"/>
							</div>
						</div>
					
						<div class="form-group row">
							<label for="title" class="col-sm-2 col-form-label">내용</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="receive-title" name="title">
							</div>
						</div>

						<div class="form-group row">
							<label for="title" class="col-sm-2 col-form-label">약속일</label>
							<div class="col-sm-10">
								<input type="date" class="form-control" id="receive-startDate"
									name="startDate">
									<input type="date" id="receive-endDate" name="endDate" style="display:none"/>
							</div>
						</div>
							<input type="hidden" name="allDay" id="receive-allDay" /> 
							<input type="hidden" name="type"  value="lol"/>
							<input type="hidden" name="borderColor"  value="#D25565"/>
							<input type="hidden" name="backgroundColor"  value="#D25565"/>
							<input type="hidden" name="textColor"  value="#ffffff"/>
							<input type="hidden" name="id" value="${loginMember.id}" />
							<input type="hidden" name="friendid" id="receive-friendId" />
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">추가</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
<!-- 캘린더 확인 모달 끝 -->

<script>
$(."schedule-detail-btn").click((e)=> {
	
		
		const timeConvert = (t) => {
		    var unixTime = Math.floor(t / 1000);
		    var date = new Date(unixTime*1000);
		    var year = date.getFullYear();
		    var month = "0" + (date.getMonth()+1);
		    var day = "0" + date.getDate();
		    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
		}
				
		const $scheduleCheckCode ='${schedulecode}';
				
			 	var data = {"schedulecode":$scheduleCheckCode}
				$.ajax({
					url : "${pageContext.request.contextPath}/movie/movieScheduleCheck.do",
					method : "GET",
					data : {
						schedulecode : $scheduleCheckCode
						
					},
					success(data){
						const accept = data["accept"];
						const allDay = data["allDay"];
						const friendnickname = data["friendnickname"];
						const mynickname = data["mynickname"];
						const startDate = data["startDate"];
						const content = data["content"];
						const friendid = data["friendid"];
						
						$('#receive-title').val(content);
						$('#receive-startDate').val(timeConvert(startDate));
						$('#receive-endDate').val(timeConvert(startDate));
						$('#receive-mynickname').val(mynickname);
						$('#receive-friendnickname').val(friendnickname);
						$('#receive-allDay').val(allDay);
						$('#receive-friendId').val(friendid);
						
						 $(promiseReceiveFrm).submit((e) => {
								e.preventDefault();
						
						     
									$.ajax({
										url:`${pageContext.request.contextPath}/movie/movieReceiveSchedule.do`,
										method: "POST",
										headers : headers, 
										data : $(promiseReceiveFrm).serialize(),
										success(resp){
											location.reload();
											const msg = resp["msg"];
											alert(msg);
											
											},
										error: console.log
										});
							}); 
					},
					error : function(xhr, status, err){
						console.log(xhr, status, err);
							alert("에러");
					}
				}); 
	
});
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
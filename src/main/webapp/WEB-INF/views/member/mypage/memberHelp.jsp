<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 질문 모음" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="member-body">
	<div class="question-list-wrap">
		<div class="question-list-last-wrap">
			<div class="question-list-head">
				<h1>질문 모음</h1>
				<div class="help-btn-wrap">
					<div class="input-group mb-3 help-search-btn-wrap">
						<div class="input-group-prepend">
							<button id="search-help-start" class="btn btn-outline-secondary" type="button">검색</button>
							<input id="searchHelp" type="text" name="title" class="form-control" required placeholder="질문을 검색해보세요." aria-label="" aria-describedby="basic-addon1">
						</div>
					</div>
				</div>
				<div class="write-btn-wrap">
					<button type="button" class="btn btn-outline-primary write-help-btn" onclick="location.href='${pageContext.request.contextPath}/member/mypage/memberHelpEnroll.do'">질문하기</button>
				</div>
				<div class="search-result-list">
					<ul id="search-result-ul" class="list-group list-group-flush"></ul>
				</div>
			</div>
			<div class="question-list-body">
				<c:if test="${checkHelp.ME > 0}">
					<div class="me-wrap">
						<span>메모</span>
						<div class="help-list-main all-category">
							<ul class="list-group list-group-flush">
								<c:forEach items="${helpMeList}" var="help">
									<c:if test="${help.category eq 'me'}">
										<li class="list-group-item">
											<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
												${help.title}<c:if test="${help.status == 'T'}">&nbsp;-&nbsp;<i class="fa fa-check" aria-hidden="true"></i></c:if>
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<div class="help-list-footer">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpOneCategory.do?category=me">더보기</a>
						</div>
					</div>
				</c:if>
				<c:if test="${checkHelp.DY > 0}">
					<div class="dy-wrap">
						<span>다이어리</span>
						<div class="help-list-main all-category">
							<ul class="list-group list-group-flush">
								<c:forEach items="${helpDyList}" var="help">
									<c:if test="${help.category eq 'dy'}">
										<li class="list-group-item">
											<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
												${help.title}<c:if test="${help.status == 'T'}">&nbsp;-&nbsp;<i class="fa fa-check" aria-hidden="true"></i></c:if>
											</a>
										</li>											
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<div class="help-list-footer">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpOneCategory.do?category=dy">더보기</a>
						</div>
					</div>
				</c:if>
				<c:if test="${checkHelp.AB > 0}">
					<div class="ab-wrap">
						<span>가계부</span>
						<div class="help-list-main all-category">
							<ul class="list-group list-group-flush">
								<c:forEach items="${helpAbList}" var="help">
									<c:if test="${help.category eq 'ab'}">
										<li class="list-group-item">
											<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
												${help.title}<c:if test="${help.status == 'T'}">&nbsp;-&nbsp;<i class="fa fa-check" aria-hidden="true"></i></c:if>
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<div class="help-list-footer">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpOneCategory.do?category=ab">더보기</a>
						</div>
					</div>
				</c:if>
				<c:if test="${checkHelp.FR > 0}">
					<div class="fr-wrap">
						<span>친구</span>
						<div class="help-list-main all-category">
							<ul class="list-group list-group-flush">
								<c:forEach items="${helpFrList}" var="help">
									<c:if test="${help.category eq 'fr'}">
										<li class="list-group-item">
											<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
												${help.title}<c:if test="${help.status == 'T'}">&nbsp;-&nbsp;<i class="fa fa-check" aria-hidden="true"></i></c:if>
											</a>
										</li>
									</c:if>
								</c:forEach>		
							</ul>
						</div>
						<div class="help-list-footer">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpOneCategory.do?category=fr">더보기</a>
						</div>
					</div>
				</c:if>
				<c:if test="${checkHelp.CU > 0}">
					<div class="cu-wrap">
						<span>문화</span>
						<div class="help-list-main all-category">
							<ul class="list-group list-group-flush">
								<c:forEach items="${helpCuList}" var="help">
									<c:if test="${help.category eq 'cu'}">
										<li class="list-group-item">
											<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
												${help.title}<c:if test="${help.status == 'T'}">&nbsp;-&nbsp;<i class="fa fa-check" aria-hidden="true"></i></c:if>
											</a>
										</li>
									</c:if>
								</c:forEach>		
							</ul>
						</div>
						<div class="help-list-footer">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpOneCategory.do?category=cu">더보기</a>
						</div>
					</div>
				</c:if>
				<c:if test="${checkHelp.FE > 0}">
					<div class="cu-wrap">
						<span>피드</span>
						<div class="help-list-main all-category">
							<ul class="list-group list-group-flush">
								<c:forEach items="${helpCuList}" var="help">
									<c:if test="${help.category eq 'fe'}">
										<li class="list-group-item">
											<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
												${help.title}<c:if test="${help.status == 'T'}">&nbsp;-&nbsp;<i class="fa fa-check" aria-hidden="true"></i></c:if>
											</a>
										</li>
									</c:if>
								</c:forEach>		
							</ul>
						</div>
						<div class="help-list-footer">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpOneCategory.do?category=cu">더보기</a>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<script>
$("#searchHelp").on('keyup', function(e){
	if($("#searchHelp").val() != ''){
		if(e.key === 'Enter' || e.keyCode === 13){
			$("#search-help-start").trigger('click');
		}
	}
});

$("#search-help-start").click((e) => {
	if($("#searchHelp").val() == ''){
		alert("질문을 입력해 주세요.");
		return false;
	}
	let title = $("#searchHelp").val();
	$.ajax({
		url: `${pageContext.request.contextPath}/member/mypage/searchStart.do?title=\${title}`,
		success(resp){
			const $resultListUl = $(".search-result-list").find('ul');
			$resultListUl.empty();
			let resultList = '';
			if(resp == '0'){
				resultList = `<li class="list-group-item">그런 질문은 없어요.</li>`;
				$resultListUl.append(resultList);	
			}else{
				$(resp).each((i, {CODE, ID, CATEGORY, TITLE, REGDATE, STATUS}) => {
					console.log(i,CODE, ID, CATEGORY, TITLE, REGDATE, STATUS);
					
					let d = new Date(REGDATE);
					let date = `\${d.getFullYear()}.\${d.getMonth() + 1}.\${d.getDate()}`;
					let answer = '';
					if(STATUS == 'T')
						answer = '답변완료';
					else
						answer = '답변대기중';
					
					resultList = `
					<li class="list-group-item"><div class="result-box"><div class="result-title">\${TITLE}</div><div class="result-answer"> - \${answer}</div><div class="result-date">\${date}</div><input type="hidden" name="code" value="\${CODE}" /></input></div></li>
					`;
					
					$resultListUl.append(resultList);
				});
			}
			
			
		},
		error: console.log
	});
	
	$("#search-result-ul").click((e) => {
		const selectCode = $(e.currentTarget).find('input[name=code]').val();
		console.log(selectCode);
		if(typeof selectCode != 'undefined')
			location.href=`${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${selectCode}`;
	});
	
});

$(() => {
	$("#searchHelp").autocomplete({
		source: function(request, response){
			$.ajax({
				url: "${pageContext.request.contextPath}/member/mypage/searchHelpTitle.do",
				data: {value: request.term},
				success(data){
					console.log(data);
					response(
						$.map(data, function(item){
							console.log(item)
							return{
								value: item,
							}
						})	
					);	
				},
				error:console.log				
			});
		},
		select: function(event, ui){
			console.log(ui);
			console.log(ui.item.value);
		},
		focus: function(event,ui){
			return false;
		},
		minLength: 1,
		autoFocus: true,
		classes:{
			"ui-autocomplete":"highlight"
		},
		delay: 500,
		position:{
			my: "right top", at: "right bottom"
		},
		close: function(event){
			console.log(event);
		}
	});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
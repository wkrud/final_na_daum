<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 질문 등록" name="title" />
</jsp:include>
<style>
.board-container {
	width: 715px;
	height: 927px;
	left: 500px;
}
</style>
<script>
/**
* boardEnrollFrm 유효성 검사
*/
function boardValidate(){
	const $title = $("[name=title]");
	const $content = $("[name=content]");
	
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test($title.val())){
		alert("제목을 입력하세요.");
		return false;
	}
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	// \n는 .에 포함되지 않는다.
	if(!/^(.|\n)+$/.test($title.val())){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}

</script>

<div class="board-container">
	<form method="POST"	action="${pageContext.request.contextPath}/board/boardEnroll.do"
		onsubmit="return boardValidate();">
		
		<div class="form-group row" >
		<label for="title" class="col-sm-2 col-form-label">제목</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요" required >
		</div>
		</div>
		
		<div class="form-group row">
		<label for="category" class="col-sm-2 col-form-label">카테고리</label>
		<div class="col-sm-10">
			<input type="hidden" class="form-control" name="category" >
			<select id="category-select" class="form-control" aria-label="Default select example">
			<option selected>카테고리</option>
			<option value="자유">자유게시판</option>
			<option value="문화">문화</option>
			<option value="영화">영화</option>
		</select>
		</div>
		</div>
		
		<textarea name="content" id="board-content-summernote" required></textarea>
		<div>
			<span id="limite_normal"></span><span id="limite_vermelho"
				style="color: red"></span>/500
		</div>
		
		<br />
		<button type="submit" id="submit-btn" class="btn btn-warning">등록</button>
		
		<input type="hidden" name="id" id="id" value="${loginMember.id}" /> 
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
</div>

<script>
$("#category-select").change((e) => {	
	$("input[name='category']").val($("#category-select").val());	
});

$("#submit-btn").click((e) => {
	if($("#title").val() == ''){
		alert('제목을 작성해 주세요');
		return false;
	}
	if($("input[name='category']").val() == ''){
		alert('카테고리를 선택해주세요');
		return false;
	}
	if($("#limite_normal").text() == ''){
		alert('내용을 작성해 주세요');
		return false;
	}
	if($("#limite_normal").text() <= 10){
		alert('10자 이상 작성해 주세요');
		return false;
	}
	return true;
});

$(document).ready(function() {
	
	var toolbar = [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	    
	  ];
	
	
	var setting = {
			placeholder: '내용을 작성하세요',
            height : 600,
            minHeight : null,
            maxHeight : null,
            focus : true,
            lang : 'ko-KR',
            toolbar : toolbar,
            callbacks : { //여기 부분이 이미지를 첨부하는 부분
	            onImageUpload : function(files, editor, welEditable) {
		            for (var i = files.length - 1; i >= 0; i--) {
		            	uploadSummernoteImageFile(files[i], this);
	         		}
	         	},
	         	onMediaDelete: function(target){
	         		alert(target[0].src);
	         		deleteImg(target[0].src);
	         	},
	         	onKeyup: function(e) {
	         		var text = $(this).next('.note-editor').find('.note-editable').text();
	         		var length = text.length;
	         		var num = 500 - length;
	         		
	         		if(length > 500){
	         			$("#limite_normal").hide();
	         			$("#limite_vermelho").text(length).show();
	         			$("#board-content-summernote").summernote("code", text.substring(0,500));
	         		}else{
	         			$("#limite_vermelho").hide();
	         			$("#limite_normal").text(length).show();
	         		}
	         	}
    	}
	};
	
	$('#board-content-summernote').summernote(setting);
	
	function uploadSummernoteImageFile(file, el){
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		console.log('시작');
		data = new FormData();
		data.append("file", file);
		$.ajax({
			url: "${pageContext.request.contextPath}/board/uploadSummernoteImageFile.do",
			data: data,
			type: "POST",
			headers: headers,
			enctype: 'multipart/form-data',
			contentType: false,
			processData: false,
			success(resp){
				console.log(resp);
				$(el).summernote('editor.insertImage', resp.url);
			}
		});
	}
});
const deleteImg = (url) => {
	let val = "";
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/board/deleteSummernoteImageFile.do',
		headers: headers,
		type: "POST",
		data: {val: url},
		success(resp){
			if(resp > 0)
				console.log('success');
		}
	});
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
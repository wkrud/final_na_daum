<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="album 등록" name="pageTitle" />
</jsp:include>
<style>
div#board-container {
	width: 800px;
	margin: 0 auto;
	text-align: center;
}

div#board-container input {
	margin-bottom: 15px;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}

.albumFrm {
	margin-top: 20px;
}
</style>

<script>
$(document).ready(function() {
    $("#add").click(function() {
    	var lastField = $(".trk-input:last");
        var intId = (lastField && lastField.length && lastField.data("idx") + 1) || 1;
        var fileWrapper = $("<div class=\"input-group mb-3 trk-input\" style=\"padding:0px; margin-bottom:15px;\" name=\"track\" id=\"track" + intId + "\"><div class=\"input-group-prepend\" style=\"padding: 0px;\"><span class=\"input-group-text\" style=\"height:38px;\">트랙"+"</span></div>");
        fileWrapper.data("idx", intId);
        /* var fName = $("<input type=\"text\" class=\"fieldname\" />"); */
        
        //트랙이름
        /* <span class=\"input-group-text\">음원파일</span> */
        var tName = $("<div class=\"input-group-prepend\" style=\"padding:0px;\"><input type=\"text\" name=class=\"form-control\" placeholder=\"트랙이름\"></div>");
        
        // file
        var tFile = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\" name=\"trkFile\" id=\"trkFile"+intId+"\"><label for=\"trkFile"+intId+"\" class=\"custom-file-label\">파일을 선택하세요</label></div>");
        
        /* var fType = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\">); */
        //삭제버튼
        var removeButton = $("<input type=\"button\" class=\"removeAttach btn btn-xs btn-danger\" value=\"Χ\"></div>");
        
        removeButton.click(function() {
            $(this).parent().remove();
        });
        let lastLen=$(".trk-input").length;
        if(lastLen<11){
        	fileWrapper.append(tName);
        	fileWrapper.append(tFile);
        	fileWrapper.append(removeButton);
        	$(".trk-bg").append(fileWrapper);
    	} else {alert("최대 10개까지만 추가 가능합니다");}
    });
    
    //동적으로 현재 입력한 폼 보여주기
    $("#preview").click(function() {
        $("#yourform").remove();
        var fieldSet = $("<fieldset id=\"yourform\"><legend>Your Form</legend></fieldset>");
        $("#buildyourform div").each(function() {
            var id = "input" + $(this).attr("id").replace("field","");
            var label = $("<label for=\"" + id + "\">" + $(this).find("input.fieldname").first().val() + "</label>");
            var input;
            switch ($(this).find("select.fieldtype").first().val()) {
                case "checkbox":
                    input = $("<input type=\"checkbox\" id=\"" + id + "\" name=\"" + id + "\" />");
                    break;
                case "textbox":
                    input = $("<input type=\"text\" id=\"" + id + "\" name=\"" + id + "\" />");
                    break;
                case "textarea":
                    input = $("<textarea id=\"" + id + "\" name=\"" + id + "\" ></textarea>");
                    break;    
            }
            fieldSet.append(label);
            fieldSet.append(input);
        });
        $("body").append(fieldSet);
    });
});
</script>

<div id="board-container">
	<form name="albumFrm"
		action="${pageContext.request.contextPath}/audiobook/album/update?${_csrf.parameterName}=${_csrf.token}"
		method="post" enctype="multipart/form-data"
		onsubmit="return albumValidate();">
		<input type="text" class="form-control" placeholder="제목" name="title"id="title" value="${albumInfo.title}" required> 
		<input type="text" class="form-control" placeholder="제작사" name="provider" id="provider" value="${albumInfo.provider}" required> 
		<input type="text" class="form-control" placeholder="크리에이터" name="creator" id="creator" value="${albumInfo.creator}" required> 
		<input type="text"class="form-control" placeholder="장르" name="kind" id="kind" value="${albumInfo.kind}" required>
		<input type="text" class="form-control" placeholder="코드" name="code" id="code" value="${albumInfo.code}" required readonly>
		
	<c:forEach items="${oldAlbumImgList}" var="img" varStatus="status">
		<c:choose>
			<c:when test="${not empty oldAlbumImgList && null ne oldAlbumImgList}">
				<div class="input-group mb-3 al-cover"style="padding: 0px; margin-bottom: 15px;">
					<div class="input-group-prepend" style="padding: 0px;">
						<span class="input-group-text">앨범커버</span>
					</div>
				<div class="custom-file">
					<input type="file" class="custom-file-input" name="imgFile" id="imgFile"> 
					<label class="custom-file-label"for="imgFile">${img.originalFilename}</label>
				</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="input-group mb-3 al-cover" style="padding: 0px; margin-bottom:15px;">
					<div class="input-group-prepend" style="padding: 0px;">
						<span class="input-group-text" >앨범커버</span>
					</div>
					<div class="custom-file">
						<input type="file" class="custom-file-input" name="imgFile" id="imgFile"> 
						<label class="custom-file-label" for="imgFile">파일을 선택하세요</label>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>
			
	<c:forEach items="${oldAlbumTrackList}" var="track" varStatus="status">
		<div class="input-group mb-3 trk-input"
			style="padding: 0px; margin-bottom: 15px;" name="track"
			id="track${status.index}">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text" style="height: 38px;">트랙</span>
			</div>
			<div class="input-group-prepend" style="padding: 0px;">
				<input type="text" name="track name" class="form-control"
					placeholder="트랙이름">
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="trkFile"
					id="trkFile${status.index}"> 
				<label for="trkFile${status.index}" class="custom-file-label">${track.originalFilename} </label>
			</div>
			<input type="button" class="removeAttach btn btn-xs btn-danger"
				value="Χ">
		</div>
	</c:forEach>
	<div class="input-gruop-prepend" style="padding: 0px;">
		<input type="button" value="트랙추가" class="add" id="add" />
	</div>

	
	<textarea class="form-control" name="content" placeholder="내용"required>
		<c:if test="${not empty albumInfo.content}">
			${albumInfo.content}
		</c:if>
	</textarea>
	<br/> 
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" /> 
	<input type="submit"
		class="btn btn-outline-success" value="수정">
	</form>
</div>



<script>

function albumValidate(){
	
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	if(!trackValid()){
		return false;
	}
	if(!imgValid()){
		return false;
	}
	return true;
}

const trackValid = function trackValid(){
	var $trkFile =$("[name=trkFile]");
	console.log($trkFile.val());
	/* for(int i=0; i<trkFile.length;i++){
		const file = $(trkFile).prop('files')[i];
		let fileLen = file.name.length;
		console.log(fileLen);
		let lastDot = file.name.lastIndexOf('.');
		console.log(lastDot);
		let fileExt = file.name.substring(lastDot+1,fileLen).toLowerCase();
		let check = (fileType==fileExt);
		console.log(check); 
		validArr.push(check);
		console.log(check);
	} */
	return check;
}

/*img파일은 확장성을 위해 list로 받았지만 현재는 front에서 단일파일입력으로 정책설정*/

const imgValid = function imgValid(){
	var $imgFile = $("[name=imgFile]");
	const file1 = $(imgFile).prop('files')[0];
	console.log(file1.name);
	const fileLen = file1.name.length;
	console.log(fileLen); 
	const lastDot = file1.name.lastIndexOf('.');
	console.log(lastDot); 
	const fileExt = file1.name.substring(lastDot+1,fileLen).toLowerCase(); 
	console.log(fileExt);
	const fileType = ["jpg","png","jpeg","bmp"];
	const check1 = fileType.includes(fileExt);
	console.log(check1);
	validArr.push(check1);
	return check1;
}

/* const fnValid = function fileNameValid(){
	$("[id=upFile1]").change((e) => {
		const file1 = $(e.target).prop('files')[0];
		console.log(file1.name);
 		const fileLen = file1.name.length;
 		console.log(fileLen);
		const lastDot = file1.name.lastIndexOf('.');
		console.log(lastDot);
		const fileExt = file1.name.substring(lastDot,fileLen).toLowerCase(); 
		const fileType = ["jpg","png","jpeg","bmp"];
		const check = fileType.includes(file1.name);
		console.log(check); 
		return check;
	});
} */

$(() => {
	/**
	 * 파일명 표시하기
	 */
	 const validArr = new Array();
	
	$("[name=imgFile]").change((e) => {
		const file = $(e.target).prop('files')[0];
		const $label = $(e.target).next();
		
		if(file != undefined)
			$label.html(file.name);
		else
			$label.html("파일을 선택하세요.");
		
		if($label.html!="파일을 선택하세요."){
			console.log(file.name);	
		}
		
	});
	
	
	$(document).on('click','input[id=add]',function(){
		console.log(this);
		var lastField = $(".trk-input:last");
		console.log(lastField.attr());
        var intId = (lastField && lastField.length && lastField.data("idx") + 1) || 1;
        var fileWrapper = $("<div class=\"input-group mb-3 trk-input\" style=\"padding:0px; margin-bottom:15px;\" name=\"track\" id=\"track" + intId + "\"><div class=\"input-group-prepend\" style=\"padding: 0px;\"><span class=\"input-group-text\" style=\"height:38px;\">트랙"+"</span></div>");
        fileWrapper.data("idx", intId);
        /* var fName = $("<input type=\"text\" class=\"fieldname\" />"); */
        
        //트랙이름
        /* <span class=\"input-group-text\">음원파일</span> */
        var tName = $("<div class=\"input-group-prepend\" style=\"padding:0px;\"><input type=\"text\" name=class=\"form-control\" placeholder=\"트랙이름\"></div>");
        
        // file
        var tFile = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\" name=\"trkFile\" id=\"trkFile"+intId+"\"><label for=\"trkFile"+intId+"\" class=\"custom-file-label\">파일을 선택하세요</label></div>");
        
        /* var fType = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\">); */
        //삭제버튼
        var removeButton = $("<input type=\"button\" class=\"removeAttach btn btn-xs btn-danger\" value=\"Χ\"></div>");
        
        removeButton.click(function() {
            $(this).parent().remove();
        });
        
        let lastLen=$("input.trk-input").length;
        if(lastLen<11){
        	fileWrapper.append(tName);
        	fileWrapper.append(tFile);
        	fileWrapper.append(removeButton);
        	$(".trk-bg").append(fileWrapper);
    	} else {alert("최대 10개까지만 추가 가능합니다");} 
	});
	
	$("#add").click(function() {
    	var lastField = $(".trk-input:last");
        var intId = (lastField && lastField.length && lastField.data("idx") + 1) || 1;
        var fileWrapper = $("<div class=\"input-group mb-3 trk-input\" style=\"padding:0px; margin-bottom:15px;\" name=\"track\" id=\"track" + intId + "\"><div class=\"input-group-prepend\" style=\"padding: 0px;\"><span class=\"input-group-text\" style=\"height:38px;\">트랙"+"</span></div>");
        fileWrapper.data("idx", intId);
        /* var fName = $("<input type=\"text\" class=\"fieldname\" />"); */
        
        //트랙이름
        /* <span class=\"input-group-text\">음원파일</span> */
        var tName = $("<div class=\"input-group-prepend\" style=\"padding:0px;\"><input type=\"text\" name=class=\"form-control\" placeholder=\"트랙이름\"></div>");
        
        // file
        var tFile = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\" name=\"trkFile\" id=\"trkFile"+intId+"\"><label for=\"trkFile"+intId+"\" class=\"custom-file-label\">파일을 선택하세요</label></div>");
        
        /* var fType = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\">); */
        //삭제버튼
        var removeButton = $("<input type=\"button\" class=\"removeAttach btn btn-xs btn-danger\" value=\"Χ\"></div>");
        
        removeButton.click(function() {
            $(this).parent().remove();
        });
        /* let lastLen=$(".trk-input").length; */
        if(intId<11){
        	fileWrapper.append(tName);
        	fileWrapper.append(tFile);
        	fileWrapper.append(removeButton);
        	$(".trk-bg").append(fileWrapper);
    	} else {alert("최대 10개까지만 추가 가능합니다");}
    });
	
	
	$(document).on({'change':function(e) {
		console.log($(e.target));
		const file = $(e.target).prop('files')[0];
		
		const $label = $(e.target).next();
		 
		if(file != undefined)
			$label.html(file.name);
		else
			$label.html("파일을 선택하세요.");
		
		if($label.html!="파일을 선택하세요."){
			console.log(file.name);	
			}
		
		let fileLen = file.name.length;
		console.log(fileLen);
		
		let lastDot = file.name.lastIndexOf('.');
		console.log(lastDot);
		
		let fileExt = file.name.substring(lastDot+1,fileLen).toLowerCase(); 
		console.log(fileExt);
		
		const fileType = 'mp3';
		
		let check = (fileType==fileExt);
		console.log(check); 
		validArr.push(check);
		console.log(check);
		return check;
		}
	});
	
	
	
	//검증
	$("[id=imgFile]").change((e) => {
		const file1 = $(e.target).prop('files')[0];
		console.log(file1.name);
 		const fileLen = file1.name.length;
 		 console.log(fileLen); 
		const lastDot = file1.name.lastIndexOf('.');
		console.log(lastDot); 
		const fileExt = file1.name.substring(lastDot+1,fileLen).toLowerCase(); 
		console.log(fileExt);
		const fileType = ["jpg","png","jpeg","bmp"];
		const check1 = fileType.includes(fileExt);
		console.log(check1);
		validArr.push(check1);
		return check1;
	});
	
	$("[id=trkFile2]").change((e) => {
		const file2 = $(e.target).prop('files')[0];
		console.log(file2.name);
 		const fileLen = file2.name.length;
 		console.log(fileLen); 
		const lastDot = file2.name.lastIndexOf('.');
		console.log(lastDot); 
		const fileExt = file2.name.substring(lastDot+1,fileLen).toLowerCase(); 
		console.log(fileExt);
		const fileType = 'mp3';
		const check2 = (fileType==fileExt);
		console.log(check2); 
		return check2;
	});

});
</script>

<!--  
	onsubmit="return albumValidate()&&fnValid();"
	?${_csrf.parameterName}=${_csrf.token}-->
<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->


<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>
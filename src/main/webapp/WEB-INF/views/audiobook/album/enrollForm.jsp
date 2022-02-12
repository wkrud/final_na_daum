<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="album 등록" name="pageTitle"/>
</jsp:include>
<style>
div#board-container{
	width:800px;
	margin:0 auto; 
	text-align:center;
}
div#board-container input{
	margin-bottom:15px;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{
	text-align:left;
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
        //var tName = $("<div class=\"input-group-prepend\" style=\"padding:0px;\"><input type=\"text\" name=class=\"form-control\" placeholder=\"트랙이름\"></div>");
        
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
        	//fileWrapper.append(tName);
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
	<form 
		name="albumFrm" 
		action="${pageContext.request.contextPath}/audiobook/album/enroll?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data"
		>
		<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
		<input type="text" class="form-control" placeholder="제작사" name="provider" id="provider" required>
		<input type="text" class="form-control" placeholder="크리에이터" name="creator" id="creator" required>
		<input type="text" class="form-control" placeholder="장르" name="kind" id="kind" required>
		<input type="text" class="form-control" placeholder="코드" name="code" id="code" required>
		<input type="text" class="form-control" placeholder="뮤직비디오링크" name="mvLink" id="mvLink">
		
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3 al-cover" style="padding: 0px; margin-bottom:15px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text" >앨범커버</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="imgFile"
					id="imgFile" required> 
				<label class="custom-file-label" for="imgFile">파일을 선택하세요</label>
			</div>
		</div>
		<div class="input-group trk-bg" style ="margin-bottom:15px; padding:0px;"></div>
		<!-- 	<div class="input-group mb-3 trk-input" style="padding: 0px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text">음원파일</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="upFile"
					id="upFile2"> <label class="custom-file-label"
					for="upFile2">파일을 선택하세요</label>
			</div>
		</div> -->
		<div class="input-group-prepend justify-content-center" style="padding: 0px;text-align:center;">
			<input type="button" value="트랙추가" class="add" id="add" />
		</div>


		<textarea class="form-control" name="content" placeholder="내용"
			required></textarea>
		<br /> <input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="submit"
			class="btn btn-outline-success" value="저장">
	</form>
</div>



<script>
/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
function albumValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
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

/* onsubmit="return albumValidate()&&fnValid();"
	?${_csrf.parameterName}=${_csrf.token}*/

/* ${_csrf.parameterName}=${_csrf.token} */
</script>

<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>
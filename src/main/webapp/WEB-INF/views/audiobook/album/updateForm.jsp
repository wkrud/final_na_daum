<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</script>

<div id="board-container">
	<form name="albumFrm" action="${pageContext.request.contextPath}/audiobook/album/updateTest?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return albumValidate();">
		<input type="text" class="form-control" placeholder="코드" name="code" id="code" value="${oldAlbumInfo.code}" required readonly> 
		<input type="text" class="form-control" placeholder="제목" name="title" id="title" value="${oldAlbumInfo.title}" required> 
		<input type="text" class="form-control" placeholder="제작사" name="provider" id="provider" value="${oldAlbumInfo.provider}" required> 
		<input type="text" class="form-control" placeholder="크리에이터" name="creator" id="creator" value="${oldAlbumInfo.creator}" required> 
		<input type="text" class="form-control" placeholder="장르" name="kind" id="kind" value="${oldAlbumInfo.kind}" required> 
		<input type="text" class="form-control" placeholder="뮤직비디오링크" name="mvLink" value="${oldAlbumInfo.mvLink}" id="mvLink">

		<c:forEach items="${oldImgList}" var="img" varStatus="status">
			<c:choose>
				<c:when test="${not empty oldImgList && null ne oldImgList}">
					<div class="input-group mb-3 al-cover" style="padding: 0px; margin-bottom: 15px;">
						<div class="input-group-prepend" style="padding: 0px;">
							<span class="input-group-text">앨범커버</span>
						</div>
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="imgFile" id="imgFile"> 
							<label class="custom-file-label" for="imgFile">${img.originalFilename}</label>
							<%--<input type="hidden"  name="imgOriginalFileName" id="imgOriginalFileName${status.index}" value="${img.originalFilename}" readonly>
							<input type="hidden"  name="imgRenamedFileName" id="imgRenamedFileName${status.index}" value="${img.renamedFilename}" readonly> --%>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="input-group mb-3 al-cover" style="padding: 0px; margin-bottom: 15px;">
						<div class="input-group-prepend" style="padding: 0px;">
							<span class="input-group-text">앨범커버</span>
						</div>
						
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="imgFile" id="imgFile" required> 
							<label class="custom-file-label" for="imgFile">파일을 선택하세요</label>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:forEach items="${oldTrackList}" var="track" varStatus="status">
			<div class="input-group mb-3 trk-input" style="padding: 0px; margin-bottom: 15px;" name="track" id="track${status.index}">
				<div class="input-group-prepend" style="padding: 0px;">
					<span class="input-group-text" style="height: 38px;">트랙</span>
				</div>
				<div class="custom-file">
					<%--<input type="file" class="custom-file-input" name="trkFile" id="trkFile${status.index}" readonly>--%>
					<input type="hidden"  name="trkOriginalFileName" id="trkOriginalFileName${status.index}" value="${track.originalFilename}" >
					<input type="hidden"  name="trkRenamedFileName" id="trkRenamedFileName${status.index}" value="${track.renamedFilename}" > 
					<label for="trkFile${status.index}" class="custom-file-label">${track.originalFilename}</label>
				</div>
				<input type="button" class="removeAttach btn btn-xs btn-danger" value="Χ">
			</div>
		</c:forEach>
		<div class="input-group trk-bg" style ="margin-bottom:15px; padding:0px;"></div>
		<div class="input-group-prepend justify-content-center" style="padding: 0px;text-align:center;">
			<input type="button" value="트랙추가" class="add" id="add" />
		</div>
		
		<textarea class="form-control" name="content" placeholder="내용" required>
		<c:if test="${not empty albumInfo.content}">
			${albumInfo.content}
		</c:if>
	</textarea>
		<br /> <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="submit" class="btn btn-outline-success" value="수정">
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
		alert("잘못된 확장자입니다.");
		return false;
	}
	if(!imgValid()){
		alert("잘못된 확장자입니다.");
		return false;
	}
	return true;
}

/* const trackValid = function trackValid(){
	var $trkFile =$("[name=trkFile]");
	console.log($trkFile.val());
	 for(int i=0; i<trkFile.length;i++){
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
	}  
	return check;
} */

/*img파일은 확장성을 위해 list로 받았지만 현재는 front에서 단일파일입력으로 정책설정*/
/*
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
} */

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
	
	
	$(document).on({'click':function(e){
		console.log($(e.target).prop('tagName'));
		console.log($(e.target));
		console.log($(e.target).prop('value')); 
		var removeBtn='Χ';
		var addBtn='트랙추가'
		if(removeBtn===$(e.target).prop('value')){
			console.log('it is removeBtn');
			let remove = $(e.target).prop('value');
			let $parent = $(e.target).prop('parentElement');
			console.log($parent);
			console.log(remove);
			$parent.remove();
			
		} else if(addBtn==$(e.target).prop('value')){
			/* console.log('it is add Btn'); 
			let $parent = $(e.target).prop('parentElement');
			/* console.log(parent); */
			let lastLen=$(".trk-input").length; 
			if(lastLen==0){
	    		$(".custom-file").append(fileWrapper);
	    		
	    		var nextNum = 0;
	    		var fileWrapper = $("<div class=\"input-group mb-3 trk-input\" style=\"padding:0px; margin-bottom:15px;\" name=\"track\" id=\"track" + nextNum + "\"><div class=\"input-group-prepend\" style=\"padding: 0px;\"><span class=\"input-group-text\" style=\"height:38px;\">트랙"+"</span></div>");
	 	        fileWrapper.data("idx",nextNum);
	 	        console.log(fileWrapper);
	 	        var tFile = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\" name=\"trkFile\" id=\"trkFile"+nextNum+"\"><label for=\"trkFile"+nextNum+"\" class=\"custom-file-label\">파일을 선택하세요</label></div>");
	 	        var removeButton = $("<input type=\"button\" class=\"removeAttach btn btn-xs btn-danger\" value=\"Χ\"></div>");
 				//fileWrapper.append(tName);
	        	fileWrapper.append(tFile);
	        	fileWrapper.append(removeButton);
	        	/* console.log(fileWrapper); */
	        	console.log($(".trk-bg"));
	        	$(".trk-bg:last").append(fileWrapper);
		    	return;
			}
			
			var lastField = $(".trk-input:last");
			/* console.log(lastField); */
			/* console.log(lastField.prop('id')); */
			/* console.log(typeof(lastField.prop('id'))); */
			var curId= lastField.attr('id');
			/* console.log(curId); */
			var curNum=Number(curId.substr(5));
			/* console.log(curNum); */
	        var nextNum = (null||''||undefined)!=curNum?(curNum+ 1):1;
	        console.log(nextNum);
	        
	        var fileWrapper = $("<div class=\"input-group mb-3 trk-input\" style=\"padding:0px; margin-bottom:15px;\" name=\"track\" id=\"track" + nextNum + "\"><div class=\"input-group-prepend\" style=\"padding: 0px;\"><span class=\"input-group-text\" style=\"height:38px;\">트랙"+"</span></div>");
	        fileWrapper.data("idx",nextNum);
	        console.log(fileWrapper);
	        var tFile = $("<div class=\"custom-file\"><input type=\"file\" class=\"custom-file-input\" name=\"trkFile\" id=\"trkFile"+nextNum+"\"><label for=\"trkFile"+nextNum+"\" class=\"custom-file-label\">파일을 선택하세요</label></div>");
	        var removeButton = $("<input type=\"button\" class=\"removeAttach btn btn-xs btn-danger\" value=\"Χ\"></div>");
	        
	        removeButton.click(function() {
	            $(this).parent().remove();
	        });
	        
	        lastLen=$(".trk-input").length;
	        /* console.log(lastLen); */
	        if(lastLen<11&&lastLen>0){
	        	//fileWrapper.append(tName);
	        	fileWrapper.append(tFile);
	        	fileWrapper.append(removeButton);
	        	/* console.log(fileWrapper); */
	        	console.log($(".trk-bg"));
	        	$(".trk-bg:last").append(fileWrapper);
	    	} else {
	    		alert("최대 10개까지만 추가 가능합니다");
	    	}
		}		
		/* const file = $(e.target).prop('files')[0]; */
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
</script>

<!--  
	onsubmit="return albumValidate()&&fnValid();"
	?${_csrf.parameterName}=${_csrf.token}-->
<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->


<jsp:include page="/WEB-INF/views/audiobook/common/audioBookFooter.jsp"></jsp:include>
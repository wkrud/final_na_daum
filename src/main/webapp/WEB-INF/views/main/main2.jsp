<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/main/main2.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>

<article class="mainWrapper">
	<section class="mainSection box" id="dragZone" droppable="true">
	
	</section>
</article>
<script>
//홈 진입시 draggable 속성 추가
$(() => {
	$(".accept-drag").attr('draggable', 'true');
})
//위젯 변수 선언	
let widgetName = "";

//드래그 이벤트 줄 변수
const drags = document.querySelectorAll(".accept-drag"); //arr
const dragZone = document.querySelector("#dragZone");

//위젯 가능한 항목들에 이벤트 부여
for (const widgets of drags) {
	widgets.addEventListener("dragstart", dragStart);
	widgets.addEventListener("dragend", dragEnd);
}

//드래그존 이벤트
dragZone.addEventListener('dragover', dragOver);   // 마우스 객체 위에 자리잡고 있을 때
dragZone.addEventListener('dragenter', dragEnter); // 마우스가 객체 위로 처음 진입할 때 
dragZone.addEventListener('dragleave', dragLeave); // 드래그가 끝나서 마우스가 객체 위에서 벗어날 때
dragZone.addEventListener('drop', dragDrop);       // 드래그하던 객체를 놓는 장소에 위치한 객체에서 발생(드래그 끝날 때)

function dragEnter() {
	this.preventDefault();
}

//드래그 시작 이벤트
function dragStart() {
	widgetName = this.id;
	console.log(widgetName);
}

//드래그 내려놓을 때 이벤트
function dragEnd() {
//여기서 if문으로 widgetName 따라서 각 요소 불러오면 될듯????????
  let widget = "";
	if(widgetName =='todoList') {
			widget = `
					<div class="widget_form `+widgetName+`">
					<table>
	        		<tr>
	        			<th>Today</th>
	        		</tr>
	        		<tr>
	        			<td>Thu Feb 3 2022</td>
	        		</tr>
	        		<tr>
	        			<td>
		        			<input type="checkbox" name="" id="test" />
		        			<label for="test">나다움 모임</label>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>
		        			<input type="checkbox" name="" id="test2" />
		        			<label for="test2">파이널...킵고잉...</label>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>
	        			<input type="text" name="" id="" placeholder="+일정 추가하기" />
	        			</td>
	        		</tr>
	        	</table>
					</div>
					`
	} else {
		widget = `<div class="widget_form `+widgetName+`">`+widgetName+`</div>`
	} 
	
	$("#dragZone").append(widget);
}
	
</script>







<jsp:include page="/WEB-INF/views/common/footer.jsp" />
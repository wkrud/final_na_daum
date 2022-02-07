<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>

<c:forEach items="${accountList}" var = "account">
	<div class="accountListDiv">
	<table class="accountTable">
		<tr class="account_side_column">
			<td><span class="accountRegDate"><fmt:formatDate value="${account.regDate}" pattern="yyyy/MM/dd"/></span></td>
			<td rowspan="2" class="accountPrice">
				<c:choose>
					<c:when test="${account.incomeExpense eq 'I' }">
						<span class="income"><fmt:formatNumber value="${account.price}" type="number"/></span>
					</c:when>
					<c:when test="${account.incomeExpense eq 'E' }">
						<span class="expense"><fmt:formatNumber value="-${account.price}" type="number"/></span>
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="accountDetail">${account.detail}</td>
		</tr>
		</table>
		<button class="deleteBtn" onclick="deleteDetail('${account.code}')">삭제</button>
	</div>
	<div class="accountUpdate">
	</div>
</c:forEach>

<style>
.accountListDiv {
  width : 400px;
  height: 80px;
  background : rgba(225, 225, 225, 0.1);
  border : 1px solid rgba(225, 225, 225, 0.5);
  border-radius: 10px;
  margin : 15px auto;
  position : relative;
  }

.deleteBtn{
	position : absolute;
	right : 15px;
	border : none;
	background-color : lightgray;
	width : 100px;
	height : 30px;
	border-radius : 10px;
	display : none;
}

.accountTable {
	margin : 5px;
}

.accountTable td {
	padding : 4px;
}

.accountRegDate, .accountDetail {
	width : 380px;
}

.accountDetail {
	font-size : 18px;
}

.accountRegDate {
	color : #b2b0b0;
}

.accountPrice {
/* 	width : 100px; */
	font-size : 20px;
}

.income {
	color : green;
}

.expense {
	color : red;
}

/* .accountUpdate{
  width : 400px;
  height: 50px;
  margin-top : 10px;
} */

</style>


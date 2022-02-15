<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(date);
%>

<div class="accountWrapper">
<!-- 엑셀 다운로드 기간선택 모달창 -->
	<div class="modal-background excelModal">
	<div class="findExcelDate">
		<p class="excel-ment">기간을 선택하세요.</p>
		<button class="modalCloseBtn defaultBtn"><i class="fas fa-sign-in-alt"></i></button>
		<form action="${pageContext.request.contextPath}/accountbook/excel">
			<input type="text" name="startDate" id="excelDate1" class="excelbox" readonly value="<%=today%>"/>
			<input type="text" name="endDate" id="excelDate2" class="excelbox" readonly value="<%=today%>"/>
			<button id="excelDownlaodBtn" class="defaultBtn"><i class="fas fa-download"></i></button>
		</form>
	</div>
	</div>
	
<!-- 가계부 수정 모달창 -->
	<div class="modal-background updateModal">
	 <div class="updateAccountModal">
		<form 
			name="updateFrm" 
			method="POST"
			action="${pageContext.request.contextPath}/accountbook/updateAccount.do">
		<input type="hidden" name="id" value="${loginMember.id}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>	
		<table class="updateAccountTable">
		</table>
			<input type="submit" class="defaultBtn addAccountBtn" value="등록" />
		</form>
			<button class="modalCloseBtn defaultBtn"><i class="fas fa-sign-in-alt"></i></button>
	</div> 
	</div>  

<!-- 가계부 입력 모달창 -->
	<div class="modal-background insertModal">
	<div class="insertAccountModal">
		<form 
			name="insertFrm" 
			method="POST"
			action="${pageContext.request.contextPath}/accountbook/accountInsert.do">
		<table class="insertAccountTable">
			<thead>
			<tr>
				<th colspan="4">새로운 거래</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="2" rowspan="2">
					<input type="date" name="regDate" id="regDate" />
				</td>
				<td>
					<input class="checkbox-tools" type="radio" name="payment" id="cash" value ="cash"/>
					<label class="for-checkbox-tools" for="cash">
						<span><i class="far fa-money-bill-alt"></i> 현금</span>
					</label>
				</td>
				<td>
					<input class="checkbox-tools" type="radio" name="payment" id="card" value ="card"/>
					<label class="for-checkbox-tools" for="card">
						<span><i class="far fa-credit-card" id="card"></i> 카드</span>
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<select name="incomeExpense" id="main">
						<option value="I">수입</option>
						<option value="E">지출</option>
					</select>
				</td>
				<td>
					<select name="category" id="sub">
						<option value="급여">급여</option>
						<option value="용돈">용돈</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<label for="detail">
						<input type="text" name="detail" id="" placeholder="내역을 입력하세요" />
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<label for="price">
						<input type="text" name="price" id="insertPrice" placeholder="금액을 입력하세요" onkeyup="numberWithCommas(this.value)" />
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="id" value="${loginMember.id}" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</td>
			</tr>
			</tbody>
		</table>
			<input type="submit" class="defaultBtn addAccountBtn" value="등록" />
		</form>
			<button class="modalCloseBtn defaultBtn"><i class="fas fa-sign-in-alt"></i></button>
	</div>
	</div>
<!-- 차트 부분 -->
<section class="chartSection">
	<a href="${pageContext.request.contextPath}/accountbook/accountAnalyze.do" id="detailChartLink">더 보기</a>
	<div id="incomeChart"></div>
	<div id="expenseChart"></div>
</section>
<section class="search_list_section">
		<!-- 검색창 -->
		<div class="search_box">
			<form 
				action="${pageContext.request.contextPath}/accountbook/searchList.do"
				method="GET"
				name = "searchFrm"
				id="searchFrm">
				<select name="incomeExpense" id="mainCategory">
					<option value="" selected>대분류</option> 
					<option value="I">수입</option>
					<option value="E">지출</option>
				</select>
				<select name="category" id="subCategory">
					<option value="">소분류</option>
				</select>
				<div class="searchBox">
				<input type="text" name="detail" id="search"/>
 				<button id="searchBtn" class="defaultBtn"><i class="fas fa-search"></i></button>
				</div>
			</form>
		</div>
		<!-- 필터링 -->
		<div class="fillterSection">
			<a href="${pageContext.request.contextPath}/accountbook/incomeExpenseFilter.do?incomeExpense=">전체보기</a>
			<a href="${pageContext.request.contextPath}/accountbook/incomeExpenseFilter.do?incomeExpense=I">수입</a>
			<a href="${pageContext.request.contextPath}/accountbook/incomeExpenseFilter.do?incomeExpense=E">지출</a>
			<button id="excelModalBtn" class="defaultBtn">엑셀 다운로드</button>
		</div>
		<!-- 가계부 리스트 -->
		<div id="account_list">
			<c:forEach items="${accountList}" var = "account">
				<div class="accountListDiv ${account.code}">
				<table class="accountTable">
					<tr class="account_side_column">
						<td><span class="accountRegDate"><fmt:formatDate value="${account.regDate}" pattern="yyyy/MM/dd"/></span></td>
						<td rowspan="2" class="accountPrice">
							<c:choose>
								<c:when test="${accountList eq null}">
								</c:when>
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
				</div>
				<div class="accountUpdate" id="${account.code}">
					<button class="updateBtn modifyBtn" onclick="updateDetail('${account.code}')">수정</button>
					<button class="deleteBtn modifyBtn" onclick="deleteDetail('${account.code}')">삭제</button>
				</div>
			</c:forEach>
			<c:if test="${totalAccountList gt 4}">
				<div class="accountPage">${pagebar}</div>
			</c:if>
		</div>
	</section>
	<!-- 사용자별 가계부 월별 금액 -->
	<section class="infoSection">
		<div class="account">
			<div class="monthlyPagingBtn">
 				<button type="submit" onclick="monthly('before')" class="defaultBtn">
					전월 조회
				</button>
				<button type="submit" onclick="monthly('next')" class="defaultBtn">
					다음 월 조회
				</button>
			</div>
			<table class="account-info">
				<tr>
					<td colspan="2">
						<c:set var="TextValue" value="${today}"/>
						${fn:substring(TextValue,0,4)}년 ${fn:substring(TextValue,5,7)}월
					</td>
				</tr>
				<tr>
					<td colspan="2">${loginMember.name}님의 총 자산</td>
				</tr>
				<tr id="total_income">
					<td colspan="2" style="font-size:40px"><fmt:formatNumber value="${monthlyAccount}" type="number"/>원</td>
				</tr>
				<tr>
					<td>수입</td>
					<td>지출</td>
				</tr>
				<tr class="user_income_expense">
					<td>
						<span class="income">+ <fmt:formatNumber value="${incomeExpenseList.income}" type="number"/></span>
					</td>
					<td>
						<span class="expense">- <fmt:formatNumber value="${incomeExpenseList.expense}" type="number"/></span>
					</td>
				</tr>
			</table>
		</div>
		<div class="insertForm">
			<button id="insertBtn"><i class="fas fa-plus plus"></i><br />거래내역 입력하기</button>
		</div>
	</section>
</div>

<input type="hidden" name="today" id="today" value="${today}" />
<input type="hidden" id="chartData" value="${chartData}" />
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
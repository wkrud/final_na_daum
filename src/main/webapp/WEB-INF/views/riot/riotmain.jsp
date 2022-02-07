<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:useBean id="dateValue" class="java.util.Date" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Dev등록" name="title" />
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/riot/riotmain.css" />


<br>

<style type="text/css">
@font-face {
	font-family: 'CookieRun-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/CookieRun-Regular.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
</style>


<input type="hidden" id="id" value="${loginMember.id}" />
<input type="hidden" id="nickName" value="${loginMember.nickname}" />
<input type="hidden" id="summonerId" value="${summoner.id}" />
<div id="nadaumgg">
	<h1>Nadaum.gg</h1>
</div>

<div id="aaa">
	<div id="bbb">
		<form id="riotnick" method="GET">
			<input type="text" id="nickname" name="nickname"
				placeholder="소환사명을 입력하세요" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg" />

			<button type="button" onclick="submit('riot1')"
				class="btn btn-sm btn-outline-secondary">전적검색</button>


		</form>

	</div>
</div>
<br>
<br>

<div class="jumbotron p-3 p-md-3 text-white rounded bg-blue">
	<div class="col-md-6 px-0 main-div">
		<img alt="아이콘" src=${ img} style="width: 200px">
		<div class="fav-button-wrap">
			<button type="button" class="btn btn-lg btn-outline-warning fav-btn">즐겨찾기</button>
		</div>
	</div>
	<div class="col-md-6 px-0">
		<h1 class="display-4 font-italic">${summoner.name}</h1>
	</div>
</div>

<div class="row mb-2">
	<div class="col-md-6">
		<div
			class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-auto d-none d-lg-block">
				<c:choose>
					<c:when test="${leagueentry.tier != null}">
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/${leagueentry.tier}.png"
							style="width: 200px">
					</c:when>
					<c:otherwise>
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/unranked.png"
							style="width: 200px; height: 229.3px;">
					</c:otherwise>
				</c:choose>

			</div>
			<div class="col p-4 d-flex flex-column position-static">
				<h3 class="d-inline-block mb-2 text-dark">솔로랭크</h3>
				<h3 class="mb-2 text-primary">${leagueentry.tier}
					${leagueentry.rank} ${leagueentry.leaguePoints} LP</h3>

				<h3 class="mb-0">${leagueentry.wins}승${leagueentry.losses}패</h3>

			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div
			class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-auto d-none d-lg-block">
				<c:choose>
					<c:when test="${leagueentries.tier != null}">
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/${leagueentries.tier}.png"
							style="width: 200px">
					</c:when>
					<c:otherwise>
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/unranked.png"
							style="width: 200px; height: 229.3px;">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col p-4 d-flex flex-column position-static">
				<h3 class="d-inline-block mb-2 text-dark">자유랭크</h3>
				<h3 class="mb-2 text-primary">${leagueentries.tier}
					${leagueentries.rank} ${leagueentries.leaguePoints} LP</h3>

				<h3 class="mb-0">${leagueentries.wins}승${leagueentries.losses}패</h3>

			</div>
		</div>
	</div>

</div>



<main role="main" class="container">
	<div
		class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		<div class="col-md-12 blog-main">


			<c:forEach items="${test}" var="list" begin="0" end="0">
				<c:forEach items="${list}" var="map" begin="0" end="19">
					<c:forEach items="${map.value}" var="mapvalue" begin="0" end="0">
						<c:forEach var="j" begin="0" end="9">
							<div id="recentgame">
								<c:if
									test="${summoner.name eq mapvalue.getInfo().getParticipants().get(j).getSummonerName()}">
									<c:set var="count" value="${count + 1}" />
									<c:if
										test="${mapvalue.getInfo().getParticipants().get(j).isWin() eq true}">
										<c:choose>
											<c:when
												test="${mapvalue.getInfo().getParticipants().get(j).getSummonerName() eq summoner.name}">
												<div class="col-auto d-flex position-static"
													style="background: #c6dbe9; margin-bottom: 10px">
													<div
														class="col-auto pt-2 d-flex flex-column position-static">
														<h4 style="color: #00bfff;">
															<strong>승리</strong>
														</h4>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '420'}">
															<h3>
																<strong>솔로 랭크</strong>
															</h3>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '440'}">
															<h4>
																<strong>자유 랭크</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '430'}">
															<h4>
																<strong>일반 게임</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '450'}">
															<h4>
																<strong>칼바람 나락</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '850'}">
															<h4>
																<strong>봇전</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '900'}">
															<h4>
																<strong>U.R.F</strong>
															</h4>
														</c:if>
														<jsp:setProperty name="dateValue" property="time"
															value="${mapvalue.getInfo().getGameDuration() * 1000}" />
														<fmt:formatDate value="${dateValue}" pattern="mm분 ss초" />
														<br>
														<jsp:setProperty name="dateValue" property="time"
															value="${mapvalue.getInfo().getGameCreation()}" />
														<fmt:formatDate value="${dateValue}" pattern=" MM-dd " />
														<c:set var="check" value="true" />
													</div>
													<div class="col p-4">
														<div class="recentgameinfo">
															<div class="recentchamp">
																<img class="recent-champ-img" alt="챔피언"
																	src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																<div class="recent-champ-lev">
																	<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																</div>
															</div>
															<div class="runespellwrap">

																<div class="recent-rune">
																	<img class="recent-main-rune" alt="룬"
																		src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																	<img class="recent-sub-rune" alt="룬"
																		src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																</div>
																<div class="recent-spellwrap">
																	<img class="recent-spell" alt="스펠"
																		src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																	<img class="recent-spell" alt="스펠"
																		src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																</div>

															</div>
															<div class="recent-kda">
																<img class="sword" alt=""
																	src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

															</div>
															<div class="recent-items-wrap">
																<div class="recent-item">
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>


																</div>
															</div>
															<div class="recent-button-wrap">
																<button type="button"
																	class="btn btn-sm btn-outline-light recent-btn">상세보기</button>
															</div>

														</div>

													</div>



												</div>
											</c:when>
											<c:otherwise>


											</c:otherwise>
										</c:choose>
									</c:if>

									<c:if
										test="${mapvalue.getInfo().getParticipants().get(j).isWin() eq false}">
										<c:choose>
											<c:when
												test="${mapvalue.getInfo().getParticipants().get(j).getSummonerName() eq summoner.name}">
												<div class="col-auto d-flex position-static"
													style="background: #e1d1d0; margin-bottom: 10px">
													<div
														class="col-auto pt-2 d-flex flex-column position-static">
														<h4 style="color: #cd5c5c;">
															<strong>패배</strong>
														</h4>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '420'}">
															<h3>
																<strong>솔로 랭크</strong>
															</h3>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '440'}">
															<h4>
																<strong>자유 랭크</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '430'}">
															<h4>
																<strong>일반 게임</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '450'}">
															<h4>
																<strong>칼바람 나락</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '850'}">
															<h4>
																<strong>봇전</strong>
															</h4>
														</c:if>
														<c:if test="${mapvalue.getInfo().getQueueId() eq '900'}">
															<h4>
																<strong>U.R.F</strong>
															</h4>
														</c:if>
														<jsp:setProperty name="dateValue" property="time"
															value="${mapvalue.getInfo().getGameDuration() * 1000}" />
														<fmt:formatDate value="${dateValue}" pattern="mm분 ss초" />
														<br>
														<jsp:setProperty name="dateValue" property="time"
															value="${mapvalue.getInfo().getGameCreation()}" />
														<fmt:formatDate value="${dateValue}" pattern=" MM-dd " />
														<c:set var="check" value="false" />
													</div>
													<div class="col p-4">
														<div class="recentgameinfo">
															<div class="recentchamp">
																<img class="recent-champ-img" alt="챔피언"
																	src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																<div class="recent-champ-lev">
																	<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																</div>
															</div>
															<div class="runespellwrap">

																<div class="recent-rune">
																	<img class="recent-main-rune" alt="룬"
																		src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																	<img class="recent-sub-rune" alt="룬"
																		src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																</div>
																<div class="recent-spellwrap">
																	<img class="recent-spell" alt="스펠"
																		src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																	<img class="recent-spell" alt="스펠"
																		src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																</div>

															</div>
															<div class="recent-kda">
																<img class="sword" alt=""
																	src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

															</div>
															<div class="recent-items-wrap">
																<div class="recent-item">
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when
																			test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																				class="recent-item06">
																		</c:when>
																		<c:otherwise>
																			<img alt=""
																				src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																				class="recent-item06">

																		</c:otherwise>
																	</c:choose>


																</div>
															</div>
															<div class="recent-button-wrap">
																<button type="button"
																	class="btn btn-sm btn-outline-light recent-btn">상세보기</button>
															</div>


														</div>

													</div>



												</div>
											</c:when>
											<c:otherwise>


											</c:otherwise>
										</c:choose>
									</c:if>
									<div class="testdiv">
										<div class="col-auto d-flex position-static"
											style="background: #f5f5dc; margin-bottom: 10px">
											<div class="col-auto pt-2 d-flex flex-column position-static">


												<c:if test="${count eq 1}">
													<div class="detailgamewrap d-gameclass">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 2}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 3}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 4}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 5}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 6}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 7}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 8}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 9}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 10}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 11}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 12}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 13}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 14}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 15}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 16}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 17}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 18}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 19}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


												<c:if test="${count eq 20}">
													<div class="detailgamewrap">
														<c:forEach items="${test}" var="list2" begin="0" end="0">
															<c:forEach items="${list2}" var="map2" begin="0" end="0">
																<c:forEach items="${map2.value}" var="map2value"
																	begin="0" end="0">
																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">

																		<c:forEach var="j" begin="0" end="4">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>
																	</div>

																	<div>
																		<br> <br> <br> <br> <br> <br>
																		<br> <br> <br> <br> <span>vs</span>
																	</div>

																	<div
																		class="col-auto pt-2 pl-1 pr-1 d-flex flex-column position-static">


																		<c:forEach var="j" begin="5" end="9">

																			<div class="detailgameinfo">
																				<div class="detailname">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getSummonerName()}</span>

																				</div>
																				<div class="detailchamp">
																					<img class="detail-champ-img" alt="챔피언"
																						src="${pageContext.request.contextPath}/resources/images/riot/champion/${mapvalue.getInfo().getParticipants().get(j).getChampionName()}.png">
																					<div class="detail-champ-lev">
																						<span style="color: white;">${mapvalue.getInfo().getParticipants().get(j).getChampLevel()}</span>
																					</div>
																				</div>
																				<div class="detailrunespellwrap">

																					<div class="detail-rune">
																						<img class="detail-main-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(0).getSelections().get(0).getPerk()}.png">
																						<img class="detail-sub-rune" alt="룬"
																							src="${pageContext.request.contextPath}/resources/images/riot/perk-images/Styles/${mapvalue.getInfo().getParticipants().get(j).getPerks().getStyles().get(1).getStyle()}.png">
																					</div>
																					<div class="detail-spellwrap">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner1Id()}.png">
																						<img class="detail-spell" alt="스펠"
																							src="${pageContext.request.contextPath}/resources/images/riot/spell/${mapvalue.getInfo().getParticipants().get(j).getSummoner2Id()}.png">
																					</div>

																				</div>
																				<div class="detail-kda">
																					<img class="detailsword" alt=""
																						src="${pageContext.request.contextPath}/resources/images/riot/sword.png">
																					<span>${mapvalue.getInfo().getParticipants().get(j).getKills()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getDeaths()}</span>
																					<span>/</span> <span>${mapvalue.getInfo().getParticipants().get(j).getAssists()}</span>

																				</div>
																				<div class="detail-items-wrap">
																					<div class="detail-item">
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem0() != null && mapvalue.getInfo().getParticipants().get(j).getItem0() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem0()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem1() != null && mapvalue.getInfo().getParticipants().get(j).getItem1() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem1()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem2() != null && mapvalue.getInfo().getParticipants().get(j).getItem2() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem2()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem3() != null && mapvalue.getInfo().getParticipants().get(j).getItem3() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem3()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem4() != null && mapvalue.getInfo().getParticipants().get(j).getItem4() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem4()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>
																						<c:choose>
																							<c:when
																								test="${mapvalue.getInfo().getParticipants().get(j).getItem5() != null && mapvalue.getInfo().getParticipants().get(j).getItem5() != 0}">
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/item/${mapvalue.getInfo().getParticipants().get(j).getItem5()}.png"
																									class="detail-item06">
																							</c:when>
																							<c:otherwise>
																								<img alt=""
																									src="${pageContext.request.contextPath}/resources/images/riot/blank.png"
																									class="detail-item06">

																							</c:otherwise>
																						</c:choose>


																					</div>
																				</div>


																			</div>

																		</c:forEach>


																	</div>



																</c:forEach>
															</c:forEach>
														</c:forEach>
													</div>
												</c:if>


											</div>
										</div>
									</div>
								</c:if>





							</div>
						</c:forEach>
					</c:forEach>
				</c:forEach>
			</c:forEach>
			<br> <br> <br> <br>


		</div>
	</div>
</main>





<script>
const submit = () => {
	$(riotnick)
		.attr("action", `${pageContext.request.contextPath}/riot/\${name}.do`)
		.submit();
		


};

$(".testdiv").hide();



$(".recent-btn").click((e) => {
	$(e.currentTarget).parent().parent().parent().parent().parent().find('div.testdiv').toggle("fold", 550);
	
});







</script>
  <script src="${pageContext.request.contextPath}/resources/js/riot/riotfav.js"></script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
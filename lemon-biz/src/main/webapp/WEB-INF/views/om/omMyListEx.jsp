<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" />
<!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />

<link href="${pageContext.request.contextPath}/resources/css/om.css"
	rel="stylesheet" type="text/css">
<script>
	$(function() {
		$("tr[data-no]")
				.click(
						function() {
							var key = $(this).attr("data-no");
							console.log(key);
							location.href = "${ pageContext.request.contextPath }/om/omDetail.do?key="
									+ key;
						});
	});

	function goOmForm() {
		location.href = "${pageContext.request.contextPath}/om/omForm.do";
	}
</script>
</head>
<body>
	<div class="container">
		<div class="card">
			<h4 id="m-title" class="card-header">
				<strong>발송함(외부)</strong>
			</h4>
			<div class="container-inner card-body">
				<form action="${pageContext.request.contextPath}/om/omMyListEx"
					method="GET">

					<!-- 여기서부터 card-body내 본문 영역 -->
					<!-- 여기서부터 네비게이션 헤더 -->
					<ul class="nav nav-tabs" id="addl-btns" role="tablist">
						<li class="nav-item"><a class="nav-link" id="allOM-tab"
							href="${pageContext.request.contextPath}/om/omMyList.do" role="tab"
							aria-controls="allOM" aria-selected="false">발송함 전체</a></li>
						<li class="nav-item"><a class="nav-link" id="myOM-tab"
							href="${pageContext.request.contextPath}/om/omMyListIn.do"
							role="tab" aria-controls="myOM" aria-selected="false">발송함(사내)</a>
						</li>
						<li class="nav-item"><a class="nav-link active" id="myOM-tab"
							href="${pageContext.request.contextPath}/om/omMyListEx.do"
							role="tab" aria-controls="myOM" aria-selected="true">발송함(외부)</a>
						</li>
						<li class="nav-item"><a class="nav-link" id="selfOM-tab"
							href="${pageContext.request.contextPath}/om/omSelfList.do"
							role="tab" aria-controls="selfOM" aria-selected="false">내게 보낸
								메일</a></li>
					</ul>
					<!-- 여기까지 네비게이션 헤더 -->

					<!-- 여기서부터 메일함 상단부 헤더 -->
					<div class="tab-content">
						<table class="table" id="tbl-header">
							<tr>
								<th id="star-all">
									<div class="the-star">
										<input class="star" type="checkbox" title="bookmark-all"
											id="bookmark-all">
									</div>
								</th>
								<th>발신인</th>
								<th>제목</th>
								<th>수신일</th>
								<th>첨부파일</th>
							</tr>
							<!-- </table> -->
							</div>
							<!-- 여기까지 메일함 상단부 헤더 -->


							<!-- 지금부터 메일 표시 -->
							<!-- 여기서부터 메일 리스트 -->
							<div class="tab-pane fade" id="myOM" role="tabpanel"
								aria-labelledby="myOM-tab">
								<c:forEach items="${ list }" var="om">
									<tr data-no="${ om.key }"
										<c:if test="${om.readCount gt 0}">
					style="background:#DCDCDC"
			</c:if>>
										<td>
											<div class="the-star">
												<input class="star" type="checkbox" title="bookmark"
													id="star"
													<c:if test="${ om.isStarred gt 0 }">checked="checked"</c:if> />
											</div>
										</td>
										<td>${ om.memId }</td>
										<td id="titlee">${ om.title }</td>
										<td><fmt:formatDate value="${ om.omDate }"
												pattern="yy/MM/dd" /></td>
										<td><c:if test="${ om.fileCount gt 0 }">
												<img
													src="${ pageContext.request.contextPath }/resources/images/file.png"
													style="width: 1rem;" />
											</c:if></td>
									</tr>
								</c:forEach>
							</div>
							<!-- 여기까지 메일 리스트 -->
						</table>
						<!-- 여기부터 하단부 버튼 및 페이징 영역 -->
						<!-- 하단 버튼 영역 -->
						<div align="center" id="btns">
							<input type="button" value="새 메일 작성" id="btn-add"
								class="btn btn-warning" onclick="goOmForm();" />
						</div>
						<br />
						<!-- 페이징 영역 -->
						<div class="row" id="pagenate">
							<div class="col">
								<ul style="justify-content: center;" class="pagination">
									<li>${ pagebar }</li>
								</ul>
							</div>
						</div>
				</form>
			</div>
			<!-- container-inner div 끝 -->
		</div>
		<!-- container div 끝 -->
	</div>
	<br />
</body>
<script>
	$(function() {
		$("tr[data-key]")
				.click(
						function() {
							var no = $(this).attr("data-key");
							console.log(no);
							location.href = "${ pageContext.request.contextPath }/om/omDetail.do?no="
									+ no;
						});
	});

	$(document).ready(function() {

		$("#attach-to").click(function() {
			$("#attachModal").modal({
				backdrop : true
			});
		});
		$("#addReceiverBtn").click(function() {
			$("#addReceiverModal").modal({
				backdrop : true
			});
		});

		$('#content-reset').click(function() {
			var reset = confirm("정말로 작성 중인 내용을 삭제하시겠습니까?");
			if (reset == true) {
				alert("메일 작성을 취소하셨습니다. 이전 화면으로 돌아갑니다.");
				window.history.back();
			} else {
			}
		});
		$('#send-om').click(function() {
			if ($('#summernote').summernote('isEmpty')) {
				alert('본문 내용을 입력해 주세요.');
				return false;
			}
		});
	});
</script>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
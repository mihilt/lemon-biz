<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />

<div class="container">
	<div class="card my-5">
		<h4 id="m-title" class="card-header">
			<strong>조직도</strong>
		</h4>

		<table class="table table-bordered">
			<c:forEach items="${ hierarchicalDeptList }" var="dept">
				<tr>
					<td style="width: 40%"
						class="<c:if test="${ dept.deptLevel == 2 }">pl-3</c:if><c:if test="${ dept.deptLevel eq 3 }">pl-5</c:if>">
						<c:if test="${ dept.deptLevel != 1 }">
							&nbsp;&nbsp;&nbsp;&nbsp;┗&nbsp;&nbsp;
						</c:if>${ dept.name }(${ dept.key })
					</td>


					<td class="mx-3"><c:forEach items="${ memberList }"
							var="member">
							<c:if test="${ dept.key eq member.deptKey }">
								<span onclick="memberInfo('${member.memberId}');"
									class="badge badge-secondary" style="cursor: pointer;">${member.name}</span>
							</c:if>


						</c:forEach></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<!-- Modal -->
<div class="modal fade bd-example-modal-lg" id="exampleModal"
	tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사원 정보</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body pb-5">

				<div id="modalProfileImg" class="m-5 mx-auto"
					style="width: 200px; height: 200px; background-size: 200px 200px; border-radius: 70%; border: solid 2px; border-color: #d1d3e2; overflow: hidden;">
				</div>

				<div class="mb-1 row mx-5">
					<div class="col-2 pt-2 text-right">이름 :</div>
					<div id="modalMemberName" class="col-10 form-control"></div>
				</div>
				<div class="mb-1 row mx-5">
					<div class="col-2 pt-2 text-right">부서 :</div>
					<div id="modalDeptName" class="col-10 form-control"></div>
				</div>
				<div class="mb-1 row mx-5">
					<div class="col-2 pt-2 text-right">직급 :</div>
					<div id="modalRankName" class="col-10 form-control"></div>
				</div>
				<br />
				<div class="mb-1 row mx-5">
					<div class="col-2 pt-2 text-right">전화번호 :</div>
					<div id="modalTelNum" class="col-10 form-control"></div>
				</div>
				<div class="mb-1 row mx-5">
					<div class="col-2 pt-2 text-right">주소 :</div>
					<div id="modalAddress" class="col-10 form-control"></div>
				</div>
				<br />
				<div class="mb-1 row mx-5">
					<div class="col-2 pt-2 text-right">이메일 :</div>
					<div id="modalEmail" class="col-10 form-control"></div>
				</div>


			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/showMemberInfo.jsp" />
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

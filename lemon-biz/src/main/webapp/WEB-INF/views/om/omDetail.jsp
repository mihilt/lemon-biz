<%@page import="com.lemon.lemonbiz.om.model.vo.OM"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- summernote -->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

</head>
<body>
	<div class="container">
		<div class="container-fluid text-center">

			<!-- 게시글 -->
			<div class="col-lg-12">
				<form action="${pageContext.request.contextPath}/om" method="post"
					name="om">
					<div class="card">
						<div class="card-header">
							<div align="left">
								<h4><strong>${om.title}</strong></h4>
								<br />
								<strong class="text-warning">${sender.name}</strong> <strong>(${sender.deptName}/${sender.rankName})</strong>
								<br />
								${sender.email}
							</div>
								<div align="right"><strong>발송일시:&nbsp;</strong>
									<strong class="text-warning">
									<fmt:formatDate value="${ om.omDate }" pattern="yyyy/MM/dd HH:mm" />
									</strong></div>
							</div>
						<div class="card-body text-center">
							<div class="form-group" align="left">
								<div style="height: 300px; overflow: auto;" align=left>${ om.content }</div>
							</div>
							<hr>
							<div>
								<strong>첨부파일 목록</strong><br>
								<c:forEach items="${ om.attachList }" var="attach">
								<c:choose>
									<c:when test="${ attach.originName != null }">
										<a href="javascript:fileDownload('${ attach.key }');"> <img
											alt="첨부파일"
											src="${ pageContext.request.contextPath }/resources/images/file.png"
											width=1rem> ${ attach.originName }
										</a>
									</c:when>
									<c:otherwise>
									<br />
									첨부된 파일이 없습니다.
									</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>
							<br>
							<div align="center" id="btns">
								<input type="button" value="메일 회신" id="btn-add"
									class="btn btn-success" onclick="omReturn(${om.key})" />
									<input type="hidden" name="sender" value="${om.memId}" />
									<input type="button" value="메일 삭제" id="content-reset"
										class="btn btn-danger" onclick="deleteOm(${om.key})"/>
								<input type="button" value="이전 화면" id="content-reset"
									class="btn btn-secondary" onclick="window.history.back();" />
									<br />
									<br />
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$('#brdmemo')
								.summernote(
										{
											lang : 'ko-KR',
											height : 500,
											popover : {
												image : [],
												link : [],
												air : []
											},
											toolbar : [
													// [groupName, [list of button]]
													[
															'style',
															[
																	'bold',
																	'italic',
																	'underline',
																	'clear' ] ],
													[
															'font',
															[
																	'strikethrough',
																	'superscript',
																	'subscript' ] ],
													[ 'fontsize',
															[ 'fontsize' ] ],
													[ 'color', [ 'color' ] ],
													[
															'para',
															[ 'ul', 'ol',
																	'paragraph' ] ],
													[ 'table', [ 'table' ] ],
													[
															'insert',
															[ 'link',
																	'picture',
																	'hr' ] ],
													[ 'height', [ 'height' ] ] ],
											focus : true,
											callbacks : {
												onImageUpload : function(files,
														editor, welEditable) {
													for (var i = files.length - 1; i >= 0; i--) {
														sendFile(files[i], this);
													}
												}
											}
										});
					})

	function fileDownload(key) {
		location.href = "${ pageContext.request.contextPath }/om/fileDownload.do?key="
				+ key;
	}

	function deleteOm(key) {
		if (!confirm("정말 삭제하시겠습니까?"))
			return;
		location.href = "${ pageContext.request.contextPath }/om/omfrmDelete.do?key="
				+ key;
	}
	function omReturn(key){
		location.href = "${pageContext.request.contextPath}/om/omReturn.do?key="
			+key;
	}
</script>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

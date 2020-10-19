<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<!-- include summernote-ko-KR -->
<script src="${pageContext.request.contextPath }/resources/summernoteKr/summernote-ko-KR.js"></script>

<script>
//add summernote
$(document).ready(function() {
  $('#summernote').summernote({
    lang: 'ko-KR',
    height: 500
    
  });
});
</script>

<div class="container">
	<div class="card">
		<h4 id="m-title" class="card-header">
			<strong>전자결재 문서 수정</strong>
		</h4>
		<form class="p-4 mx-auto"
			  action="${ pageContext.request.contextPath }/manager/updateApprovalDoc.do?key=${docType.key}"
			  method="post"
		 	  style="width: 100%;"
			>
			<div class="mb-4">
				<label>문서명</label>
				<input name="name" class="col form-control" type="text" value="${docType.name}" required>
			</div>
			<div>
				<label>내용</label>
				<textarea id="summernote" name="form" class="form-control" required>
				${docType.form}
				</textarea>
			</div>
			<button
				class="btn bg-warning text-white font-weight-bold float-right mt-4"
				type="submit">
				문서 수정
			</button>
		</form>
	</div>
</div>


			 
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

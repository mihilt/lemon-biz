<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
	

<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
tr[data-no]{
	cursor: pointer;
	
}

</style>
<script>
$(function(){
	$("tr[data-no]").click(function(){
		var key = $(this).attr("data-no");
		console.log(key);
		location.href = "${ pageContext.request.contextPath }/board/boardDetail.do?key=" + key;
	});
});


function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardForm.do";
}
</script>

<section id="board-container" class="container">
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-warning" onclick="goBoardForm();"/>
	<table id="tbl-board" class="table table-striped table-hover">
	<strong style=font-size:25px;>전사 게시판</strong>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${ list }" var="post">
		<tr data-no="${ post.key }">
			<td>${ post.key }</td>
			<td>${ post.title } 
				<c:if test="${ post.fileCount gt 0 }">
					<img src="${ pageContext.request.contextPath }/resources/images/file.png"
						 style="width:16px;" />
				</c:if>
			</td>
			<td>${ post.memId }</td>
			<td><fmt:formatDate value="${ post.postDate }" pattern="yyyy/MM/dd"/></td>
			<td>${ post.readCount }</td>
		</tr>
		</c:forEach>
	</table>
<form id="form1" name="form1"  method="post">

	<div class="container">

	    <div class="container-fluid" align="center">
	    
			<input type="hidden" checked="checked" name="searchType" value="brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">checked="checked"</c:if>/>
			
			<div class="group" style="align:center;">
			
			<select class="btn btn-outline-warning dropdown-toggle" id="condition">
			<option name="searchType" value="brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">checked="checked"</c:if>>제목</option>
			<option name="searchType" value="brdmemo" <c:if test="${fn:indexOf(searchVO.searchType, 'brdmemo')!=-1}">checked="checked"</c:if>>내용</option>
			</select>
			
			<input type="text" class="btn btn-outline-warning" name="searchKeyword" maxlength="50" value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
			<button name="btn_search" value="검색" class="btn btn-outline-warning" type="button" onclick="fn_formSubmit()"><i class="fas fa-search fa-sm"></i></button>
		    <br>
		     <div class="container" >
			<div class="row">
				<div class="col">
					
					<ul class="pagination">
						<!-- <li class="page-item"><a class="page-link" href="#">Previous</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>
						<li class="page-item"><a class="page-link" href="#">Next</a></li> -->
						${pagebar}
					</ul>
					
				</div>
			</div>
		</div>
		     </div>
		</div>
	</div>
	</form>	
            <br>
           
</section> 

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

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
		var no = $(this).attr("data-no");
		console.log(no);
		location.href = "${ pageContext.request.contextPath }/board/boardDetail.do?no=" + no;
	});
});


function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardForm.do";
}
</script>

<section id="board-container" class="container">
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-warning" onclick="goBoardForm();"/>
	<table id="tbl-board" class="table table-striped table-hover">
	<strong style=font-size:25px;  >전사 게시판</strong>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th> <!-- 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px-->
			<th>조회수</th>
		</tr>
		<c:forEach items="${ list }" var="post">
		<tr data-no="${ post.key }">
			<td>${ post.key }</td>
			<td>${ post.title }</td>
			<td>${ post.memId }</td>
			<td><fmt:formatDate value="${ post.postDate }" pattern="yyyy/MM/dd"/></td>
			<td>
				<c:if test="${ post.fileCount gt 0 }">
					<img src="${ pageContext.request.contextPath }/resources/images/file.png"
						 style="width:16px;" />
				</c:if>
			</td>
			<td>${ post.readCount }</td>
		</tr>
		</c:forEach>
	</table>
<form class="navbar-form" role="search">
	
            <div class="input-group">
            <div class="input-group-btn search-panel">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    	<span id="search_concept">제목</span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="#contains">작성자</a></li>
                      <li><a href="#its_equal">It's equal</a></li>
                      <li><a href="#greather_than">Greather than ></a></li>
                      <li><a href="#less_than">Less than < </a></li>
                      <li class="divider"></li>
                      <li><a href="#all">Anything</a></li>
                    </ul>
                </div>
                <input type="text" class="form-control" placeholder="search" name="q" >
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                </div>
            </div>
            </form>   
</section> 

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

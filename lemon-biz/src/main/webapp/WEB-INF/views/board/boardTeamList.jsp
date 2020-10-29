<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />

<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
tr[data-no]{
	cursor: pointer;
	
}

td {

font-family: 'Jua', sans-serif;
font-size: 17px;

}
div#search-title {display: inline-block;}
div#search-memberName{display:none;}
</style>


<form name="boardEnroll" 
	  action="${pageContext.request.contextPath}/board/boardForm2.do"
	  method="post" >
	<input type="hidden" name="deptKey" value="${ loginMember.deptKey }" />
</form>

<section id="board-container" class="container">
	<c:if test="${ loginMember.deptKey ne 0 }">
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-warning" onclick="goBoardForm();"/>
	</c:if>
	<table id="tbl-board" class="table table-striped table-hover">
	<strong style="font-size:25px; font-family: 'Jua', sans-serif;">
	<c:choose>
		<c:when test="${name eq null }">부서코드를 부여받으세요</c:when>
	<c:otherwise>${ name }</c:otherwise>  
	</c:choose>
	</strong>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>			
			<th>추천</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${ list }" var="post">
		<tr data-no="${ post.key }">
			<c:if test="${ post.isNotice eq 1 }">
			<td style="color:black; font-weight:bold;"><img src="${ pageContext.request.contextPath }/resources/images/notic.png" 
						 style="width:30px;" /></td>
			</c:if>
			<c:if test="${ post.isNotice eq 0 }">
			<td></td>
			</c:if>
			
			<c:if test="${ post.isNotice eq 1 }">
			<td style="color:red; font-weight:bold; fontsize:25px;">${ post.title }<span class="badge bg-teal"><i class="fa fa-comment-o">[${ post.boardCommentCnt }]</i></span> </td>
			</c:if>
			<c:if test="${ post.isNotice eq 0 }">
			<td >${ post.title } 
				<c:if test="${ post.fileCount gt 0 }">
					<img src="${ pageContext.request.contextPath }/resources/images/file.png"
						 style="width:16px;" />
				</c:if>
				<span class="badge bg-teal"><i class="fa fa-comment-o">[${ post.boardCommentCnt }]</i></span>
			</td>
			</c:if>	
			
			<c:if test="${ post.isNotice eq 1 }">
			<td style="color:red; font-weight:bold; fontsize:25px;">${ post.name1 }</td>
			</c:if>
			<c:if test="${ post.isNotice eq 0 }">
			<td>${ post.name1 }</td>
			</c:if>
			
			<c:if test="${ post.isNotice eq 1 }">
			<td style="color:red; font-weight:bold; fontsize:25px;"><fmt:formatDate value="${ post.postDate }" pattern="yyyy/MM/dd"/></td>
			</c:if>
			<c:if test="${ post.isNotice eq 0 }">
			<td><fmt:formatDate value="${ post.postDate }" pattern="yyyy/MM/dd"/></td>
			</c:if>
			
			<c:if test="${ post.isNotice eq 1 }">
			<td style="color:red; font-weight:bold; fontsize:25px;">${ post.count }</td>
			</c:if>
			<c:if test="${ post.isNotice eq 0 }">
			<td>${ post.count }</td>
			</c:if>
			
			<c:if test="${ post.isNotice eq 1 }">
			<td style="color:red; font-weight:bold; fontsize:25px;">${ post.readCount }</td>
			</c:if>
			<c:if test="${ post.isNotice eq 0 }">
			<td>${ post.readCount }</td>
			</c:if>
			
		</tr>
		</c:forEach>
	</table>

	<div class="container">
	    <div class="container-fluid" align="center">  
	    
		<div class="group" style="align:center;">
			<select class="btn btn-outline-warning dropdown-toggle" id="searchType">
				<option value="title">제목</option>
				<option value="memberName">작성자</option>
			</select>
         <div id="search-memberName" class="search-type">
            <form action="${ pageContext.request.contextPath }/board/boardTeamSearch.do">
                <input type="hidden" name="searchType" value="memberName"/>
                <input type="text" class="btn btn-outline-warning" name="searchKeyword"/>
                <button type="submit" class="btn btn-outline-warning"><i class="fas fa-search fa-sm"></i></button>			
            </form>	
        </div>

        <div id="search-title" class="search-type">
            <form action="${ pageContext.request.contextPath }/board/boardTeamSearch2.do">
                <input type="hidden" name="searchType" value="title"/>
                <input type="text" class="btn btn-outline-warning" name="searchKeyword"/>
                <button type="submit" class="btn btn-outline-warning"><i class="fas fa-search fa-sm"></i></button>			
            </form>           
        </div>
        
	</div>
		    <br>
		     <div class="container" >
			<div class="row">
				<div class="col">
					
					<%-- <ul class="pagination">
						<!-- <li class="page-item"><a class="page-link" href="#">Previous</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>
						<li class="page-item"><a class="page-link" href="#">Next</a></li> -->
						${pagebar}
					</ul> --%>
					
				</div>
			</div>
		</div>
		     </div>
		</div>

            <br>
           
</section> 

<script>
$(function(){
	$("tr[data-no]").click(function(){
		var key = $(this).attr("data-no");
		console.log(key);
		location.href = "${ pageContext.request.contextPath }/board/boardDetail2.do?key=" + key;
	});
});


function goBoardForm(){
	$("[name=boardEnroll]").submit();
}

$(function(){
	$("#searchType").change(function(){
		console.log($(this).val());
		var type = $(this).val();
		$(".search-type").hide()
						 .filter("#search-" + type)
						 .css("display", "inline-block");
	});
});
</script>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

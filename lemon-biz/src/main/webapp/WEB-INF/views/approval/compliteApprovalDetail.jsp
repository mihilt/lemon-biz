<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>


<div class="container">
		<h2>결제완료문서</h2>
		<div class="container-fluid">
		<!-- 게시글 -->
 			<div class="col-lg-12">			
             	<div class="card" >
                	<div class="card-header py-3" align="center">	
						<table class="table table text-center">
					    <tr>
					    	<td><strong>기안담당</strong>
								<c:choose>
								<c:when test="${ loginMember.isManager == 1 }">관리자</c:when>
								<c:otherwise>${ appr.memName }</c:otherwise>
								</c:choose>
							</td>
								
							<td><strong>기안부서</strong>
								<c:choose>
								<c:when test="${ loginMember.isManager == 1 }">관리자</c:when>
								<c:otherwise>${ appr.rankName }</c:otherwise>
								</c:choose>
							</td>
							
							<td>
							<strong>기안일자</strong>
							
							<fmt:formatDate value="${appr.draftDate}"  pattern="yyyy-MM-dd"/>
							
							</td>
						</tr>
					    </table>
					</div>
					<div>
					
					
					    <!-- ================결제칸=============== -->
					
						
					    <table>
						<tr><td width="50%">
						<div class="float-center">
							<!-- Button trigger modal -->
							
						</div>
						</td>
						<td width="50%">
						<div class="float-center">
						<table border="1" style="display: inline-block">
						
						<tr>
							<td></td>
							<td>기안자</td>
							<td id="proNum1">1차 결제자</td>
							<td id="proNum2">2차 결제자</td>
							<td id="proNum3">3차 결제자</td>
						</tr>
						<tr>
						<td class="tt" rowspan='4'>결재</td>
						<td class="aa">작성자</td>
						
						<td id="authRank1" class="aa">
						${ apprck1.rankName }
						</td>
						
						<td id="authRank2" class="aa">
						${ apprck2.rankName }
						</td>
						
						<td id="authRank3" class="aa">
						${ apprck3.rankName }
						</td>
						
						
						<%-- <td id="authRank1" class="aa">${ apvReWrite.rank_name1 }</td>
						<td id="authRank2" class="aa">${ apvReWrite.rank_name2 }</td>
						<td id="authRank3" class="aa">${ apvReWrite.rank_name3 }</td> --%>
						</tr>
						
						
						<tr>
						
						<td>${ loginMember.name }</td>
						<td id="authName1">${ apprck1.ckName }</td>
						<td id="authName2">${ apprck2.ckName }</td>
						<td id="authName3">${ apprck3.ckName }</td>
						
						</tr>
						
						<tr>
						
						<td>${ loginMember.memberId }</td>
						<td id="apv_mem1">${ apprck1.memId }</td>
						<td id="apv_mem2">${ apprck2.memId }</td>
						<td id="apv_mem3">${ apprck3.memId }</td>
	
						</tr>
						
						<tr>
						<td>제출</td>
						<td>
							<c:choose>
								<c:when test="${ apprck1.status eq null}">
									미결제
								</c:when>
								<c:when test="${ apprck1.status eq 't' }">
									승인
								</c:when>
								<c:when test="${ apprck1.status eq 'f' }">
									반려
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${ apprck2.status eq null }">
									미결제
								</c:when>
								<c:when test="${ apprck2.status eq 't' }">
									승인
								</c:when>
								<c:when test="${ apprck2.status eq 'f' }">
									반려
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${ apprck3.status eq null }">
									미결제
								</c:when>
								<c:when test="${ apprck3.status eq 't' }">
									승인
								</c:when>
								<c:when test="${ apprck3.status eq 'f' }">
									반려
								</c:when>
							</c:choose>
						</td>
						
						</tr>
						
						</table>
						</div>
						
						</table>
						</div>
						<!-- ==============결제칸 끝============== -->
						<!-- 폼 내용 -->
						
						
						
						<form id="sendApv" action="${ pageContext.request.contextPath }/approval/updateApproval.do" method="POST" enctype="multipart/form-data">
							
							
							
							&nbsp;제목 : <input class="form-control" id="title" type="text" name="approval_title" value="${ appr.title }" readonly>
							<br>
							
							<div>
								<textarea id="summernote" class="form-control" name="approval_content"  cols="120" rows="18" 
		      							  style="width:100%; resize:none" readonly>${ appr.content }</textarea> <br>
							</div>
							
							
							<div class="container" align="left">
							&nbsp;<label>첨부: ${ attach.originName } </label> <br>
							<button type="button"
									class="btn btn-outline-primary"
									onclick="fileDownload('${attach.key}')">
									다운로드
							</button>
							<hr>
							</div>
						               
						</form>
						
						<!-- 폼 내용 end -->
						
						<div class="container" align="center">
						<input class="btn btn-outline-primary" type="button" value="뒤로가기" onclick="history.back(-1);">
						<div><br></div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
		


<script>

function fileDownload(key) {
	location.href = "${ pageContext.request.contextPath }/approval/fileDownload.do?key=" + key;
}


</script>



<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
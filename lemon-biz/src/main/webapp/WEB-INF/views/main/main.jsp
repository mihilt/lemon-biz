<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

	<h1>Main Page</h1>
	<h6>로그아웃 프로필 누르고 나오는메뉴에서 로그아웃 가능하게 바꿨습니다</h6>
	<br />
	<h6>
		나중에 조원들 모두 풀 한번씩 당기고 어떤 식으로 처음에 로그인하는지 다들 알게 되면
		개발 진행하는 동안은 로그인 없이 index 바로 갈 수 있도록 할게요
	</h6>
	<br />
	<h6>
		예빈씨 제가 부트스트랩 푸터에 넣어놔서 저때문에 썸머노트 cdn도 부트스트랩 밑에 푸터에 넣어주셨는데
		다시 부트스트랩 헤더로 올렸어요 이제 딱 필요한 페이지에서만 cdn 추가하도록 바꿔주시면 될 것 같아요 
	</h6>
	
			 
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

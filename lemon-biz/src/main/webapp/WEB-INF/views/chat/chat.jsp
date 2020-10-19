<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
<!DOCTYPE html>
<html>
<head>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<meta charset="UTF-8">
	<title>Chating</title>
	<style>
		/* #chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		} */
		.others{
			color: #000;
			float: right;
		}
		.me{
			color: #000;
			float: left;
		}
		
	</style>
</head>

<script type="text/javascript">
	window.onload = function(){
		wsOpen();
	}

	var ws;

	function wsOpen(){
		ws = new WebSocket("ws://" + location.host + "/lemonbiz/chating/"+$("#roomNumber").val());
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 초기화 세팅하기
		}
		
		ws.onmessage = function(data) {
			console.log('wsEvt()');
			console.log('data',data);
			
			//메시지를 받으면 동작
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				console.log('d',d);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					if(d.sessionId == $("#sessionId").val()){
						$(".card-body")
						.append("<div class='d-flex flex-row'>"
							   +"<div>"
							   +"<span>나 :" + d.msg + "</span>"
							   +"</div>"
							   +"</div>")
					}else{
						$(".card-body")
						.append("<div class='d-flex flex-row-reverse'>"
							   +"<div>"
							   +"<span>" + d.userName + " : " + d.msg + "</span>"
							   +"</div>"
							   +"</div>");
					}
					
						
				}else{
					console.warn("unknown type!")
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}
	
	function send() {
		
		console.log("버튼작동");
		console.log(ws);
		
		console.log('$("#roomNumber").val()',$("#roomNumber").val());
		console.log('$("#sessionId").val()',$("#sessionId").val());
		console.log('$("#userName").val()',$("#userName").val());
		console.log('$("#chatting").val()',$("#chatting").val());
		
		
		var option = {
			type : "message",
			roomNumber : $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		};
		
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
</script>
<body>
	<div class="container">
		<div class="card text-center" id=chatingbox>
			<div class="card-header">
				<h1>${roomName}의채팅방</h1>
			</div>
			<div class="card-body" style="height:500px">
				<input type="hidden" id="sessionId" value="">
				<input type="hidden" id="roomNumber" value="${roomNumber}">
				<input type="hidden" name="userName" id="userName" value="${loginMember.getName()}">
			</div>
			<div class="card-footer">
				<div class="input-group mb-3">
					<input type="text"
						   id="chatting"
						   class="form-control"
						   placeholder="메세지를 입력하세요"
						   aria-describedby="button-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" onclick="send()" id="sendBtn">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
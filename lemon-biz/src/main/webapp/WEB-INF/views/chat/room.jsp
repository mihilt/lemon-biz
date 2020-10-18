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
<meta charset="UTF-8">
	<title>Room</title>
	<style>
	#roomName{
		width: 500px;
		float: right;
	}
	
	.DocumentList
	{
	    overflow-y:scroll;
	    height:200px;
	    width:100%;
	    padding: 0 15px;
	}

	</style>

<script type="text/javascript">
	var ws;
	window.onload = function(){
		getRoom();
		createRoom();
	}

	function getRoom(){
		commonAjax('${pageContext.request.contextPath}/getRoom', "", 'post', function(result){
			console.log('result',result);
			createChatingRoom(result);
		});
	}
	
	function createRoom(){
		$("#createRoom").click(function(){
			var msg = {	roomName : $('#roomName').val(),
						creator : ${loginMember.getMemberId()} };

			commonAjax('${pageContext.request.contextPath}/createRoom', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}

	function goRoom(number, name){
		location.href="${pageContext.request.contextPath}/moveChating?roomName="+name+"&"+"roomNumber="+number;
	}

	function deleteRoom(number){
		console.log('number',number);
		var msg = { roomNumber : number };


		$.ajax({
			url: "${pageContext.request.contextPath}/deleteRoom",
			data: msg,
			type: "POST",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success: function(response){
				console.log(response);
				alert(response.msg);
			},
			error : function(xhr,status,err){
				console.log("처리 실패");
				console.log(xhr);
				console.log(status);
				console.log(err);
			}
			
		});

		getRoom();
	}

	function createChatingRoom(res){
		console.log('res',res);
		if(res != null){
			var tag = "";
			res.forEach(function(d, idx){
				console.log('d',d)
				var rn = d.roomName.trim();
				var roomNumber = d.roomNumber;
				var creator = d.creator;
				
				if(creator == ${ loginMember.getMemberId() }){
					tag += "<tr>"+
								"<td>"+(idx+1)+"</td>"+
								"<td>"+"<p class='float-left ml-5'>"+ rn +"</P>"+"</td>"+
								"<td><button type='button' class='btn btn-outline-secondary' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>"+
								"<td><button type='button' class='btn btn-outline-secondary' onclick='deleteRoom(\""+roomNumber+"\")'>삭제</button></td>"+
			   			   "</tr>";	
				} else {
					tag += "<tr>"+
								"<td>"+(idx+1)+"</td>"+
								"<td>"+"<p class='float-left ml-3'>"+ rn +"</P>"+"</td>"+
								"<td><button type='button' class='btn btn-outline-secondary' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>"+
								"<td></td>"
			   			   "</tr>";	
				}
			
			});
			$("#roomList").empty().append(tag);
		} // if가 끝나는 부분
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
</script>

</head>

<body>
	<div class="container">
		<div class="card text-center">
			<div class="card-header" id="example2">
				<h1>채팅방</h1>
			</div>
			<div class="card-body DocumentList"style="height: 500px">
				<table class="table table-striped col-12" >
					<thead>
						<tr>
							<th style="width: 15%"><p>순서</p></th>
							<th style="width: 65%"><p class="float-left ml-5">방 이름</p></th>
							<th style="width: 10%"><p>참여</p></th>
							<th style="width: 10%"><p>삭제</p></th>
						</tr>
					</thead>
					<tbody id="roomList">
						
					</tbody>
				</table>
			</div>
			<div class="card-footer">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>방제목</th>
							<th><input type="text" name="roomName" id="roomName"></th>
							<th><button class="btn btn-outline-secondary" id="createRoom">방 만들기</button></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>LemonBiz</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
	.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>

<script type="text/javascript">

		 $(document).ready(function() {

			msg = { memberId : ${loginMember.memberId} }
				
			$.ajax({
				url : "${pageContext.request.contextPath}/approval/getCountApproval",
				method : "GET",
				data : msg,
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				success: function(response){
					console.log(response);
					$('#apvCount4').text(response);
				},
				error : function(xhr,status,err){
					console.log("처리 실패");
					console.log(xhr);
					console.log(status);
					console.log(err);
				}
			});
		});

		 $(document).ready(function() {

				msg = { memberId : ${loginMember.memberId} }
					
				$.ajax({
					url : "${pageContext.request.contextPath}/mail/getCountNoReadMail",
					method : "GET",
					data : msg,
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success: function(response){
						console.log(response);
						$('#main_email_count').text(response);
					},
					error : function(xhr,status,err){
						console.log("처리 실패");
						console.log(xhr);
						console.log(status);
						console.log(err);
					}
				});
			});	

		$(document).ready(function() {

				/* 현재 시각 */
				printTime();

				/* 주간 일정 */
	             var $calendar = $("#calendar").fullCalendar({
	                 header: false, 
	                 selectable: false,
	                 eventLimit: true,
	                 navLinks: false,
	                 editable: false,
	                 resizeable: false,
	                 defaultView: 'listWeek',
	                 height: 245,
	              
	                 events: function(start, end, timezone, callback) {

			    				$.ajax({
			    					
			    					url : "${pageContext.request.contextPath}/calendar/selectAllList.do",
			    					method : "GET",
			    					contentType : "application/json; charset=utf-8",
			    					dataType : "json",
			    					success : function(response) {
				    					
			    						  var fixedDate = response.map(function (array) {
											
											if(array.allDay == '1'){
												array.allDay = true;
											} else {
												array.allDay = false;
											} 
											
			    							return array;
			    						 });
			    						
			    						callback(fixedDate);
			    					}
		    				});

		                 
	               } //End of options
	               
	             });// calendar end
		});

			function printTime() {
				
				var clock = document.getElementById("clock");
				var now = new Date();

				clock.innerHTML = now.getFullYear() + "년 " +
				(now.getMonth()+1) + "월 " +
				now.getDate() + "일 " +
				now.getHours() + "시 " +
				now.getMinutes() + "분 " +
				now.getSeconds() + "초";

				setTimeout("printTime()", 1000);
				
			}

		

		$(document).ready(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/board/getBoardTopFive",
				method : "GET",
				contentType : "application/json; charset=utf-8",
				success : function(response){
					console.log('resposne',response);

					var str = '<table class="table table-hover text-center">';
					for(var i = 0; i < response.length; i++){
						str += '<tr>';
						str += '<td class="text-left" style="max-width: 100px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">';
						str += '<a>' + response[i].title + '</a></td>';
						str += '</tr>';
					}
					str += "</table>";	
					$('#manin_board').html(str);
				}
			});
		});
		
		$(document).ready(function(){

			var now = new Date();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/cost/selectAllCost.do?date="+ now.getFullYear() + (now.getMonth()+1),
				method : "GET",
				contentType : "application/json; charset=utf-8",
				success : function(response) {
					console.log('불러오기 성공');
					console.log('response',response);

					var pay1 = 0; var pay2 = 0; var pay3 = 0; var pay4 = 0; var pay5 = 0; var sum = 0;

					for(var i = 0; i< response.length; i++){
						pay1 += response[i].transportationCosts;
						pay2 += response[i].businessCosts;
						pay3 += response[i].gasCosts;
						pay4 += response[i].fitment;
						pay5 += response[i].mealCosts;

						sum += pay1 + pay2 + pay3 + pay4 + pay5;
					}

					console.log('교통비',pay1);
					console.log('출장비',pay2);
					console.log('주유비',pay3);
					console.log('사무비품',pay4);
					console.log('식대',pay5);

					  // Load the Visualization API and the corechart package.
				      google.charts.load('current', {'packages':['corechart']});

				      // Set a callback to run when the Google Visualization API is loaded.
				      google.charts.setOnLoadCallback(drawChart);

				      // Callback that creates and populates a data table,
				      // instantiates the pie chart, passes in the data and
				      // draws it.
				      function drawChart() {

				        // Create the data table.
				        var data = new google.visualization.DataTable();
				        data.addColumn('string', 'Cost');
				        data.addColumn('number', 'Slices');
				        data.addRows([
				          ['교통비', pay1],
				          ['출장비', pay2],
				          ['주유비', pay3],
				          ['사무비품', pay4],
				          ['식대', pay5]
				        ]);

				        // Set chart options
				        var options = {'title':'한달 지출 총계',
				                       'width':500,
				                       'height':500};

				        // Instantiate and draw our chart, passing in some options.
				        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
				        chart.draw(data, options);
				      }

				}
		     });
		});

		$(document).ready(function() {
			
			var now = new Date();
			
			var msg = { memberId : "${ loginMember.memberId }",
						date : now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate() }

			console.log('msg',msg);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/calendar/getTodayCount",
				method : "POST",
				data : msg,
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				success: function(response){
					console.log(response);
					$('#calCount3').text(response);
				},
				error : function(xhr,status,err){
					console.log("처리 실패");
					console.log(xhr);
					console.log(status);
					console.log(err);
				}
			});
		});		

		$(document).ready(function() {
			
			var now = new Date();
			
			var msg = { date : now.getFullYear() + "" + (now.getMonth() + 1) + "" + now.getDate() }

			console.log('msg getTodayAttend',msg);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/attend/getTodayAttend",
				method : "POST",
				data : msg,
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				success: function(response){
					console.log(response);
					$('#mainleftVacat').text(response);
				},
				error : function(xhr,status,err){
					console.log("처리 실패");
					console.log(xhr);
					console.log(status);
					console.log(err);
				}
			});
		});		
		

		$(document).ready(function() {

			$('#expenditure').on('click',function(){
					
					var costForm = $('#costForm');
				
					var memberId = ${loginMember.memberId};
					
					var transportationCosts = $('#transportationCosts');
					var fitment = $('#fitment');
					var businessCosts = $('#businessCosts');
					var mealCosts = $('#mealCosts');
					var gasCosts = $('#gasCosts');
					var expenditureDate = $('#expenditureDate');
		
						var costData = {
							memberId : memberId,
							transportationCosts : transportationCosts.val(),
							fitment : fitment.val(),
							businessCosts : businessCosts.val(),
							mealCosts : mealCosts.val(),
							gasCosts : gasCosts.val(),
							expenditureDate : expenditureDate.val()
						};
		
						console.log('costData',costData);
		
						if(costData.transportationCosts == '' &&
						   costData.fitment == '' &&
						   costData.businessCosts == '' &&
						   costData.mealCosts == '' &&
						   costData.gasCosts == ''){
		
							alert('금액을 한개 이상 적으십시오.');
							return false;
						}
		
						if (costData.expenditureDate == '') {
							alert('날짜는 필수입니다.');
							return false;
						}

						console.log(typeof(costData.expenditureDate));

						/* if (expenditureDate.val() != '/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/'){
							alert('형식에 맞는 날짜를 쓰세요.');
							return false;
						} */
		
						costForm.find('input').val('');
		
						$.ajax({
							url : "${pageContext.request.contextPath}/cost/enrollCost.do",
							method : "POST",
							contentType : "application/json; charset=utf-8",
							data : JSON.stringify(costData),
							dataType : "json",
							success : function(data) {
								console.log("처리 성공");
								alert('등록 성공');
								location.reload();
							},
							error : function(xhr, status, err) {
								console.log("처리 실패");
								console.log(xhr);
								console.log(status);
								console.log(err);
							}
						});
			});
		})


</script>

</head>

<body id="page-top">

	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">

		<!-- Main Content -->
		<div id="content">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- Page Heading -->
				<div
					class="d-sm-flex align-items-center justify-content-between mb-4">
					<h2 class="h3 mb-0 text-gray-800">환영합니다 ${ loginMember.name }님!</h2>
				</div>

				<!-- Content Row -->
				<div class="row">

					<!-- Earnings (Monthly) Card Example -->
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-primary shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">결재대기중 문서</div>
										<div class="h5 mb-0 font-weight-bold text-gray-800">
											(<span id="apvCount4">0</span>)
										</div>
									</div>
									<div class="col-auto">
										<i class="fas fa-pen-nib fa-2x text-gray-300"></i>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Earnings (Monthly) Card Example -->
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-success shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div
											class="text-xs font-weight-bold text-success text-uppercase mb-1">미확인
											메일</div>
										<div class="h5 mb-0 font-weight-bold text-gray-800">
											(<span id="main_email_count">0</span>)
										</div>
									</div>
									<div class="col-auto">
										<!-- <i class="fas fa-dollar-sign fa-2x text-gray-300"></i> -->
										<i class="fas fa-envelope fa-2x text-gray-300"></i>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Earnings (Monthly) Card Example -->
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-info shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div
											class="text-xs font-weight-bold text-info text-uppercase mb-1">나의 오늘 일정</div>
										<div class="row no-gutters align-items-center">
											<div class="col-auto">
												<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
													(<span id="calCount3"></span>)
												</div>
											</div>

										</div>
									</div>
									<div class="col-auto"></div>
								</div>
							</div>
						</div>
					</div>



					<!-- Pending Requests Card Example -->
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-warning shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div
											class="text-xs font-weight-bold text-warning text-uppercase mb-1">오늘 출근한 직원 수</div>

										<div class="h5 mb-0 font-weight-bold text-gray-800">
											(<span id="mainleftVacat">0</span>명)
										</div>
									</div>
									<div class="col-auto">
										<i class="fas fa-paper-plane fa-2x text-gray-300"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Content Row -->

				<div class="row">
					<!-- 1번카드 공지사항  -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- 1번 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">공지사항(최신 5개)</h6>
								<div class="dropdown no-arrow">
									<a class="dropdown-toggle" href="#" role="button"
										id="dropdownMenuLink" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="false"> <i
										class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
									</a>
									<div
										class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
										aria-labelledby="dropdownMenuLink">
										<div class="dropdown-header">게시판:</div>
										<a class="dropdown-item"
											href="${pageContext.request.contextPath}/boardList?bgno=2">공지사항으로</a>
										<a class="dropdown-item"
											href="${pageContext.request.contextPath}/boardList?bgno=1">자유게시판으로</a>

									</div>
								</div>
							</div>
							<!-- Card Body -->
							<div id="manin_board" class="card-body"></div>
						</div>
					</div>


					<!-- 2번카드 일정관리  -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- 1번 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">주간일정</h6>
								<div class="dropdown no-arrow">
									<a class="dropdown-toggle" href="#" role="button"
										id="dropdownMenuLink" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="false"> <i
										class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
									</a>
									<div
										class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
										aria-labelledby="dropdownMenuLink">
										<div class="dropdown-header">일정관리:</div>
										<a class="dropdown-item"
											href="${pageContext.request.contextPath}/calendar/calendar.do">월간일정확인</a>
									</div>
								</div>
							</div>
							<!-- Card Body -->
							<div class="card-body">

								<!-- The calendar container -->
								<div id="calendar"></div>

							</div>
						</div>
					</div>


					<!-- 3번카드 근태관리 -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- 출결버튼 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">출결확인</h6>
								<div class="dropdown no-arrow">
									<a class="dropdown-toggle" href="#" role="button"
										id="dropdownMenuLink" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="false"> <i
										class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
									</a>
									<div
										class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
										aria-labelledby="dropdownMenuLink">
										<div class="dropdown-header">근태 관련:</div>
										<a class="dropdown-item"
											href="${pageContext.request.contextPath}/commuting/commuting">월간
											근태확인</a>

									</div>
								</div>
							</div>
							<!-- Card Body -->
							<div class="card-body">

								<div class="timecheck">
									<div class="card bg-primary text-white shadow">
										<div class="card-body">
											<div align="center" id="current_time">
												<span id="clock"></span>
											</div>
											<div class="text-white-50 small" align="center">대한민국
												GMT+9</div>
										</div>
									</div>
								</div>

								<input type="hidden" id="commuting_member_id"
									value="${sessionScope.member.member_id}" />

								<div class="timecheck">
									<div id="arrive" style="width: 100%;"
										class="card bg-info text-white shadow btn-outline-info">
										<div class="card-body" align="center" style="cursor: pointer;"
											id="arrTime">
											출근체크
											<div class="text-white-50 small" align="center">9시 이전에
												체크해주세요!</div>
										</div>
									</div>
								</div>

								<div class="timecheck">
									<div id="leave" style="width: 100%;"
										class="card bg-warning text-white shadow btn-outline-warning">
										<div class="card-body" align="center" style="cursor: pointer;"
											id="leavTime">
											퇴근체크
											<div class="text-white-50 small" align="center">6시 이후에
												체크해주세요!</div>
										</div>
									</div>
								</div>


							</div>
						</div>
					</div>
				</div>

				<div class="row">

					<!-- 근무차트 -->
					<div class="col-xl-8 col-lg-7">
						<div class="card shadow mb-4">
							<!-- 공지사항으로 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">개인 지출 작성</h6>
								<div class="dropdown no-arrow"></div>
							</div>
							<!-- 근무차트바디 -->
							<div class="card-body" id="costForm">
								<div class="row" style="height: 80px;">
									<div class="col-6 input-group"
										style="height: 40px; margin: 0 auto;">
										<div class="input-group-prepend">
											<span class="input-group-text" style="width: 100px;">교통비</span>
										</div>
										<input type="text" class="form-control" id="transportationCosts" placeholder="금액을 입력하세요." aria-label="Username"aria-describedby="basic-addon1" style="height: 40px;">
									</div>
									<div class="col-6 input-group"
										style="height: 40px; margin: 0 auto;">
										<div class="input-group-prepend">
											<span class="input-group-text" style="width: 100px;">사무비품</span>
										</div>
										<input type="text" class="form-control" id="fitment" placeholder="금액을 입력하세요." aria-label="Username" aria-describedby="basic-addon1" style="height: 40px;">
									</div>
								</div>
								<div class="row" style="height: 80px;">
									<div class="col-6 input-group"
										style="height: 40px; margin: 0 auto;">
										<div class="input-group-prepend">
											<span class="input-group-text"style="width: 100px;">출장비</span>
										</div>
										<input type="text" class="form-control" id="businessCosts" placeholder="금액을 입력하세요." aria-label="Username" aria-describedby="basic-addon1" style="height: 40px;">
									</div>
									<div class="col-6 input-group"
										style="height: 40px; margin: 0 auto;">
										<div class="input-group-prepend">
											<span class="input-group-text" style="width: 100px;">식대</span>
										</div>
										<input type="text" class="form-control" id="mealCosts" placeholder="금액을 입력하세요." aria-label="Username" aria-describedby="basic-addon1" style="height: 40px;">
									</div>
								</div>
								<div class="row" style="height: 80px;">
									<div class="col-6 input-group"
										style="height: 40px; margin: 0 auto;">
										<div class="input-group-prepend">
											<span class="input-group-text" style="width: 100px;">주유비</span>
										</div>
										<input type="text" class="form-control" id="gasCosts" placeholder="금액을 입력하세요." aria-label="Username" aria-describedby="basic-addon1" style="height: 40px;">
									</div>
									<div class="col-6 input-group"
										style="height: 40px; margin: 0 auto;">
										<div class="input-group-prepend">
											<span class="input-group-text" style="width: 100px;">날짜</span>
										</div>
										<input type="text" class="form-control" id="expenditureDate" placeholder="yyyy-MM-dd형식으로 입력." aria-label="Username" aria-describedby="basic-addon1" style="height: 40px;">
									</div>
								</div>
								<hr>
								<code>올바르게 기입하였는지 확인하십시오.</code>
								<button type="button" class="btn btn-primary float-right"
									id="expenditure">확인</button>
							</div>
						</div>
					</div>

					<!-- 지출차트 -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4" style="overflow: hidden;">
							<!-- 지출차트상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">지출 통계</h6>

							</div>
							<!-- 지출차트바디 -->
							<div class="card-body">

								<div id="chart_div"></div>

							</div>

						</div>


					</div>

				</div>

				<!-- 두번째줄 끈 -->

				<div class="row">


					<!-- 지도  -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- 1번 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">회사 위치</h6>

							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div id="map" style="width: 100%; height: 280px;"></div>
								<script type="text/javascript"
									src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1bc0b6d59d803571ab98d0e956490217"></script>
								<script>
// 지도 만들기 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
		center: new kakao.maps.LatLng(37.279643, 127.072610),
	    level: 3 // 지도의 확대 레벨
	};

var map = new kakao.maps.Map(mapContainer, mapOption);

//마커를 표시할 위치입니다 
var position =  new kakao.maps.LatLng(37.279643, 127.072610);

var imageSrc = "${pageContext.request.contextPath}/resources/images/favicon/favicon.ico", // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(15, 70)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    markerPosition = new kakao.maps.LatLng(37.279643, 127.072610); // 마커가 표시될 위치입니다

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
	position : markerPosition,
	image : markerImage// 마커이미지 설정 
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var content = '<div class="customoverlay">' +
			  '<a href="" target="_blank">' +
			  '<span class="title">Lemon Biz</span>' +
			  '</a>' +
			  '</div>';

//커스텀 오버레이가 표시될 위치입니다 
var position = new kakao.maps.LatLng(37.279643, 127.072610);

//커스텀 오버레이를 생성합니다
var customOverlay = new kakao.maps.CustomOverlay({
    map: map,
    position: position,
    content: content,
    yAnchor: 1 
});

//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();

//지도에 컨트롤을 추가해야 지도위에 표시됩니다
//kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
</script>

							</div>
						</div>
					</div>


					<!-- SNS  -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- 1번 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">LEMONBIZ의 SNS</h6>

							</div>
							<!-- Card Body -->
							<div class="card-body">

								<p>
									LEMONBIZ의 <a
										href="https://www.facebook.com/GoogleKorea/?brand_redir=104958162837">페이스북</a>을
									팔로우하고 사장님의 예쁨을 받으세요!
								</p>
								<p class="mb-0">
									또한 회사의 소개 영상을 보여주는 <a
										href="https://www.youtube.com/watch?v=ApXoWvfEYVU">유튜브</a>를
									응원해주세요.
								</p>

							</div>
						</div>
					</div>

					<!-- 로고 -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- 출결버튼 상단바 -->
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">THE LEMONBIZ</h6>

							</div>
							<!-- Card Body -->
							<div class="card-body"
								style="background-color: #eaf8ff !important">
								<div align="center">
									<img id="file_img"
										src="${pageContext.request.contextPath}/resources/images/favicon/lemonBiz.jpg"
										alt="사진" height=260>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- 컨텐츠플루이드 -->

		</div>
		<!-- End of Main Content -->

	</div>
	<!-- End of Content Wrapper -->

</body>

</html>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
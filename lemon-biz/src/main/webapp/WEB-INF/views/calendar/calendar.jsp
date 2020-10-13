<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>FullCalendar Example</title>


<link rel=" shortcut icon" href="image/favicon.ico">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/css/fullcalendar.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/css/bootstrap.min.css">
<link rel="stylesheet"
	href='${pageContext.request.contextPath}/resources/vendor/css/select2.min.css' />
<link rel="stylesheet"
	href='${pageContext.request.contextPath}/resources/vendor/css/bootstrap-datetimepicker.min.css' />

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">

</head>

<body>
	<div class="container">

		<!-- 일자 클릭시 메뉴오픈 -->
		<div id="contextMenu" class="dropdown clearfix">
			<ul class="dropdown-menu dropNewEvent" role="menu"
				aria-labelledby="dropdownMenu"
				style="display: block; position: static; margin-bottom: 5px;">
				<li><a tabindex="-1" href="#">카테고리1</a></li>
				<li><a tabindex="-1" href="#">카테고리2</a></li>
				<li><a tabindex="-1" href="#">카테고리3</a></li>
				<li><a tabindex="-1" href="#">카테고리4</a></li>
				<li class="divider"></li>
				<li><a tabindex="-1" href="#" data-role="close">Close</a></li>
			</ul>
		</div>

		<div id="wrapper">
			<div id="loading"></div>
			<div id="calendar"></div>
		</div>


		<!-- 일정 추가 MODAL -->
		<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">

						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-allDay">하루종일</label> <input
									class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
							</div>
						</div>

						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-title">일정명</label> <input
									class="inputModal" type="text" name="edit-title"
									id="edit-title" required="required" />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-start">시작</label> <input
									class="inputModal" type="text" name="edit-start"
									id="edit-start" />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-end">끝</label> <input
									class="inputModal" type="text" name="edit-end" id="edit-end" />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-type">구분</label> <select
									class="inputModal" type="text" name="edit-type" id="edit-type">
									<option value="카테고리1">카테고리1</option>
									<option value="카테고리2">카테고리2</option>
									<option value="카테고리3">카테고리3</option>
									<option value="카테고리4">카테고리4</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-color">색상</label> <select
									class="inputModal" name="color" id="edit-color">
									<option value="#D25565" style="color: #D25565;">빨간색</option>
									<option value="#9775fa" style="color: #9775fa;">보라색</option>
									<option value="#ffa94d" style="color: #ffa94d;">주황색</option>
									<option value="#74c0fc" style="color: #74c0fc;">파란색</option>
									<option value="#f06595" style="color: #f06595;">핑크색</option>
									<option value="#63e6be" style="color: #63e6be;">연두색</option>
									<option value="#a9e34b" style="color: #a9e34b;">초록색</option>
									<option value="#4d638c" style="color: #4d638c;">남색</option>
									<option value="#495057" style="color: #495057;">검정색</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="edit-desc">설명</label>
								<textarea rows="4" cols="50" class="inputModal" name="edit-desc"
									id="edit-desc"></textarea>
							</div>
						</div>
					</div>
					<div class="modal-footer modalBtnContainer-addEvent">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="save-event">저장</button>
					</div>
					<div class="modal-footer modalBtnContainer-modifyEvent">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
						<button type="button" class="btn btn-primary" id="updateEvent">저장</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

		<div class="panel panel-default">

			<div class="panel-heading">
				<h3 class="panel-title">필터</h3>
			</div>

			<div class="panel-body">

				<div class="col-lg-6">
					<label for="calendar_view">구분별</label>
					<div class="input-group">
						<select class="filter" id="type_filter" multiple="multiple">
							<option value="카테고리1">카테고리1</option>
							<option value="카테고리2">카테고리2</option>
							<option value="카테고리3">카테고리3</option>
							<option value="카테고리4">카테고리4</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<!-- /.filter panel -->
	</div>
	<!-- /.container -->

	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/moment.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/fullcalendar.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/ko.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/select2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/js/bootstrap-datetimepicker.min.js"></script>

	<script>

    
    var draggedEventIsAllDay;
    var activeInactiveWeekends = true;

    var calendar = $('#calendar').fullCalendar({

      locale                    : 'ko',    
      timezone                  : "local", 
      nextDayThreshold          : "09:00:00",
      allDaySlot                : true,
      displayEventTime          : true,
      displayEventEnd           : true,
      firstDay                  : 0, 
      weekNumbers               : false,
      selectable                : true,
      weekNumberCalculation     : "ISO",
      eventLimit                : true,
      views                     : { 
                                    month : { eventLimit : 12 }
                                  },
      eventLimitClick           : 'week',
      navLinks                  : true,
      defaultDate               : moment('2019-05'),
      timeFormat                : 'HH:mm',
      defaultTimedEventDuration : '01:00:00',
      editable                  : true,
      minTime                   : '00:00:00',
      maxTime                   : '24:00:00',
      slotLabelFormat           : 'HH:mm',
      weekends                  : true,
      nowIndicator              : true,
      dayPopoverFormat          : 'MM/DD dddd',
      longPressDelay            : 0,
      eventLongPressDelay       : 0,
      selectLongPressDelay      : 0,  
      header                    : {
                                    left   : 'today, prevYear, nextYear, viewWeekends',
                                    center : 'prev, title, next',
                                    right  : 'month, agendaWeek, agendaDay, listWeek'
                                  },
      views                     : {
                                    month : {
                                      columnFormat : 'dddd'
                                    },
                                    agendaWeek : {
                                      columnFormat : 'M/D ddd',
                                      titleFormat  : 'YYYY년 M월 D일',
                                      eventLimit   : false
                                    },
                                    agendaDay : {
                                      columnFormat : 'dddd',
                                      eventLimit   : false
                                    },
                                    listWeek : {
                                      columnFormat : ''
                                    }
                                  },
                                  
	customButtons              : {
								viewWeekends : {
									text : '주말',
									click : function() {
										activeInactiveWeekends ? activeInactiveWeekends = false
												: activeInactiveWeekends = true;
										$('#calendar').fullCalendar('option', {
											weekends : activeInactiveWeekends
										});
									}
								}
							},
							eventRender : function(event , element , view){

								return true;
							},
							
	events                     : 

		function(start, end, timezone, callback) {
			console.log("list불러오기");
			console.log(start);
			console.log(end);
			console.log(timezone);
			console.log(callback);

			$.ajax({
				
				url : "${pageContext.request.contextPath}/calendar/selectAllList.do",
				method : "GET",
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(response) {
					console.log(response);
					var fixedDate = response.map(function (array) {
						
						/* if (array.allDay == '1' && array.start !== array.end) {
							console.log('allDay가 1이면서~~~~~~~');
							array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
					  	} */
					  	
						return array;
					});
					
				callback(fixedDate);
				}
			});
	},
	
	select : function(startDate, endDate, jsEvent, view) {

								$(".fc-body").unbind('click');
								$(".fc-body").on('click','td',function(e) {

									$("#contextMenu").addClass("contextOpened").css({
										display : "block",
										left : e.pageX,
										top : e.pageY
									});
									return false;
								});

								var today = moment();

								if (view.name == "month") {
									startDate.set({
										hours : today.hours(),
										minute : today.minutes()
									});

									startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
									endDate = moment(endDate).subtract(1,'days');

									endDate.set({
										hours : today.hours() + 1,
										minute : today.minutes()
									});
									
									endDate = moment(endDate).format('YYYY-MM-DD HH:mm');

									console.log("startDate",startDate);
									console.log("endDate",endDate);
									
								} else {
									startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
									endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
								}

								//날짜 클릭시 카테고리 선택메뉴
								var $contextMenu = $("#contextMenu");
								$contextMenu.on("click", "a", function(e) {
									e.preventDefault();

									//닫기 버튼이 아닐때
									if ($(this).data().role !== 'close') {
										newEvent(startDate, endDate, $(this).html());
									}

									$contextMenu.removeClass("contextOpened");
									$contextMenu.hide();
								});

								$('body').on('click', function() {
									$contextMenu.removeClass("contextOpened");
									$contextMenu.hide();
								});

		},
		
		eventClick : function(event , jsEvent, view){
			console.log('저장 시작');
			editEvent(event);
			console.log('저장 끝');
		}

	});

		var eventModal = $('#eventModal');

		var modalTitle = $('.modal-title');
		var editAllDay = $('#edit-allDay');
		var editTitle = $('#edit-title');
		var editStart = $('#edit-start');
		var editEnd = $('#edit-end');
		var editType = $('#edit-type');
		var editColor = $('#edit-color');
		var editDesc = $('#edit-desc');

		var addBtnContainer = $('.modalBtnContainer-addEvent');
		var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');

		/* ****************
		 *  새로운 일정 생성
		 * ************** */
		var newEvent = function(start, end, eventType) {

			$("#contextMenu").hide(); 

			modalTitle.html('새로운 일정');
			editType.val(eventType).prop('selected', true);
			editTitle.val('');
			editStart.val(start);
			editEnd.val(end);
			editDesc.val('');

			addBtnContainer.show();
			modifyBtnContainer.hide();
			eventModal.modal('show');

			//새로운 일정 저장버튼 클릭
			$('#save-event').unbind();
			$('#save-event').on('click',function() {

								var eventData = {
									title : editTitle.val(),
									startDate : editStart.val(),
									endDate : editEnd.val(),
									content : editDesc.val(),
									type : editType.val(),
									color : editColor.val(),
									allDay : editAllDay.is(':checked') ? '1' : '0'
								};

								console.log(eventData);

								if (eventData.start > eventData.end) {
									alert('끝나는 날짜가 앞설 수 없습니다.');
									return false;
								}

								if (eventData.title === '') {
									alert('일정명은 필수입니다.');
									return false;
								}

								var realEndDay;

								console.log('체크확인',editAllDay.is(':checked'));

								if (editAllDay.is(':checked')) {
									console.log('eventData.start1',eventData.startDate);
									eventData.startDate = moment(eventData.startDate).format('YYYY-MM-DD');
									console.log('eventData.start2',eventData.startDate);
									//render시 날짜표기수정
									eventData.endDate = moment(eventData.endDate).add(1, 'days').format('YYYY-MM-DD');
									eventData.allDay = '1'; //true
								}

								//$("#calendar").fullCalendar('renderEvent',eventData, true);
								eventModal.find('input, textarea').val('');
								editAllDay.prop('checked', false);
								eventModal.modal('hide');

								//새로운 일정 저장
								$.ajax({
										url : "${pageContext.request.contextPath}/calendar/enrollCalendar.do",
										method : "POST",
										contentType : "application/json; charset=utf-8",
										data : JSON.stringify(eventData),
										dataType : "json",
										success : function(data) {
											console.log(data);
											alert(data.msg);
										},
										error : function(xhr, status, err) {
											console.log("처리 실패");
											console.log(xhr);
											console.log(status);
											console.log(err);
										}

								});
							});
		};

		var editEvent = function(event, element, view){

			console.log(event);
			console.log('element' + element);
			console.log('view' + view);
			
			$('#deleteEvent').data('id', event.CALENDAR_ID);

			$('.popover.fade.top').remove();
		    $(element).popover("hide");

		    if (event.allDay === true) {
		        editAllDay.prop('checked', true);
		    } else {
		        editAllDay.prop('checked', false);
		    }

		    /* if (event.end === null) {
		        event.end = event.start;
		    } */

		    modalTitle.html('일정 수정');
		    editTitle.val(event.title);
		    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
		    editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
		    editType.val(event.type);
		    editDesc.val(event.description);
		    editColor.val(event.backgroundColor).css('color', event.backgroundColor);

		    addBtnContainer.hide();
		    modifyBtnContainer.show();
		    eventModal.modal('show');

		    //업데이트 버튼 클릭시
		    $('#updateEvent').unbind();
		    $('#updateEvent').on('click',function(){

			    console.log(editStart.val());
			    console.log(editEnd.val());
			    console.log(editAllDay.val());			    

		    	if (editStart.val() > editEnd.val()) {
		            alert('끝나는 날짜가 앞설 수 없습니다.');
		            return false;
		        }

		    	 if (editTitle.val() === '') {
		             alert('일정명은 필수입니다.')
		             return false;
		         }

		    	/*  var statusAllDay;
		         var startDate;
		         var endDate;
		         var displayDate;

		         if (editAllDay.is(':checked')) {
		             statusAllDay = true;
		             startDate = moment(editStart.val()).format('YYYY-MM-DD');
		             endDate = moment(editEnd.val()).format('YYYY-MM-DD');
		             displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
		         } else {
		             statusAllDay = false;
		             startDate = editStart.val();
		             endDate = editEnd.val();
		             displayDate = endDate;
		         } */

		         eventModal.modal('hide');

		         var editData = {
					 no : event.CALENDAR_ID,
			         allDay : editAllDay.is(':checked') ? '1' : '0',
			         title : editTitle.val(),
			         startDate : editStart.val(),
			         endDate : moment(editEnd.val()).format('YYYY-MM-DD'),
			         type : editType.val(),
			         color : editColor.val(),
			         content : editDesc.val()

		         };

		         $.ajax({
		             url: "${pageContext.request.contextPath}/calendar/updateCalendar.do",
		             type: "POST",
		             contentType : "application/json; charset=utf-8",
					 data : JSON.stringify(editData),
					 dataType : "json",
					 success : function(data) {
						console.log(data);
						alert(data.msg);
					 },
					 error : function(xhr, status, err) {
						console.log("처리 실패");
						console.log(xhr);
						console.log(status);
						console.log(err);
					 }
		         });
			});
		    
		};

		$('#deleteEvent').on('click',function(){
			
		
			$('#deleteEvent').unbind();
			eventModal.modal('hide');

			console.log($(this).data('id'));

			var no = $(this).data('id');
			
			$.ajax({
				url: "${pageContext.request.contextPath}/calendar/deleteCalendar.do/" + no,
				method: "DELETE",
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
		});
	</script>
</body>

</html>
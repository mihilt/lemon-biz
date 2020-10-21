<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

	<div class="container">

		<!-- 일자 클릭시 메뉴오픈 -->
		<div class="dropdown-menu" id="contextMenu">
		<c:if test="${ loginMember.isManager eq 1 }">
		  <a class="dropdown-item" href="#">카테고리1</a>
		  <a class="dropdown-item" href="#">카테고리2</a>
		  <a class="dropdown-item" href="#">카테고리3</a>
		  <a class="dropdown-item" href="#">카테고리4</a>
		  <a class="dropdown-item" href="#">회사일정</a>
		  <div class="dropdown-divider"></div>
		  <a class="dropdown-item" href="#" data-role="close">Close</a>	
		</c:if>
		<c:if test="${ loginMember.isManager eq 0 }">
		  <a class="dropdown-item" href="#">카테고리1</a>
		  <a class="dropdown-item" href="#">카테고리2</a>
		  <a class="dropdown-item" href="#">카테고리3</a>
		  <a class="dropdown-item" href="#">카테고리4</a>
		  <div class="dropdown-divider"></div>
		  <a class="dropdown-item" href="#" data-role="close">Close</a>	
		</c:if>
		</div>

		<div id="wrapper">
			<div id="loading"></div>
			<div id="calendar"></div>
		</div>
		
		<div class="modal fade" id="eventModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-allDay">하루종일</label> 
								<input class='allDayNewEvent' id="edit-allDay" type="checkbox" />
								<input type="hidden" name="userId" id="userId" value="${loginMember.getMemberId()}">
							</div>
						</div>

						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-title">일정명</label> <input
									class="inputModal" type="text" name="edit-title"
									id="edit-title" required="required" />
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-start">시작</label> <input
									class="inputModal" type="text" name="edit-start"
									id="edit-start" />
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-end">끝</label> <input
									class="inputModal" type="text" name="edit-end" id="edit-end" />
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-type">구분</label>
								
								<c:if test="${ loginMember.isManager eq 1 }">
									<select class="inputModal" type="text" name="edit-type" id="edit-type">
										<option value="카테고리1">카테고리1</option>
										<option value="카테고리2">카테고리2</option>
										<option value="카테고리3">카테고리3</option>
										<option value="카테고리4">카테고리4</option>
										<option value="회사일정">회사일정</option>
									</select>	
								</c:if>
						
								<c:if test="${ loginMember.isManager eq 0 }">
									<select class="inputModal" type="text" name="edit-type" id="edit-type">
										<option value="카테고리1">카테고리1</option>
										<option value="카테고리2">카테고리2</option>
										<option value="카테고리3">카테고리3</option>
										<option value="카테고리4">카테고리4</option>
									</select>	
								</c:if>
								
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-color">색상</label>
								<select class="inputModal" name="color" id="edit-color">
									<option value="#007bff" class="text-primary">파랑색</option>
									<option value="#6c757d" class="text-secondary">회색</option>
									<option value="#28a745" class="text-success">초록색</option>
									<option value="#dc3545" class="text-danger">빨강색</option>
									<option value="#ffc107" class="text-warning">노란색</option>
									<option value="#17a2b8" class="text-info">청록색</option>
									<option value="#212529" class="text-body">검정색</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<label class="col-4" for="edit-desc">설명</label>
								<textarea rows="4" cols="50" class="inputModal" name="edit-desc"
									id="edit-desc"></textarea>
							</div>
						</div>
					</div>
					<div class="modal-footer">
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
				</div>
			</div>
		</div>

		<div class="panel panel-default">
	
			<div class="panel-heading">
				<h3 class="panel-title">필터</h3>
			</div>
	
			<div class="panel-body">
				<div class="col-lg-6">
					<label for="calendar_view">구분별</label>
					<div class="input-group">
						<select class="form-control" id="type_filter" multiple="multiple">
							<option value="카테고리1">카테고리1</option>
							<option value="카테고리2">카테고리2</option>
							<option value="카테고리3">카테고리3</option>
							<option value="카테고리4">카테고리4</option>
							<option value="회사일정">회사일정</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	<!-- /.filter panel -->
	
	</div>
	<style>
		#modal-content{
			width: 80%;
		}
	</style>

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
	      defaultDate               : moment(),
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
	    	eventRender                : 

	    		function(event,element,view){

	    			/* console.log('이벤트 호버');
	    			console.log('event',event);
	    			console.log('element',element);
	    			console.log('view',view); */

	    			element.popover(
	    	    	
	    	    		{
	    				title : $('<div />',{
	    					class : 'hoverHead',
	    					text  : event.title
	    					}).css({
	    						'background' : event.color,
	    						'color' : '#000000'
	    					}),
	    				content : $('<div />',{
	    					class : 'hoverBody'
	    					})
	    					.append('<p><strong>구분 : </strong>' + event.type + '</p>')
	    					.append('<p><strong>시간 : </strong>' + displayDate(event) + '</p>')
	    					.append('<div class="popoverContent"><strong>설명 : </strong>' + event.content + '</div>'),
	    				delay : {
	    					show : "800",
	    					hide : "50"
	    				},
	    				trigger : 'hover',
	    				placement : 'top',
	    				html : true,
	    				container : 'body'
	    				
	    				}
		    		);

	    			return filtering(event);
	    	
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
	    						console.log('불러오기 성공');
	    						console.log('response',response);
	    						  var fixedDate = response.map(function (array) {
									console.log('array',array);

									if(array.allDay == '1'){
										array.allDay = true;
									} else {
										array.allDay = false;
									} 
									
	    							return array;
	    						 });

		    					console.log("fixedDate",fixedDate);
	    						
	    						callback(fixedDate);
	    					}
	    				});
	    		},
	    		
	    eventDragStart                : 
	    			
	    			function (event, jsEvent, ui, view) {
	    		    	draggedEventIsAllDay = event.allDay;
	    		},

	    eventDrop                     :
	    			    
	    			function(event,delta,revertFunc,jsEvent,ui,view){
	    				$('.popover.fade.top').remove();

	    				console.log("event",event);

	    				console.log('view.type',view.type);

	    				if(view.type === 'agendaWeek' || view.type === 'agendaDay'){
	    					
	    					location.reload();
	    					return false;
	    				}

	    				var newDates = dargNdrop(event);

	    				console.log('newDates',newDates);

	    				$.ajax({
	    			    	url: "${pageContext.request.contextPath}/calendar/dragNdropCalendar.do",
	    			    	type: "POST",
	    			        contentType : "application/json; charset=utf-8",
	    					data : JSON.stringify(newDates),
	    					dataType : "json",
	    				 	success : function(data) {
	    						console.log(data);
	    						alert(data.msg);
	    						$('#calendar').fullCalendar('refetchEvents');
	    					 },
	    					error : function(xhr, status, err) {
	    						console.log("처리 실패");
	    						console.log(xhr);
	    						console.log(status);
	    						console.log(err);
	    					}
	    			    });

	    		}, 
	    		select                        : 
	    			function(startDate, endDate, jsEvent, view) {

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
	    										//일정 추가
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
	    			console.log('eventClick 시작');
	    			console.log('event',event);
	    			console.log('jsEvent',jsEvent);
	    			console.log('view',view);
		    		
	    			console.log('수정 시작');
	    			editEvent(event);
	    			console.log('수정 끝');
	    		}
	      					    	
		  });

	    var eventModal = $('#eventModal');

		var userId = $('#userId');
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

			/* 카테고리별 아이디 대입 */
			var selectId;
			if(editType.val() == '회사일정'){
				selectId = '';
			}else{
				selectId = userId.val();
			}

			//새로운 일정 저장버튼 클릭
			$('#save-event').unbind();
			$('#save-event').on('click',function() {

								var eventData = {
									memberId : selectId,
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
									eventData.startDate = moment(eventData.startDate).format('YYYY-MM-DD 00:00');
									console.log('eventData.start2',eventData.startDate);
									eventData.endDate = moment(eventData.endDate).add(1, 'days').format('YYYY-MM-DD 00:00');									
									
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
											$('#calendar').fullCalendar('refetchEvents');
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

			console.log('event',event);
			console.log('element' + element);
			console.log('view' + view);
			
			$('#deleteEvent').data('id', event.CALENDAR_ID);

			$('.popover.fade.top').remove();
		    $(element).popover("hide");

		    if (event.allDay == '1') {
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
		    editDesc.val(event.content);
		    editColor.val(event.color).css('color', event.color);

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

		         var startDate;
		         var endDate;

		         if (editAllDay.is(':checked')) {
		             startDate = moment(editStart.val()).format('YYYY-MM-DD 00:00');
		             endDate = moment(editEnd.val()).format('YYYY-MM-DD 00:00');
		             endDate = moment(endDate).add(1, 'days').format('YYYY-MM-DD 00:00');
		         } else {
		             startDate = editStart.val();
		             endDate = editEnd.val();
		         }

		         eventModal.modal('hide');

		         var editData = {
					 no : event.CALENDAR_ID,
			         allDay : editAllDay.is(':checked') ? '1' : '0',
			         title : editTitle.val(),
			         startDate : startDate,
			         endDate : endDate,
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
						$('#calendar').fullCalendar('refetchEvents');
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
			$("#calendar").fullCalendar('removeEvents', $(this).data('id'));
			eventModal.modal('hide');

			console.log($(this).data('id'));

			var no = $(this).data('id');
			
			$.ajax({
				url: "${pageContext.request.contextPath}/calendar/deleteCalendar.do/" + no,
				method: "DELETE",
				success: function(response){
					console.log(response);
					alert(response.msg);
					$('#calendar').fullCalendar('refetchEvents');
				},
				error : function(xhr,status,err){
					console.log("처리 실패");
					console.log(xhr);
					console.log(status);
					console.log(err);
				}
			});
		});

		function displayDate(event){

			var contentDate;

			if(event.allDay == '0'){
				contentDate = moment(event.startDate).format('HH:mm') + " ~ " + moment(event.endDate).format('HH:mm');
			} else {
				contentDate = "하루종일";
			}

			return contentDate;
		}

		function dargNdrop(event){

			var newDates = {
				no : '',
				startDate : '',
				endDate : ''
			}

			newDates.no = event.CALENDAR_ID;
			newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
		    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');

		    return newDates;
		}

		$('#edit-color').change(function () {
		    $(this).css('color', $(this).val());
		});

		$("#type_filter").select2({
		    placeholder: "선택..",
		    allowClear: true
		});

		$('#type_filter').on('select2:select', function (e) {
			console.log('---1---');
		    var data = e.params.data;
		    console.log(data);
		});

		$('.form-control').on('change', function (e) {
			console.log('---2---');
			console.log('e',e);
		    $('#calendar').fullCalendar('rerenderEvents');
		});

		function filtering(event) {
			  
			  console.log('filtering호출');
			  console.log('event',event);
			  var show_type = true;

			  var types = $('#type_filter').val();

			  if (types && types.length > 0) {
			    if (types[0] == "all") {
			      show_type = true;
			    } else {
			      show_type = types.indexOf(event.type) >= 0;
			    }
			  }
			  
			  return show_type;
	    }
	</script>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<style type="text/css">
.cal_top{
    text-align: center;
    font-size: 30px;
}
.cal{
    text-align: center; 
}
table.calendar{
    border: 1px solid black;
    display: inline-table;
    text-align: left;
}
table.calendar td{
    vertical-align: top;
    border: 1px solid skyblue;
    width: 100px;
}
</style>
	
	<!-- <년월일> -->
    <div class="cal_top">
        <a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit">&lt;</span></a>
        <span id="cal_top_year"></span>
        <span id="cal_top_month"></span>
        <a href="#" id="moveNextMonth"><span id="nextMonth" class="cal_tit">&gt;</span></a>
    </div>
    <div id="cal_tab" class="cal">
    </div>
 
<script>
    
    var today = null;
    var year = null;
    var month = null;
    var firstDay = null;
    var lastDay = null;
    var $tdDay = null;
    var $tdSche = null;
    var jsonData = null;
    $(document).ready(function() {
        drawCalendar();
        initDate();
        drawDays();
//        drawSche();
        $("#movePrevMonth").on("click", function(){movePrevMonth();});
        $("#moveNextMonth").on("click", function(){moveNextMonth();});
    });
    
    //캘린더형식 
    function drawCalendar(){
        var setTableHTML = "";
        setTableHTML+='<table class="calendar">';
        setTableHTML+='<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
        for(var i=0;i<6;i++){
            setTableHTML+='<tr height="100">';
            for(var j=0;j<7;j++){
                setTableHTML+='<td style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">';
                setTableHTML+='    <div class="cal-day"></div>';
                setTableHTML+='    <div class="cal-schedule"></div>'; //값
                setTableHTML+='</td>';
            }
            setTableHTML+='</tr>';
        }
        setTableHTML+='</table>';
        $("#cal_tab").html(setTableHTML);
    }
    
    //초기화
    function initDate(){
        $tdDay = $("td div.cal-day")
        $tdSche = $("td div.cal-schedule")
        dayCount = 0;
        today = new Date();
        year = today.getFullYear();
        month = today.getMonth()+1;
        if(month < 10){month = "0"+month;}
        firstDay = new Date(year,month-1,1);
        lastDay = new Date(year,month,0);
    }
/*
 setData();
        var dateMatch = null;
        for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
            
        }


*/
    //날짜표시
    function drawDays(){
        $("#cal_top_year").text(year);
        $("#cal_top_month").text(month);


        var yyyymm=year+""+month;
        

		
		
		var memId="${loginMember.memberId}";
		$.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/attend/selectCalAttend.do",
			dataType : "json",
			data: {
				memId :memId
			},
			dataType : "json",
		    success: function(data) {
		    	console.log("success");
			},
			error:function(request, status, error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		
		
        for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){

			if($tdDay.eq(i)){
				$tdDay.eq(i).text(++dayCount);
/* 				console.log(dayCount); */
 
				
					/* yyyymm=year+""+month+dayCount; */

			}

			
			
			if(true/* 요일이 같다면 실행하기 */){
				
//	           $tdSche.eq(i).text();    값가져오면 넣기
			}
			
			

            	
        }

        for(var i=0;i<42;i+=7){
            $tdDay.eq(i).css("color","red");
        }
        for(var i=6;i<42;i+=7){
            $tdDay.eq(i).css("color","blue");
        }

    }
    
    //이건잘됨
    function movePrevMonth(){
        month--;
        if(month<=0){
            month=12;
            year--;
        }
        if(month<10){
            month=String("0"+month);
        }
        getNewInfo();
        }
    
    function moveNextMonth(){
        month++;
        if(month>12){
            month=1;
            year++;
        }
        if(month<10){
            month=String("0"+month);
        }
        getNewInfo();
    }
    
    //정보갱신
    function getNewInfo(){
        for(var i=0;i<42;i++){
            $tdDay.eq(i).text("");
            $tdSche.eq(i).text("");
        }
        dayCount=0;
        firstDay = new Date(year,month-1,1);
        lastDay = new Date(year,month,0);
        drawDays();
        drawSche();
    }
    
    
    //[]test
    function setData(){
    	jsonData =
         {
            "2020":{
                "10":{
                    "17":"dddddd"
                }
    	,"09":{
        	"20":"zzzz"
            	}
    	,"10":{
        	"25":"ffff1"
            	}
    	,"10":{
        	"15":"fffffff2"
            	}
    	,"10":{
        	"5":"제ffff"
            	}
            }

        } 
    }

  //[]test
    function drawSche(){
        setData();
        var dateMatch = null;
        for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
            var txt = "";
            txt =jsonData[year];
            if(txt){
                txt = jsonData[year][month]; 		
                if(txt){
                    txt = jsonData[year][month][i];
                    dateMatch = firstDay.getDay() + i -1;
/*                     $tdSche.eq(dateMatch).text(txt); */
                }
            }
/*      alert(txt);   
      alert(i);		*/
        }
          
    }

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

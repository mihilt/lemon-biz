<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
<style type="text/css">
div.cal_top{
    text-align: center;
    font-size: 30px;
}
a.cal_tit{
color:orange;
}
div.cal{
    text-align: center; 
}
table.calendar{
    border: 1px solid orange;
    display: inline-table;
    text-align: left;
}
table.calendar td{
    vertical-align: top;
    border: 1px solid orange;
    width: 100px;
}
</style>
	<h1 id="h1-sumTime"></h1>
	<!-- <년월일> -->
    <div class="cal_top m-2 ">
        <a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit ">&lt;</span></a>
        <span id="cal_top_year" class="sp_cal_top text-warning"></span>
        <span id="cal_top_month" class="sp_cal_top text-warning"></span>
        <a href="#" id="moveNextMonth"><span id="nextMonth" class="cal_tit ">&gt;</span></a>
        <button id="btn-attendList" class="btn btn-outline-warning" type="button" onclick="attendList();">뒤로가기</button>
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
        $("#movePrevMonth").on("click", function(){movePrevMonth();});
        $("#moveNextMonth").on("click", function(){moveNextMonth();});
        
    });

    //페이지요청
    function drawCalendar(){
        var setTableHTML = "";
        setTableHTML+='<table class="calendar">';
        setTableHTML+='<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
        for(var i=0;i<6;i++){
            setTableHTML+='<tr height="100">';
            for(var j=0;j<7;j++){
                setTableHTML+='<td style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">';
                setTableHTML+='    <div class="cal-day"></div>';
                setTableHTML+='    <div class="cal-schedule alert-warning"></div>'; //값
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
/*		나중에지울것
 setData();
        var dateMatch = null;
        for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
            
        }


*/
    //일한시간 출력 +날짜표시
    function drawDays(){
        $("#cal_top_year").text(year);
        $("#cal_top_month").text(month);
        var calattend =null;

        var yyyymm=year+""+month;
		var memId="${loginMember.memberId}";
		$.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/attend/selectCalAttend.do",
			dataType : "json",
			data: {
				memId :memId,
				yyyymm :yyyymm
			},
			dataType : "json",
		    success: function(data) {
			    calattend =data;
		    	console.log(calattend);
		    	var j=0;
		    	var maxcal =calattend.length;
		    	for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
					
					if($tdDay.eq(i)){
						$tdDay.eq(i).text(++dayCount);
		 
						if(dayCount<10){
							var daycon="0"+dayCount;
							yyyymm=year+""+month+daycon;
							}
						else
						yyyymm=year+""+month+dayCount;
		 	 			if(j<maxcal && calattend[j].yyyymm==yyyymm){
						$tdSche.eq(i).text(calattend[j].time+"시간");
						j++;
		 	 			}
					}
		        }
			},
			error:function(request, status, error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
        /* for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
			var j=0;
			if($tdDay.eq(i)){
				$tdDay.eq(i).text(++dayCount);
 				console.log(dayCount);
 

				if(dayCount<10){
					var daycon="0"+dayCount;
					yyyymm=year+""+month+daycon;
					}
				yyyymm=year+""+month+dayCount;

	 			if(calattend[j].yyyymm==yyyymm){
			 	console.log(calattend[0].yyyymm); 
				j++;
	 			
	 	}           $tdSche.eq(i).text(calattend.time); 
			}

			 

            	
        } */

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
    }
    function attendList(){
    	location.href = "${pageContext.request.contextPath}/attend/attend.do";
    }
    
    
  /*   망한거 나중에 지울거
    []test
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
                    $tdSche.eq(dateMatch).text(txt); 
                }
            }
    alert(txt);   
      alert(i);		
        }
          
    } */

</script>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

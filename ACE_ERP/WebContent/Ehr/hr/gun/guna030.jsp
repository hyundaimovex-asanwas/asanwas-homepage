<!--
*****************************************************
* @source       : guna030.jsp
* @description : 근태휴일날짜등록 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>휴일등록</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    
    var nscp = (navigator.appName == "Netscape")


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
    	
          //검색조건 2가지

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem(yy, mm) {
        	
            var f = document.form1;
            var REG_Y = yy;
            var REG_M;

            if ( mm.length != "1" || mm.length != "2" ){
                mm = String(mm);
            }

            if ( mm.length == "1"){
                REG_M = "0"+mm;
            }else{
                REG_M = mm;
            }

            var REG_YMD = REG_Y+REG_M;
			if(!cfDateExpr(REG_YMD)){
				alert(REG_YMD + " 는 정상적인 날짜 타입이 아닙니다.\ 다시 입력하십시요");
				return false;
			}
            trT_DI_HOLIDAY.KeyValue = "JSP(O:DS_ONE=dsT_DI_HOLIDAY, O:DS_TWO=dsT_DI_HOLIDAY2)";
            trT_DI_HOLIDAY.Action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna030.cmd.GUNA030CMD&S_MODE=SHR&REG_YMD="+REG_YMD;
            trT_DI_HOLIDAY.post();

            if ( dsT_DI_HOLIDAY.CountRow != null || dsT_DI_HOLIDAY.CountRow != 0 || dsT_DI_HOLIDAY.CountRow != "0" )
            {
                var countRow        = dsT_DI_HOLIDAY.OrgValue(1,6);  // 한달중 주의 개수
                var start_day_num   = dsT_DI_HOLIDAY.OrgValue(1,5);  // 시작요일구분숫자(달력에서의 j의 차로 데이타셋의 row_num을 구해올 수 있다.)
                var k               = 8 - start_day_num;
                f.countRow.value    = countRow;
                f.dept.value        = start_day_num;
                f.hid_REG_YMD.value = REG_YMD;

                if ( countRow == 5 ) biz.style.display = "none";
                else                 biz.style.display = "";      // 6주포함 달일경우 마지막주 테이블 활성화

                if ( start_day_num == 7)
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = "";
                    cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = "";
                    cal6_1[0].innerText = ""; cal6_2[0].innerText = ""; cal6_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                else if ( start_day_num == 6 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = "";
                    cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7)
                }
                else if ( start_day_num == 5 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7)
                }
                else if ( start_day_num == 4 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                else if ( start_day_num == 3 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(5,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal3_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal3_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal3_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal3_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal3_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7)
                }
                else if ( start_day_num == 2 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(6,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(5,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);

                    cal3_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal3_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal3_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal3_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal3_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal2_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal2_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal2_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal2_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal2_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                else if ( start_day_num == 1 )
                {
                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(7,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(7,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(7,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(7,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(7,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(7,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(6,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(5,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7)

                    cal3_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal3_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal3_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal3_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal3_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);

                    cal2_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal2_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal2_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal2_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal2_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal1_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal1_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal1_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal1_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal1_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                for ( var i=1; i<countRow-1 ;i++ )
                {
                    k++;
                    cal1_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal1_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal1_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal1_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal1_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal2_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal2_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal2_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal2_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal2_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal3_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal3_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal3_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal3_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal3_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal4_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal4_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal4_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal4_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal4_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal5_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal5_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal5_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal5_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal5_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal6_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal6_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal6_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal6_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal6_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal7_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal7_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="평일"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal7_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal7_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal7_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                }
                k++;
                cal1_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal1_2[i].innerText = "";
                else cal1_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal1_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal1_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal1_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal2_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal2_2[i].innerText = "";
                else cal2_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal2_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal2_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal2_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal3_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal3_2[i].innerText = "";
                else cal3_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal3_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal3_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal3_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal4_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal4_2[i].innerText = "";
                else cal4_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal4_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal4_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal4_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal5_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal5_2[i].innerText = "";
                else cal5_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal5_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal5_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal5_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal6_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal6_2[i].innerText = "";
                else cal6_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal6_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal6_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal6_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal7_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "평일" )
                    cal7_2[i].innerText = "";
                else cal7_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal7_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal7_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal7_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                var pre_i = document.form1.i.value;      //전에 클릭햇던 날짜칸의 행과 열 번호
                var pre_j = document.form1.col_num.value;

                if ( pre_j == 1 ) td_index_1[pre_i].style.background = "white"; //전에 클릭햇던 날짜칸의 행과 열 번호를
                if ( pre_j == 2 ) td_index_2[pre_i].style.background = "white";
                if ( pre_j == 3 ) td_index_3[pre_i].style.background = "white";
                if ( pre_j == 4 ) td_index_4[pre_i].style.background = "white";
                if ( pre_j == 5 ) td_index_5[pre_i].style.background = "white";
                if ( pre_j == 6 ) td_index_6[pre_i].style.background = "white";
                if ( pre_j == 7 ) td_index_7[pre_i].style.background = "white";

                if ( document.form1.cmbREG_Y_SHR.length > 3 )
                {
                    for( var i = dsT_DI_HOLIDAY2.CountRow; i >= 0; i-- ) {
                        oOption       = document.createElement("OPTION");
                        oOption.value = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                        oOption.text  = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                        document.getElementById("cmbREG_Y_SHR").remove(oOption);
                    }
                }
                for( var i = 1; i <= dsT_DI_HOLIDAY2.CountRow; i++ ) {
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                    oOption.text  = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                    document.getElementById("cmbREG_Y_SHR").add(oOption);
			    }

                document.form1.txtREG_YMD_UPT.readOnly = true;
                document.form1.txtREG_YMD_UPT.className = "input_ReadOnly";
                document.form1.cmbHOL_GBN_UPT.disabled = true;
                document.form1.txtREMARK_UPT.disabled  = true;

                document.form1.hid_REG_YMD.value  = "";
                document.form1.row_num.value      = "";
                document.form1.col_num.value      = "";
                document.form1.dept.value         = "";
                document.form1.countRow.value     = "";
                document.form1.cmbREG_Y_SHR.value = REG_Y;
                document.form1.cmbREG_M_SHR.value = mm;
            }
        }

        /******************"
         * 03. 저장 함수  *
         ******************/

        function fnc_Save() {
        	
            var REG_YMD = document.form1.hid_REG_YMD.value;

            if(!fnc_SaveItemCheck()) return;

            trT_DI_HOLIDAY.KeyValue = "tr01(I:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY)";
            
            trT_DI_HOLIDAY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna030.cmd.GUNA030CMD&S_MODE=SAV&REG_YMD="+REG_YMD;
            
            trT_DI_HOLIDAY.post();


        }


        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

      // 엑셀로 변환 할 자료가 있는지 체크하고
      // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

      //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

      //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

      //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
            var yy = document.form1.cmbREG_Y_SHR.value;         // 전에 클릭했던 날짜칸의 행,열 번호
            var mm = document.form1.cmbREG_M_SHR.value;
            document.getElementById("txtREG_YMD_UPT").value = '';
            document.getElementById("cmbHOL_GBN_UPT").value = '평일';
            document.getElementById("txtREMARK_UPT").value  = '';
            document.getElementById("txtPIS_YY").value      = '';

            fnc_SearchItem(yy,mm);
//          dsT_DI_HOLIDAY.ClearAll();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_HOLIDAY.IsUpdated)  {

            if (!fnc_ExitQuestion()) return;

          }

          frame = window.external.GetFrame(window);
          frame.CloseFrame();

       }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

      //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_DI_HOLIDAY.IsUpdated) {
                alert("저장할 자료가 없습니다.");
//                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;
        }

        function fnc_SaveItemCheck_01() {

            if (!dsT_DI_HOLIDAY_INPUT.IsUpdated) {
                alert("저장할 자료가 없습니다.");
//                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var date = new Date();

            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var s_year  = String(year);
            var s_month = String(month);

            fnc_SearchItem(s_year,s_month);


         }

    /********************
         * 15. 단축키 처리  *
         *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }
    /********************
         * 15. 단축키 처리  *
         *******************/
    //일괄생성
    function fnc_CreateBatch() {
    	
        var REG_Y = document.form1.txtPIS_YY.value; //일괄처리년도


        if ( document.form1.txtPIS_YY.value == "" )
        {
            alert("일괄처리년도를 입력해 주십시오!");
            document.form1.txtPIS_YY.focus();
            return false;
        }

        if ( document.form1.txtPIS_YY.value.length != 4 )
        {
            alert("일괄처리년도가 잘못되었습니다!");
            document.form1.txtPIS_YY.value = "";
            document.form1.txtPIS_YY.focus();
            return false;
        }

        for ( var k = 1; k <= Number(dsT_DI_HOLIDAY2.CountRow); k++ )
        {
            if ( REG_Y == dsT_DI_HOLIDAY2.OrgValue(k,1) )
            {
                alert("이미 생성되어 있는 년도를 선택 하셨습니다. 다시 선택해 주십시오!");
                document.form1.txtPIS_YY.value = "";
                document.form1.txtPIS_YY.focus();
                return false;
            }
        }
        dsT_DI_HOLIDAY_INPUT.SetDataHeader("partno:STRING(3)");
        dsT_DI_HOLIDAY_INPUT.ImportData('22');
        dsT_DI_HOLIDAY_INPUT.ImportData('32');

        if(!fnc_SaveItemCheck_01()) return;

        trT_DI_HOLIDAY.KeyValue = "JSP(I:dsT_DI_HOLIDAY_INPUT=dsT_DI_HOLIDAY_INPUT)";
        trT_DI_HOLIDAY.Action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna030.cmd.GUNA030CMD&S_MODE=SAV_01&REG_Y="+REG_Y;
        trT_DI_HOLIDAY.post();


    }

    /********************
       * 16. 외
         *******************/

    /****** 구분(평일,토요일,휴일,특별휴일) select박스 선택시 달력에 입력 및 색 지정  ******/
    
    function fnc_HOL_GBN_bind(hol_gubun) {
    	
        var f = document.form1;
        var i = f.i.value;
        var col_num = f.col_num.value;
        var row_num = f.row_num.value;  // row_num

        if ( row_num != "" || row_num != null ){

            var gub_color;
            if      ( hol_gubun == "토요일") gub_color = "blue";
            else if ( hol_gubun == "휴일" || hol_gubun == "특별휴일" ) gub_color = "red";
            else   gub_color = "black";
            if ( col_num == 1)
            {
                cal1_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal1_1[i].style.color = gub_color;
                cal1_2[i].style.color = gub_color;
            }
            if ( col_num == 2)
            {
                cal2_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal2_1[i].style.color = gub_color;
                cal2_2[i].style.color = gub_color;
            }
            if ( col_num == 3)
            {
                cal3_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal3_1[i].style.color = gub_color;
                cal3_2[i].style.color = gub_color;
            }
            if ( col_num == 4)
            {
                cal4_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal4_1[i].style.color = gub_color;
                cal4_2[i].style.color = gub_color;
            }
            if ( col_num == 5)
            {
                cal5_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal5_1[i].style.color = gub_color;
                cal5_2[i].style.color = gub_color;
            }
            if ( col_num == 6)
            {
                cal6_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal6_1[i].style.color = gub_color;
                cal6_2[i].style.color = gub_color;
            }
            if ( col_num == 7)
            {
                cal7_2[i].innerText   = hol_gubun=="평일"?"":hol_gubun;
                cal7_1[i].style.color = gub_color;
                cal7_2[i].style.color = gub_color;
            }

            dsT_DI_HOLIDAY.NameValue(row_num,"COLOR_VAL") = gub_color;
            dsT_DI_HOLIDAY.NameValue(row_num,"HOL_GUB")   = hol_gubun;
        }
        
        f.txtREMARK_UPT.focus();
        
    }

    /****** 비고란에 글 입력시 달력에 입력 ******/
    function fnc_txtREMARK_bind(remark_value) {
        var f = document.form1;
        var i = f.i.value;  // row_num
        var col_num = f.col_num.value;      // colid
        var colid_val;
        var row_num = f.row_num.value;
        var cal_num;



        if ( i != "" || i != null )
        {


            if ( col_num == "1" ){
                cal1_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
            if ( col_num == "2" ){
                cal2_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
            if ( col_num == "3" ){
                cal3_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
            if ( col_num == "4" ){
                cal4_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
            if ( col_num == "5" ){
                cal5_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
            if ( col_num == "6" ){
                cal6_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
            if ( col_num == "7" ){
                cal7_3[i].innerText   = remark_value;
                dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL") = remark_value;
            }
        }
    }
    /****** 다음달 버튼 ******/
    function fnc_Next_month(year, month) {
        var next_year;
        var next_month;
        var now_year  = document.form1.cmbREG_Y_SHR.value;
        var now_month = document.form1.cmbREG_M_SHR.value;
        if ( now_month == "12" ) {
            next_year  = Number(now_year) + 1;
            next_month = "1";
        } else {
            next_year  = now_year;
            next_month = Number(now_month) + 1;
        }

        fnc_SearchItem(next_year, next_month);
    }

    /****** 이전달 버튼 ******/
    function fnc_Pre_month(){
    	
    	var pre_year;
    
        var pre_month;
        
        var now_year  = document.form1.cmbREG_Y_SHR.value;
        
        var now_month = document.form1.cmbREG_M_SHR.value;
        
        if ( now_month == "1" || now_month == "0" ) {
            if ( now_month == "1" ) pre_year  = Number(now_year) - 1;
            pre_month = "12";
        } else {
            pre_year  = now_year;
            pre_month = Number(now_month) - 1;
        }

        fnc_SearchItem(pre_year, pre_month);
    }

    /****** 날짜칸에 남는 마우스흔적 ******/
    function doTrans_color(i,j) {   // 마우스 움직일때 날짜칸 색 지정
    	
        fnc_tdColor(i,j,"#EBFEE7");

        var pre_i = document.form1.i.value;      //전에 클릭햇던 날짜칸의 행과 열 번호
        var pre_j = document.form1.col_num.value;
        if ( pre_i == i )
        {
            fnc_tdColor(pre_i,pre_j,"#FEE2E0");
        }
    }

    function fnc_SearchItem_Y(M_SHR_VAL) {
    	
       form1.cmbREG_M_SHR.value = 0;
       
    }
    
    
    /****** 마우스 이동시 전에 있던 날짜칸의 색깔 하얀색으로. ******/
    function rollback_color(i,j) {

        var pre_i = document.form1.i.value;      //전에 클릭햇던 날짜칸의 행과 열 번호
        var pre_j = document.form1.col_num.value;
        if ( pre_i != i || pre_j != j )
        {
            fnc_tdColor(i,j,"white");
        }
        
    }

    /****** 날짜 클릭시 bind ******/
    function fnc_bind2(i,cal_num,j){
    	
        var f = document.form1;
        //클릭한 날이 dataset의 row 넘버가 되도록. cal_num은 달력의 제일 첫칸부터 붙여진 일련번호
        var row_num = cal_num - dsT_DI_HOLIDAY.OrgValue(1,5) + 1;
        if ( row_num == 0 ) row_num = -1;

        var space;
        var flag           = dsT_DI_HOLIDAY.NameValue(row_num,"REG_YMD");
        var txtREG_YMD_val = dsT_DI_HOLIDAY.NameValue(row_num,"DAY_VAL");
        var cmbHOL_GBN_val = dsT_DI_HOLIDAY.NameValue(row_num,"HOL_GUB");
        var txtREMARK_val  = dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL");

        if ( flag == "" || flag == null ){
            f.txtREG_YMD_UPT.value    = "";
            f.cmbHOL_GBN_UPT.value    = "";
            f.txtREMARK_UPT.value     = "";
            f.cmbHOL_GBN_UPT.disabled = true;
            f.txtREMARK_UPT.disabled  = true;
        } else {
            f.cmbHOL_GBN_UPT.disabled = false;
            f.txtREMARK_UPT.disabled  = false;

            f.txtREG_YMD_UPT.value = f.cmbREG_Y_SHR.value + "년" + f.cmbREG_M_SHR.value + "월" + txtREG_YMD_val + "일";
            if ( cmbHOL_GBN_val == "" || cmbHOL_GBN_val == null ) f.cmbHOL_GBN_UPT.value = 0;
            else                                                  f.cmbHOL_GBN_UPT.value = cmbHOL_GBN_val;
            f.txtREMARK_UPT.value = txtREMARK_val;
        }
        
        f.row_num.value = row_num;
        f.i.value       = i;
        f.col_num.value = j;
        
    }

    /****** 버튼 클릭시 해당날짜 색 지정 ******/
    function fnc_bind(i,cal_num,j) {
    	
        fnc_tdColor(i,j,"#FEE2E0");

        if ( document.form1.i.value != null || document.form1.i.value != "" )
        {
            var pre_i = document.form1.i.value;         // 전에 클릭했던 날짜칸의 행,열 번호
            var pre_j = document.form1.col_num.value;
            if ( pre_i != i || pre_j != j )
            {
                fnc_tdColor(pre_i,pre_j,"white");
            }
        }
        
        fnc_bind2(i,cal_num,j);
        
    }

    function fnc_tdColor(i,j,color_val) {
    	
        if ( j == 1 ) td_index_1[i].style.background = color_val;
        if ( j == 2 ) td_index_2[i].style.background = color_val;
        if ( j == 3 ) td_index_3[i].style.background = color_val;
        if ( j == 4 ) td_index_4[i].style.background = color_val;
        if ( j == 5 ) td_index_5[i].style.background = color_val;
        if ( j == 6 ) td_index_6[i].style.background = color_val;
        if ( j == 7 ) td_index_7[i].style.background = color_val;
    }
    
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_HOLIDAY                      |
    | 3. Table List : T_DI_HOLIDAY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_HOLIDAY2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_HOLIDAY_INPUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_HOLIDAY)		|
    | 3. 사용되는 Table List(T_CM_PERSON, T_DI_HOLIDAY) |
    +--------------------------------------------------->
    <Object ID ="trT_DI_HOLIDAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_HOLIDAY event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_HOLIDAY event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
  <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchItem(cmbREG_Y_SHR.value, cmbREG_M_SHR.value)"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 끝 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="50"></col>
                    <col width="120"></col>
                    <col width="50"></col>
                    <col width="120"></col>
                    <col width="50"></col>
                    <col width="120"></col>
                    <col width="50"></col>
                    <col width="120"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">선택일자</td>
                    <td class="padding2423">
                        <input type="text" name="txtREG_YMD_UPT" id="txtREG_YMD_UPT" style="ime-mode:disabled" size="15" maxlength="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">휴일구분</td>
                    <td class="padding2423">
                        <select id="cmbHOL_GBN_UPT" name="cmbHOL_GBN_UPT" style="WIDTH: 75%" onkeypress="javascript:if(event.keyCode==13) fnc_HOL_GBN();" onChange="fnc_HOL_GBN_bind(this.value)">
                           <option value='평일'>평일</option>
                           <option value='토요일'>토요일</option>
                           <option value='휴일'>휴일</option>
                           <option value='특별휴일'>특별휴일</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">비고</td>
                    <td class="padding2423">
                        <input type="text" name="txtREMARK_UPT" id="txtREMARK_UPT" size="27" maxlength="59"  onKeyUp="fnc_txtREMARK_bind(this.value)">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<table><tr><td height=5></td></tr>


<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width=540 align="right"  class="paddingTop8">&nbsp;
            <input type="button" name="btnREG_pre_SHR" value="<< 이전월" style="background:white;cursor:hand" onClick="fnc_Pre_month()" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <select id="cmbREG_Y_SHR" name="cmbREG_Y_SHR" style="WIDTH: 9%" onkeypress="javascript:if(event.keyCode==13) fnc_HOL_GBN();" onChange="fnc_SearchItem(this.value,form1.cmbREG_M_SHR.value)">
            </select>&nbsp;년
            <select id="cmbREG_M_SHR" name="cmbREG_M_SHR" style="WIDTH: 7%" onkeypress="javascript:if(event.keyCode==13) fnc_HOL_GBN();" onChange="fnc_SearchItem(form1.cmbREG_Y_SHR.value, this.value)" bgcolor=#E8F5FF>
               <option value='1'>1</option>
               <option value='2'>2</option>
               <option value='3'>3</option>
               <option value='4'>4</option>
               <option value='5'>5</option>
               <option value='6'>6</option>
               <option value='7'>7</option>
               <option value='8'>8</option>
               <option value='9'>9</option>
               <option value='10'>10</option>
               <option value='11'>11</option>
               <option value='12'>12</option>
            </select>&nbsp;월
            <input type="button" name="btnREG_nxt_SHR" value="다음월 >>" style="background:white;cursor:hand" onClick="fnc_Next_month(cmbREG_Y_SHR.value,cmbREG_M_SHR.value)" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" ><span id="resultMessage">&nbsp;</span></td>
                    <td align="right" class="searchState">
                    일괄처리년도
                    <input type="text" id="txtPIS_YY" name="txtPIS_YY" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YY" name="imgPIS_YY" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY','','620','140');"></a>
                    </td>
                    <td align="right">
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnReflect','','../../images/button/BatchCreateOver.gif',1)"><img src="../../images/button/BatchCreateOn.gif" id="btnReflect" name="btnReflect" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()"></a>
                    </td>
                </tr>
             </table>
        </td>

    </tr>
</table>
<table><tr><td height=10></td></tr>
<!-- 조회 상태 테이블 끝 -->



<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">

            <table  border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="40"><div align="center" class="style1"><b>일</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>월</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>화</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>수</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>목</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>금</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>토</b></div></td>
                </tr>
<%
            int cal_num = 0;   //dataset의 row넘버를 구하기위함.
            for ( int i=0; i<5; i++ ) {
%>
                <tr>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,1)" onmouseover="doTrans_color(<%=i%>,1)" onmouseout="rollback_color(<%=i%>,1)" id="td_index_1" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal1_1" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal1_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal1_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,2)" onmouseover="doTrans_color(<%=i%>,2)" onmouseout="rollback_color(<%=i%>,2)" id="td_index_2" style="cursor:hand"><div align="right" id="bbcol">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal2_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal2_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal2_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,3)" onmouseover="doTrans_color(<%=i%>,3)" onmouseout="rollback_color(<%=i%>,3)" id="td_index_3" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal3_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal3_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal3_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,4)" onmouseover="doTrans_color(<%=i%>,4)" onmouseout="rollback_color(<%=i%>,4)" id="td_index_4" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal4_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal4_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal4_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,5)" onmouseover="doTrans_color(<%=i%>,5)" onmouseout="rollback_color(<%=i%>,5)" id="td_index_5" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal5_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal5_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal5_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,6)" onmouseover="doTrans_color(<%=i%>,6)" onmouseout="rollback_color(<%=i%>,6)" id="td_index_6" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal6_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal6_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal6_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(<%=i%>,<%=++cal_num%>,7)" onmouseover="doTrans_color(<%=i%>,7)" onmouseout="rollback_color(<%=i%>,7)" id="td_index_7" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal7_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal7_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal7_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
<%
            }
%>

                <tr id="biz"  style="display:none">
                    <td onclick="fnc_bind(5,<%=++cal_num%>,1)" onmouseover="doTrans_color(5,1)" onmouseout="rollback_color(5,1)" id="td_index_1" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal1_1" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal1_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal1_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(5,<%=++cal_num%>,2)" onmouseover="doTrans_color(5,2)" onmouseout="rollback_color(5,2)" id="td_index_2" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal2_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal2_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal2_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(5,<%=++cal_num%>,3)" onmouseover="doTrans_color(5,3)" onmouseout="rollback_color(5,3)" id="td_index_3" style="cursor:hand"><div align="right">
                        <table border="0"v>
                            <tr>
                                <td height="17" width="120"><div id="cal3_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal3_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal3_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(5,<%=++cal_num%>,4)" onmouseover="doTrans_color(5,4)" onmouseout="rollback_color(5,4)" id="td_index_4" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal4_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal4_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal4_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(5,<%=++cal_num%>,5)" onmouseover="doTrans_color(5,5)" onmouseout="rollback_color(5,5)" id="td_index_5" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal5_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal5_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal5_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(5,<%=++cal_num%>,6)" onmouseover="doTrans_color(5,6)" onmouseout="rollback_color(5,6)" id="td_index_6" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal6_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal6_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal6_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onclick="fnc_bind(5,<%=++cal_num%>,7)" onmouseover="doTrans_color(5,7)" onmouseout="rollback_color(5,7)" id="td_index_7" style="cursor:hand"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="120"><div id="cal7_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal7_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="120"><div id="cal7_3" align="right">&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </div>
            
    <input type="hidden" name="i">
    <input type="hidden" name="hid_REG_YMD">
    <input type="hidden" name="row_num">
    <input type="hidden" name="col_num">

    <input type="hidden" name="dept">
    <input type="hidden" name="countRow">

        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




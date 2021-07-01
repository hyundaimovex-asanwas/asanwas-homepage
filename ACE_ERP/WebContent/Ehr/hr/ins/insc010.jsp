 <!--
*****************************************************
* @source      : insc010.jsp
* @description : 복리후생/산재보험/평균임금산정
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/09      조정호                   최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>평균임금산정</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">

    <!--*****************************
    *  CSS 선언  *
    *****************************-->
    <style type="text/css">
    .header {
        padding: 1px;
        background-color: #f7dcbb;
        text-align: center;
    }
    .content {
        padding: 1px;
        padding-right : 7px;
        background-color: #ffffff;
        text-align: right;
    }
    .textbox {
        padding: 1px;
        padding-right : 3px;
        background-color: #ffffff;
        text-align: right;
    }
    .content2 {
        padding: 1px;
        background-color: #ffffff;
        text-align: center;
    }
    </style>


<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<script language="javascript" src="/common/dateformat.js"></script>
<script language="javascript" src="/common/input.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.c.insc010.cmd.INSC010CMD";
        var params = null;
        var OCC_CD = null;

        //필드의 총 합계를 구하기 위해
        var fieldSum = new Array(0, 0, 0, 0);   //산정내역의 필드들의 계
        var subTotal = 0;   //계[A]S
        var total = 0;      //합계[A+B+C]
        
        //필드이름
        var FIELD_NM = null;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        /**
         * 사원정보를 조회 한다.
         */
         function fnc_SearchEmp() {
            //검색조건
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

            params = "&S_MODE=SHR_EMP"
                   + "&ENO_NO="+oENO_NO;

            dsT_CM_PERSON.dataid = dataClassName+params;
            dsT_CM_PERSON.reset();

            fncChangeFromToYmd();  //산정기간조회
        }
        /**
         * 평균임금 산정내역을 조회한다.
         */
        function fnc_SearchList() {
            //검색조건
            var oENO_NO         = document.getElementById("txtENO_NO_SHR");
            var oYMD            = document.getElementById("txtYMD_SHR");

            if(oENO_NO.value == "") {
                alert("사번을 선택해 주세요");
                oENO_NO.focus();
                return;
            }

            if(oYMD.value == "" ){
                alert("대상년월을 입력하십시오.");
                oYMD.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&YMD="+oYMD.value;

            //초기화 시키기
            dsT_CP_PAYMASTER.ClearData();
            dsT_CP_CHANGE_FIELD.ClearData();
            dsT_CP_CHANGE1.ClearData();
            dsT_CP_CHANGE2.ClearData();
            dsT_CP_CHANGE3.ClearData();
            dsT_CP_CHANGE4.ClearData();
            dsT_CP_PAYMASTER_BONUS.ClearData();
            dsT_CP_YEARLYBONUS.ClearData();

            //리턴받을 DataSet 설정
            trT_CP_PAYMASTER.KeyValue = "tr02"
                                   + "(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"         //산정내역
                                   + ",O:dsT_CP_CHANGE_FIELD=dsT_CP_CHANGE_FIELD"   //기타수당 항목
                                   + ",O:dsT_CP_CHANGE1=dsT_CP_CHANGE1"             //기타수당1
                                   + ",O:dsT_CP_CHANGE2=dsT_CP_CHANGE2"             //기타수당2
                                   + ",O:dsT_CP_CHANGE3=dsT_CP_CHANGE3"             //기타수당3
                                   + ",O:dsT_CP_CHANGE4=dsT_CP_CHANGE4"             //기타수당4
                                   + ",O:dsT_CP_PAYMASTER_BONUS=dsT_CP_PAYMASTER_BONUS"//상여금
                                   + ",O:dsT_CP_YEARLYBONUS=dsT_CP_YEARLYBONUS"     //연월차수당
                                   + ")";
			trT_CP_PAYMASTER.action = dataClassName+params;
			trT_CP_PAYMASTER.post();

           fnc_ShowElement("imgPrint");


        }


        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

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
            var ENO_NO_SHR         = document.getElementById("txtENO_NO_SHR").value;
            var APY_YMD_SHR        = document.getElementById("txtYMD_SHR").value;
      		var DATE_TERM          = document.getElementById("txtFROM_TO_YMD").value;
			var OCC_NM_SHR		   = document.getElementById("txtOCC_NM_SHR").value;
			var PAST_DAY1		   = document.getElementById("PAST_DAY1").innerHTML;
			var PAST_DAY2		   = document.getElementById("PAST_DAY2").innerHTML;
			var PAST_DAY3		   = document.getElementById("PAST_DAY3").innerHTML;
			var PAST_DAY4		   = document.getElementById("PAST_DAY4").innerHTML;
			
			var param = "";//기타수당 및 합계
			
			for(i=0; i<dsT_CP_CHANGE_FIELD.CountRow; i++) {
                for(j=1, sum=0; j<=4; j++) {
                    param += "&ETC_AMT"+(i+1)+""+j+"="+document.getElementById("txtETC_AMT"+(i+1)+""+j).value.replace(",", "").replace(",", "").replace(",", "");
                }
                param += "&ETC_ROWSUM"+(i+1)+"="+document.getElementById("txtETC_ROWSUM"+(i+1)).value.replace(",", "").replace(",", "").replace(",", "");
			}
			
			for(i=dsT_CP_CHANGE_FIELD.CountRow; i<4; i++) {
                for(j=1, sum=0; j<=4; j++) {
                    param += "&ETC_AMT"+(i+1)+""+j+"=0";
                }			
                param += "&ETC_ROWSUM"+(i+1)+"=0";
			}
			
		    for(j=0; j<4; j++) {
		      param += "&ETC_COLSUM"+(j+1)+"="+document.getElementById("txtETC_COLSUM"+(j+1)).value.replace(",", "").replace(",", "").replace(",", "");
	        }
	              
            param += "&ETC_TOTSUM="+document.getElementById("txtETC_TOTSUM").value.replace(",", "").replace(",", "").replace(",", "");
            
            
            for(i=1; i<=4; i++) {
                param += "&SUB_COLSUM"+i+"="+document.getElementById("txtSUB_COLSUM"+i).value.replace(",", "").replace(",", "").replace(",", "");                                
            }
            
            param += "&SUB_TOTSUM="+document.getElementById("txtSUB_TOTSUM").value.replace(",", "").replace(",", "").replace(",", "");
            
            param += "&TOTAL="+document.getElementById("txtTOTAL").value.replace(",", "").replace(",", "").replace(",", "");

            if(ENO_NO_SHR == "") {
                alert("사번을 선택해 주세요");
                txtENO_NO_SHR.focus();
                return;
            }

            if(APY_YMD_SHR == "" ){
                alert("대상년월을 입력하십시오.");
                txtYMD_SHR.focus();
                return;
            }
            

			var url = "insc010_PV.jsp?APY_YMD_SHR="+APY_YMD_SHR+"&ENO_NO_SHR=" + ENO_NO_SHR+"&DATE_TERM=" + DATE_TERM + "&OCC_NM_SHR=" + OCC_NM_SHR + "&PAST_DAY1=" + PAST_DAY1 + "&PAST_DAY2=" + PAST_DAY2 + "&PAST_DAY3=" + PAST_DAY3 + "&PAST_DAY4=" + PAST_DAY4 + param;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("평균임금산정", '', 225);
        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
			 dsT_CP_PAYMASTER.ClearData();
             dsT_CP_CHANGE_FIELD.ClearData();
             dsT_CP_CHANGE1.ClearData();
             dsT_CP_CHANGE2.ClearData();
             dsT_CP_CHANGE3.ClearData();
             dsT_CP_CHANGE4.ClearData();
             dsT_CP_PAYMASTER_BONUS.ClearData();
             dsT_CP_YEARLYBONUS.ClearData();

	         fnc_OnLoadProcess();
			 document.getElementById("resultMessage").innerText = ' ';
             fncClearSearch();   //검색 값들 초기화
             fncClearData();     //값들 초기화
             fncClearDate();     //날짜 초기화

             fncInitData();      //초기 상태로

            //계산을 위한 값들 다시 초기화
            fieldSum = new Array(0, 0, 0, 0);   //산정내역의 필드들의 계
            subTotal = 0;   //계[A]
            total = 0;      //합계[A+B+C]
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_PAYMASTER.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fncInitData();

            document.getElementById("txtYMD_SHR").value = getToday();

             fnc_HiddenElement("imgPrint");
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /********************
         * 기타 함수  *
         *******************/

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO_SHR');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmp();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');
            fnc_SearchEmp();
        }

        /**
         * 입력창의 값들을 비운다.
         */
        function fncClearSearch() {
            //초기화 시킬 입력창
            var inputFields = new Array( "txtENO_NO_SHR"
                                        ,"txtENO_NM_SHR"
                                        ,"txtHIRG_YMD_SHR"
                                        ,"txtOCC_NM_SHR"
                                        ,"txtDPT_NM_SHR"
                                        ,"txtJOB_NM_SHR"
                                       // ,"txtYMD_SHR"
                                        ,"txtFROM_TO_YMD");
            for(i=0; i<inputFields.length; i++) {
                document.getElementById(inputFields[i]).value = "";
            }
        }

        /**
         * 날짜 값들 초기화
         */
        function fncClearDate() {
            var obj = null;
            var value = null;
            var sum = 0;

            //기간값들 설정
            for(i=1; i<=4; i++) {
                obj = document.getElementById("WORKING_DATE"+i);//임금계산기간
                if(obj != null)
                    obj.innerHTML = "";
            }
            
            for(i=1; i<=4; i++) {
                obj = document.getElementById("PAST_DAY"+i);//총일수
                if(obj != null)
                    obj.innerHTML =  "0";
            }
            
            document.getElementById("PAST_DAY_SUM").innerHTML = "0"; //합계
        }

        /**
         * 산정내역 및 평균임금, 통상임금을 초기화한다.
         */
        function fncClearData() {
            var table = document.getElementById("CAL_TABLE");

            for(i=table.rows.length-1; i>=6; i--) {
                table.deleteRow(i-3);
            }

            document.getElementById("AVG_PAY1").innerHTML = ""; //평균임금
            document.getElementById("AVG_PAY2").innerHTML = ""; //통상임금
        }

        /**
         * 산정내역 테이블의 정보를 처음상태로 초기화 시킨다.
         */
        function fncInitData() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            for(i=0; i<3; i++) {
                row = table.insertRow(3+i);

                //처음시작일때
                if(i == 0) {
                    cell = row.insertCell();
                    cell.rowSpan = "3";
                    cell.className = "header";
                    cell.innerHTML = "임<br><br>금<br><br>내<br><br>역";

                    cell = row.insertCell();
                    cell.rowSpan = "2";
                    cell.className = "header";
                    cell.innerHTML = "월<br><br>급<br><br>여";

                    cell = row.insertCell();
                    cell.colSpan = "2";
                    cell.className = "header";
                    cell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
                //두번째
                if(i == 1) {
                    cell = row.insertCell();
                    cell.className = "header";
                    cell.innerHTML = "기<br>타<br>수<br>당";

                    cell = row.insertCell();
                    cell.className = "header";
                    cell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
                //세번째
                if(i == 2) {
                    cell = row.insertCell();
                    cell.colSpan = "3";
                    cell.className = "header";
                    cell.innerHTML = "계 [A]";
                }


                //필드 호출
                for(j=1, sum=0; j<=5; j++) {
                    cell = row.insertCell();
                    cell.className = "content";
                    cell.innerHTML = "&nbsp;";
                }
            }
        }

        /**
         * 산정기간 값 변경
         */
        function fncChangeFromToYmd() {

            var selectYmd = document.getElementById("txtYMD_SHR").value;
            var fromToYmd = document.getElementById("txtFROM_TO_YMD");

            if(selectYmd.trim() != "") {
                var dateinfo = selectYmd.split("-");

                //from - to 날짜값 설정하기
                var toDate = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
                var fromDate = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);

                fromDate.setMonth(fromDate.getMonth()-3);
                fromDate.setDate(toDate.getDate()+1);

                //text 넣기
                fromToYmd.value = fromDate.format("yyyy-mm-dd")+" ~ "+toDate.format("yyyy-mm-dd");
            } else {
                fromToYmd.value = "";
            }
        }

        /**
         * 날짜 값에 대한 값들 설정
         */
        function bindingDate() {
            var selectYmd = document.getElementById("txtYMD_SHR").value;

            var obj = null;

            var fromTo = null;
            var pastDay = null;
            var sum = 0;
            var cnt = 0;

            var dateinfo = selectYmd.split("-");

            //from - to 날짜값 설정하기
            var schDate = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
            var strDate = null;
            var fromDate = null;

            if(fnc_covNumber(fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1)) == fnc_covNumber(schDate.format("dd"))
                    || fnc_covNumber(fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1)) == fnc_covNumber(schDate.format("dd"))+1  ) {
                cnt = 3;
                strDate = new Date(schDate.getFullYear(), schDate.getMonth()-2, "01");
                fromDate = new Date(schDate.getFullYear(), schDate.getMonth()-2, "01");
            } else {
                cnt = 4;
                strDate = new Date(schDate.getFullYear(), schDate.getMonth()-3, schDate.getDate()+1);
                fromDate = new Date(schDate.getFullYear(), schDate.getMonth()-3, schDate.getDate()+1);
            }

            //기간값들 설정
            for(i=1; i<=cnt; i++) {

                //처음일때
                if(i == 1) {
                    fromTo = fromDate.format("yyyy-mm-dd")+"\n"+fromDate.format("yyyy-mm-")+fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1);
                    pastDay = fnc_covNumber(fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1)) - fnc_covNumber(fromDate.format("dd")) +1;
                }

                //마지막일때
                else if(i == cnt) {
                    fromTo = fromDate.format("yyyy-mm-")+"01\n"+schDate.format("yyyy-mm-dd");
                    pastDay = fnc_covNumber(schDate.format("dd"));
                }

                //두번째, 세번째일때
                else {
                    fromTo = fromDate.format("yyyy-mm-")+"01\n"+fromDate.format("yyyy-mm-")+fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1);
                    pastDay = fnc_covNumber(fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1));
                }

                obj = document.getElementById("WORKING_DATE"+i);
                obj.innerText = fromTo;

                obj = document.getElementById("PAST_DAY"+i);
                obj.innerText =  pastDay;

                sum += pastDay;
                fromDate = new Date(fromDate.getFullYear(), fromDate.getMonth()+1, fromDate.getDate());
            }
            //산정기간 값 변경
            document.getElementById("txtFROM_TO_YMD").value = strDate.format("yyyy-mm-dd")+" ~ "+schDate.format("yyyy-mm-dd");
            //총근무일수
            document.getElementById("PAST_DAY_SUM").innerText = sum;
        }

        /**
         * 비용정보에 대한 값들 설정
         */
        function bindingPay() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;
            var FIELD_NM_A = new Array( "기본급"
                                       ,"직책수당"
                                       ,"시간외수당"
                                       ,"복지수당비"
                                       ,"자기개발"
                                       ,"야근수당"
                                       ,"전산수당"
                                       ,"근속수당"
                                       );

            var FIELD_NM_M = new Array( "기본급"
                                       ,"복지수당"
                                       ,"시간외수당"
                                       ,"기술수당"
                                       ,"택배수당"
                                       ,"운행/작업수당"
                                       ,"자기개발비"
                                       ,"근속수당"
                                       );

            var FIELD_CD = new Array  ( "BAS"
                                       ,"DUTY"
                                       ,"OT"
                                       ,"WEL"
                                       ,"OSE"
                                       ,"RUN"
                                       ,"MH"
                                       ,"LSEV"
                                       );

            var obj = null;
            FIELD_NM = null; //전역변수
            var value = null;
            var name = null;
            var sum = 0;

            //값넣을 대상 결정
            if(OCC_CD == 'A') {
                FIELD_NM = FIELD_NM_A;
            } else {
                FIELD_NM = FIELD_NM_M;
            }

            for(i=0; i<FIELD_NM.length; i++) {
                row = table.insertRow(3+i);

                //처음시작일때
                if(i == 0) {
                    cell = row.insertCell();
                    cell.rowSpan = 8+dsT_CP_CHANGE_FIELD.CountRow+5;
                    cell.className = "header";
                    cell.innerHTML = "임<br><br>금<br><br>내<br><br>역";

                                        cell = row.insertCell();
                    cell.rowSpan = 8+dsT_CP_CHANGE_FIELD.CountRow+2;
                    cell.className = "header";
                    cell.innerHTML = "월<br><br>급<br><br>여";
                }

                //항목명 넣기
                name = FIELD_NM[i];

                cell = row.insertCell();
                cell.className = "header";
                cell.colSpan = "2";
                cell.innerHTML = name;


                //값 설정
                for(j=1, sum=0; j<=4; j++) {
                    cell = row.insertCell();
                    cell.className = "textbox";
                    value = dsT_CP_PAYMASTER.nameValue(j, FIELD_CD[i]+"_AMT");

                    if(value == undefined) value = "0";
                    
                    //각비용
                    cell.innerHTML = "<input id='txtFLD_AMT"+(i+1)+""+j+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(value)+"' readonly>";
                    sum += parseInt(value);
                    fieldSum[j-1] += parseInt(value);
                }
                
                cell = row.insertCell();
                cell.className = "textbox";
                
                //각비용 row합
                cell.innerHTML = "<input id='txtFLD_ROWSUM"+(i+1)+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";
            }
        }

        /**
         * 기타수당에 대한 값들 설정
         */
        function bindingEtc() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var objectDS = null;
            var value = null;
            var name = null;
            var sum = 0;

            var etcSum = new Array(0, 0, 0, 0);

            if(dsT_CP_CHANGE_FIELD.CountRow > 0) {
                for(i=0; i<dsT_CP_CHANGE_FIELD.CountRow; i++) {
                    row = table.insertRow(11+i);

                    if(i == 0) {
                        cell = row.insertCell();
                        cell.className = "header";
                        cell.rowSpan= dsT_CP_CHANGE_FIELD.CountRow+1;
                        cell.innerHTML = "기<br>타<br>수<br>당";
                    }

                    //항목명 설정
                    name = dsT_CP_CHANGE_FIELD.nameValue(i+1, "SAL_NM");

                    cell = row.insertCell();
                    cell.className = "header";
                    cell.innerHTML = name;//항목명

                    //값 설정
                    for(j=1, sum=0; j<=4; j++) {
                        objectDS = document.getElementById("dsT_CP_CHANGE"+j);

                        cell = row.insertCell();
                        cell.className = "textbox";
                        value = objectDS.nameValue(i+1, "AMOUNT");

                        if(value == undefined) value = "0";
                        
                        //기타수당 각 항목 값
                        cell.innerHTML = "<input id='txtETC_AMT"+(i+1)+""+j+"' type='text' size='15' maxlength='10' style='ime-mode:disabled;text-align:right;' onkeypress='cfCheckNumber();' onfocusout='this.value=formatNumber(this.value)' onchange='fnc_allSum()' value='"+formatNumber(value)+"'>";
                        
                        sum += parseInt(value);
                        fieldSum[j-1] += parseInt(value);
                        etcSum[j-1] += parseInt(value);
                    }

                    //다 더하기
                    cell = row.insertCell();
                    cell.className = "textbox";
                    
                    //기타수당 각 row 합계
                    cell.innerHTML = "<input id='txtETC_ROWSUM"+(i+1)+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";
                }

                sum = 0;

                //기타수당 소계 가져오기
                row = table.insertRow(11+dsT_CP_CHANGE_FIELD.CountRow);
                cell = row.insertCell();
                cell.className = "header";
                cell.innerHTML = "소&nbsp;&nbsp;&nbsp;계";

                for(j=0; j<4; j++) {
                    cell = row.insertCell();
                    cell.className = "textbox";
                    //기타수당 각 col 소계
                    cell.innerHTML = "<input id='txtETC_COLSUM"+(j+1)+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(etcSum[j])+"' readonly>";
                    sum += parseInt(etcSum[j]);
                }

                cell = row.insertCell();
                cell.className = "textbox";
                //합계의 소계
                cell.innerHTML = "<input id='txtETC_TOTSUM' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";
            }
            //기타수당이 하나라도 없으면
            else {
                row = table.insertRow(11);

                cell = row.insertCell();
                cell.className = "header";
                cell.rowSpan= dsT_CP_CHANGE_FIELD.CountRow+1;
                cell.innerHTML = "기<br>타<br>수<br>당";

                cell = row.insertCell();
                cell.className = "header";
                cell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

                for(j=0; j<5; j++) {
                    cell = row.insertCell();
                    cell.className = "content";
                    cell.innerHTML = "0";
                }
            }
        }

        /**
         * 각 필드의 합을 설정
         */
        function bindingSubSum() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var sum = 0;

            row = table.insertRow(12+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "2";
            cell.className = "header";
            cell.innerHTML = "계&nbsp;&nbsp;&nbsp;[A]";

            for(i=1; i<=4; i++) {
                cell = row.insertCell();
                cell.className = "textbox";
                cell.innerHTML = "<input id='txtSUB_COLSUM"+i+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(fieldSum[i-1])+"' readonly>";
                                
                sum += fieldSum[i-1];
            }

            cell = row.insertCell();
            cell.className = "textbox";
            cell.id = "SUB_TOTSUM";
            cell.innerHTML = "<input id='txtSUB_TOTSUM' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";

            subTotal += sum;
            total += sum;
        }

        /**
         * 상여금을 설정한다.
         */
        function bindingBonus() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var sum = 0;
            var bonValue = dsT_CP_PAYMASTER_BONUS.nameValue(1, "BONUS");
            if(bonValue == undefined) bonValue = "0";

            row = table.insertRow(13+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "3";
            cell.className = "header";
            cell.innerHTML = "상&nbsp;여&nbsp;금&nbsp;[B]";

            cell = row.insertCell();
            cell.colSpan = "4";
            cell.className = "content2";
            cell.innerHTML = formatNumber(bonValue)+" 원 x 3 / 12 = ";

            sum = parseInt(bonValue)*3/12;

            cell = row.insertCell();
            cell.className = "content";
            cell.id = "BONUS";
            cell.innerHTML = formatNumber(sum);

            total += sum;
        }

        /**
         * 연월차수당을 설정한다.
         */
        function bindingYearBonus() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var sum = 0;
            var ymaValue = dsT_CP_YEARLYBONUS.nameValue(1, "YEAR_BONUS");
            if(ymaValue == undefined) ymaValue = "0";

            row = table.insertRow(14+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "3";
            cell.className = "header";
            cell.innerHTML = "연월차수당[C]";

            cell = row.insertCell();
            cell.colSpan = "4";
            cell.className = "content2";
            cell.innerHTML = formatNumber(ymaValue)+" 원 x 3 / 12 = ";

            sum = parseInt(ymaValue)*3/12;

            cell = row.insertCell();
            cell.className = "content";
            cell.id = "YEAR_BONUS";
            cell.innerHTML = formatNumber(sum);

            total += sum;
        }

        /**
         * [A+B+C] 합계를 설정한다.
         */
        function bindingTotalSum() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            row = table.insertRow(15+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "3";
            cell.className = "header";
            cell.innerHTML = "합&nbsp;&nbsp;계&nbsp;[A+B+C]";

            cell = row.insertCell();
            cell.colSpan = "4";
            cell.className = "content2";
            cell.innerHTML = "(월급여)&nbsp;&nbsp;+&nbsp;&nbsp;(상여금)&nbsp;&nbsp;+&nbsp;&nbsp;(연월차수당)";

            cell = row.insertCell();
            cell.className = "textbox";
            cell.id = "TOTAL";
            cell.innerHTML = "<input id='txtTOTAL' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(total)+"' readonly>";
        }

        /**
         * 평균임금이랑 통상임금을 결정한다.
         */
        function bindingAveragePay() {
            var AVG_PAY1 = document.getElementById("AVG_PAY1");
            var AVG_PAY2 = document.getElementById("AVG_PAY2");

            var totalDay = document.getElementById("PAST_DAY_SUM").firstChild.nodeValue;

            AVG_PAY1.innerHTML = "(총임금액)&nbsp;&nbsp;&nbsp;"+formatNumber(total)+"&nbsp;&nbsp;&nbsp;&nbsp;&divide;&nbsp;&nbsp;&nbsp;&nbsp;"+totalDay+"&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;"+formatNumber(Math.round(total/parseInt(totalDay)));
            AVG_PAY2.innerHTML = "( 계 [A] )&nbsp;&nbsp;&nbsp;"+formatNumber(subTotal)+"&nbsp;&nbsp;&nbsp;&nbsp;&divide;&nbsp;&nbsp;&nbsp;&nbsp;"+totalDay+"&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;"+formatNumber(Math.round(subTotal/parseInt(totalDay)));
        }

        //모든 합계를 다시한다.
        function fnc_allSum() {

            var sum = 0;
            var etcSum = new Array(0, 0, 0, 0);
        
            //전역변수 초기화
            fieldSum = new Array(0, 0, 0, 0);   //산정내역의 필드들의 계
            subTotal = 0;   //계[A]S
            total = 0;      //합계[A+B+C]
            
            
            //비용정보
            sum = 0;
            var fldValue = 0;
            
            for(i=0; i<FIELD_NM.length; i++) {
                for(j=1, sum=0; j<=4; j++) {
                    fldValue = document.getElementById("txtFLD_AMT"+(i+1)+""+j).value.replace(",", "").replace(",", "").replace(",", "");
                    sum += parseInt(fldValue);
                    fieldSum[j-1] += parseInt(fldValue);
                }

                document.getElementById("txtFLD_ROWSUM"+(i+1)).value = formatNumber(sum);
            }            
            
            
            //기타수당
            sum = 0;
            var etcValue = 0;
            
            if(dsT_CP_CHANGE_FIELD.CountRow > 0) {
            
                for(i=0; i<dsT_CP_CHANGE_FIELD.CountRow; i++) {
                
                    for(j=1, sum=0; j<=4; j++) {
                        etcValue = document.getElementById("txtETC_AMT"+(i+1)+""+j).value.replace(",", "").replace(",", "").replace(",", "");
                        sum += parseInt(etcValue);
                        fieldSum[j-1] += parseInt(etcValue);
                        etcSum[j-1] += parseInt(etcValue);                    
                    }
                    
                    //기타수당 각 row 합계
                    document.getElementById("txtETC_ROWSUM"+(i+1)).value = formatNumber(sum);
                }
                
                sum = 0;
                
                for(j=0; j<4; j++) {
                    //기타수당 각 col 소계
                    document.getElementById("txtETC_COLSUM"+(j+1)).value = formatNumber(etcSum[j]);
                    sum += parseInt(etcSum[j]);
                }
                
                //합계의 소계
                document.getElementById("txtETC_TOTSUM").value = formatNumber(sum);
               
            }
            
            
            //월급여 계
            sum = 0;
            
            for(i=1; i<=4; i++) {
                //각 col 계                                
                document.getElementById("txtSUB_COLSUM"+i).value = formatNumber(fieldSum[i-1]);
                sum += fieldSum[i-1];
            }
            
            document.getElementById("txtSUB_TOTSUM").value = formatNumber(sum);
            subTotal += sum;
            total += sum;
            
            
            //상여금
            sum = 0;
            
            var bonValue = dsT_CP_PAYMASTER_BONUS.nameValue(1, "BONUS");
            if(bonValue == undefined) bonValue = "0";
            sum = parseInt(bonValue)*3/12;
            total += sum;
            
            
            //연월차수당
            sum = 0;
            
            var ymaValue = dsT_CP_YEARLYBONUS.nameValue(1, "YEAR_BONUS");
            if(ymaValue == undefined) ymaValue = "0";
            sum = parseInt(ymaValue)*3/12;
            total += sum;
            
            //[A+B+C] 합계
            document.getElementById("txtTOTAL").value = formatNumber(total);
            
            //평균임금이랑 통상임금
            bindingAveragePay();
            
        }
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_CP_PAYMASTER                       |
    | 3. Table List : T_CP_PAYMASTER                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_CP_CHANGE_FIELD                  |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE_FIELD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_CP_CHANGE1                       |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_CP_CHANGE2                       |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_CP_CHANGE3                       |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CP_CHANGE4                      |
    | 3. Table List : T_CP_CHANGE                   |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                      |
    | 2. 이름 : dsT_CP_PAYMASTER_BONUS               |
    | 3. Table List : T_CP_PAYMASTER                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_BONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                      |
    | 2. 이름 : dsT_CP_YEARLYBONUS                   |
    | 3. Table List : T_CP_YEARLYBONUS               |
    +----------------------------------------------->
    <Object ID="dsT_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet - 예금종류                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V2"/>
       <jsp:param name="CODE_GUBUN"    value="V2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet - 근로구분구분                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if(iCount >= 1) {
            OCC_CD = dsT_CM_PERSON.NameValue(1, "OCC_CD");
        }
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        //계산을 위한 값들 다시 초기화
        fieldSum = new Array(0, 0, 0, 0);   //산정내역의 필드들의 계
        subTotal = 0;   //계[A]
        total = 0;      //합계[A+B+C]

        fncClearData();     //값들 초기화
        fncClearDate();     //날짜 초기화

        bindingDate();          //날짜값들 설정(임금계산기간, 총일수)
        bindingPay();           //비용정보 설정(기본급 등 각 항목의 의 기간값과 합계)
        bindingEtc();           //기타수당 설정
        bindingSubSum();        //총 계를 설정
        bindingBonus();         //상여금을 설정
        bindingYearBonus();     //연월차수당을 설정
        bindingTotalSum();      //합계를 설정
        bindingAveragePay();    //평균임금,통상임금을 설정

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평균임금산정</td>
					<td align="right" class="navigator">HOME/복리후생/산재보험/<font color="#000000">평균임금산정</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="110"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사원번호</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" maxlength="12" style="width:70%" onkeypress="cfNumberCheck(); if(event.keyCode==13) fnc_SearchEmp()" onchange="fnc_SearchEmp()" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                                </td>
                                <td align="right" class="searchState">성&nbsp;&nbsp;&nbsp;명</td>
                                <td class="padding2423">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" onkeypress="if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                </td>
                                <td align="right" class="searchState">입&nbsp;사&nbsp;일</td>
                                <td class="padding2423">
                                    <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
                                <td class="padding2423">
                                    <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">소&nbsp;&nbsp;&nbsp;속</td>
                                <td class="padding2423">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;위</td>
                                <td class="padding2423">
                                    <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">선정사유발생일</td>
                                <td class="padding2423">
                                    <input id="txtYMD_SHR" name="txtYMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();javascript:if(event.keyCode==13) fnc_SearchEmp();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtYMD_SHR','','130','155');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">선정기간</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtFROM_TO_YMD" name="txtFROM_TO_YMD" size="23" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 산정내역 시작 -->
<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#999999" id="CAL_TABLE">

	<tr align="center">
		<td colspan="9" class="header">산&nbsp;&nbsp;정&nbsp;&nbsp;내&nbsp;&nbsp;역</td>
	</tr>
	
    <tr>
        <td class="header" colspan="4" height="22">임금계산기간</td>
        <td class="header" id="WORKING_DATE1" width="130"></td>
        <td class="header" id="WORKING_DATE2" width="130"></td>
        <td class="header" id="WORKING_DATE3" width="130"></td>
        <td class="header" id="WORKING_DATE4" width="130"></td>
        <td class="header" width="130">합&nbsp;&nbsp;&nbsp;계</td>
    </tr>
    
    <tr>
        <td class="header" colspan="4" height="22">총&nbsp;일&nbsp;수</td>
        <td class="content2" id="PAST_DAY1">0</td>
        <td class="content2" id="PAST_DAY2">0</td>
        <td class="content2" id="PAST_DAY3">0</td>
        <td class="content2" id="PAST_DAY4">0</td>
        <td class="content2" id="PAST_DAY_SUM">0</td>
    </tr>
    
    <tr>
        <td class="content2" colspan="9">&nbsp;</td>
    </tr>
    
    <tr>
        <td class="header" colspan="4">평&nbsp;균&nbsp;임&nbsp;금</td>
        <td class="content2" colspan="5" id="AVG_PAY1"></td>
    </tr>
    
    <tr>
        <td class="header" colspan="4">통&nbsp;상&nbsp;임&nbsp;금</td>
        <td class="content2" colspan="5" id="AVG_PAY2"></td>
    </tr>
</table>
<!-- 산정내역 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

    <!--**************************************************************************************
    *                                                                                        *
    *   바인딩 컴포넌트                                                                             *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_CM_PERSON 조회해온 사원 정보를 창에 뿌려줌 -->
    <object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_CM_PERSON">
        <Param Name="BindInfo", Value='
            <C>Col=ENO_NO               Ctrl=txtENO_NO_SHR              Param=value     </C>
            <C>Col=ENO_NM               Ctrl=txtENO_NM_SHR              Param=value     </C>
            <C>Col=DPT_NM               Ctrl=txtDPT_NM_SHR              Param=value     </C>
            <C>Col=JOB_NM               Ctrl=txtJOB_NM_SHR              Param=value     </C>
            <C>Col=HIRG_YMD             Ctrl=txtHIRG_YMD_SHR            Param=value     </C>
            <C>Col=OCC_NM               Ctrl=txtOCC_NM_SHR              Param=value     </C>
        '>
    </object>

    <!-- T_CP_PAYMASTER 설정 테이블 -->
    <object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_CP_PAYMASTER">
        <Param Name="BindInfo", Value="
            <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value</C>
            <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value</C>
            <C>Col=HIU_NO           Ctrl=txtHIU_NO          Param=value</C>
            <C>Col=GRD_PCT          Ctrl=txtGRD_PCT         Param=value</C>
        ">
    </object>
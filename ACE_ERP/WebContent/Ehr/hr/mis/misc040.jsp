<!--
    ************************************************************************************
    * @Source         : misc040.jsp                                                    *
    * @Description    : 인원충원계획현황 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/04 |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>인원충원계획현황(misc040)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    
    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    
        var btnList  = 'TFFTTTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var DPT_CD   = document.getElementById("txtDPT_CD_SHR").value;
            var HIRS_YM  = document.getElementById("cmbHIRS_YM_SHR").value;
            var HIRE_YM  = document.getElementById("cmbHIRE_YM_SHR").value;
            var JOB_CD   = document.getElementById("cmbJOB_CD_SHR").value;
            
            if (PIS_YY == "") {
                alert("사업년도는 필수입력항목입니다.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }
            
            if (HIRS_YM > HIRE_YM) {
                alert("계획년월 FROM년월이 계획년월 TO년월보다 큽니다.");
                return;
            }
            
            dsT_MI_LEVYPLAN.ClearData();
            
            dsT_MI_LEVYPLAN.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc040.cmd.MISC040CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&DPT_CD="+DPT_CD+"&HIRS_YM="+HIRS_YM+"&HIRE_YM="+HIRE_YM+"&JOB_CD="+JOB_CD;
            dsT_MI_LEVYPLAN.Reset();
            
            form1.grdT_MI_LEVYPLAN.Focus();
            
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요
            
        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요
            
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var DPT_CD   = document.getElementById("txtDPT_CD_SHR").value;
            var DPT_NM   = document.getElementById("txtDPT_NM_SHR").value;
            var HIRS_YM  = document.getElementById("cmbHIRS_YM_SHR").value;
            var HIRE_YM  = document.getElementById("cmbHIRE_YM_SHR").value;
            var JOB_CD   = document.getElementById("cmbJOB_CD_SHR").value;
            var JOB_NM   = document.getElementById("cmbJOB_CD_SHR").options[document.getElementById("cmbJOB_CD_SHR").selectedIndex].text; 

			var url = "misc040_PV.jsp?pis_yy="+PIS_YY+"&dpt_cd="+DPT_CD+"&dpt_nm="+DPT_NM+"&hirs_ym="+HIRS_YM+"&hire_ym="+HIRE_YM+"&job_cd="+JOB_CD+"&job_nm="+JOB_NM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_MI_LEVYPLAN.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_MI_LEVYPLAN.GridToExcel("인원충원계획현황", '', 225);

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

            document.getElementById("cmbPIS_YY_SHR").selectedIndex = 0;
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            // 계획년월(FROM)
            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value, "cmbHIRS_YM_SHR");
            
            // 계획년월(TO)
            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value, "cmbHIRE_YM_SHR");
            document.getElementById("cmbJOB_CD_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_MI_LEVYPLAN.ClearData();
            
            form1.cmbPIS_YY_SHR.value = PlanYear;
            document.getElementById("cmbPIS_YY_SHR").focus();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {
            
            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var tempDS = null;
            
            //Grid Style 적용
            cfStyleGrid(form1.grdT_MI_LEVYPLAN,0,"false","false");
            
            //직급
            tempDS = fnc_GetJobCd();
            
            for( var i=1; i<=tempDS.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = tempDS.NameValue(i,"COMM_CD");
                oOption.text = tempDS.NameValue(i,"COMM_NM");
                document.getElementById("cmbJOB_CD_SHR").add(oOption);
            }
            
            // 파견사원
            oOption = document.createElement("OPTION");
            oOption.value = 'ZZ';
            oOption.text = '파견직';
            document.getElementById("cmbJOB_CD_SHR").add(oOption);  
          
            // 사업년도 및 대상기간 추출
            dsT_CP_WORKLOG.ClearData();
            
            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc040.cmd.MISC040CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();
            
            
        }
        
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
            
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/
         
        function fnc_setHirYm(pis_yy, fld) {
            
            var oOption;
            var obj     = document.getElementById(fld);
            var Index   = obj.length;
            var Row     = dsT_CP_WORKLOG.NameValueRow("PIS_YY", pis_yy);
            var PAY_YM  = dsT_CP_WORKLOG.NameValue(Row, "PAY_YMD");
            var APY_YM  = dsT_CP_WORKLOG.NameValue(Row, "APY_YMD");
            var Month   = 0; 
            var Month2  = 0;
            var HIR_YM  = 0;
            
            //기존의 계획년월 삭제
            for( var i = Index; i >= 0; i--){

                obj.options.remove(i);

            }
            
            // 계획년월
            // 사업년도가 전년도인 경우
            if (PAY_YM.substr(0,4) != pis_yy) {

                Month = new Number(PAY_YM.substr(4,2));
                HIR_YM = new Number(PAY_YM);

                for (i = Month; i <= 12; i++) {
                    oOption = document.createElement("OPTION");
                    oOption.value = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    oOption.text  = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    obj.add(oOption);
                    
                    HIR_YM = HIR_YM + 1;
                }
                
                Month2 = new Number(APY_YM.substr(4,2));
                HIR_YM = new Number(pis_yy+"01");

                for (i = 1; i <= Month2; i++) {
                    oOption = document.createElement("OPTION");
                    oOption.value = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    oOption.text  = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    obj.add(oOption);
                    
                    HIR_YM = HIR_YM + 1;
                }
            }
            
            // 사업년도가 당해년도인 경우
            if (PAY_YM.substr(0,4) == pis_yy) {
            
                Month  = new Number(PAY_YM.substr(4,2));
                Month2 = new Number(APY_YM.substr(4,2));
                HIR_YM = new Number(PAY_YM);
            
                for (i = Month; i <= Month2; i++) {
                    oOption = document.createElement("OPTION");
                    oOption.value = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    oOption.text  = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    obj.add(oOption);
                    
                    HIR_YM = HIR_YM + 1;
                }
            }
            
            if (fld == 'cmbHIRS_YM_SHR') {
                obj.value = obj.options[0].text;
            }
            else if (fld == 'cmbHIRE_YM_SHR') {
                obj.value = obj.options[obj.length - 1].text;
            }
            
        }
        
        
    </script>

    </head>

    
    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_MI_LEVYPLAN)  |
    | 3. 사용되는 Table List(T_MI_LEVYPLAN)         |
    +----------------------------------------------->
    <Object ID="dsT_MI_LEVYPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)   |
    | 3. 사용되는 Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
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
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_MI_LEVYPLAN.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
    
        var oOption;
        var Index  = document.getElementById("cmbPIS_YY_SHR").length;
    
        if (iCount == 0)    {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 사업년도 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = getToday().substr(0,4);
            oOption.text  = getToday().substr(0,4);
            document.getElementById("cmbPIS_YY_SHR").add(oOption);

        }
        else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 사업년도 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            //사업년도
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text  = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                document.getElementById("cmbPIS_YY_SHR").add(oOption);

            }
            
            var obj    = document.getElementById("cmbPIS_YY_SHR");
            var idx    = obj.selectedIndex;
            var PIS_YY = obj.options[idx].text;

            // 계획년월
            fnc_setHirYm(PIS_YY, "cmbHIRS_YM_SHR");
            
            // 계획년월
            fnc_setHirYm(PIS_YY, "cmbHIRE_YM_SHR");
            
           
            ProSts = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

        }
        
        document.getElementById("cmbPIS_YY_SHR").focus();
    
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
   
       
<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">인원충원계획현황</td>
                    <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">인원충원계획현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="ImgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="65"></col>
                                <col width="60 "></col>
                                <col width="65 "></col>
                                <col width="180"></col>
                                <col width="65 "></col>
                                <col width="200"></col>
                                <col width="65 "></col>
                                <col width="100"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사업년도 </td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR" onChange="fnc_setHirYm(this.value, 'cmbHIRS_YM_SHR');fnc_setHirYm(this.value, 'cmbHIRE_YM_SHR');" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">부서 </td>
                                <td class="padding2423">
                                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3"  maxlength="3" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd1" name="ImgDptCd1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">계획년월</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbHIRS_YM_SHR" style="width:45%" >
                                    </select> ~
                                    <select id="cmbHIRE_YM_SHR" style="width:45%" >
                                    </select>
                                </td>
                                <td align="right" class="searchState">직급</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbJOB_CD_SHR" style="width:100%" >
                                        <option value="">전체</option>
                                    </select>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_MI_LEVYPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"                  value="dsT_MI_LEVYPLAN">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'               align=center </C>
                                <C> id='PIS_YY'       width=55    name='사업년도'           align=center </C>
                                <C> id='DPT_NM'       width=90    name='부서'               align=left   </C>
                                <C> id='JOB_NM'       width=55    name='직급'               align=center </C>
                                <C> id='MF_TNM'       width=60    name='성별'               align=center </C>
                                <C> id='HIR_YM'       width=60    name='계획년월'           align=center </C>
                                <C> id='HEAD_NM'      width=55    name='직군'               align=center </C>
                                <C> id='LEVY_NM'      width=100   name='충원사유'           align=left   </C>
                                <C> id='JIKMU_NM'     width=100   name='직무'               align=left   </C>
                                <C> id='OCC_NM'       width=55    name='근로구분'               align=center </C>
                                <C> id='OENO_NO'      width=65    name='이전사번'           align=center </C>
                                <C> id='OENO_NM'      width=65    name='성명'           align=center </C>
                                <C> id='NDPT_NM'      width=90    name='전환부서'           align=left   </C>
                                <C> id='REMARK'       width=130   name='주요업무'           align=left   </C>
                                <C> id='LEVY_TXT'     width=230   name='사유'               align=left   </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>


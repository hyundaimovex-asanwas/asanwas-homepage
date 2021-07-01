<!--
    ************************************************************************************
    * @Source         : vlub041.jsp                                                    *
    * @Description    : 역량평가표 PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/26  |  박인이   | 최초작성                                               *
    * 2007/03/16  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
<title>역량평가표작성(vlub041)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //업무구분
    String EVL_YY     = request.getParameter("EVL_YY");         //해당년도
    String EVL_GBN    = request.getParameter("EVL_GBN");        //구분(업적/역량)
    String EVL_FRQ    = request.getParameter("EVL_FRQ");        //회차
    String IPT_STDT   = request.getParameter("IPT_STDT");       //평가입력기간(시작)
    String IPT_ENDT   = request.getParameter("IPT_ENDT");       //평가입력기간(종료)
    String ENO_NO     = request.getParameter("ENO_NO");         //피평가자사번
    String DEGREE_GBN = request.getParameter("DEGREE_GBN");     //차수
    String EVLENO_NO  = request.getParameter("EVLENO_NO");      //평가자사번
    String UPDN_GBN   = request.getParameter("UPDN_GBN");       //상/하향평가구분
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    
        var btnList = 'FFTFFFFT';
    
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            
            // DATASET 초기화
            fnc_Clear();
            
            var GUBUN      = "<%=GUBUN%>";
            var EVL_YY     = form1.txtEVL_YY_SHR.value;
            var EVL_GBN    = form1.txtEVL_GBN_SHR.value;
            var EVL_FRQ    = form1.txtEVL_FRQ_SHR.value;
            var ENO_NO     = form1.txtENO_NO_SHR.value;
            var UPDN_GBN   = form1.txtUPDN_GBN_SHR.value;
            var DEGREE_GBN = form1.txtDEGREE_GBN_SHR.value;
            var EVLENO_NO  = form1.txtEVLENO_NO_SHR.value;
            
            form1.txtFLAG.value = "1"; // 조회FLAG
            
            // 하향평가이면
            if (UPDN_GBN == '2') {
            
                trT_EV_ABLTBL.KeyValue = "tr01(O:SHR=dsT_EV_ABLTBL,O:SHR2=dsT_EV_EVLIST_HD)";
                trT_EV_ABLTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub041.cmd.VLUB041CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&UPDN_GBN="+UPDN_GBN+"&DEGREE_GBN="+DEGREE_GBN+"&EVLENO_NO="+EVLENO_NO;
                trT_EV_ABLTBL.post();
            }
            else {
                trT_EV_ABLTBL.KeyValue = "tr01(O:SHR=dsT_EV_ABLTBL,O:SHR2=dsT_EV_EVLIST_HD)";
                trT_EV_ABLTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub041.cmd.VLUB041CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&UPDN_GBN="+UPDN_GBN+"&DEGREE_GBN="+DEGREE_GBN+"&EVLENO_NO="+EVLENO_NO;
                trT_EV_ABLTBL.post();
            }
            
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
            
            var UPDN_GBN   = form1.txtUPDN_GBN_SHR.value;
            var DEGREE_GBN = form1.txtDEGREE_GBN_SHR.value;
            
            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            form1.txtFLAG.value = "2"; // 저장FLAG
            
            trT_EV_ABLTBL.KeyValue = "tr01(I:SAV=dsT_EV_ABLTBL)";
            trT_EV_ABLTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub041.cmd.VLUB041CMD&S_MODE=SAV&UPDN_GBN="+UPDN_GBN+"&DEGREE_GBN="+DEGREE_GBN;
            trT_EV_ABLTBL.post();
            
            dsT_EV_ABLTBL.UseChangeInfo = "true";
            
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_ABLTBL.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            
            form1.mgrdT_EV_ABLTBL.GridToExcel("역량평가표", '', 4);

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

            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_EV_ABLTBL.ClearData();

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

            var SUBPNT = 0;

            // 값이 1보다 작거나 10보다 크면 저장이 되지 않도록 한다.            
            for (var i = 1; i<= dsT_EV_ABLTBL.CountRow; i++) {
                
                if ( dsT_EV_ABLTBL.NameValue(i, "SUBPNT_01") < 1  || 
                     dsT_EV_ABLTBL.NameValue(i, "SUBPNT_01") > 10 ) {
                    alert("["+dsT_EV_ABLTBL.NameValue(i, "EST_NM")+"]["+dsT_EV_ABLTBL.NameValue(i, "ABL_NM")+"]의 행동지표의 점수가 배점기준의 값이 아닙니다.\n해당 점수를 입력하시기 바랍니다.");
                    
                    form1.mgrdT_EV_ABLTBL.Draw = false;
                    form1.mgrdT_EV_ABLTBL.RowPosition    = i;
                    form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_01";
                    form1.mgrdT_EV_ABLTBL.Draw = true;
            
                    form1.mgrdT_EV_ABLTBL.Focus();
                    return false;
                }
                
                if ( dsT_EV_ABLTBL.NameValue(i, "SUBPNT_02") < 1  || 
                     dsT_EV_ABLTBL.NameValue(i, "SUBPNT_02") > 10 ) {
                    alert("["+dsT_EV_ABLTBL.NameValue(i, "EST_NM")+"]["+dsT_EV_ABLTBL.NameValue(i, "ABL_NM")+"]의 행동지표의 점수가 배점기준의 값이 아닙니다.\n해당 점수를 입력하시기 바랍니다.");
                    
                    form1.mgrdT_EV_ABLTBL.Draw = false;
                    form1.mgrdT_EV_ABLTBL.RowPosition    = i;
                    form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_02";
                    form1.mgrdT_EV_ABLTBL.Draw = true;
            
                    form1.mgrdT_EV_ABLTBL.Focus();
                    return false;
                }
                
                if ( dsT_EV_ABLTBL.NameValue(i, "SUBPNT_03") < 1  || 
                     dsT_EV_ABLTBL.NameValue(i, "SUBPNT_03") > 10 ) {
                    alert("["+dsT_EV_ABLTBL.NameValue(i, "EST_NM")+"]["+dsT_EV_ABLTBL.NameValue(i, "ABL_NM")+"]의 행동지표의 점수가 배점기준의 값이 아닙니다.\n해당 점수를 입력하시기 바랍니다.");
                    
                    form1.mgrdT_EV_ABLTBL.Draw = false;
                    form1.mgrdT_EV_ABLTBL.RowPosition    = i;
                    form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_03";
                    form1.mgrdT_EV_ABLTBL.Draw = true;
            
                    form1.mgrdT_EV_ABLTBL.Focus();
                    return false;
                }
             
            }
            
            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
    
            form1.txtEVL_YY_SHR.value     = "<%=EVL_YY%>";
            form1.txtEVL_GBN_SHR.value    = "<%=EVL_GBN%>";
            form1.txtEVL_FRQ_SHR.value    = "<%=EVL_FRQ%>";
            form1.txtIPT_STDT_SHR.value   = "<%=IPT_STDT%>";
            form1.txtIPT_ENDT_SHR.value   = "<%=IPT_ENDT%>";
            form1.txtENO_NO_SHR.value     = "<%=ENO_NO%>";
            form1.txtDEGREE_GBN_SHR.value = "<%=DEGREE_GBN%>";
            form1.txtEVLENO_NO_SHR.value  = "<%=EVLENO_NO%>";
            form1.txtUPDN_GBN_SHR.value   = "<%=UPDN_GBN%>";
            
            if ("<%=GUBUN%>" == "01") {
                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {
                    
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                    
                }
                
            }
            else if ("<%=GUBUN%>" == "02") {
                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;
                
                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }
                
            }
            
            //Grid Style 적용
            //cfStyleGrid(dsT_EV_ABLTBL, "comn", false);
            
            // 그리드에 개인별역량평가대상자설정 데이터 조회
            fnc_SearchList();
            
            form1.txtAVG_PNT.value  = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);
            form1.txtAVG_PNT2.value = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);

        }
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            var SUBPNT_AVG = null;

            if (dsT_EV_ABLTBL.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }
            
            window.close();
            
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLTBL)    |
    | 3. 사용되는 Table List(T_EV_ABLTBL)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr + 주요 테이블명(T_EV_ABLTBL)     |
    | 3. 사용되는 Table List(T_EV_ABLTBL)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_ABLTBL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ABLTBL)">
    </Object>
    
    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    
    <script for=dsT_EV_ABLTBL Event=onColumnChanged(row,colid)>
    
        var SUBPNT_AVG = 0;
        
        if ( colid == 'SUBPNT_01' || 
             colid == 'SUBPNT_02' || 
             colid == 'SUBPNT_03' ) {
                 
            // 점수 입력시 평균값을 구한다. (소수점 둘째자리에서 반올림)
            SUBPNT_AVG = (dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_01') + dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_02') + dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_03')) / 3;
            SUBPNT_AVG = new Number(SUBPNT_AVG).toFixed(2);
            dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_AVG') = SUBPNT_AVG;
            
            form1.txtAVG_PNT.value = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);
        
        }
        
        
        
    </script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLTBL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
        } else {

            // 최초등록자가 없다면 데이터가 역량평가표에 없는 정보임을 flag 필드에 SETTING
            if (dsT_EV_ABLTBL.NameValue(1, "IPT_MAN").trim() == "") {
                
                dsT_EV_ABLTBL.UseChangeInfo = "false";
            }
            
            form1.mgrdT_EV_ABLTBL.Draw = false;
            form1.mgrdT_EV_ABLTBL.RowPosition    = 1;
            form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_01";
            form1.mgrdT_EV_ABLTBL.Draw = true;
            
            form1.mgrdT_EV_ABLTBL.Focus();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLTBL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLTBL Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EV_ABLTBL event="OnSuccess()">
    
        if (form1.txtFLAG.value == "1") {
            dsT_EV_EVLIST_HD.RowPosition = 1;
        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");
            
            form1.txtAVG_PNT2.value = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);
            window.returnValue = new Number(form1.txtAVG_PNT2.value).toFixed(2);
            
        }
        
    </script>
    
    <!--트랜젝션 실패 -->
    <script for=trT_EV_ABLTBL event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>
    
    
    <script language=JavaScript for=mgrdT_EV_ABLTBL event=OnKeyDown(keycode,keystate)>

        if (keycode == 13) {
            
            if (mgrdT_EV_ABLTBL.ColumnPosition == 'SUBPNT_01') {
                mgrdT_EV_ABLTBL.ColumnPosition ='SUBPNT_02';
                mgrdT_EV_ABLTBL.focus();
            }
            else if (mgrdT_EV_ABLTBL.ColumnPosition == 'SUBPNT_02') {
                mgrdT_EV_ABLTBL.ColumnPosition ='SUBPNT_03';
                mgrdT_EV_ABLTBL.focus();
            }
            else if (mgrdT_EV_ABLTBL.ColumnPosition == 'SUBPNT_03') {
                
                if (mgrdT_EV_ABLTBL.RowPosition==dsT_EV_ABLTBL.CountRow) return false;
                
                mgrdT_EV_ABLTBL.RowPosition = mgrdT_EV_ABLTBL.RowPosition + 1;
                mgrdT_EV_ABLTBL.ColumnPosition ='SUBPNT_01';
                mgrdT_EV_ABLTBL.focus();
            }
            
        }

    </script>

    
    

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">역량평가표작성</span></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="580">
        <table width="580" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>피평가자정보 </strong></td>
            </tr>
            <tr>
                <td class="paddingTop3">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="580" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="110"></col>
                            <col width="180"></col>
                            <col width="110"></col>
                            <col width="180"></col>
                        </colgroup>
                        <tr>
                            <td align="center" height="25" class="creamBold">평가구분</td>
                            <td class="padding2423">
                                <input id=txtEVL_YY_SHR  name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly> 년&nbsp;
                                <input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly> 회차
                            </td>
                            <td align="center" class="creamBold">평가기간</td>
                            <td class="padding2423">
                                <input id=txtIPT_STDT_SHR name=txtIPT_STDT_SHR size="10" class="input_ReadOnly" readonly> ~
                                <input id=txtIPT_ENDT_SHR name=txtIPT_ENDT_SHR size="10" class="input_ReadOnly" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">평가그룹</td>
                            <td class="padding2423" class="input_ReadOnly" readonly>
                                <select id=cmbGROUP_CD_SHR name=cmbGROUP_CD_SHR disabled="true">
                                </select>
                            </td>
                            <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
                            <td class="padding2423"><input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="28" class="input_ReadOnly" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">피평가자</td>
                            <td class="padding2423">
                                <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly>
                                <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="14" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">평가자</td>
                            <td class="padding2423">
                                <input id=txtDEGREE_GBN_SHR name=txtDEGREE_GBN_SHR size="2" maxlength=2 class="input_ReadOnly" readonly> 차 평가자&nbsp;
                                <input id=txtEVLENO_NM_SHR  name=txtEVLENO_NM_SHR size="12" class="input_ReadOnly" readonly>
                            </td>
                            <!-- Hidden Filed -->
                            <input type=hidden id=txtEVL_GBN_SHR   name=txtEVL_GBN_SHR>
                            <input type=hidden id=txtEVLENO_NO_SHR name=txtEVLENO_NO_SHR>
                            <input type=hidden id=txtUPDN_GBN_SHR  name=txtUPDN_GBN_SHR>
                            <input type=hidden name=txtFLAG>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
        <td width="20">&nbsp;</td>
        <td width="200">
        <table width="200" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>배점기준 </strong></td>
            </tr>
            <tr>
                <td class="paddingTop3">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="200" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="45"></col>
                            <col width="65"></col>
                            <col width="45"></col>
                            <col width="65"></col>
                        </colgroup>
                        <tr>
                            <td height="25" class="creamBold" align="center">탁월</td>
                            <td class="padding2423">&nbsp;9 ~ 10</td>
                            <td class="creamBold" align="center">우수</td>
                            <td class="padding2423">&nbsp;7 ~ 8</td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center">양호</td>
                            <td class="padding2423">&nbsp;5 ~ 6</td>
                            <td class="creamBold" align="center">미흡</td>
                            <td class="padding2423">&nbsp;3 ~ 4</td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center">부족</td>
                            <td class="padding2423" colspan="3">&nbsp;1 ~ 2</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
<table>
    
<!-- 조건 입력 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15" width="600" ><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>평가점수입력 </strong>
        </td>
        <td width="200" align="right" class="searchState" valign="bottom">
            평가점수 계&nbsp;<input id=txtAVG_PNT  name=txtAVG_PNT size="6" style="text-align:right;font-weight:bold;" readonly>
            <!-- DB에 반영된 데이터의 실제 평균값 (호출한 화면에 넘겨주기 위한 변수)-->
            <input type=hidden id=txtAVG_PNT2  name=txtAVG_PNT2 size="5" >
        </td>
    </tr>
</table>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="mgrdT_EV_ABLTBL" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=800 height=304>
                            <Param Name="DataID"         value="dsT_EV_ABLTBL">
                            <Param Name="IndicatorInfo"     value='<INDICATORINFO width="0"></INDICATORINFO>'>
                            <param name="Sort"           value="false">
                            <Param Name="ColumnInfo"     value='
                              <COLUMNINFO>
                                <COLUMN id="EST_NM" refcolid="EST_NM">
                                    <HEADER left="0" top="0" right="70" bottom="35" bgcolor="#F7DCBB" text="구 분"/>
                                    <SUPPRESS>
                                        <REFCOLID>EST_NM</REFCOLID>
                                    </SUPPRESS>
                                    <VIEW   left="0" top="0" right="70" bottom="66" bgcolor="#FEFBF6" align="centercenter"/>
                                </COLUMN>
                                <COLUMN id="ABL_NM" refcolid="ABL_NM">
                                    <HEADER left="70" top="0" right="140" bottom="35" bgcolor="#F7DCBB" text="역 량 명"/>
                                    <VIEW   left="70" top="0" right="140" bottom="66" bgcolor="#FEFBF6" align="centercenter"/>
                                </COLUMN>
                                <COLUMN id="SUBITEM_01" refcolid="SUBITEM_01">
                                    <HEADER left="140" top="0" right="660" bottom="35" bgcolor="#F7DCBB" text="행      동      지      표"/>
                                    <VIEW   left="140" top="0" right="660" bottom="22" bgcolor="#FEFBF6" align="leftcenter"/>
                                </COLUMN>
                                <COLUMN id="SUBITEM_02" refcolid="SUBITEM_02">
                                    <HEADER left="140" top="0"  right="660" bottom="35" bgcolor="#F7DCBB" text="행      동      지      표"/>
                                    <VIEW   left="140" top="22" right="660" bottom="44" bgcolor="#FEFBF6" align="leftcenter"/>
                                </COLUMN>
                                <COLUMN id="SUBITEM_03" refcolid="SUBITEM_03">
                                    <HEADER left="140" top="0"  right="660" bottom="35" bgcolor="#F7DCBB" text="행      동      지      표"/>
                                    <VIEW   left="140" top="44" right="660" bottom="66" bgcolor="#FEFBF6" align="leftcenter"/>
                                </COLUMN>

                                <COLUMN id="SUBPNT_01" refcolid="SUBPNT_01">
                                    <HEADER left="660" top="0" right="695" bottom="35" bgcolor="#F7DCBB" text="점수"/>
                                    <VIEW   left="660" top="0" right="695" bottom="22" align="rightcenter"/>
                                    <CHILD type="edit" inputtype="num"/>
                                </COLUMN>
                                <COLUMN id="SUBPNT_02" refcolid="SUBPNT_02">
                                    <HEADER left="660" top="0"  right="695" bottom="35" bgcolor="#F7DCBB" text="점수"/>
                                    <VIEW   left="660" top="22" right="695" bottom="44" align="rightcenter"/>
                                    <CHILD type="edit" inputtype="num"/>
                                </COLUMN>
                                <COLUMN id="SUBPNT_03" refcolid="SUBPNT_03">
                                    <HEADER left="660" top="0"  right="695" bottom="35" bgcolor="#F7DCBB" text="점수"/>
                                    <VIEW   left="660" top="44" right="695" bottom="66" align="rightcenter"/>
                                    <CHILD type="edit" inputtype="num"/>
                                </COLUMN>

                                <COLUMN id="WEIGHT" refcolid="WEIGHT">
                                    <HEADER left="695" top="0" right="740" bottom="35" bgcolor="#F7DCBB" text="가중치"/>
                                    <VIEW   left="695" top="0" right="740" bottom="66" bgcolor="#FEFBF6" align="rightcenter"/>
                                </COLUMN>    
                                <COLUMN id="SUBPNT_AVG" refcolid="SUBPNT_AVG">
                                    <HEADER left="740" top="0" right="778" bottom="35" bgcolor="#F7DCBB"  text="평균"/>
                                    <VIEW   left="740" top="0" right="778" bottom="66" bgcolor="#FEFBF6" align="rightcenter"/>
                                </COLUMN>
                             </COLUMNINFO>'>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가대상자설정 테이블 -->
<object id="bndT_EV_EVLIST_HD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_EVLIST_HD">
    <Param Name="BindInfo", Value='
        <C>Col=EVL_YY       Ctrl=txtEVL_YY_SHR     Param=value </C>
        <C>Col=EVL_GBN      Ctrl=txtEVL_GBN_SHR    Param=value </C>
        <C>Col=EVL_FRQ      Ctrl=txtEVL_FRQ_SHR    Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO_SHR     Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM_SHR     Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM_SHR     Param=value </C>
        <C>Col=GROUP_CD     Ctrl=cmbGROUP_CD_SHR   Param=value </C>
        <C>Col=DEGREE_GBN   Ctrl=txtDEGREE_GBN_SHR Param=value </C>
        <C>Col=EVLENO_NO    Ctrl=txtEVLENO_NO_SHR  Param=value </C>
        <C>Col=EVLENO_NM    Ctrl=txtEVLENO_NM_SHR  Param=value </C>
    '>
</object>
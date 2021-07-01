<!--
*****************************************************
* @source      : vlua020.jsp
* @description : KPI Pool 설정 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/21      오대성        최초작성.
* 2007/03/15      박인이        수정. (직무평가업무내용 추가)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%> 

<!-- Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}</script>

<html>
<head>
<title>KPI Pool 설정(vlua020)</title>
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

        var btnList = 'TTTTFFTT';
        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            
            var form     = document.form1;
            var gubun    = GUBUN;
            var kpi_cd   = form.txtKPI_CD_SHR.value;
            var kpi_gb   = form.cmbKPI_GB_SHR.value;
            var checked  = '';
            
            if(form.chkEND_YN_SHR.checked){
                checked = 'T';
            } else {
                checked = 'F';
            }
            
            dsT_EV_KPIPOOL.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua020.cmd.VLUA020CMD&S_MODE=SHR&GUBUN="+gubun+"&KPI_CD="+kpi_cd+"&KPI_GB="+kpi_gb+"&CHECK="+checked;
            dsT_EV_KPIPOOL.reset();

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
            
            if(fnc_SaveItemCheck()) {
                trT_EV_KPIPOOL.KeyValue = "tr01(I:dsT_EV_KPIPOOL=dsT_EV_KPIPOOL)";
                trT_EV_KPIPOOL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua020.cmd.VLUA020CMD&S_MODE=SAV";
                trT_EV_KPIPOOL.post();
            } else {
                return;
            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            
            if(dsT_EV_KPIPOOL.CountRow < 1) {
                alert("삭제할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if(confirm("KPI코드 ["+dsT_EV_KPIPOOL.NameValue(dsT_EV_KPIPOOL.RowPosition,"KPI_CD")+"] 정보를 삭제하시겠습니까?")){
                dsT_EV_KPIPOOL.DeleteRow(dsT_EV_KPIPOOL.RowPosition);
                trT_EV_KPIPOOL.KeyValue = "tr01(I:dsT_EV_KPIPOOL=dsT_EV_KPIPOOL)";
                trT_EV_KPIPOOL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua020.cmd.VLUA020CMD&S_MODE=DEL";
                trT_EV_KPIPOOL.post();
            }

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

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
            
            //DataSet에 Header가 정의되어 있지 않는 경우
            if(dsT_EV_KPIPOOL.CountColumn < 1){
                // 데이터셋의 헤더 정보 설정.
                // KEY : KPI_CD
                dsT_EV_KPIPOOL.setDataHeader("GUBUN:STRING, KPI_CD:STRING(4):KEYVALUETYPE, KPI_NM:STRING, KPI_DEC:STRING, KPI_GB:STRING, GAUGE_GB:STRING, FORMULAS:STRING, STR_YMD:STRING, END_YMD:STRING");
            }
            
            dsT_EV_KPIPOOL.AddRow();                                    //Row 추가
            
            fnc_ColEnabled('E');
            
            document.getElementById("txtKPI_CD").focus();               //입력 첫번째로 FOCUS
            document.getElementById("txtGUBUN").value   = GUBUN;        // 업무구분
            document.getElementById("txtSTR_YMD").value = getToday();   //등록일자 입력란에 오늘 날짜 표시
            
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
            
            var form = document.form1;
            
            form.txtKPI_CD_SHR.value = '';
            form.cmbKPI_GB_SHR.value = '';
            form.chkEND_YN_SHR.checked = false;
            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_EV_KPIPOOL.ClearData();

            fnc_ColEnabled('D');
            
            form.txtKPI_CD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_KPIPOOL.IsUpdated)  {
                
                if (!fnc_ExitQuestion()) return;
            
            }
            
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            var form = document.form1;
            //DataSet의 변경 여부 확인
            if (!dsT_EV_KPIPOOL.IsUpdated ) {
                    alert("저장할 자료가 없습니다.");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                    return false;
            }
            
            for(i=0;i<dsT_EV_KPIPOOL.CountRow;i++){
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_CD") == '') {
                    alert("KPI 코드는 필수 입력 항목입니다.");
                    form.txtKPI_CD.focus();
                    return false;
                } else if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_CD").length != 4) {
                    alert("코드는 반드시 4자리로 입력 하세요!.");
                    form.txtKPI_CD.focus();
                    return false;
                } else if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_NM") == '') {
                    alert("KPI 명은 필수 입력 항목입니다.");
                    dsT_EV_KPIPOOL.RowPosition = i+1;
                    form.txtKPI_NM.focus();
                    return false;
                }else if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_GB") == '') {
                    alert("KPI 구분은 필수 입력 항목입니다.");
                    dsT_EV_KPIPOOL.RowPosition = i+1;
                    form.cmbKPI_GB.focus();
                    return false;
                }else if (dsT_EV_KPIPOOL.NameValue(i+1,"GAUGE_GB") == '') {
                    alert("계량 구분은 필수 입력 항목입니다.");
                    dsT_EV_KPIPOOL.RowPosition = i+1;
                    form.cmbGAUGE_GB.focus();
                    return false;
                }
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD") != '') {
                    if (!cfDateExpr(dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD"))){
                        alert("등록일자가 날짜형식에 맞지 않습니다.");
                        dsT_EV_KPIPOOL.RowPosition = i+1;
                        form.txtSTR_YMD.focus();
                        return false;
                    }
                }
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD") != '') {
                    if (!cfDateExpr(dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD"))){
                        alert("폐기일자가 날짜형식에 맞지 않습니다.");
                        dsT_EV_KPIPOOL.RowPosition = i+1;
                        form.txtEND_YMD.focus();
                        return false;
                    }
                }
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD") != '' && dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD") != '') {
                    if(removeChar(dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD"),'-') > removeChar(dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD"),'-')) {
                        alert("등록일자는 반드시 폐기일자보다 작아야합니다.");
                        form.txtSTR_YMD.focus();
                        return false;
                    }
                }

            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_KPIPOOL,15,"false","right")      // Grid Style 적용
            
            // 업무구분
            if (frameid == "vlua020") {
                // 인사평가
                GUBUN = "01";                
                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";
            }
            else {
                // 직무평가
                GUBUN = "02";            
                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }
            
            fnc_ColEnabled('D');
            
            form1.txtKPI_CD_SHR.focus();                               // 처음 항목에 Focus

        }


        /****************************************
         * 15. 숫자와 영문자만 들어가도록 체크  *
         ***************************************/
        function fnc_NumCharCheck() {
            if (!((event.keyCode > 47)&&(event.keyCode < 58)) && 
                !((event.keyCode > 64)&&(event.keyCode < 91)) && 
                !((event.keyCode > 96)&&(event.keyCode < 123))) {
                    event.returnValue=false;
                }
            }

        /********************
         * 16. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }
        
        
        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {
            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                form1.txtKPI_CD.disabled   = false;
                form1.txtKPI_NM.disabled   = false;
                form1.txtKPI_DEC.disabled  = false;
                form1.cmbKPI_GB.disabled   = false;
                form1.cmbGAUGE_GB.disabled = false;
                form1.txtFORMULAS.disabled = false;
                form1.txtSTR_YMD.disabled  = false;
                form1.txtEND_YMD.disabled  = false;
                
                document.getElementById("image20").disabled=false;
                document.getElementById("image21").disabled=false;
            }
            // 해당 컬럼의 속성을 Disabled로 변경
            else if (prop == 'D') {
                form1.txtKPI_CD.disabled   = true;
                form1.txtKPI_NM.disabled   = true;
                form1.txtKPI_DEC.disabled  = true;
                form1.cmbKPI_GB.disabled   = true;
                form1.cmbGAUGE_GB.disabled = true;
                form1.txtFORMULAS.disabled = true;
                form1.txtSTR_YMD.disabled  = true;
                form1.txtEND_YMD.disabled  = true;
                
                document.getElementById("image20").disabled=true;
                document.getElementById("image21").disabled=true;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_KPIPOOL)   |
    | 3. 사용되는 Table List(T_EV_KPIPOOL)          |
    +----------------------------------------------->
    <object id="dsT_EV_KPIPOOL" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"       value="true">
        <param name="UseChangeInfo"  value="true">
    </object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_KPIPOOL)   |
    | 3. 사용되는 Table List(TEST_T_EV_KPIPOOLMAIN) |
    +----------------------------------------------->
    <object id="trT_EV_KPIPOOL" classid=CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5>
        <param name=KeyName value="toinb_dataid4">
    </object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    <script language=JavaScript for="dsT_EV_KPIPOOL" event=OnLoadCompleted(iCount)>
        
            if (iCount < 1)    {

                fnc_Message(document.getElementById("resultMessage"), "MSG_02");
                
                fnc_ColEnabled('D');
                
                document.form1.txtKPI_CD_SHR.focus();

            } else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
                
                fnc_ColEnabled('E');
                
                document.form1.grdT_EV_KPIPOOL.focus();

            }

    </script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <script language="javascript"  for="dsT_EV_KPIPOOL" event="OnLoadError()">
        
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_KPIPOOL Event="OnDataError(row, colid)">

        //Dataset관련 Error 처리
        //alert(row + " : " + colid);
        // 키가 NOT NULL인 경우
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[KPI코드] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("KPI코드에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script language="javascript" for=trT_EV_KPIPOOL event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script language="javascript" for=trT_EV_KPIPOOL event="OnFail()">
        
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">KPI Pool 설정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">KPI Pool 설정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="15"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="center" class="searchBold">KPI코드/명&nbsp;</td>
                                <td><input name="txtKPI_CD_SHR" id="txtKPI_CD_SHR" class="divInput" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()" size="15"></td>
                                <td align="right" class="searchBold">KPI구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbKPI_GB_SHR" onChange="fnc_SearchList()">
                                        <option value="">전체</option>
                                        <option value="1">영업</option>
                                        <option value="2">운영</option>
                                        <option value="3">기획/지원</option>
                                    </select> </td>
                                <td class="padding2423">
                                    <input type="checkbox" name="chkEND_YN_SHR" id=chkEND_YN_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()"></td>
                                <td align="left" class="searchBold">폐기자료포함</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                    <td align="center" class="creamBold">KPI코드</td>
                    <td class="padding2423"><input id=txtKPI_CD size="8" maxlength="4" style="ime-mode:disabled" onkeypress="fnc_NumCharCheck();"></td>
                    <td align="center" class="creamBold">KPI명</td>
                    <td class="padding2423"><input id=txtKPI_NM value="" size="16" maxlength="50"></td>
                    <td align="center" class="creamBold">KPI요약</td>
                    <td class="padding2423"><input id=txtKPI_DEC value="" style="WIDTH: 100%" maxlength="100">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">KPI구분</td>
                    <td class="padding2423">
                        <select id="cmbKPI_GB" style="WIDTH: 100%">
                            <option value="1">영업</option>
                            <option value="2">운영</option>
                            <option value="3">기획/지원</option>
                        </select> </td>
                    <td align="center" class="creamBold">계량구분</td>
                    <td class="padding2423">
                        <select id="cmbGAUGE_GB" style="WIDTH: 100%">
                            <option value="1">계량</option>
                            <option value="2">비계량</option>
                        </select> </td>
                    <td align="center" class="creamBold">산출식</td>
                    <td class="padding2423"><input id="txtFORMULAS" value="" style="WIDTH: 100%" maxlength="50">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">등록일자</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD');cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','45','150');"></a>
                    </td>
                    <td align="center" class="creamBold">폐기일자</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD');cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image21" name="Image21" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','235','150');"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_KPIPOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
                            <param name="DataID"                    value="dsT_EV_KPIPOOL">
                            <param name="Format"                    value="
                                <C> id='KPI_CD'      width=80       name='KPI코드'        align=center</C>
                                <C> id='KPI_NM'      width=150      name='KPI명'          align=left </C>
                                <C> id='KPI_DEC'     width=200      name='KPI요약'        align=left </C>
                                <C> id='KPI_GB'      width=80       name='KPI구분'        align=left EditStyle=Combo Data='1:영업,2:운영,3:기획/지원'</C>
                                <C> id='GAUGE_GB'    width=100      name='계량구분'       align=left EditStyle=Combo Data='1:계량,2:비계량'</C>
                                <C> id='FORMULAS'    width=154      name='산술식'         align=left </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- KPI Pool 설정 테이블 -->
<object id="bndT_EV_KPIPOOL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_KPIPOOL">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN           Ctrl=txtGUBUN           Param=value  Disable=disabled</C>
        <C>Col=KPI_CD          Ctrl=txtKPI_CD          Param=value  Disable=disabled</C>
        <C>Col=KPI_NM          Ctrl=txtKPI_NM          Param=value</C>
        <C>Col=KPI_DEC         Ctrl=txtKPI_DEC         Param=value</C>
        <C>Col=KPI_GB          Ctrl=cmbKPI_GB          Param=value</C>
        <C>Col=GAUGE_GB        Ctrl=cmbGAUGE_GB        Param=value</C>
        <C>Col=FORMULAS        Ctrl=txtFORMULAS        Param=value</C>
        <C>Col=STR_YMD         Ctrl=txtSTR_YMD         Param=value</C>
        <C>Col=END_YMD         Ctrl=txtEND_YMD         Param=value</C>
    '>
</object>

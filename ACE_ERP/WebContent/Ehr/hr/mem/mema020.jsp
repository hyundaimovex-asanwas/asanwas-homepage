<!--
    ************************************************************************************
    * @Source         : mema020.jsp                                                    *
    * @Description    : 용역비변경내역 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>용역비변경내역</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        var chn_ymd = '';
        var seq_no  = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ME_APY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema020.cmd.MEMA020CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_APY.Reset();

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

                trT_ME_APY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema020.cmd.MEMA020CMD&S_MODE=SAV";
                trT_ME_APY.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ME_APY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_APY.RowStatus(dsT_ME_APY.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ME_APY.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("변경일자[" + dsT_ME_APY.NameValue(dsT_ME_APY.RowPosition,"CHN_YMD") + "] [" + dsT_ME_APY.NameValue(dsT_ME_APY.RowPosition,"SEQ_NO") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ME_APY.DeleteRow(dsT_ME_APY.RowPosition);

            if (status != 1) {
                trT_ME_APY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema020.cmd.MEMA020CMD&S_MODE=DEL";
                trT_ME_APY.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_APY.SetColumn(form1.grdT_ME_APY.GetColumnID(0));
            form1.grdT_ME_APY.Focus();

            bnd.ActiveBind = true;

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_ME_APY.CountColumn == 0) {
                dsT_ME_APY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, CHN_YMD:STRING:KEYVALUETYPE, SEQ_NO:INT:KEYVALUETYPE, OCC_CD:STRING, APP_CD:STRING, JOB_CD:STRING, JOB_NM:STRING, HOB_CD:STRING, HOB_NM:STRING, BAS_AMT:INT, WEL_AMT:INT, LSEV_AMT1:INT, LSEV_AMT2:INT, LSEV_AMT3:INT, SUM_AMT:INT, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_APY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_APY.setColumn(form1.grdT_ME_APY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtCHN_YMD").disabled = false;
            document.getElementById("ImgChnYmd").disabled  = false;

            document.getElementById("txtCHN_YMD").focus();
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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_APY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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

            var f = document.form1;

            //DataSet의 변경 여부 확인
            if (!dsT_ME_APY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_APY.CountRow; i++ ) {
                if ( dsT_ME_APY.RowStatus(i) == 1 ||
                     dsT_ME_APY.RowStatus(i) == 3 ) {

                    // 변경일자
                    if( dsT_ME_APY.NameValue(i, "CHN_YMD") == '' ) {
                        alert("변경일자는 필수 입력사항입니다.");
                        dsT_ME_APY.RowPosition = i;
                        document.getElementById("txtCHN_YMD").focus();
                        return false;
                    }

                    // 변경일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_APY.NameValue(i, "CHN_YMD"), "변경일자") && dsT_ME_APY.NameValue(i, "CHN_YMD") != "") {
                        dsT_ME_APY.RowPosition = i;
                        document.getElementById("txtCHN_YMD").focus();
                        return false;
                    }

                    // 파견단가
                    if( dsT_ME_APY.NameValue(i, "BAS_AMT") == '' ) {
                        alert("파견단가는 필수 입력사항입니다.");
                        dsT_ME_APY.RowPosition = i;
                        form1.medBAS_AMT.focus();
                        return false;
                    }

                    if ( dsT_ME_APY.RowStatus(i) == 1) {
                        document.getElementById("txtCHN_YMD").disabled = true;
                        document.getElementById("ImgChnYmd").disabled  = true;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style 적용
            cfStyleGrid(form1.grdT_ME_APY, 0,"false","false");

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_ME_APY.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

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

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtCHN_YMD").disabled = false;
                form1.medBAS_AMT.enable                        = true;
                form1.medWEL_AMT.enable                        = true;
                form1.medLSEV_AMT1.enable                      = true;
                form1.medLSEV_AMT2.enable                      = true;
                form1.medLSEV_AMT3.enable                      = true;
                form1.medSUM_AMT.enable                        = false;
                document.getElementById("txtREMARK").disabled  = false;

                document.getElementById("ImgChnYmd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtCHN_YMD").disabled = true;
                form1.medBAS_AMT.enable                        = false;
                form1.medWEL_AMT.enable                        = false;
                form1.medLSEV_AMT1.enable                      = false;
                form1.medLSEV_AMT2.enable                      = false;
                form1.medLSEV_AMT3.enable                      = false;
                form1.medSUM_AMT.enable                        = false;
                document.getElementById("txtREMARK").disabled  = true;

                document.getElementById("ImgChnYmd").disabled  = true;

            }
        }


        function fnc_getSeqNo(obj) {
            var SysStatus = dsT_ME_APY.SysStatus(dsT_ME_APY.RowPosition);
            var SeqNo = 0;

            if (SysStatus == 1) {

                document.getElementById("txtSEQ_NO").value = '';

                if (obj.value != '') {

                    for (var i = 1; i <= dsT_ME_APY.CountRow; i++) {

                        if (dsT_ME_APY.NameValue(i, "CHN_YMD") == obj.value &&
                            dsT_ME_APY.NameValue(i, "SEQ_NO") >= SeqNo      &&
                            i != dsT_ME_APY.RowPosition) {

                           SeqNo = new Number(dsT_ME_APY.NameValue(i, "SEQ_NO")) + 1;

                        }
                    }

                    if (SeqNo == 0) {
                        SeqNo = 1;
                    }

                    document.getElementById("txtSEQ_NO").value = SeqNo;
                }
            }

            chn_ymd = document.getElementById("txtCHN_YMD").value;
            seq_no  = document.getElementById("txtSEQ_NO").value;

        }

        function fnc_BlurYmd() {
            if (chn_ymd == document.getElementById("txtCHN_YMD").value &&
                seq_no  == document.getElementById("txtSEQ_NO").value) {
                return;
            }

            fnc_getSeqNo(document.getElementById("txtCHN_YMD"));

        }

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_APY                          |
    | 3. Table List : T_ME_APY                      |
    +----------------------------------------------->
    <Object ID="dsT_ME_APY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_APY                          |
    | 3. Table List : T_ME_APY                      |
    +----------------------------------------------->
    <Object ID ="trT_ME_APY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_APY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 해당 값이 변경될 때 합계 값을 구함               |
    +-------------------------------------------------->
    <script language=JavaScript for= medBAS_AMT event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medLSEV_AMT1 event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medLSEV_AMT2 event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medLSEV_AMT3 event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medWEL_AMT event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_APY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_APY.CountRow);

            document.getElementById("txtCHN_YMD").disabled = true;
            document.getElementById("ImgChnYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_APY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_APY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[변경일자/SEQ번호] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("변경일자/SEQ번호에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_APY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_APY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_APY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_APY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtCHN_YMD").disabled = false;
            document.getElementById("ImgChnYmd").disabled  = false;

        }
        else {
            document.getElementById("txtCHN_YMD").disabled = true;
            document.getElementById("ImgChnYmd").disabled  = true;

        }

    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>용역비변경내역</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">   <img src="/images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="95 "></col>
                    <col width="100"></col>
                    <col width="85"></col>
                    <col width="100"></col>
                    <col width="95 "></col>
                    <col width="100"></col>
                    <col width="95 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">일&nbsp;&nbsp;&nbsp;&nbsp;자</td>
                    <td class="padding2423" >
                        <input id="txtCHN_YMD" style="width:68%;ime-mode:disabled" maxlength="10" onBlur="fnc_BlurYmd();" onChange="javascript : if (fnc_CheckDate(this, '변경일자')) {fnc_getSeqNo(this);}" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgChnYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgChnYmd" name="ImgChnYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCHN_YMD','','350','55');"></a>
                    </td>
                    <td align="center" class="creamBold">파견단가</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">근속장려금(6)</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLSEV_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">근속장려금(12)</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLSEV_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">근속장려금(18)</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLSEV_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">기타수당</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medWEL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">용역비 계</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423">
                        <input id="txtREMARK" maxlength="20" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtSEQ_NO" size="1">
                    <input type=hidden   id="txtOCC_CD" size="1">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
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
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_ME_APY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:178px;">
                            <param name="DataID"                  value="dsT_ME_APY">
                            <param name="Format"                  value="
                                <C> id={currow}       width=39    name='순번'         align=center </C>
                                <C> id=CHN_YMD        width=90    name='일자'         align=center </C>
                                <C> id=BAS_AMT        width=90    name='파견단가'                  </C>
                                <C> id=LSEV_AMT1      width=90    name='근속장려금(6)'             </C>
                                <C> id=LSEV_AMT2      width=90    name='근속장려금(12)'            </C>
                                <C> id=LSEV_AMT3      width=90    name='근속장려금(18)'            </C>
                                <C> id=WEL_AMT        width=90    name='기타수당'                  </C>
                                <C> id=SUM_AMT        width=90    name='용역비 계'                 </C>
                                <C> id=REMARK         width=104   name='비고'                      </C>
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
<!-- 용역비변경내역 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_APY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=CHN_YMD       Ctrl=txtCHN_YMD      Param=value Disable=disabled</C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value Disable=disabled</C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=APP_CD        Ctrl=txtAPP_CD       Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=HOB_CD        Ctrl=txtHOB_CD       Param=value </C>
        <C> Col=BAS_AMT       Ctrl=medBAS_AMT      Param=text  </C>
        <C> Col=WEL_AMT       Ctrl=medWEL_AMT      Param=text  </C>
        <C> Col=LSEV_AMT1     Ctrl=medLSEV_AMT1    Param=text  </C>
        <C> Col=LSEV_AMT2     Ctrl=medLSEV_AMT2    Param=text  </C>
        <C> Col=LSEV_AMT3     Ctrl=medLSEV_AMT3    Param=text  </C>
        <C> Col=SUM_AMT       Ctrl=medSUM_AMT      Param=text  </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
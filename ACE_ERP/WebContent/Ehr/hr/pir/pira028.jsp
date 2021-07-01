<!--
    ************************************************************************************
    * @Source         : pira028.jsp                                                    *
    * @Description    : 교육사항 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>교육사항</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_EDUCATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira028.cmd.PIRA028CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_EDUCATION.Reset();

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

                trT_CM_EDUCATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira028.cmd.PIRA028CMD&S_MODE=SAV";
                trT_CM_EDUCATION.post();

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
            if (dsT_CM_EDUCATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_EDUCATION.RowStatus(dsT_CM_EDUCATION.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_EDUCATION.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("과정코드명["+ dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition,"EDU_NM") + "], 차수[" + dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition,"SEQ_NO") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_EDUCATION.DeleteRow(dsT_CM_EDUCATION.RowPosition);

            if (status != 1) {
                trT_CM_EDUCATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira028.cmd.PIRA028CMD&S_MODE=DEL";
                trT_CM_EDUCATION.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_EDUCATION.SetColumn(form1.grdT_CM_EDUCATION.GetColumnID(0));
            form1.grdT_CM_EDUCATION.Focus();

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
            if (dsT_CM_EDUCATION.CountColumn == 0) {
                dsT_CM_EDUCATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING, END_YMD:STRING, PLACE_CD:STRING, PLACE_NM:STRING, INT_NAM:STRING, EDU_CD:STRING:KEYVALUETYPE, EDU_NM:STRING, SEQ_NO:STRING:KEYVALUETYPE, EDU_GBN_CD:STRING, EDU_TAG:STRING, APP_VAL:STRING, DPT_CD:STRING, JOB_CD:STRING, EDU_AMT:INT, TRA_AMT:INT, BOLO_AMT:INT, REMARK:STRING, EDU_NM:STRING, CPT_PNT:INT");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_EDUCATION.AddRow();


            document.getElementById("cmbEDU_TAG").disabled  = false;
            document.getElementById("txtEDU_CD").enabled      = true;
            document.getElementById("cmbEDU_TAG").enabled     = true;
            document.getElementById("txtREMARK").disabled      = false;
            document.getElementById("txtREMARK").enabled      = true;

            form1.grdT_CM_EDUCATION.setColumn(form1.grdT_CM_EDUCATION.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;
            document.getElementById("txtEDU_CD").focus();


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

			dsT_CM_EDUCATION.ClearData();
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
            if (!dsT_CM_EDUCATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_EDUCATION.CountRow; i++ ) {
            	
                if ( dsT_CM_EDUCATION.RowStatus(i) == 1 || dsT_CM_EDUCATION.RowStatus(i) == 3 ) {

                    // 교육장소
                    if( dsT_CM_EDUCATION.NameValue(i, "PLACE_CD") == '' ) {
                    	
                        alert("교육장소코드는 필수 입력사항입니다.");
                        
                        dsT_CM_EDUCATION.RowPosition = i;
                        
                        document.getElementById("txtPLACE_CD").focus();
                        
                        return false;
                        
                    }

                    // 교육장소
                    if (dsT_CM_EDUCATION.NameValue(i, "PLACE_CD") != "" && dsT_CM_EDUCATION.NameValue(i, "PLACE_NM") == "") {
                    	
                        alert("교육장소코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        
                        dsT_CM_EDUCATION.RowPosition = i;
                        
                        document.getElementById("txtPLACE_CD").focus();
                        
                        return;
                    }

                    // 과정코드
                    if( dsT_CM_EDUCATION.NameValue(i, "EDU_CD") == '' ) {
                    	
                        alert("과정코드는 필수 입력사항입니다.");
                        
                        dsT_CM_EDUCATION.RowPosition = i;

                        return false;
                    }


                    if ( dsT_CM_EDUCATION.RowStatus(i) == 1) {

                       document.getElementById("ImgEduCd").disabled   = false;

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
            cfStyleGrid_New(form1.grdT_CM_EDUCATION, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_PERSON.IsUpdated)  {
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
                document.getElementById("cmbEDU_TAG").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;
                document.getElementById("ImgEduCd").disabled       = false;
            }
            else if (prop == 'D') {
                document.getElementById("cmbEDU_TAG").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;
                document.getElementById("ImgEduCd").disabled       = true;
            }
        }


        //과정코드 팝업
        function fnc_eduPopup(){

            //과정코드(T_CM_COMMON, Q1) 조회용 팝업
            obj = fnc_eduCode_Popup();

            if(obj.edu_cd == "") {
                return;
            }

            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_CD")  = obj.edu_cd;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_NM")  = obj.edu_nm;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "SEQ_NO")  = obj.seq_no;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_NM") = obj.edu_nm;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "STR_YMD") = obj.edu_str_ymd;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "END_YMD") = obj.edu_end_ymd;

            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "DECISION_CD") = "D";
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_TAG") = "Y";


            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_GBN_CD")  = obj.edu_gbn_cd;


            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "INT_NAM")  = obj.int_nam;//시행처
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "PLACE_CD") = obj.place_cd;//교육장소코드
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "PLACE_NM") = obj.place_nm;//교육장소명
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "CPT_PNT") =  obj.cpt_pnt;//이수점수

        }


		// 과정코드(T_CM_COMMON, Q1) 조회용 팝업
		function fnc_eduCode_Popup() {
			var obj = new String();
			window.showModalDialog("/common/popup/educourse.jsp", obj, "dialogWidth:500px; dialogHeight:525px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      		return obj;//return edu_cd, seq_no, Str_ymd, end_ymd, int_nam, place_cd, place_nm, cpt_pnt
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
    | 2. 이름 : dsT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_EDUCATION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
        	
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');
            
        } else {
        	
            fnc_ColEnabled('E');
            
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_EDUCATION.CountRow);

            document.getElementById("ImgEduCd").disabled   = true;
            
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {

            document.getElementById("ImgEduCd").disabled   = false;
            
            alert("해당 필수입력항목[교육기간/과정코드/차수] 입력 후 다음 작업이 가능합니다.");
            
        }
        else if (this.ErrorCode == 50020) {

            document.getElementById("ImgEduCd").disabled   = false;
            
            alert("교육기간/과정코드/차수에 대한 중복값이 존재합니다. 확인바랍니다.");
            
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_EDUCATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_EDUCATION event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_EDUCATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_EDUCATION.SysStatus(row);

        if (SysStatus == 1) {

            document.getElementById("ImgEduCd").disabled   = false;

        }
        else {

            document.getElementById("ImgEduCd").disabled   = true;

        }

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>교육사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">   <img src="../../images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','../../images/button/btn_CancelOver.gif',1)"> <img src="../../images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="160"></col>
                    <col width="70 "></col>
                    <col width="110 "></col>
                    <col width="70 "></col>
                    <col width="105 "></col>
                    <col width="70 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">과정코드명</td>
                    <td class="padding2423">
                        <input id="txtEDU_CD" size="10" maxlength="10" >
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_eduPopup()"></a>
                    </td>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423">
                        <input id="txtPLACE_CD" size="2" maxlength="2" onChange="fnc_GetCommNm('Q9', 'txtPLACE_CD','txtPLACE_NM');"> <input id="txtPLACE_NM" style="width:74%">
                    </td>
                    <td align="center" class="blueBold">차&nbsp;&nbsp;&nbsp;&nbsp;수</td>
                    <td class="padding2423">
                        <input id="txtSEQ_NO" style="width:100%;">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육기간</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        ~
                        <input id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">필수여부</td>
                    <td class="padding2423" >
                        <select id="cmbEDU_GBN_CD" style="width:100%" >
                            <option value="AA" >필수</option>
                            <option value="AB" >선택</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">수료여부</td>
                    <td class="padding2423">
                        <select id="cmbEDU_TAG" style="width:100%" >
                            <option value="Y" >수료</option>
                            <option value="N" >미수료</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육과정명</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_NM" style="width:100%;">
                    </td>
                    <td align="center" class="blueBold">시 행 처</td>
                    <td class="padding2423">
                        <input id="txtINT_NAM" maxlength="22" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423">
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">이수학점</td>
                    <td class="padding2423">
                        <input id="txtCPT_PNT" maxlength="5" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="blueBold"></td>
                    <td class="padding2423">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtOCC_CD" size="1">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="Format"                  value="
                                <C> id={currow}        width=29     name='순번'            align=center </C>
                                <C> id=STR_YMD         width=80     name='시작일'          align=center </C>
                                <C> id=END_YMD         width=80     name='종료일'          align=center </C>
                                <C> id=EDU_CD          width=100     name='과정코드'        align=center </C>
                                <C> id=PLACE_NM        width=60     name='교육장소'        align=center </C>
                                <C> id=SEQ_NO          width=50     name='차수'            align=center </C>
                                <C> id=EDU_GBN_CD      width=70     name='필수여부'        align=center value={DECODE(EDU_GBN_CD,'AA','필수','AB','선택')} </C>
                                <C> id=EDU_NM          width=150    name='교육과정명'                   </C>
                                <C> id=INT_NAM         width=120    name='시행처'                       </C>
                                <C> id=EDU_TNM         width=60     name='수료여부'        align=center value={DECODE(EDU_TAG,'N','미수료','Y','수료')} </C>
                                <C> id=CPT_PNT         width=60     name='이수학점'        align=center  </C>
                                <C> id=REMARK          width=100    name='교육분야'                      </C>
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
<!-- 교육사항 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_EDUCATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=PLACE_CD      Ctrl=txtPLACE_CD     Param=value </C>
        <C> Col=PLACE_NM      Ctrl=txtPLACE_NM     Param=value </C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
        <C> Col=EDU_GBN_CD    Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C> Col=EDU_CD        Ctrl=txtEDU_CD       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM       Param=value </C>
        <C> Col=INT_NAM       Ctrl=txtINT_NAM      Param=value </C>
        <C> Col=EDU_TAG       Ctrl=cmbEDU_TAG      Param=value </C>
        <C> Col=APP_VAL       Ctrl=txtAPP_VAL      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=DECISION_CD   Ctrl=txtDECISION_CD  Param=value </C>
        <C> Col=DECISION_NM   Ctrl=txtDECISION_NM  Param=value </C>
        <C> Col=CPT_PNT       Ctrl=txtCPT_PNT      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
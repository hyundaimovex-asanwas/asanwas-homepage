<!--
*****************************************************
* @source      : idtc010.jsp
* @description : 주간업무등록 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      이동훈        최초작성
*-------------+-----------+--------------------------+
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>주간업무등록</title>
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

        var eno_no = '';
        var eno_nm = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	

            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD   = document.getElementById("hidEMPL_DPT_CD").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;

            
            // FROM일자와 TO일자 비교
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("시작일자는 반드시 종료일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }


            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc010.cmd.IDTC010CMD"
										                                + "&S_MODE=SHR"
										                                + "&ENO_NO="+ENO_NO
										                                + "&STR_YMD="+STR_YMD
										                                + "&END_YMD="+END_YMD;
            dsT_WF_WORKFORM.Reset();

            form1.grdT_WF_WORKFORM.Focus();

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

                trT_WF_WORKFORM.KeyValue = "tr01(I:SAV=dsT_WF_WORKFORM)";
                trT_WF_WORKFORM.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug020.cmd.EDUG020CMD&S_MODE=SAV";
                trT_WF_WORKFORM.post();

            }

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

            //이곳에 해당 코딩을 입력 하세요

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

            dsT_WF_WORKFORM.ClearData();
            
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("txtENO_NO_SHR").focus();

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
            if (!dsT_WF_WORKFORM.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_WF_WORKFORM.CountRow; i++ ) {
                if ( dsT_WF_WORKFORM.RowStatus(i) == 1 ||
                     dsT_WF_WORKFORM.RowStatus(i) == 3 ) {

                    // 책임지도사원
                    if( dsT_WF_WORKFORM.NameValue(i, "TRA_ENO_NO") == '' ) {
                        alert("책임지도사원사번은 필수 입력사항입니다.");
                        dsT_WF_WORKFORM.RowPosition = i;
                        document.getElementById("txtTRA_ENO_NO").focus();
                        return false;
                    }

                    // 책임지도사원
                    if (dsT_WF_WORKFORM.NameValue(i, "TRA_ENO_NO") != "" &&
                        dsT_WF_WORKFORM.NameValue(i, "TRA_ENO_NM") == "") {
                        alert("책임지도사원사번에 입력하신 값은 존재하지 않는 사번입니다. 확인바랍니다.");
                        dsT_WF_WORKFORM.RowPosition = i;
                        document.getElementById("txtTRA_ENO_NO").focus();
                        return;
                    }

                    if (dsT_WF_WORKFORM.NameValue(i, "ENO_NO") == dsT_WF_WORKFORM.NameValue(i, "TRA_ENO_NO")) {
                        alert("대상자사번과 책임지도사원사번이 동일합니다. 확인바랍니다.");
                        dsT_WF_WORKFORM.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return false;
                    }

                    if ( dsT_WF_WORKFORM.RowStatus(i) == 1) {
                       document.getElementById("txtENO_NO").disabled  = true;
                       document.getElementById("ImgEnoNo").disabled   = true;
                    }

                }
            }

            return true;

        }

        
        
        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_WF_WORKFORM,0,"false","false");
            cfStyleGrid_New(form1.grdT_WF_WORKFORM2,0,"false","false");

            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNoShr");


       		fnc_SearchList();
       		
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_WF_WORKFORM.IsUpdated)  {

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

		function fnc_UsrGetEnoNm(gbn) {

            var obj = new String();

            if (gbn == 'ENO_NO') {

                obj = fnc_GetEnoNm("txtENO_NO");

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
                document.getElementById("txtSTR_YMD").value = obj.hir_ymd;
                document.getElementById("txtEND_YMD").value = shiftTime(obj.hir_ymd);


            }
            else if (gbn == 'TRA_ENO_NO') {

                obj = fnc_GetEnoNm("txtTRA_ENO_NO");

                document.getElementById("txtTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtTRA_ENO_NM").value = obj.eno_nm;
                document.getElementById("txtMDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtMDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtMJOB_CD").value = obj.job_cd;
                document.getElementById("txtMJOB_NM").value = obj.job_nm;
            }
            else if (gbn == 'HEAD_EMP_NO') {

                obj = fnc_GetEnoNm("txtHEAD_EMP_NO");

                document.getElementById("txtHEAD_EMP_NO").value = obj.eno_no;
                document.getElementById("txtHEAD_EMP_NM").value = obj.eno_nm;
            }
        }

        function fnc_UsrGetEnoNo(gbn) {
        	if (gbn == 'ENO_NO') {
        		fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
        	}

        	else if (gbn == 'TRA_ENO_NO') {
        		fnc_GetEnoNo('txtTRA_ENO_NM', 'txtTRA_ENO_NO');
        	}
        	else if (gbn == 'HEAD_EMP_NO') {
        		fnc_GetEnoNo('txtHEAD_EMP_NM', 'txtHEAD_EMP_NO');
        	}

        	fnc_UsrGetEnoNm(gbn);

        }

        function fnc_Popup(gbn) {
            var obj = new String();

            if (gbn == 'ENO_NO') {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtENO_NO','txtENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
                document.getElementById("txtSTR_YMD").value = obj.hir_ymd;
                document.getElementById("txtEND_YMD").value = shiftTime(obj.hir_ymd);
            }
            else if (gbn == 'TRA_ENO_NO') {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtTRA_ENO_NO','txtTRA_ENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtTRA_ENO_NM").value = obj.eno_nm;
                document.getElementById("txtMDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtMDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtMJOB_CD").value = obj.job_cd;
                document.getElementById("txtMJOB_NM").value = obj.job_nm;
            }
            else if (gbn == 'HEAD_EMP_NO') {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtHEAD_EMP_NO','txtHEAD_EMP_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtHEAD_EMP_NO").value = obj.eno_no;
                document.getElementById("txtHEAD_EMP_NM").value = obj.eno_nm;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTO)|
    | 3. 사용되는 Table List(T_CD_MENTO)       |
    +----------------------------------------------->
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_WF_WORKFORM                        |
    | 3. Table List : T_CD_MENTO                    |
    +----------------------------------------------->
    <Object ID ="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_WF_WORKFORM)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_WF_WORKFORM Event="OnDblClick(row, col)">
    
  //책임지도사원  OJT 계획등록
  //alert(dsT_WF_WORKFORM.NameValue(row, "TRA_ENO_NO"));
  if(dsT_WF_WORKFORM.NameValue(row, "TRA_ENO_NO") == gusrid || dsT_WF_WORKFORM.NameValue(row, "ENO_NO") == gusrid) {
	  
  		eno_no  = dsT_WF_WORKFORM.NameValue(row, "ENO_NO");
        eno_nm  = dsT_WF_WORKFORM.NameValue(row, "ENO_NM");

        window.showModalDialog("../../../Ehr/hr/edu/edug021.jsp", self, "dialogHeight:650px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
  }



        eno_no  = dsT_WF_WORKFORM.NameValue(row, "ENO_NO");
        eno_nm  = dsT_WF_WORKFORM.NameValue(row, "ENO_NM");

        window.showModalDialog("../../../Ehr/hr/edu/edug021.jsp", self, "dialogHeight:650px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");


    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_WF_WORKFORM.CountRow );

        }

        document.getElementById("txtENO_NO").disabled  = true;
        document.getElementById("txtENO_NM").disabled  = true;
        document.getElementById("txtDPT_CD").disabled  = true;
        document.getElementById("txtDPT_NM").disabled  = true;
        document.getElementById("txtJOB_CD").disabled  = true;
        document.getElementById("txtJOB_NM").disabled  = true;
        document.getElementById("txtSTR_YMD").disabled = true;
        document.getElementById("txtEND_YMD").disabled = true;
        document.getElementById("txtTRA_DPT_CD").disabled = true;
        document.getElementById("txtHIR_YMD").disabled = true;

        document.getElementById("ImgEnoNo").disabled   = true;
        document.getElementById("ImgStrYmd").disabled  = true;
        document.getElementById("ImgEndYmd").disabled  = true;
        document.getElementById("ImgTraDptCd").disabled  = true;

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WF_WORKFORM event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WF_WORKFORM event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">

                            <colgroup>
                                <col width="90"></col>
                                <col width="100"></col>
                                <col width="90"></col>
                                <col width="180"></col>
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>

                            <tr>
                                <td align="right" class="searchState" width="70">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">기간&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '후견기간 FROM일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '후견기간 TO일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="left" width="800">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:750px;height:500px;">
                            <param name="DataID"                  value="dsT_WF_WORKFORM">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="

	                                <C> id='WORK_WEEK'     			width=40    name='주차'         	align=center edit='none'</C>
	                                <C> id='STR_YMD'     			width=80    name='시작일'         align=center edit='none'</C>
	                                <C> id='END_YMD'     			width=80    name='종료일'         align=center edit='none'</C>

	                                <C> id='WORK_ITEM'     			width=70    name='주요과제'        align=center edit='none' </C>
	                                <C> id='WORK_DETAIL'     		width=390   name='항목'         	align=left   EditLimit=2000 edit='none'</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td width="10">
                        &nbsp;
                    </td>
                    <td align="right" width="190">
                        <comment id="__NSID__">
                        <object    id="grdT_WF_WORKFORM2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:240px;height:500px;">
                            <param name="DataID"                  value="dsT_WF_WORKFORM2">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='TRA_YMD'     	 width=150    name='일자'   		align=center mask='XXXX-XX-XX' </C>
                                <C> id='STATUS'       	 width=88     name='상태'         align=center </C>                                
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


<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 해당 항목을 더블클릭 하시면 주간업무일지를 등록하거나 수정하실 수 있습니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 내용보기 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WF_WORKFORM">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        		Ctrl=txtENO_NO        		Param=value </C>
        <C> Col=ENO_NM        		Ctrl=txtENO_NM        		Param=value </C>
        <C> Col=WORK_WEEK        	Ctrl=txtWORK_WEEK       	Param=value </C>
        <C> Col=STR_YMD     		Ctrl=txtSTR_YMD      		Param=value </C>
        <C> Col=END_YMD       		Ctrl=txtEND_YMD        		Param=value </C>
        <C> Col=WORK_ITEM        	Ctrl=txtWORK_ITEM        	Param=value </C>
        <C> Col=WORK_DETAIL      	Ctrl=txtWORK_DETAIL      	Param=value </C>

    '>
</object>



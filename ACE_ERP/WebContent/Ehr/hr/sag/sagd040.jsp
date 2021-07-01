<!--
***********************************************************************
* @source      : sagd040.jsp
* @description : 신_개인별 수당 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/01/14      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>개인별 수당</title>
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

        var today = gcurdate;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            
            var gbn = "";
             //조건1
            if(f.rdoGBN_SHR[0].checked){
                gbn = "ENO_NO";
            }else if(f.rdoGBN_SHR[1].checked){
                gbn = "SAL_CD";
            }

			dsT_CP_NSUDANG.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd040.cmd.SAGD040CMD&S_MODE=SHR&GBN="+gbn+"&ENO_NO="+eno_no+"&SAL_CD="+sal_cd+"&PIS_YM="+pis_ym;
    		dsT_CP_NSUDANG.reset();

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

				if(!fnc_SaveItemCheck()) return;	//유효성 체크

				trT_CP_NSUDANG.KeyValue = "tr01(I:dsT_CP_NSUDANG=dsT_CP_NSUDANG)";
				trT_CP_NSUDANG.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd040.cmd.SAGD040CMD&S_MODE=SAV";
				trT_CP_NSUDANG.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var SAL_NM = document.getElementById("txtSAL_NM").value;

			if(dsT_CP_NSUDANG.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if(confirm("[사번:"+dsT_CP_NSUDANG.NameValue(dsT_CP_NSUDANG.RowPosition,"ENO_NO")+"/성명:"+dsT_CP_NSUDANG.NameValue(dsT_CP_NSUDANG.RowPosition,"ENO_NM")+"/수당항목:"+SAL_NM+"]\n의 정보를 삭제하시겠습니까?")){

				dsT_CP_NSUDANG.DeleteRow(dsT_CP_NSUDANG.RowPosition);

				trT_CP_NSUDANG.KeyValue = "tr02(I:dsT_CP_NSUDANG=dsT_CP_NSUDANG)";
				trT_CP_NSUDANG.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd040.cmd.SAGD040CMD&S_MODE=DEL";
				trT_CP_NSUDANG.post();

			}

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {


        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_NSUDANG.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_NSUDANG.GridToExcel("수당테이블", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_CP_NSUDANG.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_CP_NSUDANG.setDataHeader("OCC_CD:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, SAL_CD:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, AD_TAG:STRING, AMOUNT:NUMBER, DPT_CD:STRING, JOB_CD:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING");
			}

			dsT_CP_NSUDANG.AddRow();

			document.getElementById('txtENO_NO').focus();

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


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_NSUDANG.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

        	window.close();

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

			if (!dsT_CP_NSUDANG.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			var RowCnt = dsT_CP_NSUDANG.CountRow;

			for(i=1; i<=RowCnt; i++){

	            if(dsT_CP_NSUDANG.NameValue(i,"ENO_NO").trim() == ""){
	                alert("사번을 입력하세요.");
					dsT_CP_NSUDANG.RowPosition = i;
	                document.getElementById('txtENO_NO').focus();
	                return false;
	            }

	            if(dsT_CP_NSUDANG.NameValue(i,"ENO_NO").trim().length != 7 || dsT_CP_NSUDANG.NameValue(i,"ENO_NM").trim() == ""){
	                alert("올바른 사번이 아닙니다.");
					dsT_CP_NSUDANG.RowPosition = i;
	                document.getElementById('txtENO_NO').focus();
	                return false;
	            }

   				if(dsT_CP_NSUDANG.NameValue(i,"SAL_CD").trim() == ""){
					alert("수당항목을 입력하세요.");
					dsT_CP_NSUDANG.RowPosition = i;
					document.getElementById("txtSAL_CD").focus();
					return false;
				}

				if(dsT_CP_NSUDANG.NameValue(i,"AD_TAG").trim() == ""){
					alert("구분을 입력하세요.");
					dsT_CP_NSUDANG.RowPosition = i;
					document.getElementById("cmbAD_TAG").focus();
					return false;
				}

			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = gcurdate.substring(0,7);        	
        	
			cfStyleGrid_New(form1.grdT_CP_NSUDANG,15,"true","true");      // Grid Style 적용

            document.getElementById('txtENO_NO_SHR').focus();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/***********************
         * 16. 사원조회용 팝업 *
         **********************/
		function fnc_EmplPop(gbn) {

			var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("../../common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(gbn == '1'){
                document.getElementById("txtENO_NO_SHR").value = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value = obj.eno_nm;

            }else{
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }

		}

        /**********************************
         * 17. 사번으로 사원정보조회 처리 *
         *********************************/
        function fnc_UserGetEnoNm(gbn) {

            var obj = new String();

            if(gbn == '1'){
                obj = fnc_GetEnoNm("txtENO_NO_SHR");
                document.getElementById("txtENO_NM_SHR").value = obj.eno_nm;
                document.getElementById("hidOCC_CD_SHR").value = obj.occ_cd;
                document.getElementById("txtOCC_NM_SHR").value = obj.occ_nm;
                document.getElementById("txtRET_YMD_SHR").value = obj.ret_ymd;
            }else{
                obj = fnc_GetEnoNm("txtENO_NO");
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("hidOCC_CD").value = obj.occ_cd;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }

        }

        /**********************************
         * 18. 이름으로 사원정보조회 처리 *
         *********************************/
        function fnc_UserGetEnoNo(gbn) {

            var obj = new String();

            if(gbn == '1'){
	            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');

				fnc_UserGetEnoNm(gbn);
            }

        }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_NSUDANG)   |
    | 3. 사용되는 Table List(T_CP_NSUDANG)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_NSUDANG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_CP_NSUDANG)	    |
    | 3. 사용되는 Table List(T_CP_NSUDANG)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CP_NSUDANG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_NSUDANG Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
 			form1.medAMOUNT.Enable = "true";
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_NSUDANG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_NSUDANG Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사번/수당항목/시작일]\n입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[사번/수당항목/시작일]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_NSUDANG event="OnSuccess()">
        //fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CP_NSUDANG event="OnFail()">
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
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDel','','../../images/button/btn_DeleteOver.gif',1)">    <img src="../../images/button/btn_DeleteOn.gif"   name="imgDelete"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="80"></col>
									<col width="800"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="right" class="searchState" rowspan="2">검색조건&nbsp;</td>
								<td class="padding2423">
                                    <table width="100%" height="100%" border="0" cellspacing="1" cellpadding="2">
                                    

			                                                                    
                                        <tr>
											<td class="searchState" align="right">해당년월&nbsp;</td>
			                                <td class="padding2423" align="left">
			                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> 
			                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','../../images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','5','110');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
			                                </td>                                        
                                            <td><input type="radio" id="radio1" name="rdoGBN_SHR" style="border:none" value="0" checked>사원번호&nbsp;&nbsp;
                                                <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxLength="8" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_UserGetEnoNm('1'); cfNumberCheck();" onChange="fnc_UserGetEnoNm('1')">
									            <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="10" maxlength="12" onKeypress="javascript:if(event.keyCode==13) fnc_UserGetEnoNo('1');" onChange="fnc_UserGetEnoNo('1')">
									            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPop('1');"></a>
                                            </td>

                                            <td><input type="radio" id="radio2" name="rdoGBN_SHR" style="border:none" value="0">수당항목&nbsp;&nbsp;
												<input id="txtSAL_CD_SHR" name="txtSAL_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');" onChange="fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');">
												<input id="txtSAL_NM_SHR" name="txtSAL_NM_SHR" size="16" class="input_ReadOnly" readonly>
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgSAL_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD_SHR','txtSAL_NM_SHR','수당항목','U8');"></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="137"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
                <tr>
					<td align="center" class="blueBold">사 번</td>
					<td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" style="width:80;ime-mode:disabled" maxLength="8" onKeypress="cfNumberCheck();" onChange="fnc_UserGetEnoNm('2')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){return;} fnc_EmplPop();"></a>
                    </td>
					<td align="center" class="blueBold">성 명</td>
					<td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%" class="input_ReadOnly" readonly>
                        <input type="hidden" id="hidOCC_CD" name="hidOCC_CD">
                    </td>
                    <td align="center" class="blueBold">직 위</td>
					<td class="padding2423">
                        <input id="txtJOB_CD" name="txtJOB_CD" style="width:30" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" name="txtJOB_NM" style="width:50" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">소 속</td>
					<td class="padding2423" colspan="3">
                        <input id="txtDPT_CD" name="txtDPT_CD" style="width:30" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" name="txtDPT_NM" style="width:90" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
					<td align="center" class="blueBold">수당항목</td>
					<td class="padding2423">
						<input id="txtSAL_CD" name="txtSAL_CD" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');" onChange="fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');">
						<input id="txtSAL_NM" name="txtSAL_NM" size="11" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgSAL_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD','txtSAL_NM','수당항목','U8');return false;"></a>
                    </td>
					<td align="center" class="blueBold">금 액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=8>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="blueBold">구  분</td>
					<td class="padding2423">
                        <select id="cmbAD_TAG" style="WIDTH: 100%" >
						    <option value="A">지 불</option>
						    <option value="D">공 제</option>
						</select>
                    </td>
                    <td align="center" class="blueBold">시작일</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtSTR_YMD.disabled == true) return; calendarBtn('datetype1','txtSTR_YMD','','410','215');"></a>
                    </td>
                    <td align="center" class="blueBold">종료일</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtEND_YMD.disabled == true) return; calendarBtn('datetype1','txtEND_YMD','','600','215');"></a>
                    </td>

				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_NSUDANG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:450px;">
							<param name="DataID"					value="dsT_CP_NSUDANG">
							<param name="SortView"					value="Left">
							<param name="Format"					value="
								<C> id={currow}		width=50    name='NO'			align=center </C>
                                <C> id='DPT_NM'	    width=150	name='소속'	        align=left </C>
                                <C> id='JOB_NM'	    width=80	name='직위'	        align=center </C>
                                <C> id='ENO_NO'	    width=80	name='사번'	        align=center </C>
                                <C> id='ENO_NM'	    width=90	name='성명'	        align=center </C>
								<C> id='SAL_NM'		width=120	name='수당항목'		align=left      LeftMargin='10' </C>
                                <C> id='STR_YMD'	width=100	name='시작일'	    	align=center </C>
                                <C> id='END_YMD'	width=100	name='종료일'	    	align=center </C>
								<C> id='AMOUNT'		width=100	name='금액'			align=right </C>
								<C> id='AD_TAG'		width=80	name='구분'		    align=center    Value={Decode(AD_TAG,'A','지불','D','공제')} </C>
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
<!-- 급상여 변동 세부사항 설정 테이블 -->
<object id="bndT_CP_NSUDANG" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_NSUDANG">
	<Param Name="BindInfo", Value='
        <C>Col=OCC_CD		Ctrl=hidOCC_CD	      	Param=value		</C>
        <C>Col=DPT_CD		Ctrl=txtDPT_CD	      	Param=value		</C>
        <C>Col=DPT_NM		Ctrl=txtDPT_NM	      	Param=value		</C>
        <C>Col=JOB_NM		Ctrl=txtJOB_NM	      	Param=value		</C>
        <C>Col=JOB_CD		Ctrl=txtJOB_CD	      	Param=value		</C>
        <C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NM		Ctrl=txtENO_NM	      	Param=value		</C>
		<C>Col=SAL_CD		Ctrl=txtSAL_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_NM		Ctrl=txtSAL_NM	      	Param=value		Disable=disabled</C>
		<C>Col=AMOUNT    	Ctrl=medAMOUNT	     	Param=text		Disable=disabled</C>
		<C>Col=AD_TAG		Ctrl=cmbAD_TAG      	Param=value		Disable=disabled</C>
        <C>Col=STR_YMD		Ctrl=txtSTR_YMD      	Param=value		Disable=disabled</C>
        <C>Col=END_YMD		Ctrl=txtEND_YMD      	Param=value		Disable=disabled</C>
    '>
</object>
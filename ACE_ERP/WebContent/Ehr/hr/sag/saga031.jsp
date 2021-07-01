<!--
    ************************************************************************************
    * @source         : saga031.jsp 				                                                                                     *
    * @description   : 급여계산처리(대상자추가) PAGE.                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/22  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>급여계산처리(대상자추가)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'FFTFFFFT';

        var dsT_CP_WORKLOG = window.dialogArguments;//opener에서 받아온다.

        /********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

        }

   		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

   			if( !fnc_SaveItemCheck() )	return;

			//트랜잭션 전송
			trT_CP_PAYMASTER.KeyValue = "SVL(I:SAV=dsT_CP_PAYMASTER)";
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga031.cmd.SAGA031CMD&S_MODE=SAV";
			trT_CP_PAYMASTER.Post();

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

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CP_PAYMASTER.CountColumn == 0) {
                dsT_CP_PAYMASTER.setDataHeader("OCC_CD:STRING(1):KEYVALUETYPE,PIS_YY:STRING(4):KEYVALUETYPE,PIS_MM:STRING(2):KEYVALUETYPE,SAL_GBN:STRING(1):KEYVALUETYPE,SEQ:STRING(2):KEYVALUETYPE,ENO_NO:STRING(8):KEYVALUETYPE,PRO_STS:STRING(1),ENO_NM:STRING(12),DPT_NM:STRING(12),JOB_NM:STRING(12)");
            }

            enableInput();

			dsT_CP_PAYMASTER.AddRow();

			var i = 1;

			//dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"OCC_CD")=dsT_CP_WORKLOG.NameValue(i,"OCC_CD");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_YY")=dsT_CP_WORKLOG.NameValue(i,"PIS_YY");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_MM")=dsT_CP_WORKLOG.NameValue(i,"PIS_MM");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SAL_GBN")=dsT_CP_WORKLOG.NameValue(i,"SAL_GBN");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SEQ")=dsT_CP_WORKLOG.NameValue(i,"SEQ");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PRO_STS")="7";//대상자추가

			/*alert(dsT_CP_PAYMASTER.RowPosition+"--->"+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"OCC_CD") +",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_YY")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_MM")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SAL_GBN")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SEQ")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PRO_STS"));*/

			document.form1.txtENO_NO.focus();

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			// 삭제 할 자료가 있는지 체크하고
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			// 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_CP_PAYMASTER.ColumnString(dsT_CP_PAYMASTER.RowPosition,8) + "] 자료를 제거하시겠습니까?") == false) return;

			dsT_CP_PAYMASTER.DeleteRow(dsT_CP_PAYMASTER.RowPosition);

			if(dsT_CP_PAYMASTER.CountRow < 1){
				disableInput();
			}

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			fnc_OnLoadProcess();
			dsT_CP_PAYMASTER.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYMASTER.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_CP_PAYMASTER.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;
			var oOCC_CD, oPIS_YY, oPIS_MM, oSAL_GBN, oENO_NO, oSEQ;

			var RowCnt = dsT_CP_PAYMASTER.CountRow;

			for(i=1; i<=RowCnt; i++){
				oOCC_CD = dsT_CP_PAYMASTER.NameValue(i,"OCC_CD");
				oPIS_YY = dsT_CP_PAYMASTER.NameValue(i,"PIS_YY");
				oPIS_MM = dsT_CP_PAYMASTER.NameValue(i,"PIS_MM");
				oSAL_GBN = dsT_CP_PAYMASTER.NameValue(i,"SAL_GBN");
				oENO_NO = dsT_CP_PAYMASTER.NameValue(i,"ENO_NO");
				oSEQ = dsT_CP_PAYMASTER.NameValue(i,"SEQ");

				dsT_CP_PAYMASTER_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga031.cmd.SAGA031CMD&S_MODE=SHR&OCC_CD="+oOCC_CD+"&PIS_YY="+oPIS_YY+"&PIS_MM="+oPIS_MM+"&SAL_GBN="+oSAL_GBN+"&ENO_NO="+oENO_NO+"&SEQ="+oSEQ;
    			dsT_CP_PAYMASTER_01.reset();

    			if(dsT_CP_PAYMASTER_01.CountRow != 0){
    				alert(dsT_CP_PAYMASTER.NameValue(i, "ENO_NM")+"["+dsT_CP_PAYMASTER.NameValue(i, "ENO_NO")+"]"+"은 이미 대상자 선정이 되어 있습니다.");
					return false;
    			}

			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");

			disableInput();//입력필드 비활성화

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

		/********************************************
         * 입력필드 사용 가능하게(Enable)          	        	 *
         ********************************************/
  		function enableInput(){

			document.form1.txtENO_NO.readOnly = false;
  			document.form1.txtENO_NO.className = "";
			document.form1.txtENO_NM.readOnly = false;
  			document.form1.txtENO_NM.className = "";
  			document.getElementById("imgENO_NO").disabled = false;

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtENO_NO.readOnly = true;
  			document.form1.txtENO_NO.className = "input_ReadOnly";
			document.form1.txtENO_NM.readOnly = true;
  			document.form1.txtENO_NM.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO").disabled = true;

  		}

		/**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO', 'txtENO_NM');

            fnc_GetUserInfo1();
        }

  		/**
         * fnc_GetEnoNm 다른정보도 가져오게 재정의
         */
        function fnc_GetUserInfo1() {

            var i = 1;
            var obj = fnc_GetEnoNm("txtENO_NO");

            if (!(obj.occ_cd == "0" || obj.occ_cd == "1" || obj.occ_cd == "2" || obj.occ_cd != "3" )){

		            alert("해당직원은 급여대상 직원이 아닙니다.");

	            document.getElementById("txtOCC_CD").value = "";
	            document.getElementById("txtENO_NO").value = "";
	            document.getElementById("txtENO_NM").value = "";
	            document.getElementById("txtJOB_CD").value = "";
	            document.getElementById("txtJOB_NM").value = "";
	            document.getElementById("txtDPT_CD").value = "";
	            document.getElementById("txtDPT_NM").value = "";

            }else{
	            document.getElementById("txtOCC_CD").value = obj.occ_cd;
	            document.getElementById("txtENO_NO").value = obj.eno_no;
	            document.getElementById("txtENO_NM").value = obj.eno_nm;
	            document.getElementById("txtJOB_CD").value = obj.job_cd;
	            document.getElementById("txtJOB_NM").value = obj.job_nm;
	            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
	            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            }

        }

        function fnc_GetUserInfo2() {

            fnc_GetEnoNo("txtENO_NM","txtENO_NO");

            fnc_GetUserInfo1();

        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER                                 |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_01                                 |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_PAYMASTER                                    |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        //처리후 강제 CLOSE
		window.close();

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
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
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">급여처리대상자추가</td>
					<td align="right" class="navigator">HOME/보상관리/급여관리/급여계산처리/<font color="#000000">급여처리대상자추가</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!--삽입--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInsert','','/images/button/btn_InsertOver.gif',1)">    <img src="/images/button/btn_InsertOn.gif"   name="imgInsert"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <!--제거--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)">    <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
            <!--처리--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ConductOver.gif',1)">    <img src="/images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="195"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">사원번호</td>
					<td class="padding2423" colspan="3">
						<input id="txtENO_NO" name="txtENO_NO" size="10" maxlength="8"  onkeypress="if(event.keyCode==13) fnc_GetUserInfo1();cfNumberCheck();" onChange="fnc_GetUserInfo1();" style="ime-mode:disabled">
						<input id="txtENO_NM" name="txtENO_NM" size="14" maxlength="14" onkeypress="if(event.keyCode==13) fnc_GetUserInfo2();" onChange="fnc_GetUserInfo2();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();"></a>

						<input type="hidden" id="txtOCC_CD" name="txtOCC_CD" >
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
					<td class="padding2423">
						<input id="txtDPT_CD" size="5" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" size="15" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423">
						<input id="txtJOB_CD" size="5" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" size="15" class="input_ReadOnly" readOnly>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
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
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:220px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=49			name='NO'					align=center				value={String(Currow)}	</C>
								<C> id='DPT_NM'				width=120			name='소속'					align=center														</C>
								<C> id='JOB_NM'				width=120			name='직위'					align=center														</C>
								<C> id='ENO_NO'				width=120			name='사번'					align=center														</C>
								<C> id='ENO_NM'				width=120			name='성명'					align=center														</C>
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
<!-- -->
<object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_PAYMASTER">
	<Param Name="BindInfo", Value='

		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM     		 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM 			 	Param=value 		</C>
		<C>Col=ENO_NO     		 	Ctrl=txtENO_NO    		 	Param=value 		</C>
		<C>Col=ENO_NM     		 	Ctrl=txtENO_NM 			 	Param=value 		</C>

    '>
</object>

<!--
***********************************************************************
* @source      : sagb050.jsp
* @description : 그룹별 고정지불/공제 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/23      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>그룹별 고정지불/공제(sagb050)</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTTTTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;

			var occ_cd = '1';
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var apy_tag = document.getElementById('cmbAPY_TAG_SHR').value;

			dsT_CP_GROUPFIXED.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb050.cmd.SAGB050CMD&S_MODE=SHR&OCC_CD="+occ_cd+"&SAL_CD="+sal_cd+"&APY_TAG="+apy_tag;
    		dsT_CP_GROUPFIXED.reset();

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

				trT_CP_GROUPFIXED.KeyValue = "tr01(I:dsT_CP_GROUPFIXED=dsT_CP_GROUPFIXED)";
				trT_CP_GROUPFIXED.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb050.cmd.SAGB050CMD&S_MODE=SAV";
				trT_CP_GROUPFIXED.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var dpt_index = document.getElementById("cmbDPT_CD").selectedIndex;
            var pos_index = document.getElementById("cmbPOS_CD").selectedIndex;
            var SAL_NM = "";
            var DPT_NM = "";
            var POS_NM = "";

			SAL_NM = document.getElementById("txtSAL_NM").value;

            if(dpt_index >= 0){
				DPT_NM = document.getElementById("cmbDPT_CD")[dpt_index].text;
			}
            if(pos_index >= 0){
				POS_NM = document.getElementById("cmbPOS_CD")[pos_index].text;
			}


			if(dsT_CP_GROUPFIXED.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if(confirm("[급여항목:" + SAL_NM + "/소속:" + DPT_NM + "/직위:" + POS_NM + "]\n의 정보를 삭제하시겠습니까?")){
				dsT_CP_GROUPFIXED.DeleteRow(dsT_CP_GROUPFIXED.RowPosition);
				trT_CP_GROUPFIXED.KeyValue = "tr02(I:dsT_CP_GROUPFIXED=dsT_CP_GROUPFIXED)";
				trT_CP_GROUPFIXED.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb050.cmd.SAGB050CMD&S_MODE=DEL";
				trT_CP_GROUPFIXED.post();
			}

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {
           var f = document.form1;

			var occ_cd = '1';
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var apy_tag = document.getElementById('cmbAPY_TAG_SHR').value;

			var url = "sagb050_PV.jsp?OCC_CD="+occ_cd+"&SAL_CD="+sal_cd+"&APY_TAG="+apy_tag;

   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_GROUPFIXED.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_GROUPFIXED.GridToExcel("그룹별고정지불공제", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {



			dsT_CP_GROUPFIXED.AddRow();

			document.getElementById('txtSAL_CD').focus();

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

            document.getElementById('txtSAL_CD_SHR').value = "";
            document.getElementById('txtSAL_NM_SHR').value = "";
            document.getElementById('cmbAPY_TAG_SHR').value = "";

   			form1.medAMOUNT.Enable = "true";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_GROUPFIXED.ClearData();

            document.getElementById('txtSAL_CD_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_GROUPFIXED.IsUpdated)  {

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

			if (!dsT_CP_GROUPFIXED.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			var RowCnt = dsT_CP_GROUPFIXED.CountRow;

			for(i=1; i<=RowCnt; i++){

				if(dsT_CP_GROUPFIXED.NameValue(i,"SAL_CD").trim() == ""){
					alert("급여항목을 입력하세요.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("txtSAL_CD").focus();
					return false;
				}

				/*
				if(dsT_CP_GROUPFIXED.NameValue(i,"DPT_CD").trim() == ""){
					alert("소속을 입력하세요.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbDPT_CD").focus();
					return false;
				}

				if(dsT_CP_GROUPFIXED.NameValue(i,"POS_CD").trim() == ""){
					alert("직위를 입력하세요.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbPOS_CD").focus();
					return false;
				}
				*/

				if(dsT_CP_GROUPFIXED.NameValue(i,"AD_TAG").trim() == ""){
					alert("구분을 입력하세요.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbAD_TAG").focus();
					return false;
				}

				if(dsT_CP_GROUPFIXED.NameValue(i,"APY_TAG").trim() == ""){
					alert("적용을 입력하세요.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbAPY_TAG").focus();
					return false;
				}

			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
				dsT_CP_GROUPFIXED.setDataHeader("OCC_CD:STRING:KEYVALUETYPE, SAL_CD:STRING:KEYVALUETYPE, DPT_CD:STRING:KEYVALUETYPE, POS_CD:STRING:KEYVALUETYPE, APY_YMD:STRING:KEYVALUETYPE, APY_TAG:STRING, AD_TAG:STRING, AMOUNT:NUMBER");
            //데이터셋 전송
            dsT_CM_COMMON_DEPT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.codenm.cmd.CODENMCMD&S_MODE=SHR&GBN=DEPT";
            dsT_CM_COMMON_DEPT.Reset();

            //직위구분
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbPOS_CD").add(oOption);

            }

			cfStyleGrid(form1.grdT_CP_GROUPFIXED,15,"false","false");      // Grid Style 적용

  			form1.medAMOUNT.Enable = "true";

            document.getElementById('txtSAL_CD_SHR').focus();

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

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_GROUPFIXED)   |
    | 3. 사용되는 Table List(T_CP_GROUPFIXED)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_GROUPFIXED" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_CP_GROUPFIXED)	    |
    | 3. 사용되는 Table List(T_CP_GROUPFIXED)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CP_GROUPFIXED" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 직위구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
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
    <Script For=dsT_CP_GROUPFIXED Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
  			form1.medAMOUNT.Enable = "true";

        }

    </Script>

    <Script For=dsT_CM_COMMON_DEPT Event="OnLoadCompleted(iCount)">

        //소속구분
        for( var i = 1; i <= dsT_CM_COMMON_DEPT.CountRow; i++ ) {

            oOption       = document.createElement("OPTION");
            oOption.value = dsT_CM_COMMON_DEPT.NameValue(i,"CODE_CD");
            oOption.text  = dsT_CM_COMMON_DEPT.NameValue(i,"CODE_CD")+" "+dsT_CM_COMMON_DEPT.NameValue(i,"CODE_NM");
            document.getElementById("cmbDPT_CD").add(oOption);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_GROUPFIXED Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_GROUPFIXED Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[급여항목/소속/직위/적용일자]\n입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[급여항목/소속/직위/적용일자]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_GROUPFIXED event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CP_GROUPFIXED event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">그룹별고정지불/공제</td>
					<td align="right" class="navigator">HOME/보상관리/수당관리/<font color="#000000">그룹별고정지불/공제</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
									<col width="80"></col>
									<col width="200"></col>
									<col width="80"></col>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="right" class="searchState">급여항목&nbsp;</td>
								<td>
									<input id="txtSAL_CD_SHR" name="txtSAL_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');" onChange="fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');">
									<input id="txtSAL_NM_SHR" name="txtSAL_NM_SHR" size="16" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD_SHR','txtSAL_NM_SHR','급여세부항목','U4');"></a>
								</td>
                                <td align="right" class="searchState">적용여부&nbsp;</td>
								<td>
									<select id="cmbAPY_TAG_SHR" style="width:100" onChange="fnc_SearchList();">
                                        <option value="" >전 체</option>
										<option value="Y" >적 용</option>
	                                    <option value="N" >미적용</option>
									</select>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="130"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
                <tr>
					<td align="center" class="creamBold">급여항목</td>
					<td class="padding2423" colspan="3">
						<input id="txtSAL_CD" name="txtSAL_CD" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');" onChange="fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');">
						<input id="txtSAL_NM" name="txtSAL_NM" size="11" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD','txtSAL_NM','급여세부항목','U4');return false;"></a>
                    </td>
					<td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
					<td class="padding2423">
                        <select id="cmbDPT_CD" style="width:100%">
							<option value=" " >전체</option>
						</select>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423" >
                        <select id="cmbPOS_CD" style="width:100%">
							<option value=" " >전체</option>
						</select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">금&nbsp;&nbsp;액</td>
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
                    <td align="center" class="creamBold">구  분</td>
					<td class="padding2423">
                        <select id="cmbAD_TAG" style="WIDTH: 100%" >
						    <option value="A">지 불</option>
						    <option value="D">공 제</option>
						</select>
                    </td>
                    <td align="center" class="creamBold">적용일자</td>
					<td class="padding2423">
                        <input id="txtAPY_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtAPY_YMD.disabled == true) return; calendarBtn('datetype1','txtAPY_YMD','','410','215');"></a>
                    </td>
					<td align="center" class="creamBold">적&nbsp;&nbsp;용</td>
					<td class="padding2423">
                        <select id="cmbAPY_TAG" style="width:100%">
							<option value="Y" >적 용</option>
	                        <option value="N" >미적용</option>
						</select>
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
						<object	id="grdT_CP_GROUPFIXED" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_CP_GROUPFIXED">
							<param name="Format"					value="
								<C> id={currow}		width=49    name='NO'				align=center 	</C>
								<C> id='SAL_NM'		width=150	name='급여항목'			align=left      LeftMargin='10' </C>
                                <C> id='DPT_CD'	    width=120	name='소속'	        	align=left      EditStyle=Lookup Data='dsT_CM_COMMON_DEPT:CODE_CD:CODE_NM' LeftMargin='10' </C>
                                <C> id='POS_CD'	    width=85	name='직위'	        	align=left      EditStyle=Lookup Data='dsT_CM_COMMON_A2:CODE:CODE_NAME' LeftMargin='10' </C>
								<C> id='AMOUNT'		width=100	name='금액'				align=right 	</C>
								<C> id='AD_TAG'		width=80	name='구분'		    	align=center    Value={Decode(AD_TAG,'A','지불','D','공제')} </C>
                                <C> id='APY_YMD'	width=100	name='적용일자'	        align=center 	</C>
                                <C> id='APY_TAG'	width=80	name='적용여부'	        align=center Value={Decode(APY_TAG,'Y','적용','미적용')} </C>
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
<object id="bndT_CP_GROUPFIXED" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_GROUPFIXED">
	<Param Name="BindInfo", Value='
        <C>Col=DPT_CD		Ctrl=cmbDPT_CD	      	Param=value		Disable=disabled</C>
        <C>Col=POS_CD		Ctrl=cmbPOS_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_CD		Ctrl=txtSAL_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_NM		Ctrl=txtSAL_NM	      	Param=value		Disable=disabled</C>
		<C>Col=AMOUNT    	Ctrl=medAMOUNT	     	Param=text		Disable=disabled</C>
		<C>Col=AD_TAG		Ctrl=cmbAD_TAG      	Param=value		Disable=disabled</C>
        <C>Col=APY_YMD		Ctrl=txtAPY_YMD      	Param=value		Disable=disabled</C>
        <C>Col=APY_TAG		Ctrl=cmbAPY_TAG      	Param=value		Disable=disabled</C>
    '>
</object>
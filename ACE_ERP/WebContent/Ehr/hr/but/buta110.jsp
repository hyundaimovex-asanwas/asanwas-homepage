<!--
*****************************************************
* @source      : buta110.jsp
* @description : 해외출장비지급기준 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/15      오대성        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>해외출장비지급기준(buta110)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTFFTT';

        var today = getToday();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			//검색조건
			var basic_ymd = document.getElementById("txtBASIC_YMD_SHR").value;		//기준일
            var but_city_cd = document.getElementById("cmbBUT_CITY_CD_SHR").value;  //출장지 CODE

			dsT_DI_OVERSEASBT_BASIS.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta110.cmd.BUTA110CMD&S_MODE=SHR&BASIC_YMD="+basic_ymd+"&BUT_CITY_CD="+but_city_cd;
			dsT_DI_OVERSEASBT_BASIS.reset();

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

			if(!fnc_SaveItemCheck()) return;

			trT_DI_OVERSEASBT_BASIS.KeyValue = "tr01(I:dsT_DI_OVERSEASBT_BASIS=dsT_DI_OVERSEASBT_BASIS)";
			trT_DI_OVERSEASBT_BASIS.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta110.cmd.BUTA110CMD&S_MODE=SAV";
			trT_DI_OVERSEASBT_BASIS.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_DI_OVERSEASBT_BASIS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var index_city = document.getElementById("cmbBUT_CITY_CD").selectedIndex;
            var index_job = document.getElementById("cmbJOB_CD_FROM").selectedIndex;

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            var msg = "[기준일:"
                    + document.getElementById("txtBASIC_YMD_SHR").value
                    + "/출장지:"
                    + dsT_CM_COMMON_LT.NameValue(dsT_CM_COMMON_LT.RowPosition, "CODE_NAME")
                    + "/직위:"+document.getElementById("cmbJOB_CD_FROM")[index_job].text
                    + "] 자료를 제거하시겠습니까?";
            if (confirm(msg) == false) return;
            dsT_DI_OVERSEASBT_BASIS.DeleteRow(dsT_DI_OVERSEASBT_BASIS.RowPosition);

			trT_DI_OVERSEASBT_BASIS.KeyValue = "SVL(I:dsT_DI_OVERSEASBT_BASIS=dsT_DI_OVERSEASBT_BASIS)";
			trT_DI_OVERSEASBT_BASIS.Action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta110.cmd.BUTA110CMD&S_MODE=SAV";
			trT_DI_OVERSEASBT_BASIS.post();
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
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_DI_OVERSEASBT_BASIS.CountColumn < 1) {
                dsT_DI_OVERSEASBT_BASIS.setDataHeader(    "BASIC_YMD:STRING:KEYVALUETYPE"
                                                        +",BUT_CITY_CD:STRING:KEYVALUETYPE"
                                                        +",JOB_CD_FROM:STRING:KEYVALUETYPE"
                                                        +",JOB_CD_TO:STRING"
                                                        +",BUT_EXPENSE:DECIMAL"
                                                        +",BUT_LODGING:DECIMAL"
                                                        +",BUT_EXPENSE_OFFER:DECIMAL"
                                                        +",CURRENCY_CD:STRING"
                                                      );
            }
            dsT_DI_OVERSEASBT_BASIS.AddRow();
            document.getElementById("txtBASIC_YMD").focus();
            document.getElementById("txtBASIC_YMD").value = getToday();
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
			//이곳에 해당 코딩 입력 하세요
        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
            //document.getElementById("txtBASIC_YMD_SHR").value = "";	    //기준일
            document.getElementById("cmbBUT_CITY_CD_SHR").value = "";   //출장지 CODE
			dsT_DI_OVERSEASBT_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtBASIC_YMD_SHR").focus();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
			if (dsT_DI_OVERSEASBT_BASIS.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {
			var basic_ymd = document.getElementById("txtBASIC_YMD_SHR");
            if(basic_ymd.value == ""){
                alert("기준일자를 입력하세요!");
                basic_ymd.focus();
                return false;
            }
            return true;
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
			if (!dsT_DI_OVERSEASBT_BASIS.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_OVERSEASBT_BASIS,15,"false","false")      // Grid Style 적용
            //출장지
            fnc_ConstructCommonCode("dsT_CM_COMMON_LT", "cmbBUT_CITY_CD_SHR");
            //fnc_ConstructCommonCode("dsT_CM_COMMON_LT", "cmbBUT_CITY_CD");
            //직위
            //fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM");
                        //직위형태
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_FROM").add(oOption);
            }
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO");
            //단위
            fnc_ConstructCommonCode("dsT_CM_COMMON_EX", "cmbCURRENCY_CD");
            document.getElementById("txtBASIC_YMD_SHR").value = getToday();
            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /****************************
         * 16. 단위 입력(미사용)    *
         ***************************/
		function fnc_InputCurrency() {
            if(document.getElementById("cmbBUT_CITY_CD").value == "KR"){
                alert("대한민국은 선택할 수 없습니다!");
                document.getElementById("cmbBUT_CITY_CD").value = "";
                return;
            }
			if(document.getElementById("cmbBUT_CITY_CD").value == "JP"){
                document.getElementById("cmbCURRENCY_CD").value = "JPY";
            }else {
                document.getElementById("cmbCURRENCY_CD").value = "USD";
            }
		}

        var elementList = new Array(     "txtBASIC_YMD"
                                        ,"imgBASIC_YMD"
                                        ,"cmbBUT_CITY_CD"
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbJOB_CD_TO"
                                        ,"txtBUT_LODGING"
                                        ,"txtBUT_EXPENSE"
                                        ,"txtBUT_EXPENSE_OFFER"
                                        ,"cmbCURRENCY_CD" );

        var exceptionList = new Array(  // "txtBASIC_YMD"
                                        //,"imgBASIC_YMD"
                                         "cmbBUT_CITY_CD"
                                        ,"cmbJOB_CD_FROM");

        var keyList = new Array(         "txtBASIC_YMD"
                                        ,"cmbBUT_CITY_CD"   // 화폐단위
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbCURRENCY_CD" );
    </script>
    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS             |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 출장지 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_LT"/>
       <jsp:param name="CODE_GUBUN"    value="LT"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직위 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 환율 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_EX"/>
       <jsp:param name="CODE_GUBUN"    value="EX"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_OVERSEASBT_BASIS)|
    | 3. 사용되는 Table List(T_DI_OVERSEASBT_BASIS)	        |
    +------------------------------------------------------->
    <Object ID ="trT_DI_OVERSEASBT_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtBASIC_YMD_SHR.focus();
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준일/출장지/직위] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("기준일/출장지/직위에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_OVERSEASBT_BASIS event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_OVERSEASBT_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_DI_OVERSEASBT_BASIS event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //신규일 경우
            if(dsT_DI_OVERSEASBT_BASIS.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_DI_OVERSEASBT_BASIS event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_DI_OVERSEASBT_BASIS.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_DI_OVERSEASBT_BASIS.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }

            //비용
            var exp = fnc_covNumber(dsT_DI_OVERSEASBT_BASIS.NameString(row, "BUT_LODGING"))
                    + fnc_covNumber(dsT_DI_OVERSEASBT_BASIS.NameString(row, "BUT_EXPENSE"))
                    + fnc_covNumber(dsT_DI_OVERSEASBT_BASIS.NameString(row, "BUT_EXPENSE_OFFER"));

            if(exp == 0) {
                alert("비용은 반드시 하나는 입력하셔야 됩니다.");
                document.getElementById("txtBUT_LODGING").focus();
                return false;
            }
        }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">해외출장비지급기준</td>
					<td align="right" class="navigator">HOME/근태관리/해외출장/<font color="#000000">해외출장비지급기준</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="160"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">기준일&nbsp;</td>
                                <td class="padding2423">
									<input id="txtBASIC_YMD_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBASIC_YMD_SHR','','40','110');"></a>
								</td>
                                <td class="searchState" align="right">출장지역&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbBUT_CITY_CD_SHR"  style="width='170';" onChange="fnc_SearchList()">
                                        <option value="">전 체</option>
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">기준일</td>
					<td class="padding2423">
						<input type="text" id="txtBASIC_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtBASIC_YMD.disabled == true) return; calendarBtn('datetype1','txtBASIC_YMD','','60','150');"></a>
					</td>
					<td align="center" class="creamBold">출장지역</td>
                    <td class="padding2423">
									<comment id="__NSID__">
				<object id=cmbBUT_CITY_CD classid="clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197" height="120" width="130">
					<param name=ComboDataID		value="dsT_CM_COMMON_LT">
					<param name=SearchColumn	value="CODE">
					<param name=Sort			value="True">
					<param name=ListExprFormat	value="CODE^0^20,CODE_NAME^0^140">
					<param name=BindColumn		value="CODE">
					<param name=EditExprFormat 	value="% %;CODE;CODE_NAME">

					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>

					<!--
                        <select id="cmbBUT_CITY_CD"  style="width='100%';" onChange="">
                        </select>
						-->
                    </td>
					<td align="center" class="creamBold">직위</td>
                    <td class="padding2423" colspan="3">
                        <select id="cmbJOB_CD_FROM"  style="width=100px" onChange="">
                        </select>
                        &nbsp;~&nbsp;
                        <select id="cmbJOB_CD_TO"  style="width=100px" onChange="">
                        </select>
                    </td>

				</tr>
                <tr>
                    <td align="center" class="creamBold">단위</td>
                    <td class="padding2423">
                        <select id="cmbCURRENCY_CD"  style="width='100%';" onChange="">
                        </select>
                    </td>
					<td align="center" class="creamBold">숙박비</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="txtBUT_LODGING" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">일당</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="txtBUT_EXPENSE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">숙식제공시 일당</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="txtBUT_EXPENSE_OFFER" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERSEASBT_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_OVERSEASBT_BASIS">
							<param name="Format"				value="
								<FC> id={currow}		    width=35    name='NO'		align=center </FC>
								<FC> id='BASIC_YMD'	    width=80	name='기준일'	align=center </FC>
								<FC> id='BUT_CITY_CD'	width=151	name='출장지역'	align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_LT:CODE:CODE_NAME'</FC>
                                <FC> id='JOB_CD_FROM'	width=71	name='직위 From'	    align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_A2:CODE:CODE_NAME'</FC>
                                <FC> id='JOB_CD_TO'	    width=71	name='직위 To'	    align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_A2:CODE:CODE_NAME'</FC>
                                <FC> id='CURRENCY_CD'    width=71    name='단위'       align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_EX:CODE:CODE_NAME'</FC>
                                <FC> id='BUT_LODGING'    width=71   name='숙박비'  align=right     rightmargin=10</FC>
                                <FC> id='BUT_EXPENSE'	width=71	name='일당' 	align=right     rightmargin=10</FC>
                                <FC> id='SUM'	        width=71	name='합계'	    align=right	Value={BUT_LODGING+BUT_EXPENSE}      rightmargin=10</FC>
                                <C> id='BUT_EXPENSE_OFFER'	width=71	name='숙박제공시'	align=right     rightmargin=10</C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 해외출장비 지급기준 테이블 -->
<object id="bndT_DI_OVERSEASBT_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_OVERSEASBT_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=BASIC_YMD      	    Ctrl=txtBASIC_YMD      	    Param=value </C>
		<C>Col=BUT_CITY_CD		    Ctrl=cmbBUT_CITY_CD	   	    Param=BindColVal	</C>
		<C>Col=JOB_CD_FROM  		Ctrl=cmbJOB_CD_FROM 	    Param=value	</C>
		<C>Col=JOB_CD_TO    		Ctrl=cmbJOB_CD_TO 	        Param=value	</C>
		<C>Col=BUT_LODGING		    Ctrl=txtBUT_LODGING 	    Param=Text	</C>
		<C>Col=BUT_EXPENSE		    Ctrl=txtBUT_EXPENSE		    Param=Text	</C>
        <C>Col=BUT_EXPENSE_OFFER    Ctrl=txtBUT_EXPENSE_OFFER	Param=Text	</C>
        <C>Col=CURRENCY_CD          Ctrl=cmbCURRENCY_CD        	Param=value	</C>
    '>
</object>
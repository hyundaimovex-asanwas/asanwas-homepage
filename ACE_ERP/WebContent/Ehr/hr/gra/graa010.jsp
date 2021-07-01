<!--
***********************************************************************
* @source      : graa010.jsp
* @description : 승급제외자관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/11      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>승급제외자관리(graa010)</title>
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
        var rai_ymd = getToday().substring(0,5)+"03-01";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var rai_yy = document.getElementById('txtRAI_YY_SHR').value;
			var eno_no = document.getElementById('txtENO_NO_SHR').value;

            //코드가 정해지지 않았음
            //var reject_cd = document.getElementById('cmbREJECT_CD_SHR').value;

            if(!fnc_SearchItemCheck()) return;

			dsT_PM_NOGRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa010.cmd.GRAA010CMD&S_MODE=SHR&RAI_YY="+rai_yy+"&ENO_NO="+eno_no+"&REJECT_CD=";
    		dsT_PM_NOGRADE.reset();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_PM_NOGRADE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_PM_NOGRADE.GridToExcel("승급제외자관리", '', 225);

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

			document.getElementById('txtRAI_YY_SHR').value = getTodayArray()[0];
			document.getElementById('txtENO_NO_SHR').value = "";
            document.getElementById('txtENO_NM_SHR').value = "";
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_NOGRADE.ClearData();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_PM_NOGRADE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			if(document.getElementById('txtRAI_YY_SHR').value == ""){
                alert("승급예정일을 입력하세요!");
                document.getElementById('txtRAI_YY_SHR').focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_PM_NOGRADE,0,"false","false");      // Grid Style 적용

            document.getElementById('txtRAI_YY_SHR').value = getTodayArray()[0];
            document.getElementById('txtRAI_YY_SHR').focus();
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_PM_NOGRADE)  |
    | 3. 사용되는 Table List(T_PM_NOGRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_PM_NOGRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_PM_NOGRADE)	|
    | 3. 사용되는 Table List(T_PM_NOGRADE)	        |
    +--------------------------------------------------->
    <Object ID ="trT_PM_NOGRADE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 제외기준 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_P2"/>
       <jsp:param name="CODE_GUBUN"    value="P2"/>
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
    <Script For=dsT_PM_NOGRADE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_NOGRADE.CountRow);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_NOGRADE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_PM_NOGRADE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[승급기준일, 사번]\n\n입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        if(confirm("사번에 대한 중복값이 존재합니다.\n중복된 데이터를 삭제 하시겠습니까?")){
                dsT_PM_NOGRADE.DeleteRow(dsT_PM_NOGRADE.RowPosition);
            }
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_PM_NOGRADE event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_PM_NOGRADE event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승급제외자관리</td>
					<td align="right" class="navigator">HOME/인사관리/승급/<font color="#000000">승급제외자관리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
									<col width="80"></col>
									<col width="100"></col>
									<col width="60"></col>
									<col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">기준년도&nbsp;</td>
								<td align="left" class="padding2423">
	                                <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
	                                    <tr>
	                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
	                                            <input type="text" id="txtRAI_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
	                                        </td>
	                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtRAI_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
	                                    </tr>
	                                    <tr>
	                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtRAI_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
	                                    </tr>
	                                </table>
								</td>
								<td align="right" class="searchState">사번&nbsp;</td>
                                <td align="left" class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_PM_NOGRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_PM_NOGRADE">
							<param name="Format"					value="
                                <C> id={currow}		width=29    name='NO'			align=center                     </C>
                                <C> id='REJECT_NM'  width=160   name='제외기준'     align=center  suppress=1         </C>
                                <C> id='DPT_NM'     width=100   name='소속'         align=center                     </C>
                                <C> id='JOB_NM'     width=40    name='직위'         align=center                     </C>
                                <C> id='ENO_NO'		width=70	name='사번'			align=center                     </C>
                                <C> id='ENO_NM'		width=60	name='성명'			align=center                     </C>
                                <C> id='RAI_YMD'    width=70    name='승급기준일'   align=center   </C>
                                <C> id='HOB'		width=40	name='호봉'			align=center   </C>
                                <C> id='HIR_YMD'	width=70	name='입사일'	    align=center   </C>
                                <C> id='HBA_YMD'	width=70	name='승급일'	    align=center   </C>
                                <C> id='FPRO_YMD'	width=70	name='승진일'		align=center   </C>
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
<!-- ***** 설정 테이블 -->
<object id="bndT_PM_NOGRADE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_PM_NOGRADE">
    <Param Name="BindInfo", Value='
        <C>Col=RAI_YMD		Ctrl=txtRAI_YMD	      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NM    	Ctrl=txtENO_NM	     	Param=value		</C>
        <C>Col=DPT_CD		Ctrl=hidDPT_CD      	Param=value		</C>
        <C>Col=DPT_NM		Ctrl=txtDPT_NM	      	Param=value		</C>
        <C>Col=PJOB_CD		Ctrl=hidPJOB_CD	     	Param=value		</C>
        <C>Col=JOB_NM		Ctrl=txtJOB_NM	     	Param=value		</C>
        <C>Col=HOB_CD		Ctrl=hidHOB_CD	     	Param=value		</C>
        <C>Col=HOB_NM		Ctrl=txtHOB_NM     	    Param=value		</C>
        <C>Col=YRP_CNT		Ctrl=txtYRP_CNT     	Param=value		</C>
        <C>Col=FINJ_CD		Ctrl=hidFINJ_CD     	Param=value		</C>
        <C>Col=FINJ_NM		Ctrl=txtFINJ_NM     	Param=value		</C>
        <C>Col=HIR_YMD		Ctrl=txtHIR_YMD   	    Param=value		</C>
        <C>Col=GHI_YMD		Ctrl=txtGHI_YMD    	    Param=value		</C>
        <C>Col=GRP_NAM		Ctrl=txtGRP_NAM    	    Param=value		</C>
        <C>Col=HBA_YMD		Ctrl=txtHBA_YMD    	    Param=value		</C>
        <C>Col=FPRO_YMD		Ctrl=txtFPRO_YMD   	    Param=value		</C>
        <C>Col=REPU_YMD		Ctrl=txtREPU_YMD   	    Param=value		</C>
        <C>Col=REJECT_CD	Ctrl=cmbREJECT_CD  	    Param=value		</C>
        <C>Col=OCC_CD	    Ctrl=hidOCC_CD  	    Param=value		</C>
        <C>Col=STTJ_CD	    Ctrl=hidSTTJ_CD  	    Param=value		</C>
    '>
</object>
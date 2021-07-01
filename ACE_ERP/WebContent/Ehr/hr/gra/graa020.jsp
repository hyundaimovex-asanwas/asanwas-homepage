<!--
***********************************************************************
* @source      : graa020.jsp
* @description : 승급대상자선정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      오대성        최초작성.
* 2007/04/26      조정호        작업로그 처리
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>승급대상자선정(graa020)</title>
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

        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장
                    + "F"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var rai_ymd = getToday().substring(0,4)+"-03-01";
        //var pas_ymd = (getToday().substring(0,4)-1)+"-03-01";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var rai_ymd = document.getElementById("txtRAI_YMD_SHR").value;

            //트랜잭션 전송
	        trT_PM_GRADE_SHR.KeyValue = "tr(O:dsT_PM_GRADE=dsT_PM_GRADE, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_GRADE_SHR.Action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa020.cmd.GRAA020CMD&S_MODE=SHR&RAI_YMD="+rai_ymd;
            trT_PM_GRADE_SHR.Post();

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
            var oRAI_YMD = document.getElementById("txtRAI_YMD_SHR");   //승급 예정일

            if(!fnc_SaveItemCheck()) return;

            if(!confirm("승급대상자 선정을 하시겠습니까?")){
                return false;
            }

            dsT_PM_GRADE.UseChangeInfo = "false";

			//트랜잭션 전송
            trT_PM_GRADE_SAV.KeyValue = "tr01(I:dsT_PM_GRADE=dsT_PM_GRADE, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
			trT_PM_GRADE_SAV.Action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa020.cmd.GRAA020CMD&S_MODE=SAV&RAI_YMD="+oRAI_YMD.value;
			trT_PM_GRADE_SAV.Post();
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

            // 엑셀로 변환 할 자료가 있는지 체크하고

            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //document.getElementById("txtRAI_YMD_SHR").value = rai_ymd;
            //document.getElementById("txtPAS_YMD_SHR").value = pas_ymd;
            document.form1.txtPRO_CNT.value     = "";
            document.form1.txtTRG_CNT.value     = "";
            document.form1.txtERR_CNT.value     = "";
            document.form1.txtPRO_STS_MSG.value = "";
            document.getElementById("resultMessage").innerText = ' ';

            dsT_PM_GRADE.ClearData();
            dsT_CP_WORKLOG.ClearData();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

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

            if( document.getElementById("txtRAI_YMD_SHR").value == '') {
				alert("승급일자는 필수입력사항입니다.");
				document.getElementById("txtRAI_YMD_SHR").focus();
				return false;
			}

			/*
            if( document.getElementById("txtPAS_YMD_SHR").value == '') {
				alert("종전기준일은 필수입력사항입니다.");
				document.getElementById("txtPAS_YMD_SHR").focus();
				return false;
			}
			*/

            if ( dsT_PM_GRADE.CountRow < 1 ) {
				alert("저장할 승급 대상자가 없습니다.");
                return false;
			}

            if(dsT_CP_WORKLOG.CountRow == 1) {
                alert("해당년도의 승급대상자 처리가 이미 이루어졌습니다.");
                return false;
            }
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtRAI_YMD_SHR").value = rai_ymd;
            //document.getElementById("txtPAS_YMD_SHR").value = pas_ymd;

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

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
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_GRADE)     |
    | 3. 사용되는 Table List(T_PM_GRADE)            |
    +----------------------------------------------->
    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_PM_GRADE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>

    <Object ID ="trT_PM_GRADE_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_PM_GRADE_SHR event="OnSuccess()">

        if (dsT_PM_GRADE.CountRow == 0) {
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승급대상자가 없습니다.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            document.getElementById("txtTRG_CNT").value = dsT_PM_GRADE.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";

        } else if(dsT_CP_WORKLOG.CountRow == 1) {
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승급대상자 선정을 완료하였습니다.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_GRADE.CountRow);

            document.getElementById("txtTRG_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT")+dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");

        } else {
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승급대상자 선정이 가능합니다.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_GRADE.CountRow);

            document.getElementById("txtTRG_CNT").value = dsT_PM_GRADE.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";
        }

    </script>

    <script for=trT_PM_GRADE_SAV event="OnSuccess()">
        if(dsT_CP_WORKLOG.CountRow == 1){ // 저장
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");

            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승급대상자 선정을 완료하였습니다..';
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");

        }else{// 조회
            alert("승급대상자 선정에 실패하였습니다.");
            document.getElementById("resultMessage").innerText = ' ';
        }
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_PM_GRADE_SHR event="OnFail()">
        alert(trT_PM_GRADE_SHR.ErrorMsg);
    </script>

    <script for=trT_PM_GRADE_SAV event="OnFail()">
        alert(trT_PM_GRADE_SAV.ErrorMsg);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
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
						<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승급대상자선정</td>
						<td align="right" class="navigator">HOME/인사관리/승급/<font color="#000000">승급대상자선정</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                            <!-- <col width="100"></col> -->
                            <col width="80"></col>
                            <col width="130"></col>
                            <col width="80"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
                            <!-- <td align="right" class="searchState">대상자선정&nbsp;</td>  -->
                            <td class="searchState"align="right">승급일자</td>
                            <td class="padding2423" align="left">
	                            <input id=txtRAI_YMD_SHR name=txtRAI_YMD_SHR value="" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="divInput" onblur="cfCheckDate(this);" onkeyup="cfDateHyphen(this);" onkeypress="cfCheckNumber();" valid='key=true' field='적용일자'>
	                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtRAI_YMD_SHR','','60','110');"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td class="searchState"align="right"><!-- 종전기준일 --></td>
                            <td class="padding2423" align="left">
                                <!--
	                            <input id=txtPAS_YMD_SHR name=txtPAS_YMD_SHR value="" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="divInput" onblur="cfCheckDate(this);" onkeyup="cfDateHyphen(this);" onkeypress="cfCheckNumber();" valid='key=true' field='적용일자'>
	                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPAS_YMD_SHR','','425','145');"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle"></a>
	                            -->
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
                <col width="70"></col>
                <col width=""></col>
                <tr>
                    <td align="center" class="creamBold">대상인원</td>
                    <td class="padding2423" align="left">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        승급대상인원&nbsp;<input id="txtTRG_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;명
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        승급인원&nbsp;<input id="txtPRO_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;명
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        승급제외&nbsp;<input id="txtERR_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;명
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">작업상황</td>
                    <td  class="padding2423" colspan="2">
                        <input id="txtPRO_STS_MSG" style="width:100%"  class="input_ReadOnly" readonly>
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

	</form>
	<!-- form 끝 -->

</body>
</html>
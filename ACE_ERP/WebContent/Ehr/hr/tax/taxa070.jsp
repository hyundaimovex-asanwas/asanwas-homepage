<!--*************************************************************************
* @source      : taxa070.jsp                                                *
* @description : 연말정산자료급여반영 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>연말정산자료급여반영(taxa070)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장(처리)
                    + "T"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa070.cmd.TAXA070CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oPIS_YY     = document.getElementById("txtPIS_YY_SHR");

            params = "&S_MODE=SHR"
                   + "&OCC_CD="+oOCC_CD.value
                   + "&PIS_YY="+oPIS_YY.value;

            dsT_CP_PAYMASTER.ClearData();

            dsT_CP_PAYMASTER.dataid = dataClassName+params;
            dsT_CP_PAYMASTER.reset();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            //유효성 검사
            if(!fnc_CheckElement(oElementList, oElementMsgList, new Array())) return;
            if(fnc_GetCheckedValue("radSAL_GBN") == "") {
                alert("구분을 선택해 주세요.");
                document.getElementById("radSAL_GBN").focus();
                return;
            }
            dsT_CP_PAYMASTER.UseChangeInfo = "false";

            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oPIS_YY     = document.getElementById("txtPIS_YY_SHR");
            var vPIS_YM     = document.getElementById("txtPIS_YM").value.split("-");
            var oSVC_TYPE   = document.getElementById("txtSVC_TYPE");

            params = "&S_MODE=SAV"
                   + "&OCC_CD="+oOCC_CD.value
                   + "&PIS_YY2="+oPIS_YY.value
                   + "&PIS_YY="+vPIS_YM[0]
                   + "&PIS_MM="+vPIS_YM[1]
                   + "&SAL_GBN="+fnc_GetCheckedValue("radSAL_GBN")
                   + "&SVC_TYPE="+oSVC_TYPE.value;

            trT_CP_PAYMASTER.KeyValue = "SAV"
                                      + "(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"
                                      + ",O:dsRESULT=dsRESULT"
                                      + ")";
            trT_CP_PAYMASTER.action = dataClassName+params;
            trT_CP_PAYMASTER.post();
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_CP_PAYMASTER.GridToExcel("연말정산자료급여반영", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_PAYMASTER.ClearData();

            //날자값들 바인딩
            var toDays = getTodayArray();
            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1];
            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1];
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_PAYMASTER.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            var oPIS_YY_SHR = document.getElementById("txtPIS_YY_SHR");
            oPIS_YY_SHR.value = getTodayArray()[0]-1;

            var oBTN1 = document.getElementById("btnPROC1");
            var oBTN2 = document.getElementById("btnPROC2");
            oBTN1.disabled = true;
            oBTN2.disabled = true;

   				alert("연말정산  급여 반영 변동자료로 처리바랍니다.");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * 기타 함수              *
         ********************************************/

        //지금 정의되어 있는 항목들
        var oElementList = new Array(   "txtPIS_YY_SHR"
                                       ,"cmbOCC_CD_SHR"
                                       ,"txtPIS_YM");

        //항목들의 메세지
        var oElementMsgList = new Array("년말정산 해당년도"
                                       ,"근로구분"
                                       ,"해당년월");

        //예외 항목들
        var oExceptionList = new Array( "cmbOCC_CD_SHR"
                                       ,"txtPIS_YM");




    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_PAYMASTER)                |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut             value="3600000">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut             value="3600000">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_PAYMASTER)                |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName             Value="toinb_dataid4">
        <param name=TimeOut             value="3600000">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0 )    {
            alert("정산 대상이 없습니다.");
        } else {
            var vPRO_STS;
            var oBTN1 = document.getElementById("btnPROC1");
            var oBTN2 = document.getElementById("btnPROC2");

            oBTN1.disabled = true;
            oBTN2.disabled = true;

            if(dsT_CP_PAYMASTER.NameString(1, "PIS_YY") != "" || dsT_CP_PAYMASTER.NameString(1, "PIS_MM") != "")
                document.getElementById("txtPIS_YM").value  = dsT_CP_PAYMASTER.NameString(1, "PIS_YY")+"-"+dsT_CP_PAYMASTER.NameString(1, "PIS_MM");
            fnc_CheckedElement("radSAL_GBN", dsT_CP_PAYMASTER.NameString(1, "SAL_GBN"));

            vPRO_STS = dsT_CP_PAYMASTER.NameString(1, "PRO_STS");
            document.getElementById("txtPRO_STS").value     = vPRO_STS;
            document.getElementById("txtPRO_STS_MSG").value = dsT_CP_PAYMASTER.NameString(1, "PRO_STS_MSG");

            document.getElementById("txtPRO_CNT").value     = dsT_CP_PAYMASTER.NameString(1, "PRO_CNT");

            if(vPRO_STS == "3") oBTN1.disabled = false;
            else oBTN2.disabled = false;
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        alert(dsRESULT.NameString(1,"PRO_STS")+":("+dsRESULT.NameString(1,"RTN_CD")+") "+dsRESULT.NameString(1,"RTN_MSG"));
        fnc_OnLoadProcess();
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연말정산자료급여반영</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">연말정산자료급여반영</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="130"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td class="searchState" align="right">년말정산 해당년도</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()" onchange="clearDS()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY','','134','108');"></a>
                    </td>
                    <td class="searchState" align="right">직&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD_SHR" id="cmbOCC_CD_SHR">
                            <option value="A">사무직</option>
                            <option value="M">택배직</option>
                        </select>
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
    					<col width="310"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
                        <td align="center" class="creamBold">급(상)여</td>
    					<td align="center" class="creamBold">해당년월</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','134','108');"></a>
    					</td>
    	        		<td align="center" class="creamBold">구분</td>
    	        		<td>
                            &nbsp;&nbsp;
                            <input type="radio" id="radSAL_GBN" name="radSAL_GBN" value="0">&nbsp;급여
                            &nbsp;&nbsp;
                            <input type="radio" id="radSAL_GBN" name="radSAL_GBN" value="1">&nbsp;상여
    	        		</td>
    				</tr>
    				<tr>
    	        		<td align="center" class="creamBold" colspan="2">작업상황</td>
    	        		<td  class="padding2423">
    	        			<input id="txtPRO_STS" name="txtPRO_STS" style="width:20px"  class="input_ReadOnly" readonly>
    	        			<input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:90%"  class="input_ReadOnly" readonly>
    	        		</td>
                        <td align="center" class="creamBold">처리인원</td>
                        <td  class="padding2423">
                            <input id="txtPRO_CNT" name="txtPRO_CNT" style="width:100px"  class="input_ReadOnly" readonly>&nbsp;명
                        </td>
    	            </tr>
                    <tr>
                        <td align="center" class="creamBold" colspan="2">작업선택</td>
                        <td  class="padding2423" colspan="3" colspan="3" height="60">
                            <input type="hidden" id="txtSVC_TYPE" name="txtSVC_TYPE" value="">
                            &nbsp;&nbsp;
                            <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" 반   영 " onclick="document.getElementById('txtSVC_TYPE').value = 'Y'; fnc_Save();">
                            &nbsp;
                            <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" 취   소 " onclick="document.getElementById('txtSVC_TYPE').value = 'N'; fnc_Save();">
                            &nbsp;&nbsp;
                        </td>
                    </tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- 조건 입력 테이블 끝 -->

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

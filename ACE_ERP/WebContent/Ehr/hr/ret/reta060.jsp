<!--*************************************************************************
* @source      : reta060.jsp                                                *
* @description : 퇴직보험금관리 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
    <title>퇴직보험금관리(reta060)</title>
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
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta060.cmd.RETA060CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_SearchItemCheck()) return;

            var oPIS_YY = document.getElementById("txtPIS_YY");
            var oBNK_CD = document.getElementById("cmbBNK_CD");

            params = "&S_MODE=SHR"
                   + "&PIS_YY="+oPIS_YY.value
                   + "&BNK_CD="+oBNK_CD.value;
            
            trT_AC_RETINSURANCE.KeyValue = "SHR(O:dsT_AC_RETINSURANCE=dsT_AC_RETINSURANCE)";
            trT_AC_RETINSURANCE.action = dataClassName+params;
            trT_AC_RETINSURANCE.post();            
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
                dsT_CM_COMMON_BK.DataID = dataClassName+"&S_MODE=ITM_SHR";
                dsT_CM_COMMON_BK.Reset();
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {

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
            var oPIS_YY = document.getElementById("txtPIS_YY");
            var oBNK_CD = document.getElementById("cmbBNK_CD");
            var params;

            params = "PIS_YY="+oPIS_YY.value
                   + "&BNK_CD="+oBNK_CD.value;

            var url = "reta060_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETINSURANCE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETINSURANCE.GridToExcel("퇴직보험금관리", '', 225);
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

            dsT_AC_RETINSURANCE.ClearData();

            fnc_ClearInputElement(oElementList);

            //년도 초기화
            document.getElementById("txtPIS_YY").value = getTodayArray()[0];
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETINSURANCE.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList);
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
            //보험회사명 가져오기
            fnc_SearchItem();

            var oSelect = null;
            var oOption = null;

            // 근로구분 구분 검색 콤보박스 생성
            oSelect = document.getElementById("cmbBNK_CD");
            //첫번째 라인을 제외한 모든 option 삭제
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }
            for(i = 1; i <= dsT_CM_COMMON_BK.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_BK.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_BK.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

            //첫번째 인수 : 그리드명
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_AC_RETINSURANCE,0,"false","false");      // Grid Style 적용

            //년도 초기화
            document.getElementById("txtPIS_YY").value = getTodayArray()[0];
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
        var oElementList = new Array(    "txtPIS_YY"
                                        ,"cmbBNK_CD");

        //항목들의 메세지
        var oElementMsgList = new Array( "기준연도"
                                        ,"보험회사구분");

        //예외 항목들
        var oExceptionList = new Array(  "cmbBNK_CD");

        /**
         * DataSet을 초기화 시킴
         */
        function clearDS() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETINSURANCE.ClearData();
        }

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETINSURANCE)                |
    | 3. 사용되는 Table List(T_AC_RETINSURANCE)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINSURANCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_BK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETINSURANCE)                |
    | 3. 사용되는 Table List(T_AC_RETINSURANCE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINSURANCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINSURANCE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINSURANCE.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINSURANCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINSURANCE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINSURANCE event="OnSuccess()">
        //fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINSURANCE event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_RETINSURANCE event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_AC_RETINSURANCE.CountRow; i++) {
            dsT_AC_RETINSURANCE.NameValue(i, "STATUS") = bCheck;
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직보험금관리</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직보험관리/<font color="#000000">퇴직보험금관리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
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
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기준연도</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YY" name="txtPIS_YY" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY','','134','108');"></a>
					</td>
					<td class="searchState" align="right">보험회사구분</td>
					<td class="padding2423" align="left">
                        <select id="cmbBNK_CD" name="cmbBNK_CD">
                            <option value="">선택하세요</option>
                        </select>
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
    					<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_AC_RETINSURANCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RETINSURANCE">
                        <param name=ColSelect  value=true>
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"      width=40		  align=center	  name="NO"         value={String(Currow)}</C>
                            <C> id=BNK_NM         width=140       align=center    name=보험사             Suppress=1</C>
                            <C> id=PIS_YM         width=120       align=center    name=발생년월         </C>
                            <C> id=RES_AMT        width=120       align=right     name=충당금           rightmargin=10 </C>
                            <C> id=INTEREST       width=120       align=right     name=이자             rightmargin=10 </C>
                            <C> id=PAID_AMT       width=120       align=right     name=중도지급액       rightmargin=10 </C>
                            <C> id=BAL_AMT        width=120       align=right     name=차액             rightmargin=10 </C>
						'>
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

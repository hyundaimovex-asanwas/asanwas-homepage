<!--*************************************************************************
* @source      : reta020.jsp                                                *
* @description : 퇴직금중간정산신청현황 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>퇴직금중간정산신청현황(reta020)</title>
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
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta020.cmd.RETA020CMD";
        var params = null;


        //동적 그리드 포멧을 위해
        var gridFormat =   "<C> id='{CUROW}'        width=40        align=center        name='NO'                       HeadBgColor='#F7DCBB'   value={String(Currow)}</C>"
                         + "<C> id=DPT_NM           width=70        align=center        name='부 서'                    HeadBgColor='#F7DCBB'   Edit=None SubSumText='계'</C>"
                         + "<C> id=JOB_NM           width=70        align=center        name='직 위'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=ENO_NM           width=70        align=center        name='성 명'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=IPT_YMD          width=70        align=center        name='신청일'                   HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=APP_YN           width=50        align=center        name='상태'                   HeadBgColor='#F7DCBB'   EditStyle=Combo  Pointer=Hand Data='A:신청,R:접수,N:반송,Y:지급'    BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "<C> id=HIRG_YMD         width=70        align=center        name='입사일'                   HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=RAM_YMD          width=70        align=center        name='중간정산일'               HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<G> name='현재기준'     HeadBgColor='#F7DCBB'"
                         + "    <C> id=REQ_YMD      width=70        align=center        name='정산기준'                 HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=RET_LSE_YMD  width=110       align=center        name='근속기간 (A)'             HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=AVG_PAY      width=130       align=right         name='평균임금/월 (B)'          HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "    <C> id=RET_PAY      width=150       align=right         name='퇴직금총액 (C = A x B)'   HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "</G>"
                         + "<G> name='중간정산 신청내역'     HeadBgColor='#F7DCBB'"
                         + "    <C> id=SEQ_NO       width=40        align=center        name='차 수'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=BASIC_YMD    width=70        align=center        name='정산기준'                 HeadBgColor='#F7DCBB'   Edit=Numeric        Mask='XXXX/XX/XX'        BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "    <C> id=MID_LSE_YMD  width=110       align=center        name='기 간'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=MID_PAY      width=110       align=right         name='금 액'                    HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "    <C> id=MID_PAY_PER  width=50        align=center        name='%'                        HeadBgColor='#F7DCBB'   Edit=None</C> SubSumText=''"
                         + "    <C> id=Expr         width=70        align=right         name='정산후잔액'               value={RET_PAY-MID_PAY} HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "</G>"
                         + "<X> name='심의위원회 결정(안)' HeadBgColor='#F7DCBB'"
                         + "    <C> id=APP_YMD      width=70        align=center        name='정산기준'                 HeadBgColor='#F7DCBB'     Edit=Numeric       Mask='XXXX/XX/XX'        BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "    <C> id=APP_LSE_YMD  width=110       align=center        name='기 간'                    HeadBgColor='#F7DCBB'     Edit=None</C>"
                         + "    <C> id=APP_PAY      width=110       align=right         name='금 액'                    HeadBgColor='#F7DCBB'     rightmargin=10             BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "    <R>"
                         + "        <G> name='퇴직보험'            HeadBgColor='#F7DCBB'"
                         + "            <C> id=Expr         width=110       align=right         name='회사지급'        value={if(APP_PAY-BNK_SUM > 0, APP_PAY-BNK_SUM, 0)} HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "            <C> id=BNK_SUM      width=110       align=right         name=' 계 '            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>" ;

        //동적 그리드 포멧 뒷부분
        var gridFormat2 =  "        </G>"
                         + "    </R>"
                         + "    <R>"
                         + "        <G> name='공제액'            HeadBgColor='#F7DCBB'"
                         + "            <C> id=ICM_TAX      width=110       align=right         name='소득세'            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "            <C> id=DBW_TAX      width=110       align=right         name='농어촌특별세'            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "            <C> id=DJM_TAX      width=110       align=right         name='주민세'            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "        </G>"
                         + "    </R>"
                         + "</X>"
                         + "<C> id=REASON_NM        width=120       align=center        name='신청사유'                 HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=REASON           width=180       align=center        name='신청사유 상세'                 HeadBgColor='#F7DCBB'   Edit=None</C>";


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_SearchItemCheck()) return;

            //검색조건
            var oSTR_YMD = document.getElementById("txtSTR_YMD_SHR");
            var oEND_YMD = document.getElementById("txtEND_YMD_SHR");
            var oDPT_CD = document.getElementById("txtDPT_CD_SHR");
            var oAPP_YN = document.getElementById("cmbAPP_YN_SHR");

            params = "&S_MODE=SHR"
                   + "&DPT_CD="+oDPT_CD.value
                   + "&STR_YMD="+oSTR_YMD.value
                   + "&END_YMD="+oEND_YMD.value
                   + "&APP_YN="+oAPP_YN.value;

            trT_AC_RETTABLE.KeyValue = "SHR(O:dsT_AC_RETTABLE=dsT_AC_RETTABLE,O:dsBNK_INFO=dsBNK_INFO)";
            trT_AC_RETTABLE.action = dataClassName+params;
            trT_AC_RETTABLE.post();
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
            //저장유효성 검사
            if(!fnc_SaveItemCheck()) return;

            trT_AC_RETTABLE.KeyValue = "reta(I:dsT_AC_RETTABLE=dsT_AC_RETTABLE)";
            trT_AC_RETTABLE.action = dataClassName+"&S_MODE=SAV";
            trT_AC_RETTABLE.post();

            fnc_SearchList();
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
	           //검색조건
            var oSTR_YMD = document.getElementById("txtSTR_YMD_SHR");
            var oEND_YMD = document.getElementById("txtEND_YMD_SHR");
            var oDPT_CD = document.getElementById("txtDPT_CD_SHR");
            var oAPP_YN = document.getElementById("cmbAPP_YN_SHR");

			var url = "reta020_PV.jsp?PIS_SDAY="+oSTR_YMD.value + "&PIS_EDAY="+oEND_YMD.value + "&DPT_CD="+oDPT_CD.value + "&APP_YN="+oAPP_YN.value;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETTABLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETTABLE.GridToExcel("퇴직금중간정산신청현황", '', 225);
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
            document.getElementById("resultMessage").innerText = '&nbsp;';
            dsT_AC_RETTABLE.ClearData();
            fnc_ClearInputElement(oElementList);

            document.getElementById("grdT_AC_RETTABLE").Format = gridFormat+gridFormat2;

            //document.getElementById("txtSTR_YMD_SHR").value = getToday();
            //document.getElementById("txtEND_YMD_SHR").value = getToday();

            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"true","false");      // Grid Style 적용
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETTABLE.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            /*
            for(var i=1; i<=dsT_AC_RETTABLE.CountRow; i++) {
                if(dsT_AC_RETTABLE.RowStatus(i) == "3") {
                    if(dsT_AC_RETTABLE.NameString(i, "IS_PROC") == "N") {
                        alert("no:"+i+" 이미 중간정산 처리가 완료 되었습니다.");
                        dsT_AC_RETTABLE.RowPosition = i;
                        return false;
                    }
                }
            }
            */
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            document.getElementById("grdT_AC_RETTABLE").Format = gridFormat+gridFormat2;

            document.getElementById("txtSTR_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtEND_YMD_SHR").value = getToday();

            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"true","false");      // Grid Style 적용
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
        var oElementList = new Array(    "txtSTR_YMD_SHR"
                                        ,"txtEND_YMD_SHR"
                                        ,"txtDPT_NM_SHR");

        //항목들의 메세지
        var oElementMsgList = new Array( "검색시작일"
                                        ,"검색종료일"
                                        ,"부서명");
        //예외 항목들
        var oExceptionList = new Array(  "txtDPT_NM_SHR");

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsBNK_INFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETTABLE)                |
    | 3. 사용되는 Table List(T_AC_RETTABLE)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value=total>
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETTABLE)                |
    | 3. 사용되는 Table List(T_AC_RETTABLE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName             Value="toinb_dataid4">
        <param name=TimeOut             value="360000">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETTABLE event="OnSuccess()">
        if (dsT_AC_RETTABLE.CountRow == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETTABLE.RealCount(1, dsT_AC_RETTABLE.CountRow));

            //검색이 성공적으로 이루어 졌을때 해당 보험사 만큼 필드 크기를 늘림
            var oGRID = document.getElementById("grdT_AC_RETTABLE");
            var gridAdd = "";

            for(var i=1; i<=dsBNK_INFO.CountRow; i++) {
                gridAdd += "<C> id='"+dsBNK_INFO.NameString(i,"BNK_CD")+"' width=110 align=right name='"+dsBNK_INFO.NameString(i,"BNK_NM")+"' HeadBgColor='#F7DCBB' Edit=None rightmargin=10</C>" ;
            }

            oGRID.Format = gridFormat+gridAdd+gridFormat2;
            cfStyleGrid(oGRID,0,"true","false");
        }
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETTABLE event="OnFail()">
        alert(trT_AC_RETTABLE.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AC_RETTABLE event=OnRowPosChanged(row)>

    </script>

    <script language=JavaScript for=grdT_AC_RETTABLE event=OnClick(row,colid)>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직금중간정산신청현황</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직금관리/<font color="#000000">퇴직금중간정산신청현황</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="50"></col>
					<col width="220"></col>
					<col width="50"></col>
					<col width="190"></col>
					<col width="50"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기간</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
						 ~
						<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','208','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
                    <td class="searchState" align="right">부서</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) { fnc_SearchList(); fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR'); }" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
                        </a>
                    </td>
                    <td class="searchState" align="right">상태</td>
                    <td class="padding2423" align="left">
                        <select name="cmbAPP_YN_SHR" id="cmbAPP_YN_SHR">
                            <option value="">선택하세요</option>
                            <option value="A">신청</option>
                            <option value="R">접수</option>
                            <option value="N">반송</option>
                            <option value="Y">지급</option>
                        </select>
                    </td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="520" border="0" cellspacing="0" cellpadding="0">
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
					<object id="grdT_AC_RETTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RETTABLE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='

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

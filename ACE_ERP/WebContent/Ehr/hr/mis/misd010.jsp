<!--
    ************************************************************************************
    * @Source         : misd010.jsp                                                    *
    * @Description    : 노동임금통계조사 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/06  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>노동임금통계조사(misd010)</title>
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

        var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var DPT_CNT = dsT_CM_DEPT.CountRow;
            var DPT_CD = '';

            if (dsT_CM_DEPT.CountRow > 0) {

                for (var i = 0; i < dsT_CM_DEPT.CountRow; i++) {
                    DPT_CD = DPT_CD + dsT_CM_DEPT.NameValue(i + 1, "DPT_CD") + ",";
                }

            }

            if (PIS_YY == "" || PIS_MM == "") {
                alert("해당년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // 해당년월 CHECK
            if (!fnc_CheckDate(document.getElementById("txtPIS_YM_SHR"), '년월')) {
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            dsT_CP_PAYMASTER.ClearData();

            dsT_CP_PAYMASTER.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.d.misd010.cmd.MISD010CMD&S_MODE=SHR&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&DPT_CD="+DPT_CD+"&DPT_CNT="+DPT_CNT;
            dsT_CP_PAYMASTER.Reset();

            form1.grdT_CP_PAYMASTER.Focus();

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

            //이곳에 해당 코딩을 입력 하세요

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

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("노동임금통계조사", '', 225);

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

            //document.getElementById("txtPIS_YM_SHR").value = getToday().substr(0,7);
			document.getElementById("cmbRCV_DPT").length = 0;
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CP_PAYMASTER.ClearData();
            dsT_CM_DEPT.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");

            document.getElementById("txtPIS_YM_SHR").value = getToday().substr(0,7);
            document.getElementById("txtPIS_YM_SHR").focus();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

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

        function select_dpt() {

            var tempDS = fnc_selectDPT(dsT_CM_DEPT);

			document.getElementById('cmbRCV_DPT').length = 0;

			var oOption;
			for(var i=0 ; i<tempDS.CountRow ; i++) {

				oOption = document.createElement("OPTION");
				oOption.text = tempDS.NameValue(i+1, 'DPT_CD')+" "+tempDS.NameValue(i+1, 'DPT_NM');
				oOption.value = tempDS.NameValue(i+1, 'DPT_CD');

				document.getElementById('cmbRCV_DPT').add(oOption);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_PAYMASTER) |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)        |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_PAYMASTER) |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)        |
    +----------------------------------------------->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CP_PAYMASTER.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


<!--
***********************************************************************
* BODY START
***********************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">노동임금통계조사</td>
                    <td align="right" class="navigator">HOME/인사관리/인건비관련자료/<font color="#000000">노동임금통계조사</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState"> 년월&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '년월');"  onkeypress="cfDateHyphen(this);cfCheckNumber();if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPisYm','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPisYm" name="ImgPisYm" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','145','125');"></a>
                                </td>
                                <td>
									<select id="cmbRCV_DPT" name="cmbRCV_DPT">
									</select>
				                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDeptselect','','/images/button/btn_DeptselectOver.gif',1)"><img src="/images/button/btn_DeptselectOn.gif" name="imgDeptselect" width="80" height="20" border="0" align="absmiddle" onClick="select_dpt();"></a>
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
                        <object    id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
                            <param name="DataID"                    value="dsT_CP_PAYMASTER">
                            <param name="EdiTABLE"                  value="false">
                            <param name="DragDropEnable"            value="true">
                            <param name="SortView"                  value="Left">
                            <param name="VIEWSUMMARY"               value=0>
                            <param name="Format"                    value="
                                <C> id='{currow}'       width=45    name='순번'       align=center </C>
                                <C> id='DPT_NM'         width=100   name='구분'       align=center suppress=1 </C>
                                <C> id='RNUM'           width=40    name='NO'         align=center </C>
                                <C> id='JOB_NM'         width=60    name='직위'       align=left   </C>
                                <C> id='ENO_NO'         width=60    name='사번'       align=center </C>
                                <C> id='ENO_NM'         width=60    name='성명'       align=center </C>
                                <C> id='SEX_NM'         width=40    name='성별'       align=center value={DECODE(MF_TAG,'M','남','W','여','')}</C>
                                <G> name='급상여지급액' HeadBgColor='#F7DCBB'
                                    <C> id='SALT_AMT1'  width=100   name='급여'       align=right  </C>
                                    <C> id='SALT_AMT2'  width=100   name='상여'       align=right  </C>
                                    <C> id='SUM_AMT'    width=100   name='계'         align=right  </C>
                                </G>
                                <C> id='REMARK'         width=75    name='비고'       align=center </C>
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

</form>
<!-- form 끝 -->

</body>
</html>
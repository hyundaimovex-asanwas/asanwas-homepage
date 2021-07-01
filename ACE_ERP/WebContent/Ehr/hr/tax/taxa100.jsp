<!--*************************************************************************
* @source      : taxa100.jsp                                                *
* @description : 직위별부서별공제현황 PAGE                                    *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/05/05            김학수             최초작성
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>직위별부서별공제현황(taxa100)</title>
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

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa050.cmd.TAXA050CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var f = document.form1;
            var STR_YM  = f.txtSTR_YM_SHR.value;
            var END_YM  = f.txtEND_YM_SHR.value;
            var OCC_CD1;
            var OCC_CD2;
            var OCC_NM;
            var SAL_GBN = f.cmbSAL_GBN_SHR.value;
            var SAL_VAL;
            var SEQ     = f.cmbSORT_GBN_SHR.value;
            var LUN_AMT = f.cmbLUN_AMT_SHR.value;

            if ( STR_YM == null || STR_YM == "" )
            {
                alert("시작날짜를 입력해 주십시오!");
                f.txtSTR_YM_SHR.focus();
                return false;
            }
            if ( END_YM == null || END_YM == "" )
            {
                alert("끝나는날짜를 입력해 주십시오!");
                f.txtEND_YM_SHR.focus();
                return false;
            }

            if(removeChar(STR_YM,'-') > removeChar(END_YM,'-') || removeChar(STR_YM,'/') > removeChar(END_YM,'/')) {
                alert("시작연월이 종료연월보다 큽니다!");
                document.getElementById("txtSTR_YM_SHR").focus();
                return;
            }

            if ( f.cmbOCC_CD_SHR.value == "T" ) {
                OCC_CD1 = "A";
                OCC_CD2 = "M";
                OCC_NM  = "근로구분 : 전체";
            } else if ( f.cmbOCC_CD_SHR.value == "A" ) {
                OCC_CD1 = "A";
                OCC_CD2 = "A";
                OCC_NM  = "근로구분 : 사무직";
            } else if ( f.cmbOCC_CD_SHR.value == "M" ) {
                OCC_CD1 = "M";
                OCC_CD2 = "M";
                OCC_NM  = "근로구분 : 택배직";
            } else {
                OCC_CD1 = "A";
                OCC_CD2 = "M";
                OCC_NM  = "근로구분 : 전체";
            }

            if ( SAL_GBN == "0" ) {
                SAL_VAL = "구 분 : 급여";
            } else if ( SAL_GBN == "1" ) {
                SAL_VAL = "구 분 : 상여";
            } else if ( SAL_GBN == "4" ) {
                SAL_VAL = "구 분 : 연차";
            } else {
                SAL_GBN = "0";
                SAL_VAL = "구 분 : 급여";
            }


            params = "STR_YM="+STR_YM
                   + "&END_YM="+END_YM
                   + "&OCC_CD1="+OCC_CD1
                   + "&OCC_CD2="+OCC_CD2
                   + "&OCC_NM="+OCC_NM
                   + "&SAL_GBN="+SAL_GBN
                   + "&SAL_VAL="+SAL_VAL
                   + "&SEQ="+SEQ
                   + "&LUN_AMT="+LUN_AMT;

			var url = "taxa100_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

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

        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {

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
            //첫번째 인수 : 그리드명
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)

            document.getElementById("txtSTR_YM_SHR").value = getTodayArray()[0]+"-01";
            document.getElementById("txtEND_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
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
         * 날짜 형식 유효성 체크                     *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

         /********************************************
         * 종료일자에서 포커스 떠날때 신청일자와 비교*
         ********************************************/
        function cfCheckDateTermGUNA040(p_obj,p_stdt,p_endt) {
          if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
            if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
              alert("종료일자가 시작일자보다 큽니다.");
              document.getElementById(p_obj).value = '';
            }
          }
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet                               |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U5"/>
       <jsp:param name="CODE_GUBUN"    value="U5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직위별부서별공제현황</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">직위별부서별공제현황</font></td>
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
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a -->
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a -->
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a -->
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
				<tr>
                    <td align="right" class="searchState">해당기간&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtSTR_YM_SHR"  name="txtSTR_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtSTR_YM_SHR','','108','113');">
                        <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                         ~
                        <input type="text" id="txtEND_YM_SHR"  name="txtEND_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtEND_YM_SHR','','224','113');">
                        <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>

                    <td class="searchState" align="right">직&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423" align="left">
                        <select id="cmbOCC_CD_SHR">
                            <option value="T">전체</option>
                            <option value="A">사무직</option>
                            <option value="M">택배직</option>
                        </select>
<!--
                        <input type="checkbox" name="chkOCC_CD_SHR" id="chkOCC_CD_SHR" style="margin-bottom:-2px;border:0;" checked>사무직
                        <input type="checkbox" name="chkOCC_CD_SHR" id="chkOCC_CD_SHR" style="margin-bottom:-2px;border:0;">택배직  -->
                    </td>
                    <td align="right" class="searchState">중식대</td>
                    <td class="padding2423">
                        <select id="cmbLUN_AMT_SHR">
                            <option value="Y">포함</option>
                            <option value="N">비포함</option>
                        </select>
<!--                         <input type="checkbox" name="radLUN_AMT_SHR" id="radLUN_AMT_SHR" style="margin-bottom:-2px;border:0;" checked> -->
                    </td>
                    <td class="searchState" align="right">구분1</td>
                    <td class="padding2423" align="left">
                        <select id="cmbSAL_GBN_SHR">
                            <option value="0">급여</option>
                            <option value="1">상여</option>
                            <option value="4">연차</option>
                        </select>
<!--                         <input type="radio" name="radSAL_GBN_SHR" id="radSAL_GBN_SHR" style="margin-bottom:-2px;border:0;" checked>급여
                        <input type="radio" name="radSAL_GBN_SHR" id="radSAL_GBN_SHR" style="margin-bottom:-2px;border:0;">상여
                        <input type="radio" name="radSAL_GBN_SHR" id="radSAL_GBN_SHR" style="margin-bottom:-2px;border:0;">년월차 -->
                    </td>

                    <td class="searchState" align="right">구분2</td>
                    <td class="padding2423" align="left">
                        <select id="cmbSORT_GBN_SHR">
                            <option value="10">부서별</option>
                            <option value="20">직위별</option>
                            <option value="30">T직위별</option>
                        </select>
<!--                        <input type="radio" name="radSORT_GBN_SHR" id="radSORT_GBN_SHR" style="margin-bottom:-2px;border:0;" checked>부서별
                        <input type="radio" name="radSORT_GBN_SHR" id="radSORT_GBN_SHR" style="margin-bottom:-2px;border:0;">직위별
                        <input type="radio" name="radSORT_GBN_SHR" id="radSORT_GBN_SHR" style="margin-bottom:-2px;border:0;">T직위별 -->
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

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

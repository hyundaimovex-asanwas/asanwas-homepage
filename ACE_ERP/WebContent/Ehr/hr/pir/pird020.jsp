<!--
    ************************************************************************************
    * @Source         : pird020.jsp                                                    *
    * @Description    : 인사기록카드 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/05/16  |  이승욱   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>인사기록카드-파견사원(pird020)</title>
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

        var btnList = 'TFFTFTFT';

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

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

            // 개인별인경우
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                if (document.getElementById("txtNO_SHR").value == "") {
                    alert("사번은 필수입력항목입니다.");
                    document.getElementById("txtNO_SHR").focus();
                    return;
                }

            }

            var hnwParm = "[:OCC_CD]=[:PRT_SELT]=[:NO_SHR]="; // 변수값 초기화
            document.form1.rptObject.SetValues = hnwParm;

			hnwParm = "";
            hnwParm    += "[:OCC_CD]="   + document.getElementById("cmbOCC_CD_SHR").value;
            hnwParm    += "[:PRT_SELT]=" + document.getElementById("cmbPRT_SELT_SHR").value;
            hnwParm    += "[:NO_SHR]="   + document.getElementById("txtNO_SHR").value;

            document.form1.rptObject.SetValues = hnwParm;
            document.form1.rptObject.RunButton("CommandPrint");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            alert("개발중입니다.");

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

   			//팝업으로 호출시
            if (dsTemp != null) {

            }else{

	            document.getElementById("cmbOCC_CD_SHR").value    = 'AM';
	            document.getElementById("cmbPRT_SELT_SHR").value  = '1';
	            document.getElementById("txtNO_SHR").value        = '';
	            document.getElementById("txtNM_SHR").value        = '';

	            document.getElementById("cmbOCC_CD_SHR").focus();

            }

            document.getElementById("resultMessage").innerText = ' ';

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

   			//팝업으로 호출시
            if (dsTemp != null) {

            	//근로구분
				document.getElementById("cmbOCC_CD_SHR").value = dsTemp.NameValue(1,"OCC_CD");
            	document.getElementById("cmbOCC_CD_SHR").disabled = true;

            	//출력선택
				document.getElementById("cmbPRT_SELT_SHR").value = "1";
            	document.getElementById("cmbPRT_SELT_SHR").disabled = true;

            	//사번
            	document.getElementById("txtNO_SHR").value = dsTemp.NameValue(1,"ENO_NO");
            	document.getElementById("txtNM_SHR").value = dsTemp.NameValue(1,"ENO_NM");
                document.getElementById("txtNO_SHR").className = "input_ReadOnly";
                document.getElementById("txtNO_SHR").readOnly     = true;
                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly     = true;
                document.getElementById("ImgNo").style.display = "none";


            }else{

	            document.getElementById("cmbOCC_CD_SHR").focus();

            }



        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsTemp != null) {
                window.close();

            } else {
                frame = window.external.GetFrame(window);

                frame.CloseFrame();
            }

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

        function fnc_Popup(cd, nm){

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
               // fnc_emplPopup(cd, nm);
               fnc_empl3Popup(cd, nm,'','','','','2');
            }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
               fnc_commonCodePopup(cd, nm,'소속','A4');
            }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
               fnc_commonCodePopup(cd, nm,'직위','A2');
            }

        }

        function fnc_FldChange() {

            document.getElementById("txtNO_SHR").value = "";
            document.getElementById("txtNM_SHR").value = "";

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                document.getElementById("txtNM_SHR").className = "";
                document.getElementById("txtNM_SHR").readOnly  = false;
            } else{
                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly  = true;
            }

        }

        function fnc_GetNm() {

            // 개인별
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                fnc_GetEnoNm('txtNO_SHR', 'txtNM_SHR','2','0');
            }
            // 소속별
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
                fnc_GetCommNm('A4', 'txtNO_SHR','txtNM_SHR');
            }
            // 직위별
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
                fnc_GetCommNm('A2', 'txtNO_SHR','txtNM_SHR');
            }
        }

        function fnc_Getcd() {

            // 개인별
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
	            fnc_GetEnoNo('txtNM_SHR','txtNO_SHR','2','0');
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)    |
    | 3. 사용되는 Table List(T_CM_PERSON)           |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">인사기록카드-파견사원</td>
                    <td align="right" class="navigator">HOME/인사관리/인사정보출력/<font color="#000000">인사기록카드-파견사원</font></td>
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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right" >(소속/직위별인 경우 BLANK: ALL)</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="90"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;종</td>
                    <td align="left" class="padding2423">
                        <select id="cmbOCC_CD_SHR" style="width:76"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                            <option value="AM">전  체</option>
                            <option value="A">사무직</option>
                            <option value="M">택배직</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">출력선택</td>
                    <td class="padding2423">
                        <select id=cmbPRT_SELT_SHR onchange="fnc_FldChange()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" style="width:72">
                            <option value="1">개인별</option>
                            <option value="2">소속별</option>
                            <option value="3">직위별</option>
                        </select>
                        <input id=txtNO_SHR  name=txtNO_SHR size="8"  maxlength="8" onKeyPress="JavaScript: if(document.getElementById('cmbPRT_SELT_SHR').value == '1') cfNumberCheck();" onChange="fnc_GetNm();"> <input id=txtNM_SHR name=txtNM_SHR size="12" onchange="fnc_Getcd();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('txtNO_SHR','txtNM_SHR')"></a>
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
                    <td valign="top" class="searchState">
                    <!--여기서부터 코딩입니다//-->
                    <comment id="__NSID__">
                      <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
                      <param name="hnwsrc"    VALUE="pird020.hnw">
                      <param name="initvalue" VALUE="">
                      <param name="hidewnd"   VALUE="N">
                      <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                      </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    <!--여기까지 코딩입니다//-->
                        <span id="resultMessage">&nbsp;</span>
                    </td>
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

<!--
*****************************************************
* @source       : vlul040.jsp
* @description  : 업적평가피평가자선정 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/11/11    정하나        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>피평가자선정(vlul040)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;

        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도

            if (document.form1.rdoGBN_SHR[0].checked) {
	            //정보 조회
	            dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul040.cmd.VLUL040CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR; //+"&GUBUN="+GUBUN;
	            dsT_EV_ABLRST.reset();
            }else{
	            //정보 조회
	            dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul040.cmd.VLUL040CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR; //+"&GUBUN="+GUBUN;
	            dsT_EV_ABLRST.reset();
			}

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

            //이곳에 해당 코딩을 입력 하세요
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도

			if(document.form1.rdoGBN_SHR[0].checked){ //일반

				if (dsT_EV_ABLRST.countrow<1){
					alert ("삭제할 정보가 없습니다.");
				}else {
					if (confirm("선택한 피평가자 정보를 삭제하시겠습니까?")){
						dsT_EV_ABLRST.deleterow(dsT_EV_ABLRST.rowposition);

			            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul040.cmd.VLUL040CMD&S_MODE=DEL&REG_YM_SHR="+REG_YM_SHR;
			            trT_EV_ABLRST.post();

						fnc_SearchList();
					}
				}

			}else{ //부서장

				if (dsT_EV_ABLRST.countrow<1){
					alert ("삭제할 정보가 없습니다.");
				}else {
					if (confirm("선택한 부서장 피평가자 정보를 삭제하시겠습니까?")){
						dsT_EV_ABLRST.deleterow(dsT_EV_ABLRST.rowposition);

			            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul040.cmd.VLUL040CMD&S_MODE=DEL_DPT&REG_YM_SHR="+REG_YM_SHR;
			            trT_EV_ABLRST.post();

						fnc_SearchList();

					}
				}
			}
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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("피평가자선정", '', 225);

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
			var url = "/hr/vlu/vlul041.jsp";

			window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:450px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

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



        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //이곳에 해당 코딩을 입력 하세요

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

		document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

		document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

        cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","true");      // Grid Style 적용

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

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">피평가자선정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">피평가자선정</font></td>
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

            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','/images/button/btn_CreateOver.gif',1)"><img src="/images/button/btn_CreateOn.gif"   name="imgCreate"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
			&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="60"></col>
                                <col width="60"></col>
                                <col width="60"></col>
                                <col width=""></col>
                                </colgroup>
                             <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                                </td>
                                <td align="right" class="searchState">구분</td>
                                <td class="padding2423" >
                                    <fieldset style="width:180px">
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;">일반
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;">부서장
                                    </fieldset>
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
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <C> id='ENO_NO'     	width=55   	name='사번'    		align=center    edit=none </C>
                                    <C> id='DEPTNM'    	width=120   name='소속'   		align=left    	edit=none </C>
                                    <C> id='GRDNM'    	width=70   	name='직위'   		align=left    	edit=none </C>
                                    <C> id='ENO_NM'   	width=70  	name='성명'  		align=left      edit=none </C>
                                    <C> id='RECNM'    	width=90  	name='입사구분'     align=left      edit=none </C>
                                    <C> id='GRSTRTDT'   width=90  	name='그룹입사일'   align=center    edit=none mask='XXXX-XX-XX'</C>
                                    <C> id='STRTDT'     width=90   	name='입사일'      	align=center    edit=none mask='XXXX-XX-XX'</C>
                                    <C> id='LAMDT'     	width=90   	name='최종승진일'   align=center    edit=none mask='XXXX-XX-XX'</C>
                                    <C> id='WRDT'       width=90   	name='생성고과년월' align=center    edit=none mask='XXXX-XX'</C>
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



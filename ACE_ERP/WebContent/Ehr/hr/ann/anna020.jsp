<!--
*****************************************************
* @source      : anna020.jsp
* @description : 복리후생/개인연금/개인연금공제내역
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      조정호                   최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인연금공제내역</title>
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
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ann.a.anna020.cmd.ANNA020CMD";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            //검색조건
            var oCON_YMD_SHR    = document.getElementById("txtCON_YMD_SHR").value;
            var oOCC_CD_SHR     = document.getElementById("cmbOCC_CD_SHR").value;
            var oSAV_CD2_SHR    = document.getElementById("cmbSAV_CD2_SHR").value;
            var oTYPE_SHR       = document.getElementById("cmbTYPE_SHR").value;

            /*
            if(oCON_YMD_SHR=="" ){
                alert("대상년월을 입력하십시오. 예)"+today.substr(0,7));
                return;
            } */

            var params = "&S_MODE=SHR"
                       + "&CON_YMD="+oCON_YMD_SHR
                       + "&OCC_CD="+oOCC_CD_SHR
                       + "&SAV_CD2="+oSAV_CD2_SHR
                       + "&TYPE="+oTYPE_SHR;

            dsT_SV_SAVELIST.dataid = dataClassName+params;
            dsT_SV_SAVELIST.reset();
        }


        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_SV_SAVELIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SV_SAVELIST.GridToExcel("개인연금공제내역", '', 225);
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
			dsT_SV_SAVELIST.ClearData();
	        fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
            fncClearSearch();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_SV_SAVELIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

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
            var oSelect = null;
            var oOption = null;

            // 근로구분 구분 검색 콤보박스 생성
            oSelect = document.getElementById("cmbSAV_CD2_SHR");
            //첫번째 라인을 제외한 모든 option 삭제
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }
            for(i = 1; i <= dsT_CM_COMMON_V2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_V2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_V2.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

            // 근로구분 구분 검색 콤보박스 생성
            oSelect = document.getElementById("cmbOCC_CD_SHR");
            //첫번째 라인을 제외한 모든 option 삭제
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }
            for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

			cfStyleGrid(form1.grdT_SV_SAVELIST,15,"true","true")      // Grid Style 적용
            document.getElementById("txtCON_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * 날짜 형식 유효성 체크
         */
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

        /**
         * 입력창의 값들을 비운다.
         */
        function fncClearSearch() {
            //초기화 시킬 입력창
            var inputFields = new Array( "cmbOCC_CD_SHR"
                                        ,"cmbSAV_CD2_SHR"
                                        ,"cmbTYPE_SHR");
            for(i=0; i<inputFields.length; i++) {
                document.getElementById(inputFields[i]).value = "";
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
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_SV_SAVELIST                       |
    | 3. Table List : T_SV_SAVELIST                 |
    +----------------------------------------------->
    <Object ID="dsT_SV_SAVELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet - 예금종류                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V2"/>
       <jsp:param name="CODE_GUBUN"    value="V2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet - 근로구분구분                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
    <Script For=dsT_SV_SAVELIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_SV_SAVELIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_SV_SAVELIST event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인연금공제내역</td>
					<td align="right" class="navigator">HOME/복리후생/개인연금/<font color="#000000">개인연금공제내역</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="70"></col>
                                <col width="90"></col>
                                <col width="70"></col>
                                <col width="90"></col>
                                <col width="70"></col>
                                <col width="150"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">대상년월</td>
                                <td class="padding2423">
                                    <input type="text" id="txtCON_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtCON_YMD_SHR','','80','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
                                <td class="padding2423">
                                    <select id="cmbOCC_CD_SHR" name="cmbOCC_CD_SHR" style="width:80;">
                                        <option value="">모두</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">예금종류</td>
                                <td class="padding2423">
                                    <select id="cmbSAV_CD2_SHR" name="cmbSAV_CD2_SHR" style="width:140;">
                                        <option value="">모두</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">조회구분</td>
                                <td class="padding2423">
                                    <select id="cmbTYPE_SHR" name="cmbTYPE_SHR" style="width:100;">
                                        <option value="">모두</option>
                                        <option value="1">신규입사자</option>
                                        <option value="2">퇴사자</option>
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
							<param name="DataID"				value="dsT_SV_SAVELIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</C>
                                <C> id=SAV_NM2      width=130       align=center        name=예금종류         </C>
                                <C> id=ENO_NM       width=80        align=center        name=성명             </C>
                                <C> id=OCC_NM       width=80        align=center        name=근로구분             </C>
                                <C> id=DPT_NM       width=80        align=center        name=소속             </C>
                                <C> id=JOB_NM       width=80        align=center        name=직위             </C>
                                <C> id=CONM_AMT     width=80        align=right         name=불입액           </C>
                                <C> id=SUM_SAV      width=80        align=right         name=누적액           </C>
                                <C> id=OTHP_AMT     width=80        align=right         name=기타지불액       </C>
                                <C> id=CON_CNT      width=39        align=center        name=횟수             </C>
                                <C> id=CON_YMD      width=80        align=center        name=계약일           </C>
                                <C> id=DUE_YMD      width=80        align=center        name=만기일           </C>
                                <C> id=CAN_YMD      width=80        align=center        name=해약일           </C>
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


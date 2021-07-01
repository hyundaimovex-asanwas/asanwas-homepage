<!--
*****************************************************
* @source      : buta100.jsp
* @description : 해외출장신청현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/16      오대성        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>해외출장신청현황(buta100)</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTTTFT';

        var today = getToday();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			//검색조건
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var but_city_cd = document.getElementById("cmbBUT_CITY_CD_SHR").value;

			dsT_DI_OVERSEASBT.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta100.cmd.BUTA100CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&DPT_CD="+dpt_cd+"&BUT_CITY_CD="+but_city_cd;
			dsT_DI_OVERSEASBT.reset();

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
            if(!fnc_SearchItemCheck()) return;

			//검색조건
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var but_city_cd = document.getElementById("cmbBUT_CITY_CD_SHR").value;

	        var url = "buta100_PV.jsp?STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&DPT_CD="+dpt_cd+"&BUT_CITY_CD="+but_city_cd;
   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
         }


        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			if (dsT_DI_OVERSEASBT.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_OVERSEASBT.GridToExcel("해외출장신청현황", '', 225);

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

            //document.getElementById("txtSTR_YMD_SHR").value = "";
            //document.getElementById("txtEND_YMD_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
            document.getElementById("cmbBUT_CITY_CD_SHR").value = "";

			dsT_DI_OVERSEASBT.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

			document.getElementById("txtSTR_YMD_SHR").focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_OVERSEASBT.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var str_ymd = document.getElementById("txtSTR_YMD_SHR");
			var end_ymd = document.getElementById("txtEND_YMD_SHR");

            if(str_ymd.value == ""){
                alert("조회 시작일을 입력하세요!");
                str_ymd.focus();
                return false;
            }
            if(end_ymd.value == ""){
                alert("조회 종료일을 입력하세요!");
                end_ymd.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //출장지
            for( var i = 1; i <= dsT_CM_COMMON_L2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_L2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_L2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbBUT_CITY_CD_SHR").add(oOption);
			}

            document.getElementById("txtSTR_YMD_SHR").value = today.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = today;

			cfStyleGrid(form1.grdT_DI_OVERSEASBT,0,"false","false")      // Grid Style 적용
			form1.grdT_DI_OVERSEASBT.IgnoreSelectionColor = "true";
			

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

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT                   |
    | 3. Table List : T_DI_OVERSEASBT               |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 출장지 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_L2"/>
       <jsp:param name="CODE_GUBUN"    value="L2"/>
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
    <Script For=dsT_DI_OVERSEASBT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.getElementById("txtSTR_YMD_SHR").focus();
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준일/출장지/직위] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("기준일/출장지/직위에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">해외출장신청현황</td>
					<td align="right" class="navigator">HOME/근태관리/해외출장/<font color="#000000">해외출장신청현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center" class="greenTable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="60"></col>
						<col width="220"></col>
                        <col width="60"></col>
                        <col width="160"></col>
                        <col width="60"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="searchState" align="right">출장기간&nbsp;</td>
						<td class="padding2423" align="left">
							<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','113');"></a> ~
						    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','113');"></a>
						</td>
                        <td class="searchState" align="right">소속&nbsp;</td>
                        <td class="padding2423" align="left">
                            <input id="txtDPT_CD_SHR" size="3" maxlength="2"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                        </td>
						<td class="searchState" align="right">출장지&nbsp;</td>
						<td class="padding2423" align="left">
							<select id="cmbBUT_CITY_CD_SHR"  style="width='70%';" onChange="fnc_SearchList()">
								<option value="">전 체</option>
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERSEASBT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"				value="dsT_DI_OVERSEASBT">
							<param name="Format"				value="
								<C> id='ORD_NO'		    width=80    name='품의번호'	align=center    </C>
                                <C> id='DPT_NM'		    width=80	name='소속'	    align=left      </C>
                                <C> id='JOB_NM'		    width=60	name='직위'	    align=center    </C>
                                <C> id='ENO_NO'	        width=65	name='사번'     align=center    </C>
                                <C> id='ENO_NM'	        width=65	name='성명'	    align=center    </C>
								<C> id='BUT_CITY_CD'	width=100	name='출장지'	align=left      EditStyle=Lookup  Data='dsT_CM_COMMON_L2:CODE:CODE_NAME'</C>
								<C> id='BUT_OBJ'		width=160	name='출장목적'	align=center	</C>
                                <G> name='출장기간' HeadBgColor='#F7DCBB'
                                    <C> id='BUT_FR_YMD'	width=80	name='출발일'	align=center  Mask='XXXX-XX-XX'</C>
								    <C> id='BUT_TO_YMD'	width=80	name='도착일'	align=center  Mask='XXXX-XX-XX'</C>
                                    <C> id='BUT_NIGHT'	width=40	name='박' 	    align=center	</C>
                                    <C> id='BUT_DAY'	width=40	name='일'	    align=center	</C>
                                </G>
                                <C> id='BUT_CNT'	    width=100	name='합계'	    align=right	    </C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

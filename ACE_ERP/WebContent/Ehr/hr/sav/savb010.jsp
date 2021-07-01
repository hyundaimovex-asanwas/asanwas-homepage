<!--
*****************************************************
* @source       : savb010.jsp
* @description  : 분기보고서_직원현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2008/12/02      김경주        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>분기보고서_직원현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var today_ym = getToday().substring(0,7);
		var btnList = 'TFTTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
			var PIS_YM_SHR = document.form1.txtPIS_YM_SHR.value;
			var OCC_CD_SHR = document.form1.cmbOCC_CD_SHR.value;

			trT_CP_PAYMASTER.action = "/servlet/GauceChannelSVL?cmd=hr.sav.b.savb010.cmd.SAVB010CMD&S_MODE=SHR&PIS_YM_SHR="+PIS_YM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR;
			trT_CP_PAYMASTER.KeyValue = "SHR"
                                      + "(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"
                                      + ",O:dsT_CM_PERSON=dsT_CM_PERSON)";
			trT_CP_PAYMASTER.post();

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

            if(dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("분기보고서",'',225);

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

            document.form1.cmbOCC_CD_SHR.selectedIndex = 0;
			document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
			document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("txtTOT_INFO").innerText = ''

			dsT_CP_PAYMASTER.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_PAYMASTER.IsUpdated)  {

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


			// 근로구분구분검색 콤보박스 생성
			for (var i=1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
			    oOption       = document.createElement("OPTION");
			    oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
			    oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
			    document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

			cfStyleGrid(form1.grdT_CP_PAYMASTER,15,"false","false")      // Grid Style 적용

			//해당일자을 가져온다.
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];

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
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CP_PAYMASTER                    |
    | 3. Table List : T_CP_PAYMASTER                |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>



	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_PAYMASTER)			|
    | 3. 사용되는 Table List(T_CP_PAYMASTER)				|
    +------------------------------------------------------>
	<Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsT_CP_PAYMASTER)">
	</Object>



    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.CountRow);

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnSuccess()">
	//	fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
          if(dsT_CP_PAYMASTER.CountRow >= 1){

            document.getElementById("txtTOT_INFO").innerText = dsT_CM_PERSON.NameString(1,'INFO') +"\n"+  dsT_CM_PERSON.NameString(2,'INFO')
            document.getElementById("txtTOT_INFO").style.display = "";
            document.getElementById("txtTOT_INFO").rows = Math.ceil(2);

        }
        fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.CountRow);
    </script>


	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnFail()">
        alert(dsT_CP_PAYMASTER.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">분기보고서_직원현황</td>
					<td align="right" class="navigator">HOME/정산세무/분기보고서/<font color="#000000">분기보고서_직원현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width='70'></col>
                            </colgroup>
                            <tr>
								<td class="searchState" align="right">기준년월</td>
						     	<td class="padding2423" align="left">
								 <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
								 <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','50','107');">
								 <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right" rowspan="3">근로구분별</td>
							<td class="padding2423" align="left" rowspan="3">
								<select id="cmbOCC_CD_SHR" style="WIDTH: 29%" onChange="fnc_SearchList()">
									<option value="0">모두</option>
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
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'	    width=25 		    name= NO  			   align= center 	    value={String(Currow)}  </C>
								<C> id='OCC_NM'			width=50			name='근로구분'			   align=center									</C>
								<C> id='DPT_NM'		    width=90			name='부서'			   align=center									</C>
								<C> id='JOB_NM'			width=50			name='직위'			   align=center									</C>
								<C> id='ENO_NO'		    width=70			name='사번'			   align=center									</C>
								<C> id='ENO_NM'		    width=70			name='성명'			   align=center									</C>
								<C> id='MF_TAG'			width=50			name='성별'			   align=center			Value={Decode(MF_TAG,'M','남','W','여')} </C>
								<C> id='CET_NO'			width=100			name='주민번호'		   align=center									</C>
								<C> id='LSE_YM'		    width=60			name='근속년수'		   align=center		   							</C>
								<C> id='HIR_YMD'		width=75			name='입사일'		   align=center									</C>
								<C> id='RET_YMD'		width=75			name='퇴사일'		   align=center									</C>
								<C> id='SALT_AMT_0'		width=90			name='급여'			   align=right		    RightMargin= 10 		</C>
								<C> id='SALT_AMT_1'		width=90			name='상여'			   align=right		    RightMargin= 10 		</C>
								<C> id='SCH_AMT'		width=90			name='학자금'		   align=right		    RightMargin= 10 		</C>
								<C> id='WEL_POINT'		width=90			name='복지카드'		   align=right		    RightMargin= 10 		</C>
								<C> id='LUN_AMT'		width=90			name='중식대'		   align=right			RightMargin= 10 		</C>
								<C> id='SALT_AMT_4'		width=90			name='연월차'		   align=right			RightMargin= 10 		</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		  <td class="paddingTop8">
    			<table border="0" cellspacing="0" cellpadding="0" width="100%">
        			<tr>
        				<td align="left" width="80"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">&nbsp;직&nbsp;원&nbsp;현&nbsp;황&nbsp;&nbsp;&nbsp;</td>
           			</tr>
                    <tr>
                        <td colspan="2"><textarea rows="1" id="txtTOT_INFO" class="input_ReadOnly" readonly style="width:100%;"></textarea></td>
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
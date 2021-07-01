<!--
    **************************************************
    * @source        : yaca080_14.jsp 				                             *
    * @description   : 개인별결과조회 PAGE.                                     *
****************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*-----------------------------------------------------------------
* 2015/01/27            이동훈             최초작성                                         *
****************************************************-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

<title>개인별결과조회(yaca080_14)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 정산년도
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // 소속
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번

            //데이터셋 전송
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca080.cmd.YACA080CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CM_PERSON.Reset();


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

            if (dsT_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("개인별결과조회", '', 225);

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

			fnc_OnLoadProcess();
			dsT_CM_PERSON.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = ""; // 근로구분구분
			document.getElementById("txtDPT_CD_SHR").value = ""; // 소속코드
			document.getElementById("txtDPT_NM_SHR").value = ""; // 소속명
			document.form1.txtPIS_YY_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			window.close();
			
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_CM_PERSON.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                                        
			//두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    
			//네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			
			cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","true");
			
            document.getElementById("txtPIS_YY_SHR").value =  '2014';
            
			//값이 없어서 하이픈만 나오는거 방지
			var PIS_YY_SHR = (document.getElementById("txtPIS_YY_SHR").value).replace("-", "").replace("-", "");
			
			if(PIS_YY_SHR.trim() == ""){
				document.getElementById("txtPIS_YY_SHR").value = "";
			}
			
			fnc_SearchList();

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CM_PERSON                             |
    | 3. Table List : T_CM_PERSON                         |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubsumExpr"          value="total">        
    </Object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CM_PERSON                                    |
    | 3. Table List : T_CM_PERSON                             |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">
   		var iCount = dsT_CM_PERSON.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			//alert(dsT_CM_PERSON.ExportData(1, dsT_CM_PERSON.CountRow, true));
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">개인별결과조회</td>
					<td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">개인별결과조회</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10"></col>
								<col width="80"></col>
								<col width="140"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">정산년도</td>
								<td>
									<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">소&nbsp;&nbsp;&nbsp;속</td>
								<td>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','../../images/button/btn_HelpOver.gif',1)">
										<img src="../../images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
									</a>
								</td>
								<td align="center" class="searchState">사원번호</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
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
<table width="1050" border="0" cellspacing="0" cellpadding="0">
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
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
							<param name="DataID"					value="dsT_CM_PERSON">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'		width=39			name='NO'								align=center		value={String(Currow)}		</FC>
								<FC> id='JOB_NM'			width=80			name='직위'								align=center		</FC>
								<FC> id='ENO_NO'		width=80			name='사번'								align=center		</FC>
								<FC> id='ENO_NM'		width=80			name='성명'								align=center		SubSumText='합 계' </FC>
								<C> id='CET_NO'			width=100			name='주민번호'						align=center		</C>						
								<C> id='DPT_NM'			width=100			name='소속'								align=left		    </C>						
								<C> id='TEAM_NM'		width=150			name='팀'								align=left		    </C>	
								<C> id='SALT_AMTT'		width=100			name='총근로소득'						align=right		</C>
								<C> id='FREE_INCOME'	width=100			name='비과세'							align=right		SumText=@sum</C>								
								<C> id='TAX_INCOME'	width=100			name='과세대상급여'					align=right		</C>									
								<C> id='MGR_AMT'		width=100			name='근로소득공제'					align=right		SumText=@sum</C>
								<C> id='MNI_AMT'		width=100			name='과세근로소득'					align=right		BgColor='#99FF99' </C>								
								<C> id='MNI_TOT'			width=100			name='차감소득금액'					align=right		</C>										
								
								<C> id='TAX_AMT'		width=100			name='산출세액'						align=right		</C>									
								<C> id='TDED_TOT'		width=100			name='세액공제계'						align=right		</C>
							<G> name='결정세액' 		BgColor='#dae0ee'
								<C> id='DGG_TAX'		width=100			name='결정소득세'						align=right		</C>								
								<C> id='DJM_TAX'			width=100			name='결정주민세'						align=right		</C>	
								<C> id='DGG_DJM'			width=100			name='소계'								align=right		</C>
							</G>
							<G> name='기납부세액' 		BgColor='#dae0ee'							
								<C> id='AGG_TAX'		width=100			name='기납부소득세'					align=right		</C>								
								<C> id='AJM_TAX'			width=100			name='기납부주민세'					align=right		</C>	
								<C> id='AGG_AJM'			width=100			name='소계'								align=right		</C>
							</G>
							<G> name='환급세액' 		BgColor='#dae0ee'		
								<C> id='DRE_INTX'		width=100			name='환급소득세'						align=right		</C>								
								<C> id='DRE_CTTX'		width=100			name='환급주민세'						align=right		</C>	
							</G>							
								<C> id='RET_SUM'		width=100			name='환급액'							align=right		BgColor='#FFFF99'</C>																	

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
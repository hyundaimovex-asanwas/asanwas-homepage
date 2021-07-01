<!--
***********************************************************************
* @source      : graa080.jsp
* @description : 보직변경자/무급휴직자/징계자리스트 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      오대성        최초작성.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>보직변경자/무급휴직자/징계자리스트(graa080)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
			
			var pis_yymm = document.getElementById('txtPIS_YYMM_SHR').value;
			var ret_yymm = document.getElementById('txtRET_YYMM_SHR').value;
			var apy_ymd = document.getElementById('txtAPY_YMD').value;
            var remark = "";
            if(document.form1.rdoREMARK[0].checked){
                remark = "보직변경";
            }else if(document.form1.rdoREMARK[1].checked){
                remark = "휴직";
            }else {
                remark = "징계";
            }

            if(!fnc_SearchItemCheck()) return;

            dsT_PM_GRADE.ClearData();

            trT_PM_GRADE.KeyValue = "tr01(O:dsT_PM_GRADE=dsT_PM_GRADE)";
			trT_PM_GRADE.action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa080.cmd.GRAA080CMD&S_MODE=SHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7)+"&RET_YY="+ret_yymm.substring(0,4)+"&RET_MM="+ret_yymm.substring(5,7)+"&APY_YMD="+apy_ymd+"&REMARK="+remark;
			trT_PM_GRADE.post();

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

			//이곳에 해당 코딩을 입력 하세요

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
			
            document.getElementById('txtPIS_YYMM_SHR').value = '';
			document.getElementById('txtRET_YYMM_SHR').value = '';
			document.getElementById('txtAPY_YMD').value = '';
			document.form1.rdoREMARK[0].checked = true;
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_GRADE.ClearData();

            document.getElementById('txtPIS_YYMM_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {
			
			var pis_yymm = document.getElementById('txtPIS_YYMM_SHR');
			var ret_yymm = document.getElementById('txtRET_YYMM_SHR');
			var apy_ymd = document.getElementById('txtAPY_YMD');

            if(pis_yymm.value == ""){
                alert("투입년월은 반드시 입력하셔야 합니다!");
                pis_yymm.focus();
                return false;
            }
            if(ret_yymm.value == ""){
                alert("소급년월은 반드시 입력하셔야 합니다!");
                ret_yymm.focus();
                return false;
            }
            if(apy_ymd.value == ""){
                alert("호봉표일자는 반드시 입력하셔야 합니다!");
                apy_ymd.focus();
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

			cfStyleGrid(form1.grdT_PM_GRADE,0,"false","false");      // Grid Style 적용
			
            document.getElementById('txtPIS_YYMM_SHR').focus();

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

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_PM_GRADE)    |
    | 3. 사용되는 Table List(T_PM_GRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_PM_GRADE)	    |
    | 3. 사용되는 Table List(T_PM_GRADE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_PM_GRADE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_J3"/>
       <jsp:param name="CODE_GUBUN"    value="J3"/>
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
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">
		
        

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_PM_GRADE event="OnSuccess()">
        if (dsT_PM_GRADE.CountRow < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
			document.getElementById("resultMessage").innerText = "* 자료가 조회되었습니다!";

        }
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_PM_GRADE event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">보직변경자/무급휴직자/징계자리스트</td>
					<td align="right" class="navigator">HOME/인사관리/승급/<font color="#000000">보직변경자/무급휴직자/징계자리스트</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="90"></col>
                                    <col width="80"></col>
                                    <col width="90"></col>
                                    <col width="90"></col>
                                    <col width="120"></col>
                                    <col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">투입년월&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','10','115');"></a>
                                </td>
                                <td align="right" class="searchState">소급년월&nbsp;</td>
								<td class="padding2423"><input id="txtRET_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtRET_YYMM_SHR','','160','115');"></a>
                                </td>
								<td align="right" class="searchState">호봉표일자&nbsp;</td>
								<td class="padding2423"><input id="txtAPY_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','350','115');"></a></td>
                                <td class="padding2423">
									<input type="radio" id="radio1" name="rdoREMARK" style="border:none" value="0" checked>보직변경 <input type="radio" id="radio2" name="rdoREMARK" style="border:none" value="1">휴직 <input type="radio" id="radio2" name="rdoREMARK" style="border:none" value="2">징계
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
						<object	id="grdT_PM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_PM_GRADE">
							<param name="Format"					value="
                                <C> id='NO'             width=29    name='NO'               align=center    </C>
                                <C> id='OCC_NM'         width=50    name='근로구분'             align=center    </C>
                                <C> id='DPT_NM'         width=100   name='소속'             align=center    </C>
                                <C> id='JOB_NM'         width=50    name='직위'             align=center    </C>
                                <C> id='ENO_NO'         width=70    name='사번'             align=center    </C>
                                <C> id='ENO_NM'         width=70    name='성명'             align=center    </C>
                                <C> id='SAL_GBN'        width=50    name='급상여'           align=center    </C>
                                <C> id='JCD_CD'         width=100   name='내역'             align=left EditStyle=Lookup  Data='dsCOMMON_J3:CODE:CODE_NAME'</C>
                                <C> id='STR_YMD'        width=70    name='발생시작'         align=center Mask='XXXX-XX-XX'</C>
                                <C> id='END_YMD'        width=70    name='발생종료'         align=center Mask='XXXX-XX-XX'</C>
                                <C> id='FROM_YMD'       width=70    name='시작일'           align=center Mask='XXXX-XX-XX'</C>
                                <C> id='TO_YMD'         width=70    name='종료일'           align=center Mask='XXXX-XX-XX'</C>
                                <C> id='HOB'            width=50    name='전호봉'           align=center    </C>
                                <C> id='BAS_AMT'        width=70    name='기본급'           align=right     </C>
                                <C> id='DUTY_AMT'       width=70    name='직책/복지'        align=right     </C>
                                <C> id='OT_AMT'         width=70    name='시간외'           align=right     </C>
                                <C> id='WEL_AMT'        width=70    name='복지/기술'        align=right     </C>
                                <C> id='OSE_AMT'        width=85    name='자기개발/택배'    align=right     </C>
                                <C> id='RUN_AMT'        width=70    name='운행'             align=right     </C>
                                <C> id='MH_AMT'         width=85    name='월차/자기개발'    align=right     </C>
                                <C> id='OLD_SALT_AMT'   width=80    name='총계'             align=right     </C>
                                <C> id='FIN_HOB'        width=50    name='후호봉'           align=center    </C>
                                <C> id='BAS_AMT1'       width=70    name='기본급'           align=right     </C>
                                <C> id='DUTY_AMT1'      width=70    name='직책/복지'        align=right     </C>
                                <C> id='OT_AMT1'        width=70    name='시간외'           align=right     </C>
                                <C> id='WEL_AMT1'       width=70    name='복지/기술'        align=right     </C>
                                <C> id='OSE_AMT1'       width=85    name='자기개발/택배'    align=right     </C>
                                <C> id='RUN_AMT1'       width=70    name='운행'             align=right     </C>
                                <C> id='MH_AMT1'        width=85    name='월차/자기개발'    align=right     </C>
                                <C> id='NEW_SALT_AMT'   width=80    name='총계'             align=right     </C>
                                <C> id='SALT_AMT'       width=80    name='소급금액'         align=right     </C>
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

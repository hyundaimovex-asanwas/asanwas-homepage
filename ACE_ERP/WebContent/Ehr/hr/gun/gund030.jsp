<!--
*****************************************************
* @source       : gund030.jsp
* @description : 연차발생관리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>연차생성</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
			var pis_yy = document.form1.txtPIS_YY_SHR.value;	//기준년도

			if(pis_yy.trim().length == 0){
				alert("기준년도를 입력하세요.");
				document.getElementById("txtPIS_YY_SHR").focus();
				return false;
			}else if(pis_yy.trim().length != 4){
				alert("기준년년도가 올바르지 않습니다.");
				document.getElementById("txtPIS_YY_SHR").focus();
				return false;
			}

			dsT_DI_YEARLY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.d.gund030.cmd.GUND030CMD&S_MODE=SHR&PIS_YY="+pis_yy;
			dsT_DI_YEARLY.reset();

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

			if(!fnc_SaveItemCheck()) return;

			trT_DI_YEARLY.KeyValue = "tr01(I:dsT_DI_YEARLY=dsT_DI_YEARLY)";
			trT_DI_YEARLY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.d.gund030.cmd.GUND030CMD&S_MODE=SAV";
			trT_DI_YEARLY.post();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
            if (dsT_DI_YEARLY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_YEARLY.GridToExcel("연차발생", '', 225);

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



        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_YEARLY.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

        	window.close();

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

			if (!dsT_DI_YEARLY.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_DI_YEARLY,15,"true","true");      // Grid Style 적용

   	        var oYear;

   	        oYear = gcurdate.substring(0,4)
   	        
   	        document.getElementById("txtPIS_YY_SHR").value = oYear;
   	        
			document.form1.txtPIS_YY_SHR.focus();

            //2008년도 미만 연차는 생성 못한다.(이전년도 데이터(선연차)가 있어야 연차생성가능)
            if( parseInt(oYear) > 2007 ) {
                document.getElementById("divCreateBatch1").style.display = "";
                document.getElementById("divCreateBatch2").style.display = "";

                document.getElementById("txtPIS_YY").value = oYear;
            }

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /***************************************
         * 일괄생성버튼 클릭시 작업 처리 부분  *
         **************************************/
        function fnc_CreateBatch() {

			if (!confirm("연차 일괄생성을 하시겠습니까?")) return false;

			//생성조건
			var pis_yy = document.form1.txtPIS_YY.value;//일괄처리년도

			if(pis_yy.trim().length == 0){
				alert("일괄처리년도를 입력하세요.");
				document.getElementById("txtPIS_YY").focus();
				return false;
			}else if(pis_yy.trim().length != 4){
				alert("일괄처리년도가 올바르지 않습니다.");
				document.getElementById("txtPIS_YY").focus();
				return false;
			}

            var oYear;

            oYear = getToday().substring(0,4)

            dsT_DI_YEARLY_01.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.d.gund030.cmd.GUND030CMD&S_MODE=SHR&PIS_YY="+pis_yy;
            dsT_DI_YEARLY_01.Reset();

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
    | 2. 이름 : dsT_DI_YEARLY                      |
    | 3. Table List : T_DI_YEARLY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut           value=2000000>
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_YEARLY_01                      |
    | 3. Table List : T_DI_YEARLY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_YEARLY_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_YEARLY)		|
    | 3. 사용되는 Table List(T_DI_YEARLY)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_YEARLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_YEARLY Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_YEARLY.focus();
        }

    </Script>

    <Script For=dsT_DI_YEARLY_01 Event="OnLoadCompleted(iCount)">
		var pis_yy = document.form1.txtPIS_YY.value;//일괄처리년도

        if (iCount < 1)    {
			//데이터가 없으면 신규생성
            dsT_DI_YEARLY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.d.gund030.cmd.GUND030CMD&S_MODE=INS&PIS_YY="+pis_yy;
            dsT_DI_YEARLY.Reset();

        } else {
			//데이터가 있으면 업데이트
			if(!confirm("발생한 연차를 재처리 하시겠습니까?")){
				return;
			}

            dsT_DI_YEARLY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.d.gund030.cmd.GUND030CMD&S_MODE=UPT&PIS_YY="+pis_yy;
            dsT_DI_YEARLY.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_YEARLY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_DI_YEARLY_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_YEARLY Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_YEARLY_01 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_YEARLY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_YEARLY event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">기준년도</td>
                                <td class="padding2423">
									<input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','60','115');"></a>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="66%" height="20"><span id="resultMessage">&nbsp;</span></td>
					<td align="right" class="searchState">
					   <div id="divCreateBatch1" style="display:none">
							일괄처리년도
							<input type="text" id="txtPIS_YY" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_CreateBatch(); cfNumberCheck()">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YY" name="imgPIS_YY" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY','','60','115');"></a>
						</div>
					</td>
					<td align="right">
                        <div id="divCreateBatch2" style="display:none">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnReflect','','../../images/button/BatchCreateOver.gif',1)"><img src="../../images/button/BatchCreateOn.gif" id="btnReflect" name="btnReflect" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()"></a>
                        </div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_YEARLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:540px;">
							<param name="DataID"				value="dsT_DI_YEARLY">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=50			name='NO'					align=center			value={String(Currow)}		</C>
								<C> id='DPT_NM'			width=120			name='소속'					align=center			Edit=None					</C>
								<C> id='JOB_NM'			width=100			name='직위'					align=center			Edit=None					</C>
								<C> id='ENO_NO'			width=90			name='사번'					align=center			Edit=None					</C>
								<C> id='ENO_NM'			width=90			name='성명'					align=center			Edit=None					</C>
								<C> id='HIRG_YMD'		width=120			name='그룹입사일'			align=center			Edit=None					</C>
								<C> id='YRP_CNT'			width=120			name='생성연차'			align=center			Edit=None					</C>
								<C> id='AYRP_CNT'		width=120			name='작년선연차'			align=center			Edit=None					</C>
								<C> id='TOT_YRP'			width=120			name='사용가능연차'		align=center			Edit=None	</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


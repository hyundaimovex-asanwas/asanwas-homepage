<!--
***********************************************************************
* @source      : duty.jsp
* @description : 직무선택 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
	<title>직무선택(duty)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="../../common/common.js"></script>
    <script language=javascript src="../../common/mdi_common.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>
	<base target="_self">

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		 var reObj = window.dialogArguments;

		reObj.duty_cd = "";
		reObj.duty_nm = "";
		reObj.sec_nm = "";
		reObj.thr_nm = "";
		

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

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

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)

            // 삭제 후 해당 그리드로 Focus 이동

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

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


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//트리 조회를 위해 VLUF010CMD를 사용
			dsT_CM_DUTYMST.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.cod.f.codf010.cmd.CODF010CMD&S_MODE=SHR";
			dsT_CM_DUTYMST.Reset();

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
    | 1. 트리구성용 DataSet                                               |
    | 2. 이름 : dsT_CM_DUTYMST                                            |
    | 3. Table List : T_CM_DUTYMST                                       |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


	<!-----------------------------------------+
    | TreeView에 있는 Item을 Double Click할때  |
    +------------------------------------------>
	<script language=JavaScript for=tvT_CM_DUTYMST event=OnDblClick()>

		var downduty_cd = dsT_CM_DUTYMST.NameValue(dsT_CM_DUTYMST.RowPosition,"DOWNDUTY_CD");
		if (downduty_cd != 1) return false;

		var row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",tvT_CM_DUTYMST.ItemText);
		var reObj = window.dialogArguments;

		reObj.duty_cd = dsT_CM_DUTYMST.NameValue(row,"DUTY_CD");
		reObj.duty_nm = dsT_CM_DUTYMST.NameValue(row,"DUTY_NM");
		reObj.sec_nm = dsT_CM_DUTYMST.NameValue(row,"UPDUTY_NM");
		reObj.thr_nm = dsT_CM_DUTYMST.NameValue(row,"HIGHDUTY_NM");
		window.close();

	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 켈린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
		<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="25" background="../../images/common/barBg.gif">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
	                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">직무 선택</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>&nbsp;&nbsp;&nbsp;&nbsp;
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<!-- power Search테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							<object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
								<param name=DataID		value="dsT_CM_DUTYMST">
								<param name=TextColumn	value="DUTY_NM">
								<param name=LevelColumn	value="DUTY_LBL">
								<param name=ExpandLevel	value="1">
								<param name=BorderStyle  value="4">
								<param name=UseImage      value="false">
								<param name=ExpandOneClick      value="true">

								<!-- <param name=UseImage		value="true">
								<param name=ImgDataID		value="idsT_CM_DUTYMST">
								<param name=ImgCColumn	value="ImgC">
								<param name=ImgDColumn	value="ImgD">
								<param name=ImgOColumn	value="ImgO"> -->
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
						</td>
					</tr>
				</table>
	        </td>
	    </tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->
	<!-- 조회 상태 테이블 시작 -->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState">* 해당 직무를 더블클릭 하시면 선택됩니다.</span></td>
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
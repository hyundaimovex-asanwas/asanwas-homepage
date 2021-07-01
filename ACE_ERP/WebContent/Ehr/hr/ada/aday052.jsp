<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ 시스템명 : 일용직 인사관리 - 결재 기안
+ 기능정의 : 결재 기안한다.
+ 프로그램ID : aday050.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2013.04.03
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>근태현황(aday052.jsp)</title>
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
		var btnList = 'TTTTTFTT';
        var param = window.dialogArguments;
		var chkValid  = 'T';
		var cet_no = param.cet_no;
		var wrk_ym = param.wrk_ym;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	dsT_CA_DILIGENCE.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_GUN"	
												+ "&cet_no=" + cet_no	
												+ "&wrk_ym=" + wrk_ym;					
        	dsT_CA_DILIGENCE.reset();


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
            //이곳에 해당 코딩을 입력 하세요
        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 유효성 검사 *
         ******************/
        function fnc_Valid() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
		function fnc_Append(){


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

            cfStyleGrid5(form1.grdT_CA_DILIGNECE,0,"false","true");      		// Grid Style 적용

	        fnc_SearchList();
  
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
    | 2. 이름 : dsREQ_NO                           |
    | 3. Table List :             					|
    +----------------------------------------------->

    <Object ID="dsT_CA_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CA_DILIGENCE Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CA_DILIGENCE Event="OnLoadError()">
        cfErrorMsg(this);
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
<table width="380" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근무현황</td>
					<td align="right" class="navigator">HOME/보상관리/일용직관리/<font color="#000000">근무현황</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="380" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CA_DILIGNECE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:380px;height:540px;">
							<param name="DataID"					value="dsT_CA_DILIGENCE">
							<PARAM NAME="TITLEHEIGHT"		VALUE=40>
							<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
							<PARAM NAME="BORDERSTYLE" 		VALUE="0">
							<PARAM NAME="INDWIDTH"			VALUE="0">
							<PARAM NAME="FILLAREA"				VALUE="true">
							<PARAM NAME="EDITABLE"				VALUE="true">
							<PARAM NAME="Colsizing"				VALUE="true">						
							<param name="Format"					value="
                				<FC>Name=NO				  	ID={CurRow} 		Width=30,  		align=center, 	sort = false,	editable=false</FC>
								<FC>Name=일자,       	   	ID=WRK_DT,		width=100,		align=center, 	sort = true, 	edit=none mask='XXXX-XX-XX' color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC>		
								<FC>Name=요일,       	   	ID=YOIL,				width=50,		align=center, 	sort = true, 	edit=none 	value={IF (YOIL='1','일',IF (YOIL='2','월', IF (YOIL='3','화', IF (YOIL='4','수', IF (YOIL='5','목', IF (YOIL='6','금', IF (YOIL='7','토', '' )))))))} color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC>		
								<FC>Name=성명,       	   	ID=ENO_NM,		width=80,		align=center, 	sort = true, 	edit=none</FC>		
                				<FC>Name=구분,    	 		ID=WRK_GB,  		width=80,		align=center, 	sort = true,  	EditStyle=Combo, dec=0, 	Data='X:X,1:근무' color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC						                            ">
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



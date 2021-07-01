<!--
    ************************************************************************************
    * @source        : code061.jsp 				                                                                                *
    * @description   : 기타내역 PAGE.                                                                    						*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                 *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/01/22      이동훈        최초작성.
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>기타내역</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

        var dsT_CP_PAYMASTER = window.dialogArguments;//opener에서 받아온다.

        /********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {
        	
			var kind = dsT_CP_PAYMASTER.NameValue(1,"KIND");
			
			var PIS_YY = dsT_CP_PAYMASTER.NameValue(1,"PIS_YY");
			
			var PIS_MM = dsT_CP_PAYMASTER.NameValue(1,"PIS_MM");
			
			var ENO_NO = dsT_CP_PAYMASTER.NameValue(1,"ENO_NO");
			
			var SAL_GBN = dsT_CP_PAYMASTER.NameValue(1,"SAL_GBN");
			
			var SEQ = dsT_CP_PAYMASTER.NameValue(1,"SEQ");

			if(kind == "1"){
				
				dsT_CP_CHANGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code061.cmd.CODE061CMD&S_MODE=SHR_01&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&ENO_NO="+ENO_NO+"&SAL_GBN="+SAL_GBN+"&SEQ="+SEQ;
    			dsT_CP_CHANGE.reset();

			}else{
				
				dsT_CP_CHANGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code061.cmd.CODE061CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&ENO_NO="+ENO_NO+"&SAL_GBN="+SAL_GBN+"&SEQ="+SEQ;
    			dsT_CP_CHANGE.reset();

			}

        }

   		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
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

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_CHANGE.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

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

            fnc_ChangeGrid();

            fnc_ChangeTitle();

			fnc_SearchList();

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid() {

			var kind = dsT_CP_PAYMASTER.NameValue(1,"KIND");


			if(kind == "1"){
                form1.grdT_CP_CHANGE.format = "<C> id='{CUROW}'	     width=39	name='NO'		  	    align=center  value={String(Currow)}  </C>" +
                                              "<C> id='SD_GBN'		 width=90	name='수당구분'			align=left </C>" +
                                              "<C> id='SD_NAM'		 width=100	name='급여항목'			align=left </C>" +
                                              "<C> id='SD_REMARK'	 width=129	name='내역'				align=right </C>" +
                                              "<C> id='SD_AMT'		 width=80	name='금액'				align=right </C>";


            }else{
                form1.grdT_CP_CHANGE.format = "<C> id='{CUROW}'	     width=39	name='NO'		  	    align=center  value={String(Currow)}  </C>" +
                                              "<C> id='COMM_NM'		 width=130	name='공제항목'			align=left </C>" +
                                              "<C> id='REMARK'		 width=160	name='내역'				align=right </C>" +
                                              "<C> id='AMOUNT'		 width=110	name='금액'				align=right </C>";
            }

            cfStyleGrid_New(form1.grdT_CP_CHANGE,0,"false","false");      // Grid Style 적용

		}

        function fnc_ChangeTitle() {

			var kind = dsT_CP_PAYMASTER.NameValue(1,"KIND");

			if(kind == "1"){
				document.getElementById('title1').innerText = "기타수당내역";
				document.getElementById('title2').innerText = "기타수당내역";
            }else{
				document.getElementById('title1').innerText = "기타공제내역";
				document.getElementById('title2').innerText = "기타공제내역";
            }

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
    | 2. 이름 : dsT_CP_CHANGE                                 |
    | 3. Table List : T_CP_CHANGE                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
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
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle"><span id="title1"></span></td>
					<td align="right" class="navigator">HOME/기초정보/개인정보/급여지급액조회/<font color="#000000"><span id="title2"></span></font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:460px;height:230px;">
							<param name="DataID"							value="dsT_CP_CHANGE">
							<param name="EdiTABLE"						value="false">
							<param name="DragDropEnable"				value="true">
							<param name="SortView"						value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
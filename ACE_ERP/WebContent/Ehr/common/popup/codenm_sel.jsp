<!--
***********************************************************************
* @source      : codenm.jsp
* @description : 코드명조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2013/04/09      이동훈        최초작성.
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
	<title>코드명조회(codenm)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>
	<base target="_self">

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var retObj = window.dialogArguments;

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.codenm.cmd.CODENMCMD&S_MODE=SHR_SEL&GBN="+retObj.gbn;
            dsT_CM_COMMON.Reset();

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

			cfStyleGrid(form1.grdT_CM_COMMON,0,"false","right");      // Grid Style 적용

            document.getElementById("title").innerText      = retObj.title;

            retObj.comm_cd = '';
            retObj.comm_nm = '';
            retObj.eno_no = '';
            
            fnc_SearchList();

			document.getElementById('txtCOMM_CD_SHR').focus();

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
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = ' ';
            alert("검색하신 조건의 자료가 없습니다.");
			document.getElementById('txtCOMM_CD_SHR').focus();

        } else {

            document.getElementById("resultMessage").innerText = '* '+iCount+' 건의 자료가 조회되었습니다.';
	  	 	grdT_CM_COMMON.SetColumn("COMM_CD");//set focus

        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
	<script language=JavaScript for=grdT_CM_COMMON event=OnDblClick(row,colid)>

		var retObj = window.dialogArguments;

		retObj.comm_cd = dsT_CM_COMMON.NameValue(row,'CODE_CD');
		retObj.comm_nm = dsT_CM_COMMON.NameValue(row,'CODE_NM');
		retObj.cd_gbn  = dsT_CM_COMMON.NameValue(row,'CD_GBN');

		window.close();

	</script>

	<!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
	<script language=JavaScript for=grdT_CM_COMMON event=OnReturn(row,colid)>

		var retObj = window.dialogArguments;

		retObj.comm_cd = dsT_CM_COMMON.NameValue(row,'CODE_CD');
		retObj.comm_nm = dsT_CM_COMMON.NameValue(row,'CODE_NM');
		retObj.cd_gbn  = dsT_CM_COMMON.NameValue(row,'CD_GBN');

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
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="25" background="/images/common/barBg.gif">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
	                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><span id="title"></span>정보조회</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td align="center" class="greenTable">
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
	                                <td align="center" class="searchState">코드/코드명&nbsp;</td>
									<td class="padding2423"><input name="txtCOMM_CD_SHR" id="txtCOMM_CD_SHR" size="50" maxlength="50" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()"><input type="text" style="display:none"></td>
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
	<table width="450" border="0" cellspacing="0" cellpadding="0">
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
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr align="center">
	                    <td>
	                        <comment id="__NSID__">
	                        <object    id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:200px;">
	                            <param name="DataID"            value="dsT_CM_COMMON">
								<param Name="Editable"          value="false">
	                            <param name=HiddenHScroll    value="true">
	                            <param name="Format"            value='
	                            	<C> id=CODE_CD		width=100	name=코드	align=center 	</C>
	                                <C> id=CODE_NM		width=320   name=코드명     align=left 	</C>
	                            '>
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
	<table width="450" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState">* 해당항목을 더블클릭 하시면 선택됩니다.</span></td>
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
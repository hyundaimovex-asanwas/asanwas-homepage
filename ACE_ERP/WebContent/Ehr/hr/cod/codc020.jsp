<!--
    ************************************************************************************
    * @Source         : codc020.jsp 					                                 *
    * @Description    : Role별 권한관리.           *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/17  |  안준성   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>Role별권한관리(codc010)</title>
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

		var btnList = 'TFTTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//조회시 유효성 체크
			if( !fnc_SearchItemCheck() ) return;

           //데이터셋 전송
            dsT_CM_ROLEAUTH.DataID = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc020.cmd.CODC020CMD&S_MODE=SHR&txtROLE_CD_SHR="+document.getElementById("txtROLE_CD_SHR").value;
            dsT_CM_ROLEAUTH.Reset();

            form1.mgrdT_CM_ROLEAUTH.CollapseAll();

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

			if( !fnc_SaveItemCheck() ) return;

			for( i=1; i<= dsT_CM_ROLEAUTH.CountRow; i++ ) {
				if( dsT_CM_ROLEAUTH.NameValue(i,"T_CHECK") == 'T' )
					dsT_CM_ROLEAUTH.NameValue(i,"T_CHECK") = 'F';
			}

			for( i=1; i<= dsT_CM_ROLEAUTH.CountRow; i++ ) {
				if( dsT_CM_ROLEAUTH.RowStatus(i) == 3 ) {
					if( dsT_CM_ROLEAUTH.NameValue(i,"IO_FLG") == 'I' ) {
						dsT_CM_ROLEAUTH.UserStatus(i) = 1;
					}
				}
			}

			//트랜잭션 전송
			trT_CM_ROLEAUTH.Action = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc020.cmd.CODC020CMD&S_MODE=SAV";
			trT_CM_ROLEAUTH.Post();

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

			//document.getElementById("txtROLE_CD_SHR").value = '';
			//document.getElementById("txtROLE_NM_SHR").value = '';

			document.getElementById("resultMessage").innerText = ' ';

			dsT_CM_ROLEAUTH.ClearAll();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_CM_ROLEAUTH.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			if( document.getElementById("txtROLE_CD_SHR").value == '' ) {
				alert("ROLE을 선택해주세요.");
				return false;
			}
			return true;
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if( !dsT_CM_ROLEAUTH.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_04");
        		alert("저장 할 자료가 없습니다!");
        		return false;
        	}
        	return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /**
         * 모든 권한을 선택한다.
         */
        function selectCheckAll() {
            for(var i=1; i<=dsT_CM_ROLEAUTH.CountRow; i++) {
                //메뉴 구분 'm' 메뉴, 'f' 하위메뉴
                if(dsT_CM_ROLEAUTH.NameValue(i, "MENU_GBN") == "f") {
                    dsT_CM_ROLEAUTH.NameValue(i, "T_CHECK") = 'T';
                    dsT_CM_ROLEAUTH.NameValue(i, "BTN_01")  = 'T';
                    dsT_CM_ROLEAUTH.NameValue(i, "BTN_02")  = 'T';
                    dsT_CM_ROLEAUTH.NameValue(i, "BTN_03")  = 'T';
                    dsT_CM_ROLEAUTH.NameValue(i, "BTN_04")  = 'T';
                    dsT_CM_ROLEAUTH.NameValue(i, "BTN_05")  = 'T';
                    dsT_CM_ROLEAUTH.NameValue(i, "BTN_06")  = 'T';
                }
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
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->

    <Object ID="dsT_CM_ROLEAUTH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<object id=imgDsT_CM_ROLEAUTH classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
	     <param name="DataID"        value="service.csv">
	</object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_CM_ROLEAUTH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_ROLEAUTH)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

	<script language=JavaScript for=mgrdT_CM_ROLEAUTH event="OnLButtonDown(type, index, colid, x, y)">
        var checkVal;
        var menu_lbl;

        //메뉴명일때 리턴
        if( colid == 'MENU_NM' ) {
            return;
        }

        //INDEX랑 RowPosition 이랑 맞춤 (안 맞을때가 있어 맞춤)
        if(mgrdT_CM_ROLEAUTH.RowPosition != index)
            mgrdT_CM_ROLEAUTH.RowPosition = index;

        //TYPE이 VIEW 이고 전체 선택일 경우
		if( type == 3 && colid == 'T_CHECK' ) {

            if(dsT_CM_ROLEAUTH.NameValue(index, "T_CHECK") == "T") {
                checkVal = "F"
            } else {
                checkVal = "T"
            }
            //전체 선택 창 값변경
            dsT_CM_ROLEAUTH.NameValue(index, "T_CHECK") = checkVal;

            menu_lbl = dsT_CM_ROLEAUTH.NameValue(index, "MENU_LBL");    //메뉴 레벨


            //구분이 메뉴가 이니면 해당되는 줄만 변경 시킴  - 메뉴 구분 'm' 메뉴, 'f' 하위메뉴
            if(dsT_CM_ROLEAUTH.NameValue(index, "MENU_GBN") == "f") {


                dsT_CM_ROLEAUTH.NameValue(index, "BTN_01")  = checkVal;
                dsT_CM_ROLEAUTH.NameValue(index, "BTN_02")  = checkVal;
                dsT_CM_ROLEAUTH.NameValue(index, "BTN_03")  = checkVal;
                dsT_CM_ROLEAUTH.NameValue(index, "BTN_04")  = checkVal;
                dsT_CM_ROLEAUTH.NameValue(index, "BTN_05")  = checkVal;
                dsT_CM_ROLEAUTH.NameValue(index, "BTN_06")  = checkVal;

            } else {
                for(var i=index+1; i<=dsT_CM_ROLEAUTH.CountRow; i++) {
                    //선택한 메뉴 레벨보다 크거나 같은 메뉴가 나오면 중지
                    if(menu_lbl >= dsT_CM_ROLEAUTH.NameValue(i, "MENU_LBL")) return;

                    if(dsT_CM_ROLEAUTH.NameValue(i, "MENU_GBN") == "f") {

                        dsT_CM_ROLEAUTH.NameValue(i, "T_CHECK") = checkVal;
                        dsT_CM_ROLEAUTH.NameValue(i, "BTN_01")  = checkVal;
                        dsT_CM_ROLEAUTH.NameValue(i, "BTN_02")  = checkVal;
                        dsT_CM_ROLEAUTH.NameValue(i, "BTN_03")  = checkVal;
                        dsT_CM_ROLEAUTH.NameValue(i, "BTN_04")  = checkVal;
                        dsT_CM_ROLEAUTH.NameValue(i, "BTN_05")  = checkVal;
                        dsT_CM_ROLEAUTH.NameValue(i, "BTN_06")  = checkVal;
                    } else {
                        dsT_CM_ROLEAUTH.NameValue(i, "T_CHECK") = checkVal;
                    }
                }

            }

		}

        //개별일경우 개별로값 변경
        else {
			if( dsT_CM_ROLEAUTH.NameValue(index, colid) == 'F' )
				dsT_CM_ROLEAUTH.NameValue(index, colid) = 'T';
			else if( dsT_CM_ROLEAUTH.NameValue(index, colid) == 'T' )
				dsT_CM_ROLEAUTH.NameValue(index, colid) = 'F';
		}

	</script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->

    <Script For=dsT_CM_ROLEAUTH Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            document.getElementById("resultMessage").innerText = '* 자료가 조회 되었습니다!';

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_ROLEAUTH Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_ROLEAUTH Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_ROLEAUTH event="OnSuccess()">

		fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_ROLEAUTH event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
						<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">Role별 권한관리</td>
						<td align="right" class="navigator">HOME/인사평가/역량평가/<font color="#000000">Role별 권한관리</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" class="greenTable">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="100"></col>
									<col width="280"></col>
									<col width="480"></col>
								</colgroup>
								<tr>
									<td align="right" class="searchBold">ROLE&nbsp;</td>
									<td>
                                        <input id=txtROLE_CD_SHR name=txtROLE_CD_SHR style="ime-mode:disabled;width 100%;text-align:center" class="divInput" size="4" onKeypress="cfNumberCheck(); if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('RL','txtROLE_CD_SHR','txtROLE_NM_SHR');">
                                        <input id=txtROLE_NM_SHR size="16" style="text-align:center" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtROLE_CD_SHR','txtROLE_NM_SHR','ROLE','RL');"></a>
									</td>
									<td>&nbsp;</td>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td align="right" valign="bottom">
                            <img src="/images/button/btn_AllselectOn.gif" name="all_select" border="0" align="absmiddle" onclick="selectCheckAll()" style="cursor:hand;"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('all_select','','/images/button/btn_AllselectOver.gif',1)">
                        </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8" style="padding-top:1">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td height="2" bgcolor="#A4A4A1"></td>
	                </tr>
	            </table>
			</td>
		</tr>
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							  <object id=mgrdT_CM_ROLEAUTH classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=800 height=350>
							    <Param Name="DataID"		value="dsT_CM_ROLEAUTH">
							    <param name="ImageDataID"		value="imgDsT_CM_ROLEAUTH">
							    <Param Name="Sort"		value="false">
							    <Param Name="ColumnInfo"		value='
							      <COLUMNINFO>
							    	<COLUMN id="MENU_NM" refcolid="MENU_NM">
							    		<TREE type="2" levelcolumn="MENU_LBL"/>
							    		<HEADER left="0" top="0" right="403" bottom="30" bgcolor="#F7DCBB" text="메뉴"/>
							    		<VIEW left="0" top="0" right="403" bottom="23"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="T_CHECK" refcolid="T_CHECK">
							    		<HEADER left="403" top="0" right="463" bottom="30" bgcolor="#F7DCBB" text="전체적용"/>
							    		<VIEW left="403" top="0" right="463" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_01" refcolid="BTN_01">
							    		<HEADER left="463" top="0" right="513" bottom="30" bgcolor="#F7DCBB" text="신규"/>
							    		<VIEW left="463" top="0" right="513" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_02" refcolid="BTN_02">
							    		<HEADER left="513" top="0" right="563" bottom="30" bgcolor="#F7DCBB" text="조회"/>
							    		<VIEW left="513" top="0" right="563" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_03" refcolid="BTN_03">
							    		<HEADER left="563" top="0" right="613" bottom="30" bgcolor="#F7DCBB" text="저장"/>
							    		<VIEW left="563" top="0" right="613" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_04" refcolid="BTN_04">
							    		<HEADER left="613" top="0" right="663" bottom="30" bgcolor="#F7DCBB" text="삭제"/>
							    		<VIEW left="613" top="0" right="663" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_05" refcolid="BTN_05">
							    		<HEADER left="663" top="0" right="713" bottom="30" bgcolor="#F7DCBB" text="인쇄"/>
							    		<VIEW left="663" top="0" right="713" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_06" refcolid="BTN_06">
							    		<HEADER left="713" top="0" right="763" bottom="30" bgcolor="#F7DCBB" text="기타"/>
							    		<VIEW left="713" top="0" right="763" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							     </COLUMNINFO>'>
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
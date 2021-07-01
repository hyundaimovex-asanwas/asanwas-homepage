<!--
*****************************************************
* @source       : etcb010.jsp
* @description : 통합결재현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/10/07      한학현        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>미결재현황</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'F' + 'F' + 'T';

        var today = getToday();
        var sso_flag = "";
        if("<%=box.get("SSO_FLAG")%>" != ""){
            sso_flag = "<%=box.get("SSO_FLAG")%>";
        }


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO_SHR  = "<%=box.get("SESSION_ENONO") %>";//사번
            var APP_GBN_SHR = document.getElementById("cmbAPP_GBN_SHR").value;//결재구분


            dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb010.cmd.ETCB010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&APP_GBN_SHR="+APP_GBN_SHR;
            dsT_DI_APPROVAL.reset();

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

            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_APPROVAL.GridToExcel("통합결재현황", '', 225);

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

            document.getElementById("cmbAPP_GBN_SHR").value = "";//결재구분
            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_APPROVAL.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(sso_flag == ""){
	            if (dsT_DI_APPROVAL.IsUpdated)  {
	                if (!fnc_ExitQuestion()) return;
	            }

	            frame = window.external.GetFrame(window);

	            frame.CloseFrame();

            }else{
		        ds_LOGOUT.DataId="/servlet/GauceChannelSVL?cmd=common.menu.logout.cmd.LOGOUTCMD";
		        ds_LOGOUT.reset();
            }

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

            if (!dsT_DI_APPROVAL.IsUpdated) {
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


            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용

            document.getElementById("cmbAPP_GBN_SHR").value = "%";//결재구분

            fnc_SearchList();//자동조회

            if(sso_flag == ""){
	            if(dsT_DI_APPROVAL.countrow > 0){
	                alert(dsT_DI_APPROVAL.countrow+"건의 미결재내역이 존재합니다.");
	            }
            }


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
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!------------------------------------+
    | 1. Logout용 DataSet                  |
    | 2. 이름 : dsT_CM_EMPLIST            |
    | 3. Table List :T_CM_EMPLIST         |
    +------------------------------------->
    <Object ID="ds_LOGOUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <Script For=ds_LOGOUT Event="OnLoadCompleted(iCount)">

        var frame = window.external.GetFrame(window);
        frame.outerWindow.do_logout();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=ds_LOGOUT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">

        var param = new String();

        if(row < 1) {

            return;

        } else {
			//휴일근무 param 값 Setting
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                      //변수들 정의
	            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");
          		param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");
          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
            }

            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

            //일일근태, 근태변경, 익월근태, 연차촉진제
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "0" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "1" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "2" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "3"){
                window.showModalDialog("/hr/gun/guna071.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //파견관리
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "4"){
				var url = "/hr/but/butc020.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO") + "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
                window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:540px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //해외출장
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "5"){
				var url = "/hr/but/butb020.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO") + "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");

                window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:700px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //휴일근무 정산
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6"){
                window.showModalDialog("/hr/gun/gunc071.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //휴일근무 사전신청
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7"){
                window.showModalDialog("/hr/gun/gunc091.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //휴일근무 결과보고
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                window.showModalDialog("/hr/gun/gunc012.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //국내출장
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "9"){
				var url = "/hr/but/buta025.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&PENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");

                window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //경공조금
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "10"){
                 var url = "/hr/aid/aida011.jsp?REQ_NO="+dsT_DI_APPROVAL.NameString(row, "REQ_NO")+"&TYPE=TYPE2";
				cfWinOpen(url,"경공조",870,500)
               // window.showModalDialog("/hr/aid/aida010.jsp", "Modal", "dialogWidth:870px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //교육신청
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "11"){
				window.showModalDialog("/hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:770px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //교육신청
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "12"){
				window.showModalDialog("/hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:770px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //교육결과보고
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "13"){
                 window.showModalDialog("/hr/edu/edue061.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:550px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //신입사원OJT
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "14"){
                 window.showModalDialog("/hr/cdp/cdpd061.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:860px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //도서구입
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "15"){

          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
            	window.showModalDialog("/hr/cdp/book011.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");


            //일용직노무비
	        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "16"){
	
	      		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");

	        	window.showModalDialog("/hr/ada/aday051.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
	        }
            
			fnc_SearchList();
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">미결재현황</td>
                    <td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">미결재현황</font></td>
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
                                <col width="20"></col>
                                <col width="30"></col>
                                <col width="40"></col>
                                <col width="120"></col>
                                <col width="80"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">결재구분&nbsp;</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_GBN_SHR" style="width:100" onChange="fnc_SearchList();">
			                            <option value="%" >전체</option>
			                            <option value="0" >일일근태</option>
			                            <option value="1" >근태변경</option>
			                            <option value="3" >연차촉진제</option>
			                            <option value="6" >휴일정산</option>
			                            <option value="7" >휴일신청</option>
			                            <option value="8" >휴일결과</option>
			                            <option value="9" >국내출장</option>
			                            <option value="10" >경공조금</option>
			                            <option value="11" >교육신청</option>
			                            <option value="12" >연간교육신청</option>
			                            <option value="13" >교육결과보고</option>
			                            <option value="14" >신입사원OJT</option>
			                            <option value="15" >도서구입</option>
			                            <option value="16" >일용직노무비</option>			                            
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
        <td align="center" width="45%" valign="bottom">
            <b>※ 더블클릭을 하시면 해당 결재현황으로 이동합니다. </b>
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
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                value="dsT_DI_APPROVAL">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    width=39    name='NO'           align=center    value={String(Currow)}</C>
                                <FC> id='APP_GBN_NM' width=100   name='결재구분'     align=center </FC>
                                <FC> id='APP_TITLE'  width=440   name='제목'         align=left   </FC>
                                <FC> id='APP_YMD'    width=110   name='상신일자'     align=center </FC>
                                <C> id='PENO_NM'    width=90    name='상신자'       align=center  </C>
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
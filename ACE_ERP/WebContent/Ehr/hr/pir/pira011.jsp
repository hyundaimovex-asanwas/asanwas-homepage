<!--
    ************************************************************************************
    * @Source         : pira011.jsp                                                    *
    * @Description    : 신입사원 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사									 *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>신입사원(pira011)</title>
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
    
        var retObj = window.dialogArguments;

        retObj.reg_no  = '';
        retObj.jumin1  = '';
        retObj.jumin2  = '';
        retObj.eno_nm  = '';
        retObj.nam_eng = '';
        retObj.nam_chi = '';
        retObj.sexgu   = '';
        retObj.birymd  = '';
        retObj.birtag  = '';
    
		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
        var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var REGYY  = document.getElementById("txtREGYY_SHR").value;
            var REGCH  = document.getElementById("txtREGCH_SHR").value;
            
            if (REGYY == "") {
                alert("년도는 필수입력항목입니다.");
                document.getElementById("txtREGYY_SHR").focus();
                return;
            }
            
            if (REGCH == "") {
                alert("차수는 필수입력항목입니다.");
                document.getElementById("txtREGCH_SHR").focus();
                return;
            }

            dsT_RC_MASTER.ClearData();
            
            dsT_RC_MASTER.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira011.cmd.PIRA011CMD&S_MODE=SHR&REGYY="+REGYY+"&REGCH="+REGCH;
            dsT_RC_MASTER.Reset();
            
            form1.grdT_RC_MASTER.Focus();
            
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
            var CountRow = 0;
            
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

            document.getElementById("txtREGYY_SHR").value = '';
            document.getElementById("txtREGCH_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_RC_MASTER.ClearData();
            
            document.getElementById("txtREGYY_SHR").focus();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
            
            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            
            //Grid Style 적용
            cfStyleGrid(form1.grdT_RC_MASTER,0,"false","false");
            
            // 그리드에 개인별역량평가대상자설정 데이터 조회
            //fnc_SearchList();
                        
            document.getElementById("txtREGYY_SHR").focus();
        }
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_RC_MASTER.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }
            
            window.close();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_RC_MASTER)    |
    | 3. 사용되는 Table List(T_RC_MASTER)           |
    +----------------------------------------------->
    <Object ID="dsT_RC_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_RC_MASTER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_RC_MASTER.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_RC_MASTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_MASTER Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_RC_MASTER event=OnDblClick(row,colid)>

        var retObj = window.dialogArguments;

        retObj.reg_no  = dsT_RC_MASTER.NameValue(row,'REG_NO');
        retObj.jumin1  = dsT_RC_MASTER.NameValue(row,'JUMIN1');
        retObj.jumin2  = dsT_RC_MASTER.NameValue(row,'JUMIN2');
        retObj.eno_nm  = dsT_RC_MASTER.NameValue(row,'ENO_NM');
        retObj.nam_eng = dsT_RC_MASTER.NameValue(row,'NAM_ENG');
        retObj.nam_chi = dsT_RC_MASTER.NameValue(row,'NAM_CHI');
        retObj.sexgu   = dsT_RC_MASTER.NameValue(row,'SEXGU');
        retObj.birymd  = dsT_RC_MASTER.NameValue(row,'BIRYMD');
        retObj.birtag  = dsT_RC_MASTER.NameValue(row,'BIRTAG');
        
        window.close();

    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때 |
    +-------------------------------->
    <script language=JavaScript for=grdT_RC_MASTER event=OnReturn(row,colid)>

        var retObj = window.dialogArguments;

        retObj.reg_no  = dsT_RC_MASTER.NameValue(row,'REG_NO');
        retObj.jumin1  = dsT_RC_MASTER.NameValue(row,'JUMIN1');
        retObj.jumin2  = dsT_RC_MASTER.NameValue(row,'JUMIN2');
        retObj.eno_nm  = dsT_RC_MASTER.NameValue(row,'ENO_NM');
        retObj.nam_eng = dsT_RC_MASTER.NameValue(row,'NAM_ENG');
        retObj.nam_chi = dsT_RC_MASTER.NameValue(row,'NAM_CHI');
        retObj.sexgu   = dsT_RC_MASTER.NameValue(row,'SEXGU');
        retObj.birymd  = dsT_RC_MASTER.NameValue(row,'BIRYMD');
        retObj.birtag  = dsT_RC_MASTER.NameValue(row,'BIRTAG');
        
        window.close();

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">신입사원</td>
                    <td align="right" class="navigator">HOME/인사평가/평가기준정보/<font color="#000000">신입사원</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="40"></col>
                                <col width="50"></col>
                                <col width="40"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">년도 </td>
                                <td class="padding2423">
                                    <input name=txtREGYY_SHR size="4"  maxlength="4" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
                                </td>
                                <td align="right" class="searchState">차수 </td>
                                <td class="padding2423">
                                    <input name=txtREGCH_SHR size="4"  maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
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
<table width="400" border="0" cellspacing="0" cellpadding="0">
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
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_RC_MASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:250px;">
                            <param name="DataID"                  value="dsT_RC_MASTER">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'         align=center </C>
                                <C> id='REG_NO'       width=100   name='수험번호'     align=center </C>
                                <C> id='ENO_NM'       width=80    name='성명'         align=left   </C>
                                <C> id='FIN_DPT_NM'   width=90    name='배치부서'     align=left   </C>
                                <C> id='SPLIT_NM'     width=70    name='구분'         align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

<!-- 조회 상태 테이블 시작 -->
    <table width="400" border="0" cellspacing="0" cellpadding="0">
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
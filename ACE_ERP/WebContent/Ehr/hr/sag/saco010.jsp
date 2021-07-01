<!--
    ************************************************************************************
    * @Source         : saco010.jsp                                                    *
    * @Description    : 계정코드  PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/31  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>ERP 계정코드(saco010)</title>
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

            trT_ZZ_SAP_SHR.KeyValue = "tr05(O:dsT_ZZ_SAP=dsT_ZZ_SAP)";
				trT_ZZ_SAP_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.zzz.a.zzza011.cmd.ZZZA011CMD&S_MODE=SAP_SHR";
				trT_ZZ_SAP_SHR.post();

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
            cfStyleGrid(form1.grdT_RC_MASTER,0,"false","true");
            fnc_SearchList()

            // 그리드에 개인별역량평가대상자설정 데이터 조회
            //fnc_SearchList();
        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
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
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_ZZ_POSTLIST                                     |
    | 3. Table List : T_ZZ_POSTLIST                                |
    +----------------------------------------------->
    <Object ID="dsT_ZZ_SAP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_ZZ_SAP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT,I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)">
	</Object>

	<Object ID="trT_ZZ_SAP_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)">
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


        retObj.acc_cd  = dsT_ZZ_SAP.NameValue(row,'SAKNR');
        retObj.acc_nm  = dsT_ZZ_SAP.NameValue(row,'TXT50');

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
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ERP 계정코드</td>
                    <td align="right" class="navigator">HOME/보상관리/급여관리/<font color="#000000">ERP 계정코드</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->


<!-- 조회 상태 테이블 시작 -->
<table width="600" border="0" cellspacing="0" cellpadding="0">
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
                        <object    id="grdT_RC_MASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:290px;">
                            <param name="DataID"                  value="dsT_ZZ_SAP">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C>    id='{CURROW}'       name='NO'  width='40'    align=center               </C>
                                <C>    id='KTOPL'       name='계정과목표'  width='85'    align=center               </C>
                                <C>    id='SAKNR'     name='G/L계정번호'    width='100'    align=left                </C>
                                <C>    id='XBILK'   name='지시자'    width='65'    align=center   edit=true             </C>
                                <C>    id='KTOKS'   name='G/L계정그룹'    width='90'    align=center   edit=true             </C>
                                <C>    id='TXT20'   name='기준텍스트'   show='false' width='200'    align=left   edit=true             </C>
                                <C>    id='TXT50'   name='텍스트'    width='200'    align=left   edit=true             </C>
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
<!--
    ************************************************************************************
    * @Source         : eduj010.jsp                                                    *
    * @Description    : 코드관리 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>코드관리(eduj010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >
    
        var btnList = 'TTTTFFTT';
    
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var f = document.form1;

            try {
                dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=SHR&COMM_CD="+f.txtCOMM_CD_SHR.value;
                dsT_CM_COMMON.Reset();
    
                f.grdT_CM_COMMON.focus();
            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
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
            var f = document.form1;
            if(fnc_SaveItemCheck()) {
                tr01T_CM_COMMON.KeyValue = "SVL(I:SAV=ds01T_CM_COMMON)";
                tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=SAV";
                tr01T_CM_COMMON.post();
    
                dsT_CM_COMMON.Reset();
    
                ds01T_CM_COMMON.Reset();
            } else {
                return;
            }
        }
    
        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (ds01T_CM_COMMON.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");//메세지가 제거인데 삭제로 출력햇음
                return;
            }
            
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("코드[" + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            ds01T_CM_COMMON.DeleteRow(ds01T_CM_COMMON.RowPosition);
            tr01T_CM_COMMON.KeyValue = "SVL(I:DEL=ds01T_CM_COMMON)";
            tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=DEL";
            tr01T_CM_COMMON.post();
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
            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CM_COMMON.CountRow < 1) {

                alert('조회 후 신규등록이 가능합니다.');
                document.getElementById("resultMessage").innerText = "* 조회 후 신규등록이 가능합니다."
                return;
            }
    
            // AddNew 후 입력 테이블로 포커스
            ds01T_CM_COMMON.AddRow();
    
            var oCD_GBN = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition,"COMM_CD");
            
            document.getElementById("txtCD_GBN").value = oCD_GBN;
            document.getElementById("txtCOMM_CD").focus();
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
    
        }
    
        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
    
            dsT_CM_COMMON.ClearData();
            ds01T_CM_COMMON.ClearData();
            document.getElementById("txtCOMM_CD_SHR").focus();
        }
    
        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_COMMON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }
    
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }
    
        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요
    
        }
    
        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
               var f = document.form1;
    
            //DataSet의 변경 여부 확인
            if (!ds01T_CM_COMMON.IsUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
    
            var i = 0;
            var oCD_GBN, oCOMM_CD, oCOMM_NM, oSORT_NO, oEND_YMD;
            var RowCnt = ds01T_CM_COMMON.CountRow;
            for(i=1; i<=RowCnt; i++){
    
                oCD_GBN = ds01T_CM_COMMON.NameValue(i,"CD_GBN");
                if(oCD_GBN.trim() == ""){
                    alert(i+"번째의 공통구분코드가 잘못되었습니다." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtCD_GBN").focus();
                    return false;
                }
    
                oCOMM_CD = ds01T_CM_COMMON.NameValue(i,"COMM_CD");
                if(oCOMM_CD.trim() == ""){
                    alert(i+"번째의 코드가 잘못되었습니다." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtCOMM_CD").focus();
                    return false;
                }
    
                oCOMM_NM = ds01T_CM_COMMON.NameValue(i,"COMM_NM");
                if(oCOMM_NM.trim() == ""){
                    alert(i+"번째의 코드명1이 잘못되었습니다." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtCOMM_NM").focus();
                    return false;
                }
    
                oSORT_NO = ds01T_CM_COMMON.NameValue(i,"SORT_NO");
                if(oSORT_NO.toString().trim().length == 0 || oSORT_NO == 0){
                    alert(i+"번째의 정렬순서가  잘못되었습니다." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.medSORT_NO.Focus();
                    return false;
                }
    
                oEND_YMD = ds01T_CM_COMMON.NameValue(i,"END_YMD");
                if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){
                    alert(i+"번째의 폐기일자가  잘못되었습니다." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtEND_YMD").focus();
                    return false;
                }
            }
    
            return true;
        }
    
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_COMMON,15,"false","right");
            cfStyleGrid(form1.grd01T_CM_COMMON,15,"false","right");
        }
    
        /********************
         * 16. 단축키 처리  *
         *******************/
        function fnc_HotKey() {
    
            fnc_HotKey_Process(btnList, event.keyCode);
    
        }
    
        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/
    
    </script>
    </head>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CM_COMMON                       |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : ds01T_CM_COMMON                     |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <Object ID="ds01T_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : tr01T_CM_COMMON                     |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_COMMON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
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
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_COMMON.CountRow);
        }
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CM_COMMON.CountRow);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=tr01T_CM_COMMON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=tr01T_CM_COMMON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid에서 row를 클릭했을때 |
    +------ -------------------->
    <script for=grdT_CM_COMMON event=OnClick(Row,Colid)>

        var overId = "COMM_CD";
        var overValue = dsT_CM_COMMON.NameValue(Row,overId);
        
        if(Row < 1) {
            return;
        } else {
            try {
                ds01T_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=SHR_01&"+overId+"="+overValue;
                ds01T_CM_COMMON.Reset();

            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">코드관리</td>
                    <td align="right" class="navigator">HOME/교육관리/시스템관리/<font color="#000000">코드관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <!-- 왼쪽 화면 시작-->
            <table width="350" border="0" cellspacing="0" cellpadding="0">
                <tr align="center"  valign="top">
                    <td  valign="top">
                        <!-- power Search테이블 시작 -->
                        <table width="350" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" class="greenTable">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <colgroup>
                                                        <col width="130"></col>
                                                        <col width=""></col>
                                                        <col width="60"></col>
                                                    </colgroup>
                                                    <tr>
                                                        <td align="right" class="searchState">코드/코드명</td>
                                                        <td align="center"><input id="txtCOMM_CD_SHR" name="txtCOMM_CD_SHR" style="width 100%;" class="divInput" onKeypress="javascript:if(event.keyCode==13)fnc_SearchList()"></td>
                                                        <td align="left"></td>
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
                        <table width="350" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop15">
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
                        <table width="350" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr align="center">
                                            <td>
                                                <comment id="__NSID__">
                                                <object id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:350px;height:370px;">
                                                    <param name="DataID"                 value="dsT_CM_COMMON">
                                                    <param name="EdiTABLE"               value="false">
                                                    <param name="DragDropEnable"         value="true">
                                                    <param name="SortView"               value="Left">
                                                    <param name="VIEWSUMMARY"            value=0>
                                                    <param name="Format"                 value="
                                                        <C> id='CURROW'     width=50     name='순번'                 align=center    value={CurRow} </C>
                                                        <C> id='COMM_CD'    width=80     name='코드'    sort=true    align=center                   </C>
                                                        <C> id='COMM_NM'    width=184    name='코드명'  sort=true    align=left                     </C>
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

                    </td>
                </tr>
            </table>
            <!-- 왼쪽 화면 끝-->
        </td>
        <td>
            <!-- 오른쪽 화면 시작-->
            <table width="440" border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <!-- 조건 입력 테이블 시작 -->
                        <table width="440" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                        <colgroup>
                                            <col width="90"></col>
                                            <col width="120"></col>
                                            <col width="90"></col>
                                            <col width=""></col>
                                        </colgroup>
                                        <tr>
                                            <td align="center" class="creamBold">공통구분코드</td>
                                            <td class="padding2423"><input id="txtCD_GBN" style="width:100%" maxlength="2"></td>
                                            <td align="center" class="creamBold">코&nbsp;&nbsp;&nbsp;드</td>
                                            <td class="padding2423"><input id="txtCOMM_CD" style="width:100%"  maxlength="5"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">코드명1</td>
                                            <td class="padding2423"><input id="txtCOMM_NM" style="width:100%" maxlength="50"></td>
                                            <td align="center" class="creamBold">코드명2</td>
                                            <td class="padding2423"><input id="txtCOMM_NM2" style="width:100%" maxlength="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">정렬순서</td>
                                            <td class="padding2423">
                                                <comment id="__NSID__"><object id="medSORT_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                                    <param name=Alignment            value=0>
                                                    <param name=Border               value=true>
                                                    <param name=ClipMode             value=true>
                                                    <param name=DisabledBackColor    value="#EEEEEE">
                                                    <param name=Enable               value=true>
                                                    <param name=IsComma              value=true>
                                                    <param name=Language             value=0>
                                                    <param name=MaxLength            value=3>
                                                    <param name=Numeric              value=true>
                                                    <param name=ShowLiteral          value="false">
                                                    <param name=Visible              value="true">
                                                </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                            </td>
                                            <td align="center" class="creamBold">폐기일자</td>
                                            <td class="padding2423">
                                                <input id="txtEND_YMD" style="width:78%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','500','125');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">기타항목1</td>
                                            <td class="padding2423"><input id="txtEXT_01" style="width:100%" maxlength="50"></td>
                                            <td align="center" class="creamBold">기타항목2</td>
                                            <td class="padding2423"><input id="txtEXT_02" style="width:100%" maxlength="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">기타항목3</td>
                                            <td class="padding2423"><input id="txtEXT_03" style="width:100%" maxlength="50"></td>
                                            <td align="center" class="creamBold">기타항목4</td>
                                            <td class="padding2423"><input id="txtEXT_04" style="width:100%" maxlength="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;고</td>
                                            <td class="padding2423" colspan="3"><input id="txtOTH_DEC" style="width:100%" maxlength="100"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <!-- 조건 입력 테이블 끝 -->

                        <!-- 내용 조회 그리드 테이블 시작-->
                        <table width="440" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr align="center">
                                            <td>
                                                <comment id="__NSID__">
                                                <object id="grd01T_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:300px;">
                                                    <param name="DataID"                    value="ds01T_CM_COMMON">
                                                    <param name="EdiTABLE"                  value="false">
                                                    <param name="DragDropEnable"            value="true">
                                                    <param name="SortView"                  value="Left">
                                                    <param name="VIEWSUMMARY"               value=0>
                                                    <param name="Format"                    value="
                                                        <C> id='CURROW'     width=50        name='순번'                     align=center    value={CurRow}  </C>
                                                        <C> id='COMM_CD'    width=80        name='코드'        sort=true    align=center                    </C>
                                                        <C> id='COMM_NM'    width=154       name='코드명'      sort=true    align=left                      </C>
                                                        <C> id='END_YMD'    width=120       name='폐기일자'    sort=true    align=center                    </C>
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

                    </td>
                </tr>
            </table>
            <!-- 오른쪽 화면 끝-->
        </td>
    </tr>
</table>

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(Bind Component)                                          *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                        |
    | 2. 이름 : bndT_CM_COMMON                      |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="ds01T_CM_COMMON">
        <Param Name="BindInfo", Value="
            <C>Col='CD_GBN'        Ctrl='txtCD_GBN'        Param=value        Disable=disabled</C>
            <C>Col='COMM_CD'       Ctrl='txtCOMM_CD'       Param=value        Disable=disabled</C>
            <C>Col='COMM_NM'       Ctrl='txtCOMM_NM'       Param=value        Disable=disabled</C>
            <C>Col='COMM_NM2'      Ctrl='txtCOMM_NM2'      Param=value        Disable=disabled</C>
            <C>Col='SORT_NO'       Ctrl='medSORT_NO'       Param=text         Disable=disabled/C>
            <C>Col='END_YMD'       Ctrl='txtEND_YMD'       Param=value        Disable=disabled</C>
            <C>Col='EXT_01'        Ctrl='txtEXT_01'        Param=value        Disable=disabled</C>
            <C>Col='EXT_02'        Ctrl='txtEXT_02'        Param=value        Disable=disabled</C>
            <C>Col='EXT_03'        Ctrl='txtEXT_03'        Param=value        Disable=disabled</C>
            <C>Col='EXT_04'        Ctrl='txtEXT_04'        Param=value        Disable=disabled</C>
            <C>Col='OTH_DEC'       Ctrl='txtOTH_DEC'       Param=value        Disable=disabled</C>
        ">
    </object>

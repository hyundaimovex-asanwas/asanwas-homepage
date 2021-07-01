<!--
    ************************************************************************************
    * @Source         : sela021.jsp                                                    *
    * @Description    : 공지사항 등록(수정)PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/19  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>공지사항 등록(수정)(sela021)</title>
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
    
        var btnList = 'FFTFFFFT';
        
        var opener = window.dialogArguments;
        var mode   = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_BOARD.ClearData();
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela021.cmd.SELA021CMD&S_MODE=SHR&BBS_GBN="+opener.bbs_gbn+"&SEQ_NO="+opener.seq_no;
            dsT_ED_BOARD.Reset();
            
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

            dsT_ED_BOARD.NameValue(dsT_ED_BOARD.RowPosition, "CHK") = "0";
            
            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            mode = "0";                   // 입력/수정모드
            dsT_ED_BOARD2.ClearData();
            oFileListGDS.ClearData();

            trT_ED_BOARD.KeyValue = "tr01(I:SAV=dsT_ED_BOARD,I:FILE=oFileListGDS2, O:RELOAD=dsT_ED_BOARD2, O:RELOAD2=oFileListGDS)";
            trT_ED_BOARD.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela021.cmd.SELA021CMD&S_MODE=SAV&BBS_GBN="+opener.bbs_gbn+"&SEQ_NO="+opener.seq_no;
            trT_ED_BOARD.post();
            
            oFileListGDS2.ClearData();
            
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

            //이곳에 해당 코딩을 입력 하세요

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
            
            if (!dsT_ED_BOARD.IsUpdated && !oFileListGDS.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
            
            if ( dsT_ED_BOARD.isUpdated || oFileListGDS.IsUpdated) {
                for( i = 1; i <= dsT_ED_BOARD.CountRow; i++ ) {
                    if( dsT_ED_BOARD.RowStatus(i) == 1 || 
                        dsT_ED_BOARD.RowStatus(i) == 3 ) {
                        // 사번
                        if( dsT_ED_BOARD.NameValue(i, "ENO_NO") == '' ) {
                            alert("사번은 필수 입력사항입니다.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }
                        
                        // 사번 CHECK
                        if( document.getElementById("txtENO_NO").value != '' && document.getElementById("txtENO_NM").value == '' ) {
                            alert("입력하신 사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }
                        
                        // 제목
                        if( dsT_ED_BOARD.NameValue(i, "SUBJECT_TAG") == "" ) {
                            alert("제목은 필수 입력사항입니다.");
                            document.getElementById("txtSUBJECT_TAG").focus();
                            return false;
                        }
                        
                        // 내용
                        if( dsT_ED_BOARD.NameValue(i, "CONTENT_TXT") == "" ) {
                            alert("내용은 필수 입력사항입니다.");
                            document.getElementById("txtCONTENT_TXT").focus();
                            return false;
                        }
                    }
                }
            }            

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("title").innerText = opener.title;
            
            //Grid Style 적용
            cfStyleGrid(form1.grdFileListGDS,15,"false","false");
            
            // 파일 첨부용 데이터셋의 헤더 정보 설정. 
            oFileListGDS.setDataHeader("SEQ:INT, FILE_NAME:STRING, FILE_URL:URL");
            oFileListGDS2.setDataHeader("SEQ:INT, FILE_NAME:STRING, FILE_URL:URL");

            // 구분이 수정이면
            if (opener.gbn == "2") {

                document.getElementById('txtENO_NO').value = opener.eno_no;
                document.getElementById('txtENO_NM').value = opener.eno_nm;
                
                fnc_ChangeStateElement(false, "txtENO_NO");
                fnc_ChangeStateElement(false, "txtENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
            
                // 공지사항 데이터 조회
                fnc_SearchList();
            }
            else {
            
                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
                if (dsT_ED_BOARD.CountColumn == 0) {
                    dsT_ED_BOARD.setDataHeader("BBS_GBN:STRING, SEQ_NO:STRING, REF_NO:STRING, STEP_NO:STRING, DEPT_NO:STRING, ENO_NO:STRING:NOTNULL, ENO_NM:STRING, SUBJECT_TAG:STRING(40), CONTENT_TXT:STRING(1000), SRCFILE1_NM:STRING, TGTFILE1_NM:STRING, SRCFILE2_NM:STRING, TGTFILE2_NM:STRING, SRCFILE3_NM:STRING, TGTFILE3_NM:STRING, SRCFILE4_NM:STRING, TGTFILE4_NM:STRING, SRCFILE5_NM:STRING, TGTFILE5_NM:STRING, CHK:STRING");
                }
                
                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_ED_BOARD.AddRow();
                
                dsT_ED_BOARD.NameValue(1, "BBS_GBN") = opener.bbs_gbn;
                dsT_ED_BOARD.NameValue(1, "REF_NO")  = opener.ref_no;
                dsT_ED_BOARD.NameValue(1, "STEP_NO") = opener.step_no;
                dsT_ED_BOARD.NameValue(1, "DEPT_NO") = opener.dept_no;
                dsT_ED_BOARD.NameValue(1, "ENO_NO")  = opener.eno_no;
                dsT_ED_BOARD.NameValue(1, "ENO_NM")  = opener.eno_nm;
            
                document.getElementById('txtENO_NO').focus();
            }
            
        }
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_ED_BOARD.IsUpdated)
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
        
        /********************
         * 첨부파일 처리    *
         *******************/
        function fnc_FileUpload() {
            var flag = "";

            if (oFileListGDS.CountRow == 5) {
                alert("파일은 최대 5개까지 첨부 가능합니다!");
                return;
            }
            
            oFileListGDS.addrow();
            oFileListGDS2.addrow();

            oFileGF.open();
            
            if(oFileGF.SelectState == true)
            {
                for (var i = 1; i <= 5; i++) {
                    for (var j = 1; j <= oFileListGDS.CountRow; j++) {
                        if (oFileListGDS.NameValue(j, "SEQ") == i) {
                            break;
                        }
                        else {
                            if (oFileListGDS.NameValue(j, "SEQ") == 0) {
                                
                                oFileListGDS.NameValue(oFileListGDS.RowPosition, "FILE_NAME") = oFileGF.value;
                                oFileListGDS.NameValue(oFileListGDS.RowPosition, "SEQ") = i;
                                oFileListGDS2.NameValue(oFileListGDS2.RowPosition, "FILE_NAME") = oFileGF.value;
                                oFileListGDS2.NameValue(oFileListGDS2.RowPosition, "SEQ") = i;
                                flag = "1";
                                break;
                            }
                        }
                    }
                    
                    if (flag == "1") {
                        break;
                    }
                }
            }
            else {
                oFileListGDS.deleterow(oFileListGDS.RowPosition);
                oFileListGDS2.deleterow(oFileListGDS2.RowPosition);
            }
            
        }
        
        /********************
         * 첨부파일 삭제    *
         *******************/
        function fnc_FileDelete() {
            var flag = "";
            
            var status = oFileListGDS.RowStatus(oFileListGDS.RowPosition);
            var CountRow = 0;
            
            if (confirm("해당 파일을 삭제하시겠습니까?") == false) return;
            
            for (var i = 1; i <= oFileListGDS2.CountRow; i++) {
                if (oFileListGDS2.NameValue(i, "SEQ") == oFileListGDS.NameValue(oFileListGDS.RowPosition, "SEQ")) {
                    oFileListGDS2.deleterow(i);
                    oFileListGDS.deleterow(oFileListGDS.RowPosition);
                    flag = "1";
                    break;
                }
            }
            
            if (flag != "1") {
                oFileListGDS2.addrow();
                
                oFileListGDS2.NameValue(oFileListGDS2.RowPosition, "SEQ") = oFileListGDS.NameValue(oFileListGDS.RowPosition, "SEQ");
                oFileListGDS2.NameValue(oFileListGDS2.RowPosition, "FILE_NAME") = "";
                oFileListGDS2.NameValue(oFileListGDS2.RowPosition, "FILE_URL") = oFileListGDS.NameValue(oFileListGDS.RowPosition, "FILE_URL");
     
                oFileListGDS.deleterow(oFileListGDS.RowPosition);
            }

            // 신규가 아닌 경우는 
            if (status != "1") {
                
                mode = "1";                   // 삭제모드
                
                dsT_ED_BOARD.NameValue(dsT_ED_BOARD.RowPosition, "CHK") = "1";
                
                dsT_ED_BOARD2.ClearData();
                oFileListGDS.ClearData();
                
                trT_ED_BOARD.KeyValue = "tr01(I:SAV=dsT_ED_BOARD,I:FILE=oFileListGDS2, O:RELOAD=dsT_ED_BOARD2, O:RELOAD2=oFileListGDS)";
                trT_ED_BOARD.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela021.cmd.SELA021CMD&S_MODE=SAV&BBS_GBN="+opener.bbs_gbn+"&SEQ_NO="+opener.seq_no;
                trT_ED_BOARD.post();
                
                oFileListGDS2.ClearData();
                
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdFileListGDS.SetColumn(form1.grdFileListGDS.GetColumnID(0));
            form1.grdFileListGDS.Focus();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_BOARD) |
    | 3. 사용되는 Table List(T_ED_BOARD)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-- Reload용 데이터셋 -->
    <Object ID="dsT_ED_BOARD2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>
    
    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="oFileListGDS" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>
    
    <!-- Reload용 데이터셋 -->
    <object id="oFileListGDS2" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- 가우스 파일 오브젝트 -->
    <object id="oFileGF" classid="CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE" class="root" style="display:none" >
        <param name="Text"        value='첨부파일'>
        <param name="Enable"    value="true">
    </object>
    
   
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID ="trT_ED_BOARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_BOARD,I:FILE=oFileListGDS, O:RELOAD=dsT_ED_BOARD2)">
    </Object>
    
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_BOARD.CountRow );
            
            oFileListGDS.ClearData();
            
            oFileListGDS.DataId = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela021.cmd.SELA021CMD&S_MODE=SHR_01&BBS_GBN="+opener.bbs_gbn+"&SEQ_NO="+opener.seq_no;
            oFileListGDS.Reset();
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=oFileListGDS Event="OnLoadCompleted(iCount)">

        
    </Script>
    
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=oFileListGDS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=oFileListGDS Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_BOARD event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
        opener.fnc_SearchList();
        
        if (mode == "0") {
            // 구분이 신규이면
            if (opener.gbn == "1") {
                // 해당 화면 닫고, 목록 화면에서 refresh된다.
                
                fnc_Exit();
                
            }
            // 구분이 수정이면
            else if (opener.gbn == "2") {
                // 해당 화면 닫고, 내용 화면에서 refresh된다.

                fnc_Exit();
            }
        }
        
        mode = "";
        
    </script>
    
    <!--트랜젝션 실패 -->
    <script for=trT_ED_BOARD event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>
    
    <!-- 데이터를 성공적으로 가지고 온 경우 발생하는 이벤트 -->
    <script for=dsT_ED_BOARD2 event="OnLoadCompleted(iCount)">
    
        if (iCount == 0){
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            return;
        } 
        else {
            /** 데이터셋 복사 **/
            cfCopyDataSet(dsT_ED_BOARD2, dsT_ED_BOARD, "copyHeader=yes");
        }
        
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">공지사항 <span id="title"></span></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="700"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">등 록 자</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO','txtENO_NM');" onchange="fnc_GetEnoNm('txtENO_NO','txtENO_NM');" style="ime-mode:disabled">
                        <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO','txtENO_NM');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
                    <td class="padding2423" >
                        <input id="txtSUBJECT_TAG"  name="txtSUBJECT_TAG" style="width:100%"  onKeyUp="fc_chk_byte(this,40)" maxlength="40" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
                    <td class="padding2423" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="114" rows="16"  onKeyUp="fc_chk_byte(this,1000)" maxlength="4000" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >첨부파일</td>
                    <td class="padding2423" >
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',3)"><img src="/images/button/FileAddOn.gif" id="btnUPLOAD" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEL','','/images/button/FileDelOver.gif',3)">   <img src="/images/button/FileDelOn.gif" id="btnDEL"    name="btnDEL"    width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileDelete()"></a>                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="paddingTop5">
                                    <comment id="__NSID__">
                                    <object  id="grdFileListGDS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:705px;height:160px;">
                                        <param name="DataID"                  value="oFileListGDS">
                                        <param name="EdiTABLE"                value="false">
                                        <param name="DragDropEnable"          value="true">
                                        <param name="SortView"                value="Left">
                                        <param name="VIEWSUMMARY"             value=0>
                                        <param name="Format"                  value="
                                            <C> id='SEQ'          width=40    name='순번'           align=center sort=true</C>
                                            <C> id='FILE_NAME'    width=630   name='첨부파일명'     align=left   </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                            <tr>
                                <td class="paddingTop5">
                                    <comment id="__NSID__">
                                    <object  id="grdFileListGDS2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:705px;height:0px;">
                                        <param name="DataID"                  value="oFileListGDS2">
                                        <param name="EdiTABLE"                value="false">
                                        <param name="DragDropEnable"          value="true">
                                        <param name="SortView"                value="Left">
                                        <param name="VIEWSUMMARY"             value=0>
                                        <param name="Format"                  value="
                                            <C> id='SEQ'          width=40    name='순번'           align=center</C>
                                            <C> id='FILE_NAME'    width=630   name='첨부파일명'     align=left  </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
                <input type=hidden id="txtBBS_GBN">
                <input type=hidden id="txtSEQ_NO">
                <input type=hidden id="txtREF_NO">
                <input type=hidden id="txtSTEP_NO">
                <input type=hidden id="txtDEPT_NO">
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가대상자설정 테이블 -->
<object id="bndT_ED_BOARD"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_BOARD">
    <Param Name="BindInfo", Value='
        <C>Col=BBS_GBN      Ctrl=txtBBS_GBN      Param=value </C>
        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=REF_NO       Ctrl=txtREF_NO       Param=value </C>
        <C>Col=STEP_NO      Ctrl=txtSTEP_NO      Param=value </C>
        <C>Col=DEPT_NO      Ctrl=txtDEPT_NO      Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=SUBJECT_TAG  Ctrl=txtSUBJECT_TAG  Param=value </C>
        <C>Col=CONTENT_TXT  Ctrl=txtCONTENT_TXT  Param=value </C>
        <C>Col=SRCFILE1_NM  Ctrl=txtSRCFILE1_NM  Param=value </C>
        <C>Col=TGTFILE1_NM  Ctrl=txtTGTFILE1_NM  Param=value </C>
        <C>Col=SRCFILE2_NM  Ctrl=txtSRCFILE2_NM  Param=value </C>
        <C>Col=TGTFILE2_NM  Ctrl=txtTGTFILE2_NM  Param=value </C>
        <C>Col=SRCFILE3_NM  Ctrl=txtSRCFILE3_NM  Param=value </C>
        <C>Col=TGTFILE3_NM  Ctrl=txtTGTFILE3_NM  Param=value </C>
        <C>Col=SRCFILE4_NM  Ctrl=txtSRCFILE4_NM  Param=value </C>
        <C>Col=TGTFILE4_NM  Ctrl=txtTGTFILE4_NM  Param=value </C>
        <C>Col=SRCFILE5_NM  Ctrl=txtSRCFILE5_NM  Param=value </C>
        <C>Col=TGTFILE5_NM  Ctrl=txtTGTFILE5_NM  Param=value </C>
    '>
</object>


<!-- 첨부파일용 바인딩 오브젝트 -->
<object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="oFileListGDS2">
    <Param Name="BindInfo", Value='
        <C>Col=FILE_NAME    Ctrl=oFileGF     Param=Value </C>
        <C>Col=FILE_URL     Ctrl=oFileGF     Param=Value </C>
    '>
</object>
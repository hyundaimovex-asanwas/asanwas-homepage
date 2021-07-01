<!--
    ************************************************************************************
    * @Source         : edue010.jsp                                                    *
    * @Description    : 공지사항 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/14  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");
    
    boolean isMaster = false;
    boolean isSubMaster = false;
    
    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>

    <head>
    <title>공지사항(edue010)</title>
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
    
        var btnList = 'TTFTFFFT';
        
        var bbs_gbn = "3"              // 게시판구분 : 공지사항 
        var maxNum  = 0;               // 첫페이지의 가장 큰 순번
        var recNum  = 12;              // 한페이지당 보여지는 목록수
        var pagNum  = 0;               // 페이지
        var vGbn    = '';              // 검색조건 (1: 제목, 2: 내용, 3: 작성자)
        var vText   = '';              // 검색조건 내용
        var strRec  = 1;               // 시작 REC
        var endRec  = 0;               // 종료 REC
        
        var gbn     = '';
        var title   = '';
        var seq_no  = '';
        var ref_no  = '';
        var step_no = '';
        var dept_no = '';
        var eno_no  = '';
        var eno_nm  = '';
        

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var GBN     = document.getElementById("cmbGBN_SHR").value;
            var TEXT    = document.getElementById("txtTEXT_SHR").value;
            
            dsT_ED_BOARD.ClearData();
            
            if (endRec == 0) {
                endRec = recNum;
            }
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue010.cmd.EDUE010CMD&S_MODE=SHR&BBS_GBN="+bbs_gbn+"&GBN="+GBN+"&TEXT="+TEXT+"&STRREC="+strRec+"&ENDREC="+endRec;
            dsT_ED_BOARD.Reset();
            
            form1.grdT_ED_BOARD.Focus();

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

            var obj = new String();
            
            maxNum  = 0;                      // 첫페이지의 가장 큰 순번
            pagNum  = 0;                      // 페이지
            vGbn    = '';                     // 검색조건 (1: 제목, 2: 내용, 3: 작성자)
            vText   = '';                     // 검색조건 내용
            strRec  = 1;                      // 시작 REC
            endRec  = 0;                      // 종료 REC

            gbn     = "1";                // 1: 등록, 2: 수정, 3: 답변
            title   = "등록";
            seq_no  = "";
            ref_no  = "";
            step_no = "0";
            dept_no = "0";
            eno_no  = '<%=box.get("SESSION_ENONO")%>';
            eno_nm  = '<%=box.get("SESSION_ENONM")%>';

            window.showModalDialog("/hr/edu/edue011.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            maxNum  = 0;                      // 첫페이지의 가장 큰 순번
            pagNum  = 0;                      // 페이지
            vGbn    = '';                     // 검색조건 (1: 제목, 2: 내용, 3: 작성자)
            vText   = '';                     // 검색조건 내용
            strRec  = 1;                      // 시작 REC
            endRec  = 0;                      // 종료 REC
            
            document.getElementById("cmbGBN_SHR").value  = '1';
            document.getElementById("txtTEXT_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            fnc_SearchList();
            
            document.getElementById("cmbGBN_SHR").focus();

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
            cfStyleGrid(form1.grdT_ED_BOARD,0,"false","false");
            
<%
    if(!isMaster) {
%>
            fnc_HiddenElement("imgAddnew");
<%
    }
%>        
                      
            fnc_SearchList();
            
            document.getElementById("cmbGBN_SHR").focus();
            
        }
        
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
            
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
         
        function fnc_Next() {

            pagNum = pagNum + 1;
            
            strRec = (pagNum * recNum) + 1;
            endRec = (pagNum + 1) * recNum;
            
            dsT_ED_BOARD.ClearData();            
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue010.cmd.EDUE010CMD&S_MODE=SHR&BBS_GBN="+bbs_gbn+"&GBN="+vGbn+"&TEXT="+vText+"&STRREC="+strRec+"&ENDREC="+endRec;
            dsT_ED_BOARD.Reset();
            
            form1.grdT_ED_BOARD.Focus();
        }
        
        function fnc_Prev() {

            pagNum = pagNum - 1;
            
            strRec = (pagNum * recNum) + 1;
            endRec = (pagNum + 1) * recNum;
            
            dsT_ED_BOARD.ClearData();            
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue010.cmd.EDUE010CMD&S_MODE=SHR&BBS_GBN="+bbs_gbn+"&GBN="+vGbn+"&TEXT="+vText+"&STRREC="+strRec+"&ENDREC="+endRec;
            dsT_ED_BOARD.Reset();
            
            form1.grdT_ED_BOARD.Focus();
            
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_BOARD)    |
    | 3. 사용되는 Table List(T_ED_BOARD)           |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    
    <Script For=grdT_ED_BOARD Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: 등록, 2: 수정, 3: 답변
        bbs_gbn = dsT_ED_BOARD.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/edu/edue012.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        
    </Script>
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            // 이전 버튼이 보이지 않음.
            document.getElementById("view_1").style.display='none';
            document.getElementById("view_2").style.display='none'; 

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_BOARD.CountRow );
            
            if (pagNum == 0) {
                maxNum = dsT_ED_BOARD.NameValue(1, "NUM");
                
                vGbn  = document.getElementById("cmbGBN_SHR").value;
                vText = document.getElementById("txtTEXT_SHR").value;

            }

            if (maxNum == dsT_ED_BOARD.NameValue(1, "NUM")) {
                // 이전 버튼이 보이지 않음.
                document.getElementById("view_1").style.display='none';
            }
            else {
                // 이전 버튼이 보임
                document.getElementById("view_1").style.display='inline';
            }
            
            if (dsT_ED_BOARD.NameValue(dsT_ED_BOARD.CountRow, "NUM") > 1) {
                // 다음 버튼이 보임
                document.getElementById("view_2").style.display='inline';
                
            }
            else {
                // 다음 버튼이 보이지 않음
                document.getElementById("view_2").style.display='none';
            }
            
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

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
       
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">공지사항</td>
                    <td align="right" class="navigator">HOME/교육관리/과정안내신청/<font color="#000000">공지사항</font></td>
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
            <img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)" style="cursor:hand;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <tr>
                                <td class="searchState" align="left">
                                    <select id=cmbGBN_SHR>
                                        <option value="1">제목</option>
                                        <option value="2">내용</option>
                                        <option value="3">작성자</option>
                                    </select>
                                    <input id="txtTEXT_SHR" name="txtTEXT_SHR" size="50">
                                    <input type=hidden id="txtEDU_AUTHO_SHR" name="txtEDU_AUTHO_SHR">
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
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_BOARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:298px;">
                            <param name="DataID"                  value="dsT_ED_BOARD">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='ROWNM'        width=40    name='순번'           align=center </C>
                                <C> id='SUBJECT_TAG'  width=390   name='제목'           align=left   </C>
                                <C> id='ENO_NM'       width=70    name='등록자'         align=center </C>
                                <C> id='DPT_NM'       width=85    name='부서'     align=center </C>
                                <C> id='JOB_NM'       width=70    name='직위'     align=center </C>
                                <C> id='FILE_YN'      width=55    name='첨부문서'       align=center </C>
                                <C> id='UPT_YMD'      width=70    name='등록일자'       align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="right" class="paddingTop5">
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <input type=button id="btnPIRA024" value="이 전"  style="width:57pt;" onclick="fnc_Prev();">
            </div>
            <div id="view_2" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <input type=button id="btnPIRA025" value="다 음"  style="width:57pt;" onclick="fnc_Next();">
            </div>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>
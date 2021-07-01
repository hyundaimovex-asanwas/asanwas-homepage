<!--
    ************************************************************************************
    * @Source         : edud022.jsp                                                    *
    * @Description    : 묻고답하기 내용 PAGE                                           *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/14  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>묻고답하기 내용(edud022)</title>
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

        var btnList = 'FFTFFFFT';

        var opener = window.dialogArguments;

        var gbn     = '';
        var title   = '';
        var bbs_gbn = '';
        var seq_no  = '';
        var ref_no  = '';
        var step_no = '';
        var dept_no = '';
        var eno_no  = '';
        var eno_no  = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var BBS_GBN = document.getElementById('txtBBS_GBN').value;
            var SEQ_NO  = document.getElementById('txtSEQ_NO').value;

            dsT_ED_BOARD.ClearData();

            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.d.edud022.cmd.EDUD022CMD&S_MODE=SHR&BBS_GBN="+BBS_GBN+"&SEQ_NO="+SEQ_NO;
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_BOARD.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            //답글이 달려 있으면 삭제 못하게 막기
            if(dsT_ED_BOARD.NameValue(1, "IS_RE") != "0") {
                alert("게시된 글에 답글이 달려 있습니다.\n삭제하실 수 없습니다.");
                return;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("제목[" + dsT_ED_BOARD.NameValue(1,"SUBJECT_TAG") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ED_BOARD.DeleteRow(dsT_ED_BOARD.RowPosition);

            trT_ED_BOARD.action = "/servlet/GauceChannelSVL?cmd=hr.edu.d.edud022.cmd.EDUD022CMD&S_MODE=DEL";
            trT_ED_BOARD.post();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //document.getElementById("txtENO_NO").innerText = opener.eno_no;
            document.getElementById('txtENO_NM').innerText = opener.eno_nm;
            document.getElementById('txtBBS_GBN').value = opener.bbs_gbn;
            document.getElementById('txtSEQ_NO').value  = opener.seq_no;
            document.getElementById('txtREF_NO').value  = opener.ref_no;
            document.getElementById('txtSTEP_NO').value = opener.step_no;
            document.getElementById('txtDEPT_NO').value = opener.dept_no;


            // 그리드에 개인별역량평가대상자설정 데이터 조회
            fnc_SearchList();

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

        /************************************
         * 수정버튼 클릭시 수정화면 호출    *
         ************************************/
        function fnc_Modify() {

            var obj = new String();

            gbn     = "2";                // 1: 등록, 2: 수정, 3: 답변
            title   = "수정";
            bbs_gbn = opener.bbs_gbn;
            seq_no  = opener.seq_no;
            ref_no  = opener.ref_no;
            step_no = opener.step_no;
            dept_no = opener.dept_no;
            eno_no  = opener.eno_no;
            eno_no  = opener.eno_nm;

            window.showModalDialog("/hr/edu/edud021.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            opener.fnc_SearchList();

        }

        /************************************
         * 답변버튼 클릭시 답변화면 호출    *
         ************************************/
        function fnc_Reply() {

            var obj = new String();

            gbn     = "3";                // 1: 등록, 2: 수정, 3: 답변
            title   = "답변";
            bbs_gbn = opener.bbs_gbn;
            seq_no  = opener.seq_no;
            ref_no  = opener.ref_no;
            step_no = opener.step_no;
            dept_no = opener.dept_no;
            eno_no  = opener.eno_no;
            eno_no  = opener.eno_nm;

            window.showModalDialog("/hr/edu/edud021.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            opener.fnc_SearchList();

            window.close();
        }

        function fnc_link(val1, val2) {

            // 첨부 파일이 존재하는 경우만 수행하게~
            //alert(val1+",     "+val2);
            cfDownload(val1, val2);

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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID ="trT_ED_BOARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_BOARD)">
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

            // 버튼이 보이지 않음.
            document.getElementById("view_1").style.display='none';
            document.getElementById("view_2").style.display='none';

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_BOARD.CountRow );

            //document.getElementById("txtENO_NO").innerText      = 'hlc'+dsT_ED_BOARD.NameValue(1, "ENO_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_ED_BOARD.NameValue(1, "ENO_NM");
            document.getElementById("txtSUBJECT_TAG").innerText = dsT_ED_BOARD.NameValue(1, "SUBJECT_TAG");
            document.getElementById("txtCONTENT_TXT").innerText = dsT_ED_BOARD.NameValue(1, "CONTENT_TXT");
            document.getElementById("txtUPT_YMD").innerText     = dsT_ED_BOARD.NameValue(1, "UPT_YMD");

            document.getElementById("txtSRCFILE1_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE1_NM");
            document.getElementById("txtTGTFILE1_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE1_NM");
            document.getElementById("txtSRCFILE2_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE2_NM");
            document.getElementById("txtTGTFILE2_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE2_NM");
            document.getElementById("txtSRCFILE3_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE3_NM");
            document.getElementById("txtTGTFILE3_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE3_NM");
            document.getElementById("txtSRCFILE4_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE4_NM");
            document.getElementById("txtTGTFILE4_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE4_NM");
            document.getElementById("txtSRCFILE5_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE5_NM");
            document.getElementById("txtTGTFILE5_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE5_NM");

            // 삭제 및 수정권한은 등록자인 경우만 해당
            if (dsT_ED_BOARD.NameValue(1, "ENO_NO") == '<%=box.get("SESSION_ENONO")%>') {
                // 버튼이 보임
                document.getElementById("view_1").style.display='inline';
                document.getElementById("view_2").style.display='inline';
            }
            else {
                // 버튼이 보이지 보임
                document.getElementById("view_1").style.display='none';
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

        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_BOARD event="OnSuccess()">

        alert("해당 데이터가 삭제되었습니다.");

        opener.fnc_SearchList();

        window.close();

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_BOARD event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">묻고답하기 내용</td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdjust','','/images/button/btn_AdjustOver.gif',1)">    <img src="/images/button/btn_AdjustOn.gif"   name="imgAdjust"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Modify()"></a>
            </div>
            <div id="view_2" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)" onClick="fnc_Delete();"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReply','','/images/button/btn_ReplyOver.gif',1)">    <img src="/images/button/btn_ReplyOn.gif"   name="imgReply"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reply()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">등 록 자</td>
                    <td class="padding2423" >
                        <span id="txtENO_NM" name="txtENO_NM" ></span>
                    </td>
                    <td align="center" class="creamBold">등록일시</td>
                    <td class="padding2423" >
                        <span id="txtUPT_YMD" name="txtUPT_YMD" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">첨부파일</td>
                    <td class="padding2423" colspan="3">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE1_NM').innerText, document.getElementById('txtTGTFILE1_NM').value);"><span id="txtSRCFILE1_NM"  name="txtSRCFILE1_NM"></span></a>
                            <input type=hidden id="txtTGTFILE1_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE2_NM').innerText, document.getElementById('txtTGTFILE2_NM').value);"><span id="txtSRCFILE2_NM"  name="txtSRCFILE2_NM"></span></a>
                            <input type=hidden id="txtTGTFILE2_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE3_NM').innerText, document.getElementById('txtTGTFILE3_NM').value);"><span id="txtSRCFILE3_NM"  name="txtSRCFILE3_NM"></span></a>
                            <input type=hidden id="txtTGTFILE3_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE4_NM').innerText, document.getElementById('txtTGTFILE4_NM').value);"><span id="txtSRCFILE4_NM"  name="txtSRCFILE4_NM"></span></a>
                            <input type=hidden id="txtTGTFILE4_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE5_NM').innerText, document.getElementById('txtTGTFILE5_NM').value);"><span id="txtSRCFILE5_NM"  name="txtSRCFILE5_NM"></span></a>
                            <input type=hidden id="txtTGTFILE5_NM">
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtSUBJECT_TAG"  name="txtSUBJECT_TAG"></span>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423" colspan="4" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="130" rows="26" readonly></textarea>
                    </td>
                </tr>
                <input type=hidden id="txtBBS_GBN">
                <input type=hidden id="txtSEQ_NO">
                <input type=hidden id="txtREF_NO">
                <input type=hidden id="txtSTEP_NO">
                <input type=hidden id="txtDEPT_NO">
            </table>
        </td>
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
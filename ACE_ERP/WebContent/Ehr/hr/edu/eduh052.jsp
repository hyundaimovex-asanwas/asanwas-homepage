<!--
    ************************************************************************************
    * @Source         : eduh052.jsp                                                    *
    * @Description    : 담당과정운영_대상자일괄등록 PAGE                               *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>

    <head>
    <title>담당과정운영_대상자일괄등록(eduh052)</title>
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

        var btnList = 'FFFFFFFT';

        var obj = window.dialogArguments;
        var rcnt   = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_OBJTLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh052.cmd.EDUH052CMD"
                                   + "&S_MODE=SHR"
                                   + "&EDU_CD="+obj.edu_cd
                                   + "&SEQ_NO="+obj.seq_no
                                   + "&COMM_NO="+obj.comm_no;
            dsT_ED_OBJTLIST.Reset();

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

			trT_ED_OBJTLIST.KeyValue = "tr01(I:dsT_ED_OBJTLIST=dsT_ED_OBJTLIST)";
			trT_ED_OBJTLIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh052.cmd.EDUH052CMD"
                                   + "&S_MODE=SAV"
                                   + "&COMM_NO="+obj.comm_no;
			trT_ED_OBJTLIST.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            var del_cnt = 0;

            for(var i=1; i<=dsT_ED_OBJTLIST.CountRow; i++) {
                if(dsT_ED_OBJTLIST.NameString(i, "IS_PROC") == "T")
                    del_cnt++;
            }

            if(del_cnt == 0) {
                alert("삭제할 자료를 선택해 주세요.");
                return;
            }

			if(!confirm(del_cnt+"건의 정보를 삭제하시겠습니까?")){
                return;
            }

            //삭제 시킴
            for(var i=dsT_ED_OBJTLIST.CountRow; i>0; i--) {

                if(dsT_ED_OBJTLIST.NameString(i, "IS_PROC") == "T"){
	                if(dsT_ED_OBJTLIST.NameString(i, "IS_PROC_CHK") == ""){
	                    if(confirm(dsT_ED_OBJTLIST.NameString(i, "ENO_NM")+"("+dsT_ED_OBJTLIST.NameString(i, "ENO_NO")+") 실적등록이 완료되어 있는 자료입니다.\n정말 삭제하시겠습니까?")){
                            dsT_ED_OBJTLIST.DeleteRow(i);
	                    }

	                }else{
                        dsT_ED_OBJTLIST.DeleteRow(i);
	                }
                }
            }

			trT_ED_OBJTLIST.KeyValue = "tr01(I:dsT_ED_OBJTLIST=dsT_ED_OBJTLIST)";
			trT_ED_OBJTLIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh052.cmd.EDUH052CMD"
                                   + "&S_MODE=SAV"
                                   + "&COMM_NO="+obj.comm_no;
			trT_ED_OBJTLIST.post();
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

            if (dsT_ED_OBJTLIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_OBJTLIST.GridToExcel("담당과정운영_대상자리스트", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            dsT_ED_OBJTLIST.AddRow();

            dsT_ED_OBJTLIST.NameString(dsT_ED_OBJTLIST.RowPosition, "EDU_CD") = obj.edu_cd;
            dsT_ED_OBJTLIST.NameString(dsT_ED_OBJTLIST.RowPosition, "SEQ_NO") = obj.seq_no;

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

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_OBJTLIST.ClearData();

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
            fnc_DisableElementAll(elementList);

            //Grid Style 적용
            cfStyleGrid(form1.grdT_ED_OBJTLIST, 0, "true", "false");

            document.getElementById("title").innerText = obj.edu_nm + '(' + obj.edu_cd + ')';

            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_OBJTLIST.IsUpdated)
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


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtHEAD_NM").value     = obj.head_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtHEAD_NM").value     = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }



        /**
         * EXCEL 파일 업로드
         */
        function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn < 1) {
                dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){
                dsT_ED_OBJTLIST.ClearData();

                trFILE_UPLOAD.KeyValue = "tr01(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_ED_OBJTLIST=dsT_ED_OBJTLIST, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh052.cmd.EDUH052CMD"
                                       + "&S_MODE=ULD"
                                       + "&EDU_CD="+obj.edu_cd
                                       + "&SEQ_NO="+obj.seq_no;
                trFILE_UPLOAD.post();

            }

        }

        //입력 창
        var elementList = new Array( "txtENO_NO"
                                   , "txtENO_NM"
                                   , "ImgEnoNo"
                                     );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_OBJTLIST)    |
    | 3. 사용되는 Table List(T_ED_OBJTLIST)           |
    +----------------------------------------------->
    <Object ID="dsT_ED_OBJTLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 결과 DS -->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_ED_OBJTLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_OBJTLIST)">
    </Object>

    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>



    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_OBJTLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_OBJTLIST.CountRow );
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_OBJTLIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_OBJTLIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ED_OBJTLIST event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ED_OBJTLIST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trFILE_UPLOAD event="OnSuccess()">
        for(var i=1; i<=dsT_ED_OBJTLIST.CountRow; i++) {
            dsT_ED_OBJTLIST.UserStatus(i) = "1";
        }
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ED_OBJTLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //신규일 경우
            if(dsT_ED_OBJTLIST.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            }
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_ED_OBJTLIST event=CanRowPosChange(row)>
        if(row > 0) {
            if(document.getElementById("txtENO_NO").value == "") {
                alert("사번은 필수 입력사항입니다");
                return false;
            }
        }
    </script>


    <!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_ED_OBJTLIST event=OnHeadCheckClick(Col,Colid,bCheck)>
        var checkVal;
        if(bCheck == "1")
            checkVal = "T";
        else
            checkVal = "F";

        if(Colid == "IS_PROC" && dsT_ED_OBJTLIST.CountRow > 0) {
            for(var i=1; i<=dsT_ED_OBJTLIST.CountRow; i++) {
                if(dsT_ED_OBJTLIST.NameString(i, "IS_PROC") != "")
                    dsT_ED_OBJTLIST.NameString(i, "IS_PROC") = checkVal;
            }
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
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">담당과정운영_대상자일괄등록</td>
                    <td align="right" class="navigator"></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="600" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="180"></col>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <input type="hidden" id="hidEMPL_DPT_CD">
                        <input type="hidden" id="txtHEAD_NM">
                    </td>

                    <td align="center" class="creamBold">부 서</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtDPT_CD">
                    </td>
                    <td align="center" class="creamBold">직 위</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtJOB_CD">
                        <input type="hidden" id="hidCOMM_NO">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="600" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td valign="bottom"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
			            <strong>과정명 : <span id="title"></span></strong>
			        </td>
                    <td width="200" align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" width="80" height="20" border="0" align="absmiddle" onclick="cfDownload('eduh052.xls', '<%=FILEURL %>/eduh052.xls');"></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)">         <img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_OBJTLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_OBJTLIST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'           align=center    Edit=none   </C>
                                <C> id='IS_PROC'      width=20    name=''               align=center    EditStyle=CheckBox,Pointer=Hand  Edit={IF(IS_PROC='','false','true')}    CheckBoxText=IS_PROC_MSG    HeadCheckShow=true</C>
                                <C> id='HEAD_NM'      width=130   name='본부'           align=left      Edit=none   </C>
                                <C> id='DPT_NM'       width=130   name='소속'           align=left      Edit=none   </C>
                                <C> id='JOB_NM'       width=90    name='직위'           align=center    Edit=none   </C>
                                <C> id='ENO_NO'       width=80    name='사번'           align=center    Edit=none   </C>
                                <C> id='NAME'         width=90    name='성명'           align=center    Edit=none   </C>
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
<table width="600" border="0" cellspacing="0" cellpadding="0">
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


<!-- 개인정보 수정요청 테이블 -->
<object id="bndT_ED_OBJTLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_OBJTLIST">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value</C>
        <C> Col=NAME	     Ctrl=txtENO_NM       Param=value</C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value</C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value</C>
        <C> Col=HEAD_NM      Ctrl=txtHEAD_NM      Param=value</C>
    '>
</object>
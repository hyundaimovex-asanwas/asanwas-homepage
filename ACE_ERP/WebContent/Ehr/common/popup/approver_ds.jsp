<!--
***********************************************************************
* @source      : approver.jsp
* @description : 결재자정보조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/10/13      오대성        최초작성.
* 2006/11/22      한학현        엔터이벤트 추가.
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>

<%

    String gbn_cd     = request.getParameter("GBN_CD");
    String ret_cd     = request.getParameter("RET_CD");
    String str_ymd    = request.getParameter("STR_YMD");
    String end_ymd    = request.getParameter("END_YMD");
    String dpt_cd     = request.getParameter("DPT_CD");
%>

<html>

    <head>
    <title>결재자정보조회(approver)</title>
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

        var dataSet  = window.dialogArguments;
        var dataSet1 = window.dialogArguments;


        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            dsT_CM_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=common.empl.cmd.EMPLCMD&S_MODE=SHR"
                                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                                 + "&DPT_CD="+document.getElementById("txtDPT_CD_SHR").value
                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value
                                 ;
            dsT_CM_PERSON.reset();
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

            // 엑셀로 변환 할 자료가 있는지 체크하고

            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)

            // 삭제 후 해당 그리드로 Focus 이동

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

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

            cfStyleGrid(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style 적용
            form1.grdT_CM_PERSON.HiddenHScroll  = true;
            form1.grdT_CM_PERSON.DisableNoHScroll = false;

            cfStyleGrid(form1.grdT_AD_DECISION,0,"false","false");      // Grid Style 적용
            form1.grdT_AD_DECISION.HiddenHScroll  = true;
            form1.grdT_AD_DECISION.DisableNoHScroll = false;
			//권혁수 : 기안자 결재자로 자동세팅 불가
            var eno_no  = dataSet.NameValue(dataSet.countRow,"ENO_NO");
            var dpt_cd  = "<%=dpt_cd %>";
	        var gbn_cd  = "<%=gbn_cd %>";
	        var ret_cd  = "<%=ret_cd %>";
	        var str_ymd = "<%=str_ymd %>";
	        var end_ymd = "<%=end_ymd %>";

            //넘어온 사번과 구분을 저장하고
            document.getElementById("txtENO_NO").value      = eno_no;
            document.getElementById("hidGBN_CD").value      = gbn_cd;
            document.getElementById("hidRET_CD").value      = ret_cd;
            document.getElementById("hidSTR_YMD").value     = str_ymd;
            document.getElementById("hidEND_YMD").value     = end_ymd;

            //넘어온 사번으로 사원정보 검색
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO");
            if(enoObj.eno_no == "") {
                alert("신청자 정보가 없습니다.");
                window.close();
                return;
            }

            //검색조건(소속)지정
            if(dpt_cd != "") {
                document.getElementById("txtDPT_CD_SHR").value  = dpt_cd;
                fnc_GetCommNm('A4', "txtDPT_CD_SHR", "txtDPT_NM_SHR");
            } else {
                document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
                document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
            }

            //신청자 정보 추가
            document.getElementById("lblJOB_NM_A2").innerText   = enoObj.job_nm;
            document.getElementById("lblENO_NO_A2").innerText   = enoObj.eno_no;
            document.getElementById("lblENO_NM_A2").innerText   = enoObj.eno_nm;

            //신청자 정보 저장
            document.getElementById("txtENO_NO").value      = enoObj.eno_no;
            document.getElementById("txtENO_NM").value      = enoObj.eno_nm;
            document.getElementById("txtDPT_CD").value      = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM").value      = enoObj.dpt_nm;
            document.getElementById("txtJOB_CD").value      = enoObj.job_cd;
            document.getElementById("txtJOB_NM").value      = enoObj.job_nm;

            //결재선지정

            cfCopyDataSet(dataSet, dsT_AD_DECISION);
            fnc_SearchList();
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /**
         * 결재자를 선정한 후 확인을 누르면 결재자정보가 넘어감
         * (결재자가 없으면 신청자가 결재자로 넘어감)
         */
        function fnc_Confirm() {
            cfCopyDataSet(dsT_AD_DECISION, dataSet1);
            window.close();

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
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_AD_DECISION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //검색 1조건에 Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <Script For=dsT_AD_DECISION Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_AD_DECISION Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_AD_DECISION Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var i = 0;

        //중복사번체크
        for(i=1; i<=dsT_AD_DECISION.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_AD_DECISION.NameValue(i,'ENO_NO')){
                alert("해당 결재자는 이미 결재선에 포함되어 있습니다.");
                return false;
            }
        }

		if(dsT_AD_DECISION.CountRow >= 5){
			alert("결재선은 5 명 까지만 지정할수있습니다.");
			return false;
		}

        dsT_AD_DECISION.InsertRow(1);//위에서부터 넣기 위해 insert

        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ORD_NO") = dsT_AD_DECISION.NameValue(dsT_AD_DECISION.countRow,"ORD_NO");//상신자의 품의번호
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"NAM_KOR") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"AUTHO_CD") = "A"+dsT_AD_DECISION.CountRow;

    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var i = 0;

        //중복사번체크
        for(i=1; i<=dsT_AD_DECISION.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_AD_DECISION.NameValue(i,'ENO_NO')){
                alert("해당 결재자는 이미 결재선에 포함되어 있습니다.");
                return false;
            }
        }
		if(dsT_AD_DECISION.CountRow >= 5){
			alert("결재선은 5 명 까지만 지정할수있습니다.");
			return false;
		}

        dsT_AD_DECISION.InsertRow(1);//위에서부터 넣기 위해 insert

        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ORD_NO") = dsT_AD_DECISION.NameValue(dsT_AD_DECISION.countRow,"ORD_NO");//상신자의 품의번호
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"NAM_KOR") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"AUTHO_CD") = "A"+dsT_AD_DECISION.CountRow;

    </script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_AD_DECISION event=OnDblClick(row,colid)>

        var j = 0;
        var i = 0;

        // 상신자는 삭제 못한다.
        if(dsT_AD_DECISION.CountRow == row){
            alert("신청자는 결재선에서 삭제할 수 없습니다.");
            return;
        }

        dsT_AD_DECISION.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_AD_DECISION.CountRow-1; i>=1; i--){
            j++;
            dsT_AD_DECISION.NameValue(i,"AUTHO_CD") = "A"+j;
        }

    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_AD_DECISION event=OnReturn(row,colid)>

        var j = 0;
        var i = 0;

        // 상신자는 삭제 못한다.
        if(dsT_AD_DECISION.CountRow == row){
            alert("신청자는 결재선에서 삭제할 수 없습니다.");
            return;
        }

        dsT_AD_DECISION.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_AD_DECISION.CountRow-1; i>=1; i--){
            j++;
            dsT_AD_DECISION.NameValue(i,"AUTHO_CD") = "A"+j;
        }

    </script>




<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재자정보조회</td>
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
                                    <td align="center" class="searchState">사원 번호/성명&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">

                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">

                                        <input type="hidden" id="txtENO_NO">
                                        <input type="hidden" id="txtENO_NM">
                                        <input type="hidden" id="txtDPT_CD">
                                        <input type="hidden" id="txtDPT_NM">
                                        <input type="hidden" id="txtJOB_CD">
                                        <input type="hidden" id="txtJOB_NM">
                                    </td>

                                    <td align="center" class="searchState">소속&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:144px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           width=100  name=본부   align=left   </C>
                                    <C> id=DPT_NM            width=90   name=소속   align=left   </C>
                                    <C> id=JOB_NM            width=80   name=직위   align=left   </C>
                                    <C> id=ENO_NO            width=80   name=사번   align=center show=false</C>
                                    <C> id=ENO_NM            width=159   name=성명   align=center </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">※ 해당항목을 더블클릭 하시면 선택됩니다.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 내용 조회 그리드 데이블 끝-->

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>결재선</strong>
	        </td>
	    </tr>
	    <tr>
	        <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_AD_DECISION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:144px;">
                                <param name="DataID"            value="dsT_AD_DECISION">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=AUTHO_CD          width=39    name=NO     align=center   </C>
                                    <C> id=DPT_NM            width=110   name=소속   align=left     </C>
                                    <C> id=JOB_NM            width=80    name=직위   align=center   </C>
                                    <C> id=ENO_NO            width=100   name=사번   align=center   show=false</C>
                                    <C> id=NAM_KOR           width=200   name=성명   align=center   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">※ 해당항목을 더블클릭 하시면 삭제됩니다.</span></td>
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
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">신청자</td>
                        <td align="center" class="creamBold">직위</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="creamBold">사번</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="creamBold">성명</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    </form>
    <!-- form 끝 -->

</body>
</html>
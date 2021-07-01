<!--
    ************************************************************************************
    * @Source         : eduk010.jsp                                                    *
    * @Description    : 부서별 연간 교육신청 현황 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/08  |  박인이   | 최초작성                                               *
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
    <title>부서별 연간 교육신청 현황(eduk010)</title>
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

        var btnList = 'TFFTTFFT';
        
        var gbn     = "";
        var pis_yy  = "";
        var dpt_cd  = "";
        var ord_no = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var YEAR      = document.getElementById("txtYEAR_SHR").value;
            var DPT_CD    = document.getElementById("txtDPT_CD").value;


            dsT_ED_CHASULIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk020.cmd.EDUK020CMD"
                                    + "&S_MODE=SHR"
                                    + "&YEAR="+YEAR
                                    + "&DPT_CD="+DPT_CD;
            dsT_ED_CHASULIST.Reset();

            form1.grdT_ED_CHASULIST.Focus();

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

            var ENO_NO  = dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"ENO_NO");
            var STR_YMD = dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"STR_YMD");

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("해당과정 [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_CD") + "] [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + "], 학습자 [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"ENO_NM") + "] 자료의 신청을 취소하시겠습니까?") == false) return;

            dsT_ED_CHASULIST.DeleteRow(dsT_ED_CHASULIST.RowPosition);

            trT_ED_CHASULIST.KeyValue = "SVL(I:dsT_ED_CHASULIST=dsT_ED_CHASULIST)";
            trT_ED_CHASULIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk020.cmd.EDUK020CMD&S_MODE=DEL";
            trT_ED_CHASULIST.post();

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

            if (dsT_ED_CHASULIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_CHASULIST.GridToExcel("연간교육계획", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            gbn     = "1";        // 1: 신규, 2: 수정
	        pis_yy      = document.getElementById("txtYEAR_SHR").value;
            dpt_cd    = document.getElementById("txtDPT_CD").value;
	        ord_no = "";


            url = "/hr/edu/eduk021.jsp";
            window.showModalDialog(url, self, "dialogHeight:500px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            document.getElementById("txtYEAR_SHR").value     = getToday().substr(0,4);
            document.getElementById("txtDPT_CD").value   = '';
            document.getElementById("txtDPT_NM").value   = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_CHASULIST.ClearData();

            document.getElementById("txtYEAR_SHR").focus();

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
            //cfStyleGrid(form1.grdT_ED_CHASULIST,0,"false","false");
            cfStyleGrid2(form1.grdT_ED_CHASULIST);
            form1.grdT_ED_CHASULIST.IndWidth = 0;

            document.getElementById("txtYEAR_SHR").value = getToday().substr(0,4);



<%
    //관리자가 아니면 다른 부서로 조회가 되지 않게
    if(!isMaster && !isSubMaster) {
%>
            document.getElementById("txtDPT_CD").value = '<%=box.get("SESSION_DPTCD")%>';
            document.getElementById("txtDPT_NM").value = '<%=box.get("SESSION_DPTNM")%>';

            fnc_ChangeStateElement(false, "txtDPT_CD");
            fnc_ChangeStateElement(false, "txtDPT_NM");
            fnc_ChangeStateElement(false, "ImgTraDptCd");
<%
    }
%>

            document.getElementById("txtYEAR_SHR").focus();

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


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_CHASULIST)|
    | 3. 사용되는 Table List(T_ED_CHASULIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_EDUCATION)|
    | 3. 사용되는 Table List(T_CM_EDUCATION)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_CHASULIST)">
    </Object>

    <!-----------------------------------------------------+
    | 1. 카피용 DataSet							           |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_CHASULIST)		   |
    | 3. 사용되는 Table List(T_ED_CHASULIST) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_ED_CHASULIST_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-- 교육주관 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육분야 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_CHASULIST Event="OnDblClick(row, col)">
        // 교육이력
        gbn     = "2";        // 1: 신규, 2: 수정
        pis_yy = dsT_ED_CHASULIST.NameValue(row, "PIS_YY");
        dpt_cd = dsT_ED_CHASULIST.NameValue(row, "DPT_CD");
        ord_no = dsT_ED_CHASULIST.NameValue(row, "ORD_NO");
        
		window.showModalDialog("/hr/edu/eduk021.jsp", self, "dialogWidth:860px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");


    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_CHASULIST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_CHASULIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_CHASULIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">부서별 연간 교육신청 현황</td>
                    <td align="right" class="navigator">HOME/교육관리/나의학습정보/<font color="#000000">부서별 연간 교육신청 현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
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
			            	<colgroup>
			                	<col width="100"></col>
			                    <col width="120"></col>
			                    <col width="40"></col>
			                    <col width="150"></col>
			                    <col width="90"></col>
			                    <col width=""></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">

                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtYEAR_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>

                                </td>
                                <td align="right" class="searchState">부서&nbsp;</td>
                                <td class="padding2423">
	                                <input id="txtDPT_CD" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13){fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');}"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');">
									<input id="txtDPT_NM" size="12" class="input_ReadOnly"  readonly>
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
			                        	<img src="/images/button/btn_HelpOn.gif" id="ImgTraDptCd" name="ImgTraDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','소속','DEPT')">
			                       	</a>
                                </td>
                                <!--
                                <td align="right" class="searchState">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                -->
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
                        <object    id="grdT_ED_CHASULIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_CHASULIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="ColSelect"  				value="true">
                            <param name="Format"                  value="
                            	<C> id='{currow}'       width=30        name='NO'       align=center </C>
                                <FC> id='INT_NAM'       width=120   name='교육기관'         align=left  suppress = '1' </FC>
                                <FC> id='EDU_NM'       width=120   name='과정명'         align=left  suppress = '1' </FC>
                                <C>  id='SHAPE_NM'     width=80    name='교육형태'           align=center </C>
                                <C>  id='STR_YMD'     width=160   name='학습시작일'       align=center </C>
                                <C>  id='END_YMD'     width=160   name='학습종료일'       align=center </C>
                                <C>  id='TIME_NO'       width=80    name='시간'         align=center </C>
                                <C>  id='COST_AMT'     width=80    name='비용'           align=center </C>
                                <C>  id='INS_NM'       width=80    name='고용보험;환급여부'         align=center </C>
                                <C>  id='JOB_NM'       width=80    name='직위'         align=center </C>
                                <C>  id='DUTY_TXT'       width=80    name='담당직무'         align=center </C>
                                <C>  id='ENO_NM'       width=80    name='대상자'         align=center </C>
                                <C>  id='DUTY_REL_NM'       width=80    name='직무관련성'         align=center </C>
                                <C>  id='GOAL_TAG'       width=80    name='업무목표'         align=center </C>
                                <C>  id='EFFECT_TAG'      width=80    name='기대효과'     align=center </C>
                                <C>  id='NOTE_TAG'  width=55    name='비고'       align=center </C>

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

</form>
<!-- form 끝 -->

</body>
</html>
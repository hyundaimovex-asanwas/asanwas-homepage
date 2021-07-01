<!--
    ************************************************************************************
    * @Source         : edue032.jsp                                              
    * @Description    : 개설요청과정교육신청서 PAGE                         
    * @Developer Desc :                                                          
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                  
    *-------------+-----------+--------------------------------------------------------+
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/23  |  정영식   | 소스이전                                     
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>

    <head>
    <title>개설요청 과정교육신청서</title>
    <jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        var opener = window.dialogArguments;
        
        var flag   = '';                       // 0: 조회, 1: 저장/삭제

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_RQSTOBJTLIST.ClearData();
            dsT_ED_OPENRQST.ClearData();

            flag = '0';

            trT_ED_CHASULIST.KeyValue = "SVL(O:SHR=dsT_ED_OPENRQST, O:SHR2=dsT_ED_RQSTOBJTLIST, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue021.cmd.EDUE021CMD&S_MODE=SHR&ORD_NO="+opener.ord_no;
            trT_ED_CHASULIST.post();

            form1.grdT_CM_EDUCATION.Focus();

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

            if(fnc_SaveItemCheck()) {

                flag = '1';

                // 해당 교육과정이 마감되었는지 CHECK
                dsT_ED_OPENRQST.UseChangeInfo = false;

                trT_ED_CHASULIST.KeyValue = "SVL(I:SAV=dsT_ED_OPENRQST, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
                trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue021.cmd.EDUE021CMD&S_MODE=SAV&DPT_CD="+dsVI_T_PERSON.NameValue(0,"DPT_CD")+"&JOB_CD="+dsVI_T_PERSON.NameValue(0,"JOB_CD")+"&ORD_NO="+opener.ord_no;
                trT_ED_CHASULIST.post();

                dsT_ED_OPENRQST.UseChangeInfo = true;

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = dsT_ED_OPENRQST.NameValue(1, "CHK_YN");

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_OPENRQST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("해당과정 [" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"EDU_CD") + "] [" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"EDU_NM") + "] 신청을 취소하시겠습니까?") == false) return;

            if (status == "Y")    {

                flag = '1';

                dsT_ED_RQSTOBJTLIST.DeleteRow(dsT_ED_RQSTOBJTLIST.RowPosition);

                trT_ED_CHASULIST.KeyValue = "SVL(I:DEL=dsT_ED_RQSTOBJTLIST)";
                trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue021.cmd.EDUE021CMD&S_MODE=DEL";
                trT_ED_CHASULIST.post();
            }
            else {
                flag = '';
                document.getElementById("Message").innerText = '* 신청하지 않은 교육과정은 신청취소할 수 없습니다.';
                return;
            }

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

            if (dsT_ED_RQSTOBJTLIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("개설요청강좌신청서", '', 225);

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

          //  fnc_Delete();

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

            var f = document.form1;

            // 확인 CHECK
            if( document.getElementById("chkCHECK").checked == false ) {
                alert("신청하시기 전에 확인란을 체크하여 주십시오.");
                document.getElementById("chkCHECK").focus();
                return false;
            }

            if(dsT_DI_APPROVAL.CountRow < 1){
				alert("결재선을 하나이상 지정해 주십시요");
				return false;
			}

            if (dsT_ED_OPENRQST.NameValue(1, "CHK_YN") == "Y") {
                alert("이미 신청하신 교육과정입니다.");
                document.getElementById("Message").innerText = '* 해당 교육과정은 신청되었습니다.';
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_CM_EDUCATION,0,"false","false");
            
            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");
            
            dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// 근태날짜
	                            "GUN_GBN:STRING(1),"+			// 근태결재구분
								"DPT_CD:STRING(6),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"SEQ_NO:STRING(1),"+			// 결재선
								"ENO_NO:STRING(10),"+			// 결재자사번
								"JOB_CD:STRING(10),"+			// 결재자직위
								"APP_TIME:STRING(10),"+			// 결재시간
								"PENO_NO:STRING(10),"+			// 상신자사번
								"APP_YN:STRING(10),"+			// 결재여부
								"ENO_NM:STRING(10),"+			// 결재자명
								"JOB_NM:STRING(10)"				// 직위명
								);
            
            
            //개인정보 불러오기 추가  ( 직위, 소속   때문에 사용함.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            
            dsVI_T_PERSON.reset();

            

            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;
            document.getElementById("txtDPT_NM").value = dsVI_T_PERSON.NameValue(0,"DPT_NM");;
            document.getElementById("txtJOB_NM").value = dsVI_T_PERSON.NameValue(0,"JOB_NM");

            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_OPENRQST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList();

            window.close();

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
         //결재선지정
		function fnc_Approval(){

         	var STR_YMD_SHR = "";
			var END_YMD_SHR = "";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			var EMP_NO      = gusrid;
			var COST = dsT_ED_OPENRQST.NameValue(1, "COST_AMT");

			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"M",COST);

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");	//결재선(결재순서)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// 일별 근태에서 결재자 뜨지 않게 하기위해서...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = gusrid;	//상신자 사번
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "M";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
            }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EDUCATION) |
    | 3. 사용되는 Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_RQSTOBJTLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_CHASULIST) |
    | 3. 사용되는 Table List(T_ED_CHASULIST)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_OPENRQST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_OPENRQST)">
    </Object>
    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)			 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
      <!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)							       |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
	</Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_RQSTOBJTLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_RQSTOBJTLIST.CountRow );

        }

    </Script>
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {


        } else {

            //fnc_HiddenElement("imgSave");
            //fnc_HiddenElement("imgReport");
            fnc_HiddenElement("ImgSelectapproval");

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_RQSTOBJTLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_RQSTOBJTLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_OPENRQST Event="OnLoadCompleted(iCount)">

        if (dsT_ED_OPENRQST.NameValue(1, "CHK_YN") != "Y")    {

            document.getElementById("Message").innerText = '* 해당 교육과정을 신청하실 수 있습니다.';
            document.getElementById("chkCHECK").checked = false;
            document.getElementById("chkCHECK").disabled = false;
            document.getElementById("chkCHECK").focus();

        } else {

            document.getElementById("Message").innerText = '* 해당 교육과정은 신청되었습니다.';
            document.getElementById("chkCheck").checked = true;
            document.getElementById("chkCheck").disabled = true;

        }

        document.getElementById("txtEDU_TXT").value      = dsT_ED_OPENRQST.NameValue(1, "EDU_TXT");
        document.getElementById("txtEDU_STR_YMD").value = dsT_ED_OPENRQST.NameValue(1, "EDU_STR_YMD");
        document.getElementById("txtEDU_END_YMD").value = dsT_ED_OPENRQST.NameValue(1, "EDU_END_YMD");

        document.getElementById("txtEDU_GBN_TXT").value     = dsT_ED_OPENRQST.NameValue(1, "EDU_GBN_TXT");
        document.getElementById("txtPLACE_TXT").value   = dsT_ED_OPENRQST.NameValue(1, "PLACE_TXT");
        form1.medCOST_AMT.text                          = dsT_ED_OPENRQST.NameValue(1, "COST_AMT");
        document.getElementById("txtFIX_NO").value      = dsT_ED_OPENRQST.NameValue(1, "FIX_NO");
        document.getElementById("txtREQ_CNT").value      = dsT_ED_OPENRQST.NameValue(1, "REQ_CNT");
        document.getElementById("txtCONTENT_TXT").value = dsT_ED_OPENRQST.NameValue(1, "CONTENT_TXT");
        document.getElementById("txtINS_NM").value      = dsT_ED_OPENRQST.NameValue(1, "INS_NM");
        form1.medRTN_AMT.text                           = dsT_ED_OPENRQST.NameValue(1, "RTN_AMT");

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ED_CHASULIST event="OnSuccess()">

        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ED_CHASULIST event="OnFail()">

        cfErrorMsg(this);
        flag = '';

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
        <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">개설요청과정교육신청서</td>
                    <td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">개설요청과정교육신청서</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">   <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="Message">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >교육과정</td>
                    <td class="padding2423" align="left">
						<input id="txtEDU_TXT" name="txtEDU_TXT" size="19" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="blueBold">교육기간</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                    </td>
                    <td class="padding2423" colspan="2" rowspan="4">
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
							<tr><td align="right">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()"></a>
							</td></tr>
                    		<tr><td class="padding2423">
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:250px;height:100px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'	width=40	name='등록번호'	align=center	show=false</C>
	            					<C> id='SEQ_NO'	width=30	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=80	name='부서'		align=center	</C>
									<C> id='JOB_NM'	width=60	name='직위'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='사번'		align=center	show=false</C>
									<C> id='ENO_NM'	width=60	name='성명'		align=center	</C>
									<C> id='APP_YN'	width=70	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')} show=false</C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td></tr>
						</table>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="blueBold">교육기관</td>
                    <td class="padding2423" >
                        <input id="txtEDU_GBN_TXT" name="txtEDU_GBN_TXT" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">교육비용</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423">
                        <input id="txtPLACE_TXT" name="txtPLACE_TXT" maxlength="50" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">인&nbsp;&nbsp;&nbsp;&nbsp;원</td>
                    <td class="padding2423">
                        <input id="txtREQ_CNT" name="txtREQ_CNT" maxlength="20" style="width:70;text-align:right;" class="input_ReadOnly" readonly>
                        / <input id="txtFIX_NO" name="txtFIX_NO" maxlength="20" style="width:70;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육내용</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="70" rows="3" maxlength="300"  class="input_ReadOnly" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">환급여부</td>
                    <td class="padding2423">
                        <input id="txtINS_NM" name="txtINS_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">환급예상액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="blueBold">&nbsp;</td>
                    <td class="padding2423">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">신 청 자</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtENO_NO" size="10" maxlength="8" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                        &nbsp;&nbsp;&nbsp;부서 <input id="txtDPT_NM" size="20" class="input_ReadOnly" readonly>
                        &nbsp;&nbsp;직위 <input id="txtJOB_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="padding2423" colspan="6">
                        해당 교육강좌를 신청합니다. <input type="checkbox" id="chkCHECK"  name="chkCHECK">확인&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
                            <param name="DataID"                  value="dsT_ED_RQSTOBJTLIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     		width=40    	name='순번'         	align=center </C>
                                <C> id='EDU_STR_YMD'  	width=150    	name='시작일자'     	align=center </C>
                                <C> id='EDU_END_YMD'  	width=150    	name='종료일자'     	align=center </C>
                                <C> id='ENO_NO'       		width=80    	name='사번'     		align=center </C>
                                <C> id='ENO_NM'       		width=80    	name='성명'         	align=center </C>
                                <C> id='DPT_NM'       		width=180    	name='부서'         	align=center </C>
                                <C> id='JOB_NM'       		width=90    	name='직위'         	align=center </C>
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

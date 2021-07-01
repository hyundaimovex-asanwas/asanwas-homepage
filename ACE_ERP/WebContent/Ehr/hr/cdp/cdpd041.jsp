<!--
    ************************************************************************************
    * @Source         : cdpd041.jsp                                                    *
    * @Description    : 멘토링 보고서등록 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/26  |  박인이   | 최초작성                                               *
    * 2007/04/17  |  김학수   | 인쇄추가                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>개별 O.J.T. 지도 평가서(cdpd041)</title>
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

        var btnList = 'TFFTFTFT';

        var opener = window.dialogArguments;
        var flag   = '';                       // 0: 조회, 1: 저장/삭제

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO  = opener.eno_no;

            flag = '0';

            dsT_CD_OJT.ClearData();

            dsT_CD_OJT.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd041.cmd.CDPD041CMD&S_MODE=SHR&ENO_NO="+ENO_NO;
            dsT_CD_OJT.Reset();

            form1.grdT_CD_OJTEVAL.Focus();

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

            	if(confirm("확인을 선택하여 평가를 완료하시면 경영지원본부로 결과가 전달됩니다. \n취소를 선택하시면 저장한 후 평가서를 계속 수정하실 수 있습니다."))

                flag = '1';
                var ENO_NO    = opener.eno_no;
                var SAV_TYPE;
				var TOTAL_SCORE1 = 0;
				var TOTAL_SCORE2 = 0;

                for(var i=1; i<=dsT_CD_OJTEVAL.CountRow; i++) {
                	TOTAL_SCORE1 += dsT_CD_OJTEVAL.NameValue(i, "SCORE_A1");
                	TOTAL_SCORE2 += dsT_CD_OJTEVAL.NameValue(i, "SCORE_A2");
                }

                if(document.getElementById("txtCHA1_ENO_NO").value == "<%=box.get("SESSION_ENONO")%>"){
					SAV_TYPE = "A1";
					dsT_CD_OJTRPT.NameValue(1, "TOTAL_SCORE1") = TOTAL_SCORE1;
				} else
				if(document.getElementById("txtCHA2_ENO_NO").value == "<%=box.get("SESSION_ENONO")%>"){
					SAV_TYPE = "A2";
					dsT_CD_OJTRPT.NameValue(1, "TOTAL_SCORE2") = TOTAL_SCORE2;
				}

                trT_CD_OJT.KeyValue = "SVL(I:SAV_01=dsT_CD_OJTRPT, I:SAV_02=dsT_CD_OJTEVAL)";
                trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd041.cmd.CDPD041CMD&S_MODE=SAV&ENO_NO="+ENO_NO+"&SAV_TYPE="+SAV_TYPE;
                trT_CD_OJT.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            var ENO_NO    = opener.eno_no;
            var SEQ_NO    = opener.seq_no;

            var url = "cdpd041_PV.jsp?ENO_NO="+ENO_NO+"&SEQ_NO="+SEQ_NO;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");


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
        function fnc_AddNew(gubun) {

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

            var f = document.form1;

            //DataSet의 변경 여부 확인
            if (!dsT_CD_OJTRPT.IsUpdated && !dsT_CD_OJTEVAL.IsUpdated) {
            	alert("* 저장할 내용이 없습니다.");
                //document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//Grid Style 적용
            cfStyleGrid(form1.grdT_CD_OJTEVAL,0,"true","false");

            fnc_SearchList();
            document.getElementById("resultMessage").innerText = "* 해당 평가기준의 배점 점수를 더블클릭 하세요.";
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJTRPT.IsUpdated || dsT_CD_OJTEVAL.IsUpdated )
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
		function Right(str, n){
		  if (n <= 0)
		     return "";
		  else if (n > String(str).length)
		     return str;
		  else {
		     var iLen = String(str).length;
		     return String(str).substring(iLen, iLen - n);
		  }
		}

		function Left(str, n){
			if (n <= 0)
			  return "";
			else if (n > String(str).length)
			  return str;
			else
			  return String(str).substring(0,n);
		}



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

   <!-----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                      |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_OJTRESULT)|
    | 3. 사용되는 Table List(T_CD_OJTRESULT)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTRPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   <!-----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                      |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_OJTRESULT)|
    | 3. 사용되는 Table List(T_CD_OJTRESULT)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTEVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_OJT)     |
    | 3. 사용되는 Table List(T_CD_OJT)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CD_OJT                        |
    | 3. Table List : T_CD_OJT                    |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_OJT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
	<Script For=grdT_CD_OJTEVAL Event="OnDblClick(row, col)">
	    if(Left(col, 8)=="QUESTION") {
	    	if(document.getElementById("txtCHA1_ENO_NO").value == "<%=box.get("SESSION_ENONO")%>"){
				dsT_CD_OJTEVAL.NameValue(row, "SCORE_A1")= dsT_CD_OJTEVAL.NameValue(row, col);
				dsT_CD_OJTEVAL.NameValue(row, "ANSWER_A1")= Right(col, 1);
			} else
			if(document.getElementById("txtCHA2_ENO_NO").value == "<%=box.get("SESSION_ENONO")%>"){
				dsT_CD_OJTEVAL.NameValue(row, "SCORE_A2")= dsT_CD_OJTEVAL.NameValue(row, col);
				dsT_CD_OJTEVAL.NameValue(row, "ANSWER_A2")= Right(col, 1);
			}
		}
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTRPT Event="OnLoadCompleted(iCount)">

		var SAV_TYPE;
		if(document.getElementById("txtCHA1_ENO_NO").value == "<%=box.get("SESSION_ENONO")%>"){
			SAV_TYPE = "A1";
		} else
		if(document.getElementById("txtCHA2_ENO_NO").value == "<%=box.get("SESSION_ENONO")%>"){
			SAV_TYPE = "A2";
			document.getElementById("txtEVAL_ENO_NO2").value = document.getElementById("txtCHA2_ENO_NO").value;
			document.getElementById("txtEVAL_ENO_NM2").value = document.getElementById("txtCHA2_ENO_NM").value;
		}

        if (iCount == 0)    {

			dsT_CD_OJTRPT.AddRow();

            if(SAV_TYPE == "A1"){
				dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "ENO_NO") = opener.eno_no;
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_STEP") = SAV_TYPE;
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_ENO_NO1") = "<%=box.get("SESSION_ENONO")%>";
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_ENO_NM1") = "<%=box.get("SESSION_ENONM")%>";
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_YMD1") = getToday();
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "COMPLETE_YN1") = "N";
			} else
			if(SAV_TYPE == "A2"){
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "ENO_NO") = opener.eno_no;
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_STEP") = SAV_TYPE;
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_ENO_NO2") = "<%=box.get("SESSION_ENONO")%>";
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_ENO_NM2") = "<%=box.get("SESSION_ENONM")%>";
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "EVAL_YMD2") = getToday();
	        	dsT_CD_OJTRPT.NameValue(dsT_CD_OJTRPT.RowPosition, "COMPLETE_YN2") = "N";
			}

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

        	if(SAV_TYPE == "A1" && ( dsT_CD_OJTRPT.NameValue(iCount, "EVAL_YMD1") == null
        			|| dsT_CD_OJTRPT.NameValue(iCount, "EVAL_YMD1") == "") ){
				dsT_CD_OJTRPT.NameValue(iCount, "ENO_NO") = opener.eno_no;
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_STEP") = SAV_TYPE;
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_ENO_NO1") = "<%=box.get("SESSION_ENONO")%>";
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_ENO_NM1") = "<%=box.get("SESSION_ENONM")%>";
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_YMD1") = getToday();
	        	dsT_CD_OJTRPT.NameValue(iCount, "COMPLETE_YN1") = "N";
			} else
			if(SAV_TYPE == "A2" && ( dsT_CD_OJTRPT.NameValue(iCount, "EVAL_YMD2") == null
        			|| dsT_CD_OJTRPT.NameValue(iCount, "EVAL_YMD2") == "") ){
	        	dsT_CD_OJTRPT.NameValue(iCount, "ENO_NO") = opener.eno_no;
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_STEP") = SAV_TYPE;
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_ENO_NO2") = "<%=box.get("SESSION_ENONO")%>";
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_ENO_NM2") = "<%=box.get("SESSION_ENONM")%>";
	        	dsT_CD_OJTRPT.NameValue(iCount, "EVAL_YMD2") = getToday();
	        	dsT_CD_OJTRPT.NameValue(iCount, "COMPLETE_YN2") = "N";
			}

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJTRPT.CountRow );

        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTRPT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTRPT Event="OnDataError()">

        cfErrorMsg(this);

    </Script>
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTEVAL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJTRPT.CountRow );

        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTEVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTEVAL Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">

        var ENO_NO  = opener.eno_no;

        if (iCount > 0) {
            trT_CD_OJT.KeyValue = "tr01(O:SHR_00=dsT_CD_OJTRPT, O:SHR_01=dsT_CD_OJTEVAL)";
            trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd041.cmd.CDPD041CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO;
            trT_CD_OJT.post();

        }
    </Script>
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTEVAL Event="OnLoadCompleted(iCount)">

        grdT_CD_OJTEVAL.RowHeight = "34";
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CD_OJT event="OnSuccess()">

        // 저장인 경우 재조회
        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CD_OJT event="OnFail()">

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
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개별 O.J.T. 지도 평가서</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
   <!--          <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">   <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                	<col width="90"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                	<td align="center" class="creamBold">대상자</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <!--
                <tr>
                	<td align="center" class="creamBold">책임지도사원</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                -->
                <tr>
                	<td align="center" class="creamBold">1차평가자</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtCHA1_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtCHA1_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtDPT1_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT1_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtJOB1_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB1_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">2차평가자</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtCHA2_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtCHA2_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtDPT2_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT2_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtJOB2_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB2_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">기간</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                        ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">부서</td>
                    <td class="padding2423">
                    	<input id="txtTRA_DPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_DPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">입사일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" name="txtHIR_YMD" size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">담당팀장</td>
                    <td class="padding2423">
                    	<input id="txtHEAD_EMP_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtHEAD_EMP_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423" colspan="3">
						<input id="txtTRA_DUTY" size="53" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                   <!--  <td align="center" class="creamBold">중점지도사항</td>
                    <td class="padding2423" colspan="5">
                    	<textarea id="txtEDU_POINT"  name="txtEDU_POINT" cols="112" rows="5" maxlength="4000" class="input_ReadOnly" readonly></textarea>
                    </td>   -->
                    <td align="center" class="creamBold">교육목표</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtEDU_GOAL1" size="110" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL2" size="110" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL3" size="110" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->


<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="30%" class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>평가</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span align="absmiddle" id="resultMessage">&nbsp;</span>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3" >
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_OJTEVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:285px;">
                            <param name="DataID"                  value="dsT_CD_OJTEVAL">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=1>
                            <param name="Format"                  value="
                                <C> id='CTGRY_DESC'     width=100    name='구분'     sumtext='합계'     align=center  edit=none suppress=1</C>
                                <C> id='ITEM_DESC'      width=320   name='평가기준'              align=left  edit=none  Multiline=true wordwrap=word scroll=vert </C>
                                <G> name='배점' HeadBgColor='#F7DCBB'
                                <C> id='QUESTION1'      width=50   name='A'  align=center  edit=none   </C>
                                <C> id='QUESTION2'      width=50   name='B'  align=center  edit=none   </C>
                                <C> id='QUESTION3'      width=50   name='C'  align=center  edit=none   </C>
                                <C> id='QUESTION4'      width=50   name='D'  align=center  edit=none   </C>
                                <C> id='QUESTION5'      width=50   name='E'  align=center  edit=none   </C>
                                </G>
                                <G> name='점수' HeadBgColor='#F7DCBB'
                                <C> id='SCORE_A1'      width=50   name='1차'      align=center  edit=none  sumtext=@sum </C>
                                <C> id='SCORE_A2'      width=50   name='2차'      align=center  edit=none  sumtext=@sum </C>
                                </G>
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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90"></col>
                    <col width="70"></col>
                    <col width="215"></col>
                    <col width="70"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">1차<br>평가</td>
                    <td align="center" class="creamBold">평가자</td>
                    <td class="padding2423">
                    	<input id="txtEVAL_ENO_NO1" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtEVAL_ENO_NM1" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">평가일</td>
                    <td class="padding2423">
                        <input id="txtEVAL_YMD1" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">의견</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtOPINION1"  name="txtOPINION1" cols="112" rows="4" maxlength="4000"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">2차<br>평가</td>
                    <td align="center" class="creamBold">평가자</td>
                    <td class="padding2423">
                    	<input id="txtEVAL_ENO_NO2" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtEVAL_ENO_NM2" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">평가일</td>
                    <td class="padding2423">
                        <input id="txtEVAL_YMD2" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">의견</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtOPINION2"  name="txtOPINION2" cols="112" rows="4" maxlength="4000"></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 기본정보 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        	 Ctrl=txtENO_NO        		Param=value </C>
        <C> Col=ENO_NM        	 Ctrl=txtENO_NM        		Param=value </C>
        <C> Col=DPT_CD        	 Ctrl=txtDPT_CD        		Param=value </C>
        <C> Col=DPT_NM        	 Ctrl=txtDPT_NM        		Param=value </C>
        <C> Col=JOB_CD        	 Ctrl=txtJOB_CD        		Param=value </C>
        <C> Col=JOB_NM        	 Ctrl=txtJOB_NM        		Param=value </C>

        <C> Col=CHA1_ENO_NO      Ctrl=txtCHA1_ENO_NO       	Param=value </C>
        <C> Col=CHA1_ENO_NM      Ctrl=txtCHA1_ENO_NM       	Param=value </C>
        <C> Col=DPT1_CD       	 Ctrl=txtDPT1_CD       		Param=value </C>
        <C> Col=DPT1_NM       	 Ctrl=txtDPT1_NM       		Param=value </C>
        <C> Col=JOB1_CD       	 Ctrl=txtJOB1_CD       		Param=value </C>
        <C> Col=JOB1_NM       	 Ctrl=txtJOB1_NM       		Param=value </C>

        <C> Col=CHA2_ENO_NO      Ctrl=txtCHA2_ENO_NO       	Param=value </C>
        <C> Col=CHA2_ENO_NM      Ctrl=txtCHA2_ENO_NM       	Param=value </C>
        <C> Col=DPT2_CD       	 Ctrl=txtDPT2_CD       		Param=value </C>
        <C> Col=DPT2_NM       	 Ctrl=txtDPT2_NM       		Param=value </C>
        <C> Col=JOB2_CD       	 Ctrl=txtJOB2_CD       		Param=value </C>
        <C> Col=JOB2_NM       	 Ctrl=txtJOB2_NM       		Param=value </C>

        <C> Col=STR_YMD       	 Ctrl=txtSTR_YMD       		Param=value </C>
        <C> Col=END_YMD       	 Ctrl=txtEND_YMD       		Param=value </C>

        <C> Col=TRA_DPT_CD       Ctrl=txtTRA_DPT_CD        	Param=value </C>
        <C> Col=TRA_DPT_NM       Ctrl=txtTRA_DPT_NM        	Param=value </C>
        <C> Col=HIR_YMD       	 Ctrl=txtHIR_YMD       		Param=value </C>
        <C> Col=TRA_DUTY         Ctrl=txtTRA_DUTY        	Param=value </C>
        <C> Col=HEAD_EMP_NO      Ctrl=txtHEAD_EMP_NO        Param=value </C>
        <C> Col=HEAD_EMP_NM      Ctrl=txtHEAD_EMP_NM        Param=value </C>

        <C> Col=EDU_GOAL1        Ctrl=txtEDU_GOAL1        	Param=value </C>
        <C> Col=EDU_GOAL2        Ctrl=txtEDU_GOAL2        	Param=value </C>
        <C> Col=EDU_GOAL3        Ctrl=txtEDU_GOAL3        	Param=value </C>
        <C> Col=EDU_POINT        Ctrl=txtEDU_POINT        	Param=value </C>
    '>
</object>
<!-- 평가정보 테이블 -->
<object id="mxBnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJTRPT">
    <Param Name="BindInfo", Value='
        <C> Col=EVAL_ENO_NO1        Ctrl=txtEVAL_ENO_NO1        Param=value </C>
        <C> Col=EVAL_ENO_NM1        Ctrl=txtEVAL_ENO_NM1        Param=value </C>
        <C> Col=EVAL_YMD1        	Ctrl=txtEVAL_YMD1        	Param=value </C>
        <C> Col=OPINION1        	Ctrl=txtOPINION1        	Param=value </C>
        <C> Col=EVAL_ENO_NO2        Ctrl=txtEVAL_ENO_NO2        Param=value </C>
        <C> Col=EVAL_ENO_NM2        Ctrl=txtEVAL_ENO_NM2        Param=value </C>
        <C> Col=EVAL_YMD2        	Ctrl=txtEVAL_YMD2        	Param=value </C>
        <C> Col=OPINION2        	Ctrl=txtOPINION2        	Param=value </C>
    '>
</object>

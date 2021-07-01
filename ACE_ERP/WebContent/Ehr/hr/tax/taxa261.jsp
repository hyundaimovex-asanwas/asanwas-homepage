	<!--*************************************************************************
	* @source      : taxa250.jsp												*
	* @description : 증명서신청 PAGE 												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/20            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String REQ_NO = request.getParameter("REQ_NO");
%>

<html>
<head>
	<title>증명서신청(taxa250)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TTFTFTTT';
		var today = getToday();
        var trTypeMsg = "";

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
            dsT_AC_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SHR&REQ_NO=<%=REQ_NO %>";
            dsT_AC_CEFBOOK.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save(sts) {
            //상태가 신청이면 상태값을 변경 시킨다.
            if(dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'CEF_STS') == "B") {
    			dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'CEF_STS') = sts;
    			if(sts == "F" || sts == "E"){
    				dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'SPL_YMD') = today;
    			}

    			if ( !fnc_SaveItemCheck() ) {
    				return;
    			}

                //결과 메세지를 출력 하기 위해
                if(sts == "C")
                    trTypeMsg = "반송";
                else if(sts == "E")
                    trTypeMsg = "발급";

    			// save
    			trT_AC_CEFBOOK.KeyValue = "tr01(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
    			trT_AC_CEFBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SAV";
    			trT_AC_CEFBOOK.post();
            }

            //인쇄 호출- 발급버튼을 누르면 바로 호출
            if(sts == "E")
                fnc_Print();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            if(dsT_AC_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");   //발급번호

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var STR_YMD  = document.getElementById("txtREQ_YMD").value;
            var STR_YY  = document.getElementById("txtCEF_YY").value.substring(0,4);
            var STR_YM  = document.getElementById("txtCEF_YY").value;
			var DPT_CD ="";

            if(CEF_STS != "E" && CEF_STS != "F") {
                alert("상태가 발급이나 직접출력이 아니면 출력하실 수 없습니다.");
                return;
            }
        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("인쇄하실 내용이 없습니다.");
                return;
            }

			//01^근로소득원천징수 영수증,02^근로소득원천징수부,03^퇴직소득원천징수 영수증,04^갑근세원천징수증명서
			if(CEF_SEC == "01"){  //근로소득원천징수 영수증
				var url = "taxa160_PV.jsp"
	                    + "?PIS_YY="+STR_YY   //정산년도
	                    + "&ENO_NO="+ENO_NO     //사번
	                    + "&DPT_CD="+DPT_CD 		//부서코드
	                    + "&STR_YMD="+STR_YMD	//신청일자
	                    + "&CEF_CNT="+CEF_CNT
	                    + "&TYPE=E&STP_GBN=2&TAX_GBN=8&PRT_GBN=1&CHK_OCC=ALL&SEND_PARM=1";
	                    //+ "&TYPE="+TYPE			//무조건 E : 사번으로 출력 한다.
	                    //+ "&STP_GBN="+STP_GBN	//직인출력 구분 : 무조건 직인출력 : 1
	                    //+ "&TAX_GBN="+TAX_GBN   //정산구분:1연말정산
	                    //+ "&PRT_GBN="+PRT_GBN   //증명서 종류(무조건 1: 소득자,발행자)
	                    //+ "&CHK_OCC="+CHK_OCC;  //근로구분구분(여기서는 무의미)
            }else if(CEF_SEC == "02"){  //근로소득 원천징수부

            	var url = "taxa080_PV.jsp"
                    + "?PIS_YY="+STR_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                    + "&CEF_CNT="+CEF_CNT
                    + "&TYPE=2&SEND_PARM=1";

            }else if(CEF_SEC == "03"){  //퇴직소득 원천징수영수증

            	var url = "taxa170_PV.jsp"
                    + "?PIS_YM="+STR_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&STP_GBN=2"//+STP_GBN
                    + "&CEF_CNT="+CEF_CNT
                    + "&PRT_GBN=1"//+PRT_GBN;

            }else if(CEF_SEC == "04"){  //갑근세 증명서

				var url = "taxa180_PV.jsp"
                    + "?PIS_YY="+STR_YM.replace("-","")
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                    + "&CEF_CNT="+CEF_CNT
//                    + "&JOB_CD="+JOB_CD
                    + "&IS_YEAR_AMT=Y"//+IS_YEAR_AMT
                   // + "&DOC1="+DOC1
                   // + "&DOC2="+DOC2
                   // + "&DOC3="+DOC3;
            }
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			window.close();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
            if ( !dsT_AC_CEFBOOK.isUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);
            fnc_HiddenElement("btnC");      //반송
            fnc_HiddenElement("btnE");      //발급

            fnc_SearchList();
        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        //입력 element들
        var elementList = new Array(     "txtHIR_CNT"
                                        ,"txtEXP_CNT"
                                        ,"txtRET_CNT"
                                        ,"txtCAR_CNT"
                                        ,"txtREMARK"
                                        ,"rdoCEF_SEC"
                                        ,"txtCEF_CNT"
                                        ,"txtCEF_YY"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM");

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_AC_CEFBOOK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_AC_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">

	</Object>

	<Object ID="dsT_AC_CEFBOOK_UPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_AC_CEFBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_AC_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsT_AC_CEFBOOK)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->

    <!-- 증명서 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R3"/>
       <jsp:param name="CODE_GUBUN"    value="R3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnLoadCompleted(iCount)">
		if (iCount != 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_CEFBOOK.CountRow);

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AC_CEFBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        fnc_HiddenElement("btnC");      //반송
        fnc_HiddenElement("btnE");      //발급

        if(row > 0) {
            var CEF_STS = dsT_AC_CEFBOOK.NameString(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");

            //신청 상태가 아니면 상태 변경 하지 못함
            if(CEF_STS == "B")
                fnc_ShowElement("btnC");    //반송

            //상태가 신청이거나 발급이거나 직접출력일 경우 발급버튼 보이게
            if(CEF_STS == "B"
                    || CEF_STS == "E"
                    || CEF_STS == "F" )
                fnc_ShowElement("btnE");    //발급

        }
    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_AC_CEFBOOK event=CanRowPosChange(row)>
		if ( dsT_AC_CEFBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_AC_CEFBOOK.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_AC_CEFBOOK.NameValue(row,"CEF_CNT") == "" ) {
			alert("[ " + grdT_AC_CEFBOOK.GetHdrDispName('-3','CEF_CNT') + " ]는 필수 입력사항입니다");
			return false;
		}
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">증명서신청</td>
					<td align="right" class="navigator">HOME/업무관리/증명서발급관리/<font color="#000000">증명서신청</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

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
            <td height="35" class="paddingTop5" width="260" align="right">
                <img src="/images/button/btn_SendbackOn.gif" id="btnC" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('C');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnC','','/images/button/btn_SendbackOver.gif',1)">
                <img src="/images/button/btn_IssueOn.gif"    id="btnE" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('E');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnE','','/images/button/btn_IssueOver.gif',1)">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->


	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="180"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">신청번호</td>
			<td class="padding2423" align="left">
				<input id="txtREQ_NO" name="txtREQ_NO" size="12"  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">사번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
            </td>
			<td align="center" class="creamBold">직위</td>
			<td class="padding2423" align="left">
				<input id="txtJOB_NM" name="txtJOB_NM" size="10" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidJOB_CD">
			</td>
			<td align="center" class="creamBold">부서</td>
			<td class="padding2423" align="left">
				<input id="txtDPT_NM" name="txtDPT_NM" size="15" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidDPT_CD">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">본적</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtPER_ADR" name="txtPER_ADR" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">주소</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtADDRESS" name="txtADDRESS" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">

		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="230"></col>
			<col width="60"></col>
			<col width="100"></col>
            <col width="60"></col>
            <col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold" rowspan="4">증명서<br>종류</td>
			<td class="padding2423" align="left" rowspan="4">

                <comment id="__NSID__">
                    <object id=rdoCEF_SEC classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200;height:90;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^근로소득원천징수 영수증,02^근로소득원천징수부,03^퇴직소득원천징수 영수증,04^갑근세원천징수증명서">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>

			</td>
			<td align="center" class="creamBold">용도</td>
			<td class="padding2423" colspan="3">
                <input type="text" id="txtCEF_RSN_NM" style="width:100%" class="input_ReadOnly" readonly>
			</td>

            <td align="center" class="creamBold">매수</td>
            <td class="padding2423">
                <input id="txtCEF_CNT" size="4"  maxlength="2" style="ime-mode:disabled">
            </td>
		</tr>
		<tr>
			<td align="center" class="creamBold">비고</td>
			<td class="padding2423" colspan="5">
				<input type="text" id="txtREMARK" style="width:100%" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
            <td align="center" class="creamBold">귀속년월</td>
            <td class="padding2423" align="left">
                <input type="text" id="txtCEF_YY" style="ime-mode:disabled" size="7" maxlength= "7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
            </td>
			<td align="center" class="creamBold">상태</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_STS_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">신청일자</td>
			<td class="padding2423">
				<input type="text" id="txtREQ_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">발급번호</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtCEF_NO" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">발급일자</td>
			<td class="padding2423">
				<input type="text" id="txtSPL_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr>
			<td>
            [증명서 신청방법]<br>
			&nbsp;&nbsp;1. 증명서 종류를 선택하세요.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. 신청한 증명서의 매수를 입력하고 신청용도를 선택하세요.<br>
			[직접출력 공지]<br>
			&nbsp;&nbsp;직접출력은 본인이 직접 증명서를 출력할 수 있으나 직인과 담당자인은 이미지 처리 됩니다.
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	</form>
	<!-- form 끝 -->

</body>
</html>


	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_CEFBOOK 설정 테이블 -->
	<object id="bndT_AC_CEFBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_CEFBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=PER_ADR		Ctrl=txtPER_ADR		Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>

			<C>Col=CEF_RSN_NM	Ctrl=txtCEF_RSN_NM	Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=CEF_NO		Ctrl=txtCEF_NO		Param=value</C>
			<C>Col=CEF_STS_NM	Ctrl=txtCEF_STS_NM	Param=value</C>
			<C>Col=CEF_SEC		Ctrl=rdoCEF_SEC		Param=CodeValue</C>
			<C>Col=CEF_CNT		Ctrl=txtCEF_CNT		Param=value</C>
            <C>Col=CEF_YY       Ctrl=txtCEF_YY      Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
		">
	</object>
	<!--*************************************************************************
	* @source      : scha050.jsp												*
	* @description : 개인별 학자금 관리 PAGE	 								*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27      오대성          최초작성									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String role_cd = box.getString("SESSION_ROLE_CD");
    boolean isMaster = false;
    if(role_cd.equals("1001")
            || role_cd.equals("1002"))
        isMaster = true;
%>

<html>
<head>
	<title>개인별 학자금 관리(scha050)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TFTTFFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {
			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var pis_yy = document.getElementById("txtPIS_YY_SHR").value;
			var eno_no = document.getElementById("txtENO_NO").value;

			dsT_SC_SCHLBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha050.cmd.SCHA050CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_SC_SCHLBOOK.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 *
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			// save
			trT_SC_SCHLBOOK.KeyValue = "tr01(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
			trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha050.cmd.SCHA050CMD&S_MODE=SAV";
			trT_SC_SCHLBOOK.post();
        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_SC_SCHLBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SC_SCHLBOOK.GridToExcel("개인별학자금관리현황", '', 225);
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {
        	// 초기화
			document.getElementById("txtPIS_YY_SHR").value = getTodayArray()[0];
        	document.getElementById("txtENO_NO").value = "";
        	document.getElementById("txtENO_NM").value = "";
			document.getElementById("txtOCC_NM").value = "";
        	document.getElementById("txtDPT_NM").value = "";
			document.getElementById("txtJOB_NM").value = "";
        	document.getElementById("txtHIR_YMD").value = "";
			document.getElementById("txtRET_YMD").value = ""
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_SC_SCHLBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_SC_SCHLBOOK.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var pis_yy = document.getElementById('txtPIS_YY_SHR').value;
			var eno_no = document.getElementById("txtENO_NO").value;
			var eno_nm = document.getElementById("txtENO_NM").value;

			if(pis_yy.trim() == ''){
				alert("해당년월은 반드시 입력하셔야 합니다!");
				document.getElementById('txtPIS_YY_SHR').focus();
				return false;
			}
			if(eno_no.trim() == ''){
				alert("사번은 반드시 입력하셔야 합니다!");
				document.getElementById('txtENO_NO').focus();
				return false;
			}
			if(eno_nm.trim() == ''){
				alert("잘못된 사번입니다. 확인 후 다시 입력 하세요.");
				document.getElementById('txtENO_NO').focus();
				return false;
			}

			return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   *
         ********************************************/
        function fnc_OnLoadProcess() {
            //입력 못하게 막기
            fnc_DisableElementAll(elementList);


			cfStyleGrid(form1.grdT_SC_SCHLBOOK,0,"false","false");      // Grid Style 적용
			document.getElementById('txtPIS_YY_SHR').focus();
            document.getElementById("txtPIS_YY_SHR").value = getTodayArray()[0];

            //로그인 사람의 정보를 조회해옴
            document.getElementById("txtENO_NO").value = "<%=box.get("SESSION_ENONO") %>";

<%
    if(!box.get("SESSION_ROLE_CD").equals("1001")
            && !box.get("SESSION_ROLE_CD").equals("1002")) {
%>

            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
%>


            fnc_SearchEmpNo();
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 합계구해서 넣기	 							*
         ********************************************/
		function fnc_sum(){

			if(dsT_SC_SCHLBOOK.CountRow<1) return;

			var ret_amt = form1.medRET_AMT.Text;
			var edu_amt = form1.medEDU_AMT.Text;
			var end_amt = form1.medEND_AMT.Text;
			var sco_amt = form1.medSCO_AMT.Text;
			var oth_amt = form1.medOTH_AMT.Text;

			if( ret_amt == "" ) ret_amt = 0;
			if( edu_amt == "" ) edu_amt = 0;
			if( end_amt == "" ) end_amt = 0;
			if( sco_amt == "" ) sco_amt = 0;
			if( oth_amt == "" ) oth_amt = 0;

			dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, 'TOT_AMT') = eval( ret_amt+"+"+edu_amt+"+"+end_amt+"+"+sco_amt+"+"+oth_amt );

		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");

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
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO");

            if(obj.eno_no != "") {
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtHIR_YMD").value     = obj.hirg_ymd;
                document.getElementById("txtOCC_NM").value      = obj.occ_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtRET_YMD").value     = obj.ret_ymd;
            } else {
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtHIR_YMD").value     = "";
                document.getElementById("txtOCC_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtRET_YMD").value     = "";
            }
        }

        var elementList = new Array(     "txtSEL_NM"
                                        ,"txtBIR_YMD"
                                        ,"txtOLD_AGE"
                                        ,"txtFSCH_NM"
                                        ,"txtSCH_NM"
                                        ,"txtMAJ_NM"
                                        ,"medRET_AMT"
                                        ,"medEDU_AMT"
                                        ,"medEND_AMT"
                                        ,"medSCO_AMT"
                                        ,"medOTH_AMT"
                                        ,"medTOT_AMT"
                                        ,"medPAY_AMT" );

        var amtList = new Array(         "medRET_AMT"
                                        ,"medEDU_AMT"
                                        ,"medEND_AMT"
                                        ,"medSCO_AMT"
                                        ,"medOTH_AMT"
                                        ,"medPAY_AMT" );

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_SC_SCHLBOOK)		   |
    | 3. 사용되는 Table List(T_SC_SCHLBOOK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet COPY 용					   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_PERSON)		   |
    | 3. 사용되는 Table List(T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_SC_SCHLBOOK)			       |
    | 3. 사용되는 Table List(T_SC_SCHLBOOK)				       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {

		} else {

			document.getElementById("txtOCC_NM").value = dsVI_T_PERSON.NameValue(1,"OCC_NM");
			document.getElementById("txtHIR_YMD").value = dsVI_T_PERSON.NameValue(1,"HIR_YMD");
			document.getElementById("txtRET_YMD").value = dsVI_T_PERSON.NameValue(1,"RET_YMD");

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnFail()">
        alert(trT_SC_SCHLBOOK.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_SC_SCHLBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

<%
    if(isMaster) {
%>
        if(row > 0) {
            fnc_EnableElementAll(amtList);
        }
<%
    }
%>
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별 학자금 관리</td>
					<td align="right" class="navigator">HOME/복리후생/학자금지원/<font color="#000000">개인별 학자금 관리</font></td>
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
<%
    if(isMaster) {
%>
   	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
<%
    }
%>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="90"></col>
                            <col width="130"></col>
                            <col width="60"></col>
                            <col width="150"></col>
                            <col width="60"></col>
                            <col width="110"></col>
                            <col width="60"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td align="center" class="searchState">해당년&nbsp;</td>
                            <td class="padding2423">

                                <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                            <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                        </td>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                    </tr>
                                    <tr>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                    </tr>
                                </table>

                            </td>
                            <td align="center" class="searchState">사&nbsp;&nbsp;번</td>
                            <td class="padding2423">
                                <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                            </td>
                            <td align="center" class="searchState">성&nbsp;&nbsp;명</td>
                            <td class="padding2423">
                                <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                            </td>

                            <td align="center" class="searchState">근로구분</td>
                            <td class="padding2423"><input id="txtOCC_NM" size="8"  class="input_ReadOnly" readonly></td>
                        </tr>
                        <tr>
                            <td align="center" class="searchState">소속</td>
                            <td class="padding2423">
                                <input id="txtDPT_NM" size="15"  class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="searchState">직위</td>
                            <td class="padding2423">
                                <input id="txtJOB_NM" size="15"  class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="searchState">입사일</td>
                            <td class="padding2423"><input id="txtHIR_YMD" size="10"  class="input_ReadOnly" readonly></td>
                            <td align="center" class="searchState">퇴사일</td>
                            <td class="padding2423"><input id="txtRET_YMD" size="10"  class="input_ReadOnly" readonly></td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- power Search테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">성명</td>
			<td class="padding2423"><input id="txtSEL_NM" size="12" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">생년월일</td>
			<td class="padding2423"><input id="txtBIR_YMD" size="12" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">나이</td>
			<td class="padding2423"><input id="txtOLD_AGE" size="12" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">학년</td>
			<td class="padding2423"><input id="txtFSCH_NM" size="12" class="input_ReadOnly" readonly></td>
		</tr>
		<tr>
			<td align="center" class="creamBold">학교명</td>
			<td class="padding2423"><input id="txtSCH_NM" size="12" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">학과명</td>
			<td class="padding2423" colspan="5"><input id="txtMAJ_NM" size="14" class="input_ReadOnly" readonly></td>
        </tr>
        <tr>
			<td align="center" class="creamBold">입학금</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medRET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=false>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">수업료</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=false>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">학교운영지원비</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medEND_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=false>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">장학금</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medSCO_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=false>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
        </tr>
        <tr>
			<td align="center" class="creamBold">기타</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medOTH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=false>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">합계</td>
			<td class="padding2423" colspan="3">
			<table width="100%" border="0" >
			<tr>
				<td width="85">
					<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=false>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=9>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
            <td align="center" class="creamBold">지급금액</td>
            <td class="padding2423">
                <table width="100%" border="0" >
                <tr>
                    <td width="85px">
                        <comment id="__NSID__"><object id="medPAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:85px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="left">원</td>
                </tr>
                </table>
            </td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

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
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"	width="30"	name="NO"		align="center" </C>
							<C> id="SEL_NM"		width="50"	name="성명"		align="center" </C>
							<C> id="BIR_YMD"	width="90"	name="주민번호"	align="center" </C>
							<C> id="OLD_AGE"	width="30"	name="나이"		align="center" </C>
							<C> id="FSCH_NM"	width="60"	name="학력구분"	align="center" </C>
							<C> id="SCH_NM"		width="70"	name="학교명"	align="left"			LeftMargin="10"</C>
							<C> id="MAJ_NM"		width="70"	name="학과명"	align="left"			LeftMargin="10"</C>
							<C> id="RET_AMT"	width="65"	name="입학금"	align="right" </C>
							<C> id="EDU_AMT"	width="65"	name="수업료"	align="right" </C>
							<C> id="END_AMT"	width="65"	name="학교운영지원비"	align="right" </C>
							<C> id="SCO_AMT"	width="65"	name="장학금"	align="right" </C>
							<C> id="OTH_AMT"	width="65"	name="기타"		align="right" </C>
							<C> id="TOT_AMT"	width="65"	name="합계"		align="right"				value={(RET_AMT+EDU_AMT+END_AMT+SCO_AMT+OTH_AMT)} </C>
                            <C> id="PAY_AMT"    width="65"  name="지급금액"   align="right" </C>
                            <C> id="PAY_YM"     width="65"  name="지급년월"   align="center" </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

</body>
</html>

	<!-- T_SC_SCHLBOOK 설정 테이블 -->
	<object id="bndT_SC_SCHLBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_SC_SCHLBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=SEL_NM		Ctrl=txtSEL_NM		Param=value </C>
			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value </C>
			<C>Col=OLD_AGE		Ctrl=txtOLD_AGE		Param=value </C>
			<C>Col=FSCH_NM		Ctrl=txtFSCH_NM		Param=value </C>
			<C>Col=SCH_NM		Ctrl=txtSCH_NM		Param=value </C>
			<C>Col=MAJ_NM		Ctrl=txtMAJ_NM		Param=value </C>
			<C>Col=RET_AMT		Ctrl=medRET_AMT		Param=Text  </C>
			<C>Col=EDU_AMT		Ctrl=medEDU_AMT		Param=text  </C>
			<C>Col=END_AMT		Ctrl=medEND_AMT		Param=text  </C>
			<C>Col=SCO_AMT		Ctrl=medSCO_AMT		Param=text  </C>
			<C>Col=OTH_AMT		Ctrl=medOTH_AMT		Param=text  </C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=text  </C>
			<C>Col=PAY_AMT		Ctrl=medPAY_AMT		Param=text  </C>
		">
	</object>
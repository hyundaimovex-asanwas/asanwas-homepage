	<!--*************************************************************************
	* @source      : proa030.jsp												*
	* @description : 승진대상자선정 PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/17            채갑병         	        최초작성
    * 2007/04/15            김학수         	        최초작성			*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>승진대상자선정(proa030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var isSave = false;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;   // 승진년도

            if( PMT_YMD_SHR == "" ){
        		alert("승진년도를 입력하십시오. 예)"+next_yy);
        		return;
        	}
        	if( PMT_YMD_SHR.length != 4 ){
        		alert("승진년도를 바르게 입력하십시오. 예)"+next_yy);
        		return;
        	}
        	//if( PMT_YMD_SHR != next_yy ){
        	//	alert("차기년도의 대상자만 처리 가능합니다. 예)"+next_yy);
        	//	return;
        	//}

			isSave = false;

			var GBN_CD_SHR     = document.form1.hidGBN_CD_SHR.value;     // 정기/특별승진 구분

            /*
			var JOB_CD_SHR     = document.form1.txtJOB_CD_SHR.value;     // 직위코드
			var DPT_CD_SHR     = document.form1.txtDPT_CD_SHR.value;     // 소속코드
			var JOBDPT_CD_SHR  = document.form1.hidJOBDPT_CD_SHR.value;  // 직위/소속 구분
			var TOE_CD_SHR     = document.form1.hidTOE_CD_SHR.value;     // 토익 구분
			var REC_CD_SHR     = document.form1.hidREC_CD_SHR.value;     // 추천 구분
			var LAN_CD_SHR     = document.form1.hidLAN_CD_SHR.value;     // 어학/전산 구분
            */

            trVI_T_CM_PERSON.KeyValue = "SHR(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa030.cmd.PROA030CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;//+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOBDPT_CD_SHR="+JOBDPT_CD_SHR+"&TOE_CD_SHR="+TOE_CD_SHR+"&REC_CD_SHR="+REC_CD_SHR+"&LAN_CD_SHR="+LAN_CD_SHR;
			trVI_T_CM_PERSON.post();
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
        function fnc_Save() {
            var PMT_YMD_SHR     = document.form1.txtPMT_YMD_SHR.value;      // 승진년도
            var GBN_CD_SHR      = document.form1.hidGBN_CD_SHR.value;       // 정기/특별승진 구분

			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			
			if(!confirm("승진대상자 선정을 하시겠습니까?")){
                return false;
            }
            
			dsVI_T_CM_PERSON.UseChangeInfo = "false";

            trVI_T_CM_PERSON_SAV.KeyValue = "SAV(I:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
			trVI_T_CM_PERSON_SAV.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa030.cmd.PROA030CMD&S_MODE=SAV&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
			trVI_T_CM_PERSON_SAV.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {

			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;   // 승진년도

            if( PMT_YMD_SHR == "" ){
        		alert("승진년도를 입력하십시오. 예)"+next_yy);
        		return;
        	}
        	if( PMT_YMD_SHR.length != 4 ){
        		alert("승진년도를 바르게 입력하십시오. 예)"+next_yy);
        		return;
        	}

            var gbn_cd     = document.form1.hidGBN_CD_SHR.value;     // 정기/특별승진 구분

			//var job_cd     = document.form1.txtJOB_CD_SHR.value;     // 직위코드
			//var dpt_cd     = document.form1.txtDPT_CD_SHR.value;     // 소속코드
			//var jobdpt_cd  = document.form1.hidJOBDPT_CD_SHR.value;  // 직위/소속 구분
			//var toe_cd     = document.form1.hidTOE_CD_SHR.value;     // 토익 구분
			//var rec_cd     = document.form1.hidREC_CD_SHR.value;     // 추천 구분
			//var lan_cd     = document.form1.hidLAN_CD_SHR.value;     // 어학/전산 구분

            var url = "proa030_PV.jsp?pmt_ymd="+PMT_YMD_SHR+"&gbn_cd="+gbn_cd;//+"&job_cd="+job_cd+"&dpt_cd="+dpt_cd+"&jobdpt_cd="+jobdpt_cd+"&toe_cd="+toe_cd+"&rec_cd="+rec_cd+"&lan_cd="+lan_cd;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
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
			//이곳에 해당 코딩을 입력 하세요
		}

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
  			//document.form1.txtPMT_YMD_SHR.value = next_yy;
  			
  			//document.form1.txtJOB_CD_SHR.value  = "";
  			//document.form1.txtDPT_CD_SHR.value  = "";
  			//document.form1.txtJOB_NM_SHR.value  = "";
  			//document.form1.txtDPT_NM_SHR.value  = "";
  			document.form1.txtPRO_CNT.value     = "";
  			document.form1.txtTRG_CNT.value     = "";
  			document.form1.txtERR_CNT.value     = "";
  			document.form1.txtPRO_STS_MSG.value = "";


			//document.form1.rdoGBN_CD_SHR.item(0).checked = true;
			//document.form1.rdoJOBDPT_SHR.item(0).checked = true;
			//document.form1.rdoTOE_CD_SHR.item(0).checked = true;
			//document.form1.rdoREC_CD_SHR.item(0).checked = true;
			//document.form1.rdoLAN_CD_SHR.item(0).checked = true;

			document.form1.hidGBN_CD_SHR.value  = "1";
			//document.form1.hidJOBDPT_CD_SHR.value = "1";
			//document.form1.hidTOE_CD_SHR.value  = "1";
			//document.form1.hidREC_CD_SHR.value  = "1";
			//document.form1.hidLAN_CD_SHR.value  = "1";

            document.getElementById("resultMessage").innerText = ' ';
            
			changeInput();
			
        	dsVI_T_CM_PERSON.ClearData();
        	dsT_CP_WORKLOG.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
        
            if(document.form1.txtPMT_YMD_SHR.value == '') {
                alert("승진년도는 필수입력사항입니다.");
                document.form1.txtPMT_YMD_SHR.focus();
                return false;
            }
                    
         	if(dsVI_T_CM_PERSON.CountRow == 0) {
				alert("저장할 승진 대상자가 없습니다.");
                return false;
			}

            if(dsT_CP_WORKLOG.CountRow == 1) {
                alert("해당년도의 승진대상자 처리가 이미 이루어졌습니다.");
                return false;
            }

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
	        changeInput();
	        document.form1.txtPMT_YMD_SHR.value = next_yy;
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

  		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

  		/********************************************
         * 직위/소속 선택에 따른 입력 구분                 			*
         ********************************************/
        function changeInput() {
            /*
        	if( document.form1.rdoJOBDPT_SHR[0].checked ){
        		document.form1.txtJOB_CD_SHR.readOnly = false;
        		document.form1.txtJOB_CD_SHR.className = "";
        		document.form1.txtDPT_CD_SHR.readOnly = true;
        		document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";

        		document.form1.txtDPT_CD_SHR.value = "";
        		document.form1.txtDPT_NM_SHR.value = "";
        		document.form1.hidJOBDPT_CD_SHR.value = "1";
        		document.getElementById("imgJOB_CD_SHR").disabled = false;
        		document.getElementById("Image21").disabled = true;
        	}else{
        		document.form1.txtJOB_CD_SHR.readOnly = true;
        		document.form1.txtJOB_CD_SHR.className = "input_ReadOnly";
        		document.form1.txtDPT_CD_SHR.readOnly = false;
        		document.form1.txtDPT_CD_SHR.className = "";

        		document.form1.txtJOB_CD_SHR.value = "";
        		document.form1.txtJOB_NM_SHR.value = "";
        		document.form1.hidJOBDPT_CD_SHR.value = "2";
        		document.getElementById("imgJOB_CD_SHR").disabled = true;
        		document.getElementById("Image21").disabled = false;
        	}
        	*/
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet						 		   	   |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)		 	   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
		<param name=TimeOut           value=200000>
	</Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut           value=200000>
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<param name=TimeOut value=2000000>
	</Object>

	<Object ID="trVI_T_CM_PERSON_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<param name=TimeOut value=2000000>
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">

    </Script>

	<Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
	
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
        
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
        if (dsVI_T_CM_PERSON.CountRow == 0) {
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승진대상자가 없습니다.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            document.getElementById("txtTRG_CNT").value = dsVI_T_CM_PERSON.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";
            
        } else if(dsT_CP_WORKLOG.CountRow == 1) {
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승진대상자 선정을 완료하였습니다..';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsVI_T_CM_PERSON.CountRow);

            document.getElementById("txtTRG_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT") + dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");
            
        } else {
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승진대상자 선정이 가능합니다.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsVI_T_CM_PERSON.CountRow);
            
            document.getElementById("txtTRG_CNT").value = dsVI_T_CM_PERSON.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";
        }

    </script>

	<script for=trVI_T_CM_PERSON_SAV event="OnSuccess()">
		if(dsT_CP_WORKLOG.CountRow == 1){ // 저장
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");
            
            document.getElementById("txtPRO_STS_MSG").value = '해당년도의 승진대상자 선정을 완료하였습니다..';
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");

		}else{// 조회
			alert("승진대상자 선정에 실패하였습니다.");
			document.getElementById("resultMessage").innerText = ' ';
		}
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
    </script>

	<script for=trVI_T_CM_PERSON_SAV event="OnFail()">
        alert(trVI_T_CM_PERSON_SAV.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승진대상자선정</td>
					<td align="right" class="navigator">HOME/인사관리/승진/<font color="#000000">승진대상자선정</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)">  <img src="/images/button/btn_ConductOn.gif"   name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<!-- <col width="100"></col> -->
							<col width="80"></col>
							<col width="95"></col>
							<col width="80"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<!-- <td align="right" class="searchState">대상자선정&nbsp;</td>  -->
							<td class="searchState"align="right">승진년도</td>
							<td class="padding2423" align="left">
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                            <input type="text" id="txtPMT_YMD_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                        </td>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPMT_YMD_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                    </tr>
                                    <tr>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPMT_YMD_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                    </tr>
                                </table>
							</td>
							<td class="searchState"align="right"><!-- 승진구분 --></td>
							<td class="padding2423" align="left">
							    <!-- 
								<input type="radio" name="rdoGBN_CD_SHR" id="rdoGBN_CD_SHR" checked style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_CD_SHR.value = '1' ">정기승진
								&nbsp;
								<input type="radio" name="rdoGBN_CD_SHR" id="rdoGBN_CD_SHR" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_CD_SHR.value = '2' ">특별승진
								 -->
							</td>
						</tr>
						
						
						<!-- 
						<tr>
						    <td colspan="5" height="5"></td>
						</tr>
						<tr>
						    <td align="right" class="searchState">인쇄물출력&nbsp;</td>
						    <td align="right" >조회구분</td>
							<td class="padding2423" align="left" colspan="3">
							    <input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" checked style="margin-bottom:-2px;border:0;"  onClick="changeInput()">
							    직위
							    <input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');">
								<input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="10" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')"></a>
                                &nbsp;&nbsp;
							    <input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" style="margin-bottom:-2px;border:0;"   onClick="changeInput()">
							    소속
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
								</a>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">TOEIC점수</td>
							<td class="padding2423" align="left" colspan="3">
								<input type="radio" id="rdoTOE_CD_SHR" name="rdoTOE_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidTOE_CD_SHR.value = '1' " checked>
								전체&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoTOE_CD_SHR" name="rdoTOE_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidTOE_CD_SHR.value = '2' ">
								550미만&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoTOE_CD_SHR" name="rdoTOE_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidTOE_CD_SHR.value = '3' ">
								550이상
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">추천구분</td>
							<td class="padding2423" align="left" colspan="3">
								<input type="radio" id="rdoREC_CD_SHR" name="rdoREC_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidREC_CD_SHR.value = '1' " checked>
								전체&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoREC_CD_SHR" name="rdoREC_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidREC_CD_SHR.value = '2' ">
								추천자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoREC_CD_SHR" name="rdoREC_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidREC_CD_SHR.value = '3' ">
								미추천자
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">어학/전산점수</td>
							<td class="padding2423" align="left" colspan="3">
								<input type="radio" id="rdoLAN_CD_SHR" name="rdoLAN_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidLAN_CD_SHR.value = '1' " checked>
								출력&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    							<input type="radio" id="rdoLAN_CD_SHR" name="rdoLAN_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidLAN_CD_SHR.value = '2' ">
    							미출력
							</td>
						</tr>
						-->
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
				<col width="70"></col>
				<col width=""></col>
				<tr>
					<td align="center" class="creamBold">대상인원</td>
					<td class="padding2423" align="left">
					    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						처리대상인원&nbsp;<input id="txtTRG_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;명
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						처리인원&nbsp;<input id="txtPRO_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;명
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						미처리인원&nbsp;<input id="txtERR_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;명
					</td>
				</tr>
                <tr>
                    <td align="center" class="creamBold">작업상황</td>
                    <td  class="padding2423" colspan="2">
                        <input id="txtPRO_STS_MSG" style="width:100%"  class="input_ReadOnly" readonly>
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

	<input type="hidden" id="hidGBN_CD_SHR"    value="1">
	<input type="hidden" id="hidJOBDPT_CD_SHR" value="1">
	<input type="hidden" id="hidTOE_CD_SHR"    value="1">
	<input type="hidden" id="hidREC_CD_SHR"    value="1">
	<input type="hidden" id="hidLAN_CD_SHR"    value="1">
	</form>
	<!-- form 끝 -->

</body>
</html>
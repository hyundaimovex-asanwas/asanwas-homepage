	<!--*************************************************************************
	* @source      : scha070.jsp												*
	* @description : 개인별 학자금 지급 현황 PAGE	 							*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27      오대성          최초작성									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>개인별 학자금 지급 현황(scha070)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var pis_yy = document.getElementById("txtPIS_YY_SHR").value;
			var eno_no = document.getElementById("txtENO_NO_SHR").value;

			dsT_SC_SCHLBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha070.cmd.SCHA070CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
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

			//이곳에 해당 코딩을 입력 하세요

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
			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var REGYY = document.getElementById("txtPIS_YY_SHR").value;
			var ENONO = document.getElementById("txtENO_NO_SHR").value;

	        var url = "scha070_PV.jsp?REGYY="+REGYY+"&ENONO="+ENONO;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
            //이곳에 해당 코딩을 입력 하세요
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
			document.getElementById("txtPIS_YY_SHR").value = "";
        	document.getElementById("txtENO_NO_SHR").value = "";
        	document.getElementById("txtENO_NM").value = "";
			document.getElementById("txtOCC_NM").value = "";
        	document.getElementById("txtDPT_NM").value = "";
			document.getElementById("txtJOB_NM").value = "";
        	document.getElementById("txtHIR_YMD").value = "";
			document.getElementById("txtRET_YMD").value = "";
			document.getElementById("txtCET_NO").value = "";
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_SC_SCHLBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var pis_yy = document.getElementById('txtPIS_YY_SHR').value;
			var eno_no = document.getElementById("txtENO_NO_SHR").value;

			if(pis_yy.trim() == ''){
				alert("지급년도는 반드시 입력하셔야 합니다!");
				document.getElementById('txtPIS_YY_SHR').focus();
				return false;
			}
			if(eno_no.trim() == ''){
				alert("사번은 반드시 입력하셔야 합니다!");
				document.getElementById('txtENO_NO_SHR').focus();
				return false;
			}
			if(pis_yy.length != 4) {
				alert("년도를 4자리로 입력하세요!");
				document.getElementById('txtPIS_YY_SHR').focus();
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
			cfStyleGrid(form1.grdT_SC_SCHLBOOK,0,"false","false");      // Grid Style 적용
			document.getElementById('txtPIS_YY_SHR').focus();
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


		/********************************************
         * 16. 사원 검색 후 필드값 매핑(extends common.js - 배열을 인자로)*
         ********************************************/
        function fnc_emplPopupArr1(arr){
        	var obj = new String();
        	
        	obj.eno_nm = "";

			window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(arr[0] != "" && obj.eno_no.trim() != ""){
	  			document.getElementById(arr[0]).value = obj.eno_no;
 			}
			if(arr[1] != "" && obj.eno_nm.trim() != ""){
 				document.getElementById(arr[1]).value = obj.eno_nm;
			}
//			if(arr[2] != "" && obj.dpt_cd.trim() != ""){
// 				document.getElementById(arr[2]).value = obj.dpt_cd;
//			}
			if(arr[3] != ""  && obj.dpt_nm.trim() != ""){
 	 			document.getElementById(arr[3]).value = obj.dpt_nm;
 			}
//			if(arr[4] != "" && obj.job_cd.trim() != ""){
// 				document.getElementById(arr[4]).value = obj.job_cd;
//			}
			if(arr[5] != "" && obj.job_nm.trim() != ""){
  				document.getElementById(arr[5]).value = obj.job_nm;
 			}
			if(arr[6] != ""){
				// [6]에 지정된 함수명으로 스크립트 함수 실행
				var fn = "document.Script."+arr[6];
				eval(fn);
			}
        }

 		/********************************************
         * 17. 선택된 사원에 해당하는 사원정보 조회 *
         ********************************************/
        function fnc_SearchInfo(){
			var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
			if( ENO_NO == ""){	return;	}
			dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha050.cmd.SCHA050CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO;
			dsVI_T_PERSON.reset();
        }

		/********************************************
         * 18. 합계구해서 넣기	 					*
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

//			var sum = eval( ret_amt+"+"+edu_amt+"+"+end_amt )+"";
			dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, 'TOT_AMT') = eval( ret_amt+"+"+edu_amt+"+"+end_amt+"+"+sco_amt+"+"+oth_amt );

		}

         /**********************************
         * 19. 사번으로 사원정보조회 처리 *
         *********************************/
        function fnc_UserGetEnoNm() {

            var obj = new String();
            
            obj = fnc_GetEnoNm("txtENO_NO_SHR");

            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtOCC_NM").value = obj.occ_nm;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
            document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
            document.getElementById("txtRET_YMD").value = obj.ret_ymd;
            document.getElementById("txtCET_NO").value = obj.cet_no;

        }

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
			alert("검색하신 조건의 자료가 없습니다!");
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
			document.getElementById("txtCET_NO").value = dsVI_T_PERSON.NameValue(1,"CET_NO");


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별 학자금 지급 현황</td>
					<td align="right" class="navigator">HOME/복리후생/학자금지원/<font color="#000000">개인별 학자금 지급 현황</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	     		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="80"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width="140"></col>
							<col width="60"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="searchState">지급년도&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YY_SHR" size="4" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','5','115');"></a>
                                </td>
							<td align="center" class="searchState">사번</td>
							<td class="padding2423"><input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength="8" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()" onChange="fnc_UserGetEnoNm()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FindEmpl','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="FindEmpl" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopupArr1( new Array('txtENO_NO_SHR','txtENO_NM','hidDPT_CD','txtDPT_NM','','txtJOB_NM','fnc_SearchInfo()') )"></a>
							</td>
							<td align="center" class="searchState">성명</td>
							<td class="padding2423"><input id="txtENO_NM" size="10"  class="input_ReadOnly" readonly></td>
							<td align="center" class="searchState">근로구분</td>
							<td class="padding2423"><input id="txtOCC_NM" size="8"  class="input_ReadOnly" readonly></td>
							<td align="center" class="searchState">직위</td>
							<td class="padding2423">
								<input id="txtJOB_NM" size="10"  class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
							<td align="center" class="searchState">소속</td>
							<td class="padding2423">
								<input id="txtDPT_NM" size="15"  class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="searchState">입사일</td>
							<td class="padding2423"><input id="txtHIR_YMD" size="10"  class="input_ReadOnly" readonly></td>
							<td align="center" class="searchState">퇴사일</td>
							<td class="padding2423"><input id="txtRET_YMD" size="10"  class="input_ReadOnly" readonly></td>
							<td align="center" class="searchState">주민번호</td>
							<td class="padding2423" colspan="3"><input id="txtCET_NO" size="14"  class="input_ReadOnly" readonly></td>
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
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"	width="30"	name="NO"		align="center" </C>
							<C> id="PIS_MM"		width="45"	name="지급월"	align="center" </C>
							<C> id="SEL_NM"		width="50"	name="성명"		align="center" </C>
							<C> id="BIR_YMD"	width="70"	name="생년월일"	align="center" </C>
							<C> id="OLD_AGE"	width="30"	name="나이"		align="center" </C>
							<C> id="FSCH_NM"	width="60"	name="학력구분"	align="center" </C>
							<C> id="SCH_NM"		width="70"	name="학교명"	align="left"			LeftMargin="10"</C>
							<C> id="MAJ_NM"		width="70"	name="학과명"	align="left"			LeftMargin="10"</C>
							<C> id="RET_AMT"	width="65"	name="입학금"	align="right" </C>
							<C> id="EDU_AMT"	width="65"	name="수업료"	align="right" </C>
							<C> id="END_AMT"	width="65"	name="기성회비"	align="right" </C>
							<C> id="SCO_AMT"	width="65"	name="장학금"	align="right" </C>
							<C> id="OTH_AMT"	width="65"	name="기타"		align="right" </C>
							<C> id="TOT_AMT"	width="65"	name="합계"		align="right" </C>
							<C> id="PAY_AMT"	width="65"	name="지급액"	align="right" </C>
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

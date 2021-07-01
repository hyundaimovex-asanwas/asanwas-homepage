	<!--*************************************************************************
	* @source      : welm011.jsp												*
	* @description : 주차권신청 PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2010/04/09            권혁수                     주차권신청 최초작성
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="common.util.DateUtil" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //사번
	String eno_nm = box.getString("SESSION_ENONM");         //성명
	String dep_cd = box.getString("SESSION_DPTCD");         //부서
	String dep_nm = box.getString("SESSION_DPTNM");         //부서명
	String job_nm = box.getString("SESSION_JOBNM");         //직위
	String job_cd = box.getString("SESSION_JOBCD");         //직위

	String SESSION_ROLE_CD = box.getString("SESSION_ROLE_CD");         //권한

	// 요일
	int dayOfWeek = DateUtil.getDayOfWeek(new Date());
	// 현재시간
	String CurHour = DateUtil.getCurrentHour();

	System.out.println("요일 [" + dayOfWeek + "] 시간 [" + CurHour + "]");
%>
<html>
<head>
	<title>주말주차권신청(welm010)</title>
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
		//☞.신청마감 : 매주 수요일, 금요일 오후 04:00
		/*
		if(4 == <%=dayOfWeek%> || 6 == <%=dayOfWeek%> ){
			if("<%=CurHour%>" >= "16"){
				alert("신청마감은 매주 수요일, 금요일 오후 4시까지입니다");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			}
		}else{
		}
		*/
		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_WL_PARKING_SHR.KeyValue = "tr05(O:dsT_WL_PARKING=dsT_WL_PARKING)";
			trT_WL_PARKING_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD"
                                   + "&S_MODE=SHR"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_WL_PARKING_SHR.post();
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
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			// save
			trT_WL_PARKING.KeyValue = "tr01(I:dsT_WL_PARKING=dsT_WL_PARKING)";
			trT_WL_PARKING.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD&S_MODE=SAV";
			trT_WL_PARKING.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
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
			// 행 추가
			dsT_WL_PARKING.AddRow();
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NM") = "<%=eno_nm%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_NM") = "<%=dep_nm%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "JOB_NM") = "<%=job_nm%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "JOB_CD") = "<%=job_cd%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_CD") = "<%=dep_cd%>";

			fnc_ChangeStateElement(true, "ImgYmd");
			fnc_ChangeStateElement(true, "txtREQ_YMD");
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_PARKING.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
				var endTag = dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "END_TAG");
				if(endTag == "T"){
					alert("발급이 완료된 데이터는 삭제할수 없습니다");
					return;
				}
           		var tmpMSG = "삭제하시겠습니까?\n";

	            if( confirm(tmpMSG) ){
					dsT_WL_PARKING.DeleteRow(dsT_WL_PARKING.RowPosition);
					trT_WL_PARKING.KeyValue = "tr01(I:dsT_WL_PARKING=dsT_WL_PARKING)";
					trT_WL_PARKING.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD&S_MODE=DEL";
					trT_WL_PARKING.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_PARKING.ClearData();
			dsT_WL_PARKING.ClearData();
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
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
			var REQ_YMD	= document.getElementById("txtREQ_YMD").value;
			var CAR_KIND	= document.getElementById("txtCAR_KIND").value;
			var CAR_NO	= document.getElementById("txtCAR_NO").value;

			if(REQ_YMD == ""){
				alert("요청일을 입력하십시요");
				document.getElementById("txtREQ_YMD").focus();
				return;
			}
			if(CAR_KIND == ""){
				alert("차종을 입력하십시요");
				document.getElementById("txtCAR_KIND").focus();
				return;
			}
			if(CAR_NO == ""){
				alert("차량번호를 입력하십시요");
				document.getElementById("txtCAR_NO").focus();
				return;
			}
         	if ( !dsT_WL_PARKING.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_WL_PARKING.SetDataHeader(
        	        			"ENO_NO:STRING(10):KEYVALUETYPE,"+	// 사번
								"REQ_YMD:(20):KEYVALUETYPE,"+		// 요청일
        	        			"ENO_NM:STRING(20),"+			// 성명
	                            "JOB_CD:STRING(10),"+			// 직위
	                            "JOB_NM:STRING(20),"+			// 직위명
	                            "DPT_CD:STRING(10),"+			// 부서코드
	                            "DPT_NM:STRING(20),"+			// 부서명
	                            "CAR_KIND:STRING(20),"+			// 차종
	                            "CAR_NO:STRING(20),"+			// 차량번호
								"REMARK:STRING(100)"			// 비고
								);
			document.getElementById("txtENO_NO").value = "<%=eno_no%>";
			document.getElementById("txtENO_NM").value = "<%=eno_nm%>";
			document.getElementById("txtDPT_NM").value = "<%=dep_nm%>";
			document.getElementById("txtJOB_NM").value = "<%=job_nm%>";

<%
    //마스터는 모든부서 통할
    if("1001".equals(SESSION_ROLE_CD) || "1002".equals(SESSION_ROLE_CD)  ) {
%>

<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=dep_cd%>";
			document.getElementById('ImgEnoNo').style.display = "none";

<%
	}
%>

			cfStyleGrid2(form1.grdT_WL_PARKING,0,"true","false");      // Grid Style 적용

			fnc_SearchList();

        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
<%
    //마스터는 모든부서 통할
    if("1001".equals(SESSION_ROLE_CD) || "1002".equals(SESSION_ROLE_CD)  ) {
%>
            document.getElementById('hidEMPL_DPT_CD').value = "";
<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=dep_cd%>";
			document.getElementById('ImgEnoNo').style.display = "none";

<%
	}
%>

            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
				fnc_CmPerson();
            }
        }
		function fnc_CmPerson(eno_no){
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_CM_PERSON.KeyValue = "tr05(O:dsT_CM_PERSON=dsT_CM_PERSON)";
			trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_CM_PERSON.post();
		}
        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;

            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }


        //지나간 날짜인지 체크
        function fnc_ChkDate() {

            var REQ_YMD = document.getElementById("txtREQ_YMD").value.replace("-","").replace("-","");
            var today = getToday().replace("-","").replace("-","");
            if(REQ_YMD != ""){
	            if(REQ_YMD < today){
	                alert("이미 지나간 일자는 등록할수 없습니다.");
	                document.getElementById("txtREQ_YMD").value = "";
	                document.getElementById("txtREQ_YMD").focus();
	                return false;
	            }
            }

        }
		function fnc_Addr(){

		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_PARKING)			 	   |
    | 3. 사용되는 Table List(T_WL_PARKING) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_PARKING" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)			 	   |
    | 3. 사용되는 Table List(T_CM_PERSON) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_CARD)		       |
    | 3. 사용되는 Table List(T_WL_CARD)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_PARKING_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_PARKING=dsT_WL_PARKING)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_PARKING)		       |
    | 3. 사용되는 Table List(T_WL_PARKING)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_PARKING" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_PARKING=dsT_WL_PARKING)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_PARKING)		       |
    | 3. 사용되는 Table List(T_WL_PARKING)			       |
    +------------------------------------------------------>
	<Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CM_PERSON=dsT_CM_PERSON)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_PARKING Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_PARKING.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_PARKING Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_PARKING Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>


	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=trT_CM_PERSON Event="OnSuccess()">

		if (dsT_CM_PERSON.CountRow > 0)    {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NO") = dsT_CM_PERSON.NameValue(1, "ENO_NO");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NM") = dsT_CM_PERSON.NameValue(1, "ENO_NM");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_NM") = dsT_CM_PERSON.NameValue(1, "DPT_NM");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_CD") = dsT_CM_PERSON.NameValue(1, "DPT_CD");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "JOB_CD") = dsT_CM_PERSON.NameValue(1, "JOB_CD");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=trT_CM_PERSON Event="OnFail()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
		fnc_SearchList();
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_PARKING event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_PARKING_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_PARKING event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>


	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for="dsT_WL_PARKING" event=OnRowPosChanged(row)>
		var endTag = dsT_WL_PARKING.NameValue(row, "END_TAG");
		if(endTag == "T"){
			fnc_ChangeStateElement(false, "txtREMARK");
		}else{
			fnc_ChangeStateElement(true, "txtREMARK");
		}

	</script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"  onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">주말주차권신청</td>
					<td align="right" class="navigator">HOME/복리후생/주말주차권/<font color="#000000">주말주차권신청</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->




	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">사&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" class="input_ReadOnly"  readonly maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readonly maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">

                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;속</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;위</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td class="creamBold" align="center">신청일</td>
                    <td class="padding2423">
						<input id="txtREQ_YMD" name="txtREQ_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgYmd" name="ImgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtREQ_YMD','','20','120');" class="input_ReadOnly"  readonly></a>                    </td>
					<td align="center" class="creamBold">차종</td>
					<td class="padding2423"><input id="txtCAR_KIND" size="30" ></td>
					<td align="center" class="creamBold">차량번호</td>
					<td class="padding2423"><input id="txtCAR_NO" size="30" ></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">사유</td>
                    <td class="padding2423" colspan="5">
					  <input id="txtREMARK" name="txtREMARK" size="100" maxlength="100" >
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
	<p>
☞.공휴일 및 주말 전일 오후 2:00분 까지 신청요함!!!			<br>
☞.예) 15일(광복절)경우 14일 오후 2:00까지 신청가능.	<br>

	</p>
	<!-- 내용 조회 그리드 테이블 시작-->
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
	<!-- 내용 조회 그리드 데이블 끝-->


	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_PARKING" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_PARKING">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29   name="NO"		align=center	value={String(Currow)}</C>
                            <C> id="ENO_NO"     width=100  name="사번"      align=center    edit=none     show=false        </C>
							<C> id="REQ_YMD"	width=100  name="신청일"    align=center      </C>
							<C> id="CAR_KIND"   width=200  name="차종"      align=center      </C>
							<C> id="CAR_NO"     width=200  name="차량번호"  align=center      </C>
							<C> id="END_TAG"    width=100  name="발급현황"  align=center   value={DECODE(END_TAG,"T","승인완료","신청")}   </C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->
	<!-- T_WL_CARD 설정 테이블 -->
	<object id="bndT_WL_PARKING" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_PARKING">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=Value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=Value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=Value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=Value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=Value</C>
			<C>Col=CAR_KIND		Ctrl=txtCAR_KIND	Param=Value</C>
			<C>Col=CAR_NO		Ctrl=txtCAR_NO		Param=Value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=Value</C>
		">
	</object>

	<!--*************************************************************************
	* @source      : welj010.jsp												*
	* @description : 통근버스신청 PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/12/17            권혁수                     통근버스신청 최초작성
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<%
	String eno_no = box.getString("SESSION_ENONO");         //사번
	String eno_nm = box.getString("SESSION_ENONM");         //성명
	String dep_cd = box.getString("SESSION_DPTCD");         //부서
	String dep_nm = box.getString("SESSION_DPTNM");         //부서명
	String job_nm = box.getString("SESSION_JOBNM");         //직위
%>
<html>
<head>
	<title>통근버스신청(welj010)</title>
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

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;

			trT_WL_BUSAPP_SHR.KeyValue = "tr05(O:dsT_WL_BUSAPP=dsT_WL_BUSAPP)";

			trT_WL_BUSAPP_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD"
											                                   + "&S_MODE=SHR"
											                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_WL_BUSAPP_SHR.post();
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
			trT_WL_BUSAPP.KeyValue = "tr01(I:dsT_WL_BUSAPP=dsT_WL_BUSAPP)";
			trT_WL_BUSAPP.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=SAV";
			trT_WL_BUSAPP.post();
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
			dsT_WL_BUSAPP.AddRow();
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "GUBUN") = "INS";

			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "LINE_CD") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "SEQ") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "SEQ");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_LOC") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_LOC");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_TIME") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_TIME");
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_BUSAPP.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "삭제하시겠습니까?\n";

	            if( confirm(tmpMSG) ){
					dsT_WL_BUSAPP.DeleteRow(dsT_WL_BUSAPP.RowPosition);
					trT_WL_BUSAPP.KeyValue = "tr01(I:dsT_WL_BUSAPP=dsT_WL_BUSAPP)";
					trT_WL_BUSAPP.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=DEL";
					trT_WL_BUSAPP.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_BUSAPP.ClearData();
			dsT_WL_BUSAPP.ClearData();
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
			for(var i = 1; i <= dsT_WL_BUSAPP.CountRow; i++){
				if(dsT_WL_BUSAPP.NameVAlue(i, "PIS_YYMM") == ""){
					alert("년월을 입력하십시요");
					return false;
				}
				if(dsT_WL_BUSAPP.NameVAlue(i, "LINE_CD") == ""){
					alert("노선을 선택하십시요");
					return false;
				}
			}
         	if ( !dsT_WL_BUSAPP.isUpdated && !dsT_WL_BUSAPP.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			if(document.getElementById("txtFULL_GBN").value == "2" ){
				alert("만차노선입니다. 대기자 명단에 들어갑니다.");
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_WL_BUSAPP.SetDataHeader(
        	        			"ENO_NO:STRING(11):KEYVALUETYPE,"+			// 사번
								"PIS_YYMM:STRING(10):KEYVALUETYPE,"+			// 년월
	        					"LINE_CD:STRING(10),"+			// 노선코드
	        					"GUBUN:STRING(10),"+			// 노선코드
	                            "SEQ:STRING(30),"+			// 순서
	                            "PHONE:STRING(20),"+			// 소속
	                            "STOP_LOC:STRING(100),"+			// 소속
	                            "STOP_TIME:STRING(100),"+			// 구분
								"REMARK:STRING(100)"			// 비고
								);



			document.getElementById("txtENO_NO").value = "<%=eno_no%>";
			document.getElementById("txtENO_NM").value = "<%=eno_nm%>";
			document.getElementById("hidEMPL_DPT_CD").value = "<%=dep_cd%>";
			document.getElementById("txtDPT_NM").value = "<%=dep_nm%>";
			document.getElementById("txtJOB_NM").value = "<%=job_nm%>";


			cfStyleGrid2(form1.grdT_WL_BUSAPP,0,"true","false");      // Grid Style 적용

			fnc_BusLine();

			fnc_SearchList();

        }

        function fnc_BusLine() {
			trT_WL_BUSLINE.KeyValue = "tr01(O:dsT_WL_BUSLINE=dsT_WL_BUSLINE,O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSLINE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=SHR_LINE";
			trT_WL_BUSLINE.post();
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
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

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

            var PIS_YYMM = document.getElementById("txtPIS_YYMM").value.replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(PIS_YYMM != ""){
	            if(PIS_YYMM < today.substring(0,6)){
	                alert("이미 지나간 일자는 등록할수 없습니다.");
	                document.getElementById("txtPIS_YYMM").value = "";
	                document.getElementById("txtPIS_YYMM").focus();
	                return false;
	            }
            }

        }
        /******************
         * 08. 지점/시간  *
         ******************/
        function fnc_StopLoc(line) {
			trT_WL_BUSSTOP.KeyValue = "tr01(O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSSTOP.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=SHR_STOP&LINE_CD="+line;
			trT_WL_BUSSTOP.post();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_BUSAPP)			 	   |
    | 3. 사용되는 Table List(T_WL_BUSAPP) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_BUSLINE)			 	   |
    | 3. 사용되는 Table List(T_WL_BUSLINE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSLINE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_BUSSTOP)			 	   |
    | 3. 사용되는 Table List(T_WL_BUSSTOP) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSSTOP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_BUSAPP)		       |
    | 3. 사용되는 Table List(T_WL_BUSAPP)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSAPP_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSAPP=dsT_WL_BUSAPP)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_BUSAPP)		       |
    | 3. 사용되는 Table List(T_WL_BUSAPP)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_BUSAPP=dsT_WL_BUSAPP)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_BUSLINE)		       |
    | 3. 사용되는 Table List(T_WL_BUSLINE)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSLINE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSLINE=dsT_WL_BUSLINE)">
	</Object>
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_BUSLINE)		       |
    | 3. 사용되는 Table List(T_WL_BUSLINE)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSSTOP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_BUSAPP.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSAPP Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSAPP Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSAPP event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSAPP_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSAPP event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>

	<script for=trT_WL_BUSSTOP event="OnSuccess()">
		if(dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "GUBUN") == "INS"){
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "LINE_CD") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "SEQ") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "SEQ");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_LOC") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_LOC");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_TIME") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_TIME");
		}
	</script>


	<script language=JavaScript for="cmbLINE_CD" event=OnSelChange()>
		if(dsT_WL_BUSLINE.NameValue(dsT_WL_BUSLINE.RowPosition, "FULL_GBN") == "2"){
			alert("만차노선입니다");
		}
		document.getElementById("txtFULL_GBN").value = dsT_WL_BUSLINE.NameValue(dsT_WL_BUSLINE.RowPosition, "FULL_GBN");
		fnc_StopLoc(cmbLINE_CD.ValueOfIndex("LINE_CD", cmbLINE_CD.Index));

	</script>

	<script language=JavaScript for="cmbSEQ" event=OnSelChange()>
		if(dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "GUBUN") == "INS"){
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "LINE_CD") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "SEQ") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "SEQ");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_LOC") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_LOC");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_TIME") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_TIME");

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
	<input type="hidden" id="txtFULL_GBN">
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">통근버스신청</td>
					<td align="right" class="navigator">HOME/복리후생/통근버스/<font color="#000000">통근버스신청</font></td>
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
					<col width="110"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">사&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" class="input_ReadOnly"  readonly maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readonly maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
						<!--
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
						-->
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;속</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;위</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">년&nbsp;&nbsp;&nbsp;월</td>
                    <td class="padding2423">
                        <input id="txtPIS_YYMM" name="txtPIS_YYMM" size="7" maxlength="7" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgYm" name="ImgYm" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM','','20','120');"></a>
                    </td>
					<td class="creamBold" align="center">구내번호</td>
                    <td class="padding2423">
                        <input id="txtPHONE" name="txtPHONE" size="20" maxlength= "20">
                    </td>
					<td class="creamBold" align="center">사&nbsp;&nbsp;&nbsp;유</td>
					<td class="padding2423" align="left" >
						<input id="txtREMARK" name="txtREMARK" size="40" maxlength= "50">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">노&nbsp;&nbsp;&nbsp;선</td>
                    <td class="padding2423">
				<comment id="__NSID__">
				<object id=cmbLINE_CD classid="clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197" height="106" width="130">
					<param name=ComboDataID		value=dsT_WL_BUSLINE>
					<param name=SearchColumn	value=LINE_CD>
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="LINE_CD^0^30,LINE_NM^0^100">
					<param name=BindColumn		value="LINE_CD">
					<param name=EditExprFormat 	value="% - %;LINE_CD;LINE_NM">

					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					<!--
                        <select id="cmbLINE_CD" style="width='100';" onChange="fnc_StopLoc()" >
							<option value="">&nbsp;</option>
						</select>
					-->
                    </td>
					<td class="creamBold" align="center">지점/시각</td>
                    <td class="padding2423" colspan="3">
					<comment id="__NSID__">
					<object id="cmbSEQ" classid="clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197" height="106" width="400">
						<param name=ComboDataID		value="dsT_WL_BUSSTOP">
						<param name=SearchColumn	value="SEQ">
						<param name=Sort			value="True">
						<param name=ListExprFormat	value="SEQ^0^20,STOP_LOC^0^250,STOP_TIME^0^100">
						<param name=BindColumn		value="SEQ">
						<param name=EditExprFormat 	value="% - % - %;SEQ;STOP_LOC;STOP_TIME">

						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					<!--
                        <select id="cmbSTOP_LOC" style="width='300';"  >
							<option value="">&nbsp;</option>
						</select>
					-->
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

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

	<p>
	※ 통근버스노선 확인 바립니다.[업무지원팀 연락 및 신청가능여부 확인 후 신청바랍니다.]
    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)">
    <img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onclick="cfDownload('welj010.xls', '<%=FILEURL %>/welj010.xls');"></a>
    <br>
	</p>
	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_BUSAPP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_BUSAPP">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29   name="NO"		align=center	value={String(Currow)}</C>
                            <C> id="ENO_NO"     width=100  name="사번"      align=center    edit=none     show=false        </C>
                            <C> id="PIS_YYMM"   width=100  name="년월"      align=center    edit=none           </C>
							<C> id="LINE_CD"	width=100  name="노선"	    align=center	EditStyle=Lookup  Data="dsT_WL_BUSLINE:LINE_CD:LINE_NM"        </C>
							<C> id="SEQ"	    width=100  name="탑승지코드"    align=center      show=false  </C>
							<C> id="STOP_LOC"	    width=300  name="탑승지"    align=left	      </C>
							<C> id="STOP_TIME"	    width=100  name="탑승시간"    align=center	        </C>
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
	<!-- T_WL_BUSAPP 설정 테이블 -->
	<object id="bndT_WL_BUSAPP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_BUSAPP">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=Value</C>
			<C>Col=PIS_YYMM	    Ctrl=txtPIS_YYMM    Param=Value</C>
			<C>Col=PHONE		Ctrl=txtPHONE		Param=Value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=Value</C>
		">
	</object>

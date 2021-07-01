	<!--*************************************************************************
	* @source      : guna011.jsp												*
	* @description : 개인별근태등록목록 PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/10/16            권혁수                      개인별 근태신청최초작성
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //품의자사번
	String eno_nm = box.getString("SESSION_ENONM");         //품의자사번
	String dep_cd = box.getString("SESSION_DPTCD");         //품의자사번

%>


<html>
<head>
	<title>근태신청(guna011)</title>
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

			//장기근태등록 정보 조회
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var GUN_CD_SHR  = document.getElementById("cmbGUN_CD_SHR").value;
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;


			//사번이 없으면 조회못함.
			if(ENO_NO_SHR.trim().length == 0){
				alert("사번을 입력하세요.");
				document.getElementById("txtENO_NO_SHR").focus();
				return false;
			}

			//시작일자가 없으면 조회못함.
			if(STR_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작일자를 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//시작일자가 잘못되었으면 조회못함.
			if(STR_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작일자가 잘못되었습니다.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//종료일자가 없으면 조회못함.
			if(END_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료일자를 입력하세요.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//종료일자가 잘못되었으면 조회못함.
			if(END_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료일자가 잘못되었습니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//종료일자가 시작일자보다 크면 않된다.
			if(parseInt(END_YMD_SHR.replaceStr("-","")) < parseInt(STR_YMD_SHR.replaceStr("-",""))){
					alert("종료일자가 시작일자보다 빠릅니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}
			trT_DI_DILIGENCE.KeyValue = "tr05(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna012.cmd.GUNA012CMD"
                                   + "&S_MODE=SHR_LST"
                                   + "&ENO_NO_SHR="+ENO_NO_SHR
                                   + "&STR_YMD_SHR="+STR_YMD_SHR
                                   + "&END_YMD_SHR="+END_YMD_SHR
                                   + "&GUN_CD_SHR="+GUN_CD_SHR
                                  // + "&GUN_STS_SHR="+GUN_STS_SHR
                                   + "&EMPL_DPT_CD="+EMPL_DPT_CD;
			trT_DI_DILIGENCE.post();
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
        	dsT_DI_DILIGENCE.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	        dsT_DI_DILIGENCE.SetDataHeader(
								"DPT_CD:STRING(10),"+			// 시작일자
	        					"REG_NO:STRING(10),"+			// 등록번호
	                            "DPT_NM:STRING(20),"+			// 소속
								"JOB_NM:STRING(20),"+			// 직위
								"ENO_NO:STRING(10),"+			// 사번
								"ENO_NM:STRING(10),"+			// 성명
								"CNT:STRING(10),"			// 진행여부
								);

			document.getElementById("txtENO_NO_SHR").value="<%=eno_no%>";
			document.getElementById("txtENO_NM_SHR").value="<%=eno_nm%>";

			cfStyleGrid2(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style 적용
            //cfStyleGrid(form1.grdT_DI_DILIGENCE,15,"true","false");      // Grid Style 적용

        	// 근태(입력)
        	var h4_cd = "";
        	// 근태(조회)
			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {

                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE")
                /* 2009.09.16 권혁수 수정*/
                if(h4_cd == "A" || h4_cd == "B" || h4_cd == "C" || h4_cd == "D" || h4_cd == "Y" ||
                   h4_cd == "W" || h4_cd == "M" || h4_cd == "N" || h4_cd == "O" || h4_cd == "X" || h4_cd == "9"){
                    continue;
                }

				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUN_CD_SHR").add(oOption);
			}

			document.getElementById("txtSTR_YMD_SHR").value = getToday();
			document.getElementById("txtEND_YMD_SHR").value = next_month(getToday())+"-"+getToday().substring(8);


<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");


<%//A 는 자기부서만 통할
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	    document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";
	    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");
<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";
            fnc_ChangeStateElement(false, "ImgEnoNoSHR");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");


<%
	}
%>
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
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNmSHR() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Application() {
                //선택된 ROW를 dsT_DI_CHANGE_CP 복사하여 guna061에 dsT_DI_CHANGE_CP 넘겨준다.
    			cfCopyDataSet(dsT_DI_DILIGENCE, dsT_DI_DILIGENCE_CP, "copyHeader=yes,rowFrom=0,rowCnt=0");
    			var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
    			var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
				var param = "str_ymd_shr="+str_ymd_shr+"&end_ymd_shr="+end_ymd_shr;
    			window.showModalDialog("/hr/gun/guna012.jsp?MODE=INS&"+param, dsT_DI_DILIGENCE_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

                fnc_SearchList();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)			 	   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 카피용 DataSet                             |
    | 2. 이름 : dsT_DI_DILIGENCE_CP                  |
    | 3. Table List : T_DI_DILIGENCE                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>


    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_SG"/>
       <jsp:param name="CODE_GUBUN"    value="SG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_SF"/>
       <jsp:param name="CODE_GUBUN"    value="SF"/>
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
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);
        }
		/*
		for(var i=1; i<=dsT_DI_DILIGENCE.countrow; i++){
			if(dsT_DI_DILIGENCE.NameValue(i,"APP_YN_NM") == "부결"){
				grdT_DI_DILIGENCE.ColumnProp('APP_YN_NM', 'BgColor') = "Red";
			}
		}
		*/
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

  </script>


    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_DILIGENCE event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {

			//선택된 ROW를 dsT_DI_CHANGE_CP 복사하여 guna061에 dsT_DI_CHANGE_CP 넘겨준다.
			cfCopyDataSet(dsT_DI_DILIGENCE, dsT_DI_DILIGENCE_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");
			var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
			var param = "str_ymd_shr="+str_ymd_shr+"&end_ymd_shr="+end_ymd_shr;
			window.showModalDialog("/hr/gun/guna012.jsp?MODE=READ&"+param, dsT_DI_DILIGENCE_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();

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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태신청</td>
					<td align="right" class="navigator">HOME/기초정보/개인정보/<font color="#000000">근태신청</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApplication','','/images/button/btn_ApplicationOver.gif',1)"><img src="/images/button/btn_ApplicationOn.gif" name="imgApplication" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Application()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" 보ellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0"  cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="30"></col>
							<col width="220"></col>
							<col width="30"></col>
							<col width="170"></col>
							<col width="30"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">기간</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','108','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','224','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>

							<td class="searchState" align="right">사번</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
                        		<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
                        		<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
							</td>

							<td class="searchState" align="right">근태</td>
							<td class="padding2423" align="left">
								<select id="cmbGUN_CD_SHR" style="width='100';" onChange="fnc_SearchList()">
									<option value="0">모두</option>
								</select>
							</td>
						<!--
							<td class="searchState" align="right">종료여부</td>
							<td class="padding2423" align="left">
								<select id="cmbGUN_STS_SHR"  style="width='70';" onChange="fnc_SearchList()">
									<option value="0">모두</option>
									<option value="1">미진행</option>
									<option value="2">진행중</option>
									<option value="3">완료</option>
								</select>
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
					<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
						<param name="DataID" value="dsT_DI_DILIGENCE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="REQ_NO"		width=75	name="등록번호"		align=center	Edit=none    </C>
							<C> id="DPT_NM"		width=100   name="소속"			align=center	Edit=none    </C>
							<C> id="JOB_NM"		width=50	name="직위"			align=center	Edit=none    </C>
                            <C> id="ENO_NO"     width=70    name="사번"         align=center    Edit=none    </C>
                            <C> id="ENO_NM"     width=70    name="성명"         align=center    Edit=none    </C>
                            <C> id="CNT"        width=70    name="개수"         align=center    Edit=none    </C>
							<C> id="APP_YN_NM"  width=200   name="결재여부"     align=center    Edit=none  BgColor={Decode(APP_YN_NM,"부결","#FEB293")}  </C>
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

	<input type="hidden" id="txtDPT_CD">
	<input type="hidden" id="txtJOB_CD">
	</form>
	<!-- form 끝 -->
</body>
</html>

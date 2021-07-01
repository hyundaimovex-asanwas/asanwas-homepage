	<!--*************************************************************************
	* @source      : adva010.jsp												*
	* @description : 사내공모내용입력 PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27            채갑병          	        최초작성									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>사내공모내용입력(adva010)</title>
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

		var today = getToday();
		var btnList = 'TTTTTFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
			var END_YN_SHR  = document.getElementById("cmbEND_YN_SHR").value;

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

			dsT_EV_ADVTBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva010.cmd.ADVA010CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&END_YN_SHR="+END_YN_SHR;
			dsT_EV_ADVTBOOK.reset();
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
			trT_EV_ADVTBOOK.KeyValue = "tr01(I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)";
			trT_EV_ADVTBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva010.cmd.ADVA010CMD&S_MODE=SAV";
			trT_EV_ADVTBOOK.post();
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
            if (dsT_EV_ADVTBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ADVTBOOK.GridToExcel("사내공모내용입력", '', 225)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_EV_ADVTBOOK.CountColumn == 0) {
				dsT_EV_ADVTBOOK.setDataHeader("ORD_NO:STRING, DPT_CD:STRING, DPT_NM:STRING, STR_YMD:STRING, END_YMD:STRING, FROM_JOB_CD:STRING, TO_JOB_CD:STRING, REMARK:STRING    ,FIELD_DIS:STRING   ,JOB_DIS:STRING ,CONDITION_DIS:STRING   ,AREA_DIS:STRING");
			}

			dsT_EV_ADVTBOOK.AddRow();

			fnc_EnableElementAll(oAllElementList)

			document.form1.cmbFROM_JOB_CD.selectedIndex      = 0;
			document.form1.cmbTO_JOB_CD.selectedIndex      = 0;
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
	        if (dsT_EV_ADVTBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "다음 사내공모 항목을 삭제하시겠습니까?\n"+
                             "삭제시 개인별 신청항목도 동시에 삭제됩니다.\n\n";
            	tmpMSG += "관리번호  = "+dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "ORD_NO")+"\n";
            	tmpMSG += "공모부서  = "+dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "DPT_NM")+"\n";

	            if( confirm(tmpMSG) ){
					var ORD_NO = dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "ORD_NO");
					var DPT_CD = dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "DPT_CD");

					dsT_EV_ADVTBOOK.DeleteRow(dsT_EV_ADVTBOOK.RowPosition);

					// 파라미터 추가
					trT_EV_ADVTBOOK.Parameters = "ORD_NO="+ORD_NO+",DPT_CD="+DPT_CD;

					trT_EV_ADVTBOOK.KeyValue = "tr02(I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)";
					trT_EV_ADVTBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva010.cmd.ADVA010CMD&S_MODE=DEL";
					trT_EV_ADVTBOOK.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
  			for(var i=2; i<=3; i++){
  				document.form1.elements[i].value = "";
  			}

  			disableInput();
	        document.getElementById("resultMessage").innerText = ' ';

			// 콤보박스 기본 선택
			document.form1.cmbFROM_JOB_CD.selectedIndex      = 0;
			document.form1.cmbTO_JOB_CD.selectedIndex      = 0;
			document.form1.cmbEND_YN_SHR.selectedIndex  = 0;

        	dsT_EV_ADVTBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_EV_ADVTBOOK.IsUpdated)  {
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
         	if ( !dsT_EV_ADVTBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			document.getElementById("txtSTR_YMD_SHR").value = getToday().substring(0,8)+"01";
			document.getElementById("txtEND_YMD_SHR").value = getToday();

            // 직위 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbFROM_JOB_CD").add(oOption);
			}

			// 직위 구분 검색 콤보박스2 생성
			for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbTO_JOB_CD").add(oOption);
			}


			cfStyleGrid(form1.grdT_EV_ADVTBOOK,15,"false","false");      // Grid Style 적용
			disableInput();
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

        //입력필드들 정의
        var oElementList    = new Array("txtSTR_YMD"
                                       ,"txtEND_YMD"
                                       ,"imgSTR_YMD"
                                       ,"imgEND_YMD"
                                       ,"cmbFROM_JOB_CD"
                                       ,"cmbTO_JOB_CD"
                                       ,"txtFIELD_DIS"
                                       ,"txtJOB_DIS"
                                       ,"txtREMARK"
                                       ,"txtCONDITION_DIS"
                                       ,"txtAREA_DIS");

        var oAllElementList = new Array("txtSTR_YMD"
                                       ,"txtEND_YMD"
                                       ,"imgSTR_YMD"
                                       ,"imgEND_YMD"
                                       ,"imgDPT_CD"
                                       ,"txtDPT_CD"
                                       ,"cmbFROM_JOB_CD"
                                       ,"cmbTO_JOB_CD"
                                       ,"txtFIELD_DIS"
                                       ,"txtJOB_DIS"
                                       ,"txtREMARK"
                                       ,"txtCONDITION_DIS"
                                       ,"txtAREA_DIS");

         /********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	fnc_EnableElementAll(oElementList);

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	fnc_DisableElementAll(oAllElementList);
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
         * 접수시작일자에서 포커스 떠날때 종료일자와 비교  	 *
         ********************************************/
		function cfCheckDateTermADVA010(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("접수종료일자가 접수시작일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
				if( cfDateDiff(getToday().replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("현재일자가 접수종료일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
			}
		}

		/********************************************
         * 공모종료 여부에 따라 필드 활성화 처리 	   		*
         ********************************************/
		function checkAdvtStatus(row){
			var status = dsT_EV_ADVTBOOK.NameValue(row, "END_YN");
			if( status == "T" ){  // 접수중
				enableInput();
			}else{                // 접수종료
				disableInput();
			}
		}

		/********************************************
         * 선택한 공모에 해당하는 신청자 목록조회(popup-adva030.jsp)*
         ********************************************/
		function fnc_viewList(){
			// 신청자 수
			var ADV_CNT = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"ADV_CNT");

			if (dsT_EV_ADVTBOOK.CountRow < 1) {
				alert("조회할 신청서가 없습니다.");
				return;
			}
			if( ADV_CNT == "0"){
				alert("조회할 신청자가 없습니다.");
				return;
			}

			var ORD_NO = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"ORD_NO"); // 관리번호
			var DPT_CD = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"DPT_CD"); // 소속

			var url = "/hr/adv/adva030.jsp?&ORD_NO="+ORD_NO+"&DPT_CD="+DPT_CD;
			window.showModalDialog(url, new Object(), "dialogWidth:870px; dialogHeight:480px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			//fnc_SearchList();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ADVTBOOK)			   |
    | 3. 사용되는 Table List(T_EV_ADVTBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_ADVTBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ADVTBOOK)		       |
    | 3. 사용되는 Table List(T_EV_ADVTBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_EV_ADVTBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK,I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->

    <!-- 직위 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="TA2"/>
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
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ADVTBOOK.CountRow);

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


	<Script For=dsT_TACCCOD_BK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnFail()">
        alert(trT_EV_ADVTBOOK.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_EV_ADVTBOOK event=CanRowPosChange(row)>
		if ( dsT_EV_ADVTBOOK.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_EV_ADVTBOOK.GetHdrDispName('-3','STR_YMD') + " ]은 필수 입력사항입니다");
			document.getElementById("txtSTR_YMD").focus();
			return false;
		}
		if ( dsT_EV_ADVTBOOK.NameValue(row,"END_YMD") == "" ) {
			alert("[ " + grdT_EV_ADVTBOOK.GetHdrDispName('-3','END_YMD') + " ]은 필수 입력사항입니다");
			document.getElementById("txtEND_YMD").focus();
			return false;
		}
		if ( dsT_EV_ADVTBOOK.NameValue(row,"DPT_CD") == "" ) {
			alert("[ 공모부서 ]는 필수 입력사항입니다");
			document.getElementById("txtDPT_CD").focus();
			return false;
		}
		if ( dsT_EV_ADVTBOOK.NameValue(row,"DPT_NM") == "" ) {
			alert("[ " + grdT_EV_ADVTBOOK.GetHdrDispName('-3','DPT_CD') + " ]의 값이 잘못되었습니다. 확인해 주세요.");
			return false;
		}

	</script>

	<!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리			   |
    +------------------------------------------------------>
	<script language="javascript"  for=dsT_EV_ADVTBOOK event=OnRowPosChanged(row)>
		checkAdvtStatus(row);
        if (document.getElementById("txtADV_CNT").value == "0") {
            fnc_HiddenElement("imgListView");
        }
        else{
            fnc_ShowElement("imgListView");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사내공모내용입력</td>
					<td align="right" class="navigator">HOME/인사평가/사내공모/<font color="#000000">사내공모내용입력</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
							<col width="70"></col>
							<col width="230"></col>
							<col width="70"></col>
							<col width="170"></col>
							<col width="70"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">접수기간</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','60','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">공모부서</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
								</a>
							</td>
							<td class="searchState" align="right">종료여부</td>
							<td class="padding2423" align="left">
								<select id="cmbEND_YN_SHR" style="width:100" onChange="fnc_SearchList()">
									<option value="0">전체</option>
									<option value="1">진행</option>
									<option value="2">종료</option>
								</select>
							</td>
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
			<col width="75"></col>
			<col width="165"></col>
			<col width="75"></col>
			<col width="165"></col>
			<col width="75"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">접수기간</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','58','152');"></a>
				 ~
				<input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermADVA010('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD','','168','152');"></a>
			</td>

            <td align="center" class="creamBold">응시자수</td>
            <td class="padding2423">
                <input id="txtADV_CNT" size="6" class="input_ReadOnly" readonly">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgListView','','/images/button/btn_ListViewOver.gif',1)"><img src="/images/button/btn_ListViewOn.gif" name="imgListView" width="80" height="20" border="0" align="absmiddle" onClick="fnc_viewList();"></a>
            </td>

		</tr>
		<tr>
            <td align="center" class="creamBold">관리번호</td>
            <td class="padding2423" align="left"><input id="txtORD_NO" size="15" class="input_ReadOnly" readonly></td>

            <td align="center" class="creamBold">공모부서</td>
            <td class="padding2423">
                <input id="txtDPT_CD" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM')">
                <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD','','/images/button/btn_HelpOver.gif',1)">
                    <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','소속','DEPT')">
                </a>
            </td>
			<td align="center" class="creamBold">대상직위</td>
			<td class="padding2423">
				<select id="cmbFROM_JOB_CD" style="width:45%">
				<option value=""></option>
				</select>
				~
				<select id="cmbTO_JOB_CD" style="width:45%">
				<option value=""></option>
				</select>
			</td>
		</tr>
        <tr>
            <td align="center" class="creamBold">모집분야</td>
            <td class="padding2423"><input id="txtFIELD_DIS" style="22" maxLength="10"></td>
            <td align="center" class="creamBold">주요업무</td>
            <td class="padding2423"><input id="txtJOB_DIS" size="22" maxLength="10"></td>
            <td align="center" class="creamBold">자격요건</td>
            <td class="padding2423"><input id="txtREMARK" size="22" maxLength="10"></td>
        </tr>
        <tr>
            <td align="center" class="creamBold">우대자격</td>
            <td class="padding2423"><input id="txtCONDITION_DIS" size="22" maxLength="10"></td>
            <td align="center" class="creamBold">근무지</td>
            <td class="padding2423" colspan="3"><input id="txtAREA_DIS" size="22" maxLength="10"></td>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_EV_ADVTBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_EV_ADVTBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width="40"		name="NO"				align="center"	value={String(Currow)}</C>
							<C> id="ORD_NO"		width="70"		name="관리번호"			align="center"	Edit=none</C>
							<C> id="STR_YMD"	width="70"		name="접수시작일"		align="center"	Edit=none</C>
							<C> id="END_YMD"	width="70"		name="접수종료일"		align="center"	Edit=none</C>
							<C> id="DPT_NM"		width="110"		name="공모부서"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_NM"		width="130"		name="대상직위"			align="center"	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"</C>
							<C> id="FIELD_DIS"  width="140"		name="모집분야"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_DIS"	width="140"		name="주요업무"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="REMARK"		width="140"		name="자격요건"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="CONDITION_DIS"	width="140"	name="우대자격"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="AREA_DIS"	width="100"		name="근무지"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="ADV_CNT"	width="55"		name="응시자수"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="END_YN"		width="60"		name="진행여부"			align="center"	Edit=none	value={decode(END_YN, "T", "진행중", "종료")}</C>
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
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_EV_ADVTBOOK 설정 테이블 -->
	<object id="bndT_EV_ADVTBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_ADVTBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=ORD_NO			Ctrl=txtORD_NO			Param=value</C>
			<C>Col=DPT_CD			Ctrl=txtDPT_CD			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=STR_YMD			Ctrl=txtSTR_YMD			Param=value</C>
			<C>Col=END_YMD			Ctrl=txtEND_YMD			Param=value</C>
			<C>Col=FROM_JOB_CD	    Ctrl=cmbFROM_JOB_CD		Param=value</C>
			<C>Col=TO_JOB_CD	    Ctrl=cmbTO_JOB_CD		Param=value</C>
			<C>Col=JOB_NM			Ctrl=cmbJOB_CD			Param=value</C>
            <C>Col=FIELD_DIS        Ctrl=txtFIELD_DIS       Param=value</C>
            <C>Col=JOB_DIS          Ctrl=txtJOB_DIS         Param=value</C>
            <C>Col=REMARK           Ctrl=txtREMARK          Param=value</C>
            <C>Col=CONDITION_DIS    Ctrl=txtCONDITION_DIS   Param=value</C>
            <C>Col=AREA_DIS         Ctrl=txtAREA_DIS        Param=value</C>
			<C>Col=ADV_CNT			Ctrl=txtADV_CNT			Param=value</C>
		">
	</object>
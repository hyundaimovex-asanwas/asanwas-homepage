	<!--*************************************************************************
	* @source      : proa020.jsp												*
	* @description : 승진배점관리 PAGE	 								  		*
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/29            채갑병            	최초작성						*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>승진배점관리(proa020)</title>
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

		var btnList = 'TTTTFFTT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	if( document.form1.txtPMT_YMD_SHR.value=="" ){
        		alert("승진년도를 입력하십시오. 예)"+next_yy);
        		return;
        	}
        	if( document.form1.txtPMT_YMD_SHR.value.length != 4 ){
        		alert("승진년도를 바르게 입력하십시오. 예)"+next_yy);
        		return;
        	}
        	
			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;
			var OCC_CD_SHR  = document.form1.cmbOCC_CD_SHR.value;
			var JOB_CD_SHR  = document.form1.txtJOB_CD_SHR.value;
			
			dsT_PM_PMTALLOT.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa020.cmd.PROA020CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR;
			dsT_PM_PMTALLOT.reset();
			
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
			trT_PM_PMTALLOT.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa020.cmd.PROA020CMD&S_MODE=SAV";
			trT_PM_PMTALLOT.post();
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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_PM_PMTALLOT.CountColumn == 0) {
				dsT_PM_PMTALLOT.setDataHeader("OCC_CD:STRING, PJOB_CD:STRING, PJOB_NM:STRING, STR_YMD:STRING, END_YMD:STRING, FJOB_CD:STRING, FJOB_NM:STRING, GOG_PNT:STRING, JPT_PNT:STRING, EDU_PNT:STRING, GUN_PNT:STRING, CEN_PNT:STRING, SUM_PNT:STRING, SAN_PNT:STRING");
			}

            enableInput();            
			dsT_PM_PMTALLOT.AddRow();
			document.form1.cmbOCC_CD.selectedIndex = 0;
			document.form1.cmbOCC_CD.focus();
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
	        if (dsT_PM_PMTALLOT.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "근로구분        = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "OCC_NM")+"\n";
            	tmpMSG += "현직위     = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "PJOB_NM")+"\n";
            	tmpMSG += "승진직위 = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "FJOB_NM")+"\n";
            	tmpMSG += "시작일    = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "STR_YMD")+"\n";
            	tmpMSG += "종료일    = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "END_YMD");
            	
	            if( confirm(tmpMSG) ){
					var OCC_CD  = dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "OCC_CD");
					var PJOB_CD = dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "PJOB_CD");
					var STR_YMD = dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "STR_YMD");
				
					dsT_PM_PMTALLOT.DeleteRow(dsT_PM_PMTALLOT.RowPosition);
					// 파라미터 추가
					trT_PM_PMTALLOT.Parameters = "OCC_CD="+OCC_CD+",PJOB_CD="+PJOB_CD+",STR_YMD="+STR_YMD;
				
					trT_PM_PMTALLOT.KeyValue = "tr02(I:dsT_PM_PMTALLOT=dsT_PM_PMTALLOT)";
					trT_PM_PMTALLOT.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa020.cmd.PROA020CMD&S_MODE=DEL";
					trT_PM_PMTALLOT.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
  			
			document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
			
        	disableInput();
        	
        	document.getElementById("resultMessage").innerText = ' ';
        	//document.form1.txtPMT_YMD_SHR.value = next_yy;
        	dsT_PM_PMTALLOT.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PMTALLOT.IsUpdated)  {
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
         	if (!dsT_PM_PMTALLOT.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			
			return true;
        }
        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        
            // 근로구분 구분 검색 콤보박스 생성(검색)
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			
            // 근로구분 구분 검색 콤보박스 생성(입력)
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD").add(oOption);
			}
			
			disableInput();
			document.form1.txtPMT_YMD_SHR.value = next_yy;
			cfStyleGrid(form1.grdT_PM_PMTALLOT,15,"true","false");      // Grid Style 적용
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
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		  	for(var i=5; i<19; i++){
  		  		if( i== 5 ) continue; // 현직위코드
  		  		if( i== 6 ) continue; // 현직위명
  		  		if( i== 8 ) continue; // 승진직위명
  		  		if( i== 9 ) continue; // 시작일
  		  		if( i== 16 ) continue; // 총점
  		  		
				document.form1.elements[i].readOnly = false;
	 			document.form1.elements[i].className = ""; 
  			}
  			//document.getElementById("cmbOCC_CD").disabled   = false;
  			//document.getElementById("img_HelpOn2").disabled = false;  // 현직위 검색
  			document.getElementById("img_HelpOn3").disabled = false;  // 승진직위 검색
  			//document.getElementById("imgSTR_YMD").disabled  = false;  // 시작일
  			document.getElementById("imgEND_YMD").disabled  = false;  // 종료일
  		}
  		
        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  		  	for(var i=5; i<19; i++){
				document.form1.elements[i].readOnly = true;
	 			document.form1.elements[i].className = "input_ReadOnly"; 
  			}
  			document.getElementById("cmbOCC_CD").disabled   = true;
  			document.getElementById("img_HelpOn2").disabled = true;  // 현직위 검색
  			document.getElementById("img_HelpOn3").disabled = true;  // 승진직위 검색
  			document.getElementById("imgSTR_YMD").disabled  = true;  // 시작일
  			document.getElementById("imgEND_YMD").disabled  = true;  // 종료일
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
         * 종료일자에서 포커스 떠날때 신청일자와 비교       		*
         ********************************************/       
		function cfCheckDateTermPROA020(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("종료일자가 시작일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
			}
		}
		
  		/********************************************
         * 총합계 계산	                       			*
         ********************************************/
        function setTotal() {
        	var GOG_PNT = document.form1.txtGOG_PNT.value;
        	var JPT_PNT = document.form1.txtJPT_PNT.value;
        	var EDU_PNT = document.form1.txtEDU_PNT.value;
        	var GUN_PNT = document.form1.txtGUN_PNT.value;
        	var CEN_PNT = document.form1.txtCEN_PNT.value;
        	
        	if(GOG_PNT=="") GOG_PNT = "0";
        	if(JPT_PNT=="") JPT_PNT = "0";
        	if(EDU_PNT=="") EDU_PNT = "0";
        	if(GUN_PNT=="") GUN_PNT = "0";
        	if(CEN_PNT=="") CEN_PNT = "0";
        	
        	if(GOG_PNT != "" && JPT_PNT != "" && EDU_PNT != "" && GUN_PNT != "" && CEN_PNT != ""){
	        	document.form1.txtSUM_PNT.value = eval(GOG_PNT+"+"+JPT_PNT+"+"+EDU_PNT+"+"+GUN_PNT+"+"+CEN_PNT);
        	}
        }
        
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_PMTALLOT)			   |
    | 3. 사용되는 Table List(T_PM_PMTALLOT) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PMTALLOT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_PM_PMTALLOT)			   |
    | 3. 사용되는 Table List(T_PM_PMTALLOT)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_PMTALLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_PMTALLOT=dsT_PM_PMTALLOT,I:dsT_PM_PMTALLOT=dsT_PM_PMTALLOT)">
	</Object>
	
    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
	<Script For=dsT_PM_PMTALLOT Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PMTALLOT.CountRow);
			enableInput();
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PMTALLOT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PMTALLOT Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PMTALLOT event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PMTALLOT event="OnFail()">
        alert(trT_PM_PMTALLOT.ErrorMsg);
    </script>
     
	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_PM_PMTALLOT event=CanRowPosChange(row)>
		if ( dsT_PM_PMTALLOT.NameValue(row,"OCC_CD") == "" ) {
			alert("[ " + grdT_PM_PMTALLOT.GetHdrDispName('-3','OCC_CD') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_PM_PMTALLOT.NameValue(row,"PJOB_CD") == "" ) {
			alert("[ " + grdT_PM_PMTALLOT.GetHdrDispName('-3','PJOB_CD') + " ]는 필수 입력사항입니다");
			return false;
		}
		if ( dsT_PM_PMTALLOT.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_PM_PMTALLOT.GetHdrDispName('-3','STR_YMD') + " ]은 필수 입력사항입니다");
			return false;
		}
		if( document.form1.txtSUM_PNT.value != "100" ){
			alert("총점이 100점이 아닙니다.");
			return false;
		}
		
	</script>
	
	
<script language=JavaScript for=dsT_PM_PMTALLOT event=OnRowPosChanged(row)>

        if(dsT_PM_PMTALLOT.SysStatus(row) == "1"){
            document.getElementById("txtPJOB_CD").readOnly = false;//현직위코드
            document.getElementById("txtPJOB_CD").className = "";  //현직위코드
            document.getElementById("txtSTR_YMD").readOnly = false;//시작일
            document.getElementById("txtSTR_YMD").className = "";//시작일
                            
            document.getElementById("cmbOCC_CD").disabled   = false;
            document.getElementById("img_HelpOn2").disabled = false;  // 현직위 검색
            document.getElementById("imgSTR_YMD").disabled  = false;  // 시작일
            
        }else{
            document.getElementById("txtPJOB_CD").readOnly = true;//현직위코드
            document.getElementById("txtPJOB_CD").className = "input_ReadOnly";  //현직위코드
            document.getElementById("txtSTR_YMD").readOnly = true;//시작일
            document.getElementById("txtSTR_YMD").className = "input_ReadOnly";//시작일
                            
            document.getElementById("cmbOCC_CD").disabled   = true;
            document.getElementById("img_HelpOn2").disabled = true;  // 현직위 검색
            document.getElementById("imgSTR_YMD").disabled  = true;  // 시작일
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승진배점관리</td>
					<td align="right" class="navigator">HOME/인사관리/승진/<font color="#000000">승진배점관리</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->
	
	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">승진년도&nbsp;</td>
					<td class="padding2423" align="left">
	                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
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
					<td class="searchState" align="right">근로구분&nbsp;</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="width:80;">
							<option value="0">모두</option>
						</select>
					</td>
					<td class="searchState" align="right">직위&nbsp;</td>
					<td class="padding2423" align="left">
					    <input id=txtJOB_CD_SHR size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');">
						<input id=txtJOB_NM_SHR size="10" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')"></a>
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
			<col width="100"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="85"></col>
			<col width="60"></col>
			<col width="85"></col>
			<col width="60"></col>
			<col width=""></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">근로구분</td>
			<td class="padding2423">
				<select id="cmbOCC_CD" style="width:80;"></select>
			</td>
			<td align="center" class="creamBold">현직위</td>
			<td class="padding2423" colspan="3">
			    <input id="txtPJOB_CD" name="txtPJOB_CD" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A2', 'txtPJOB_CD','txtPJOB_NM')">
				<input type="text" id="txtPJOB_NM" size="10" class="input_ReadOnly"  readOnly>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtPJOB_CD','txtPJOB_NM','직위','A2')"></a>
			</td>
			<td align="center" class="creamBold">승진직위</td>
			<td class="padding2423" colspan="3">
			    <input id="txtFJOB_CD" name="txtFJOB_CD" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A2', 'txtFJOB_CD','txtFJOB_NM')">
				<input type="text" id="txtFJOB_NM" size="10" class="input_ReadOnly"  readOnly>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtFJOB_CD','txtFJOB_NM','직위','A2')"></a>
			</td>
		</tr>
		<tr>
            <td align="center" class="creamBold">시작일</td>
            <td class="padding2423">
                <input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA020('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','30','176');"></a>
            </td>
            <td align="center" class="creamBold">종료일</td>
            <td class="padding2423">
                <input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA020('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD','','200','176');"></a>
            </td>
			<td align="center" class="creamBold">인사고과</td>
			<td class="padding2423"><input id="txtGOG_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
			<td align="center" class="creamBold">근속기간</td>
			<td class="padding2423"><input id="txtJPT_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
			<td align="center" class="creamBold">교육</td>
			<td class="padding2423"><input id="txtEDU_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
		</tr>
		<tr>
            <td align="center" class="creamBold">근태</td>
            <td class="padding2423"><input id="txtGUN_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
            <td align="center" class="creamBold">추천</td>
            <td class="padding2423"><input id="txtCEN_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
			<td align="center" class="creamBold">총점</td>
			<td class="padding2423"><input id="txtSUM_PNT" size="8" maxlength="3" style="text-align:right"></td>
			<td align="center" class="creamBold">상벌</td>
			<td class="padding2423"><input id="txtSAN_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
            <td align="center" class="creamBold">승진년수</td>
            <td class="padding2423"><input id="txtBAS_YY" size="8" maxlength="3" style="text-align:right"></td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	
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
					<object id="grdT_PM_PMTALLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" value="dsT_PM_PMTALLOT">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=34	name="NO"		align=center	value={String(Currow)}      </C>
							<C> id="OCC_CD"			width=50	name="근로구분"		align=center	Edit=none	 EditStyle=Lookup  Data="dsT_CM_COMMON_A1:CODE:CODE_NAME" </C>
							<C> id="PJOB_CD"		width=50	name="현직위"	align=center	Edit=none	 show="false"   </C>
							<C> id="PJOB_NM"		width=50	name="현직위"	align=center	Edit=none	                </C>
							<C> id="FJOB_CD"		width=50	name="승진직위"	align=center	Edit=none	 show="false"   </C>
							<C> id="FJOB_NM"		width=50	name="승진직위"	align=center	Edit=none	                </C>
							<C> id="STR_YMD"		width=70	name="시작일"	align=center	Edit=none                   </C>
							<C> id="END_YMD"		width=70	name="종료일"	align=center	Edit=none                   </C>
							<C> id="GOG_PNT"		width=55	name="인사고과"	align=right		Edit=none	             	</C>
							<C> id="JPT_PNT"		width=55	name="근속기간"	align=right		Edit=none	             	</C>
							<C> id="EDU_PNT"		width=55	name="교육"		align=right		Edit=none	             	</C>
							<C> id="GUN_PNT"		width=55	name="근태"		align=right		Edit=none	             	</C>
							<C> id="CEN_PNT"		width=55	name="추천"		align=right		Edit=none	             	</C>
							<C> id="SUM_PNT"		width=55	name="총계"		align=right		Edit=none	             	</C>
							<C> id="SAN_PNT"		width=55	name="상벌(±)"	align=right		Edit=none	 	            </C>
							<C> id="BAS_YY" 		width=55	name="기준년수"	align=right		Edit=none	 	            </C>
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

	<!-- T_PM_PMTALLOT 설정 테이블 -->
	<object id="bndT_PM_PMTALLOT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_PMTALLOT">
		<Param Name="BindInfo", Value="
			<C>Col=OCC_CD		Ctrl=cmbOCC_CD		Param=value</C>
			<C>Col=PJOB_CD		Ctrl=txtPJOB_CD		Param=value</C>
			<C>Col=PJOB_NM		Ctrl=txtPJOB_NM		Param=value</C>
			<C>Col=FJOB_CD		Ctrl=txtFJOB_CD		Param=value</C>
			<C>Col=FJOB_NM		Ctrl=txtFJOB_NM		Param=value</C>
			<C>Col=STR_YMD		Ctrl=txtSTR_YMD		Param=value</C>
			<C>Col=END_YMD		Ctrl=txtEND_YMD		Param=value</C>
			<C>Col=GOG_PNT		Ctrl=txtGOG_PNT		Param=value</C>
			<C>Col=JPT_PNT		Ctrl=txtJPT_PNT		Param=value</C>
			<C>Col=EDU_PNT		Ctrl=txtEDU_PNT		Param=value</C>
			<C>Col=GUN_PNT		Ctrl=txtGUN_PNT		Param=value</C>
			<C>Col=CEN_PNT		Ctrl=txtCEN_PNT		Param=value</C>
			<C>Col=SUM_PNT		Ctrl=txtSUM_PNT		Param=value</C>
			<C>Col=SAN_PNT		Ctrl=txtSAN_PNT		Param=value</C>
			<C>Col=BAS_YY 		Ctrl=txtBAS_YY		Param=value</C>
		">
	</object>
	<!--*************************************************************************
	* @source      : proa130.jsp												*
	* @description : 상벌점수관리 PAGE	 								  			*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/29            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>상벌점수관리(proa130)</title>
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

		var btnList = 'TTTTFFTT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var REPU_CD = "K1";  // 포상/징계 구분에 따라 코드 변환(K1, K2)
		var REPU_NM = "포상";

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

			dsT_PM_REWARD.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa130.cmd.PROA130CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR;
			dsT_PM_REWARD.reset();

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
			trT_PM_REWARD.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa130.cmd.PROA130CMD&S_MODE=SAV";
			trT_PM_REWARD.post();
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
			if (dsT_PM_REWARD.CountColumn == 0) {
				dsT_PM_REWARD.setDataHeader("REPU_CD:STRING, REPU_TAG:STRING, REPU_TAG_NM:STRING, STR_YMD:STRING, END_YMD:STRING, ANS_TAG:STRING, ANS_CNT:STRING");
			}

			enableInput();
			dsT_PM_REWARD.AddRow();
			document.form1.cmbREPU_CD.selectedIndex = 0;
			document.form1.cmbANS_TAG.selectedIndex = 0;
			fnc_ChgRepuCombo();
			document.form1.cmbREPU_CD.focus();
			
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
	        if (dsT_PM_REWARD.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "상벌      = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_NM")+"\n";
            	tmpMSG += "종류      = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_TAG_NM")+"\n";
            	tmpMSG += "시작일   = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "STR_YMD")+"\n";
            	tmpMSG += "종료일   = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "END_YMD");

	            if( confirm(tmpMSG) ){
					var REPU_CD  = dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_CD");
					var REPU_TAG = dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_TAG");
					var STR_YMD  = dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "STR_YMD");

					dsT_PM_REWARD.DeleteRow(dsT_PM_REWARD.RowPosition);
					// 파라미터 추가
					trT_PM_REWARD.Parameters = "REPU_CD="+REPU_CD+",REPU_TAG="+REPU_TAG+",STR_YMD="+STR_YMD;

					trT_PM_REWARD.KeyValue = "tr02(I:dsT_PM_REWARD=dsT_PM_REWARD)";
					trT_PM_REWARD.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa130.cmd.PROA130CMD&S_MODE=DEL";
					trT_PM_REWARD.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

        	disableInput();

        	document.getElementById("resultMessage").innerText = ' ';
        	//document.form1.txtPMT_YMD_SHR.value = next_yy;
        	dsT_PM_REWARD.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_REWARD.IsUpdated)  {
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
         	if (!dsT_PM_REWARD.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			disableInput();
        	document.form1.txtPMT_YMD_SHR.value = next_yy;
			cfStyleGrid(form1.grdT_PM_REWARD,15,"true","false");      // Grid Style 적용
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
  		  	for(var i=2; i<8; i++){
  		  		if(i==2) continue; // 코드
                if(i==3) continue; // 코드명
                if(i==4) continue; // 시작일

				document.form1.elements[i].readOnly = false;
	 			document.form1.elements[i].className = "";
  			}
  			//document.getElementById("cmbREPU_CD").disabled  = false;  // 포상/징계 구분
  			document.getElementById("cmbANS_TAG").disabled  = false;  // 가점/감점 구분
  			//document.getElementById("img_HelpOn2").disabled = false;  // 코드 검색
  			//document.getElementById("imgSTR_YMD").disabled  = false;  // 시작일
  			document.getElementById("imgEND_YMD").disabled  = false;  // 종료일
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  		  	for(var i=2; i<8; i++){
  		  		if(i==6) continue; // 가감 콤보
				document.form1.elements[i].readOnly = true;
	 			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.getElementById("cmbREPU_CD").disabled  = true;  // 포상/징계 구분
  			document.getElementById("cmbANS_TAG").disabled  = true;  // 가점/감점 구분
  			document.getElementById("img_HelpOn2").disabled = true;  // 코드 검색
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
		function cfCheckDateTermPROA130(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("종료일자가 시작일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
			}
		}

  		/********************************************
         * 상벌구분에따른 코드목록 변환	       			*
         ********************************************/
        function fnc_ChgRepuCombo() {
        	if(document.form1.cmbREPU_CD.selectedIndex == 0){
        		REPU_CD = "K1"; // 포상
        		REPU_NM = "포상";
        	}else{
        		REPU_CD = "K2"; // 징계
        		REPU_NM = "징계";
        	}
        }

  		/********************************************
         * 코드종류 선택 팝업			       			*
         ********************************************/
        function fnc_RepuPop() {
	        fnc_commonCodePopup('txtREPU_TAG','txtREPU_TAG_NM',REPU_NM, REPU_CD);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_REWARD)			   |
    | 3. 사용되는 Table List(T_PM_REWARD) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_REWARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_PM_REWARD)			   |
    | 3. 사용되는 Table List(T_PM_REWARD)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_REWARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_REWARD=dsT_PM_REWARD,I:dsT_PM_REWARD=dsT_PM_REWARD)">
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
	<Script For=dsT_PM_REWARD Event="OnLoadCompleted(iCount)">
		if (iCount == 0){
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_REWARD.CountRow);
			enableInput();
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_REWARD Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_REWARD Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_PM_REWARD event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_REWARD event="OnFail()">
        alert(trT_PM_REWARD.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_PM_REWARD event=CanRowPosChange(row)>
		if ( dsT_PM_REWARD.NameValue(row,"REPU_CD") == "" ) {
			alert("[ " + grdT_PM_REWARD.GetHdrDispName('-3','REPU_CD') + " ]는 필수 입력사항입니다");
			return false;
		}
		if ( dsT_PM_REWARD.NameValue(row,"REPU_TAG") == "" ) {
			alert("[ " + grdT_PM_REWARD.GetHdrDispName('-3','REPU_TAG') + " ]는 필수 입력사항입니다");
			return false;
		}
		if ( dsT_PM_REWARD.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_PM_REWARD.GetHdrDispName('-3','STR_YMD') + " ]은 필수 입력사항입니다");
			return false;
		}
	</script>

    <!-----------------------------------------------------+
    | Grid 클릭시 승진여부에 따른 라디오버튼 매핑				   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_PM_REWARD event=OnClick(row,colid)>
		fnc_ChgRepuCombo();
	</script>
	
    <script language=JavaScript for=dsT_PM_REWARD event=OnRowPosChanged(row)>

        if(dsT_PM_REWARD.SysStatus(row) == "1"){
            document.getElementById("txtREPU_TAG").readOnly = false;//코드
            document.getElementById("txtREPU_TAG").className = "";  //코드
            document.getElementById("txtSTR_YMD").readOnly = false;//시작일
            document.getElementById("txtSTR_YMD").className = "";//시작일
            
            document.getElementById("cmbREPU_CD").disabled  = false;  // 포상/징계 구분
            document.getElementById("img_HelpOn2").disabled = false;  // 코드 검색
            document.getElementById("imgSTR_YMD").disabled  = false;  // 시작일
            
        }else{
            document.getElementById("txtREPU_TAG").readOnly = true;//코드
            document.getElementById("txtREPU_TAG").className = "input_ReadOnly";  //코드
            document.getElementById("txtSTR_YMD").readOnly = true;//시작일
            document.getElementById("txtSTR_YMD").className = "input_ReadOnly";//시작일
                            
            document.getElementById("cmbREPU_CD").disabled   = true;
            document.getElementById("img_HelpOn2").disabled = true;  // 현직위 검색
            document.getElementById("imgSTR_YMD").disabled  = true;  // 시작일
        }
        
    </script>        

	<!--**************************************************************************************
    *                                                                                        *
	*	BODY START                                                                           *
    *                                                                                        *
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">상벌점수관리</td>
					<td align="right" class="navigator">HOME/인사관리/승진/<font color="#000000">상벌점수관리</font></td>
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
			<col width="180"></col>
			<col width="60"></col>
			<col width="120"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">상벌</td>
			<td class="padding2423">
				<select id="cmbREPU_CD" style="width:90%;" onChange="fnc_ChgRepuCombo();">
					<option value="H">포상</option>
					<option value="P">징계</option>
				</select>
			</td>
			<td align="center" class="creamBold">코드</td>
			<td class="padding2423">
				<input type="text" id="txtREPU_TAG" size="4"> <input type="text" id="txtREPU_TAG_NM" size="14" class="input_ReadOnly"  readOnly>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_RepuPop()"></a>
			</td>
			<td align="center" class="creamBold">시작일</td>
			<td class="padding2423">
				<input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA130('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','384','98');"></a>
			</td>
			<td align="center" class="creamBold">종료일</td>
			<td class="padding2423">
				<input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA130('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD','','384','98');"></a>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">가감</td>
			<td class="padding2423">
				<select id="cmbANS_TAG" style="width:90%;">
					<option value="1">가점</option>
					<option value="2">감점</option>
				</select>
			</td>
			<td align="center" class="creamBold">점수</td>
			<td class="padding2423" colspan="5">
				<input type="text" id="txtANS_CNT" size="4" maxLength="3" style="text-align:right">
			</td>
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
					<object id="grdT_PM_REWARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
						<param name="DataID" value="dsT_PM_REWARD">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=29	name="NO"		align=center	value={String(Currow)}   </C>
							<C> id="REPU_CD"		width=80	name="상벌"		align=center	Edit=none	value={decode(REPU_CD, "H", "포상", "P", "징계")}</C>
							<C> id="REPU_TAG"		width=70	name="코드"		align=center	Edit=none	             </C>
							<C> id="REPU_TAG_NM"	width=185	name="종류"		align=left		Edit=none	             </C>
							<C> id="STR_YMD"		width=120	name="시작일"	align=center	Edit=none                </C>
							<C> id="END_YMD"		width=120	name="종료일"	align=center	Edit=none                </C>
							<C> id="ANS_TAG"		width=80	name="가감"		align=center	Edit=none	value={decode(ANS_TAG, 1, "가점", 2, "감점")}    </C>
							<C> id="ANS_CNT"		width=80	name="점수"		align=right		Edit=none	             </C>
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

	<!-- T_PM_REWARD 설정 테이블 -->
	<object id="bndT_PM_REWARD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_REWARD">
		<Param Name="BindInfo", Value="
			<C>Col=REPU_CD		Ctrl=cmbREPU_CD			Param=value</C>
			<C>Col=REPU_TAG		Ctrl=txtREPU_TAG		Param=value</C>
			<C>Col=REPU_TAG_NM	Ctrl=txtREPU_TAG_NM		Param=value</C>
			<C>Col=STR_YMD		Ctrl=txtSTR_YMD			Param=value</C>
			<C>Col=END_YMD		Ctrl=txtEND_YMD			Param=value</C>
			<C>Col=ANS_TAG		Ctrl=cmbANS_TAG			Param=value</C>
			<C>Col=ANS_CNT		Ctrl=txtANS_CNT			Param=value</C>
		">
	</object>
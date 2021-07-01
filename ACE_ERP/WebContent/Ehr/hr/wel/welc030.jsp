	<!--*************************************************************************
	* @source      : welc030.jsp												*
	* @description : 건강검진 장부관리 PAGE										*
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/07            채갑병         	        최초작성									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>건강검진 장부관리(welc030)</title>
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

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
		
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//건겅검진 장부 정보 조회
			var CHIT_YMD_STDT_SHR = document.getElementById("txtCHIT_YMD_STDT_SHR").value;
			var CHIT_YMD_ENDT_SHR = document.getElementById("txtCHIT_YMD_ENDT_SHR").value;
			
			var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;
			
			dsT_WL_BODYBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc030.cmd.WELC030CMD&S_MODE=SHR&CHIT_YMD_STDT_SHR="+CHIT_YMD_STDT_SHR+"&CHIT_YMD_ENDT_SHR="+CHIT_YMD_ENDT_SHR+"&ENO_NM_SHR="+ENO_NM_SHR;
			dsT_WL_BODYBOOK.reset();
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
			trT_WL_BODYBOOK.KeyValue = "tr01(I:dsT_WL_BODYBOOK=dsT_WL_BODYBOOK)";
			trT_WL_BODYBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc030.cmd.WELC030CMD&S_MODE=SAV";
			trT_WL_BODYBOOK.post();
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
			if (dsT_WL_BODYBOOK.CountColumn == 0) {
				dsT_WL_BODYBOOK.setDataHeader("ORD_NO:STRING(8), SEQ_NO:STRING(4), CHIT_YMD:STRING, ENO_NM:STRING, CHIT_TXT:STRING, CHIT_AMT:INT(7)");
			}
			dsT_WL_BODYBOOK.AddRow();
			
			document.medCHIT_AMT.Text = "";
			document.getElementById("txtORD_NO").focus();
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
	        if (dsT_WL_BODYBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
		 		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
	           	tmpMSG += "검진일자  = "+dsT_WL_BODYBOOK.nameValue(dsT_WL_BODYBOOK.RowPosition, "CHIT_YMD2")+"\n";
	           	tmpMSG += "검진대상  = "+dsT_WL_BODYBOOK.nameValue(dsT_WL_BODYBOOK.RowPosition, "ENO_NM")+"\n";
	           	
				if( confirm(tmpMSG) ){
					var ENO_NO = dsT_WL_BODYBOOK.nameValue(dsT_WL_BODYBOOK.RowPosition, "ENO_NO");
					var CHIT_YMD2 = dsT_WL_BODYBOOK.nameValue(dsT_WL_BODYBOOK.RowPosition, "CHIT_YMD2");
				
					dsT_WL_BODYBOOK.DeleteRow(dsT_WL_BODYBOOK.RowPosition);
					// 파라미터 추가
					trT_WL_BODYBOOK.Parameters = "ENO_NO="+ENO_NO+",CHIT_YMD2="+CHIT_YMD2;
					
					trT_WL_BODYBOOK.KeyValue = "tr02(I:dsT_WL_BODYBOOK=dsT_WL_BODYBOOK)";
					trT_WL_BODYBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc030.cmd.WELC030CMD&S_MODE=DEL";
					trT_WL_BODYBOOK.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {     
        
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
        
  			document.getElementById("resultMessage").innerText = ' ';

            fnc_DisableElementAll(elementList);
        	dsT_WL_BODYBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_BODYBOOK.IsUpdated)  {
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
         	if (!dsT_WL_BODYBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }
        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_WL_BODYBOOK,15,"true","false");      // Grid Style 적용
            
            document.getElementById("txtCHIT_YMD_STDT_SHR").value = getStrDate();
            document.getElementById("txtCHIT_YMD_ENDT_SHR").value = getEndDate();
            
            fnc_DisableElementAll(elementList);
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}
        
        var elementList = new Array( "txtORD_NO"
                                    ,"txtSEQ_NO"
                                    ,"txtCHIT_YMD"
                                    ,"txtCHIT_YMD2"
                                    ,"ImgCHIT_YMD"
                                    ,"ImgCHIT_YMD2"
                                    ,"txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtCHIT_TXT"
                                    ,"medCHIT_AMT"      
                                    );
        
        var exceptionList = new Array(
                                     "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtCHIT_YMD2"
                                    ,"ImgCHIT_YMD2"
                                    );
  		
		/********************************************
         * 전표번호 입력시 커서 이동                           			*
         ********************************************/
		function nextFocus(field, next){
			var nextObj = document.getElementById(next);
			if(field.value.length==8){
				nextObj.focus();
			}
		}
		function prevFocus(field, prev){
			var prevObj = document.getElementById(prev);
			if(event.keyCode==8 && field.value.length==0){
				prevObj.focus();
				var r = prevObj.createTextRange();
				r.moveEnd('textedit');
				r.text = prevObj.value;
			}
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
            if(document.getElementById("txtENO_NO").value != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
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
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_BODYBOOK)			 	   |
    | 3. 사용되는 Table List(T_WL_BODYBOOK) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BODYBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_BODYBOOK)			       |
    | 3. 사용되는 Table List(T_WL_BODYBOOK)				       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BODYBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BODYBOOK=dsT_WL_BODYBOOK,I:dsT_WL_BODYBOOK=dsT_WL_BODYBOOK)">
	</Object>
    
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_BODYBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_BODYBOOK.CountRow);
        }
    </Script>
    
	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BODYBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BODYBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BODYBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_BODYBOOK event="OnFail()">
        alert(trT_WL_BODYBOOK.ErrorMsg);
    </script>
    
 	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_WL_BODYBOOK event=CanRowPosChange(row)>
		if ( dsT_WL_BODYBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_WL_BODYBOOK.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}else if ( dsT_WL_BODYBOOK.NameValue(row,"CHIT_YMD2") == "" ) {
			alert("[ " + grdT_WL_BODYBOOK.GetHdrDispName('-3','CHIT_YMD2') + " ]는 필수 입력사항입니다");
			return false;
		}
	</script>   
    
    
    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_BODYBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            if(dsT_WL_BODYBOOK.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">건강검진 장부관리</td>
					<td align="right" class="navigator">HOME/복리후생/건강검진/<font color="#000000">건강검진 장부관리</font></td>
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
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="60"></col>
                            <col width="250"></col>
                            <col width="70"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">전표일자</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtCHIT_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCHIT_YMD_STDT_SHR','','91','148');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~ 
                                <input type="text" id="txtCHIT_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCHIT_YMD_ENDT_SHR','','206','148');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td align="right" class="searchState">검진대상</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
					<col width="60"></col>
					<col width="110"></col>
					<col width="60"></col>
					<col width="97"></col>
					<col width="60"></col>
					<col width="85"></col>
					<col width="37"></col>
					<col width="90"></col>
					<col width="37"></col>
					<col width=""></col>
				</colgroup>
                <tr>
                    <td align="center" class="creamBold">검진대상</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>   
                    <td align="center" class="creamBold">부&nbsp;&nbsp;서</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
                    </td>                                        
                    <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
                    </td>                                        
                </tr>                
				<tr>
                    <td align="center" class="creamBold">검진일자</td>
                    <td class="padding2423">
                        <input type="text" id="txtCHIT_YMD2" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHIT_YMD2','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="ImgCHIT_YMD2" name="ImgCHIT_YMD2" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtCHIT_YMD2','','263','101');"></a>
                    </td>                
					<td align="center" class="creamBold">관리번호</td>
					<td class="padding2423">
						<input id="txtORD_NO" size="8" maxlength="8" onKeyUp="javascript:nextFocus(this,'txtSEQ_NO');"> - <input id="txtSEQ_NO" size="4" maxlength="4" style="ime-mode:disabled" onKeyUp="javascript:prevFocus(this, 'txtORD_NO');">
					</td>
					<td align="center" class="creamBold">전표일자</td>
					<td class="padding2423">
						<input type="text" id="txtCHIT_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHIT_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="ImgCHIT_YMD" name="ImgCHIT_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtCHIT_YMD','','263','101');"></a>
					</td>

					<td align="center" class="creamBold">비용</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medCHIT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=DisabledBackColor		value="#EEEEEE">
										<param name=Enable					value=true>
										<param name=IsComma					value=true>
										<param name=Language				value=0>
										<param name=MaxLength				value=7>
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
                    <td align="center" class="creamBold">내용</td>
                    <td class="padding2423" colspan="7">
                        <input id="txtCHIT_TXT" size="18" maxlength="10" style="text-align:left">
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
					<object id="grdT_WL_BODYBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_BODYBOOK">
						<param name="Editable" value="false">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=55	name="N0"			align=center	value={String(Currow)}</C>
                            <C> id="ENO_NM"     width=80    name="검진대상"     align=center    Edit=none</C>
                            <C> id="CHIT_YMD2"  width=80   name="검진일자"      align=center    Edit=none</C>   
							<C> id="ORD_NO"		width=80	name="관리번호"		align=center	Edit=none</C>
                            <C> id="SEQ_NO"     width=60   name="일련번호"      align=center    Edit=none</C>
							<C> id="CHIT_YMD"	width=80	name="전표일자"		align=center	Edit=none</C>
							<C> id="CHIT_TXT"	width=210	name="내용"			align=left 		Edit=none	LeftMargin=10</C>
							<C> id="CHIT_AMT"	width=120   name="비용"			align=right		Edit=none	RightMargin=10</C>
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

	<!-- T_WL_BODYBOOK 설정 테이블 -->
	<object id="bndT_WL_BODYBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_BODYBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=ORD_NO		Ctrl=txtORD_NO		Param=value</C>
			<C>Col=SEQ_NO		Ctrl=txtSEQ_NO		Param=value</C>
			<C>Col=CHIT_YMD		Ctrl=txtCHIT_YMD	Param=value</C>
			<C>Col=CHIT_YMD2	Ctrl=txtCHIT_YMD2	Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=CHIT_TXT		Ctrl=txtCHIT_TXT	Param=value</C>
			<C>Col=CHIT_AMT		Ctrl=medCHIT_AMT	Param=text</C>
		">
	</object>
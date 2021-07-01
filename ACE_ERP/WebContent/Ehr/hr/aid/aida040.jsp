	<!--*************************************************************************
	* @source      : aida040.jsp												*
	* @description : 경공조금 장부관리 PAGE 										*
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/13            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>경공조금 장부관리(aida040)</title>
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
			//경공조금 장부 조회
			var FIN_YMD_STDT_SHR = document.getElementById("txtFIN_YMD_STDT_SHR").value;
			var FIN_YMD_ENDT_SHR = document.getElementById("txtFIN_YMD_ENDT_SHR").value;
			
			dsT_AD_AIDBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=SHR&FIN_YMD_STDT_SHR="+FIN_YMD_STDT_SHR+"&FIN_YMD_ENDT_SHR="+FIN_YMD_ENDT_SHR;
			dsT_AD_AIDBOOK.reset();
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
			trT_AD_AIDBOOK.KeyValue = "tr01(I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)";
			trT_AD_AIDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=SAV";
			trT_AD_AIDBOOK.post();
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
            if (dsT_AD_AIDBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AD_AIDBOOK.GridToExcel("경공조금 장부관리", '', 225);
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_AD_AIDBOOK.CountColumn == 0) {
				dsT_AD_AIDBOOK.setDataHeader("FIN_YMD:STRING, FIN_SEQ:STRING, CD_GBN:STRING, CD_TAG:STRING, FIN_RSN:STRING, FIN_IN:INT, FIN_OUT:INT, FIN_AMT:INT");
			}
			
			// 행 추가
			dsT_AD_AIDBOOK.AddRow();
            
            //값들 초기화
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_YMD")    = getToday();
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN")     = "3";          //경공조금은 수입,지출이 고정되어 있음 '3' 예금이자
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_TAG")     = "U";          //사용자 입력
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
	        if ( dsT_AD_AIDBOOK.CountRow < 1 ) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
                var CD_GBN = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN");
                var CD_TAG = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_TAG");
                var fin_nm;
                if(CD_TAG != 'U') {
                    alert("해당 데이터는 삭제할 수 없습니다.");
                    return;
                }
                
                if(CD_GBN == '1') fin_nm = "수입";
                else if(CD_GBN == '2') fin_nm = "지출";
                else if(CD_GBN == '3') fin_nm = "이자";
            
            	var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "날짜 = "+dsT_AD_AIDBOOK.nameValue(dsT_AD_AIDBOOK.RowPosition, "FIN_YMD")+"\n";
            	tmpMSG += "SEQ = "+dsT_AD_AIDBOOK.nameValue(dsT_AD_AIDBOOK.RowPosition, "FIN_SEQ")+"\n";
                tmpMSG += fin_nm+" = "+document.getElementById("medFIN_INOUT").Text+"\n";
            	
				if(!confirm(tmpMSG) ){
                    return;
				}
                
                dsT_AD_AIDBOOK.DeleteRow(dsT_AD_AIDBOOK.RowPosition);
                
                trT_AD_AIDBOOK.KeyValue = "tr01(I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)";
                trT_AD_AIDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=DEL";
                trT_AD_AIDBOOK.post();
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
	        document.medFIN_INOUT.Text = "";
	        document.form1.cmbCD_GBN.selectedIndex = 0;
	        document.getElementById("resultMessage").innerText = ' ';
	        
        	fnc_DisableElementAll(elementList);
        	dsT_AD_AIDBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_AD_AIDBOOK.IsUpdated)  {
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
        	if (!dsT_AD_AIDBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			trT_AD_AIDBOOK.KeyValue = "tr04(I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)";
			trT_AD_AIDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=SAV";
			trT_AD_AIDBOOK.post();	
        }
        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            document.getElementById("txtFIN_YMD_STDT_SHR").value = getStrDate();
            document.getElementById("txtFIN_YMD_ENDT_SHR").value = getEndDate();
        
			cfStyleGrid(form1.grdT_AD_AIDBOOK,15,"true","false");      // Grid Style 적용
			fnc_DisableElementAll(elementList);
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}
        
        
        //입력창 이름들
        var elementList = new Array(    "txtFIN_YMD"
                                       ,"imgFIN_YMD"
                                       ,"cmbCD_GBN"
                                       ,"txtFIN_RSN"
                                       ,"medFIN_INOUT" );
                                       
        //제외할 입력창들
        var exceptionList = new Array(  "txtFIN_YMD"
                                       ,"imgFIN_YMD" );
  
        /**
         * 입력된 금액을 EMEdit Component 에 바인딩 시킨다.
         */
        function bindFIN_INOUT() {
            var CD_GBN      = document.getElementById("cmbCD_GBN").value;
            var FIN_IN_OUT  = document.getElementById("medFIN_INOUT").Text;
            
            //해당 row의 금액 값을 비우고 값을 바인딩
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_IN") = "";
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_OUT") = "";
            
            if(CD_GBN == "2") {
                // 수입 -> 지출 로 변경시 바인딩 정보 변경
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_OUT      Ctrl=medFIN_INOUT   Param=text  </C>"
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>"
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>"
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
                                         
                dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_OUT") = FIN_IN_OUT;
            } else {
                // 지출 -> 수입 으로 변경시 바인딩 정보 변경
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_IN       Ctrl=medFIN_INOUT   Param=text  </C>" 
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>" 
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>" 
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
                                         
                dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_IN") = FIN_IN_OUT;
            }
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN") = CD_GBN;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDBOOK)			   |
    | 3. 사용되는 Table List(T_AD_AIDBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDBOOK)			   |
    | 3. 사용되는 Table List(T_AD_AIDBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK,I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		//저장 후 잔액이 변경되므로 재조회 시킴
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDBOOK event="OnFail()">
        alert(trT_AD_AIDBOOK.ErrorMsg);
    </script>
    
	<!-----------------------------------------------------+
    | Grid 클릭시 수입/지출에 따른 바인딩 변경 					   |
    +------------------------------------------------------>     
	<script language=JavaScript for=dsT_AD_AIDBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            var CD_GBN = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN");
            var CD_TAG = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_TAG");
            

            
            //신규일 경우        
            if(dsT_AD_AIDBOOK.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else if(CD_TAG == 'U'){
                fnc_EnableElementAll(elementList, exceptionList);
            }
            
            //구분은 변경되지 않음 경고조금 장부에선 수입, 지출이 고정되어 있음
            fnc_ChangeStateElement(false, "cmbCD_GBN");
        
            //금액을 바인딩 시킨다.
            if(CD_GBN == "2") {
                // 수입 -> 지출 로 변경시 바인딩 정보 변경
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_OUT      Ctrl=medFIN_INOUT   Param=text  </C>"
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>"
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>"
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
            } else {
                // 지출 -> 수입 으로 변경시 바인딩 정보 변경
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_IN       Ctrl=medFIN_INOUT   Param=text  </C>" 
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>" 
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>" 
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
            }
            
        }
	</script>
	
	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_AD_AIDBOOK event=CanRowPosChange(row)>
        if(row > 0) {
    		if ( dsT_AD_AIDBOOK.NameValue(row, "FIN_YMD") == '' ) {
    			alert("[ " + grdT_AD_AIDBOOK.GetHdrDispName('-3','FIN_YMD')+" ] 를 입력하십시오.");
    			return false;
    		}else if( dsT_AD_AIDBOOK.NameValue(row, "CD_GBN") == '' ){
    			alert("[ " + grdT_AD_AIDBOOK.GetHdrDispName('-3','CD_GBN')+" ] 를 입력하십시오.");
    			return false;
    		}else if( (dsT_AD_AIDBOOK.NameValue(row,"FIN_IN") == 0 && dsT_AD_AIDBOOK.NameValue(row,"FIN_OUT") == 0) ){
    			alert("금액을 입력하십시오.");
    			return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">경공조금 장부관리</td>
					<td align="right" class="navigator">HOME/복리후생/경공조금/<font color="#000000">경공조금 장부관리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>                
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
                            <col width="560"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">조회기간</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtFIN_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIN_YMD_STDT_SHR','','107','143');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~ 
                                <input type="text" id="txtFIN_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIN_YMD_ENDT_SHR','','222','143');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
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
			<table width="100%" height="30" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="60"></col>
					<col width="110"></col>
					<col width="60"></col>
					<col width="80"></col>
					<col width="60"></col>
					<col width="180"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">날짜</td>
					<td class="padding2423">
						<input type="text" id="txtFIN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFIN_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgFIN_YMD" name="imgFIN_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtFIN_YMD','','95','98');"></a>
					</td>
					<td align="center" class="creamBold">구분</td>
					<td class="padding2423">
						<select id="cmbCD_GBN" style="WIDTH:60px" onChange="bindFIN_INOUT()">
							<option value="1">수입</option>
							<option value="2">지출</option>
							<option value="3">이자</option>
						</select>
					</td>
					<td align="center" class="creamBold">적요</td>
					<td class="padding2423">
						<input type="text" id="txtFIN_RSN" size="30" maxlength="30">
					</td>
					<td align="center" class="creamBold">금액</td>
					<td>
						<table width="100%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medFIN_INOUT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=DisabledBackColor		value="#EEEEEE">
										<param name=Enable					value=true>
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
					<object id="grdT_AD_AIDBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AD_AIDBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=60	name="순번"	align=center	value={String(Currow)}</C>
							<C> id="FIN_YMD"	width=90	name="날짜"	align=center	Edit=none</C>
							<C> id="FIN_SEQ"	width=55	name="SEQ"	align=center	Edit=none</C>
							<C> id="CD_GBN"	    width=40	name="구분"	align=center	Edit=none    value={decode(CD_GBN, "1", "수입", "2", "지출", "3", "이자")}</C>
							<C> id="FIN_RSN"	width=190	name="적요"	align=center	Edit=none</C>
							<C> id="FIN_IN"		width=110	name="수입"	align=right		Edit=none	RightMargin=10</C>
							<C> id="FIN_OUT"	width=110	name="지출"	align=right 	Edit=none	RightMargin=10</C>
							<C> id="FIN_AMT"	width=110	name="잔액"	align=right		Edit=none	RightMargin=10</C>
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

	<!-- T_AD_AIDBOOK 설정 테이블 -->
	<object id="bndT_AD_AIDBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDBOOK">
		<Param Name="BindInfo", Value="
			
		">
	</object>

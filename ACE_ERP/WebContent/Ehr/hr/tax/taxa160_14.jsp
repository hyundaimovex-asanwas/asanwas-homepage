	<!--*************************************************************************
	* @source      : taxa160.jsp												*
	* @description : 근로소득원천징수영수증
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2015/03/12          이동훈             	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>근로소득원천징수영수증(taxa160)</title>
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

		var btnList = 'TFFTTTFT';
		var year = getToday().substring(0,4);

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {


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
			//이곳에 해당 코딩을 입력 하세요
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
			var PIS_YY   = document.getElementById("txtPIS_YY_SHR").value;
			var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var PRT_GBN  = fnc_GetCheckedValue("rdoPRT_GBN");

			if(!fnc_SearchItemCheck()) return;//필수 조회조건 체크

			var url = "taxa160_14_PV.jsp"
                    + "?PIS_YY="+PIS_YY
                    + "&ENO_NO="+ENO_NO
                    + "&STP_GBN=1"  	  			//1직인출력, 2직인생략
                    + "&PRT_GBN="+PRT_GBN 	  	//발행구분
                    + "&SEND_PARM=1";

			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

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
			document.getElementById("txtPIS_YY_SHR").value      = year;
			document.getElementById("txtENO_NO_SHR").value      = "";
            document.getElementById("txtDPT_CD_SHR").value      = "";
            document.getElementById("txtENO_NM_SHR").value      = "";
            document.getElementById("txtDPT_NM_SHR").value      = "";
            document.getElementById("txtSTR_YMD_SHR").value     = "";

            document.getElementsByName("rdoSTP_GBN")[0].checked = true;
            document.getElementsByName("rdoTAX_GBN")[0].checked = true;
            document.getElementsByName("rdoPRT_GBN")[0].checked = true;
            document.getElementsByName("rdoTYPE")[2].checked    = true;

            document.getElementById("chkOCC_CD_A").checked      = true;
            document.getElementById("chkOCC_CD_M").checked      = false;

        	document.getElementById("resultMessage").innerText = ' ';
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
       		if( document.form1.txtPIS_YY_SHR.value=="" ){
       			alert("기준년도를 입력하십시오.");
       			document.form1.txtPIS_YY_SHR.focus();
        		return false;
        	}
       		/*
       		if( document.form1.txtENO_NO_SHR.value=="" ){
       			alert("사원번호를 입력하십시오.");
       			document.form1.txtENO_NO_SHR.focus();
        		return false;
        	}
        	*/
        	return true;
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            
        	document.form1.txtPIS_YY_SHR.value = "2014";

        	//document.getElementsByName("rdoTYPE")[2].checked    = true;

<%
    //관리자나 인사 관리자 이면 정상 검색하고 일반유저이면 자기사번만 검색
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			fnc_ChangeStateElement(false, "txtPIS_YY_SHR");
            fnc_ChangeStateElement(false, "ImgDptCdShr");
            fnc_ChangeStateElement(false, "rdoTYPE");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";            
            
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

            document.getElementById('txtENO_NO_SHR').value = "<%=box.get("SESSION_ENONO") %>";
            document.getElementById('txtENO_NM_SHR').value = "<%=box.get("SESSION_ENONM") %>";
<%
    }
%>

        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

	   }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
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
    </script>
</head>




	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->



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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">원천징수영수증_2014</td>
					<td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">소득증명원출력 - 원천징수영수증_2014</font>
				</td>
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
	        <!--  
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	        -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>

                <tr>
                    <td align="right" class="searchState">정산구분&nbsp;</td>
                    <td class="padding2423">
                        <input type="radio" class="noview" name="rdoTAX_GBN" value="8" checked>&nbsp;연말정산
                        <!--<input type="radio" class="noview" name="rdoTAX_GBN" value="9">&nbsp;퇴직자정산 -->
                    </td>
                </tr>

                <tr><td height="15"></td></tr>

                <tr>
                    <td class="searchState" align="right">정산년도&nbsp;</td>
                    <td class="padding2423" align="left">
                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="40" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4" class="input_ReadOnly" readonly>
                                </td>
                                
                                <!--  
                                <td style="height:9px; padding-left:0px; border-style:none">
                                <img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none">
                                <img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            
                            	-->
                            	</tr>
                        </table>
                    </td>
					<!--  
                    <td align="right" class="searchState">신고일자&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','410','150');"></a>
                    </td>
                    -->
                </tr>

                <tr><td height="15"></td></tr>

                <tr>
                    <td align="right" class="searchState">발행구분&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="1" checked>&nbsp;소득자보관용
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="2">&nbsp;발행자보고용
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="3">&nbsp;발행자보관용
                    </td>
                </tr>

                <tr><td height="15"></td></tr>
				
				<!--  
                <tr>
                    <td align="right" class="searchState">직인여부&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="1" checked>&nbsp;직인출력
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="2">&nbsp;직인생략
                    </td>
                </tr>
                <tr><td height="15" colspan="4"></td></tr>
				-->

                <tr>
                    <td align="right" class="searchState">출력조건&nbsp;</td>
                    <td align="left" colspan="3">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <!--  
                            <tr>
                                <td align="left" class="searchState">
                                    <input type="radio" class="noview" name="rdoTYPE" value="O" checked>&nbsp;근로구분
                                </td>
                                <td class="padding2423">
                                    <input type="checkbox" class="noview" name="chkOCC_CD_A" checked style="DISPLAY:none">&nbsp;사무직
                                    &nbsp;&nbsp;&nbsp;
                                    <input type="checkbox" class="noview" name="chkOCC_CD_M" style="DISPLAY:none">
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="left" class="searchState">
                                    <input type="radio" class="noview" name="rdoTYPE" value="D">&nbsp;부서
                                </td>
                                <td class="padding2423">
                                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="10" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCdShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCdShr" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                </td>
                            </tr>
                            -->
                            <tr>
                                <td align="left" class="searchState">
                                    <input type="radio" class="noview" name="rdoTYPE" value="E"  checked>&nbsp;사번
                                </td>
                                <td class="padding2423">
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchList();"onblur="fnc_SearchList();" style="ime-mode:disabled"> 
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchList();"onblur="fnc_SearchList();"> 
							<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							<input type="hidden" id="hidEMPL_DPT_CD">
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



	</form>
	<!-- form 끝 -->

</body>
</html>


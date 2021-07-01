	<!--*************************************************************************
	* @source      : adva040.jsp												*
	* @description : 개인별신청현황 PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/06            채갑병          	        최초작성									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>개인별신청현황(adva040)</title>
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

		var today = getToday();
		var btnList = 'TFFTFFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
		 	var ENO_NO_SHR  = document.getElementById("txtENO_NO_SHR").value;

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

			dsT_EV_ADVTLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva040.cmd.ADVA040CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_EV_ADVTLIST.reset();
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
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_EV_ADVTLIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ADVTLIST.GridToExcel("개인별신청현황", '', 225)
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
  			for(var i=2; i<6; i++){
  				document.form1.elements[i].value = "";
  			}

	        document.getElementById("resultMessage").innerText = ' ';

        	dsT_EV_ADVTLIST.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_EV_ADVTLIST.IsUpdated)  {
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
	        //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

		 	cfStyleGrid(form1.grdT_EV_ADVTLIST,15,"false","false");      // Grid Style 적용

			document.getElementById("txtSTR_YMD_SHR").value = getToday().substring(0,8)+"01";
			document.getElementById("txtEND_YMD_SHR").value = getToday();

		 	cfStyleGrid(form1.grdT_EV_ADVTLIST,15,"true","false");      // Grid Style 적용

		 	document.getElementById("txtENO_NO_SHR").value = "<%=box.get("SESSION_ENONO") %>";
<%
            if(box.getString("SESSION_ADV_AUTHO").equals("M")) {
%>
            document.getElementById("txtENO_NO_SHR").value= "";
            document.getElementById("txtENO_NM_SHR").value ="";
            document.getElementById("txtENO_NM_SHR").className = "";
            document.getElementById("txtENO_NM_SHR").readOnly = false;
            document.getElementById("imgENO_NO_SHR").disabled = false;
            document.getElementById("imgENO_NO_SHR").style.display = "";
<%
    } else {

%>

           document.getElementById("txtENO_NO_SHR").value = "<%=box.get("SESSION_ENONO") %>";
		   document.getElementById("txtENO_NM_SHR").value = "<%=box.get("SESSION_ENONM") %>";
		   document.getElementById("txtENO_NO_SHR").className = "input_ReadOnly";
		   document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";
           document.getElementById("txtENO_NM_SHR").readOnly = true;
           document.getElementById("imgENO_NO_SHR").disabled = true;
           document.getElementById("imgENO_NO_SHR").style.display = "none";
<%
    }
%>

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
         * 시작일자에서 포커스 떠날때 종료일자와 비교  		 *
         ********************************************/
		function cfCheckDateTermADVA040(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("접수종료일자가 접수시작일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ADVTLIST)			   |
    | 3. 사용되는 Table List(T_EV_ADVTLIST) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_ADVTLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ADVTLIST)		       |
    | 3. 사용되는 Table List(T_EV_ADVTLIST)			       |
    +------------------------------------------------------>
	<Object ID="trT_EV_ADVTLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_EV_ADVTLIST=dsT_EV_ADVTLIST,I:dsT_EV_ADVTLIST=dsT_EV_ADVTLIST)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTLIST Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ADVTLIST.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTLIST Event="OnLoadError()">
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
	<Script For=dsT_EV_ADVTLIST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTLIST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTLIST event="OnFail()">
        alert(trT_EV_ADVTLIST.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Grid Double Click Event                                   |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_EV_ADVTLIST event=OnDblClick(row,colid)>

        window.showModalDialog("/hr/adv/adva021.jsp?GBN=adva040"+"&ORD_NO_SHR="+dsT_EV_ADVTLIST.NameString(row, "ORD_NO")+"&ENO_NO_SHR="+dsT_EV_ADVTLIST.NameString(row, "ADV_ENO_NO"), self, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        fnc_SearchList();

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별신청현황</td>
					<td align="right" class="navigator">HOME/인사평가/사내공모/<font color="#000000">개인별신청현황</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="220"></col>
							<col width="60"></col>
							<col width="160"></col>
							<col width="40"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">신청기간</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','104','116');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermADVA040('txtEND_YMD_SHR', 'txtSTR_YMD_SHR', 'txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','218','116');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">공모부서</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
								</a>
							</td>
							<td align="right" class="searchState">사번</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
								<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>
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
					<object id="grdT_EV_ADVTLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_EV_ADVTLIST">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width="44"		name="NO"				align="center"	value={String(Currow)}</C>
							<C> id="ADV_DPT_NM"		width="130"		name="소속"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="ADV_JOB_NM"		width="80"		name="직위"				align="center"	Edit=none	LeftMargin="10"</C>
							<C> id="ADV_ENO_NM"		width="100"		name="성명"				align="center"	Edit=none</C>
							<C> id="ADV_ENO_NO"		width="100"		name="사번"				align="center"	Edit=none</C>
							<C> id="ORD_NO"			width="100"		name="관리번호"			align="center"	Edit=none</C>
							<C> id="DPT_NM"			width="130"		name="공모소속"			align="left"	Edit=none	LeftMargin="10"</C>
					    	<C> id="IPT_YMD"        width="80"      name="신청일"           align="center"  Edit=none</C>
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

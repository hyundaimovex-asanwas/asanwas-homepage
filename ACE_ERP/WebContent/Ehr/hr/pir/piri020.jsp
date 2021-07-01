	<!--*************************************************************************
	* @source      : piri020.jsp												*
	* @description : 현장별인원현황 PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2013/04/09            이동훈            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>현장별인원현황(piri020)</title>
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

		var btnList = 'TFFTTFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var TEAM_CD_SHR = document.getElementById("txtTEAM_CD_SHR").value;

			//DPT_CD_SHR = (DPT_CD_SHR == null) ? "%" : DPT_CD_SHR;

			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.i.piri020.cmd.PIRI020CMD&S_MODE=SHR&TEAM_CD_SHR="+TEAM_CD_SHR;
			trVI_T_CM_PERSON.KeyValue = "SHR"
                                      + "(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON)";

			trVI_T_CM_PERSON.post();


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

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("현장별인원현황", '', 225)
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

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
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


			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","true");      // Grid Style 적용

		<%
		    //관리자가 아니면  현장 검색은 하지 못한다.
		    if(!(box.getString("SESSION_ENONO").equals("6060002") 
		    		|| box.getString("SESSION_ENONO").equals("2050046") 
		    		|| box.getString("SESSION_ENONO").equals("2080028"))) {
		%>
		            fnc_ChangeStateElement(false, "txtTEAM_CD_SHR");
		            fnc_ChangeStateElement(false, "txtTEAM_NM_SHR");
		            fnc_HiddenElement(  "ImageTeam" );  
		<%
		    }
		%>

	        document.getElementById("txtTEAM_CD_SHR").value = "<%=box.get("SESSION_TEAMCD") %>";
	        document.getElementById("txtTEAM_NM_SHR").value = "<%=box.get("SESSION_TEAMNM") %>";
	        document.getElementById("txtENO_NO_SHR").value = "<%=box.get("SESSION_ENONO") %>";
	        document.getElementById("txtENO_NM_SHR").value = "<%=box.get("SESSION_ENONM") %>";
	        
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 									*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

		/********************************************
         * 17. Form이 Active 될 때 처리 할 일 									*
         ********************************************/
        /**
         * 소속, KPI, 본부, 팀, 지점의 코드를 조회한다.
         * @param - ctrl_01 : 리턴받을 코드명
         * @param - ctrl_02 : 리턴받을 코드네임명
         * @param - ctrl_03 : 타이틀명
         * @param - ctrl_04 : cd_gbn 코드명
         * @param - ctrl_05 : 상위 부서 코드
         */
		function fnc_commnmPopup222(ctrl_01,ctrl_02,ctrl_03,ctrl_04) {

			var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
			obj.title = ctrl_03;
			obj.gbn = document.getElementById(ctrl_04).value;

			window.showModalDialog("/common/popup/codenm_sel.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.comm_cd != '' && obj.comm_nm != ''){
				document.getElementById(ctrl_01).value = obj.comm_cd;
				document.getElementById(ctrl_02).value = obj.comm_nm;
			}
		
		}
		
    </script>
</head>



    <!------------------------------+
    | grid에서 row를 더블클릭했을때 |
    +------ ------------------------>
	<script for=grdVI_T_CM_PERSON event=OnDblClick(Row,Colid)>
	
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		
		var url = "";
		var data = new String();

		if(Row < 1) {
			return;
		} else {
			data.eno_no = dsVI_T_CM_PERSON.NameValue(Row,'ENO_NO');
			data.mode       = "read";
			url = "/hr/pir/pirc010.jsp";
			window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:615px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		}
		
	</script>


	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 			   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsVI_T_CM_PERSON)">
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
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">현장별인원현황</td>
					<td align="right" class="navigator">HOME/인사관리/인원정보/<font color="#000000">현장별인원현황</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
					<col width="150"></col>
					<col width="80"></col>
					<col width="150"></col>					
					<col width="*"></col>					
				</colgroup>
				<tr>
					<td class="searchState" align="right">소속&nbsp;</td>
					<td class="padding2423">
                        <input id="txtTEAM_CD_SHR" name="txtTEAM_CD_SHR" size="6" class="input_ReadOnly" readonly>
						<input id="txtTEAM_NM_SHR" name="txtTEAM_NM_SHR" size="30" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageTeam','','/images/button/btn_HelpOver.gif',1)">
							<img src="/images/button/btn_HelpOn.gif" name="ImageTeam" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup222('txtTEAM_CD_SHR','txtTEAM_NM_SHR','현장','txtENO_NO_SHR')">
						</a>
					</td>

                    <td align="right" class="searchState">사 번&nbsp;</td>
                    <td class="padding2423">
                        <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="7"  class="input_ReadOnly" readonly>
                        <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly>
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{curow}"			width=29	name="NO"			align=center	Edit=none	 value="{String(currow)}"</C>
							<C> id="DPT_NM"			width=110	name="소속"		align=left		Edit=none	 LeftMargin="10" show=false</C>
							<C> id="JOB_NM"			width=70	name="직위"		align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="HOB_NM"			width=60	name="호봉"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NO"			width=70	name="사번"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NM"			width=60	name="성명"		align=center	Edit=none	 </C>
							<C> id="CET_NO"			width=100	name="주민번호"	align=center	Edit=none	 </C>
							<C> id="HIR_YMD"		width=90	name="입사일"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="HIRG_YMD"		width=90	name="그룹입사일"	align=center	Edit=none	 RightMargin="10"</C>							
							<C> id="JPR_YMD"		width=90	name="승진일"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="AGE"				width=60	name="나이"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="EM_PHN_NO"	width=100	name="핸드폰"	   	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="EDGR_NM"		width=100	name="학력구분"	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SCH_NM"			width=100	name="학교명"	   	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="MAJ_NM"			width=100	name="학과명"	   	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="GRD_NM"			width=100	name="졸업구분"	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="REMARK"			width=120	name="담당업무"   align=left		Edit=none	 RightMargin="10"</C>

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


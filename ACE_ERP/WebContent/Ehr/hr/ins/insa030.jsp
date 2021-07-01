	<!--*************************************************************************
	* @source      : insa030.jsp												*
	* @description : 국민연금개인별조회 PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/08            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>국민연금개인별조회(insa030)</title>
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
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
                    
		var today = getToday().substr(0,4);

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STD_PIS_YY_SHR = document.form1.txtSTD_PIS_YY_SHR.value;
			var END_PIS_YY_SHR = document.form1.txtEND_PIS_YY_SHR.value;
			var ENO_NO_SHR = document.form1.txtENO_NO.value;

        	if( ENO_NO_SHR == "" ){
        		alert("사번을 입력하십시오.");
        		return false;
        	}
        	if( STD_PIS_YY_SHR == "" ){
        		alert("시작 년도를 입력하세요.");
        		return false;
        	}
        	if( END_PIS_YY_SHR == "" ){
        		alert("마지막 년도를 입력하세요.");
        		return false;
        	}

			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa030.cmd.INSA030CMD&S_MODE=SHR&STD_PIS_YY_SHR="+STD_PIS_YY_SHR+"&END_PIS_YY_SHR="+END_PIS_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_CP_PAYMASTER.reset();

            return true;
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

        	//if(!fnc_SearchList())
            //    return;
            if(dsT_CP_PAYMASTER.CountRow < 1) {
                alert("조회를 먼저 해주세요");
                return;
            }
            
            var eno_no  = document.getElementById("txtENO_NO").value;
            var job_nm  = document.getElementById("txtJOB_NM").value;
            var dpt_nm  = document.getElementById("txtDPT_NM").value;
            var eno_nm  = document.getElementById("txtENO_NM").value;
            var hir_ymd = document.getElementById("txtHIR_YMD").value;
            var cet_no  = document.getElementById("txtCET_NO").value;
            
            
            var str_yy  = dsT_CP_PAYMASTER.NameValue(1,"PIS_YY");
            var end_yy  = dsT_CP_PAYMASTER.NameValue(Number(dsT_CP_PAYMASTER.CountRow)-2,"PIS_YY");
            //alert(str_yy+",  "+end_yy);
            
            var url = "insa030_PV.jsp?eno_no="+eno_no+"&job_nm="+job_nm+"&dpt_nm="+dpt_nm+"&eno_nm="+eno_nm+"&hir_ymd="+hir_ymd+"&cet_no="+cet_no+"&str_yy="+str_yy+"&end_yy="+end_yy;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("국민연금개인별조회", '', 225)
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

        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_CP_PAYMASTER.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CP_PAYMASTER.IsUpdated)  {
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
            
            //검색 조건들 초기화
            document.getElementById("txtSTD_PIS_YY_SHR").value = today;
            document.getElementById("txtEND_PIS_YY_SHR").value = today;
            
            //사번 정보 조회
            document.getElementById("txtENO_NO").value = "<%=box.get("SESSION_ENONO") %>";
            fnc_SearchEmpNo();
            
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"true","false");      // Grid Style 적용
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

            if(obj.eno_no != "") {            
                document.getElementById("txtENO_NO"     ).value = obj.eno_no;
                document.getElementById("txtENO_NM"     ).value = obj.eno_nm;
                document.getElementById("txtOCC_CD"     ).value = obj.occ_cd;
                document.getElementById("txtOCC_NM"     ).value = obj.occ_nm;
                document.getElementById("txtJOB_NM"     ).value = obj.job_nm;
                document.getElementById("txtDPT_NM"     ).value = obj.dpt_nm;
                document.getElementById("txtHIR_YMD"    ).value = obj.hir_ymd;
                document.getElementById("txtCET_NO"     ).value = obj.cet_no;

            } else {
                document.getElementById("txtENO_NO"     ).value = "";
                document.getElementById("txtENO_NM"     ).value = "";
                document.getElementById("txtOCC_CD"     ).value = "";
                document.getElementById("txtOCC_NM"     ).value = "";
                document.getElementById("txtJOB_NM"     ).value = "";
                document.getElementById("txtDPT_NM"     ).value = "";
                document.getElementById("txtHIR_YMD"    ).value = "";
                document.getElementById("txtCET_NO"     ).value = "";
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_PAYMASTER)			   |
    | 3. 사용되는 Table List(T_CP_PAYMASTER) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
        <param name="SubSumExpr"      value="total , 1:PIS_YY">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_PAYMASTER)			   |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)				   |
    +------------------------------------------------------>
	<Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
            //alert(dsT_CP_PAYMASTER.ExportData(1, dsT_CP_PAYMASTER.CountRow, true));
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.RealCount(1, dsT_CP_PAYMASTER.CountRow));
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnFail()">
        alert(trT_CP_PAYMASTER.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">국민연금개인별조회</td>
					<td align="right" class="navigator">HOME/복리후생/국민연금/<font color="#000000">국민연금개인별조회</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
					<col width="45"></col>
					<col width="65"></col>
					<col width="45"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width="85"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">년도&nbsp;</td>
					<td class="padding2423" align="left" colspan="3">
						<input type="text" id="txtSTD_PIS_YY_SHR" name="txtSTD_PIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTD_PIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgSTD_PIS_YY_SHR" name="imgSTD_PIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtSTD_PIS_YY_SHR','','340','108');"></a>
						~
						<input type="text" id="txtEND_PIS_YY_SHR" name="txtEND_PIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_PIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgEND_PIS_YY_SHR" name="imgEND_PIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtEND_PIS_YY_SHR','','425','108');"></a>
					</td>
                    <td align="right" class="searchState">사번&nbsp;</td>
                    <td class="padding2423" align="left" colspan="3">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>
                </tr>
                <tr>
                    <td align="right" class="searchState">근로구분&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="hidden" id="txtOCC_CD" size="2" class="input_ReadOnly" readonly>
                        <input type="text" id="txtOCC_NM" size="6" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">소속&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">직위&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtJOB_NM" size="10" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">입사일&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtHIR_YMD" size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">주민번호&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtCET_NO" size="15" class="input_ReadOnly" readonly>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="65"></col>
			<col width="80"></col>
			<col width="65"></col>
			<col width="90"></col>
			<col width="65"></col>
			<col width="70"></col>
			<col width="65"></col>
			<col width="80"></col>
			<col width="65"></col>
			<col width="*"></col>
		</colgroup>

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
					<object id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
						<param name="DataID" value="dsT_CP_PAYMASTER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"	width=50	name="NO"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	 SubSumText={decode(currow,LastRow,"합 계","소 계")}</C>
							<C> id="PIS_YY"		width=50	name="년"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	 SubSumText=""</C>
							<C> id="PIS_MM"		width=50	name="월"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}</C>
							<C> id="STDB_AMT"	width=110	name="표준보수월액"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
							<C> id="NPN_GRD"	width=80	name="등급"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}</C>
							<C> id="NPEN_AMT"	width=110	name="본인부담금"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
							<C> id="COM_AMT"	width=110	name="회사부담금"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
							<C> id="RTPL_AMT"	width=110	name="퇴직전환금"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"      SubSumText={IF(curlevel=9999, Max(RTPL_TOT), RTPL_AMT)} </C>
							<C> id="NPN_SUM"	width=110	name="합계"			align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
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

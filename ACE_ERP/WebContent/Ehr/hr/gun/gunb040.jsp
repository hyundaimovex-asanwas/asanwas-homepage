<!--
***********************************************************************
* @source      : gunb040.jsp
* @description : 휴가계획사용자조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>휴가계획사용자조회(gunb040)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TFFTTFFT';

        var today = getToday();

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			//휴가계획사용자 조회
			var pis_yy = document.getElementById("txtPIS_YY_SHR").value;
			var pis_mm_str = document.getElementById("txtPIS_MM_STR").value;
            var pis_mm_end = document.getElementById("txtPIS_MM_END").value;
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
            var att_kind = document.getElementById("cmbATT_KIND_SHR").value;

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_DI_PLAN.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb040.cmd.GUNB040CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&PIS_MM_STR="+pis_mm_str+"&PIS_MM_END="+pis_mm_end+"&DPT_CD="+dpt_cd+"&ATT_KIND="+att_kind;
			dsT_DI_PLAN.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_DI_PLAN.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_PLAN.GridToExcel("휴가계획사용자", '', 225);

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//document.getElementById("txtPIS_YY_SHR").value = "";
			//document.getElementById("txtPIS_MM_STR").value = "";
            //document.getElementById("txtPIS_MM_END").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
            document.getElementById("cmbATT_KIND_SHR").value = "";
            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_PLAN.ClearData();

            document.getElementById("txtPIS_YY_SHR").focus();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var pis_yy = document.getElementById("txtPIS_YY_SHR");
			var pis_mm_str = document.getElementById("txtPIS_MM_STR");
            var pis_mm_end = document.getElementById("txtPIS_MM_END");
            var dpt_cd = document.getElementById("txtDPT_CD_SHR");

            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("4자리수 조회년도를 입력하세요!");
                pis_yy.focus();
                return false;
            }
            if(pis_mm_str.value == "" || pis_mm_str.value.length < 2 || pis_mm_str.value > 12){
                alert("2자리수 시작월을 입력하세요!");
                pis_mm_str.focus();
                return false;
            }
            if(pis_mm_end.value == "" || pis_mm_end.value.length < 2 || pis_mm_end.value > 12){
                alert("2자리수 종료월을 입력하세요!");
                pis_mm_end.focus();
                return false;
            }
            if(pis_mm_str > pis_mm_end){
                alert("시작월은 종료월보다 작아야합니다!");
                pis_mm_str.focus();
                return false;
            }
            if(dpt_cd.value == "" || pis_yy.value.length < 2){
                alert("소속코드를 입력하세요!");
                dpt_cd.focus();
                return false;
            }

            return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_PLAN,0,"false","false");      // Grid Style 적용

            document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            document.getElementById("txtPIS_MM_STR").value = "01";
            document.getElementById("txtPIS_MM_END").value = today.substring(5,7);
            
            document.getElementById("txtPIS_YY_SHR").focus();


            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       
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

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-------------------------------------------------+
    | 1. 조회 및 저장용 DataSet						   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_PLAN)		   |
    | 3. 사용되는 Table List(T_DI_PLAN) 			   |
    +-------------------------------------------------->
	<Object ID="dsT_DI_PLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_PLAN Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_PLAN Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">휴가계획사용자조회</td>
					<td align="right" class="navigator">HOME/근태관리/휴가계획관리/<font color="#000000">휴가계획사용자조회</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="100"></col>
							<col width="160"></col>
                            <col width="60"></col>
							<col width="220"></col>
                            <col width="60"></col>
							<col width="80"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">해당기간&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YY_SHR" size="4" maxlength="4" onkeypress="cfNumberCheck();" style="ime-mode:disabled">년<input id="txtPIS_MM_STR" size="2" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">월 ~ <input id="txtPIS_MM_END" size="2" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">월</td>
                            <td class="searchState" align="right">소속&nbsp;</td>
					        <td class="padding2423" align="left">
						        <input id="txtDPT_CD_SHR" size="3" maxlength="2" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="14" class="input_ReadOnly"  readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
					        </td>
                            <td class="searchState" align="right">휴가항목&nbsp;</td>
					        <td class="padding2423" align="left">
						        <select id="cmbATT_KIND_SHR"  style="width='100%';" onChange="fnc_SearchList()">
									<option value="">전 체</option>
									<option value="H">연 차</option>
									<option value="Q">기념일</option>
									<option value="Z">Refresh</option>
                                    <option value="S">유 급</option>
								</select>
					        </td>
                            <td>&nbsp;</td>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_DI_PLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_DI_PLAN">
						<param name="Format" value='
			                <C> id="{CUROW}"	width=29	name=NO				align=center	value={String(Currow)}</C>
                            <C> id="DPT_NM"		width=100	name="소속"         align=left      suppress=1 </C>
                            <C> id="JOB_NM"		width=60	name="직위"         align=center    suppress=1 </C>
                            <C> id="ENO_NO"		width=70	name="사번"         align=center    suppress=1 </C>
                            <C> id="ENO_NM"		width=70	name="성명"	        align=center    suppress=1 </C>
                            <C> id="YRP_CNT"    width=70	name="미사용연차"   align=center    suppress=1 </C>
                            <C> id="ATT_KIND"   width=80	name="휴가항목"     align=left      suppress=1 LeftMargin="10" Value={Decode(ATT_KIND,"H","연 차","Q","기념일휴가","Z","Refresh","S","유급휴가")}</C>
                            <C> id="PLAN_CNT"	width=60	name="계획일수"     align=right     RightMargin="10" </C>
                            <C> id="PLAN_YMD"	width=180	name="계획일자"     align=left      LeftMargin="20" </C>
                            <C> id="USE_YN"	    width=60	name="사용유무"     align=center    Value={Decode(USE_YN,"Y","사용","미사용")}</C>
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
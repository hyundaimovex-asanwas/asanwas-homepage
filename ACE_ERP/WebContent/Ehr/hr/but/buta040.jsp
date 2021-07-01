<!--
***********************************************************************
* @source      : buta040.jsp
* @description : 근태대비출장현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>근태대비출장현황(buta040)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TFFTTFFT';

        var today = getToday();

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			//근태변경신청현황 정보 조회
			var pis_ym = document.getElementById("txtPIS_YM_SHR").value;
			var str_date = document.getElementById("txtSTR_DATE_SHR").value;
			var end_date = document.getElementById("txtEND_DATE_SHR").value;
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;

			dsT_DI_BUSINESSTRIP.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta040.cmd.BUTA040CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&STR_DATE="+str_date+"&END_DATE="+end_date+"&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
			dsT_DI_BUSINESSTRIP.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
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

            if (dsT_DI_BUSINESSTRIP.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_BUSINESSTRIP.GridToExcel("근태대비출장현황", '', 225);

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

			//document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
			//document.getElementById("txtSTR_DATE_SHR").value = "";
			//document.getElementById("txtEND_DATE_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_BUSINESSTRIP.ClearData();
            dsT_DI_BUSINESSTRIP_SET.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var pis_ym = document.getElementById("txtPIS_YM_SHR");
			var str_date = document.getElementById("txtSTR_DATE_SHR");
			var end_date = document.getElementById("txtEND_DATE_SHR");

            if(pis_ym.value == ""){
                alert("근태기간 년-월을 입력하세요!");
                pis_ym.focus();
                return false;
            }
            if(str_date.value == ""){
                alert("근태기간 시작일을 입력하세요!");
                str_date.focus();
                return false;
            }
            if(end_date.value == ""){
                alert("근태기간 종료일을 입력하세요!");
                end_date.focus();
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

            document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
			document.getElementById("txtSTR_DATE_SHR").value = "01";
			document.getElementById("txtEND_DATE_SHR").value = today.substring(8,10);
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";

			cfStyleGrid(form1.grdT_DI_BUSINESSTRIP,0,"false","false");      // Grid Style 적용

            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************
         * 15. 입력일 크기 비교					*
         ********************************************/
        function fnc_DateTerm(p_stdt,p_endt) {

            if(document.getElementById(p_stdt).value != "" && document.getElementById(p_endt).value != ""){
                if(document.getElementById(p_stdt).value > document.getElementById(p_endt).value){
                    alert("시작일이 종료일 보다 큽니다.");
                    document.getElementById(p_stdt).focus();
                }
            }

        }



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP)   |
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_BUSINESSTRIP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_SET)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_SET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 필터사용, 전체조회일때는 출장날짜만 나온다           |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_DI_BUSINESSTRIP_SET event=onFilter(row)>

		if (dsT_DI_BUSINESSTRIP_SET.NameValue(row,"BUSI_CD") == "E"){
			return true;
		}else{
			return false;
		}

	</script>

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP Event="OnLoadCompleted(iCount)">

        var pis_ym = document.getElementById("txtPIS_YM_SHR").value;
		var str_date = document.getElementById("txtSTR_DATE_SHR").value;
		var end_date = document.getElementById("txtEND_DATE_SHR").value;
        var cnt = 0;

        dsT_DI_BUSINESSTRIP_SET.ClearData();

		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
            dsT_DI_BUSINESSTRIP_SET.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING, PIS_YMD:STRING, AT_NM:STRING, AT_CD:STRING, BUSI_CD:STRING, FLAG:STRING");

			//필터실행여부 개인조회면 전체보여주고 아니면 출장만 나오게 한다.
			if(document.getElementById("txtENO_NO_SHR").value.length != 8){
				dsT_DI_BUSINESSTRIP_SET.UseFilter=true;
            }else{
				dsT_DI_BUSINESSTRIP_SET.UseFilter=false;
            }

            for(i=1; i<=iCount; i++){
                cnt = 5;    //근태코드를 가져오기 위한 변수(근태코드는 5번째 컬럼부터 날짜 수만큼 들어있음)

                if(i==1 || dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO") != dsT_DI_BUSINESSTRIP.NameValue(i-1,"ENO_NO")){
                    for(j=Number(str_date); j<=Number(end_date); j++){
                        dsT_DI_BUSINESSTRIP_SET.AddRow();
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO");
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"ENO_NM") = dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NM");
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"DPT_NM") = dsT_DI_BUSINESSTRIP.NameValue(i,"DPT_NM");
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"JOB_NM") = dsT_DI_BUSINESSTRIP.NameValue(i,"JOB_NM");
                        if(j < 10){
                            dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"PIS_YMD") = pis_ym+"-0"+j;
                        }else{
                            dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"PIS_YMD") = pis_ym+"-"+j;
                        }
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"AT_CD") = dsT_DI_BUSINESSTRIP.ColumnValue(i,cnt);
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"AT_NM") = dsT_DI_BUSINESSTRIP.ColumnValue(i,cnt+1);
                        if(j>=Number(dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_FR_YMD").substring(6,8)) && j<=Number(dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_TO_YMD").substring(6,8))){
                            dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"BUSI_CD") = "E";
	                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"FLAG") = dsT_DI_BUSINESSTRIP.NameValue(i,"FLAG");//출장구분
                        }

                        cnt = cnt + 2;

                    }//end for
                }//end if

                //조회 기간동안에 중복된 출장이 있을 경우
                else if(i>1 && dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO") == dsT_DI_BUSINESSTRIP.NameValue(i-1,"ENO_NO")){
                    for(k=1; k<=dsT_DI_BUSINESSTRIP_SET.CountRow; k++){
                        //동일한 사번이 존재하는 경우
                        if(dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO") == dsT_DI_BUSINESSTRIP_SET.NameValue(k,"ENO_NO")){
                            //근태일이 출장기간동안에 속하는 경우
                            if(removeChar(dsT_DI_BUSINESSTRIP_SET.NameValue(k,"PIS_YMD"),"-") >= dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_FR_YMD") && removeChar(dsT_DI_BUSINESSTRIP_SET.NameValue(k,"PIS_YMD"),"-") <= dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_TO_YMD")){
                                dsT_DI_BUSINESSTRIP_SET.NameValue(k,"BUSI_CD") = "E";
                                dsT_DI_BUSINESSTRIP_SET.NameValue(k,"FLAG") = dsT_DI_BUSINESSTRIP.NameValue(i,"FLAG");//출장구분
                            }
                        }
                    }//end for
                }
            }//end for

            dsT_DI_BUSINESSTRIP_SET.Filter();//필터실행
            dsT_DI_BUSINESSTRIP_SET.RowPosition = "1";//화면이 순간적으로 않보이는 버그때문에 커서를 움직인다.

			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_BUSINESSTRIP_SET.countrow);


        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태대비출장현황</td>
					<td align="right" class="navigator">HOME/근태관리/출장관리/<font color="#000000">근태대비출장현황</font></td>
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
							<col width="80"></col>
							<col width="180"></col>
                            <col width="60"></col>
							<col width="180"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">근태기간&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtPIS_YM_SHR"  name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                <input id="txtSTR_DATE_SHR" style="ime-mode:disabled" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" onblur="javascript:if(txtPIS_YM_SHR.value != '' && !cfDateExpr(txtPIS_YM_SHR.value+this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} fnc_DateTerm('txtSTR_DATE_SHR','txtEND_DATE_SHR');">일 ~
                                <input id="txtEND_DATE_SHR" style="ime-mode:disabled" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" onblur="javascript:if(txtPIS_YM_SHR.value != '' && !cfDateExpr(txtPIS_YM_SHR.value+this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} fnc_DateTerm('txtSTR_DATE_SHR','txtEND_DATE_SHR');">일
							</td>
                            <td align="right" class="searchState">소 속&nbsp;</td>
                            <td class="padding2423">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
								</a>
                            </td>
                            <td align="right" class="searchState">사 번&nbsp;</td>
                            <td class="padding2423">
                                <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','0');">
								<input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
					<object id="grdT_DI_BUSINESSTRIP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_DI_BUSINESSTRIP_SET">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}			</C>
                            <C> id="DPT_NM"	    width=120	name="소속"		align=center    suppress=1 </C>
                            <C> id="JOB_NM"		width=80	name="직위"		align=center    suppress=1 </C>
                            <C> id="ENO_NO"     width=80	name="사번"     align=center    suppress=1 </C>
                            <C> id="ENO_NM"	    width=80	name="성명"	    align=center    suppress=1 </C>
                            <C> id="PIS_YMD"	width=100	name="근태일"	align=center    </C>
                            <C> id="AT_NM"	    width=100	name="근태반영분"	align=center    </C>
                            <C> id="BUSI_NM"	width=100	name="출장반영분"	align=center    Value={Decode(FLAG,"I","국내출장","O","해외출장")}</C>
                            <C> id="AT_CD"	    width=100	name="근태코드"	align=center    Show=false</C>
                            <C> id="BUSI_CD"	width=100	name="출장"	    align=center    Show=false</C>
                            <C> id="DIF_YN"	    width=80	name="비교결과"	align=center    Value={Decode(BUSI_CD,"E",Decode(AT_CD,"E","","N"))}</C>
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
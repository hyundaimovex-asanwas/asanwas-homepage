<!--
***********************************************************************
* @source      : graa050.jsp
* @description : 직급호봉별임금조정현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      오대성        최초작성.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>직급호봉별임금조정현황(graa050)</title>
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

		var btnList = 'TFFTTTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
			
			var f = document.form1;
            var snd_kind = "";
            if(f.rdoSND_KIND[0].checked){
                snd_kind = "PAY";  //급여
            } else {
                snd_kind = "BNS";  //상여
            }
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var rai_ymd = f.txtRAI_YMD_SHR.value;
            var hba_ymd = f.txtHBA_YMD_SHR.value;
            var pis_ym = f.txtPIS_YM_SHR.value;
            var gubun = f.cmb_GUBUN_SHR.value;
            var dpt_cd1 = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2 = f.cmbDPT_CD_SHR2.value;
            var job_cd1 = f.cmbJOB_CD_SHR1.value;
            var job_cd2 = f.cmbJOB_CD_SHR2.value;
            var sel = "";
            if(f.rdoSEL_SHR[0].checked){
                sel = "DPT";   //소속
            } else {
                sel = "JOB";  //직위
            }

            if(!fnc_SearchItemCheck()) return;

			dsT_PM_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa050.cmd.GRAA050CMD&S_MODE=SHR&SND_KIND="+snd_kind+"&OCC_CD="+occ_cd+"&RAI_YMD="+rai_ymd+"&HBA_YMD="+hba_ymd+"&PIS_YM="+pis_ym+"&DPT_CD1="+dpt_cd1+"&DPT_CD2="+dpt_cd2+"&JOB_CD1="+job_cd1+"&JOB_CD2="+job_cd2+"&GUBUN="+gubun+"&SEL="+sel;
            dsT_PM_GRADE.reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

				//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
			
			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {
            var f = document.form1;
            var snd_kind = "";
            if(f.rdoSND_KIND[0].checked){
                snd_kind = "PAY";  //급여
            } else {
                snd_kind = "BNS";  //상여
            }
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var rai_ymd = f.txtRAI_YMD_SHR.value;
            var hba_ymd = f.txtHBA_YMD_SHR.value;
            var pis_ym = f.txtPIS_YM_SHR.value;
            var gubun = f.cmb_GUBUN_SHR.value;
            var dpt_cd1 = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2 = f.cmbDPT_CD_SHR2.value;
            var job_cd1 = f.cmbJOB_CD_SHR1.value;
            var job_cd2 = f.cmbJOB_CD_SHR2.value;
            var sel = "";
            if(f.rdoSEL_SHR[0].checked){
                sel = "DPT";
            } else {
                sel = "JOB";  //상여
            }

            var url = "graa050_PV.jsp?SND_KIND="+snd_kind+"&OCC_CD="+occ_cd+"&RAI_YMD="+rai_ymd+"&HBA_YMD="+hba_ymd+"&PIS_YM="+pis_ym+"&DPT_CD1="+dpt_cd1+"&DPT_CD2="+dpt_cd2+"&JOB_CD1="+job_cd1+"&JOB_CD2="+job_cd2+"&GUBUN="+gubun+"&SEL="+sel;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_PM_GRADE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            
            form1.grdT_PM_GRADE.GridToExcel("직급호봉별임금조정현황", '', 225)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
			
			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {
			
			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {
			
			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
			
            var f = document.form1;
            f.rdoSND_KIND[0].checked = true;
            f.rdoSEL_SHR[0].checked = true;
            f.cmbOCC_CD_SHR.value = "";
            //f.txtRAI_YMD_SHR.value = "";
            //f.txtHBA_YMD_SHR.value = "";
            //f.txtPIS_YM_SHR.value = "";
            f.cmb_GUBUN_SHR.value = "CON";
            f.cmbDPT_CD_SHR1.value = "";
            f.cmbDPT_CD_SHR2.value = "";
            f.cmbJOB_CD_SHR1.value = "";
            f.cmbJOB_CD_SHR2.value = "";
			
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_GRADE.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {
			
			var pis_ym = document.getElementById("txtPIS_YM_SHR");
            var rai_ymd = document.getElementById("txtRAI_YMD_SHR");
            var hba_ymd = document.getElementById("txtHBA_YMD_SHR");

            if(pis_ym.value == ""){
                alert("수당기준년월은 반드시 입력하셔야합니다!");
                pis_ym.focus();
                return false;
            }
            if(rai_ymd.value == ""){
                alert("승급예정일은 반드시 입력하셔야합니다!");
                rai_ymd.focus();
                return false;
            }
            if(hba_ymd.value == ""){
                alert("전년승급일은 반드시 입력하셔야합니다!");
                hba_ymd.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
			
			//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//근로구분
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);
                
            }
            
            //직위
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR1").add(oOption);
                
            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR2").add(oOption);
                
            }
            
            //소속
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR1").add(oOption);
                
            }            
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR2").add(oOption);
                
            }

			cfStyleGrid(form1.grdT_PM_GRADE,0,"false","false");      // Grid Style 적용
			
            document.getElementById('radio1').focus();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



	</script>
	

 </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_PM_GRADE)    |
    | 3. 사용되는 Table List(T_PM_GRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubSumExpr"      value="total , 1:PJOB_CD, 1:PJOB_NM">
    </Object>

	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직위 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 소속 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">
		
        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직급호봉별임금조정현황</td>
					<td align="right" class="navigator">HOME/인사관리/승급/<font color="#000000">직급호봉별임금조정현황</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="85"></col>
									<col width="95"></col>
									<col width="60"></col>
									<col width="70"></col>
									<col width="75"></col>
									<col width="150"></col>
									<col width="75"></col>
									<col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">출력선택&nbsp;</td>
								<td class="padding2423">
                                    <input type="radio" id="radio1" name="rdoSND_KIND" style="border:none" value="0" checked>급여 
                                    <input type="radio" id="radio2" name="rdoSND_KIND" style="border:none" value="1">상여
								</td>
								<td align="right" class="searchState">근로구분&nbsp;</td>
								<td class="padding2423">
									<select id="cmbOCC_CD_SHR" style="WIDTH:60">
                                        <option value="">전체</option>
									</select>
								</td>
								<td colspan="2">
								    <input type="radio" id="radio11" name="rdoSEL_SHR" style="border:none" value="0" checked>소속 
                                    <select id="cmbDPT_CD_SHR1" name="cmbDPT_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~ 
                                    <select id="cmbDPT_CD_SHR2" name="cmbDPT_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                </td>
								<td colspan="2">
								    <input type="radio" id="radio12" name="rdoSEL_SHR" style="border:none" value="0">직위 
                                    <select id="cmbJOB_CD_SHR1" name="cmbJOB_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~ 
                                    <select id="cmbJOB_CD_SHR2" name="cmbJOB_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                </td>
							</tr>
							<tr>
								<td align="right" class="searchState">수당기준년월&nbsp;</td>
								<td class="padding2423">
								    <input id="txtPIS_YM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','50','138');"></a></td>
								<td align="right" class="searchState">적용자료&nbsp;</td>
								<td class="padding2423">
									<select id="cmb_GUBUN_SHR" style="WIDTH:60">
										<option value="CON">조정</option>
                                        <option value="FIN">확정</option>
									</select>
								</td>
                                <td align="right" class="searchState">승급예정일&nbsp;</td>
								<td class="padding2423">
								    <input id="txtRAI_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAI_YMD_SHR','','380','138');"></a>
								</td>
                                <td align="right" class="searchState">전년승급일&nbsp;</td>
								<td class="padding2423">
								    <input id="txtHBA_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHBA_YMD_SHR','','615','138');"></a>
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_PM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_PM_GRADE">
							<param name="Format"					value="
								<C> id='PJOB_CD'	width=60    name='직위'			align=center Show=false</C>
                                <C> id='JOB_NM'	    width=60    name='직위'			align=center BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} SubSumText='합 계'</C>
								<C> id='HOB'		width=50	name='전호봉'		align=center BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='CNT'		width=60	name='전인원'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='AVR_SAL'	width=80	name='전임금'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_SAL)),AVR_SAL)} </C>
								<C> id='AVR_AOW'	width=80	name='전근속'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_AOW)),AVR_AOW)} </C>
								<C> id='ETC_AVR'	width=80	name='전기타'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(ETC_AVR)),ETC_AVR)} </C>
								<C> id='SUM_SAL'	width=80	name='전합계'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} DECAO=0</C>
								<C> id='HOB2'		width=50	name='후호봉'		align=center BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='CNT2'		width=60	name='후인원'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='AVR_SAL2'		width=80	name='후임금'	align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_SAL2)),AVR_SAL2)} </C>
								<C> id='AVR_AOW2'		width=80	name='후근속'	align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_AOW2)),AVR_AOW2)} </C>
								<C> id='ETC_AVR2'	width=80	name='후기타'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(ETC_AVR2)),ETC_AVR2)} </C>
								<C> id='SUM_SAL2'		width=80	name='후합계'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} DECAO=0</C>
                                <C> id='INC_PER'		width=80	name='인상율'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', decode(SUM_SAL2-SUM_SAL,0,0,((SUM_SAL2-SUM_SAL)/SUM_SAL*100))))} Dec=1</C>
								<C> id='INC_AMT'		width=80	name='소요재원'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SUM_SAL2-SUM_SAL))}</C>
							">
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
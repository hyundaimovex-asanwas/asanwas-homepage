<!--
***********************************************************************
* @source      : ymaa030.jsp
* @description : 연차수당지급내역 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/22      오대성        최초작성.
* 2007/04/27      김학수        인쇄부분 추가.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>연차수당지급내역(ymaa030)</title>
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

        var today = getToday();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var occ_cd = document.getElementById('cmbOCC_CD_SHR').value;
			var dpt_cd = document.getElementById('cmbDPT_CD_SHR').value;
            var job_cd = document.getElementById('cmbJOB_CD_SHR').value;
            var gbn = "";
            
             //조건1
            if(document.getElementById('cmbCD_GBN_SHR').value == "0"){
                gbn = "DPT_CD";
            }else{
                gbn = "JOB_CD";
            }

			dsT_CP_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa030.cmd.YMAA030CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&OCC_CD="+occ_cd+"&GBN="+gbn+"&DPT_CD="+dpt_cd+"&JOB_CD="+job_cd;
    		dsT_CP_CHANGE.reset();

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

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var occ_cd = document.getElementById('cmbOCC_CD_SHR').value;
			var dpt_cd = document.getElementById('cmbDPT_CD_SHR').value;
            var job_cd = document.getElementById('cmbJOB_CD_SHR').value;
            var gbn = "";

             //조건1
            if(document.getElementById('cmbCD_GBN_SHR').value == "0"){
                gbn = "DPT_CD";
            }else{
                gbn = "JOB_CD";
            }

            var url = "ymaa030_PV.jsp?PIS_YM="+pis_ym+"&OCC_CD="+occ_cd+"&GBN="+gbn+"&DPT_CD="+dpt_cd+"&JOB_CD="+job_cd;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			if (dsT_CP_CHANGE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_CHANGE.GridToExcel("연차수당지급내역", '', 225);

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

			//document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
            document.getElementById('cmbOCC_CD_SHR').value = "";
            document.getElementById('cmbCD_GBN_SHR').value = "0";
            document.getElementById('cmbDPT_CD_SHR').value = "";
            document.getElementById('cmbJOB_CD_SHR').value = "";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_CHANGE.ClearData();
            
            fnc_ChgCD_GBN_SHR();

            document.getElementById('txtPIS_YM_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_CHANGE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var pis_ym = document.getElementById('txtPIS_YM_SHR');

            if(pis_ym.value == ""){
                alert("해당년월을 입력하셔야 합니다!");
                pis_ym.focus();
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
        
            cfStyleGrid(form1.grdT_CP_CHANGE,0,"false","false");      // Grid Style 적용
            
            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
            
            fnc_ChgCD_GBN_SHR();

            //데이터셋 전송
            dsT_CM_COMMON_DEPT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.codenm.cmd.CODENMCMD&S_MODE=SHR&GBN=DEPT";
            dsT_CM_COMMON_DEPT.Reset();

            //직위구분
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR").add(oOption);

            }
            
            document.getElementById('txtPIS_YM_SHR').focus();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
		
        function fnc_ChgCD_GBN_SHR(){
        
            if(document.getElementById('cmbCD_GBN_SHR').value == "0") {
	            document.getElementById("CD_GBN_SHR_01").style.display="";
	            document.getElementById("CD_GBN_SHR_02").style.display="none";
            
            } else {
                document.getElementById("CD_GBN_SHR_01").style.display="none";
                document.getElementById("CD_GBN_SHR_02").style.display="";
            }

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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_CHANGE)   |
    | 3. 사용되는 Table List(T_CP_CHANGE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_CM_COMMON_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->

    <!-- 직위구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
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
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>
    <Script For=dsT_CM_COMMON_DEPT Event="OnLoadCompleted(iCount)">

        //소속구분
        for( var i = 1; i <= dsT_CM_COMMON_DEPT.CountRow; i++ ) {

            oOption       = document.createElement("OPTION");
            oOption.value = dsT_CM_COMMON_DEPT.NameValue(i,"CODE_CD");
            oOption.text  = dsT_CM_COMMON_DEPT.NameValue(i,"CODE_CD")+" "+dsT_CM_COMMON_DEPT.NameValue(i,"CODE_NM");
            document.getElementById("cmbDPT_CD_SHR").add(oOption);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
		cfErrorMsg(this);

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연차수당지급내역</td>
					<td align="right" class="navigator">HOME/보상관리/연차수당관리/<font color="#000000">연차수당지급내역</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="80"></col>
									<col width="80"></col>
                                    <col width="90"></col>
									<col width="100"></col>
                                    <col width="100"></col>
									<col width="80"></col>
									<col width=""></col>
								</colgroup>
							<tr>
                                <td class="searchState" align="right">해당년월&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','50','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">근로구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbOCC_CD_SHR" style="width:80" onChange="fnc_SearchList();">
                                        <option value="" >전체</option>
                                        <option value="A" >사무직</option>
                                        <option value="M" >택배직</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">조회구분&nbsp;</td>
								<td class="padding2423">
                                    <select id="cmbCD_GBN_SHR" style="width:80" onChange="fnc_ChgCD_GBN_SHR();">
                                        <option value="0" >소속별</option>
                                        <option value="1" >직위별</option>
                                    </select>
                                </td>    
                                <td class="padding2423">
                                    <div id="CD_GBN_SHR_01" style="DISPLAY:none">
	                                    <select id="cmbDPT_CD_SHR" name="cmbDPT_CD_SHR" style="WIDTH:120" onChange="fnc_SearchList();">
	                                        <option value="">전체</option>
	                                    </select>
                                    </div>
                                    
                                    <div id="CD_GBN_SHR_02" style="DISPLAY:none">
	                                    <select id="cmbJOB_CD_SHR" name="cmbJOB_CD_SHR" style="WIDTH:120" onChange="fnc_SearchList();">
	                                        <option value="">전체</option>
	                                    </select>
                                    </div>
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
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_CP_CHANGE">
							<param name="Format"					value="
								<C> id={currow}		    width=39    name='NO'			    align=center </C>
                                <C> id='DPT_NM'	        width=100	name='소속'	            align=center </C>
                                <C> id='JOB_NM'	        width=60	name='직위'	            align=center </C>
                                <C> id='ENO_NO'	        width=70	name='사번'	            align=center </C>
                                <C> id='ENO_NM'	        width=70	name='성명'	            align=center </C>
								<C> id='BSH_YMD'	    width=80	name='입사일'		    align=center    Mask='XXXX-XX-XX' </C>
                                <G> name='연차유급휴가일수' HeadBgColor='#F7DCBB'
                                    <C> id='ANUO_MM'	width=45	name='발생'			    align=right  </C>
                                    <C> id='ANUU_MM'	width=45	name='사용'		        align=right  </C>
                                    <C> id='ANUN_MM'    width=45	name='미사용'	        align=right  </C>
                                </G>
                                <C> id='TUN_DD'	        width=45	name='미사용;총일수'	align=right  </C>
                                <C> id='MNOR_WAG'	    width=90	name='통상임금'		    align=right  </C>
                                <C> id='PAY_AMT'	    width=90	name='정산금액'		    align=right  </C>
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

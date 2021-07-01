<!--
*****************************************************
* @source       : guna101.jsp
* @description : 미확인근태현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2010/01/28      권혁수        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>미확인근태현황</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTFFFT';

        var today = getToday();
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건(기간)
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
            var gun_gbn = document.getElementById("cmbGUN_CD").value;
            if(!fnc_SearchItemCheck()) return;

            dsT_DI_DILIGENCE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna101.cmd.GUNA101CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&GUN_CD_SHR="+gun_gbn;
            dsT_DI_DILIGENCE.reset();

            document.getElementById("txtSTR_YMD_SHR").focus();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';
			dsT_DI_DILIGENCE.ClearData();
			document.getElementById("txtSTR_YMD_SHR").focus();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
	        if(dsTemp != "Modal"){
	            frame = window.external.GetFrame(window);
	            frame.CloseFrame();
	        }else{
	            window.close();
	        }
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {
            var str_ymd = document.getElementById("txtSTR_YMD_SHR");
            if(str_ymd.value == ""){
                alert("근태일 입력하세요!");
                str_ymd.focus();
                return false;
            }
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	// 근태(입력)
        	var h4_cd = "";

			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {

                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE")

			    
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUN_CD").add(oOption);
			}



			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"false","false")      // Grid Style 적용
			document.getElementById("txtSTR_YMD_SHR").value = getToday();
            fnc_SearchList();//자동조회
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		function fnc_Proc(){
			var GUN_YMD_SHR = document.getElementById('txtGUN_YMD_SHR').value;
			if(GUN_YMD_SHR == ""){
				alert("근태적용일자를 입력하십시요");
				return;
			}
			if(confirm("[" + GUN_YMD_SHR +"] 의 근태일에 비어있는 근태코드를 [미확인 근태코드(S)]로 변경하시겠습니까?")){
				//데이터셋 전송
				dsT_DI_GROUPWARE.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna101.cmd.GUNA101CMD&S_MODE=PROC&GUN_YMD="+GUN_YMD_SHR;
				dsT_DI_GROUPWARE.Reset();
			}
		}
    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_DILIGENCE                     |
    | 3. Table List : T_DI_DILIGENCE                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_DILIGENCE)|
    | 3. 사용되는 Table List(T_DI_DILIGENCE)		 |
    +------------------------------------------------>
    <Object ID="dsT_DI_GROUPWARE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
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
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
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
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_GROUPWARE Event="OnLoadCompleted(iCount)">
        alert("작업을 완료하였습니다");
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_GROUPWARE Event="OnLoadError()">
        alert(cfErrorMsg(this));
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">미확인근태현황</td>
					<td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">미확인근태현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="imgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td class="searchState" align="right">해당기간&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }; cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> 
                                </td>
                                <td class="searchState" align="right">근태구분</td>
                                <td class="padding2423" align="left">
									<select id="cmbGUN_CD" style="width='100';" onChange="fnc_SearchList()" >
										<option value="">전체</option>			
									</select>
									<!--
			                        <select id="cmbGUN_GBN_SHR" style="width:100" onChange="fnc_SearchList();">
			                            <option value="" >전체</option>
			                            <option value="S" >미확인</option>
			                            <option value="C" >지각</option>
			                            <option value="W" >정상</option>
			                        </select>
									-->
                                </td>


							<td class="searchState" align="right">적용근태일자</td>
							<td class="padding2423" align="left"><input id="txtGUN_YMD_SHR" size="10" maxLength="10" onblur="cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGUN_YMD_SHR','','190','115');"></a></td>

							<td class="padding2423" align="left">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgProc','','/images/button/BatchAdjustOn.gif',1)">  <img src="/images/button/BatchAdjustOn.gif"   name="imgProc" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Proc()"></a>
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_DILIGENCE">
							<param name="Format"				value="
                                <C> id='{CUROW}'    width=50    name='NO'           align=center    value={String(Currow)}</C>
								<C> id='DPT_NM'		width=150	name='소속'		    align=center </C>
								<C> id='JOB_NM'		width=150	name='직위'			align=center </C>
								<C> id='ENO_NM'	    width=150	name='이름'			align=center </C>
								<C> id='ENO_NO'	    width=100	name='사번'			align=center </C>
								<C> id='GUN_NM'	    width=100	name='근태'			align=center </C>
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
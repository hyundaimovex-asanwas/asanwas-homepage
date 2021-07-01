<!--
***********************************************************************
* @source      : educ040.jsp
* @description : 연간계획기간설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/20      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

    boolean isMaster = false;
    boolean isSubMaster = false;

    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>
<head>
<title>연간계획기간설정(eduk040)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var pis_yy = document.getElementById('txtYEAR_SHR').value;

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_DI_DILIGENCE.ClearData();
			dsT_DI_DILIGENCE.DataId ="/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk040.cmd.EDUK040CMD&S_MODE=SHR&PIS_YY="+pis_yy;
			dsT_DI_DILIGENCE.Reset();

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

            trT_DI_DILIGENCE.KeyValue = "SAVE(I:SAV=dsT_DI_DILIGENCE)";
            trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk040.cmd.EDUK040CMD&S_MODE=SAV";
            trT_DI_DILIGENCE.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			var PIS_YY  = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"PIS_YY");

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("해당연도 [" + dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"PIS_YY") + "] 자료를 삭제하시겠습니까?") == false) return;

            dsT_DI_DILIGENCE.DeleteRow(dsT_DI_DILIGENCE.RowPosition);

            trT_DI_DILIGENCE.KeyValue = "DEL(I:DEL=dsT_DI_DILIGENCE)";
            trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk040.cmd.EDUK040CMD&S_MODE=DEL&PIS_YY="+PIS_YY;
            trT_DI_DILIGENCE.post();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_DI_DILIGENCE.CountColumn == 0) {
                //dsT_DI_DILIGENCE.setDataHeader("PIS_YY:STRING:NOTNULL, REG_STR_YMD:STRING, REG_END_YMD:STRING, APP_STR_YMD:STRING, APP_END_YMD:STRING");
                alert("조회 후 추가하세요.");
                return;
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_DI_DILIGENCE.AddRow();

            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "PIS_YY")  = getToday().substring(0,4);
            //dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REG_STR_YMD")  = '';
            //dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REG_END_YMD")  = '';
            //dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "APP_STR_YMD")  = '';
            //dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "APP_END_YMD")  = '';

            document.getElementById("txtPIS_YY").focus();

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
			document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_DILIGENCE.ClearData();

            document.getElementById('txtYEAR_SHR').focus();

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

            var pis_yy = document.getElementById("txtYEAR_SHR");

            //if(pis_yy.value == "" || pis_yy.value.length < 4){
            //    alert("4자리수의 년도를 입력하세요!");
            //    pis_yy.focus();
            //    return false;
            //}

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

			cfStyleGrid2(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style 적용
			
            //날짜값들 초기화
			document.getElementById("txtYEAR_SHR").value = getToday().substr(0,4);
            document.getElementById("txtYEAR_SHR").focus();


<%
    //관리자가 아니면 다른 사번으로 조회가 되지 않게
    if(!isMaster && !isSubMaster) {
%>
<%
    }
%>

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
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_DILIGENCE)|
    | 3. 사용되는 Table List(T_DI_DILIGENCE)		 |
    +------------------------------------------------>
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

  </script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연간계획기간설정</td>
					<td align="right" class="navigator">HOME/교육관리/연간학습계획/<font color="#000000">연간계획기간설정</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
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
			                	<col width="100"></col>
			                    <col width="*"></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">

                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtYEAR_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>

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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="40 "></col>
                    <col width="40 "></col>
                    <col width="80 "></col>
                    <col width="200"></col>
                    <col width="70 "></col>
                    <col width="182"></col>
                    <col width="70 "></col>
                    <col width="182"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">연도</td>
                    <td class="padding2423">
                        <input id="txtPIS_YY" name="txtPIS_YY" style="ime-mode:disabled" size="4" maxlength="4"  >
                    </td>
                    <td align="center" class="creamBold">연간교육신청</td>
                    <td class="padding2423">
                        <input id="txtREG_STR_YMD" name="txtREG_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10"  onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '신청시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtREG_STR_YMD', 'txtREG_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRegStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRegStrYmd" name="ImgRegStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtREG_STR_YMD','','0','252');"></a> ~
                        <input id="txtREG_END_YMD" name="txtREG_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '신청종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtREG_STR_YMD', 'txtREG_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRegEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRegEndYmd" name="ImgRegEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtREG_END_YMD','','112','252');"></a>
                    </td>
                    <td align="center" class="creamBold">연간교육결재</td>
                    <td class="padding2423">
                        <input id="txtAPP_STR_YMD" name="txtAPP_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10"  onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '결재시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtAPP_STR_YMD', 'txtAPP_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgAppStrYmd" name="ImgAppStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_STR_YMD','','0','252');"></a> ~
                        <input id="txtAPP_END_YMD" name="txtAPP_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '결재종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtAPP_STR_YMD', 'txtAPP_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgAppEndYmd" name="ImgAppEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_END_YMD','','112','252');"></a>
                    </td>
                </tr>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

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
		<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:220px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE">
                            <param name="Format"					value="
                                <C> id='PIS_YY'	width=100	name='연도'	align=center </C>
                                <C> id='REG_STR_YMD'	width=150	name='신청시작일'	align=center </C>
                                <C> id='REG_END_YMD'	width=150	name='신청종료일'	align=center </C>
                                <C> id='APP_STR_YMD'	width=150	name='결재시작일'	align=center </C>
                                <C> id='APP_END_YMD'	width=150	name='결재종료일'	align=center </C>
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

<!-- 급/상여 MASTER 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_DILIGENCE">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY       Ctrl=txtPIS_YY       Param=value </C>
        <C> Col=REG_STR_YMD       Ctrl=txtREG_STR_YMD       Param=value </C>
        <C> Col=REG_END_YMD       Ctrl=txtREG_END_YMD       Param=value </C>
        <C> Col=APP_STR_YMD     Ctrl=txtAPP_STR_YMD     Param=value </C>
        <C> Col=APP_END_YMD     Ctrl=txtAPP_END_YMD     Param=value </C>
    '>
</object>

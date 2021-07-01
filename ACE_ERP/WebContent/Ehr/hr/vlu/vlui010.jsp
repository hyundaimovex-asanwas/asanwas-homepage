<!--
*****************************************************
* @source       : vlui010.jsp
* @description  : 고과표입력 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>고과표입력(vlui010)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
            var GRADE_STR = document.form1.cmbGRADE_STR.value;    		//평가그룹

            //정보 조회
            dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&GRADE="+GRADE_STR;
            dsT_EV_ABLRST.reset();

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
        function fnc_Save(s_mode) {

            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SAV";
            trT_EV_ABLRST.post();
        	fnc_SearchList();
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요
			if (dsT_EV_ABLRST.countrow<1){
				alert ("저장할 정보가 없습니다.");
			}else {

				if (confirm("선택한 정보를 삭제하시겠습니까?")){
					dsT_EV_ABLRST.deleterow(dsT_EV_ABLRST.rowposition);
			        trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			        trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=DEL";
			        trT_EV_ABLRST.post();
					fnc_SearchList();
				}
			}
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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("고과표입력", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요
			dsT_EV_ABLRST.AddRow();

			dsT_EV_ABLRST.nameValue(dsT_EV_ABLRST.RowPosition, "EVAYM") = document.form1.txtREG_YM_SHR.value.replace("-","");        //해당년도
			dsT_EV_ABLRST.nameValue(dsT_EV_ABLRST.RowPosition, "GRPCD") = document.form1.cmbGRADE_STR.value;        				//해당년도


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


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_ABLRST.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			document.getElementById("loctitle").innerText = "HOME/인사평가/고과평가/";

			document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

	        cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");      // Grid Style 적용

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /********************************************
         * 16. 처리 버튼 클릭시 마지막 고과표로 입력 *
         *******************************************/
		function fnc_Conduct(){

            var txtJPR_YM = document.form1.txtJPR_YM.text;

			if (txtJPR_YM.trim().length != 6) {
				alert("생성할 고과표의 고과년월을 입력하십시요.");
		    	document.getElementById("txtJPR_YM").focus();
				return ;
			}else{

	            //정보 조회
	            dsT_EV_ABLRSTCHK.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SHR_01&JPR_YM="+txtJPR_YM;
	            dsT_EV_ABLRSTCHK.reset();

			}

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->
    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRSTCHK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRSTLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)">
    </Object>

    <Object ID ="trT_EV_ABLRSTLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:dsT_EV_ABLRSTLIST=dsT_EV_ABLRSTLIST)">
    </Object>
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <Script For=dsT_EV_ABLRSTCHK Event="OnLoadCompleted(iCount)">
        if (iCount >= 1)    {
            alert("생성할 고과년월의 고과표가 존재합니다.");
        } else {
	        //정보 조회
	        dsT_EV_ABLRSTLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SHR_02";
	        dsT_EV_ABLRSTLIST.reset();
        }
    </Script>

    <Script For=dsT_EV_ABLRSTLIST Event="OnLoadCompleted(iCount)">
        if (iCount >= 1)    {

			if (confirm(document.form1.txtJPR_YM.text+ "고과표를 생성하시겠습니까?")) {
				for(i=1;i<=iCount;i++){
						dsT_EV_ABLRSTLIST.namevalue(i,"EVAYM") =  document.form1.txtJPR_YM.text;
						dsT_EV_ABLRSTLIST.UserStatus(i)=1; //insert
				}
			        	trT_EV_ABLRSTLIST.KeyValue = "tr01(I:dsT_EV_ABLRSTLIST=dsT_EV_ABLRSTLIST)";
						trT_EV_ABLRSTLIST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=CRT";
						trT_EV_ABLRSTLIST.post();
						alert("요청하신 작업을 완료하였습니다.")
			}

        } else {
			alert("참조할 기생성된 고과표가 존재하지 않아서  고과표를 일괄적으로 생성할 수 없습니다.");
        }
    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고과표입력</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">고과표입력</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('SAV_02')"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="60"></col>
                                <col width="60"></col>
                                <col width="60"></col>
                                <col width=""></col>
                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">직급</td>
                                <td class="padding2423">
                                    <select id="cmbGRADE_STR">
                                        <option value="1">대리이하</option>
                                        <option value="2">과장이상</option>
                                        <option value="4">부서장</option>
                                    </select>

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
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:420px;">
                            <param name="DataID"                	value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                	value="true">
                            <param name="DragDropEnable"        	value="true">
                            <param name="SortView"                	value="Left">
                            <param name="VIEWSUMMARY"            	value=0>
                            <param name="Format"                	value="
                                <C> id='EVAYM'       	width=60    name='고과년월'     align=left   Edit=None show=false</C>
                                <C> id='DIVCD'        	width=60    name='부문'         align=left   Edit=None value={IF (DIVCD='1','능력',IF (DIVCD='2','업적' , IF (DIVCD='3','태도' '')))}</C>
                                <C> id='JOBGRPH'        width=50    name='직군'         align=left   Edit=None show=false</C>
                                <C> id='GRPITEM'        width=70    name='항목구분'     align=left   Edit=None value={IF (GRPITEM='1','태도',IF (GRPITEM='2','능력' , IF (GRPITEM='3','업적',GRPITEM)))}</C>
                                <C> id='PRTSEQ'         width=30    name='순번',        align=center Edit=none</C>
                                <C> id='ASKITEM'        width=150   name='평가요소'     align=left 	 Edit=none</C>
                                <C> id='ESCR'           width=40    name='탁월'        	align=center Dec=2</C>
                                <C> id='GSCR'           width=40    name='우수'         align=center Dec=2</C>
                                <C> id='MSCR'       	width=40    name='보통'       	align=center Dec=2</C>
                                <C> id='LSCR'        	width=40    name='부족' 		align=center Dec=2</C>
                                <C> id='PSCR'        	width=40    name='문제'       	align=center Dec=2</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

		  		<td >
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=3
					style='width:243px;height:422px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;일괄생성</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=txtJPR_YM  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style=" position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; ">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object>
							</comment><script> __ShowEmbedObject(__NSID__);</script>
                        	<nobr>&nbsp;</nobr>
	            		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct()"></a>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="creamBold"><nobr>&nbsp;고과년월</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gcem_yymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object>
							</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
							</td>
						</tr>
						<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;&nbsp;&nbsp;직급</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gclx_grpcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
										<param name="CBData" 			value="1^대리이하,2^과장이상,3^상향고과,4^부서" />
										<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
										<param name="Index" 			value="0" />
										<param name="SearchColumn" 		value="COM_SNAME" />
										<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
										<param name="BindColumn" 		value="COM_CODE" />
										<param name="Enable" 			value="true" />
								</object>
							</comment><script>__ShowEmbedObject(__NSID__);</script>		&nbsp;</nobr>
							</td>
						</tr>
						<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;&nbsp;&nbsp;부문</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
								<comment id="__NSID__">
								<object id=gclx_divcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
											<param name="CBData" 			value="1^능력,2^업적,3^태도" />
											<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
											<param name="Index" 			value="0" />
											<param name="SearchColumn" 		value="COM_SNAME" />
											<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
											<param name="BindColumn" 		value="COM_CODE" />
											<param name="Enable" 			value="true" />
								</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>	&nbsp;</nobr>
								</td>
							</tr>
							<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;&nbsp;&nbsp;직군</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
										<comment id="__NSID__">
										<object id=gclx_jobgrphcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
										<param name="CBData" 			value="00^공통,10^사무직,20^영업직,30^기술직,40^기타" />
										<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
										<param name="Index" 			value="0" />
										<param name="SearchColumn" 		value="COM_SNAME" />
										<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
										<param name="BindColumn" 		value="COM_CODE" />
										<param name="Enable" 			value="true" />
									</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;항목구분</td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
										<comment id="__NSID__">
										<object id=gclx_grpitemcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=120>
										<param name="CBData" 			value="1^태도,2^능력,3^업적" />
										<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
										<param name="Index" 			value="0" />
										<param name="SearchColumn" 		value="COM_SNAME" />
										<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
										<param name="BindColumn" 		value="COM_CODE" />
										<param name="Enable" 			value="true" />
										</object>
										</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;순번</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_prtseq   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:20px; height:18px; font-family:굴림;font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=ClipMode	      value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="">
										<param name=MaxLength     value=2>
										<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;평가요소</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_askitem" name="txt_askitem" type="text"  class="txt21" style="position:relative; left:-5px;width:150px;" maxlength=34 >&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;탁월</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_escr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;우수</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_gscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;보통</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_mscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;부족</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_lscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"  class="creamBold">&nbsp;&nbsp;&nbsp;문제</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_pscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
						</table>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_EV_ABLRST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_ABLRST">
	<Param Name="BindInfo", Value='
    	<C>Col=EVAYM           	Ctrl=gcem_yymm2        		Param=text</C>
    	<C>Col=GRPCD          	Ctrl=gclx_grpcd2           	Param=BindColVal</C>
		<C>Col=DIVCD           	Ctrl=gclx_divcd            	Param=BindColVal</C>
		<C>Col=JOBGRPH       	Ctrl=gclx_jobgrphcd      	Param=BindColVal</C>
		<C>Col=PRTSEQ         	Ctrl=gcem_prtseq         	Param=text</C>
		<C>Col=GRPITEM       	Ctrl=gclx_grpitemcd      	Param=BindColVal</C>
		<C>Col=ASKITEM       	Ctrl=txt_askitem           	Param=value</C>
		<C>Col=ESCR            	Ctrl=gcem_escr          	Param=text</C>
		<C>Col=GSCR            	Ctrl=gcem_gscr          	Param=text</C>
		<C>Col=MSCR            	Ctrl=gcem_mscr         		Param=text</C>
		<C>Col=LSCR             Ctrl=gcem_lscr          	Param=text</C>
		<C>Col=PSCR             Ctrl=gcem_pscr         		Param=text</C>
    '>
</object>

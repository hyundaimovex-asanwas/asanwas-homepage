<!--
*****************************************************
* @source       : gunc091.jsp
* @description : 휴일근무사전신청 결재 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2009/09/10      장문열        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>휴일근무사전신청결재</title>
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
		var btnList = 'TTTTTFTT';
        var param = window.dialogArguments;
        var GUN_YMD  = param.gun_ymd
		var GUN_DPT  = param.req_no.substr(9,3);
		var REQ_NO   = param.req_no;
		var obj = new String();
		obj.app_cmt = "";
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {


			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc090.cmd.GUNC090CMD"
                                      + "&S_MODE=SHR"
                                      + "&HOL_YMD_SHR="+GUN_YMD
                                      + "&DPT_CD_SHR="+GUN_DPT;
			dsT_DI_HOLIDAYWORK.reset();

            //결재자 조회
            fnc_SearchApprover();
        }

        /**
         * 결재자 정보를 조회한다.
         */
        function fnc_SearchApprover() {

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=R";
            dsT_DI_APPROVAL.Reset();
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

            //이곳에 해당 코딩을 입력 하세요

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

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
			window.close();
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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,15,"false","false")      // Grid Style 적용

        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";


            //시작하자마자 폼 로드
            fnc_SearchList();
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        //입력 element
        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_HOL_HOUR"
                                        ,"cmbSTR_HOL_MIN"
                                        ,"cmbEND_HOL_HOUR"
                                        ,"cmbEND_HOL_MIN"
                                        ,"txtREMARK" );

        //예외 항목
        var exceptionList = new Array(   "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");


		function fnc_InputDisabled() {
            document.getElementById("txtHOL_YMD_SHR").className = "input_ReadOnly";
            document.getElementById("txtHOL_YMD_SHR").readOnly = true;
            document.getElementById("txtHOL_YMD_SHR").innerText  = GUN_YMD.substring(0,4)+"-"+GUN_YMD.substring(4,6)+"-"+GUN_YMD.substring(6,8);


		}


        /**
         * 결재를 처리 한다.
         */
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" 처리를 하시겠습니까?")) return;

            var app_yn = "Y";    //결재완료여부

			if (kind == "부결") {
				app_yn = "N";
				window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			}

			dsT_DI_HOLIDAYWORK.UserStatus(1) = 1;
			dsT_DI_HOLIDAYWORK.NameValue(1,"REMARK") = obj.app_cmt;   // 결재의견 Container

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc091.cmd.GUNC091CMD"
                                      + "&S_MODE=SAV_APP"
                                      + "&APP_YN="  +app_yn
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"R"
                                      + "&GUN_DPT=" +GUN_DPT
                                      + "&REQ_NO="  +REQ_NO;
			trT_DI_HOLIDAYWORK.post();
            //결재상태 조회
            //fnc_SearchApprover();

		}

        /**
         * 부결을 처리 한다.

		function fnc_SubmitCancle(kind) {
            var obj = new String();
            var	row = "";
            var leno_no = dsT_DI_APPROVAL.NameValue(2,"ENO_NO");//최상위가 최종결재자
            var our_man = '<%=box.get("SESSION_ENONO")%>';

			if(leno_no != our_man){
	            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "N";  // 'R' 상신, 'Y' 결재, 'N' 반려
	            row = "1"

            }else if(leno_no == our_man){
	            dsT_DI_APPROVAL.NameString(2, "APP_YN") = "N";  // 'R' 상신, 'Y' 결재, 'N' 반려
	            row = "2"
            }

            window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != undefined){

				trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc091.cmd.GUNC091CMD"
	                                      + "&S_MODE=UPT_REJ"
	                                      + "&APP_YN="  +dsT_DI_APPROVAL.NameString(row, "APP_YN")
	                                      + "&GUN_YMD=" +dsT_DI_APPROVAL.NameString(row, "GUN_YMD")
	                                      + "&GUN_GBN=" +dsT_DI_APPROVAL.NameString(row, "GUN_GBN")
	                                      + "&GUN_DPT=" +dsT_DI_APPROVAL.NameString(row, "GUN_DPT")
	                                      + "&SEQ_NO="  +dsT_DI_APPROVAL.NameString(row, "SEQ_NO")
	                                      + "&REMARK="  +obj.app_cmt;
				trT_DI_HOLIDAYWORK.post();
            //결재상태 조회
            fnc_SearchApprover();

           //     document.getElementById("btn_approval").style.display = "none";

            }

        }
*/

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_HOLIDAYWORK                                |
    | 3. Table List : T_DI_HOLIDAYWORK                           |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_HOLIDAY                                      |
    | 3. Table List : T_DI_HOLIDAY                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			                  |
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_HOLIDAYWORK)		  |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK)	                  |
    +--------------------------------------------------->
    <Object ID ="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_DI_HOLIDAYWORK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>


    <!-- 결재선 조회 후 -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    	var SESSION_ENONO = '<%=box.get("SESSION_ENONO")%>';
		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");

		fnc_InputDisabled();


		// 결재자 상신 상태일 경우 결재자에게 결재,부결 이미지 보여주기
		for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
			var APP_YN = dsT_DI_APPROVAL.NameString(i, "APP_YN");
			var ENO_NO = dsT_DI_APPROVAL.NameString(i, "ENO_NO");

			if(ENO_NO == SESSION_ENONO && APP_YN == "") {
				fnc_ShowElement("imgApproval");
				fnc_ShowElement("imgRejection");
				dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
				break;
			}
		}
            document.getElementById("txtORD_NO").innerText      = dsT_DI_APPROVAL.NameValue(1, "REQ_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IENO_NM");
            document.getElementById("txtDPT_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
            document.getElementById("txtJOB_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IJOB_NM");

            document.getElementById("txtDPT_NM_SHR").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
            document.getElementById("txtDPT_CD_SHR").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_CD");

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnDataError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_HOLIDAYWORK event="OnSuccess()">
        fnc_SearchList();
		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_HOLIDAYWORK event="OnFail()">
        cfErrorMsg(this);
    </script>


	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">휴일근무사전신청결재</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/<font color="#000000">휴일근무결재처리</font></td>
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
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('결재');"></a>
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('부결');"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"            name="imgExit"      width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->
<!-- 결재 정보  시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 기안자 정보 시작 -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="creamBold">품의번호</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="creamBold">소속</td>
								<td class="padding2423">
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">직위</td>
								<td class="padding2423">
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">상신자</td>
								<td class="padding2423">
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 기안자 정보 끝 -->
        </td>
        <td width="30">&nbsp;&nbsp;&nbsp;</td>
        <td>
        	<!-- 결재선 정보 테이블 시작 -->
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='REQ_NO'		width=40	name='등록번호'	align=center	show=false</C>
								<C> id='ENO_NO'		width=100	name='사번'		align=center	show=false</C>
            					<C> id='SEQ_NO'		width=50	name='구분'		align=center	Value={DECODE(ENO_NO,'100019','협조','결재')}</C>
								<C> id='ENO_NM'		width=70	name='결재자'	align=center</C>
								<C> id='JOB_NM'		width=60	name='직위'		align=center	</C>
                                <C> id='DPT_NM'		width=100	name='부서'		align=left		</C>
								<C> id='APP_YN'		width=160	name='결재상태'	align=left		Value={DECODE(APP_YN,'Y','승인','N','부결','미결')&' '&APP_YMD} </C>
								<C> id='REMARK1'	width=87	name='의견'		align=center 	Color='Blue'	</C>
								<C> id='REMARK'		width=60	name='사유'		align=center	show=false</C>
							">
							<param name="wmode" value="transparent" >
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- 결재선 정보 테이블 끝 -->
        </td>
    </tr>
</table>
<br>
<!-- 결재 정보  끝 -->
<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td align="center" >
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            	<colgroup>
                	<col width="100"></col>
                    <col width="120"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
					<td align="right" class="searchState">휴일근무일자&nbsp;</td>
                    <td class="padding2423">

                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="100" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input id="txtHOL_YMD_SHR" readonly size="10" maxLength="10" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" ></a>
                                </td>
                            </tr>
                   </table>

					</td>
                    <td align="right" class="searchState">부&nbsp;&nbsp;서&nbsp;</td>
                    <td class="padding2423">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="3" class="input_ReadOnly" readOnly>
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" ></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				value="dsT_DI_HOLIDAYWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=39			name='NO'								align=center	value={String(Currow)}	</C>
								<C> id='JOB_NM'			width=70			name='직위'								align=center													</C>
								<C> id='ENO_NO'			width=70			name='사번'								align=center													</C>
								<C> id='ENO_NM'			width=70			name='성명'								align=center													</C>
								<C> id='HOL_YMD'		width=90			name='근무일자'							align=center													</C>
								<C> id='STR_TIME'		width=75			name='시작시간'							align=center													</C>
                                <C> id='END_TIME'		width=75			name='종료시간'						    align=center													</C>
                                <C> id='TOT_TIME'		width=75			name='총근무시간'						align=center													</C>
                                <C> id='REMARK'         width=200           name='근무내용'                         align=left      Edit=none                  </C>
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
<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
            	<colgroup>
                	<col width="400"></col>
                    <col width="350"></col>
                    <col width="*"></col>
                </colgroup>
	<tr>
		<td class="paddingTop8">
			<table  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	  	<td class="paddingTop8">
	  		<table  border="0" cellspacing="0" cellpadding="0">
	  		  <tr>
				<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
				  * 휴일근무지급기준:전월1일~말일분까지 금월급여에 산정 <br>
				  * 입력기간:휴일전까지 <br>
				  * 휴일근무시간 : 4 ~ 8 시간 인정<br></font>
				</td>
			  </tr>
			 </table>
         </td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>


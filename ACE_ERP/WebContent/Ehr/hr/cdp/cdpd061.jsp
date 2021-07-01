<!--
***********************************************************************
* @source      : cdpd061.jsp
* @description : OJT평가서 결재처리 - 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/20      권혁수        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //품의자사번
%>
<html>
<head>
	<title>OJT평가서 결재처리 - 결재세부사항(cdpd061)</title>
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

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var dsTemp = window.dialogArguments;
		var obj = new String();
		obj.app_cmt = "";
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	dsT_DI_APPROVAL.ClearData();
            //결재세부사항 조회
            trT_DI_APPROVAL.KeyValue = "SVC(O:SHR=dsT_CD_OJT, O:SHR_00=dsT_CD_OJTRPT, O:SHR_01=dsT_CD_OJTEVAL, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd061.cmd.CDPD061CMD&S_MODE=SHR&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
            trT_DI_APPROVAL.post();
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
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
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

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
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

            cfStyleGrid(form1.grdT_CD_OJTEVAL,0,"true","false");
            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

			// 결재자만 버튼이 활성화
			//alert(dsTemp.NameValue(1,"ENO_NO"));
			//alert("<%=eno_no%>");
			//alert(dsTemp.NameValue(1,"ENO_NO")== "<%=eno_no%>");
            if(dsTemp.NameValue(1,"ENO_NO")== "<%=eno_no%>"){
                fnc_ShowElement("btn_approval");
            }else{
                fnc_HiddenElement("btn_approval");
            }

            var nowDate = getToday().replace("-","").replace("-","");

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid() {

		}

        /********************************************
         * 17. 승인, 기각 버튼 처리					*
         ********************************************/
		function fnc_Approval() {

            if (confirm("결재처리를 하시겠습니까?")) {

				dsT_CD_OJT.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_CD_OJT=dsT_CD_OJT)";
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd061.cmd.CDPD061CMD&S_MODE=SAV&APP_YN=Y&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				trT_DI_APPROVAL.post();
            }

            window.close();

		}
		function fnc_Reject() {


            if (confirm("부결처리를 하시겠습니까?")) {
				if(obj.app_cmt == ""){
          			window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
          	    }

	            if(obj.app_cmt == ""){
	                alert("부결 또는 반송사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
	                return false;
            	}
				dsT_CD_OJT.UserStatus(1) = 1;
				document.getElementById("txtREMARK").innerText = obj.app_cmt;
				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_CD_OJT=dsT_CD_OJT)";
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd061.cmd.CDPD061CMD&S_MODE=SAV&APP_YN=N&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				trT_DI_APPROVAL.post();
            }
            window.close();

		}
		function fnc_ShowRemarkPop(){
			showPopupLayer("PopupLayer");
		}
//----------------------------------------------
function closePopupLayer(name){
 if(document.all[name].style.display==""){
  document.all[name].style.display="none"
 }
}
function showPopupLayer(name){
 if(document.all[name].style.display=="none"){
  document.all[name].style.display=""
 }
}

isIE=document.all;
isNN=!document.all&&document.getElementById;
isN4=document.layers;
isHot=false;

function ddInit(e){
  topDog=isIE ? "BODY" : "HTML";
  whichDog=isIE ? document.all.PopupLayer : document.getElementById("PopupLayer");
  hotDog=isIE ? event.srcElement : e.target;
  while (hotDog.id!="PopupLayer"&&hotDog.tagName!=topDog){
    hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
  }
  if (hotDog.id=="PopupLayer"){
    offsetx=isIE ? event.clientX : e.clientX;
    offsety=isIE ? event.clientY : e.clientY;
    nowX=parseInt(whichDog.style.left);
    nowY=parseInt(whichDog.style.top);
    ddEnabled=true;
    document.onmousemove=dd;
  }
}

function dd(e){
  if (!ddEnabled) return;
  whichDog.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx;
  whichDog.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
  return false;
}

document.onmousedown=ddInit;
document.onmouseup=Function("ddEnabled=false");


//----------------------------------------------
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet									|
    | 2. 이름은 ds_ + 주요 테이블명		   						|
    | 3. 사용되는 Table List              			 	   |
    |                    dsT_CD_OJT 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CD_OJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!-----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                      |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_OJTRESULT)|
    | 3. 사용되는 Table List(T_CD_OJTRESULT)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTRPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   <!-----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                      |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_OJTRESULT)|
    | 3. 사용되는 Table List(T_CD_OJTRESULT)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTEVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)			 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_APPROVAL)	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJT.CountRow );

            document.getElementById("txtORD_NO").innerText      = dsT_CD_OJT.NameValue(1, "REQ_NO");
            document.getElementById("txtPENO_NO").innerText      = dsT_CD_OJT.NameValue(1, "PENO_NO");
            document.getElementById("txtPENO_NM").innerText      = dsT_CD_OJT.NameValue(1, "PENO_NM");
            document.getElementById("txtPDPT_CD").innerText      = dsT_CD_OJT.NameValue(1, "PDPT_CD");
            document.getElementById("txtPDPT_NM").innerText      = dsT_CD_OJT.NameValue(1, "PDPT_NM");
            document.getElementById("txtPJOB_CD").innerText      = dsT_CD_OJT.NameValue(1, "PJOB_CD");
            document.getElementById("txtPJOB_NM").innerText      = dsT_CD_OJT.NameValue(1, "PJOB_NM");

            document.getElementById("txtNEW_ENO_NO").innerText      = dsT_CD_OJT.NameValue(1, "NEW_ENO_NO");
            document.getElementById("txtNEW_ENO_NM").innerText      = dsT_CD_OJT.NameValue(1, "NEW_ENO_NM");
            document.getElementById("txtNEW_DPT_CD").innerText      = dsT_CD_OJT.NameValue(1, "NEW_DPT_CD");
            document.getElementById("txtNEW_DPT_NM").innerText      = dsT_CD_OJT.NameValue(1, "NEW_DPT_NM");
            document.getElementById("txtNEW_JOB_CD").innerText      = dsT_CD_OJT.NameValue(1, "NEW_JOB_CD");
            document.getElementById("txtNEW_JOB_NM").innerText      = dsT_CD_OJT.NameValue(1, "NEW_JOB_NM");
            document.getElementById("txtTRA_ENO_NO").innerText      = dsT_CD_OJT.NameValue(1, "TRA_ENO_NO");
            document.getElementById("txtTRA_ENO_NM").innerText      = dsT_CD_OJT.NameValue(1, "TRA_ENO_NM");
            document.getElementById("txtMDPT_CD").innerText      = dsT_CD_OJT.NameValue(1, "MDPT_CD");
			document.getElementById("txtMDPT_NM").innerText      = dsT_CD_OJT.NameValue(1, "MDPT_NM");
            document.getElementById("txtMJOB_CD").innerText      = dsT_CD_OJT.NameValue(1, "MJOB_CD");
            document.getElementById("txtMJOB_NM").innerText      = dsT_CD_OJT.NameValue(1, "MJOB_NM");

            document.getElementById("txtSTR_YMD").innerText      = dsT_CD_OJT.NameValue(1, "STR_YMD");
            document.getElementById("txtEND_YMD").innerText      = dsT_CD_OJT.NameValue(1, "END_YMD");
            document.getElementById("txtTRA_DPT_CD").innerText      = dsT_CD_OJT.NameValue(1, "TRA_DPT_CD");
            document.getElementById("txtTRA_DPT_NM").innerText      = dsT_CD_OJT.NameValue(1, "TRA_DPT_NM");
            document.getElementById("txtHIR_YMD").innerText      = dsT_CD_OJT.NameValue(1, "HIR_YMD");
            document.getElementById("txtTRA_DUTY").innerText      = dsT_CD_OJT.NameValue(1, "TRA_DUTY");
            document.getElementById("txtHEAD_EMP_NO").innerText      = dsT_CD_OJT.NameValue(1, "HEAD_EMP_NO");
            document.getElementById("txtHEAD_EMP_NM").innerText      = dsT_CD_OJT.NameValue(1, "HEAD_EMP_NM");
            document.getElementById("txtEDU_GOAL1").innerText      = dsT_CD_OJT.NameValue(1, "EDU_GOAL1");
            document.getElementById("txtEDU_GOAL2").innerText      = dsT_CD_OJT.NameValue(1, "EDU_GOAL2");
            document.getElementById("txtEDU_GOAL3").innerText      = dsT_CD_OJT.NameValue(1, "EDU_GOAL3");

        }

    </Script>
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTEVAL Event="OnLoadCompleted(iCount)">

        grdT_CD_OJTEVAL.RowHeight = "34";
    </Script>
	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_CD_OJTRPT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJT.CountRow );


            document.getElementById("txtEVAL_ENO_NO").innerText      = dsT_CD_OJTRPT.NameValue(1, "EVAL_ENO_NO");
            document.getElementById("txtEVAL_ENO_NM").innerText      = dsT_CD_OJTRPT.NameValue(1, "EVAL_ENO_NM");
            document.getElementById("txtEVAL_YMD").innerText      = dsT_CD_OJTRPT.NameValue(1, "EVAL_YMD");
            document.getElementById("txtOPINION").innerText      = dsT_CD_OJTRPT.NameValue(1, "OPINION");

        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

		document.getElementById("btn_approval").style.display = "none";
        var eno_no = "";
		var app_yn = "";

                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//결재자
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//결재여부

			            //해당 결재자 의견입력 준비.
					if(eno_no == '<%=box.get("SESSION_ENONO")%>' &&  app_yn == "" ){
						document.getElementById("btn_approval").style.display = "";
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
						break;
					}
                }

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
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
		alert(obj.app_cmt);
		if(obj.app_cmt != undefined){
			document.getElementById("txtREMARK").innerText = obj.app_cmt;
		}

	}
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">OJT평가서 결재처리 - 결재세부사항</td>
					<td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">OJT평가서 결재처리 - 결재세부사항</font></td>
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
                <span id="btn_approval" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)">  <img src="/images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Approval();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)">  <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reject();"></a>
                </span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 조건 입력 테이블 시작 -->
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
									<input type="hidden" id="txtPDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtPDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">직위</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtPJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtPJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">사번/성명</td>
								<td class="padding2423">
									<input type="hidden" id="txtPENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtPENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
        </td>
        <td width="30">&nbsp;</td>
        <td>
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
        </td>
    </tr>
</table>
<br>
<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                	<col width="90"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                	<td align="center" class="creamBold">대상자</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtNEW_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtNEW_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtNEW_DPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtNEW_DPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtNEW_JOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtNEW_JOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">책임지도사원</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">기간</td>
                    <td class="padding2423">
                    	<span id="txtSTR_YMD" name="txtSTR_YMD" ></span> ~ <span id="txtEND_YMD" name="txtEND_YMD" ></span>
                    </td>
                    <td align="center" class="creamBold">부서</td>
                    <td class="padding2423">
                        <span id="txtTRA_DPT_CD" name="txtTRA_DPT_CD" ></span>&nbsp;<span id="txtTRA_DPT_NM" name="txtTRA_DPT_NM" ></span>
                    </td>
                    <td align="center" class="creamBold">입사일</td>
                    <td class="padding2423">
                        <span id="txtHIR_YMD" name="txtHIR_YMD" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">담당팀장</td>
                    <td class="padding2423">
                        <span id="txtHEAD_EMP_NO" name="txtHEAD_EMP_NO" ></span>-
                        <span id="txtHEAD_EMP_NM" name="txtHEAD_EMP_NM" ></span>
                    </td>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423" colspan="3">
                    	<span id="txtTRA_DUTY" name="txtTRA_DUTY" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육목표</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtEDU_GOAL1" size="110" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL2" size="110" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL3" size="110" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->


<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>평가</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3" >
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_OJTEVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_CD_OJTEVAL">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=1>
                            <param name=SubsumExpr             value=total>
                            <param name="Format"                  value="
                                <C> id='CTGRY_DESC'     width=110    name='구분'      sumtext='합계'    align=center  edit=none suppress=1</C>
                                <C> id='ITEM_DESC'      width=320   name='평가기준'              align=left  edit=none  Multiline=true wordwrap=word scroll=vert </C>
                                <G> name='배점' HeadBgColor='#F7DCBB'
                                <C> id='QUESTION1'      width=50   name='A'  align=center  edit=none   </C>
                                <C> id='QUESTION2'      width=50   name='B'  align=center  edit=none   </C>
                                <C> id='QUESTION3'      width=50   name='C'  align=center  edit=none   </C>
                                <C> id='QUESTION4'      width=50   name='D'  align=center  edit=none   </C>
                                <C> id='QUESTION5'      width=50   name='E'  align=center  edit=none   </C>
                                </G>
                                <C> id='SCORE'      width=50   name='점수'      align=center  edit=none sumtext=@sum  </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="170"></col>
                    <col width="70"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">평가자</td>
                    <td class="padding2423">
                    	<span id="txtEVAL_ENO_NO" name="txtEVAL_ENO_NO" ></span>
                    	<span id="txtEVAL_ENO_NM" name="txtEVAL_ENO_NM" ></span>
                    </td>
                    <td align="center" class="creamBold">평가일</td>
                    <td class="padding2423">
                    	<span id="txtEVAL_YMD" name="txtEVAL_YMD" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">의견</td>
                    <td class="padding2423" colspan="3">
                    	<span id="txtOPINION" name="txtOPINION" ></span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->
<!-- 조회 상태 테이블 시작 -->
<table width="750" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
	</form>
	<!-- form 끝 -->

</body>
<!-- new popup start -->
<div id="PopupLayer" style="position:absolute; left:200px; top:185px; z-index:10000; width:300px; height:180px; display:none ;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="3" bgcolor="dbdbdb">
  <tr>
    <td bgcolor="#FFFFFF" style="padding:1 1 1 1" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="45" bgcolor="#408080">&nbsp;&nbsp;
		<span style="font-weight: bold"><font style='color:#FFFFFF;font-size:15px;font-face:돋움'>부결사유입력</font></span>
		</td>
		<td width="50" bgcolor="#408080" align="center">
		<a href="#" onClick="closePopupLayer('PopupLayer');return false"><font color=#ffffff face=arial  style="text-decoration:none">닫기</font></a>
		</td>
      </tr>
      </table>
      <table width="100%" border="0" cellspacing="30" cellpadding="0">
        <tr>
          <td><textarea id="txtREMARK"  name="txtREMARK" cols="50" rows="5"></textarea></td>
        </tr>
      </table>
      <table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="d3e3dd" height="26">
        <tr height='26'>
          <form name="form" id="form">
            <td width="15"></td>
            <td align="center"><a href="#" onClick="fnc_Reject();return false"><font color=#000000 face=arial  style="text-decoration:none">확인</font></a>
            <td width="15"></td>
          </form>
        </tr>
      </table></td>
  </tr>
</table>
</div>
<!-- new popup end -->
</html>
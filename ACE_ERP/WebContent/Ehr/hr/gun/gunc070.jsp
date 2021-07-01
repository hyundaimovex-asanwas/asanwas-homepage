<!--
***********************************************************************
* @source      : gunc070.jsp
* @description : 휴일근무수당정산 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/06      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>휴일근무신청현황(gunc070)</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'F' + 'F' + 'T';

        var today = getToday();
        var params = null;


		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			//근태변경신청현황 정보 조회
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_yymm = document.getElementById("txtPIS_YM_SHR").value; // 시작년월

			//시작년월이 없으면 조회못함.
			if(str_yymm.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(str_yymm.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YM_SHR").focus();
					return false;
				}
			}

			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc070.cmd.GUNC070CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&STR_YYMM="+str_yymm;
			dsT_DI_HOLIDAYWORK.reset();

			//결재자 조회
            fnc_SearchApprover();
        }



        /**
         * 결재자 정보를 조회한다.
         */
        function fnc_SearchApprover() {
            var HOL_YMD = document.getElementById("txtPIS_YM_SHR").value;
         // var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var DPT_CD  = "ZZZ" //document.getElementById("txtDPT_CD_SHR").value;

			HOL_YMD = HOL_YMD.replace("-","")
            var REQ_NO  = HOL_YMD + "JZZZ";
/**
            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=J";
            dsT_DI_APPROVAL.Reset();
   */
            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc090.cmd.GUNC090CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&GUN_GBN=J"       // J.휴일근무수당 정산
                                   + "&GUN_YMD="+HOL_YMD
                                   + "&GUN_DPT="+DPT_CD;
            dsT_DI_APPROVAL.Reset();
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

          	// save

/*
			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
*/
			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc070.cmd.GUNC070CMD&S_MODE=SAV";
			trT_DI_HOLIDAYWORK.post();



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

            if (dsT_DI_HOLIDAYWORK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_HOLIDAYWORK.GridToExcel("휴일근무수당정산", '', 225);

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
			document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_HOLIDAYWORK.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_DI_HOLIDAYWORK.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();
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

         	if ( !dsT_DI_HOLIDAYWORK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_HOLIDAYWORK, 0, "true", "false");      // Grid Style 적용
         // cfStyleGrid(form1.grdT_DI_HOLIDAYWORK, 0, "true", "false");      // Grid Style 적용
            form1.grdT_DI_HOLIDAYWORK.Editable = "true";

            document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
            document.getElementById("txtPIS_YM_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";


            document.getElementById("txtPIS_YM_SHR").focus();
			document.getElementById("hidDPT_CD_ORI").value = "<%= box.get("SESSION_DPTCD")%>";// 소속

            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

            fnc_SearchList();
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
          // test  fnc_HiddenElement("imgConduct");
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


        /**
         * 결재선 지정 		*/
        function fnc_Approval() {
            var DPT_CD = document.getElementById("hidDPT_CD_ORI").value;

            //결재자 정보 조회
            window.showModalDialog("./gunc011.jsp", dsT_DI_APPROVAL, "dialogWidth:500px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            }


        /**
         * 결재 진행상태 체크.
         */
         function fnc_ApprovalCheck() {

           //상신후 재상신시 그 사이에 결재가 되어버렸는지 체크하자!
            dsT_DI_APPROVAL2.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc090.cmd.GUNC090CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&GUN_GBN=R"       // R.휴일근무사전신청
                                   + "&GUN_YMD="+dsT_DI_APPROVAL.NameString(1, "GUN_YMD")
                                   + "&GUN_DPT="+dsT_DI_APPROVAL.NameString(1, "GUN_DPT");
            dsT_DI_APPROVAL2.Reset();

            if(dsT_DI_APPROVAL2.NameString(1, "APP_YN") != dsT_DI_APPROVAL.NameString(1, "APP_YN")){
            	alert("이미 부서장 결재가 완료되어 수정 할 수 없습니다.");
				fnc_SearchList();
            	return false;
            }
            else {
            	return true;
            }
         }
        /**
         * 상신처리
         */
        function fnc_Conduct() {



            //2.상신처리함


            if(dsT_DI_APPROVAL.CountRow < 2
                    || dsT_DI_APPROVAL.NameString(1, "ENO_NO") == ""
                    || dsT_DI_APPROVAL.NameString(2, "ENO_NO") == "" ) {
                alert("결재선을 지정해주세요.");
                return;
            }

            dsT_DI_APPROVAL.UserStatus(dsT_DI_APPROVAL.RowPosition) = 1; //결재 갱신을 위한 설정
            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "R";  // 'R' 상신, 'Y' 결재, 'N' 반려


            //1.상신처리하기전 입력 데이터를 한번 저장
            trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc070.cmd.GUNC070CMD&S_MODE=SAV_APP";
            trT_DI_HOLIDAYWORK.post();
        }
        /********************************************
         * 16. 처리 버튼							*
         ********************************************/
		function fnc_Reflect() {

		    var dpt_cd   = document.getElementById("txtDPT_CD_SHR");
			var str_yymm = document.getElementById("txtPIS_YM_SHR"); // 시작년월


			if((str_yymm.value.replace("-","") != addDate("M", getToday(), -1).replace("-","").substr(0,6)) &&
			   (str_yymm.value.replace("-","") != addDate("M", getToday(),  0).replace("-","").substr(0,6))){
               alert("휴일근무수당 정산 작업이 불가능합니다.");
               return;
            }

            params = "&S_MODE=PROC"
                   + "&STR_YYMM="+str_yymm.value.replace("-","")
                   + "&DPT_CD="+dpt_cd.value;

            dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc070.cmd.GUNC070CMD"+params;
            dsT_DI_HOLIDAYWORK.reset();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_HOLIDAYWORK)	   |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
		<param name=SubsumExpr        value="total">
	</Object>

    <!-----------------------------------------------------+
    | 1. 카피용 DataSet							           |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_HOLIDAYWORK)	   |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">

	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_HOLIDAYWORK)	   |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK)		       |
    +------------------------------------------------------>
	<Object ID="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK,I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)">
	</Object>
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_DI_APPROVAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>


    <!-- 결재선 조회 후 -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
      // alert("dsT_DI_APPROVAL.CountRow :"+ dsT_DI_APPROVAL.CountRow);
      if(dsT_DI_APPROVAL.CountRow == 0) {
                 return;
                 }


        var APP_YN  = dsT_DI_APPROVAL.NameString(1, "APP_YN");  //결재자 결재 유무 '':저장, 'R':상신, 'Y':결재, 'N':반려
        var APP_YN2  = dsT_DI_APPROVAL.NameString(2, "APP_YN");

        //'반려'이거나 '저장', '상신' 이면  수정이 가능
        // alert(APP_YN + "---------" + APP_YN2);
            if(APP_YN == "Y" || APP_YN2 == "Y") {    // 결재 완료 후 수정 불가
   	            form1.grdT_DI_HOLIDAYWORK.Editable = "false";
   	            fnc_HiddenElement("imgSelectapproval");
   	            fnc_HiddenElement("imgReport");

			}else{
   	            form1.grdT_DI_HOLIDAYWORK.Editable = "true";
            }


    </Script>
	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
        alert("조회 후 결재선 지정하여 주시기 바랍니다..");
    </Script>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
        alert("조회 후 결재선 지정하여 주시기 바랍니다.");
    </Script>
	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_DI_HOLIDAYWORK event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_HOLIDAYWORK event="OnFail()">
        cfErrorMsg(this);
    </script>
    <!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_DI_HOLIDAYWORK event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "CONF_SEL" && dsT_DI_HOLIDAYWORK.CountRow > 0) {
            for(var i=1; i<=dsT_DI_HOLIDAYWORK.CountRow; i++) {
                if(dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") == "F") {
                    dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") = "T";
                } else if(dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") == "T") {
                    dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") = "F";
                }
            }
        }

    </script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		var obj = new String();
		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">휴일근무수당정산</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/<font color="#000000">휴일근무수당정산</font></td>
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
			<img src="/images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	      <!--      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"> <img src="/images/button/btn_ConductOn.gif" name="imgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>  -->
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table border="0">
	<tr>
	<td valign="top">
	<!-- power Search테이블 시작 -->
	<table width="390" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="90"></col>
							<col width="60"></col>
							<col width="160"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">해당년월&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtPIS_YM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','75','112');"></a>
							</td>
                            <td class="searchState" align=""right"">소&nbsp;&nbsp;속&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="hidDPT_CD_ORI" type="hidden">
								<input id="txtDPT_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="10" class="input_ReadOnly" readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
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

	</td>
		<td valign="top">

        	<!-- 결재선 정보 테이블 시작 -->
			<table width="400" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:80px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='REQ_NO'	width=40	name='등록번호'	align=center	show=false</C>
            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
            					<C> id='DPT_NM'	width=80	name='부서'		align=center	show=false</C>
								<C> id='JOB_NM'	width=60	name='직위'		align=center	</C>
								<C> id='ENO_NO'	width=100	name='사번'		align=center	show=false</C>
								<C> id='ENO_NM'	width=70	name='성명'		align=center	</C>
								<C> id='APP_YN'	width=160	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')&' '&APP_TIME} </C>
								<C> id='REMARK1'	width=60	name='사유'	align=center 	Color='Blue'	</C>
								<C> id='REMARK'	width=60	name='사유'		align=center	show=false</C>
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


	<!-- 조회 상태 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td align="right">
	                        <span id="btn_InsDel">
							<img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" ><br><br>
	                        </span>
			            </td>
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
					<object id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
						<param name="DataID" value="dsT_DI_HOLIDAYWORK">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=39    name="NO"			align=center SubSumText=""</C>
                            <C> id="CONF_SEL"	width=50    name="선택"         align=center    Edit=True EditStyle=CheckBox,Pointer=Hand   HeadCheckShow=true  Edit={IF(CONF_SEL="","false","true")} </C>
                            <C> id="DPT_NM"		width=110	name="소속"		    align=center    Edit=none	Suppress="1"</C>
                            <C> id="JOB_NM"		width=50	name="직위"		    align=center    Edit=none	Suppress="2"</C>
                            <C> id="ENO_NO"	    width=68	name="사번"         align=center    Edit=none	Suppress="3"</C>
                            <C> id="ENO_NM"	    width=65	name="성명"	        align=center    Edit=none	Suppress="3" SubSumText="합계"</C>
                            <C> id="HOL_AMT"	width=75	name="휴일근무수당"	    align=right     Edit=none	</C>
                            <C> id="HOL_YMD"	width=80	name="휴일근무일자"	align=center    Edit=none Mask="XXXX-XX-XX" </C>
                            <C> id="AFT_TIME"	width=90	name="근무시간"     align=center    Edit=none	</C>
                            <C> id="AFT_HOL"	width=67	name="총시간"       align=center    Edit=none	</C>

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
<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ 시스템명 : 일용직 인사관리 - 결재 기안
+ 기능정의 : 결재 기안한다.
+ 프로그램ID : aday050.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2013.04.03
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>결재 신청(aday050.jsp)</title>
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
		var chkValid  = 'T';
		var rq_seq = 0;
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			dsT_CA_DETAIL.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_DTL"
												+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
												+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;			
			dsT_CA_DETAIL.reset();

            //결재자 조회
            fnc_SearchApprover();

        }

        /**
         * 결재자 정보를 조회한다.
         */
        function fnc_SearchApprover() {

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_APP"
													+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
													+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;	

            dsT_DI_APPROVAL.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        	dsREQ_NO.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_REQ"
										+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
										+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;	

        	dsREQ_NO.Reset();

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

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CA_MASTER.CountColumn == 0) {
                dsT_CA_MASTER.setDataHeader("ENO_NO:STRING:NOTNULL, ENO_NM:STRING:NOTNULL, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, REQ_NO:STRING, REQ_REMARK:STRING,  REQ_YMD:STRING");
            }

			// 행 추가
			dsT_CA_MASTER.AddRow();

            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "ENO_NO")  = '<%=box.get("SESSION_ENONO") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "ENO_NM")  = '<%=box.get("SESSION_ENONM") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "DPT_CD")  = '<%=box.get("SESSION_TEAMCD") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "DPT_NM")  = '<%=box.get("SESSION_TEAMNM") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "JOB_CD")  = '<%=box.get("SESSION_JOBCD") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "JOB_NM")  = '<%=box.get("SESSION_JOBNM") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "REQ_YMD") = '<%=box.get("SESSION_TODAY") %>';

        }

        /******************
         * 08. 유효성 검사 *
         ******************/
        function fnc_Valid() {

			if (!dsT_CA_MASTER.IsUpdated ) {
                alert("dsT_CA_MASTER 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

			if (!dsT_DI_APPROVAL.IsUpdated ) {
                alert("결재선이 지정되지 않았습니다");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

        }

        /******************
         * 08. 추가 함수  *
         ******************/
		function fnc_Append(){

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

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

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

            //사용안하는 것들 막기
            fnc_HiddenElement("imgReport");
 
            //날짜값들 바인딩
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 0);
            
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월
            
			cfStyleGrid5(form1.grdT_CA_Detail,0,"false","true");      		// Grid Style 적용
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"true","false");      	// Grid Style 적용

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

			fnc_AddNew();

	        dsT_DI_APPROVAL.SetDataHeader(

								"ENO_NO:STRING(10),"+			// 결재자사번
								"ENO_NM:STRING(10),"+			// 결재자명
								"DPT_CD:STRING(6),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"JOB_CD:STRING(10),"+			// 결재자직위
								"JOB_NM:STRING(10),"+			// 직위명
								"SEQ_NO:STRING(2),"+			// 결재선
	        					"GUN_YMD:STRING(10),"+			// 날짜
								"PENO_NO:STRING(10),"+			// 상신자사번
	                            "GUN_GBN:STRING(1),"+			// 결재구분
								"REQ_NO:STRING(10),"+			//
								"APP_YN:STRING(10)"				// 결재여부

								);

	    <%
	    	if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002"))  {
	    %>

	    	        
	    			var eno_no = "<%=box.get("SESSION_ENONO")%>";	//사번; 
	                //데이터셋 전송
	                dsT_CA_BELONG.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR_03&eno_no="+eno_no;
	                dsT_CA_BELONG.Reset();

	                document.getElementById("txtSITE_CD_SHR").value = dsT_CA_BELONG.namevalue(1,"SITE_CD"); 		// 
	                document.getElementById("txtSITE_NM_SHR").value = dsT_CA_BELONG.namevalue(1,"SITE_NM");		//           

	    <%
	    	}
	    %>

	        fnc_SearchList();
	        
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		
		/********************
         * 결재선 지정.
         *******************/
        function fnc_Approval() {

			var chk = 0;
			
            if(dsT_DI_APPROVAL.CountRow > 0){		
                	
	            for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
	    			if(dsT_DI_APPROVAL.NameValue(i,"APP_YN") == "N"){
						chk = chk + 1;	
	        		}
	            }
	
				if(chk == 0){
	                alert("이미 상신하셨습니다.\n\n수정하시려면 부결처리부터 하시기 바랍니다.");
	                return;
				}

            }
	        	
            if(dsT_CA_DETAIL.CountRow < 1){
                alert("상신가능한 근태 내역이 없습니다\n\n조회부터 하시기 바랍니다.");
                return;
              }
        	
            var DPT_CD = "<%=box.getString("SESSION_DPTCD") %>";
			var EMP_NO =  "<%=box.getString("SESSION_ENONO") %>";
            var REQ_YMD = document.getElementById("txtREQ_YMD").value;

			REQ_YMD = REQ_YMD.replace("-","").replace("-","")

            //ds를 리턴받는다.
            dsT_DI_APPROVAL.DeleteAll();

            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "K");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);

            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){

                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") =  i;	//결재선(결재순서)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = REQ_YMD;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = "<%=box.get("SESSION_ENONO")%>";	//상신자 사번
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "K";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";

            }

	        fnc_HiddenElement("imgSelectapproval");            
	        fnc_ShowElement("imgReport");            
        }



		/********************
         * 상신처리
         *******************/
        function fnc_Conduct() {

            if(dsT_CA_DETAIL.CountRow < 1){
              alert("상신가능한 근태 내역이 없습니다");
              return;
            }

            //1.상신처리 조건함
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("결재선을 지정해주세요.");
                return;
            }

            //신청번호 생성
			fnc_SearchItem();
            
            //2.상신처리
            var REQ_YMD = document.getElementById("txtPIS_YYMM_SHR").value;
			var GUN_YMD = REQ_YMD.replace("-","").replace("-","")
			var DPT_CD  = "<%=box.getString("SESSION_DPTCD") %>";
			var REQ_NO  = dsREQ_NO.NameValue(1,"REQ_NO");

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD"
		                                      + "&S_MODE=SAV_APP"
		                                      + "&APP_YN="  +"R"
		                                      + "&GUN_YMD=" +GUN_YMD
		                                      + "&GUN_GBN=" +"K"
		                                      + "&GUN_DPT=" +DPT_CD
		                                      + "&REQ_NO="	+REQ_NO;

			prompt(this,trT_DI_APPROVAL.action);
			
			trT_DI_APPROVAL.post();

        }

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsREQ_NO                           |
    | 3. Table List :             					|
    +----------------------------------------------->
    <Object ID="dsREQ_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_DETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_BELONG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					|
    | 2. 이름은 tr_ + 주요 테이블명()								|
    | 3. 사용되는 Table List()	        							|
    +--------------------------------------------------->
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
    <Script For=dsT_CA_MASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_HiddenElement("imgReport");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			fnc_ShowElement("imgReport");
        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CA_DETAIL Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CA_DETAIL.CountRow);
        }
    </Script>

    <!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    if (iCount >= 1)    {
	                fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");                
	                document.getElementById("resultMessage").innerText =  '** 상신이 완료되었습니다. 결재중이므로 작업은 불가합니다. **';

             for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
				if(dsT_DI_APPROVAL.NameValue(i,"APP_YN") == "N"){

    	            fnc_ShowElement("imgSelectapproval");
                	document.getElementById("resultMessage").innerText =  '** 부결상태! 다시 결재선 지정한 뒤에 상신하세요. **';
					break;
					}
            }
     }else {
    	 			fnc_ShowElement("imgSelectapproval");
     }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CA_MASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CA_DETAIL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>    

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CA_MASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("저장되었습니다\n상신을 위해서는 상신버튼을 눌러주세요");

        fnc_ShowElement("imgReport");

    </script>

    <script for=trT_DI_APPROVAL event="OnSuccess()">
		alert("상신되었습니다");
        //document.getElementById("resultMessage").innerText = "상신처리되었습니다";
        //fnc_HiddenElement("imgReport");
		fnc_OnLoadProcess();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CA_MASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
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
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">


<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재신청</td>
					<td align="right" class="navigator">HOME/보상관리/일용직관리/<font color="#000000">결재신청</font></td>
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

			<img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval" width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" >
			<img src="/images/button/btn_ReportOn.gif"          	name="imgReport"            	width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >

	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="150"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
							<td align="center" class="searchState">기준월</td>
                            <td class="padding2423">
								<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
							</td>					                        
                            <td class="searchState" align="right">소 속 &nbsp;</td>
	                        <td class="padding2423">
	                         <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')">
							 <input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
							 <a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','소속','AY');fnc_SearchList();"></a>
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


<table border="0">
	<tr>
		<td valign="top">
			<!-- 조건 입력 테이블 시작 -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="100"></col>
                                <col width="200"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="creamBold">기안자</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"  class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14" class="input_ReadOnly"  readonly>
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="creamBold">부서</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>   
                            <tr>                                                         
                                <td align="center" class="creamBold">직위</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="creamBold">기안일</td>
                                <td class="padding2423">
			                        <input id="txtREQ_YMD" size="15"  class="input_ReadOnly"  readonly>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- 결재선 정보 테이블 시작 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:125px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='REQ_NO'		width=40		name='등록번호'	align=center	show=false</C>
			            					<C> id='SEQ_NO'		width=40		name='구분'			align=center	show=false</C>
											<C> id='SEQ_NM'		width=50		name='구분'			align=center	Value={IF(SEQ_NO > '90','승인', '결재')}</C>
			            					<C> id='DPT_NM'		width=80		name='부서'			align=center	show=false</C>
											<C> id='JOB_NM'		width=60		name='직위'			align=center	</C>
											<C> id='ENO_NM'		width=70		name='성명'			align=center	</C>
											<C> id='APP_YN'		width=160		name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')&' '&UPT_YMD} </C>
											<C> id='REMARK1' 	width=60		name='사유'			align=center 	Color='Blue'	</C>

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
		</div>
		</td>
	</tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
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
						<object	id="grdT_CA_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"					value="dsT_CA_Detail">
							<PARAM NAME="TITLEHEIGHT"		VALUE=40>
							<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
							<PARAM NAME="BORDERSTYLE" 		VALUE="0">
							<PARAM NAME="INDWIDTH"			VALUE="0">
							<PARAM NAME="FILLAREA"				VALUE="true">
							<PARAM NAME="EDITABLE"				VALUE="true">
							<PARAM NAME="Colsizing"				VALUE="true">						
							<param name="ViewSummary"  		value="1">
							<param name="Format"					value="
								<C> id='{CUROW}'			width=30			name='NO'			align=center	value={String(Currow)}	SumBgColor=#C3D0DB</C>
								<C> id='SITE_NM'				width=190			name='소속'			align=left		sort = true SumBgColor=#C3D0DB SumText='총'</C>
								<C> id='ENO_NM'				width=90			name='성명'			align=center	sort = true SumBgColor=#C3D0DB SumText=@count</C>
								<C> id='CET_NO'				width=90			name='생년월일'	align=center	sort = true, SumBgColor=#C3D0DB mask='XX-XX-XX' SumText='명'</C>								
								<C> id='WRK_AMT'			width=80			name='일당'			align=center	sort = true SumBgColor=#C3D0DB</C>
								<C> id='WRK_DAY'			width=80			name='근로일수'	align=center	sort = true SumBgColor=#C3D0DB</C>
								<C> id='WRK_PAY'			width=90			name='노무비'		align=center	sort = true SumBgColor=#C3D0DB SumText=@sum</C>
                                <C> id='WRK_YM'   			width=90          	name='근로달'      align=center	sort = true, SumBgColor=#C3D0DB mask='XXXX-XX' </C>
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



<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_CA_MASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CA_MASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 		Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM					Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 		Ctrl=txtDPT_CD     			Param=value 		</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 		</C>
		<C>Col=JOB_CD     		 		Ctrl=txtJOB_CD     			Param=value 		</C>
		<C>Col=JOB_NM					Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=REQ_YMD					Ctrl=txtREQ_YMD	   			Param=value		</C>

    '>
</object>




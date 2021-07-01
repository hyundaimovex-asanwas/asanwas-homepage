<!--
    *****************************************************
    * @source         : yaca001_14.jsp 				                                  *
    * @description   : 국세청 전산매체 전송자료 PAGE.                              *
    *****************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                       *
    *-------------+-----------+----------------------------------------+
    * 2015/01/28  |  이동훈   | 최초작성                                              *
    *****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<title>국세청 전산매체 전송자료</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/result.js"></script>		
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFTTTFFT';
		//var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_date = gcurdate;		
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 해당년도

            //데이터셋 전송
			if(document.tabYACA001.ActiveIndex==1){//연말정산
				dsT_AC_RETACC_01.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD&S_MODE=SHR_14&PIS_YY_SHR="+PIS_YY_SHR;
				dsT_AC_RETACC_01.Reset();
				
			}else if(document.tabYACA001.ActiveIndex==2){//의료비신고
	            dsT_AC_MEDICAL_02.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD&S_MODE=SHR_MED_14&PIS_YY_SHR="+PIS_YY_SHR;
	            dsT_AC_MEDICAL_02.Reset();

			}else if(document.tabYACA001.ActiveIndex==3){//기부금신고
	            dsT_AC_DONATION_03.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD&S_MODE=SHR_DON_14&PIS_YY_SHR="+PIS_YY_SHR;
	            dsT_AC_DONATION_03.Reset();
            }

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

			if(document.tabYACA001.ActiveIndex==1){//연말정산
				
				if (dsT_AC_RETACC_01.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_RETACC_01.GridToExcel("연말정산", '', 225)

			}else if(document.tabYACA001.ActiveIndex==2){//의료비신고
				
				if (dsT_AC_MEDICAL_02.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_MEDICAL_02.GridToExcel("의료비신고", '', 225)

			}else if(document.tabYACA001.ActiveIndex==3){//기부금신고
				if (dsT_AC_DONATION_03.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_DONATION_03.GridToExcel("기부금신고", '', 225)

            }

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
        function fnc_SearchItemCheck() {

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
        	
        	//alert(gs_date);
        	
            document.getElementById("txtPIS_YY_SHR").value =  '2014';
			document.getElementById("txtPIS_YMD").value = gs_date; // 해당일자
			
			
			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_AC_RETACC_01,0,"false","true");
			cfStyleGrid_New(form1.grdT_AC_MEDICAL_02,0,"false","true");
			cfStyleGrid_New(form1.grdT_AC_DONATION_03,0,"false","true");

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /**
         * 파일로 저장
         */
        function fnc_ToFile() {

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; 	// 해당년도
			var PIS_YMD = document.getElementById("txtPIS_YMD").value; 			// 제출년월일
			
			var FILE_NAME = "";//파일명

			if(document.tabYACA001.ActiveIndex==1){//연말정산

	            if (dsT_AC_RETACC_01.CountRow < 1) {
	                alert("데이타가 없습니다.");
	                return;
	            }

    	        FILE_NAME = "C2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "../../../servlet/JspChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD_FILE&S_MODE=FILE_01&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;
	            //prompt(this,form.action);	            
	            form.submit();


			}else if(document.tabYACA001.ActiveIndex==2){//의료비신고

	            if (dsT_AC_MEDICAL_02.CountRow < 1) {
	                alert("데이타가 없습니다.");
	                return;
	            }

	            //제출일자가 없으면 조회못함.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자를 입력하세요.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//제출일자가 잘못되었으면 조회못함.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자가 잘못되었습니다.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "CA2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "../../../servlet/JspChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD_FILE&S_MODE=FILE_02&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;          
	            form.submit();

			}else if(document.tabYACA001.ActiveIndex==3){//기부금신고

	            if (dsT_AC_DONATION_03.CountRow < 1) {
	                alert("데이타가 없습니다.");
	                return;
	            }

	            //제출일자가 없으면 조회못함.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자를 입력하세요.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//제출일자가 잘못되었으면 조회못함.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자가 잘못되었습니다.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "H2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "../../../servlet/JspChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD_FILE&S_MODE=FILE_03&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;
	            form.submit();


            }

        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->
    
    <Object ID="dsT_AC_RETACC_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">             
    </Object>

    <Object ID="dsT_AC_MEDICAL_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">        
    </Object>

    <Object ID="dsT_AC_DONATION_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">             
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_AC_RETACC_01                                           |
    | 3. Table List :                                                             |
    +----------------------------------------------->
    <Object ID ="trT_AC_RETACC_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_AC_LOAN_06                                           |
    | 3. Table List : T_AC_LOAN                                         |
    +----------------------------------------------->

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->

    <Script For=dsT_AC_RETACC_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_MEDICAL_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_DONATION_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    
    <Script For=dsT_AC_RETACC_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_MEDICAL_02 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_DONATION_03 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->

    <Script For=dsT_AC_RETACC_01 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_MEDICAL_02 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_DONATION_03 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_AC_RETACC_01 event="OnSuccess()">

   		var iCount = dsT_AC_RETACC_01.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_AC_RETACC_01 event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 파일 전송을 위해 -->
<iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">국세청 전산매체</td>
					<td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">국세청 전산매체</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->


<!-- 버튼 테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr><td valign="center" class="searchState"><span id="resultMessage">&nbsp;</span></td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a  href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFilecreate','','../../images/button/btn_FilecreateOver.gif',3)" ><img src="../../images/button/btn_FilecreateOn.gif" id="imgFilecreate" name="imgFilecreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_ToFile()" ></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="80"></col>
								<col width="150"></col>									
								<col width="80"></col>	
								<col width="150"></col>																
			                    <col width="*"></col>
							</colgroup>
							<tr>					
								<td class="searchState" align="right">해당년도</td>
								<td class="padding2423" align="left">
										<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
								</td>
								<td class="searchState" align="right">제출일자</td>
								<td class="padding2423" align="left">
										<input id="txtPIS_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD','','634','150');"></a>
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



<!-- 탭 사용 컴퍼넌트 시작 -->
<comment id="__NSID__">
<object id=tabYACA001 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C style="position:absolute; left:10; top:200; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#dae0ee">
	<param name="DisableBackColor"	value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 				value="1">
	<param name="Format"			value='
		<T>divid="tabYACA001_01"	title="연말정산"</T>
		<T>divid="tabYACA001_02"	title="의료비"</T>
		<T>divid="tabYACA001_03"	title="기부금"</T>
	'>
</object>
</comment>
<script> __ShowEmbedObject(__NSID__); </script>
<!-- 탭 사용 컴퍼넌트 끝 -->




<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabYACA001_01" style="position:absolute; left:10; top:220; width:1050; height:550; z-index:4; visibility:hidden">

	<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETACC_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
					<param name="DataID" value="dsT_AC_RETACC_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
                            <FC> id="{CUROW}"        width=40    height =150 align=center    name="NO"         value={String(Currow)}    SubSumText=""</FC>
                            <FC> id=RET_YN           width=60   align=center    name=재직     SubSumText="" Value={Decode(RET_YN,"","재직","퇴직")}</FC>
                            <FC> id=RET_YMD         width=70   align=center    name=퇴직일     SubSumText="" </FC>                       
                            <FC> id=DPT_NM           width=100   align=left    name=소속                          SubSumText=""</FC>
                            <FC> id=ENO_NO           width=55   align=center    name=사번                          SubSumText=""</C>
                            <FC> id=ENO_NM           width=55   align=center    name=성명                          SubSumText=""</FC>
                            <C> id=CET_NO           width=100   align=center    name=주민번호                          SubSumText=""</C>
                            <C> id=JOB_NM           width=75   align=center    name=직위                          SubSumText=" 합 계 "</FC>
                            <C> id=TAX_INCOME       width=100   align=right     rightmargin=10    name="과세대상급여"                 BgColor=#FAFAD2 </C>
                            <C> id=MGR_AMT          width=100   align=right     rightmargin=10    name="근로소득;공제액"                </C>
                            <C> id=MNI_AMT          width=100   align=right     rightmargin=10    name="근로소득금액"                  BgColor=#FABBCC </C>
                            <C> id=BADD_AMT         width=100   align=right     rightmargin=10    name="본인공제"                    </C>
                            <C> id=SPSB_AMT         width=100   align=right     rightmargin=10    name="배우자공제"                  </C>
                            <C> id=GDED_AMT         width=100   align=right     rightmargin=10    name="부양가족;공제"                </C>
                            <C> id=GOL_AMT          width=100   align=right     rightmargin=10    name="경로우대;공제"                </C>
                            <C> id=TBL_DED          width=100   align=right     rightmargin=10    name="장애자공제"                  </C>
                            <C> id=WDD_AMT          width=100   align=right     rightmargin=10    name="부녀자공제"                  </C>
                            <C> id=OTX_DED          width=100   align=right     rightmargin=10    name="한부모공제"                  </C>
                            <C> id=NPEN_DED         width=100   align=right     rightmargin=10    name="국민연금보험;공제"   </C>
                            <C> id=HIN_DED          width=100   align=right     rightmargin=10    name="건강,고용보험료;공제"         /C>   
                            <C> id=LOAN_DED          width=100   align=right     rightmargin=10    name="주택임차;차입금;원리금상환액"     </C>
                            <C> id=LONG_DED          width=100   align=right     rightmargin=10    name="장기주택저당;차입금;이자지급액"  </C>                                                     
                            <C> id=DON_FWD          width=100   align=right     rightmargin=10    name="기부금;이월"  </C>                                                      
                            <C> id=VEN_DED          width=100   align=right     rightmargin=10    name="특별소득;공제"  </C>                                                        
                            <C> id=INDED_TOT          width=100   align=right     rightmargin=10    name="차감소득금액"                  BgColor=#FAFAD2</C>                                             
                            <C> id=PER_DED          width=100   align=right     rightmargin=10    name="개인연금;저축공제"          </C>                                             
                            <C> id=SAVE_DED          width=100   align=right     rightmargin=10    name="주택마련;공제"              </C>                                             
                            <C> id=CARD_DED         width=100   align=right     rightmargin=10    name="신용카드;공제"                </C>                                             
                            <C> id=SAJU_DED         width=100   align=right     rightmargin=10    name="우리사주출연;공제"              </C>                                             
                            <C> id=LSS_DED         width=100   align=right     rightmargin=10    name="장기집합투자;증권저축공제"         </C>  
                            <C> id=INDED_EXC         width=100   align=right     rightmargin=10    name="소득공제;종합한도;초과액"         </C>                            
                            <C> id=TTAX_STD         width=100   align=right     rightmargin=10    name="종합소득;과세표준"                  </C>
                            <C> id=TAX_AMT          width=100   align=right     rightmargin=10    name="산출세액"                        BgColor=#AAFAD2</C>                                                                                  
                           <G> name=세액공제 BgColor="#dae0ee"
                            <C> id=HGR_DED          width=100   align=right     rightmargin=10    name="근로소득;세액공제"      </C> 
                            <C> id=AGE_AMT          width=100   align=right     rightmargin=10    name="자녀;세액공제"             </C>  
                            <C> id=ANN_DED          width=100   align=right     rightmargin=10    name="연금계좌;공제"         </C>
                            <C> id=MIN_DED          width=100   align=right     rightmargin=10    name="보장성보험;세액공제"          </C>                                                                                                         
                            <C> id=MMA_DED          width=100   align=right     rightmargin=10    name="의료비;세액공제"          </C>
                            <C> id=EDU_DED          width=100   align=right     rightmargin=10    name="교육비;세액공제"           </C>
                            <C> id=GOV1_DED         width=100   align=right     rightmargin=10    name="정치자금;(10만원이하)"     </C>
                            <C> id=GOV2_DED          width=100   align=right     rightmargin=10    name="정치자금;(10만원초과)"    </C>
                            <C> id=LC1_DED           width=100   align=right     rightmargin=10    name="법정기부금"                    </C>
                            <C> id=LC23_DED          width=100   align=right     rightmargin=10    name="지정기부금"                    </C>
                            <C> id=CPC_DED          width=100   align=right     rightmargin=10    name="기부금;세액공제"           </C>
                            <C> id=NSE_TOT          width=100   align=right     rightmargin=10    name="특별세액;공제계"             BgColor=#99FF22</C>
                            <C> id=STA_TOT          width=100   align=right     rightmargin=10    name="표준세액공제"              </C>   
                            <C> id=MRENT_DED       width=100   align=right     rightmargin=10    name="월세액;세액공제"         </C>                                                       
                            <C> id=TDED_TOT         width=100   align=right     rightmargin=10    name="세액공제계 "                   BgColor=#FAFAD2</C>
                           </G> 
                           <G> name=결정세액 BgColor="#dae0ee"                            
                            <C> id=DGG_TAX          width=100   align=right     rightmargin=10    name=결정소득세                   </C>
                            <C> id=DJM_TAX          width=100   align=right     rightmargin=10    name=결정주민세                   </C>
                            <C> id=DBW_TAX          width=100   align=right     rightmargin=10    name=결정농특세                   </C>                            
                            <C> id=AAA_TOT          width=100   align=right     rightmargin=10    name=결정세액계                    value={DGG_TAX+DJM_TAX+DBW_TAX}   BgColor=#FAFAD2</C>
                           <G> name=기납부세액 BgColor="#dae0ee"                            
                            <C> id=AGG_TAX         width=100   align=right     rightmargin=10    name=납부소득세                    </C>
                            <C> id=AJM_TAX         width=100   align=right     rightmargin=10    name=납부주민세                    </C>
                            <C> id=CONT_TAX         width=100   align=right     rightmargin=10    name=납부농특세                    </C>                            
                            <C> id=CCC_TOT          width=100   align=right     rightmargin=10    name=납부세액계                        value={AGG_TAX +AJM_TAX+CONT_TAX} BgColor=#FAFAD2</C>
                            </G>                            
                           <G> name=환급세액 BgColor="#dae0ee"                                                    
                            <C> id=DRE_INTX        width=100   align=right     rightmargin=10    name=환급소득세                    </C>
                            <C> id=DRE_CTTX        width=100   align=right     rightmargin=10    name=환급주민세                    </C>
                            <C> id=DRE_DFTX        width=100   align=right     rightmargin=10    name=환급농특세                    </C>                            
                            <C> id=EEE_TOT          width=100   align=right     rightmargin=10    name=환급세액계                    value={DRE_INTX+DRE_CTTX+DRE_DFTX} BgColor=#FFAADD</C>
                            </G>  
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->


<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabYACA001_02" style="position:absolute; left:10; top:220; width:1050; height:550; z-index:4; visibility:hidden">

	<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_MEDICAL_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
					<param name="DataID" value="dsT_AC_MEDICAL_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=40		name="NO"								align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=90		name="직위"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="사번"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="주민등록번호"					align=center		Edit=none		SubBgColor="#99FFCC"	show=false</C>
						<C> id="ENO_NM"				width=70		name="성명"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"			width=90		name="사업자번호"					align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXX-XX-XXXXX"</C>
						<C> id="COM_NM"			width=200		name="업체명"							align=left			Edit=none		SubBgColor="#99FFCC"	SubSumText=" 합 계 "</C>
						<C> id="MED_CD"				width=220		name="증빙코드"						align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="건수"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="지급금액"						align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMM_CD"			width=50		name="구분"							align=center		Edit=none		SubBgColor="#99FFCC"	show=false</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭2 조건 입력 테이블 끝 -->

<!-- 탭3 조건 입력 테이블 시작 -->
<div class=page id="tabYACA001_03" style="position:absolute; left:10; top:220; width:1050; height:550; z-index:4; visibility:hidden">

	<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_DONATION_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
					<param name="DataID" value="dsT_AC_DONATION_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=35		name="NO"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=80		name="직위"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="사번"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="성명"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="주민등록번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"			width=90		name="사업자번호"			align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXX-XX-XXXXX"</C>
						<C> id="COM_NM"			width=190		name="업체명"					align=left			Edit=none		SubBgColor="#99FFCC"	SubSumText=" 합 계 "</C>
						<C> id="REL_NM"				width=170		name="기부유형"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="건수"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="금액"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭3 조건 입력 테이블 끝 -->


</form>
<!-- form 끝 -->

</body>
</html>
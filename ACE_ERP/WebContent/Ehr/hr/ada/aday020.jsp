<!--
/*--------------------------------------------------------------------------------
+ 시스템명 : 일용직 인사관리 - 근태입력
+ 기능정의 : 근태 입력,수정,삭제,조회한다.
+ 프로그램ID : aday100.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2013.04.03
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 : 
----------------------------------------------------------------------------------*/
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();
    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>일용직 근태관리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTTTTT';
        var savObj = new Array();
        var today = getToday();
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			dsT_CA_Master.ClearData();

			//정보 조회
			var SITE_CD_SHR = document.getElementById("txtSITE_CD_SHR").value;		// 소속
			
            //데이터셋 전송
            dsT_CA_Master.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR&SITE_CD_SHR="+SITE_CD_SHR;
            dsT_CA_Master.Reset();

        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchList2() {

        	dsT_CA_Detail.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR_01"
										+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
										+ "&ENO_NM=" + dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"ENO_NM") 
										+ "&CET_NO=" + dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"CET_NO"); 

        	dsT_CA_Detail.Reset(); 

        }


        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if (confirm("근태정보를 저장하시겠습니까?")) {

	            // 해당 Dataset의 Header가 없으면 Header 선언
	            if (dsT_CA_Temp.CountColumn == 0) {
	            	dsT_CA_Temp.setDataHeader("WRK_DT:STRING, YOIL:STRING, SITE_CD:STRING, ENO_NM:STRING, CET_NO:STRING, WRK_GB:STRING, WRK_YM:STRING");
	            }

				for(i=1;i<=dsT_CA_Detail.countrow;i++){	
					
					dsT_CA_Temp.addrow();

					dsT_CA_Temp.namevalue(i,"WRK_DT") = dsT_CA_Detail.namevalue(i,"WRK_DT"); 
					dsT_CA_Temp.namevalue(i,"YOIL") 		= dsT_CA_Detail.namevalue(i,"YOIL");
					dsT_CA_Temp.namevalue(i,"SITE_CD") = dsT_CA_Detail.namevalue(i,"SITE_CD");
					dsT_CA_Temp.namevalue(i,"ENO_NM") = dsT_CA_Detail.namevalue(i,"ENO_NM");
					dsT_CA_Temp.namevalue(i,"CET_NO") = dsT_CA_Detail.namevalue(i,"CET_NO");
					dsT_CA_Temp.namevalue(i,"WRK_GB") = dsT_CA_Detail.namevalue(i,"WRK_GB");
					dsT_CA_Temp.namevalue(i,"WRK_YM") = document.getElementById("txtPIS_YYMM_SHR").value;

					}
								
				trT_CA_Detail.KeyValue = "tr01(I:dsT_CA_Temp=dsT_CA_Temp)";
				trT_CA_Detail.action = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SAV";
	            trT_CA_Detail.post();

	            dsT_CA_Temp.ClearData();
				dsT_CA_Detail.ClearData();

				}

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
			function fnc_Add(){

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

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CA_Master.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();


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

            //Grid Style 적용
			cfStyleGrid5(form1.grdT_CA_Master,0,"false","true");
			cfStyleGrid(form1.grdT_CA_Detail,15,"true","false");

            //날짜값들 바인딩
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 0);
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월 To

			//값이 없어서 하이픈만 나오는거 방지
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}			

 			document.getElementById("gcem_str_dt").Text = today.substring(0,7)+"01";	 
	        document.getElementById("gcem_end_dt").Text = today;


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
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/***********************
		* 		근태관리 시간 입력   	 *
		**********************/

		function fnc_Settle(){
	
				dsT_CA_Detail.ClearData();		
	
				if(!fnc_Settle_Chk()) return;
	
				var str_dt 	=  document.getElementById("gcem_str_dt").Text;
				var end_dt =  document.getElementById("gcem_end_dt").Text;

				dsT_CA_Date.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR_02&str_dt="+str_dt+"&end_dt="+end_dt;
				dsT_CA_Date.Reset();
	
				var date = fnc_Day_Chk(str_dt,end_dt);
	
				for(i=1;i<=date;i++){	
	
						var dateOfWeek1 = dsT_CA_Date.namevalue(i,"YYMMDD"); 
						var Yoil = dsT_CA_Date.namevalue(i,"YOIL"); 

			            // 해당 Dataset의 Header가 없으면 Header 선언
			            if (dsT_CA_Detail.CountColumn == 0) {
			            	dsT_CA_Detail.setDataHeader("WRK_DT:STRING, YOIL:STRING, SITE_CD:STRING, ENO_NM:STRING, CET_NO:STRING, WRK_GB:STRING");
			            }

						
						dsT_CA_Detail.addrow();
	
						//출근일자
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"WRK_DT") = dsT_CA_Date.namevalue(i,"YYMMDD"); 
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"YOIL") 	  = dsT_CA_Date.namevalue(i,"YOIL");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"SITE_CD") = dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"SITE_CD");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"ENO_NM") = dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"ENO_NM");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"CET_NO") = dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"CET_NO");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"WRK_GB") = "X";
	
				}
		}


		/***********************
		* 		근태입력전 체크 	 			*
		**********************/
		function fnc_Settle_Chk(){
	
			var chk = 0;

			var str_dt 	=  document.getElementById("gcem_str_dt").Text;
			var end_dt =  document.getElementById("gcem_end_dt").Text;
			
			for(i=1;i<=dsT_CA_Master.countrow;i++){		
				chk = 1;
					if(str_dt == "" || end_dt == "" ){		
					alert("날짜를 입력하세요");
					}
			}
			if(chk==0){
				alert("대상자를 선택하십시요.");
				return false;	
			}
			return true;	
		}

		/******************************************************************************
			Description : 날짜 사이 조회 Parameter   : frdt - 출발일, todt - 복귀일
		******************************************************************************/
	
		function fnc_Day_Chk(frdt,todt) { 
	
			var fryy =frdt.substring(0,4);
			var frmm =frdt.substring(4,6);
			var frdd =frdt.substring(6,8);
			var toyy =todt.substring(0,4);
			var tomm =todt.substring(4,6);
			var todd =todt.substring(6,8);
	
			frdate=new Date(fryy,frmm-1,frdd); //월에서는 1을 뺀다 
			todate=new Date(toyy,tomm-1,todd); //오늘날짜 
	
			frtime=frdate.getTime(); //출발시각 
			totime=todate.getTime(); //복구시각
			cha=totime-frtime;       //시각차이 
			conv=Math.floor(cha/(60*60*24*1000))+1; //시각차이를 일자차이로 계산 
			return conv
				
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
    | 2. 이름 : dsT_CA_Master                     |
    | 3. Table List : T_AC_COCA                   |
    +----------------------------------------------->
    <Object ID="dsT_CA_Master" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        	Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <Object ID="dsT_CA_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_Date" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_CA_BELONG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    

    <Object ID="dsT_CA_Temp" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID ="trT_CA_Detail" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!--------------------------+
    | grid에서 row를 클릭했을때      |
    +------ -------------------->
	<script for=grdT_CA_Master event=OnClick(Row,Colid)>
		fnc_SearchList2();
	</script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CA_Master Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_CA_Master.UserStatus(i) = 1;
            }
        }
    </Script>

    <Script For=dsT_CA_Detail Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {

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
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CA_Master Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CA_Detail Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CA_Master Event="OnDataError()">
        //Dataset관련 Error 처리
		 cfErrorMsg(this);
    </Script>

    <Script For=dsT_CA_Detail Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CA_Master event="OnSuccess()">
    	alert("기본사항이 저장되었습니다. 세부사항 일괄생성하십시요");
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        fnc_SearchList();
    </script>

    <script for=trT_CA_Detail event="OnSuccess()">
		alert("세부사항 저장이 완료되었습니다");
    </script>


    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CA_Master event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_CA_Detail event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>


	<!-- form 시작 -->
	<form name="form1" id="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태입력</td>
					<td align="right" class="navigator">HOME/보상관리/일용직관리/<font color="#000000">근태입력</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="100"></col>
					<col width="200"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
				<td align="center" class="searchState">기준월</td>
				<td>
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
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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

			<!-- 왼쪽 화면 시작-->
			<table width="1000" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">

						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="400" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CA_Master" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:477px;">
						                            <param name="DataID"					value="dsT_CA_Master">
													<PARAM NAME="BorderStyle"			VALUE="0">
													<PARAM NAME="Indwidth"				VALUE="0">
													<PARAM NAME="Fillarea"				VALUE="true">
													<PARAM NAME="Editable"				VALUE="false">
													<PARAM NAME="Colsizing"				VALUE="true">
													<PARAM NAME="TitleHeight"			VALUE=20>
													<param name="sortview"				value=left>
													<PARAM NAME="Format"          		VALUE="  
														<FC>ID={CurRow}		Name=NO				Width=30,   			align=center,  		sort=false  editable=false </FC> 
														<FC>ID=ENO_NM,			Name=성명,				width=80px,			align=center,		edit=none  sort=true </FC>	
														<FC>ID=CET_NO,		    Name=생년월일,	 	width=80px,			align=center,		edit=none  sort=true mask='XX-XX-XX' </FC>
														<FC>ID=SITE_NM,	  	Name=소속,				width=175px,			align=left,			edit=none  sort=true </FC>														">
													</object>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- 내용 조회 그리드 데이블 끝-->


			<!-- 왼쪽 화면 끝-->
		</td>
		<td width=15></td>
		<td>
			<!-- 오른쪽 화면 시작-->
			<table width="395" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td>
						<!-- 조건 입력 테이블 시작 -->
						<table width="395" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="395" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width=""></col>

										</colgroup>
										<tr>
											<td align="center" class="creamBold">일자</td>
											<td class="padding2423">
						                        <comment id="__NSID__">
									              <OBJECT id=gcem_str_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
									              <param name=Alignment			value=0>
									              <param name=Border	      value=true>
									              <param name=Format	      value="YYYY/MM/DD">
									              <param name=PromptChar	  value="_">
									              </OBJECT>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>							  
						                        
						                        &nbsp;&nbsp;~
						                        <comment id="__NSID__">
									              <OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
									              <param name=Alignment			value=0>
									              <param name=Border	      value=true>
									              <param name=Format	      value="YYYY/MM/DD">
									              <param name=PromptChar	  value="_">
									              </OBJECT>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>	
						                        &nbsp;&nbsp;
									            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ConductOn.gif',1)">
									            <img src="/images/button/btn_ConductOn.gif" name="imgSettle" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Settle();">
									            </a>

											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
						<!-- 조건 입력 테이블 끝 -->


						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="395" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CA_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:395px;height:445px;">
						                            <param name="DataID"				value="dsT_CA_Detail">
													<PARAM NAME="BorderStyle"			VALUE="0">
													<PARAM NAME="Indwidth"				VALUE="0">
													<PARAM NAME="Fillarea"				VALUE="true">
													<PARAM NAME="Editable"				VALUE="false">
													<PARAM NAME="Colsizing"				VALUE="true">
													<PARAM NAME="TitleHeight"			VALUE=20>
													<param name="sortview"				value=left>
						                            <param name="Format"				value="
						                				<FC>Name=NO				  	ID={CurRow} 		Width=30,  		align=center, 	sort = true,		editable=false</FC>
														<FC>Name=일자,       	   	ID=WRK_DT,		width=100,		align=center, 	sort = true, 	edit=none mask='XXXX-XX-XX' color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC>		
														<FC>Name=요일,       	   	ID=YOIL,				width=50,		align=center, 	sort = true, 	edit=none 	value={IF (YOIL='1','일',IF (YOIL='2','월', IF (YOIL='3','화', IF (YOIL='4','수', IF (YOIL='5','목', IF (YOIL='6','금', IF (YOIL='7','토', '' )))))))} color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC>		
														<FC>Name=성명,       	   	ID=ENO_NM,		width=80,		align=center, 	sort = true, 	edit=none</FC>		
						                				<FC>Name=구분,    	 		ID=WRK_GB,  		width=80,		align=center, 	sort = true,  	EditStyle=Combo, dec=0, 	Data='X:X,2:0.5 근무,1:근무,3:1.5 근무' color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC						                            ">
						                        </object>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- 내용 조회 그리드 데이블 끝-->

					</td>
				</tr>
			</table>
			<!-- 오른쪽 화면 끝-->
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>



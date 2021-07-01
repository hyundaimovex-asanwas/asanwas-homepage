<!--
***********************************************************************
* @source      : vlul080.jsp
* @description : 목표설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/03/17      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>목표설정</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/style_new.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var year    = getToday().substring(0,4);
        var dsTemp = window.dialogArguments;

        var selectRow = 0;

		var STS = "<%=request.getParameter("STATUS")%>";
        var ENO_NO = "";
        var ENO_NM = "";

        if(dsTemp != "Modal") {
			ENO_NO = "<%=box.get("SESSION_ENONO")%>";
			ENO_NM = "<%=box.get("SESSION_ENONM")%>";
		} else {
			ENO_NO = "<%=request.getParameter("ENO_NO")%>";
			ENO_NM = "<%=request.getParameter("ENO_NM")%>";
		}

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	fnc_Clear();

        	if(document.getElementById("txtENO_NM").value == "") {
	       		alert("성명을 입력해 주세요.");
	       		return;
	       	}

	       	var obj = new String;

	       	
<%
    //관리자의 경우 년도, 사번 검색 활성화
    if(box.getString("SESSION_ROLE_CD").equals("1001") || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			if(dsTemp != "Modal") {
		        obj = fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM");
		        ENO_NO = document.getElementById("txtENO_NO").value;
	        }
<%
    }
%>
        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	
            //alert("1");
            dsT_EVL_GOALLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
            dsT_EVL_GOALLIST.Reset();

            //alert("2");
            
            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);

            //alert("3");            
            
            fnc_SetGrdHeight();

			/*if(getToday() > "2013-02-27") {
            	fnc_display("n");
            }*/
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

            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }

			for(var i=0; i<dsT_EVL_GOALLIST.CountRow; i++){       
				dsT_EVL_GOALLIST.UserStatus(i) = 1;				
			}
            
            
            trT_EVL_GOALLIST.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
            trT_EVL_GOALLIST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SAV";
            trT_EVL_GOALLIST.post();
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            if (document.getElementById('txtEVL_YYYY').value != year) {
            	alert(fnc_GetMSG("MSG_10"));
                document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_10");
                document.getElementById('txtEVL_YYYY').focus();
                return;
            }

        	// 삭제 할 자료가 있는지 체크하고
            if (dsT_EVL_GOALLIST.CountRow < 1) {
            	document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_05");
                alert(fnc_GetMSG("MSG_05"));
                return;
            }

            if(selectRow == 0) {
            	alert("삭제할 행을 선택해 주세요.");
                return;
            }

            if (confirm("삭제 후 저장해야 내용이 반영됩니다.") == false) return;

            //dsT_EVL_GOALLIST.DeleteRow(dsT_EVL_GOALLIST.RowPosition);
            //dsT_EVL_GOALLIST_01.DeleteRow(dsT_EVL_GOALLIST.RowPosition);

            var row = selectRow;

            dsT_EVL_GOALLIST.DeleteRow(row);
            dsT_EVL_GOALLIST_01.DeleteRow(row);
            selectRow = 0;

            //trT_EVL_GOALLIST.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
            //trT_EVL_GOALLIST.action = "/servlet/GauceChannelSVL?cmd=hr.evl.a.evla080.cmd.EVLA080CMD&S_MODE=DEL";
            //trT_EVL_GOALLIST.post();

            //fnc_SearchList();

            fnc_SetGrdHeight();



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

            if (dsT_EVL_GOALLIST.CountRow < 1) {
                alert(fnc_GetMSG("MSG_09"));
                return;
            }

            //header 설정
            dsT_EVL_GOALLIST_PRT.setDataHeader("NO:NUMBER, "+
										"CATEGORY:STRING, "+
										"FORMULA:STRING, "+
										"GOAL_YMD:STRING, "+
										"WEIGHT:DECIMAL(3.0), "+
										"GRADE_NM:STRING, "+
										"GRADE:STRING ");

			grdT_EVL_GOALLIST_PRT.ColumnProp('INFO','Name') = "소속: " + dsT_EVL_GOALLIST.NameValue(1,"DPT_NM")
																								 + "    직위: " + dsT_EVL_GOALLIST.NameValue(1,"JOB_NM")
																								 + "    성명: " + dsT_EVL_GOALLIST.NameValue(1,"ENO_NM") ;
			var grade_nm = "";
			var grade = "";
			var sum = 0;
			for(var i=0; i<dsT_EVL_GOALLIST.CountRow; i++){

				sum += dsT_EVL_GOALLIST.NameValue(i+1,"WEIGHT");

				for(var j=1; j<=5; j++) {
					dsT_EVL_GOALLIST_PRT.AddRow();
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"NO") 				= i+1;
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"CATEGORY") 	= dsT_EVL_GOALLIST.NameValue(i+1,"CATEGORY");
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"FORMULA") 		= dsT_EVL_GOALLIST.NameValue(i+1,"FORMULA");
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"GOAL_YMD") 	= dsT_EVL_GOALLIST.NameValue(i+1,"GOAL_YMD");
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"WEIGHT") 		= dsT_EVL_GOALLIST.NameValue(i+1,"WEIGHT");
					//alert(dsT_EVL_GOALLIST.NameValue(i+1,"WEIGHT"));


					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"GRADE_NM") 	= grade_nm;
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"GRADE") 		= dsT_EVL_GOALLIST.NameValue(i+1,grade);

				}
			}

			grdT_EVL_GOALLIST_PRT.ColumnProp('WEIGHT','sumtext') = sum;
			grdT_EVL_GOALLIST_PRT.ExcelToPrintLandScape = 2;
			grdT_EVL_GOALLIST_PRT.GridToExcel("목표설정", '', 129);



        }

        /******************
         * 07. 신규 함수  *
         ******************/

        function fnc_AddNew() {

            
			for(var i=1; i<=dsT_EVL_GOALLIST.CountRow; i++){

				dsT_EVL_GOALLIST.NameValue(i,"CATEGORY") 		= dsT_EVL_GOALLIST_01.NameValue(i,"CATEGORY");
				dsT_EVL_GOALLIST.NameValue(i,"FORMULA") 		= dsT_EVL_GOALLIST_01.NameValue(i,"FORMULA");
				dsT_EVL_GOALLIST.NameValue(i,"GOAL_YMD") 		= dsT_EVL_GOALLIST_01.NameValue(i,"GOAL_YMD");
			}

			var row = dsT_EVL_GOALLIST.CountRow;
		
			//alert(row);
			
			dsT_EVL_GOALLIST.InsertRow(row+1);
		
			dsT_EVL_GOALLIST_01.InsertRow(row+1);

            dsT_EVL_GOALLIST.nameValue(row+1, "EVL_YYYY") = document.getElementById('txtEVL_YYYY').value;
            dsT_EVL_GOALLIST.nameValue(row+1, "ENO_NO") = ENO_NO;
            dsT_EVL_GOALLIST.nameValue(row+1, "GOAL_NO") = 1;

            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);

			fnc_SetGrdHeight();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			//document.getElementById("txtENO_NM").value = "<%=box.get("SESSION_ENONM")%>";
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EVL_GOALLIST.ClearData();
            dsT_EVL_GOALLIST_01.ClearData();

            selectRow = 0;
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (document.getElementById("txtEVL_YYYY").value != year) {
                alert(fnc_GetMSG("MSG_01"));
                document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_01");
                document.getElementById("txtEVL_YYYY").focus();
                return false;
            }

			for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

				dsT_EVL_GOALLIST.nameValue(i, "CATEGORY") 		= dsT_EVL_GOALLIST_01.nameValue(i, "CATEGORY");
				dsT_EVL_GOALLIST.nameValue(i, "FORMULA") 		= dsT_EVL_GOALLIST_01.nameValue(i, "FORMULA");
				dsT_EVL_GOALLIST.nameValue(i, "GOAL_YMD") 		= dsT_EVL_GOALLIST_01.nameValue(i, "GOAL_YMD");
				dsT_EVL_GOALLIST.nameValue(i, "WEIGHT") 			= dsT_EVL_GOALLIST_01.nameValue(i, "WEIGHT");
			}

            // DataSet의 변경 여부 확인
            if ( !dsT_EVL_GOALLIST.IsUpdated ) {
				document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_02");
                return false;
            }

			// 비중합계 체크
			var weightTot = 0;
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	dsT_EVL_GOALLIST.NameValue(i, "GOAL_NO") = i;		// GOAL_NO 순번 채번
				weightTot = weightTot + dsT_EVL_GOALLIST.NameValue(i, "WEIGHT");

            }

            if(weightTot != 100) {
            	alert("비중 합계가 100이 아닙니다. 확인 후 작업해 주세요.");

            	//grdT_EVL_GOALLIST.RowPosition = 1;
		      	//grdT_EVL_GOALLIST.ColumnPosition = "ID_WEIGHT";

            	return false;
            }

            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  			*
         *******************************************/
        function fnc_OnLoadProcess() {

			// DATASET 초기화
            fnc_Clear();


			cfStyleGrid_New(grdT_EVL_GOALLIST_01, 0, "true", "false");
			grdT_EVL_GOALLIST_01.RowHeight = 100;          // Grid Row Height Setting
			grdT_EVL_GOALLIST_01.TitleHeight = "40";

			// 엑셀저장용
			cfStyleGrid_New(grdT_EVL_GOALLIST_PRT, 0, "true", "false");  // Grid Style 적용

            //년도 Setting
            if(dsTemp != "Modal") {
            	document.getElementById("txtEVL_YYYY").value = year;
			} else {

<%
			    if(request.getParameter("EVL_YYYY") == null) {
%>
					document.getElementById("txtEVL_YYYY").value = year;
<%
				}else {
%>
					document.getElementById("txtEVL_YYYY").value = "<%=request.getParameter("EVL_YYYY")%>";
<%
				}
%>
			}

            document.getElementById("txtENO_NO").value = ENO_NO;
            document.getElementById("txtENO_NM").value = ENO_NM;

<%
    //관리자의 경우 년도, 사번 검색 활성화
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_YYYY").readOnly = true;
			document.getElementById("txtENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";
<%
	}else{
%>
            document.getElementById("txtEVL_YYYY").className = "";
	  		document.getElementById("txtEVL_YYYY").readOnly = false;
			document.getElementById("txtENO_NO").className = "";
	  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtENO_NM").className = "";
	  		document.getElementById("txtENO_NM").readOnly = false;

<%
    }%>

    		fnc_SearchList();

        }


        /********************************************
         * 15. 도움말 보여주는 화면                                          			*
         *******************************************/
        function fnc_Popup(){
        	
            //이곳에 해당 코딩을 입력 하세요
			var url = "/hr/vlu/vlul081.jsp";

			window.showModalDialog(url, "Modal", "dialogWidth:900px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        	
        }
        
        
		// display
        function fnc_display(yn) {

        	if(yn == "n") {
	        	document.getElementById("btnAdd").style.display = "none";
				document.getElementById("btnDelete").style.display = "none";
				document.getElementById("btnSave").style.display = "none";

				grdT_EVL_GOALLIST_01.ColumnProp("CATEGORY","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("FORMULA","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("GOAL","Edit") = "None";


			} else {
				document.getElementById("btnAdd").style.display = "";
				document.getElementById("btnDelete").style.display = "";
				document.getElementById("btnSave").style.display = "";

				grdT_EVL_GOALLIST_01.ColumnProp("CATEGORY","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("FORMULA","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("GOAL","Edit") = "Any";

			}
        }

        function fnc_SetGrdHeight() {
        	var height = 0;

			height = (dsT_EVL_GOALLIST.CountRow * 100) + 20;

			if(height < 320) { // 최소 높이 360px
				height = 320;
			}

            grdT_EVL_GOALLIST_01.style.height = height;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

 	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST_PRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>





    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST_PRT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_GOALLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_display("y");
            document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_08");

        } else {

			// 엔터키변환
			for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {
				//dsT_EVL_GOALLIST.nameValue(i, "CATEGORY") = dsT_EVL_GOALLIST.nameValue(i, "CATEGORY").replace(/&&/gi,"\r\n");
            	//dsT_EVL_GOALLIST.nameValue(i, "FORMULA") = dsT_EVL_GOALLIST.nameValue(i, "FORMULA").replace(/&&/gi,"\r\n");
            	//dsT_EVL_GOALLIST.nameValue(i, "GOAL") = dsT_EVL_GOALLIST.nameValue(i, "GOAL").replace(/&&/gi,"\r\n");
			}



            //document.getElementById("resultMessage").innerText = iCount + fnc_GetMSG("MSG                                                                                         _04");

        }

        var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        var GOAL_NO = dsT_EVL_GOALLIST.nameValue(1, "GOAL_NO");

        if(GOAL_NO == "" || GOAL_NO == undefined) {
        	GOAL_NO = "1";
        }



    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EVL_GOALLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EVL_GOALLIST event="OnSuccess()">

		if(dsTemp != "Modal") {
			//alert(fnc_GetMSG("MSG_03") + "\r\n목표설정이 완료되었으면 상신해 주세요.");
		} else {
			//alert(fnc_GetMSG("MSG_03"));
		}

        //document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_03");
        fnc_SearchList();

    </script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EVL_GOALLIST_PRT event="OnSuccess()">

		alert("C:/목표기술서.xls 에 저장되었습니다.");

    </script>



    <!--트랜젝션 실패 -->
    <script for=trT_EVL_GOALLIST event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EVL_GOALLIST_PRT event="OnFail()">

        cfErrorMsg(this);

    </script>



	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_EVL_GOALLIST event=CanRowPosChange(row)>


	</script>

	<!-----------------------------------------------------+
    | 셀 및 레코드 영역 선택 변경이 완료된 이후에 발생하는 이벤트	|
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_EVL_GOALLIST_01 event=OnClick(Row,Colid)>
	    selectRow = Row;
  	</script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<div class="evl_container"><!-- evl_container 시작-->

	<div class="info_title"><!-- info_title 시작-->
		<h3 class="info_title_h3">목표설정</h3>

	</div><!-- //info_title 끝-->


   <font size = "2" face="굴림">
	<b>1. 상사와 면담후 상호 서명하십시오. 서명이 없는 MBO는 불인정하며, 상호 서명한 것은 면담한 것으로 간주합니다.</b><br><br>
	<b>2. 중점 업무목표는 연초 보고한 업무보고, 본부/부서장 KPI 등을 참고로 설정합니다 (통상 3~5개 정도로 중요도에 따라 설정).</b><br><br>
	<b>3. 목표수준은 중점업무목표의 달성 수준을 구체화/수치화하여 명기하되 수치화/계량화가 어려울 경우 구체적 달성 상황을 설정합니다.</b><br><br>
	     1) 수치계획 목표 (영업 부문) : 사전 판단기준을 명확히 설정해 두는 것이 중요합니다.<br>	
	        (예: 매출액 달성도, 영업/매출총 이익율 달성도, 판매액 달성도, 경비예산 관리실적, 전년대비 신장율, 시장개척 실적, Claim건수, Error율, 수주액, 생산량 달성도, 가동율 달성도 등)<br><br>		
	     2) 업무계획 목표 (기획, 지원부문) :수치화가 힘든 경우 문장으로 표현해야 하므로 추상적일 수 있으나 가능한  객관적인 평가가 될 수 있도록 설정하십시오.<br>		
	        (예: 방침/계획의 달성도, 업무스케쥴의 달성도, 기획/전략/개선책의 제안 실적, 업무개선/합리화 실적, 도전목표 달성도, 영업지원 실적, 업무보고 실적등)<br><br>		
	<b>4. 달성기한 : 각 중점업무 목표의 달성기한을 설정합니다.</b><br><br> 	
	<b>5. 비중 : 전체 비중의 합이 100%가 되도록 작성하십시오.</b><br><br>
	<b>6. 업무실적 및 평가점수 기입(연말 평가시)</b><br><br>	
	     1) 본인 기입란 : 업무목표에 따라 본인 수행한 업무실적을 기입하고 상사와 면담시 제출.<br>	
	     2) 상사 기입란 : 부하가 작성한 업무실적과 실제결과를 점검하여 수정 또는 확인하여 기록(면담 필수).<br>	
	     3) 평가점수 : 각 항목별로 (비중×달성도)점수를 구하여 기입하고 최종합계를 구함.<br><br>	
	<b>7. 평가자 최종확인 : 최종 평가시 피평가자에 대한 평가 종합의견을 반드시 기록해야 합니다.</b><br><br>	
	<font color = "blue" face="굴림"><b>※ 바람직한 목표설정 요령 (SMART원칙)</b></font><br><br>		
	     1) <font color = "blue" face="굴림"><b>S</b></font>pecific (구체적으로)<br>	
	     2) <font color = "blue" face="굴림"><b>M</b></font>easurable (측정가능하게)<br>	
	     3) <font color = "blue" face="굴림"><b>A</b></font>ttainable (달성할수 있는)<br>		
	     4) <font color = "blue" face="굴림"><b>R</b></font>easonable  Responsible (합리적이고 책임질수 있는)<br>
	     5) <font color = "blue" face="굴림"><b>T</b></font>ime-based (기한이 정해져 있는)<br>
</font>

<br>
        <table width="800" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE" height="30">
            <td width="800" height="30" colspan="4" align="center">
              	평가등급 (목표치에 따라 정량적 구간의 Gap은 변동가능)
            </td>        
          </tr>
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	등급
            </td>
            <td width="330" align="center">
              	정성적 기준
            </td>
            <td width="330" align="center">
              	정량적 기준
            </td>
            <td width="70" align="center">
              	평가점수
            </td>            
          </tr>          
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	S
            </td>
            <td width="330" align="center">
                    목표치 매우 상회 달성
            </td>
            <td width="330" align="center">
              	120% 이상
            </td>
            <td width="70" align="center">
              	10
            </td>            
          </tr>
    
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	A
            </td>
            <td width="330" align="center">
                    목표치 이상 달성
            </td>
            <td width="330" align="center">
              	100%이상 ~ 120%미만
            </td>
            <td width="70" align="center">
              	9
            </td>            
          </tr>

          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	B
            </td>
            <td width="330" align="center">
                    목표치 준하여 달성
            </td>
            <td width="330" align="center">
              	80%이상 ~ 100%미만
            </td>
            <td width="70" align="center">
              	8
            </td>            
          </tr>
          
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	C
            </td>
            <td width="330" align="center">
                    목표치 미달
            </td>
            <td width="330" align="center">
              	60%이상 ~ 80%미만
            </td>
            <td width="70" align="center">
              	7
            </td>            
          </tr>          
          
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	D
            </td>
            <td width="330" align="center">
                    목표치 매우 미달
            </td>
            <td width="330" align="center">
              	60% 미만
            </td>
            <td width="70" align="center">
              	6
            </td>            
          </tr>          
                                   
        </table>








</div><!-- //evl_container 끝 -->



</body>
</html>
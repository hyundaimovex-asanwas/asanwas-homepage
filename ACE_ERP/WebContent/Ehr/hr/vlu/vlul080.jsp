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
<script language=javascript src="/common/input.js"></script>
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

            dsT_EVL_GOALLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
            dsT_EVL_GOALLIST.Reset();
            
            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);  
            
            fnc_SetGrdHeight();

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
    		if (dsT_EVL_GOALLIST.countrow<1) {
    			alert("출력하실 정보가 없습니다");
    		} else {

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;        
        
            
            dsT_EVL_REPORT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
            dsT_EVL_REPORT.Reset();
            
    		ReportID.Preview();

    		}

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

				if(dsT_EVL_GOALLIST.nameValue(i, "APP_STATUS") == 'R'){
					alert("전산제출되어 수정하실 수 없습니다.");
					return false;
				}
				
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

			//cfStyleGrid_New(grdT_EVL_APPROVAL, 0, "false", "false");  // Grid Style 적용			
			//grdT_EVL_APPROVAL.RowHeight = 20;          // Grid Row Height Setting
			//grdT_EVL_APPROVAL.TitleHeight = 25;
			
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

			window.showModalDialog(url, "Modal", "dialogWidth:1020px; dialogHeight:850px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        	
        }
        
        
 
        
        
        /*****************************************************
         * 전산제출                             *
         ****************************************************/
        function fnc_Submit() {

        	// 상신 할 자료가 있는지 체크하고
            if (dsT_EVL_GOALLIST.CountRow < 1) {
            	document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_17");
                alert(fnc_GetMSG("MSG_17"));
                return;
            }

        	// DataSet의 변경 여부 확인
            if ( dsT_EVL_GOALLIST.IsUpdated || dsT_EVL_GOALLIST_01.IsUpdated ) {
				alert("저장한 후 제출해 주세요.");
                return false;
            }

            if (confirm("전산제출이후에는 수정이 불가능합니다. 제출하시겠습니까?") == false) return;



            //전체가 넘어가게 해야함
            dsT_EVL_GOALLIST_01.UseChangeInfo = "false";

            trT_EVL_APPROVAL.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST_01)";
            trT_EVL_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SAV_01";
            trT_EVL_APPROVAL.post();

            dsT_EVL_GOALLIST_01.UseChangeInfo = "true";

            alert("전산제출 완료");
            
        	document.getElementById("resultMessage").innerText = "전산제출이 완료되었습니다";

			//fnc_display("n");

	        //trT_EVL_APPROVAL.KeyValue = "tr01(O:dsT_EVL_APPROVAL=dsT_EVL_APPROVAL)";
	        //trT_EVL_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SHR_01&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
	        //trT_EVL_APPROVAL.post();

        }

        
        
        
        // 결재 status Y:승인, N:부결
        function fnc_Approval(yn) {

        	// DataSet의 변경 여부 확인
            if ( dsT_EVL_GOALLIST.IsUpdated || dsT_EVL_GOALLIST_01.IsUpdated) {
				alert("수정한 내역이 있습니다. 저장 후 처리해 주세요.");
                return false;
            }

        	var kind = "";

        	if(yn == "Y") {
	        	kind = "승인";
			} else {
	        	kind = "부결";
			}
        	if (!confirm(kind+" 처리를 하시겠습니까?")) return;

			//var obj = new String();
			//obj.remark = "";

			/*
        	if(yn == "N") {	// 부결메시지
        		window.showModalDialog("/hr/vlu/vlul091.jsp", obj, "dialogWidth:500px; dialogHeight:170px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        		if(obj.remark == "") {
        			return;
        		}
        	}
			*/
			

        	//var GUBUN = dsT_EVL_APPROVAL.NameValue(1,"GUBUN");
        	//var GOAL_NO = dsT_EVL_APPROVAL.NameValue(1,"GOAL_NO");

			trT_EVL_APPROVAL.KeyValue = "tr01(O:dsT_EVL_APPROVAL=dsT_EVL_APPROVAL)";
	        trT_EVL_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SAV_02&EVL_YYYY="+year+"&ENO_NO="+ENO_NO+"&STATUS="+yn;
	        trT_EVL_APPROVAL.post();

			alert(kind + "하였습니다.");

			// 결재 후 창 닫힘
			window.close();

	        //fnc_display("n");
			//document.getElementById("approval").style.display = "none";
			//STS = yn;
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

			if(height < 320) { // 최소 높이 320px
				height = 320;
			}
			
            grdT_EVL_GOALLIST_01.style.height = height;
            grdT_EVL_GOALLIST.style.height = height;            
        }

        
        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            fnc_SearchList()

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList()
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
    <Object ID="dsT_EVL_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST_01)">
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



            //document.getElementById("resultMessage").innerText = iCount + fnc_GetMSG("MSG_04");

        }

    	//if( dsT_EVL_GOALLIST.NameValue(1,"APP_STATUS") == "" || dsT_EVL_GOALLIST.NameValue(1,"APP_STATUS") == "N"  ) {	// 상신 전이나 부결시 저장,추가,삭제,상신 가능
		//	fnc_display("y");
    	//} else {
        //    fnc_display("n");
    	//}

    	//alert(dsTemp);


    		if(dsTemp == "Modal" ) {


				document.getElementById("imgSave").style.display = "none";
				document.getElementById("Image0").style.display = "none";
				document.getElementById("Image1").style.display = "none";
				document.getElementById("Image2").style.display = "none";				
				document.getElementById("Image3").style.display = "none";
				document.getElementById("Image4").style.display = "none";				
				document.getElementById("Image5").style.display = "none";						
				document.getElementById("Image6").style.display = "none";				
				document.getElementById("Image7").style.display = "none";						

				document.getElementById("approval").style.display = "";					
				
				document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
		  		document.getElementById("txtEVL_YYYY").readOnly = true;
				document.getElementById("txtENO_NO").className = "input_ReadOnly";
		  		document.getElementById("txtENO_NO").readOnly = true;	  		
				document.getElementById("txtENO_NM").className = "input_ReadOnly";
		  		document.getElementById("txtENO_NM").readOnly = true;
		  		document.getElementById("ImgEnoNo").style.display = "none";				


			}


        document.getElementById("resultMessage").innerText = iCount + fnc_GetMSG("MSG_04");

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

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();" oncontextmenu="return true">

<div class="evl_container"><!-- evl_container 시작-->

	<div class="info_title"><!-- info_title 시작-->
		<h3 class="info_title_h3">목표설정</h3>
		<p class="info">HOME &gt; 인사평가  &gt; 업적평가 &gt; <strong>목표설정</strong></p>
	</div><!-- //info_title 끝-->



	<div class="btn_group_right" ><!-- btn_group 시작-->
		<ul class="list">
	 		<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_submit.gif',1)"><img src="/images/button/btn_submit.gif" name="imgSave" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>&nbsp;&nbsp;&nbsp;			
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_Detail.gif',1)"><img src="/images/button/btn_Detail.gif" name="Image0" width="66" height="21" border="0" align="left" onClick="fnc_Popup()"></a></li>&nbsp;&nbsp;		
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a></li>

			<span id="approval" style="display:none;" >
				<li><a href="#"><img id="btnApproval" name="btnApproval" 	src="/images/button/btn_ApprovalOn.gif" 	onmouseover="this.src='/images/button/btn_ApprovalOver.gif'" 	onmouseout="this.src='/images/button/btn_ApprovalOn.gif'" alt="승인" onclick="fnc_Approval('Y');" /></a></li>
				<li><a href="#"><img id="btnReject" 	name="btnReject" 	src="/images/button/btn_RejectionOn.gif" onmouseover="this.src='/images/button/btn_RejectionOver.gif'" 	 onmouseout="this.src='/images/button/btn_RejectionOn.gif'" alt="부결" onclick="fnc_Approval('N');" /></a></li>
			</span>		
		</ul>
	</div><!-- //btn_group 끝-->

   <br><br>
   
	<div class="inquiry"><!-- inquiry 시작-->
		<form action="" method="post" >
			<fieldset>
				<legend>목표설정</legend>
					<p>해당년도 :
					<span>
						<input type="text" id=txtEVL_YYYY name="txtEVL_YYYY" size="4" readonly class="input_ReadOnly" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()" />
					</span>
					&nbsp;&nbsp;성명 :
					<span>
						<input type="text" id="txtENO_NO" name="txtENO_NO" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()"/><input type="text" style="display:none" />
						<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()"  /><input type="text" style="display:none" />
						<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
						<input type="hidden" id="hidEMPL_DPT_CD">					
					</span>
					</p>
			</fieldset>
		</form>
	</div><!-- // inquiry 끝-->

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
	
	
	<div class="btn_group_right" ><!-- btn_group 시작-->
		<ul class="list">
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_AppendOver.gif',1)"> <img src="/images/button/btn_AppendOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a></li>
		</ul>
	</div><!-- //btn_group 끝-->
		
<br>
   ※ Ctrl + Enter 누르시면 줄바꿈됩니다.
	<!-- 내용 조회 그리드 테이블 시작-->
	<table  summary="목표설정" class="evl_table">
	<caption>목표설정</caption>
			<colgroup>
				<col width="30px" />
				<col width="120px" />
				<col width="300px" />
				<col width="100px" />
				<col width="50px" />
				<col width="30px" />
				<col width="120px" />
				<col width="30px" />
				<col width="120px" />				
			</colgroup>
			<thead>
				<tr>
					<th rowspan='2' style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">NO</th>
					<th rowspan='2' style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">업무목표</th>
					<th rowspan='2' style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">목표수준</th>
					<th rowspan='2' style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">달성기한</th>
					<th rowspan='2' style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">비중</th>
					<th colspan='2'  style = "height:5px; padding:7px 0 ;border:1px solid #8C8C8C; border-bottom:0px solid #abc0dc; background:#8C8C8C; font-weight:bold; color:#34578c;">본인평가</th>	
					<th colspan='2'  style = "height:5px; padding:7px 0 ;border:1px solid #8C8C8C; border-bottom:1px solid #abc0dc; background:#8C8C8C; font-weight:bold; color:#34578c;">상사평가</th>											
				</tr>		
				<tr>							
					<th style = "height:10px; padding:7px 0 ;border:0px solid #8C8C8C; border-bottom:1px solid #8C8C8C; background:#8C8C8C; font-weight:bold; color:#34578c;">등급</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #8C8C8C; border-bottom:1px solid #8C8C8C; background:#8C8C8C; font-weight:bold; color:#34578c;">실적내용</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #8C8C8C; border-bottom:1px solid #8C8C8C; background:#8C8C8C; font-weight:bold; color:#34578c;">등급</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #8C8C8C; border-bottom:1px solid #8C8C8C; background:#8C8C8C; font-weight:bold; color:#34578c;">실적내용</th>					
				</tr>
			</thead>
			<tbody>
	<tr>
	<td colspan="9">
	<div style="width:900px; height:450px; overflow-y:auto;">
		<table style='font:11px "돋움",Dotum,"굴림",Gulim,Verdana,Arial,sans-serif; color:#555; color:#454e69; font-weight:normal;'>
		    <tr align="center">
		        <td>
		        	<comment id="__NSID__">
						<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:320px;">
							<param name="DataID"				value="dsT_EVL_GOALLIST_01">
		                	<param name=HiddenVScroll 		value="true">
		                	<param name=HiddenHScroll 		value="true">
	                		<param name=ViewHeader 		value="false">
							<param name="Format"				value="
								<C> id={currow}		width=30   	name='NO'			align=center </C>
								<C> id='CATEGORY'	width=120	name='업무목표'	align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'	width=300	name='목표수준'	align=left		wordwrap=word Multiline=true </C>
								<C> id='GOAL_YMD'	width=100	name='달성기한'	align=center	wordwrap=word Multiline=true </C>
								<C> id='WEIGHT'		width=50	name='비중'			align=center	wordwrap=word Multiline=true </C>															
							">
						</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>
		        
		        
		        <td>
		            <comment id="__NSID__">
		            <object id="grdT_EVL_GOALLIST" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" style="width:300px;height:320px;">
		                <param name="DataID"                  value="dsT_EVL_GOALLIST">
		                <param name=Sort						 value=false>                
	                	<param name=ViewHeader 			value="false">
		                <param name="INDICATORINFO"  	value='<IndicatorInfo width="0" />'>
		                <param name=BackgroundInfo 		value='
		                	<BACKGROUNDINFO borderstyle="none" />
		                '>
		                <param name="ColumnInfo"                  value='
		                	<COLUMNINFO>
						    	<COLUMN id="ID_INFO" view="false">
						    		<HEADER left="0" top="0" right="300" bottom="20" text="평가방법" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="30" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="0" top="0" right="30" bottom="20"  text="S" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="30" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="0" top="20" right="30" bottom="40"  text="A" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="30" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="0" top="40" right="30" bottom="60" text="B" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="30" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="0" top="60" right="30" bottom="80" text="C" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="30" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="0" top="80" right="30" bottom="100" text="D" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_S" refcolid="GRADE_S">
						    		<HEADER left="30" top="0" right="150" bottom="100" text="기준" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="30" top="0" right="150" bottom="100" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>



						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="150" top="20" right="180" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="150" top="0" right="180" bottom="20"  text="S" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="150" top="20" right="180" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="150" top="20" right="180" bottom="40"  text="A" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="150" top="20" right="180" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="150" top="40" right="180" bottom="60" text="B" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="150" top="20" right="180" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="150" top="60" right="180" bottom="80" text="C" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="150" top="20" right="180" bottom="40" text="등급" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="150" top="80" right="180" bottom="100" text="D" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_S" refcolid="GRADE_S">
						    		<HEADER left="180" top="0" right="300" bottom="100" text="기준" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="돋움" />
						    		<VIEW left="180" top="0" right="300" bottom="100" borderstyle="Line" bordercolor="#f0f0f0" fontsize="9" fontname="돋움"/>
						    	</COLUMN>


						     </COLUMNINFO>
						 '>
		            </object>
		            </comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>		        
		    </tr>
		</table>
	</div>
	</td>
	</tr>
	</table>		  
	<font color = 'blue'>※ 본인평가 및 상사평가는 연말평가시 작성</font>
	<!-- 내용 조회 그리드 테이블 끝-->

</div><!-- //evl_container 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<comment id="__NSID__">
		<object	id="grdT_EVL_GOALLIST_PRT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:0px;">
			<param name="DataID"				value="dsT_EVL_GOALLIST_PRT">
			<param name=ViewSummary  value="1">
			<param name="Format"				value="
			<X> id='INFO' name='정보' HeadBgColor='#ffffff' HeadFontStyle='bold'
				<C> id='NO'						width=50   name='NO'				align=center 	Suppress=1 sumbgcolor='#dae0ee' sumcolor='#34578c' gte_columntype='number:0:true'</C>
				<C> id='CATEGORY'			width=200	name='업무목표'		align=center	Multiline=true Suppress=3 sumtext='합 계' sumbgcolor='#dae0ee' sumcolor='#34578c' sumFontStyle='bold' SumTextAlign='center'</C>
				<C> id='FORMULA'			width=600	name='목표수준'		align=left		Multiline=true Suppress=2 sumbgcolor='#dae0ee' sumcolor='#34578c' </C>
				<C> id='GOAL_YMD'			width=100	name='달성기한'		align=center	Multiline=true Suppress=1 sumbgcolor='#dae0ee' sumcolor='#34578c' </C>
				<C> id='WEIGHT'				width=100	name='비중'				align=center	Suppress=1 sumtext='' gte_Summarytype='number:1:true' sumbgcolor='#dae0ee' sumcolor='#34578c'  sumFontStyle='bold' SumTextAlign='center'</C>
			</X>
			">
		</object>
	</comment><script> __ShowEmbedObject(__NSID__); </script>
	<!-- 내용 조회 그리드 테이블 끝-->





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 일용직 급 여 ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_EVL_REPORT">
	<param name="DetailDataID"	    			value="dsT_EVL_REPORT">
	<PARAM NAME="PaperSize"						VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" 						VALUE="




<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=408 ,face='Arial' ,size=12 ,penwidth=1
	<X>left=1500 ,top=0 ,right=2799 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1688 ,top=0 ,right=1688 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='피평가자' ,left=1513 ,top=108 ,right=1672 ,bottom=161 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='평가자' ,left=1513 ,top=180 ,right=1672 ,bottom=235 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1498 ,top=172 ,right=2799 ,bottom=172 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2432 ,top=0 ,right=2432 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='구분' ,left=1513 ,top=19 ,right=1662 ,bottom=79 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=2000 ,top=0 ,right=2000 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='직위' ,left=1786 ,top=21 ,right=1929 ,bottom=82 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='(인)' ,left=2328 ,top=180 ,right=2413 ,bottom=233 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=2328 ,top=108 ,right=2413 ,bottom=161 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1500 ,top=243 ,right=2799 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2799 ,top=0 ,right=2799 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='성명' ,left=2072 ,top=21 ,right=2355 ,bottom=82 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='작성 및 면담일자' ,left=2445 ,top=19 ,right=2789 ,bottom=82 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=66 ,top=13 ,right=651 ,bottom=225 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='평가시트' ,left=151 ,top=53 ,right=566 ,bottom=188 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=69 ,top=294 ,right=2818 ,bottom=407 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='순' ,left=79 ,top=320 ,right=153 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=172 ,top=294 ,right=172 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=717 ,top=294 ,right=717 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2252 ,top=294 ,right=2252 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2643 ,top=294 ,right=2643 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='비중' ,left=2659 ,top=320 ,right=2797 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='달성기한' ,left=2307 ,top=320 ,right=2577 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='중점 업무 목표' ,left=238 ,top=323 ,right=669 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='목표수준' ,left=1037 ,top=307 ,right=1569 ,bottom=355 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='(구체적 달성도 평가 기준)' ,left=1037 ,top=360 ,right=1569 ,bottom=407 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>

<B>id=default ,left=0,top=0 ,right=2871 ,bottom=243 ,face='Arial' ,size=12 ,penwidth=1
	<L> left=69 ,top=0 ,right=69 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=717 ,top=0 ,right=717 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=172 ,top=0 ,right=172 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2252 ,top=0 ,right=2252 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2818 ,top=0 ,right=2818 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2643 ,top=0 ,right=2643 ,bottom=243 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='WEIGHT', left=2664, top=16, right=2797, bottom=238, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GOAL_YMD', left=2257, top=16, right=2641, bottom=241, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CATEGORY', left=177, top=13, right=709, bottom=241, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='{CURROW}', left=79, top=37, right=161, bottom=188, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=243 ,right=2818 ,bottom=243 </L>
	<C>id='FORMULA', left=728, top=11, right=2241, bottom=238, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
</B>

<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=273 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='총계' ,left=69 ,top=0 ,right=2643 ,bottom=74 ,face='Tahoma체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<X>left=2643 ,top=0 ,right=2818 ,bottom=74 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{Sum(WEIGHT)} ', left=2643, top=11, right=2813, bottom=61, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>

</B>
">
</OBJECT>


</body>
</html>
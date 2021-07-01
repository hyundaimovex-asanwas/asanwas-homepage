<!--
    ************************************************************************************
    * @Source              : joba020.jsp                                               *
    * @Description        : 직무이동설문작성                                           *
    * @Font                   :                                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  한학현   | 최초작성                                               *
    * 2006/10/24  |  한학현   | 개발완료                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>직무이동설문작성</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		var btnList = 'FFTTFFFT';
		
		var ActiveIndex = 0;

        var oRSH_GBN = 1;//직무이동, 자기신고 모두사용
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

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

			//동시에 저장하게 변경
			//msg는 trT_EV_QSTANS만 출력하게 했다

			if (!dsT_EV_CHGANS.IsUpdated && !dsT_EV_QSTANS.IsUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			if(fnc_SaveItemCheck1() && fnc_SaveItemCheck2()) {
				trT_EV_CHGANS.KeyValue = "SVL(I:dsT_EV_CHGANS=dsT_EV_CHGANS)";
				trT_EV_CHGANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_01&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value;
				trT_EV_CHGANS.post();
				
				trT_EV_QSTANS.KeyValue = "SVL(I:dsT_EV_QSTANS=dsT_EV_QSTANS)";
				trT_EV_QSTANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_02";
				trT_EV_QSTANS.post();
				
			} else {
				return;
			}

			/*
			if(ActiveIndex == 1){//직무이동만
				if(fnc_SaveItemCheck1()) {
					trT_EV_CHGANS.KeyValue = "SVL(I:dsT_EV_CHGANS=dsT_EV_CHGANS)";
					trT_EV_CHGANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_01&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value;
					trT_EV_CHGANS.post();
				} else {
					return;
				}
			}else if(ActiveIndex == 2){//자기신고만
				if(fnc_SaveItemCheck2()) {
					trT_EV_QSTANS.KeyValue = "SVL(I:dsT_EV_QSTANS=dsT_EV_QSTANS)";
					trT_EV_QSTANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_02";
					trT_EV_QSTANS.post();
				} else {
					return;
				}
			}
			*/

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

			if(ActiveIndex == 1){//직무이동만
				dsT_EV_CHGANS.ClearData();
				dsT_EV_CHGANS.Reset();

				document.rdoCHANGE_GBN.CodeValue = "";
				document.rdoCHANGE_TIME.CodeValue = "";
				document.rdoNOCHANGE_GBN.CodeValue = "";

				document.rdoCHANGE_GBN.Enable = "true";
				document.rdoCHANGE_TIME.Enable = "true";
		        document.rdoNOCHANGE_GBN.Enable = "true";

				document.getElementById("txtCHANGE_DEC").value="";
				document.getElementById("txtCHANGE_DEC").readOnly = false;
				document.getElementById("txtCHANGE_DEC").className="";

				document.getElementById("txtNOCHANGE_DEC").value="";
				document.getElementById("txtNOCHANGE_DEC").readOnly = false;
				document.getElementById("txtNOCHANGE_DEC").className="";

				document.getElementById("txtHOPE_DEP1").readOnly = true;
				document.getElementById("txtHOPE_DEP1").className="";
				document.getElementById("txtHOPE_DEP1").value="";
				document.getElementById("txtHOPE_DEP1NM").value="";
				document.getElementById("img_HelpOn1").style.display = "";
				document.getElementById("txtHOPE_DEP2").readOnly = true;
				document.getElementById("txtHOPE_DEP2").className="";
				document.getElementById("txtHOPE_DEP2").value="";
				document.getElementById("txtHOPE_DEP2NM").value="";
				document.getElementById("img_HelpOn2").style.display = "";
				document.getElementById("txtHOPE_DEP3").readOnly = true;
				document.getElementById("txtHOPE_DEP3").className="";
				document.getElementById("img_HelpOn3").style.display = "";
				document.getElementById("txtHOPE_DEP3").value="";
				document.getElementById("txtHOPE_DEP3NM").value="";

			}else if(ActiveIndex == 2){//설문조사
				dsT_EV_QSTANS.ClearData();
				dsT_EV_QSTANS.Reset();

                document.grdT_EV_QSTANS.Enable = "true";

                for(i=1; i<=dsT_EV_QSTANS.CountRow; i++){
                    dsT_EV_QSTANS.NameValue(i,"ANS_A") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_B") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_C") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_D") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_E") = "F";
                }

			}
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_EV_CHGANS.IsUpdated)  {
	            if (!confirm("직무이동에 변경내용 존재합니다.\n\n확인을 누르시면 변경된 자료는 저장되지 않고 종료 됩니다."))  return;
	        }

	        if (dsT_EV_QSTANS.IsUpdated)  {
	            if (!confirm("자기신고서에 변경내용 존재합니다.\n\n확인을 누르시면 변경된 자료는 저장되지 않고 종료 됩니다."))  return;
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

        //직무이동 유효성 체크
        function fnc_SaveItemCheck1() {
			var f = document.form1;

            //DataSet의 변경 여부 확인
			/*
			if (!dsT_EV_CHGANS.IsUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}
			*/

			var oCHANGE_GBN, oCHANGE_DEC, oNOCHANGE_GBN, oNOCHANGE_DEC;
			var RowCnt = dsT_EV_CHGANS.CountRow;

			oCHANGE_GBN = dsT_EV_CHGANS.NameValue(RowCnt,"CHANGE_GBN");
			oNOCHANGE_GBN = dsT_EV_CHGANS.NameValue(RowCnt,"NOCHANGE_GBN");
			//if(oCHANGE_GBN.trim() == "" && oNOCHANGE_GBN.trim() == ""){
			//	alert("직무이동을 원할 경우 또는 의사가 없을 경우중 하나이상 체크해야합니다." );
			//	return false;
			//}

			oCHANGE_DEC = dsT_EV_CHGANS.NameValue(RowCnt,"CHANGE_DEC");
			if(document.rdoCHANGE_GBN.CodeValue == 4 && oCHANGE_DEC.trim() == "") {
				alert("직무이동을 원할 경우 이동사유 항목의 기타내용를 입력하세요" );
				document.getElementById("txtCHANGE_DEC").focus();
				return false;
			}

			oNOCHANGE_DEC = dsT_EV_CHGANS.NameValue(RowCnt,"NOCHANGE_DEC");
			if(document.rdoNOCHANGE_GBN.CodeValue == 4 && oNOCHANGE_DEC.trim() == "") {
				alert("직무이동 의사가 없을 경우 사유 항목의 기타를 입력하세요" );
				document.getElementById("txtNOCHANGE_DEC").focus();
				return false;
			}

			if(document.rdoNOCHANGE_GBN.CodeValue == "") {
				if(document.rdoCHANGE_GBN.CodeValue == ""){
					alert("이동사유를 선택하세요");
					document.rdoCHANGE_GBN.Focus();
					return false;
				}
				if(document.rdoCHANGE_TIME.CodeValue == ""){
					alert("이동시기를 선택하세요");
					document.rdoCHANGE_GBN.Focus();
					return false;
				}
				if(document.getElementById("txtHOPE_DEP1").value == ""){
					alert("이동희망부서를 선택하세요");
					document.getElementById("txtHOPE_DEP1").focus();
					return false;
				}
			}


			return true;
        }

        //자기신고서 유효성 체크
        function fnc_SaveItemCheck2() {
			var f = document.form1;

            //DataSet의 변경 여부 확인
            /*
			if (!dsT_EV_QSTANS.IsUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}
			*/

			var i = 0;
			var oANS_A, oANS_B, oANS_C, oANS_D, oANS_E;
			var RowCnt = dsT_EV_QSTANS.CountRow;

			for(i=1; i<=RowCnt; i++){
				oANS_A = dsT_EV_QSTANS.NameValue(i,"ANS_A");
				oANS_B = dsT_EV_QSTANS.NameValue(i,"ANS_B");
				oANS_C = dsT_EV_QSTANS.NameValue(i,"ANS_C");
				oANS_D = dsT_EV_QSTANS.NameValue(i,"ANS_D");
				oANS_E = dsT_EV_QSTANS.NameValue(i,"ANS_E");

				if((oANS_A.trim() == "F" || oANS_A.trim() == "") &&
				   (oANS_B.trim() == "F" || oANS_B.trim() == "") &&
				   (oANS_C.trim() == "F" || oANS_C.trim() == "") &&
				   (oANS_D.trim() == "F" || oANS_D.trim() == "") &&
				   (oANS_E.trim() == "F" || oANS_E.trim() == "")){
				   alert("자기신고서 "+i+"번째의 설문항목을 응답하지 않았습니다.");
				   return false;
				   /*
					if (confirm(i+"번째의 설문항목을 응답하지 않았습니다.\n 그래도 저장하시겠습니까?")){
						return true;
					}else{
						return false;
					}
					*/
				}
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			//Grid Style 적용
			cfStyleGrid(form1.grdT_EV_QSTANS,0,"true","false");
			form1.grdT_EV_QSTANS.DragDropEnable  = "false";
			form1.grdT_EV_QSTANS.ColSizing  = "false";

			//form load시 무조건 조사년월 조회
            var f = document.form1;
			//if (!valid(form1)) return;//Validation 수행
			try {
				//사용자 정보 불러온다.
	            dsT_EV_JOBCHG.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SHR";
	            dsT_EV_JOBCHG.Reset();
	            
<%
    //관리자이면 사용자정보가 없어도 검색가능
    if(!box.getString("SESSION_ROLE_CD").equals("1001")) {
%>	            
				//사용자 정보가 있어야 설문가능
				if(dsT_EV_JOBCHG.CountRow != 0){
<%
    }else{
%>
                    document.getElementById("txtPIS_YYMM").value = getToday();//관리자는 대상자에 포함이 않되므로 임의로 넣어준다. 
<%
    }
%>
					//직무이동 불러온다.
					dsT_EV_CHGANS.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SHR_01&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value+"&ENO_NO="+document.getElementById("txtENO_NO").value;
		            dsT_EV_CHGANS.Reset();

					//직무조사서 불러온다.
		            dsT_EV_QSTANS.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SHR_02&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value+"&ENO_NO="+document.getElementById("txtENO_NO").value;
		            dsT_EV_QSTANS.Reset();
		            
<%
    //관리자이면 사용자정보가 없어도 검색가능
    if(!box.getString("SESSION_ROLE_CD").equals("1001")) {
%>            
	            }
<%
    }
%>	            
	            
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
        }

        /********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

		function cheakValue(obj){
			if (event.type =="click" || obj.value.length > 0){
				document.rdoNOCHANGE_GBN.Enable = "false";
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
				document.getElementById("txtNOCHANGE_DEC").value="";
			}else{
			}
		}

        //Layer ID
        var layerList = new Array(  "tabJOBA020_01"
                                   ,"tabJOBA020_02" );
        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {
        
            if(oRSH_GBN == "2" && idx== "1"){//직무이동만 가능
                alert("직무이동 설문작성만 가능합니다."); 
                return false
            }
            
            if(oRSH_GBN == "3" && idx== "0"){//자기신고서만 가능
                alert("자기신고서 설문작성만 가능합니다."); 
                return false
            }
        
            ActiveIndex = idx+1;
            
            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            
            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }
            
                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }
            
            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";
            
        }
        
</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                                      |
    | 2. 이름 : dsT_EV_JOBCHG                                        |
    | 3. Table List : T_EV_JOBCHG                                    |
    +----------------------------------------------->
    <Object ID="dsT_EV_JOBCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_EV_QSTANS                                  |
    | 3. Table List : T_EV_QSTANS                                 |
    +----------------------------------------------->
    <Object ID="dsT_EV_QSTANS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_EV_QSTANS                                    |
    | 3. Table List : T_EV_QSTANS                                 |
    +----------------------------------------------->
    <Object ID ="trT_EV_QSTANS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_EV_CHGANS                                  |
    | 3. Table List : T_EV_CHGANS                                 |
    +----------------------------------------------->
    <Object ID="dsT_EV_CHGANS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_EV_CHGANS                                    |
    | 3. Table List : T_EV_CHGANS                                 |
    +----------------------------------------------->
    <Object ID ="trT_EV_CHGANS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBCHG Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //데이터가 없다면 설문작성 대상자가 아니다.
			alert("직무이동신청 대상자가 아닙니다.");
			//fnc_Exit();
			document.getElementById("imgSave").style.display = "none";
			//document.imgSave.style.visibility="hidden";

			rdoCHANGE_GBN.Enable = "false";
			document.getElementById("txtCHANGE_DEC").readOnly = true;
			document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";

			rdoCHANGE_TIME.Enable = "false";

			document.getElementById("txtHOPE_DEP1").readOnly = true;
			document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
			document.getElementById("img_HelpOn1").style.display = "none";
			document.getElementById("txtHOPE_DEP2").readOnly = true;
			document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
			document.getElementById("img_HelpOn2").style.display = "none";
			document.getElementById("txtHOPE_DEP3").readOnly = true;
			document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
			document.getElementById("img_HelpOn3").style.display = "none";

			rdoNOCHANGE_GBN.Enable = "false";
			document.getElementById("txtNOCHANGE_DEC").readOnly = true;
			document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";

            grdT_EV_QSTANS.Enable = "false";

        } else {
	        RowCnt = dsT_EV_JOBCHG.CountRow;

	        if(RowCnt != 1){
	        	alert("대상자 개인정보 생성 오류")
	        }

			//개인정보를 보여준다.
			document.getElementById("txtPIS_YYMM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"PIS_YYMM");
			document.getElementById("txtENO_NO").value = dsT_EV_JOBCHG.NameValue(RowCnt,"ENO_NO");
			document.getElementById("txtENO_NM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"ENO_NM");
			document.getElementById("txtDPT_CD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"DPT_CD");
			document.getElementById("txtDPT_NM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"DPT_NM");
			document.getElementById("txtJOB_CD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"JOB_CD");
			document.getElementById("txtJOB_NM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"JOB_NM");
			document.getElementById("txtBIR_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"BIR_YMD");
			document.getElementById("txtHIR_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"HIR_YMD");
			document.getElementById("txtDPA_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"DPA_YMD");
			document.getElementById("txtJPR_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"JPR_YMD");

			//어학성적(임시)
			//alert(dsT_EV_JOBCHG.NameValue(RowCnt,'EXM_PNT'));

			//설문open 되어야만 설문작성메뉴 사용 가능
			var oSTATUS_JOB = dsT_EV_JOBCHG.NameValue(RowCnt,"STATUS_JOB");//작업상태
			if(oSTATUS_JOB != 2){
				alert("직무이동신청 설문작성기간이 아닙니다.");
	            //fnc_Exit();
				document.getElementById("imgSave").style.display = "none";
				document.getElementById("imgCancel").style.display = "none";
				//document.imgSave.style.visibility="hidden";

				rdoCHANGE_GBN.Enable = "false";
				document.getElementById("txtCHANGE_DEC").readOnly = true;
				document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";

				rdoCHANGE_TIME.Enable = "false";

				document.getElementById("txtHOPE_DEP1").readOnly = true;
				document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
				document.getElementById("img_HelpOn1").style.display = "none";
				document.getElementById("txtHOPE_DEP2").readOnly = true;
				document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
				document.getElementById("img_HelpOn2").style.display = "none";
				document.getElementById("txtHOPE_DEP3").readOnly = true;
				document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
				document.getElementById("img_HelpOn3").style.display = "none";

				rdoNOCHANGE_GBN.Enable = "false";
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";

                grdT_EV_QSTANS.Enable = "false";
			}

			oRSH_GBN = dsT_EV_JOBCHG.NameValue(RowCnt,"RSH_GBN");//조사내용 구분

			if(oRSH_GBN == 1){//직무이동, 자기신고 모두사용
				TabEvent(0);
				
			}else if(oRSH_GBN == 2){//직무이동만
				TabEvent(0);
				
			}else if(oRSH_GBN == 3){//자기신고
				TabEvent(1);
				
			}
        }
    </Script>

    <Script For=dsT_EV_QSTANS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            ///fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
        }
    </Script>

    <Script For=dsT_EV_CHGANS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            //현재 값이 없다면 저장하기 위한 row추가
			dsT_EV_CHGANS.AddRow();
			rdoCHANGE_GBN.Focus();
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩

            //기타버튼 처리
			if(rdoCHANGE_GBN.CodeValue == 4){
				document.getElementById("txtCHANGE_DEC").readOnly = false;
				document.getElementById("txtCHANGE_DEC").className="";
			}else{
				document.getElementById("txtCHANGE_DEC").readOnly = true;
				document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";
				document.getElementById("txtCHANGE_DEC").value="";
			}

			if(rdoNOCHANGE_GBN.CodeValue == 4){
				document.getElementById("txtNOCHANGE_DEC").readOnly = false;
				document.getElementById("txtNOCHANGE_DEC").className="";
			}else{
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
				document.getElementById("txtNOCHANGE_DEC").value="";
			}

			if(rdoCHANGE_GBN.CodeValue != ""){
				rdoNOCHANGE_GBN.Enable = "false";
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
			}else{
				rdoCHANGE_GBN.Enable = "false";
				document.getElementById("txtCHANGE_DEC").readOnly = true;
				document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";

				rdoCHANGE_TIME.Enable = "false";

				document.getElementById("txtHOPE_DEP1").readOnly = true;
				document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
				document.getElementById("img_HelpOn1").style.display = "none";
				document.getElementById("txtHOPE_DEP2").readOnly = true;
				document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
				document.getElementById("img_HelpOn2").style.display = "none";
				document.getElementById("txtHOPE_DEP3").readOnly = true;
				document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
				document.getElementById("img_HelpOn3").style.display = "none";
			}
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_EV_JOBCHG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_EV_QSTANS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_EV_CHGANS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_EV_QSTANS Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_EV_CHGANS Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_EV_QSTANS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <script for=trT_EV_CHGANS event="OnSuccess()">
        //fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_EV_QSTANS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_EV_CHGANS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!---------------------------------+
    | CheckBox 클릭시  중복 체크 처리       |
    +---------------------------------->
	<script language="javascript"  for=grdT_EV_QSTANS event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		if(Colid != 'QST_GBN_NM' && Colid != 'QST_ITEM_NM' && Row != '0'){
			//CheckBoxText를 클릭해도 체크된다.
			dsT_EV_QSTANS.NameValue(Row,Colid) = "T";

			if(Colid != "ANS_A"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_A") = "F";
	    	}
	    	if(Colid != "ANS_B"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_B") = "F";
	    	}
	    	if(Colid != "ANS_C"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_C") = "F";
	    	}
	    	if(Colid != "ANS_D"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_D") = "F";
	    	}
	    	if(Colid != "ANS_E"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_E") = "F";
	    	}
    	}
	</script>

	<!---------------------------------+
    | Radio Button 클릭시 버튼 처리            |
    +---------------------------------->
    <script language=JavaScript for=rdoCHANGE_GBN event=OnSelChange()>
    	//기타버튼 처리
		if(rdoCHANGE_GBN.CodeValue == 4){
			document.getElementById("txtCHANGE_DEC").readOnly = false;
			document.getElementById("txtCHANGE_DEC").className="";
		}else{
			document.getElementById("txtCHANGE_DEC").readOnly = true;
			document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";
			document.getElementById("txtCHANGE_DEC").value="";
		}

		rdoNOCHANGE_GBN.Enable = "false";
		document.getElementById("txtNOCHANGE_DEC").readOnly = true;
		document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
		document.getElementById("txtNOCHANGE_DEC").value="";
	</script>

    <script language=JavaScript for=rdoCHANGE_TIME event=OnSelChange()>
	    rdoNOCHANGE_GBN.Enable = "false";
		document.getElementById("txtNOCHANGE_DEC").readOnly = true;
		document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
		document.getElementById("txtNOCHANGE_DEC").value="";
	</script>

    <script language=JavaScript for=rdoNOCHANGE_GBN event=OnSelChange()>
	    //기타버튼 처리
		if(rdoNOCHANGE_GBN.CodeValue == 4){
			document.getElementById("txtNOCHANGE_DEC").readOnly = false;
			document.getElementById("txtNOCHANGE_DEC").className="";
		}else{
			document.getElementById("txtNOCHANGE_DEC").readOnly = true;
			document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
			document.getElementById("txtNOCHANGE_DEC").value="";
		}

		rdoCHANGE_GBN.Enable = "false";
		document.getElementById("txtCHANGE_DEC").readOnly = true;
		document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";
		document.getElementById("txtCHANGE_DEC").value="";

		rdoCHANGE_TIME.Enable = "false";

		document.getElementById("txtHOPE_DEP1").readOnly = true;
		document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
		document.getElementById("txtHOPE_DEP1").value="";
		document.getElementById("txtHOPE_DEP1NM").value="";
		document.getElementById("img_HelpOn1").style.display = "none";
		document.getElementById("txtHOPE_DEP2").readOnly = true;
		document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
		document.getElementById("txtHOPE_DEP2").value="";
		document.getElementById("txtHOPE_DEP2NM").value="";
		document.getElementById("img_HelpOn2").style.display = "none";
		document.getElementById("txtHOPE_DEP3").readOnly = true;
		document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
		document.getElementById("txtHOPE_DEP3").value="";
		document.getElementById("txtHOPE_DEP3NM").value="";
		document.getElementById("img_HelpOn3").style.display = "none";
	</script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직무이동설문작성</td>
					<td align="right" class="navigator">HOME/직무이동/직무이동작업/<font color="#000000">직무이동설문작성</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
   			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>개인정보</strong></td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="115"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">조사년월</td>
                                <td class="padding2423">
                                	<input id="txtPIS_YYMM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">부서</td>
                                <td class="padding2423">
                                	<input type=hidden id="txtDPT_CD" class="input_ReadOnly" readonly>
                                	<input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">직위</td>
                                <td class="padding2423">
                                	<input type=hidden id="txtJOB_CD" class="input_ReadOnly" readonly>
                                	<input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">부서발령일/승진일</td>
                                <td class="padding2423">
                                	<input id="txtDPA_YMD" size="10" class="input_ReadOnly" readonly>&nbsp;/
                                	<input id="txtJPR_YMD" size="10" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423">
                                	<input id="txtENO_NO" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">성명</td>
                                <td class="padding2423">
                                	<input id="txtENO_NM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">생년월일</td>
                                <td class="padding2423">
                                	<input id="txtBIR_YMD" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">입사일</td>
                                <td class="padding2423">
                                	<input id="txtHIR_YMD" size="15" class="input_ReadOnly" readonly>
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

    <!-- 탭 사용 컴퍼넌트 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8" align="left">  
                
                <!-- 탭버튼데이블 시작 -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                        <td width="120"> 
                            <!-- 탭오버 -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                    <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">직무이동</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td> 
                            <!-- 탭히든 -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">자기신고서</td>
                                    <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                        <td height="2" bgcolor="#A4A4A1"></td>
                    </tr>
                </table>            
                <!-- 탭버튼테이블 끝 -->            
                
            </td>
        </tr>
    </table>

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabJOBA020_01" style="position:absolute; left:20; top:221; width:800; height:340; z-index:4;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <colgroup>
	                    <col width="225"></col>
	                    <col width="135"></col>
	                    <col width=""></col>
	                </colgroup>
	                <tr>
	                    <td align="center" class="creamBold" colspan="2">조사항목</td>
	                    <td align="center" class="creamBold">응답기준</td>
	                </tr>
	                <tr align="left">
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px" rowspan="3">1. 직무이동을 원할 경우</td>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(1)이동사유</td>
	                    <td class="padding2423">
							<comment id="__NSID__">
							<object id=rdoCHANGE_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:60; width:350">
								<param name=AutoMargin	value="false">
								<param name=Cols	value="1">
								<param name=DataID			value="dsT_EV_CHGANS">
								<param name=Format	value="1^적성 부적합,2^장래를 위한 타부분 경험,3^부서내 인간관계,4^기 타">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							&nbsp;&nbsp;&nbsp;&nbsp;<input id="txtCHANGE_DEC" style="width:90%">
						</td>
	                </tr>
	                <tr>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(2)이동시기</td>
	                    <td class="padding2423">
							<comment id="__NSID__">
							<object id=rdoCHANGE_TIME classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:60; width:400">
								<param name=AutoMargin	value="false">
								<param name=Cols	value="1">
								<param name=DataID			value="dsT_EV_CHGANS">
								<param name=Format	value="1^즉시 이동,2^3개월 이후 이동,3^6개월 이후 이동,4^회사방침대로">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
						</td>
	                </tr>
	                <tr>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(3)이동희망부서</td>
	                    <td class="padding2423">
		                     &nbsp;1지망 :
		                     <input id="txtHOPE_DEP1" size="8" maxlength="3"  class="input_ReadOnly" readonly onkeyup="cheakValue(this);">
		                     <input id="txtHOPE_DEP1NM" size="25" maxlength="3" class="input_ReadOnly" readonly>
		                     <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="cheakValue(this);fnc_commnmPopup('txtHOPE_DEP1','txtHOPE_DEP1NM','부서','DEPT');"></a><BR>
		                     &nbsp;2지망 :
		                     <input id="txtHOPE_DEP2" size="8" maxlength="3" class="input_ReadOnly" readonly onkeyup="cheakValue(this);">
		                     <input id="txtHOPE_DEP2NM" size="25" maxlength="3" class="input_ReadOnly" readonly>
		                     <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="cheakValue(this);fnc_commnmPopup('txtHOPE_DEP2','txtHOPE_DEP2NM','부서','DEPT')"></a><BR>
		                     &nbsp;3지망 :
		                     <input id="txtHOPE_DEP3" size="8" maxlength="3" class="input_ReadOnly" readonly onkeyup="cheakValue(this);">
		                     <input id="txtHOPE_DEP3NM" size="25" maxlength="3" class="input_ReadOnly" readonly>
		                     <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onClick="cheakValue(this);fnc_commnmPopup('txtHOPE_DEP3','txtHOPE_DEP3NM','부서','DEPT')"></a><BR>
						</td>
	                </tr>
	                <tr align="left">
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">2. 직무이동 의사가 없을 경우</td>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(1)사유</td>
	                    <td class="padding2423">
							<comment id="__NSID__">
							<object id=rdoNOCHANGE_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:60; width:350">
								<param name=AutoMargin	value="false">
								<param name=Cols	value="1">
								<param name=DataID			value="dsT_EV_CHGANS">
								<param name=Format	value="1^현부서 직무경험 축적,2^현근로구분의 전문직 성장,3^현근로구분의 직무 공백 초래,4^기 타">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							&nbsp;&nbsp;&nbsp;&nbsp;<input id="txtNOCHANGE_DEC" style="width:90%">
						</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabJOBA020_02" style="position:absolute; left:20; top:221; width:800; height:340; z-index:3; visibility:hidden">
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	            	<tr>
                        <td>
				            <table width="799" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#A1A1A1" class="table_cream" frame="below">
				                <tr>
				                </tr>
				            </table>
				            <table width="799" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#A1A1A1" class="table_cream" frame="vsides">
				                <colgroup>
				                    <col width="110"></col>
				                    <col width="229"></col>
				                    <col width=""></col>
				                </colgroup>
				                <tr>
				                    <td align="center" style="height:25;background:#F7DCBB;font-weight: bolder;">구분</td>
				                    <td align="center" style="height:25;background:#F7DCBB;font-weight: bolder;">설문항목</td>
				                    <td align="center" style="height:25;background:#F7DCBB;font-weight: bolder;">응답기준</td>
				                </tr>
			                </table>
		                </td>
	            	</tr>
	                <tr>
	                    <td>
							<comment id="__NSID__">
							<object	id="grdT_EV_QSTANS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
	                            <param name="DataID"				value="dsT_EV_QSTANS">
	                            <param name="EdiTABLE"				value="true">
    	                        <param name="DragDropEnable"		value="false">
				                <param name="VIEWSUMMARY"		    value=0>
				                <param name=ViewHeader  			value="false">
	                            <param name="Format"						value="
	                                <C> id='QST_GBN_NM'		width=110		name='구분'				align=left			edit=None						Suppress='1'						</C>
									<C> id='QST_ITEM_NM'	width=230		name='설문항목'		    align=left			edit=None															</C>
									<C> id='ANS_A'			width=88								align=center		EditStyle=CheckBox		CheckBoxText='LST_A'		Pointer=Hand	</C>
									<C> id='ANS_B'			width=88		name='응'				align=center		EditStyle=CheckBox		CheckBoxText='LST_B'		Pointer=Hand	</C>
									<C> id='ANS_C'			width=88		name='답       기'		align=center		EditStyle=CheckBox		CheckBoxText='LST_C'		Pointer=Hand	</C>
									<C> id='ANS_D'			width=88		name='준'				align=center		EditStyle=CheckBox		CheckBoxText='LST_D'		Pointer=Hand	</C>
									<C> id='ANS_E'			width=88								align=center		EditStyle=CheckBox		CheckBoxText='LST_E'		Pointer=Hand	</C>
								">
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

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                                               |
    | 2. 이름 : bndT_EV_CHGANS                                   |
    | 3. Table List : T_EV_CHGANS                                 |
    +----------------------------------------------->
	<object id="bndT_EV_CHGANS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_CHGANS">
		<Param Name="BindInfo", Value="
			<C>Col='CHANGE_GBN'			Ctrl='rdoCHANGE_GBN'		Param=CodeValue</C>
			<C>Col='CHANGE_DEC'			Ctrl='txtCHANGE_DEC'		Param=value</C>
			<C>Col='CHANGE_TIME'		Ctrl='rdoCHANGE_TIME'		Param=CodeValue</C>
			<C>Col='HOPE_DEP1'			Ctrl='txtHOPE_DEP1'			Param=value</C>
			<C>Col='HOPE_DEP1NM'		Ctrl='txtHOPE_DEP1NM'		Param=value</C>
			<C>Col='HOPE_DEP2'			Ctrl='txtHOPE_DEP2'			Param=value</C>
			<C>Col='HOPE_DEP2NM'		Ctrl='txtHOPE_DEP2NM'		Param=value</C>
			<C>Col='HOPE_DEP3'			Ctrl='txtHOPE_DEP3'			Param=value</C>
			<C>Col='HOPE_DEP3NM'		Ctrl='txtHOPE_DEP3NM'		Param=value</C>
			<C>Col='NOCHANGE_GBN'		Ctrl='rdoNOCHANGE_GBN'		Param=CodeValue</C>
			<C>Col='NOCHANGE_DEC'		Ctrl='txtNOCHANGE_DEC'		Param=value</C>
	    ">
	</object>
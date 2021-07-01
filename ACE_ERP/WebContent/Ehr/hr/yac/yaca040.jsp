<!--
***********************************************************************
* @source      : yaca040.jsp
* @description : 기부금공제내역입력 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");

     String ENO_NO       = request.getParameter("ENO_NO");
     String ENO_NM       = request.getParameter("ENO_NM");
     String DPT_NM       = request.getParameter("DPT_NM");
     String JOB_NM       = request.getParameter("JOB_NM");

     if(ENO_NO == null){
	      ENO_NO       = box.getString("SESSION_ENONO");
	      ENO_NM       = box.getString("SESSION_ENONM");
	      DPT_NM       = box.getString("SESSION_DPTNM");
	      JOB_NM       = box.getString("SESSION_JOBNM");
     }

   //ROLE_CD가 IT인지 여부
     boolean itMaster = false;

     if(ROLE_CD.equals("1001") ) {
     itMaster = true;
     }

   //관리자인지 아닌지 여부
     boolean isMaster = false;

     if(YAC_AUTHO.equals("M")) {
     isMaster = true;
     }

    // 강제 권한
   //boolean open_yn = false;

   //if(ENO_NO.equals("19511030")) {
   //   open_yn = true;
  //  }
%>

<html>
<head>
	<title>기부금공제내역입력(yaca040)</title>
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

		var today = getToday();
		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTTTTT';
        //넘어온 변수값 처리
        var submit = "<%=request.getParameter("END_YN") %>";		

	 	/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_DONATION.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_DONATION.reset();
            document.form1.print_flag.value = "Y";
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem(row) {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

           
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			//전체가 넘어가게 해야함
            dsT_AC_DONATION.UseChangeInfo = "false";
            			
			// save
			trT_AC_DONATION.KeyValue = "tr01(I:dsT_AC_DONATION=dsT_AC_DONATION)";
			trT_AC_DONATION.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SAV";
			trT_AC_DONATION.post();

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	// 근태변경신청서 삭제

			if (dsT_AC_DONATION.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }

           	var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            tmpMSG += "사업자등록번호 = "+dsT_AC_DONATION.nameValue(dsT_AC_DONATION.RowPosition, "COM_NO")+"\n";
            tmpMSG += "상호(법인명)       = "+dsT_AC_DONATION.nameValue(dsT_AC_DONATION.RowPosition, "COM_NM")+"\n";

	        if( confirm(tmpMSG) ){
			    var status = dsT_AC_DONATION.RowStatus(dsT_AC_DONATION.RowPosition);
				dsT_AC_DONATION.DeleteRow(dsT_AC_DONATION.RowPosition);
			    if(status != 1){
                    trT_AC_DONATION.KeyValue = "tr01(I:dsT_AC_DONATION=dsT_AC_DONATION)";
                    trT_AC_DONATION.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=DEL";
                    trT_AC_DONATION.post();
                }
			}

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            if ( document.form1.print_flag.value == "Y" ) {
            	
                var pis_yy   = document.form1.txtPIS_YY_SHR.value;
                var eno_no  = document.form1.txtENO_NO_SHR.value;

                var url = "yaca040_PV.jsp?pis_yy="+pis_yy+"&eno_no="+eno_no;
                
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
                
            } else {
                alert("조회후 인쇄가능합니다.");
            }

            
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_DONATION.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_DONATION.GridToExcel("기부금공제내역입력", '', 225);
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_AC_DONATION.CountColumn < 1) {
            	
                //dsT_AC_DONATION.setDataHeader("PIS_YY:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, PIS_YM:STRING, COM_NO:STRING:KEYVALUETYPE, REMARK:STRING, COM_NM:STRING:KEYVALUETYPE, TOT_CNT:NUMBER, SUM_AMT:NUMBER, SEQ_NO:STRING:KEYVALUETYPE");
                
                alert("반드시 조회후 입력이 가능합니다.");
                
                return false;
                
            }

            dsT_AC_DONATION.AddRow();
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;

            fnc_enableInput();

            document.getElementById("cmbREL_CD").focus();

            fnc_GetFamNm();

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

            //document.form1.txtPIS_YY_SHR.value = today.substring(0,4);
			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';

        	dsT_AC_DONATION.ClearData();
            //fnc_disableInput();

            document.getElementById("resultMessage").innerText = ' ';
            document.form1.print_flag.value = "N";
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_DONATION.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();
			//frame = window.external.GetFrame(window);

			//frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요
            var rel_val = document.getElementById("cmbREL_CD1").value;


        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {


			
	        var bizNo = document.getElementById("txtCOM_NO").value;

         	if ( !dsT_AC_DONATION.isUpdated ) {
	         	alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}


         	
			//주민번호 사업자번호 체크
			for(i=0;i<dsT_AC_DONATION.CountRow;i++){
			    //alert(i+"->"+dsT_AC_MEDICAL.RowLevel(i+1));
			    if(dsT_AC_DONATION.RowLevel(i+1) !="9999"){
	                if(dsT_AC_DONATION.NameValue(i+1,"REL_CD") == '') {
	                    alert("기부유형은 필수 입력 항목입니다.");
	                    form1.cmbREL_CD.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '20') { // 20 : 정치자금의 경우 사업자번호 입력안함

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NO") == '') {
		                    alert("사업자번호는 필수 입력 항목입니다.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "").length != 10) {
		                    alert("사업자번호가 잘못되었습니다.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

			            bizNo = dsT_AC_DONATION.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "");

			            if(bizNo_validate(bizNo) == false){
			            	alert("유효하지 않은 사업자번호입니다.");
			            	return false;
			            }


		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NM") == '') {
		                    alert("상호(법인명)는 필수 입력 항목입니다.");
		                    form1.txtCOM_NM.focus();
		                    return false;
		                }
	                }else {

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NO") == ''){
		                	dsT_AC_DONATION.NameValue(i+1,"COM_NO") = ' ';
		                }

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NM") == ''){
		                	dsT_AC_DONATION.NameValue(i+1,"COM_NM") = ' ';
		                }
	                }

	            /*  if(dsT_AC_DONATION.NameValue(i+1,"SEQ_NO") == '') {
	                    alert("기부금영수증일련번호는 필수 입력 항목입니다.");
	                    form1.txtSEQ_NO.focus();
	                    return false;
	                } */

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_NO") == '') {
	                    alert("주민등록번호는 필수 입력 항목입니다.");
	                    //form1.txtFAM_NO.focus();
	                    return false;
	                }

	                 if(dsT_AC_DONATION.NameValue(i+1,"FAM_NO").replace("-", "").length != 13) {
	                    alert("주민등록번호가 잘못되었습니다.");
	                    //form1.txtFAM_NO.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_CD") == '') {
	                    alert("관계는 필수 선택 항목입니다.");
	                    form1.cmbFAM_CD.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_NM") == '') {
	                    alert("성명은 필수 선택 항목입니다.");
	                    form1.cmbFAM_NM.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"NTS_YN") == '') {
	                    alert("출처는 필수 선택 항목입니다.");
	                    form1.cmbNTS_YN.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"NTS_YN") == '1' && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '10'
	                && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '20' 
	                && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '40' && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '41'){
	                	alert("해당 기부유형의 출처는 국세청자료가 허용되지 않습니다. 확인바랍니다.");
	                	form1.cmbNTS_YN.focus();
	                	return false;

	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_CD") != '1' && (dsT_AC_DONATION.NameValue(i+1,"REL_CD") == '42'
	                || dsT_AC_DONATION.NameValue(i+1,"REL_CD") == '20')){
	                	alert("해당 기부유형은 본인만 공제 가능합니다. 확인바랍니다.");
	                	form1.cmbFAM_NM.focus();
	                	return false;

	                }
                }
			}

			return true;

        }

        /* 사업자번호 유효성 체크 */
        function bizNo_validate(value){
        	var sumMod = 0;
        	sumMod += parseInt(value.substring(0,1));
        	sumMod += parseInt(value.substring(1,2)) * 3 % 10;
        	sumMod += parseInt(value.substring(2,3)) * 7 % 10;
        	sumMod += parseInt(value.substring(3,4)) * 1 % 10;
        	sumMod += parseInt(value.substring(4,5)) * 3 % 10;
        	sumMod += parseInt(value.substring(5,6)) * 7 % 10;
        	sumMod += parseInt(value.substring(6,7)) * 1 % 10;
        	sumMod += parseInt(value.substring(7,8)) * 3 % 10;
        	sumMod += Math.floor(parseInt(value.substring(8,9)) * 5/10);
        	sumMod += parseInt(value.substring(8,9)) * 5 % 10;
	        sumMod += parseInt(value.substring(9,10));

	        if(sumMod % 10 != 0){
	        	return false;
        	}

        	return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
<%
    //관리자가 아닐 경우 타인은 조회가 되지 않게
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "imgEnoNo");
            document.getElementById("imgEnoNo").style.display = "none";
           // document.getElementById("imgPrint").style.display = "none";
<%
    }
%>

			var pis_yy   = '2012';
			var eno_no  =  document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
			dsT_AC_FAMILY.clearData();
			dsT_AC_FAMILY.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SHR_05&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_FAMILY.reset();

			//가족성명
			for( var i = 1; i <=  dsT_AC_FAMILY.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                oOption.text  = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                document.getElementById("cmbFAM_NM").add(oOption);

			}

            //기부유형
            for( var i = 1; i <= dsT_CM_COMMON_FB.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FB.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FB.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FB.NameValue(i,"CODE_NAME");
                document.getElementById("cmbREL_CD").add(oOption);

            }

            //관계구분
            for( var i = 1; i <= dsT_CM_COMMON_FD.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FD.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FD.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FD.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFAM_CD").add(oOption);

            }

			//document.form1.txtPIS_YY_SHR.value = today.substring(0,4);
		    if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            }

            document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
	        document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
	        document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
	        document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';

			cfStyleGrid(form1.grdT_AC_DONATION,15,"false","false");      // Grid Style 적용

            fnc_disableInput();

            fnc_SearchList();

		    if(submit=='Y' )
            {
        		fnc_disableInput2();
                return;
            }
            

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. 입력필드 사용 가능하게(Enable)       *
         ********************************************/
  		function fnc_enableInput(){

            document.getElementById("txtTOT_CNT").className = "";
	  		document.getElementById("txtTOT_CNT").readOnly = false;
	  		form1.medSUM_AMT.Enable = "true";
            document.getElementById("txtCOM_NO").className = "";
	  		document.getElementById("txtCOM_NO").readOnly = false;
            document.getElementById("txtREMARK").className = "";
	  		document.getElementById("txtREMARK").readOnly = false;
            document.getElementById("txtCOM_NM").className = "";
	  		document.getElementById("txtCOM_NM").readOnly = false;
            //document.getElementById("txtSEQ_NO").className = "";
	  		//document.getElementById("txtSEQ_NO").readOnly = false;
            //document.getElementById("txtPIS_YM").className = "";
	  		//document.getElementById("txtPIS_YM").readOnly = false;
	  		document.getElementById("cmbREL_CD").disabled = false;

	//  		document.getElementById("cmbFAM_CD").disabled = false;
	//  	    document.getElementById("cmbFAM_NM").className = "";
	  		document.getElementById("cmbFAM_NM").disabled = false;
    		document.getElementById("txtFAM_NO").className = "";
	//  		document.getElementById("txtFAM_NO").disabled = false;
			document.getElementById("cmbNTS_YN").disabled = false;

  		}

        /********************************************
         * 17. 입력필드 사용 불가능하게(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

  			//document.getElementById("txtTOT_CNT").className = "input_ReadOnly";
	  		//document.getElementById("txtTOT_CNT").readOnly = true;
            //form1.medSUM_AMT.Enable = "false";
            //document.getElementById("txtCOM_NO").className = "input_ReadOnly";
	  		//document.getElementById("txtCOM_NO").readOnly = true;
            //document.getElementById("txtREMARK").className = "input_ReadOnly";
	  		//document.getElementById("txtREMARK").readOnly = true;
            //document.getElementById("txtCOM_NM").className = "input_ReadOnly";
	  		//document.getElementById("txtCOM_NM").readOnly = true;


	  		//document.getElementById("txtSEQ_NO").className = "input_ReadOnly";
	  		//document.getElementById("txtSEQ_NO").readOnly = true;
            //document.getElementById("txtPIS_YM").className = "input_ReadOnly";
	  		//document.getElementById("txtPIS_YM").readOnly = true;
	  		//document.getElementById("cmbREL_CD").disabled = true;
	  		document.getElementById("cmbFAM_CD").disabled = true;
	  		document.getElementById("cmbFAM_NM").className = "input_ReadOnly";
	  		document.getElementById("cmbFAM_NM").disabled = true;
	  		document.getElementById("txtFAM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtFAM_NO").disabled = true;
	  		//document.getElementById("cmbNTS_YN").disabled = true;

  		}

  		function fnc_disableInput2(){

  			document.getElementById("txtTOT_CNT").className = "input_ReadOnly";
	  		document.getElementById("txtTOT_CNT").readOnly = true;
            form1.medSUM_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NO").readOnly = true;
            document.getElementById("txtREMARK").className = "input_ReadOnly";
	  		document.getElementById("txtREMARK").readOnly = true;
            document.getElementById("txtCOM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NM").readOnly = true;
	  		document.getElementById("cmbREL_CD").disabled = true;
	  		document.getElementById("cmbFAM_CD").disabled = true;
	  		document.getElementById("cmbFAM_NM").className = "input_ReadOnly";
	  		document.getElementById("cmbFAM_NM").disabled = true;
	  		document.getElementById("txtFAM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtFAM_NO").disabled = true;
	  		document.getElementById("cmbNTS_YN").disabled = true;

            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAddnew");
            fnc_HiddenElement("imgDelete");  
	  		
  		}

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
        }

        function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

        }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }


		// 기부금 대상자(본인 or 부양가족) 조회
        function fnc_GetFamNm() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_FAMILY.clearData();
			dsT_AC_FAMILY.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SHR_05&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_FAMILY.reset();

			document.getElementById("cmbFAM_NM").options.length = 0;

			//alert(document.getElementById("cmbFAM_NM").value);

			//관계구분
			oOption       = document.createElement("OPTION");
			oOption.value = "";
            oOption.text  = "";
            document.getElementById("cmbFAM_NM").add(oOption);

            for( var i = 1; i < dsT_AC_FAMILY.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                oOption.text  = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                document.getElementById("cmbFAM_NM").add(oOption);

            }
        }

        function setFamNo(){


            document.getElementById("cmbFAM_CD").value = dsT_AC_FAMILY.NameValue(document.getElementById("cmbFAM_NM").selectedIndex,"FAM_CD");
            document.getElementById("cmbFAM_CD").disabled = true;

            document.getElementById("txtFAM_NO").value = dsT_AC_FAMILY.NameValue(document.getElementById("cmbFAM_NM").selectedIndex,"FAM_NO");
            document.getElementById("txtFAM_NO").disabled = true;


        }

        function fnc_UpdateAcc(){

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_DONATION2.UseChangeInfo = false;

			dsT_AC_DONATION2.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=ACC&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_DONATION2.reset();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_DONATION)		   |
    | 3. 사용되는 Table List(T_AC_DONATION) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_DONATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_AC_DONATION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
	</Object>

	<Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
	</Object>



	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 관계구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FD"/>
       <jsp:param name="CODE_GUBUN"    value="FD"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 기부유형 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FB"/>
       <jsp:param name="CODE_GUBUN"    value="FB"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_DONATION)		   |
    | 3. 사용되는 Table List(T_AC_DONATION)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_DONATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AC_DONATION=dsT_AC_DONATION,I:dsT_AC_DONATION=dsT_AC_DONATION)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_DONATION Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			//alert("검색하신 조건의 자료가 없습니다!");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}else{
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount-1);
        }
    </Script>


	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_AC_DONATION Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)      
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_DONATION Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //prompt(this,dsT_AC_DONATION.text);        
        //Dataset관련 Error 처리
	    if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기부유형/사업자등록번호]\n입력 후 다음 작업이 가능합니다.");
        }
        //else if (this.ErrorCode == 50019) {
	    //    alert("[기부유형/사업자등록번호]에 대한 중복값이 존재합니다. 확인바랍니다.");
        //}
        else {        

		    cfErrorMsg(this);
	    }
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_AC_DONATION event="OnSuccess()">
		fnc_UpdateAcc();
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_DONATION event="OnFail()">

        cfErrorMsg(this);
    </script>

    <script language=JavaScript for=dsT_AC_DONATION event=OnRowPosChanged(row)>

        //if(dsT_AC_DONATION.RowStatus(row) == 1){
        //    fnc_enableInput();
        //}else{
        //    fnc_disableInput();
        //}

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기부금공제내역입력</td>
					<td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">기부금공제내역입력</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="imgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>

	<!-- power Search테이블 시작 -->
	<table width="600px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="70"></col>
                            <col width="40"></col>
                            <col width="50"></col>
                            <col width="150"></col>
                            <col width="50"></col>
                            <col width="80"></col>
                            <col width="50"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
                            <td class="searchState" align="right">귀속년도&nbsp;</td>
							<td class="padding2423">
<%
  if(!isMaster) {
%>
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>
<%
  }else{
%>
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4">
<%
  }
%>
							</td>
                            <td align="right" class="searchState">사번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
                                <img src="/images/button/btn_HelpOn.gif" id="imgEnoNo" name="imgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                <input type="hidden" id="hidEMPL_DPT_CD">
                            </td>
                            <td class="searchState" align="right">소속&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">직위&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="6" class="input_ReadOnly" readonly>
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

	<!-- 조건 입력 테이블 시작 -->
	<table width="600px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="100"></col>
                        <col width="100"></col>
                        <col width="80"></col>
                        <col width="100"></col>
                        <col width="100"></col>                        
                        <col width=""></col>
                    </colgroup>
                    
                    <tr>
                        <td align="center" class="creamBold">성명</td>
                        <td class="padding2423">
                             <select id="cmbFAM_NM" style="width=100%" onChange="setFamNo();">
                             </select>
                        </td>
                        <td align="center" class="creamBold">관계</td>
                        <td class="padding2423">
                            <select id="cmbFAM_CD" style="width=100%">
                            </select>
                        </td>
                        <td align="center" class="creamBold">주민등록번호</td>
                        <td class="padding2423" colspan="2">
                             <input id="txtFAM_NO" style="width=100%;ime-mode:disabled;" maxLength="14" onKeypress="cfNumberCheck();" onKeyUp="cfCetNoHyphen(this);">
                        </td>
                      </tr>                    
                    <tr>
                        <td align="center" class="creamBold">출처</td>
						<td class="padding2423" align="left">
								<select id="cmbNTS_YN" style="width:100%;">
									<option value=""></option>
									<option value="1">국세청자료</option>
									<option value="2">그밖의자료</option>
								</select>
						</td>                    
                        <td align="center" class="creamBold">기부유형</td>
                        <td class="padding2423"  colspan="4">
                            <select id="cmbREL_CD" style="width=100%">
                            </select>
                        </td>
                       </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                    <colgroup>
                        <col width="100"></col>
                        <col width="181"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">상호(법인명)</td>
                        <td class="padding2423" >
                            <input id="txtCOM_NM" style="width=100%" maxLength="60" onKeyUp="fc_chk_byte(this,60)">
                        </td>
                        <td align="center" class="creamBold">사업자등록번호</td>
                        <td class="padding2423">
                            <input id="txtCOM_NO" maxlength="12" style="width=100%;ime-mode:disabled" onKeypress="javascript:cfNumberCheck();" onkeyup="cfComNoHyphen(this);">
                        </td>
                       <!--  <td align="center" class="creamBold">기부금영수증일련번호</td>
                        <td class="padding2423">
                            <input id="txtSEQ_NO" style="width=100%" maxLength="20">
                        </td> -->
                    </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="100"></col>
                        <col width="181"></col>
                        <col width="100"></col>
                        <col width="30"></col>
                        <col width="80"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <!-- <td align="center" class="creamBold">기부년월</td>
						<td class="padding2423">
							<input id="txtPIS_YM"  style="ime-mode:disabled" style="width:65%" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtPIS_YM.readOnly == true) return; calendarBtn('datetype2','txtPIS_YM','','0','190');"></a>
						</td>
						-->
                        <td align="center" class="creamBold">기부내용</td>
                        <td class="padding2423">
                            <input id="txtREMARK" style="width=100%" maxLength="50" onKeyUp="fc_chk_byte(this,50)">
                        </td>            						
						
                        <td align="center" class="creamBold">기부건수</td>
                        <td class="padding2423">
                        <input id="txtTOT_CNT" maxlength="3" style="width=100%;ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();"></td>
                        <td align="center" class="creamBold">기부금합계</td>
                        <td class="padding2423">
                            <comment id="__NSID__">
                            <object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
	</td>
	<td valign="top">
        <table width="190px" height="105" border="1" cellspacing="0" cellpadding="0">
            <tr>
                <td class="searchState" valign="center">
                    <br>
	                &nbsp;-기부처, 기부유형별 합산
	                &nbsp;&nbsp;금액과 건수를 입력하시기
	                &nbsp;&nbsp;바랍니다.
                    <br>&nbsp;
	                <br>&nbsp;
                    <br>&nbsp;    
                    <br>&nbsp;     
                    <br>&nbsp;    
                    <br>&nbsp;                       
                </td>
            </tr>
        </table>
	</td>
</tr>
</table>

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState" width="280"><span id="resultMessage">&nbsp;</span></td>
                        <td align="left" class="searchState">
                            <!--※10만원 이하의 정치자금 기부금은 입력하지 않으셔도 됩니다.<BR>-->
			                            ※정치자금 기부금은 기부처에 관계없이 전체금액을 합산하여 1건으로 입력바랍니다.<BR>
			                            ※정치자금 기부금은 상호와 사업자등록번호를 적지 아니합니다.<BR>
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
					<object id="grdT_AC_DONATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
						<param name="DataID" 						value="dsT_AC_DONATION">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"			value=1>							
						<param name="Format" 						value='
							<C> id={currow}			width=34    name="NO"		                	align=center  SumBgColor=#C3D0DB  SumText="합계"</C>
				    	<G> name="기부자" align=center HeadBgColor="#F7DCBB"
							<C> id="FAM_CD"     	width=90    name="관계"                     	align=left     EditStyle=Lookup Data="dsT_CM_COMMON_FD:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
							<C> id="FAM_NM"     	width=65    name="성명"                     	align=center  SumBgColor=#C3D0DB </C>
                            <C> id="FAM_NO"     	width=90    name="대상자주민번호"           align=center  SumBgColor=#C3D0DB </C>
						</G>
                            <C> id="REL_CD"			width=100	name="기부유형"		            align=left      EditStyle=Lookup Data="dsT_CM_COMMON_FB:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="REMARK"     		width=80    name="기부내용"                 	align=left       SumBgColor=#C3D0DB </C> 
                            <C> id="COM_NM"		width=100	name="상호(법인명)"		    	align=left	   SumBgColor=#C3D0DB </C>
                            <C> id="COM_NO"     	width=90    name="사업자등록번호"          	align=center   SumBgColor=#C3D0DB </C>
                          	<C> id="TOT_CNT"		width=30	name="건수"                     	align=right	   RightMargin="10" SumBgColor=#C3D0DB SumText=@sum</C>
							<C> id="SUM_AMT"		width=80	name="기부금합계"	            	align=right	   RightMargin="10" SumBgColor=#C3D0DB SumText=@sum</C>
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

	<input type="hidden" name="print_flag" value="N">
	</form>
	<!-- form 끝 -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_DONATION 설정 테이블 -->
	<object id="bndT_AC_DONATION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_DONATION">
		<Param Name="BindInfo", Value="
			<C>Col=TOT_CNT		Ctrl=txtTOT_CNT		Param=value </C>
            <C>Col=SUM_AMT	Ctrl=medSUM_AMT	Param=text  </C>
            <C>Col=COM_NO		Ctrl=txtCOM_NO		Param=value </C>
            <C>Col=COM_NM		Ctrl=txtCOM_NM		Param=value </C>
            <C>Col=REMARK		Ctrl=txtREMARK		Param=value </C>
            <C>Col=REL_CD		Ctrl=cmbREL_CD		Param=value </C>       
            <C>Col=FAM_CD		Ctrl=cmbFAM_CD		Param=value </C>
            <C>Col=FAM_NM		Ctrl=cmbFAM_NM		Param=value </C>
            <C>Col=FAM_NO		Ctrl=txtFAM_NO		Param=value </C>
            <C>Col=NTS_YN		Ctrl=cmbNTS_YN		Param=value </C>
		">
	</object>

<!--
***********************************************************************
* @source      : yaca030.jsp
* @description : 의료비공제내역입력 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      오대성        최초작성.
* 2007/04/10      김학수        인쇄부분 추가.
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

     if(ROLE_CD.equals("1001")) {
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
	<title>의료비공제내역입력(yaca030)</title>
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
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        //넘어온 변수값 처리
        var submit = "<%=request.getParameter("END_YN") %>";
        
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_MEDICAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_MEDICAL.reset();

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
            dsT_AC_MEDICAL.UseChangeInfo = "false";

			// save
			trT_AC_MEDICAL.KeyValue = "tr01(I:dsT_AC_MEDICAL=dsT_AC_MEDICAL)";
			trT_AC_MEDICAL.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=SAV";
			trT_AC_MEDICAL.post();

			dsT_AC_MEDICAL.UseChangeInfo = "true";

			fnc_UpdateAcc();

        }

        function fnc_UpdateAcc(){

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_MEDICAL2.UseChangeInfo = false;

			dsT_AC_MEDICAL2.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=ACC&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_MEDICAL2.reset();
        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	// 근태변경신청서 삭제

			if (dsT_AC_MEDICAL.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }

           	var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            tmpMSG += "사업자등록번호 = "+dsT_AC_MEDICAL.nameValue(dsT_AC_MEDICAL.RowPosition, "COM_NO")+"\n";
            tmpMSG += "진료기관       = "+dsT_AC_MEDICAL.nameValue(dsT_AC_MEDICAL.RowPosition, "COM_NM")+"\n";

	        if( confirm(tmpMSG) ){
			    var status = dsT_AC_MEDICAL.RowStatus(dsT_AC_MEDICAL.RowPosition);
				dsT_AC_MEDICAL.DeleteRow(dsT_AC_MEDICAL.RowPosition);
			    if(status != 1){
                    trT_AC_MEDICAL.KeyValue = "tr01(I:dsT_AC_MEDICAL=dsT_AC_MEDICAL)";
                    trT_AC_MEDICAL.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=DEL";
                    trT_AC_MEDICAL.post();
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
                var eno_nm  = document.form1.txtENO_NM_SHR.value;


                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var s_year  = String(year);
                var s_month = String(month);
                var s_day = String(day);
                var today_val = s_year + "년  " + s_month + "월  " + s_day + "일"

                var url = "yaca030_PV.jsp?pis_yy="+pis_yy+"&eno_no="+eno_no+"&eno_nm="+eno_nm+"&today_val="+today_val;
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            } else {
                alert("조회후 인쇄가능합니다.");
            }
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_AC_MEDICAL.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AC_MEDICAL.GridToExcel("의료비공제내역입력", '', 225);

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_AC_MEDICAL.CountColumn < 1) {
                //dsT_AC_MEDICAL.setDataHeader("PIS_YY:STRING, ENO_NO:STRING, CARD_CNT:NUMBER, CASH_CNT:NUMBER, CARD_AMT:NUMBER, CASH_AMT:NUMBER, SUM_AMT:NUMBER, COM_NO:STRING:NOTNULL, COM_NM:STRING:NOTNULL, REL_CD:STRING, CET_NO:STRING, GBN_TAG:STRING");
                alert("반드시 조회후 입력이 가능합니다.");
                return false;
            }

            dsT_AC_MEDICAL.AddRow();
            dsT_AC_MEDICAL.NameValue(dsT_AC_MEDICAL.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_MEDICAL.NameValue(dsT_AC_MEDICAL.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;

            fnc_enableInput();

            document.getElementById("txtCARD_CNT").value = "";
            //document.getElementById("txtCASH_CNT").value = "";

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
			document.form1.txtENO_NO_SHR.value = '<%= box.get("SESSION_ENONO")%>';
            document.form1.txtENO_NM_SHR.value = '<%= box.get("SESSION_ENONM")%>';
            document.form1.txtDPT_NM_SHR.value = '<%= box.get("SESSION_DPTNM")%>';
            document.form1.txtJOB_NM_SHR.value = '<%= box.get("SESSION_JOBNM")%>';

        	dsT_AC_MEDICAL.ClearData();
            fnc_disableInput();

            document.getElementById("resultMessage").innerText = ' ';
            document.form1.print_flag.value = "N";
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_MEDICAL.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			//frame = window.external.GetFrame(window);

			//frame.CloseFrame();


			window.close();

			
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /* 주민번호 유효성 체크 */
        function Juminchk(str) {

			 var num = new Array(13);

			 var digit = new Array(12);
			 var sum = 0;
			 var i=0, j=0;

			 digit[1] = 2;
			 digit[2] = 3;
			 digit[3] = 4;
			 digit[4] = 5;
			 digit[5] = 6;
			 digit[6] = 7;
			 digit[7] = 8;
			 digit[8] = 9;
			 digit[9] = 2;
			 digit[10] = 3;
			 digit[11] = 4;
			 digit[12] = 5;

			 //사람이 입력한 주민등록 번호를 배열에 넣는다
			 for(j=1; j<=13; j++) {
			  	num[j] = parseInt(str.charAt(j-1),10)
			 } // for
			 //check_digit와 번호를 연산한다
			 for(i=1; i<=12; i++) {
			  	sum += digit[i] * num[i];
			 } // for

			 var div = (sum%11);
			 if(div == 1) {
			  	comp = 0;
			 } else if(div == 0) {
			  	comp = 1;
			 } else if((div != 0)&&(div != 1)) {
			  	comp = 11 - div;
			 } // else if

			 if(div == 0) {
			  	  if(num[13] == 1) return true;
			  	  else return false;
			 } else if(div == 1) {
				  if(num[13] == 0) return true;
				  else return false;
			 } else if((11-div) == num[13]) {

			  	  return true;
			 } else {

			  	  return false;
			 }

		}


		function fnRRNCheck(rrn) // 유효성검사. 사용법fnRRNCheck("8201011234567");
 		{
			if (fnrrnCheck(rrn) || fnfgnCheck(rrn)) {
		         return true;
     		}

     		return false;

 		}

	 function fnrrnCheck(rrn) // 주민등록번호유효성검사.
	 {
	     var sum = 0;

	     if (rrn.length != 13) {
	         return false;
	    }
	    else if (rrn.substr(6, 1) != 1 && rrn.substr(6, 1) != 2 && rrn.substr(6, 1) != 3 && rrn.substr(6, 1) != 4) {
		     return false;
	    }

	     for (var i = 0; i < 12; i++) {
	         sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
	     }

	     if (((11 - (sum % 11)) % 10) == Number(rrn.substr(12, 1))) {
	         return true;
	     }

	     return false;
	 }

	function fnfgnCheck(rrn) // 외국인등록번호유효성검사.
	{
		var sum = 0;

	     if (rrn.length != 13) {
	         return false;
	     }
	     else if (rrn.substr(6, 1) != 5 && rrn.substr(6, 1) != 6 && rrn.substr(6, 1) != 7 && rrn.substr(6, 1) != 8) {
	         return false;
	     }

	     if (Number(rrn.substr(7, 2)) % 2 != 0) {
	         return false;
	     }

	     for (var i = 0; i < 12; i++) {
	         sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
	     }

	     if ((((11 - (sum % 11)) % 10 + 2) % 10) == Number(rrn.substr(12, 1))) {
	         return true;
	     }

	     return false;
	 }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

        	var bizNo = document.getElementById("txtCOM_NO").value;
        	var juminno = document.getElementById("txtCET_NO").value;

         	if ( !dsT_AC_MEDICAL.isUpdated ) {
	         	alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

			//주민번호 사업자번호 체크
			for(i=0;i<dsT_AC_MEDICAL.CountRow;i++){


			    if(dsT_AC_MEDICAL.RowLevel(i+1) !="9999"){

			    	if(dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == '1') {


		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") == '') {
		                    alert("주민등록번호는 필수 입력 항목입니다.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "").length != 13) {
		                    alert("주민등록번호가 잘못되었습니다.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                juminno = dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "");

			            /*if(Juminchk(juminno) == false){
			            	alert("유효하지 않은 주민번호입니다.");
			            	return false;
			            }*/

			            if(fnRRNCheck(juminno) == false){
			            	alert("유효하지 않은 주민번호입니다.");
			            	return false;
			            }

						var cnt = 0;

			            // 의료비 국세청자료는 공제대상자별로 합산하여 기입
						// 공제대상자별로 한건만 입력할 수 있도록 체크
			            for(j=0;j<dsT_AC_MEDICAL.CountRow;j++){

			            	if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") == dsT_AC_MEDICAL.NameValue(j+1,"CET_NO")
			            	&& dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == dsT_AC_MEDICAL.NameValue(j+1,"MED_CD") ) {

			            		cnt++;

			            		if(cnt > 1) {
			            			alert("주민등록번호: " + dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") + "\n해당 대상자의 국세청 의료비자료가 이미 등록되어 있습니다.\n국세청 의료비자료는 공제대상자별로 합산하여 입력해 주세요." );
			            			return false;
			            		}
			            	}
			            }


		                if(dsT_AC_MEDICAL.NameValue(i+1,"REL_CD") == '') {
		                    alert("대상자 관계는 필수 입력 항목입니다.");
		                    form1.cmbREL_CD.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == '') {
		                    alert("의료증빙코드는 필수 입력 항목입니다.");
		                    form1.cmbMED_CD.focus();
		                    return false;
		                }

			    	}
			    	else
			    	{
		                if(dsT_AC_MEDICAL.NameValue(i+1,"COM_NO") == '') {
		                    alert("사업자번호는 필수 입력 항목입니다.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "").length != 10) {
		                    alert("사업자번호가 잘못되었습니다.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

		                bizNo = dsT_AC_MEDICAL.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "");

			            if(bizNo_validate(bizNo) == false){
			            	alert("유효하지 않은 사업자번호입니다.");
			            	return false;
			            }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") == '') {
		                    alert("주민등록번호는 필수 입력 항목입니다.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "").length != 13) {
		                    alert("주민등록번호가 잘못되었습니다.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                juminno = dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "");

			            if(Juminchk(juminno) == false){
			            	alert("유효하지 않은 주민번호입니다.");
			            	return false;
			            }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"REL_CD") == '') {
		                    alert("대상자 관계는 필수 입력 항목입니다.");
		                    form1.cmbREL_CD.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == '') {
		                    alert("의료증빙코드는 필수 입력 항목입니다.");
		                    form1.cmbMED_CD.focus();
		                    return false;
		                }
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
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";
			//document.getElementById("imgPrint").style.display = "none";

<%
    }
%>


            //관계구분
            for( var i = 1; i <= dsT_CM_COMMON_FA.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FA.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FA.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FA.NameValue(i,"CODE_NAME");
                document.getElementById("cmbREL_CD").add(oOption);

            }

            //의료증빙코드 구분
            for( var i = 1; i <= dsT_CM_COMMON_FC.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FC.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FC.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FC.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMED_CD").add(oOption);

            }

			//document.form1.txtPIS_YY_SHR.value = today.substring(0,4);
		   if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value =  today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            }

			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';

			cfStyleGrid(form1.grdT_AC_MEDICAL,15,"false","false");      // Grid Style 적용

            //fnc_disableInput();

            fnc_SearchList();

		    if(submit=='Y' )
            {
        		fnc_disableInput();
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

            document.getElementById("txtCARD_CNT").className = "";
	  		document.getElementById("txtCARD_CNT").readOnly = false;
            //document.getElementById("txtCASH_CNT").className = "";
	  		//document.getElementById("txtCASH_CNT").readOnly = false;
	  		form1.medCARD_AMT.Enable = "true";
            //form1.medCASH_AMT.Enable = "true";
            //form1.medSUM_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "";
	  		document.getElementById("txtCOM_NO").readOnly = false;
            document.getElementById("txtCOM_NM").className = "";
	  		document.getElementById("txtCOM_NM").readOnly = false;
            document.getElementById("txtCET_NO").className = "";
	  		document.getElementById("txtCET_NO").readOnly = false;
	  		document.getElementById("cmbREL_CD").disabled = false;
	  		document.getElementById("cmbMED_CD").disabled = false;
            document.getElementById("cmbGBN_TAG").disabled = false;

  		}

        /********************************************
         * 17. 입력필드 사용 불가능하게(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

  			document.getElementById("txtCARD_CNT").className = "input_ReadOnly";
	  		document.getElementById("txtCARD_CNT").readOnly = true;
	  		form1.medCARD_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NO").readOnly = true;
            document.getElementById("txtCOM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NM").readOnly = true;
            document.getElementById("txtCET_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCET_NO").readOnly = true;
	  		document.getElementById("cmbREL_CD").disabled = true;
	  		document.getElementById("cmbMED_CD").disabled = true;
            document.getElementById("cmbGBN_TAG").disabled = true;

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

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_MEDICAL)		   |
    | 3. 사용되는 Table List(T_AC_MEDICAL) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_MEDICAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_AC_MEDICAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
        <Param Name="SubsumExpr" 	  		Value="total">
	</Object>

	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 관계구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FA"/>
       <jsp:param name="CODE_GUBUN"    value="FA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 의료증빙코드 구분 -->
    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FC"/>
       <jsp:param name="CODE_GUBUN"    value="FC"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_MEDICAL)		   |
    | 3. 사용되는 Table List(T_AC_MEDICAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_MEDICAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AC_MEDICAL=dsT_AC_MEDICAL,I:dsT_AC_MEDICAL=dsT_AC_MEDICAL)">
	</Object>



	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_MEDICAL Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_AC_MEDICAL Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_MEDICAL Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
	    if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사업자등록번호/진료기관]\n입력 후 다음 작업이 가능합니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_AC_MEDICAL event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_MEDICAL event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script language=JavaScript for=dsT_AC_MEDICAL event=OnRowPosChanged(row)>

        //if(dsT_AC_MEDICAL.RowStatus(row) == 1){
        //    fnc_enableInput();
        //}else{
        //    fnc_disableInput();
        //}

	</script>

<!-- <script language=JavaScript for=medCARD_AMT event=onKillFocus()>

        form1.medSUM_AMT.Text = Number(form1.medCARD_AMT.Text) + Number(form1.medCASH_AMT.Text);

      </script>

	<script language=JavaScript for=medCASH_AMT event=onKillFocus()>

        form1.medSUM_AMT.Text = Number(form1.medCARD_AMT.Text) + Number(form1.medCASH_AMT.Text);

    </script> -->


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">의료비공제내역입력</td>
					<td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">의료비공제내역입력</font></td>
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
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
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
                                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
                        <col width="55"></col>
                        <col width="70"></col>
                        <col width="120"></col>
                        <col width="80"></col>
                        <col width="105"></col>
                        <col width="60"></col>
                        <col width="55"></col>
                        <col width=""></col>
                    <tr>
                        <td align="center" class="creamBold">대상자</td>
                        <td align="center" class="creamBold">관계</td>
                        <td class="padding2423">
                            <select id="cmbREL_CD" style="width=100%">
                            </select>
                        </td>
                        <td align="center" class="creamBold">주민등록번호</td>
                        <td class="padding2423">
                            <input id="txtCET_NO" style="width=100%;ime-mode:disabled;" maxLength="14" onKeypress="cfNumberCheck();" onKeyUp="cfCetNoHyphen(this);">
                        </td>
                        <td align="center" class="creamBold">구분</td>
                        <td class="padding2423" colspan="2">
                            <select id="cmbGBN_TAG" style="width=100%">
                                <option value=""></option>
                                <option value="A">장애인</option>
                                <option value="B">65세이상자</option>
                            </select>
                        </td>
                    </tr>                        
                        
                    <tr>
                         <td align="center" class="creamBold" rowspan="2">지급처</td>
                        <td align="center" class="creamBold">사업자번호</td>
                        <td class="padding2423">
                            <input id="txtCOM_NO" maxlength="12" style="width=100%;ime-mode:disabled" onKeypress="javascript:cfNumberCheck();" onkeyup="cfComNoHyphen(this);">
                        </td>
                        <td align="center" class="creamBold">진료기관</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtCOM_NM" style="width=100%" maxLength="30" onKeyUp="fc_chk_byte(this,30)">
                        </td>
                        <td align="center" class="creamBold">건수</td>
                        <td class="padding2423">
                            <input id="txtCARD_CNT" maxlength="3" style="width=100%;ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold" >지급금액</td>
                        <td class="padding2423">
	                        <comment id="__NSID__">
	                        <object id="medCARD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
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


                        <td align="center" class="creamBold">의료증빙코드 </td>
                          <td class="padding2423" colspan="4">
                           <select id="cmbMED_CD" style="width:100%" >
                            </select>
                        </tr>


                </table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
	</td>
	<td valign="top">
        <table width="190px" border="1" cellspacing="0" cellpadding="0">
            <tr>
                <td class="searchState">
                    <br>
	                &nbsp;-개인별, 진료기관별 합산
	                &nbsp;&nbsp;금액과 건수를 입력하시기
	                &nbsp;&nbsp;바랍니다.
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
                            <!--※공제받는 의료비가 200만원 이상인 분들만 반드시 입력 바랍니다.<BR>-->
                            <FONT color=#0033CC>※국세청장이 연말정산간소화서비스를 통해 제공하는 의료비자료의 경우에는 의료비 공제대상자별로 의료비 지출 합계액을 적습니다. 따라서 지급처의 사업자등록번호, 건수를 적지 아니합니다.</FONT>
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
					<object id="grdT_AC_MEDICAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" 						value="dsT_AC_MEDICAL">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"			value=1>								
						<param name="Format" 						value='
                            <C> id={currow}     		width=34    	name="NO"                       	align=center    SumBgColor=#C3D0DB  SumText="합계"</C>
                        <G> name="대상자" align=center HeadBgColor="#F7DCBB"
                            <C> id="REL_CD"     width=110   name="관계"                     			align=center    EditStyle=Lookup Data="dsT_CM_COMMON_FA:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="CET_NO"     width=90    name="대상자주민번호"           		align=center    SumBgColor=#C3D0DB</C>
                            <C> id="GBN_TAG"    width=65    name="구분"                     			align=center    Value={Decode(GBN_TAG,"A","장애인","B","65세이상자")}  SumBgColor=#C3D0DB</C>
                       </G>
                    	<G> name="지급처" align=center HeadBgColor="#F7DCBB"
                            <C> id="MED_CD"     	width=170   	name="의료증빙코드"             	align=left    EditStyle=Lookup Data="dsT_CM_COMMON_FC:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="COM_NO"     	width=80    	name="사업자번호"               	align=center    SumBgColor=#C3D0DB</C>
                            <C> id="COM_NM"     	width=115   	name="진료기관"                 	align=left        SumBgColor=#C3D0DB</C>
                            <C> id="CARD_CNT"   	width=30    	name="건수"                     	align=right      SumBgColor=#C3D0DB SumText=@sum</C>
                            <C> id="CARD_AMT"   	width=70    	name="지급금액"                 	align=right      SumBgColor=#C3D0DB SumText=@sum</C>
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

	<!-- T_AC_MEDICAL 설정 테이블 -->
	<object id="bndT_AC_MEDICAL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_MEDICAL">
		<Param Name="BindInfo", Value="
            <C>Col=CARD_AMT     		Ctrl=medCARD_AMT    	Param=text  </C>
            <C>Col=CARD_CNT     		Ctrl=txtCARD_CNT    	Param=value </C>
            <C>Col=CASH_AMT			Ctrl=medCASH_AMT		Param=text  </C>
            <C>Col=CASH_CNT     		Ctrl=txtCASH_CNT    	Param=value </C>
            <C>Col=SUM_AMT			Ctrl=medSUM_AMT		Param=text  </C>
            <C>Col=COM_NO				Ctrl=txtCOM_NO			Param=value </C>
            <C>Col=COM_NM				Ctrl=txtCOM_NM			Param=value </C>
            <C>Col=REL_CD				Ctrl=cmbREL_CD			Param=value </C>
            <C>Col=MED_CD				Ctrl=cmbMED_CD			Param=value </C>
            <C>Col=CET_NO				Ctrl=txtCET_NO			Param=value </C>
            <C>Col=GBN_TAG				Ctrl=cmbGBN_TAG		Param=value </C>
           		">
	</object>

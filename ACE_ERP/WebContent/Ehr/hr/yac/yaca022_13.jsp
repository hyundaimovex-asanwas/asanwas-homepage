<!--*************************************************************************
* @source      : yaca022_13.jsp                                                *
* @description : 부양가족등록 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2013/12/18            이동훈             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");

     double TAX_INCOME   = box.getDouble("TAX_INCOME");
     double HOSPT_AMT    = box.getDouble("HOSPT_AMT");
     double MIN_CARD_AMT = box.getDouble("MIN_CARD_AMT");

     String PIS_YY       = request.getParameter("PIS_YY");     
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

%>


<html>
<head>
    <title>부양가족등록(yaca022_2013년도)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
		var opener = window.dialogArguments;

        //단축키 순서
        var btnList = "T"   //조회
                    + "T"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "T"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params = null;

        //넘어온 변수값 처리
        var TYPE = "<%=request.getParameter("TYPE") %>";
        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        var CET_NO = "<%=request.getParameter("CET_NO") %>";
        var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";        
        
        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YY = document.getElementById("txtPIS_YY");

            params = "&S_MODE=SHR_INFO"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&CET_NO="+CET_NO;

            dsT_AC_FAMILY.dataid = dataClassName+params;
            dsT_AC_FAMILY.reset();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {

            if (dsT_AC_FAMILY.CountRow < 1) {
                alert("* 저장 할 자료가 없습니다!");
                return;
            }

            //값 유효성 검증
            if(!fnc_SaveItemCheck()) return;

            //checkbox 처리
            if(document.getElementById("chkBAS_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "BAS_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "BAS_MAN") = "";
            if(document.getElementById("chkWCT_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "WCT_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "WCT_MAN") = "";
            if(document.getElementById("chkTRB_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "TRB_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "TRB_MAN") = "";
            
            
            if(document.getElementById("chkRCH_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "RCH_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "RCH_MAN") = "";

            if(document.getElementById("chkGOL_70").checked == true) dsT_AC_FAMILY.NameValue(1, "GOL_70") = "O";
            else dsT_AC_FAMILY.NameValue(1, "GOL_70") = "";
            if(document.getElementById("chkCHI_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "CHI_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "CHI_MAN") = "";
            if(document.getElementById("chkINP_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "INP_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "INP_MAN") = "";
            if(document.getElementById("chkONE_PARENT").checked == true) dsT_AC_FAMILY.NameValue(1, "ONE_PARENT") = "O";
            else dsT_AC_FAMILY.NameValue(1, "ONE_PARENT") = "";
            
            params = "&S_MODE="+TYPE
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&CET_NO="+CET_NO;

            //DataSet을 입력상태로 변경
            dsT_AC_FAMILY.UseChangeInfo = false;
            dsT_AC_FAMILY.UserStatus(1) = 1;

            trT_AC_FAMILY.KeyValue = "TR_INS(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
            trT_AC_FAMILY.action = dataClassName+params;
            trT_AC_FAMILY.post();
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {

        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
            dsT_AC_FAMILY.ClearData();
            fnc_OnLoadProcess();
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();
        }

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
			 } 

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

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

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
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

            var cet_no = document.getElementById("txtCET_NO").value;
            var rel_cd = document.getElementById("cmbREL_CD").value;

            var card_amt = Number(form1.txtCARD_AMT_NTS.text) + Number(form1.txtCARD_AMT.text);
            var dir_card_amt = Number(form1.txtDIR_CARD_AMT_NTS.text) + Number(form1.txtDIR_CARD_AMT.text);
            var lh1_amt = Number(form1.txtLH1_AMT_NTS.text) + Number(form1.txtLH1_AMT.text);
            var lh2_amt04 = Number(form1.txtLH2_AMT04_NTS.text) + Number(form1.txtLH2_AMT04.text);
            var lh2_amt = Number(form1.txtLH2_AMT_NTS.text) + Number(form1.txtLH2_AMT.text);            
            var lh4_amt = Number(form1.txtLH4_AMT_NTS.text) + Number(form1.txtLH4_AMT.text);
            var lh5_amt = Number(form1.txtLH5_AMT_NTS.text) + Number(form1.txtLH5_AMT.text);
            var lh6_amt = Number(form1.txtLH6_AMT_NTS.text) + Number(form1.txtLH6_AMT.text);
            
            var bir_yy = "";
            var age = "";
            var sex = "";

            var juminno = "";
            juminno = cet_no.substring(0,6) + cet_no.substring(7,14);

            if(fnRRNCheck(juminno) == false){
            	alert("유효하지 않은 주민번호입니다.");
            	return false;
            }

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //외국인
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //외국인
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy); //나이
            
            if(rel_cd != "7" && rel_cd != "8" && age > 20 && age < 60 && rel_cd != "0" && rel_cd != "3" && document.getElementById("chkTRB_MAN").checked == false && document.getElementById("chkBAS_MAN").checked == true){
              alert("기본공제 대상자가 아닙니다."+"\n" + "기본공제 체크를 해제하시거나 자료를 수정하시기 바랍니다.");
              return false;
            }

            if(rel_cd == "8" && age > 17 && document.getElementById("chkTRB_MAN").checked == false && document.getElementById("chkBAS_MAN").checked == true){
              alert("기본공제 대상자가 아닙니다."+"\n" + "기본공제 체크를 해제하시거나 자료를 수정하시기 바랍니다.");
              return false;
            }

            if(document.getElementById("cmbREL_CD").value == ""){
                alert("관계가 잘못되었습니다.");
                return false;
            }

            //세대주여부
            if(TYPE == "UPT" && document.getElementById("cmbREL_CD").value == "0" && form1.radHOL_YN.CodeValue == ''){
				    alert("본인 세대주 여부를 체크 해 주십시요..");
			     	return false;
			}

			//주택임차원리금상환액 공제는 현재 무주택 세대주만 가능
			if(lh1_amt > 0 && form1.radHOL_YN.CodeValue != 'Y'){
				alert("주택임차원리금상환액 공제는 현재 무주택 세대주만 가능합니다.");
				return false;
			}

			//개인간 주택임차원리금상환액 공제는 총급여액이 30000000원 이하만 가능
			if(<%=TAX_INCOME%> >= 50000000 && lh5_amt > 0){
				alert("총급여액이 5000만원이하인 사람에 한하여 개인간 주택임차원리금상환 공제를 받으실 수 있습니다.");
				return false;
			}

			//개인간 주택임차원리금상환액 공제는 현재 무주택 세대주만 가능
			if(lh5_amt > 0 && form1.radHOL_YN.CodeValue != 'Y'){
				alert("개인간 주택임차원리금상환액 공제는 현재 무주택 세대주만 가능합니다.");
				return false;
			}

			//월세액 공제는 총급여액이 30000000원 이하만 가능
			if(<%=TAX_INCOME%> >= 50000000 && lh6_amt > 0){
				alert("총급여액이 5000만원이하인 사람에 한하여 월세액 공제를 받으실 수 있습니다.");
				return false;
			}

			//장기주택저당차입금이자상환액(30년이상)>0이면1500만원 초과시오류
			if(lh4_amt > 15000000){
				alert("장기주택저당차입금이자상환액(30년이상)>0이면1500만원 초과할 수 없습니다.");
				return false;
			}
			//장기주택저당차입금이자상환액(15년~29년) > 0, 장기주택저당차입금이자상환액(30년이상)=0이면 1000만원 초과시 오류
			if(lh4_amt == 0 && lh2_amt > 10000000){
				alert("장기주택저당차입금이자상환액(15년~29년) > 0, 장기주택저당차입금이자상환액(30년이상)=0이면 1000만원 초과할 수 없습니다.");
				return false;
			}
			//장기주택저당차입금이자상환액(15년미만) > 0, 장기주택저당차입금이자상환액(15년~29년)=0, 장기주택저당차입금이자상환액(30년이상)=0 이면 600만원 초과시 오류
			if(lh4_amt == 0 && lh2_amt == 0 && lh2_amt04 > 6000000){
				alert("장기주택저당차입금이자상환액(15년미만) > 0, 장기주택저당차입금이자상환액(15년~29년)=0, 장기주택저당차입금이자상환액(30년이상)=0 이면 600만원을 초과할 수 없습니다.");
				return false;
			}


            //장애여부 cmbINV_MAN
            if(document.getElementById("chkTRB_MAN").checked == true && document.getElementById("cmbINV_MAN").value == '0'){
				    alert("장애 여부를 체크 해 주십시요");
			     	return false;
			}else if(document.getElementById("chkTRB_MAN").checked != true && document.getElementById("cmbINV_MAN").value != '0'){
				    alert("장애 여부를 확인해 주십시요");
			     	return false;				
			}			

            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            dsT_AC_FAMILY.ClearData();

            form1.txtLH1_AMT.Enable = "false";    // 주택자금 비활성화
            form1.txtLH2_AMT04.Enable = "false";
            form1.txtLH2_AMT.Enable = "false";
            form1.txtLH4_AMT.Enable = "false";
            form1.txtLH5_AMT.Enable = "false";
            form1.txtLH6_AMT.Enable = "false";
            form1.txtLH7_AMT.Enable = "false";
            form1.txtLH8_AMT.Enable = "false";            
            form1.txtLH1_AMT_NTS.Enable = "false";
            form1.txtLH2_AMT04_NTS.Enable = "false";
            form1.txtLH2_AMT_NTS.Enable = "false";
            form1.txtLH4_AMT_NTS.Enable = "false";
            form1.txtLH5_AMT_NTS.Enable = "false";
            form1.txtLH6_AMT_NTS.Enable = "false";
            form1.txtLH7_AMT_NTS.Enable = "false";
            form1.txtLH8_AMT_NTS.Enable = "false";
            
            //공통코드 가져오기
            var oSelect = document.getElementById("cmbREL_CD");
            var oOption = null;

            for(var i=oSelect.length-1; i>0; i--) {
                oSelect.remove(i);
            }

            for(var i=1; i<=dsT_CM_COMMON_FA.CountRow; i++) {
                oOption = document.createElement("option");
                oOption.value = dsT_CM_COMMON_FA.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FA.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }
            
            form1.txtMARKET_AMT.Enable = "false";
            
            //입력 형태가 무엇인지 검증
            if(TYPE == "INS") {
                //DS 헤더 정의
                dsT_AC_FAMILY.setDataHeader(  "REL_CD:STRING"
                                            +",NAM_KOR:STRING"
                                            +",CET_NO:STRING"
                                            +",BAS_MAN:STRING"
                                            +",GOL_70:STRING"
                                            +",WCT_MAN:STRING"
                                            +",TRB_MAN:STRING"
                                            +",INV_MAN:STRING"                                            
                                            +",RCH_MAN:STRING"
                                            +",CHI_MAN:STRING"
                                            +",INP_MAN:STRING"
                                            +",ONE_PARENT:STRING"                                            
                                            +",EDU_TAG:STRING"
                                            
                                            +",LIN_AMT_NTS:INT"
                                            +",LIH_AMT_NTS:INT"
                                            +",MED_AMT_NTS:INT"
                                            +",LEN_AMT_NTS:INT"
                                            +",EDU_AMT_NTS:INT"
                                            +",HED_AMT_NTS:INT"
                                            +",CARD_AMT_NTS:INT"
                                            +",DIR_CARD_AMT_NTS:INT"
                                            +",MARKET_AMT_NTS:INT"                                            
                                            +",CASH_AMT_NTS:INT"
                                            +",PUBLIC_AMT_NTS:INT"
                                            
                                            +",LIN_AMT:INT"
                                            +",LIH_AMT:INT"
                                            +",MED_AMT:INT"
                                            +",LEN_AMT:INT"
                                            +",EDU_AMT:INT"
                                            +",HED_AMT:INT"
                                            +",CARD_AMT:INT"
                                            +",DIR_CARD_AMT:INT"
                                            +",MARKET_AMT:INT"
                                            +",CASH_AMT:INT"
                                            +",PUBLIC_AMT:INT"
                                            
                                            +",LH1_AMT:INT"                                            
                                            +",LH2_AMT04:INT"
                                            +",LH2_AMT:INT"
                                            +",LH4_AMT:INT"
                                            +",LH5_AMT:INT"
                                            +",LH6_AMT:INT"
                                            +",LH7_AMT:INT"
                                            +",LH8_AMT:INT"        
                                            
                                            +",LH1_AMT_NTS:INT"
                                            +",LH2_AMT04_NTS:INT"
                                            +",LH2_AMT_NTS:INT"
                                            +",LH4_AMT_NTS:INT"
                                            +",LH5_AMT_NTS:INT"
                                            +",LH6_AMT_NTS:INT"
                                            +",LH7_AMT_NTS:INT"
                                            +",LH8_AMT_NTS:INT"                                            

                                           );

                dsT_AC_FAMILY.AddRow();

                //교육비 disable 시키기
                changeEduTag("");

                //관계변경시
                changeRelTag("");

                //장애인공제
                fnc_changeTrbManDisabled();

            } else if(TYPE == "UPT"){
                //항목 변경일 경우 해당 항목을 조회해 옴
                fnc_SearchList();
            }
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        
        /********************************************
         * 17. 개인간 주택임차차입금 원리금 상환액 소득공제 명세서 작성*
         ********************************************/        
        function fnc_RegPerson(){

            		var href_page = "/hr/yac/yaca022_person.jsp"
                          + "?PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO
                          + "&ENO_NM="+ENO_NM
                          + "&DPT_NM="+DPT_NM
                          + "&JOB_NM="+JOB_NM;                          

            
            window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:390px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();        	

        }        
        
        /********************************************
         * 18. 월세액 소득공제 명세서 작성                                              *
         ********************************************/        
        function fnc_RegRent(){
        	
            	var href_page = "/hr/yac/yaca022_rent.jsp"
		                + "?PIS_YY="+PIS_YY
		                + "&ENO_NO="+ENO_NO
		                + "&ENO_NM="+ENO_NM
		                + "&DPT_NM="+DPT_NM
		                + "&JOB_NM="+JOB_NM;                          

  
  			window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:390px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();        	

        }              
        
        /********************************************
         * 기타 함수              *
         ********************************************/

        //지금 정의되어 있는 항목들
        var oElementList = new Array( "txtNAM_KOR"
                                     ,"txtCET_NO");

        //항목들의 메세지
        var oElementMsgList = new Array( "성명"
                                        ,"주민번호");

        //예외 항목들
        var oExceptionList = new Array(  );

        /**
         * 주민번호 검증
         */
        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("잘못된 주민번호입니다. 확인바랍니다.");
                    return false;
                }
            }

            return true;
        }

        /**
         * 교육구분이 변경 될때
         */
        function changeEduTag(selVal) {

            if(selVal == "") {
                form1.txtEDU_AMT_NTS.text = "0";
                form1.txtEDU_AMT.text = "0";

                form1.txtEDU_AMT_NTS.Enable = "false";
                form1.txtEDU_AMT.Enable = "false";
            } else {
                form1.txtEDU_AMT_NTS.Enable = "true";
                form1.txtEDU_AMT.Enable = "true";
            }

        }

        /**
         * 관계가 변경 될때
         */
        function changeRelTag(selVal) {

            document.getElementById("chkBAS_MAN").checked = false;
            document.getElementById("chkGOL_70").checked  = false;
            document.getElementById("chkTRB_MAN").checked = false;
            document.getElementById("chkWCT_MAN").checked = false;
            document.getElementById("chkRCH_MAN").checked = false;
            document.getElementById("chkCHI_MAN").checked = false;
            document.getElementById("chkINP_MAN").checked = false;
            document.getElementById("chkONE_PARENT").checked = false;            
            document.getElementById("radHOL_YN").disabled = true;

            if(selVal == ""){

            }else if(selVal == "0"){//본인
                alert("본인자료가 이미 등록되어 있습니다.");

                changeRelDisabled("");

                return false;


            }else if(selVal == "1"){//소득자의 직계존속

            }else if(selVal == "2"){//배우자의 직계존속

            }else if(selVal == "3"){//배우자
            	
                //document.getElementById("chkBAS_MAN").checked = true;

            }else if(selVal == "4"){//직계비속

           }else if(selVal == "5"){//직계비속

            }else if(selVal == "6"){//형제자매

            }else if(selVal == "7"){//수급자

            }else if(selVal == "8"){//위탁아동

			}

            changeRelDisabled(selVal);

        }

        //주민번호 체크
        function changeCetTag() {

            var rel_cd = document.getElementById("cmbREL_CD").value;
            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //외국인
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //외국인
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy);//나이

            document.getElementById("chkGOL_70").checked = false;
            document.getElementById("chkRCH_MAN").checked = false;
            document.getElementById("chkCHI_MAN").checked = false;

            document.getElementById("chkWCT_MAN").disabled = true;


            if(rel_cd == "0"){//본인

                if( cet_no != null && cet_no != "" &&
                   (cet_no.substring(7,8) == "2" || cet_no.substring(7,8) == "4" || cet_no.substring(7,8) == "6" || cet_no.substring(7,8) == "8") ){
                    document.getElementById("chkWCT_MAN").disabled = false;//활성화한다.
                }else{
                    document.getElementById("chkWCT_MAN").checked = false;//남자인경우 강제로 체크 못하게
                }

            }else if(rel_cd == "1"){//소득자의 직계존속
                if(age <= 28){
                    alert("직계존속(조부모/부모) 공제 요건에 해당하지 않습니다.");

                    return false;
                }

                //기본공제
                if(age >= 60){
                    document.getElementById("chkBAS_MAN").checked = true;
                    form1.txtLIN_AMT_NTS.Enable = "true";
                    form1.txtLIN_AMT.Enable = "true";
                }else{
                    document.getElementById("chkBAS_MAN").checked = false;
                    form1.txtLIN_AMT_NTS.Enable = "false";
                    form1.txtLIN_AMT.Enable = "false";

                    form1.txtLIN_AMT.text=0;
 	                form1.txtLIN_AMT_NTS.text=0;
                }

                if(age >= 70){//경로(70세이상)
                    document.getElementById("chkGOL_70").checked = true;
                }

            }else if(rel_cd == "2"){//배우자의 직계존속
                if(age <= 28){
                    alert("직계존속(조부모/부모) 공제 요건에 해당하지 않습니다.");

                    return false;
                }

                //기본공제
                if(age >= 60){
                    document.getElementById("chkBAS_MAN").checked = true;
                }else{
                    document.getElementById("chkBAS_MAN").checked = false;
                }

                if(age >= 70){//경로(70세이상)
                    document.getElementById("chkGOL_70").checked = true;
                }

            }else if(rel_cd == "3"){    //배우자

            }else if(rel_cd == "4"){    //직계비속
                if(age > 20){
                    alert("직계비속 공제 요건에 해당하지 않습니다.\n관계 및 주민번호를 확인하세요");

                    return false;
                }else{
                    document.getElementById("chkBAS_MAN").checked = true;
                }

                if(age <= 6){
                    document.getElementById("chkRCH_MAN").checked = true;
                }

                if(age <= 20 && document.getElementById("chkBAS_MAN").checked == true){
                    document.getElementById("chkCHI_MAN").checked = true;
                }else{
                    document.getElementById("chkCHI_MAN").checked = false;
                }
            }else if(rel_cd == "5"){    //직계비속 자녀외
                if(age > 20){
                    alert("직계비속 자녀외 공제 요건에 해당하지 않습니다.\n관계 및 주민번호를 확인하세요");

                    return false;
                }else{
                    document.getElementById("chkBAS_MAN").checked = true;
                }

                if(age <= 6){
                    document.getElementById("chkRCH_MAN").checked = true;
                }

                document.getElementById("chkCHI_MAN").checked = false;
            }else if(rel_cd == "6"){//형제자매

            }else if(rel_cd == "7"){//수급자
               document.getElementById("chkCHI_MAN").checked = false;
               document.getElementById("chkBAS_MAN").checked = true;
            }
 			else if(rel_cd == "8"){//위탁아동
               document.getElementById("chkCHI_MAN").checked = false;
               document.getElementById("chkBAS_MAN").checked = true;
            }

			//출생공제
            if(cet_no != null && cet_no != "" &&
        		(cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4")
        		&& age == 0)
        	{
	        	document.getElementById("chkINP_MAN").disabled = false;
        	}
        	else
        	{
	        	document.getElementById("chkINP_MAN").checked = false;
        		document.getElementById("chkINP_MAN").disabled = true;

        	}


        }

        //기본공제 클릭시에만
        function fnc_chkBasMan(){

            var rel_cd = document.getElementById("cmbREL_CD").value;
            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //외국인
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //외국인
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy);//나이

            if(document.getElementById("chkBAS_MAN").checked == false){//기본공제가 않되면 않된다.
                document.getElementById("chkTRB_MAN").checked = false;
                document.getElementById("chkINP_MAN").checked = false;
                document.getElementById("chkGOL_70").checked = false;
                document.getElementById("chkCHI_MAN").checked = false;
                document.getElementById("chkONE_PARENT").checked = false;                
            }

            if(rel_cd == "1" && document.getElementById("chkBAS_MAN").checked == true){//소득자의 직계존속(기본공제 체크되었을때)
                if(age >= 60){
                    //document.getElementById("chkBAS_MAN").checked = true;//이미 체크

	                if(age >= 70){//경로(70세이상)
	                   document.getElementById("chkGOL_70").checked = true;
	                }

                }else{
                    if(document.getElementById("chkTRB_MAN").checked != true){//장애인공제 제외
	                    alert("기본공제 대상자가 아닙니다.");
	                    document.getElementById("chkBAS_MAN").checked = false;
	                    return false;
	                }
                }

            }else if(rel_cd == "2" && document.getElementById("chkBAS_MAN").checked == true){//배우자의 직계존속(기본공제 체크되었을때)
                if(age >= 60){
                    //document.getElementById("chkBAS_MAN").checked = true;//이미 체크

                    if(age >= 70){//경로(70세이상)
                      document.getElementById("chkGOL_70").checked = true;
                    }

                }else{
                    if(document.getElementById("chkTRB_MAN").checked != true){//장애인공제 제외
	                    alert("기본공제 대상자가 아닙니다.");
	                    document.getElementById("chkBAS_MAN").checked = false;
	                    return false;
	                }
                }

            }

            if(rel_cd == "4" || rel_cd == "5" || rel_cd == "6"){
              if(age >= 21 && age <= 59 && document.getElementById("chkTRB_MAN").checked != true){
                 alert("기본공제 대상자가 아닙니다.");
	             document.getElementById("chkBAS_MAN").checked = false;
	             document.getElementById("chkINP_MAN").checked = false;
	             return false;
              }
            }

            //기본공제 대상자가 아니면 보헝료 입력 못한다.
            if(document.getElementById("chkBAS_MAN").checked == true){
                    form1.txtLIN_AMT_NTS.Enable = "true";
                    form1.txtLIN_AMT.Enable = "true";
            }else{
                    form1.txtLIN_AMT_NTS.Enable = "false";
                    form1.txtLIN_AMT.Enable = "false";

                    form1.txtLIN_AMT_NTS.text = 0;
                    form1.txtLIN_AMT.text = 0;
            }

	        if(rel_cd == "3"){
	            //배우자 기본공제 관련
	            fnc_changeBasManDisabled();

            }else if(rel_cd == "4" && document.getElementById("chkBAS_MAN").checked == true){//직계비속

                //자녀양육공제는 기본공제 아니어도 된다.

                if(age <= 20){//다자녀공제
                    document.getElementById("chkCHI_MAN").checked = true;
                }else{
                    document.getElementById("chkCHI_MAN").checked = false;
                }
            }else if(rel_cd == "5" && document.getElementById("chkBAS_MAN").checked == true){//직계비속 자녀외


                //자녀양육공제는 기본공제 아니어도 된다.

                if(age <= 20){//다자녀공제
                    document.getElementById("chkCHI_MAN").checked = true;
                }else{
                    document.getElementById("chkCHI_MAN").checked = false;
                }
            }else if((rel_cd == "0" || rel_cd == "3" || rel_cd == "4" || rel_cd == "5" ) && document.getElementById("chkTRB_MAN").checked == true){

            }
            else {

            }

       }

        // 배우자 기본공제 클릭, 조회, 신규
        function fnc_changeBasManDisabled(){

            var rel_cd = document.getElementById("cmbREL_CD").value;

            
            if(rel_cd == "3"){
                if(document.getElementById("chkBAS_MAN").checked == true){//배우자

                    document.getElementById("cmbEDU_TAG").disabled = false;

                    form1.txtCARD_AMT_NTS.Enable = "true";
                    form1.txtCARD_AMT.Enable = "true";
                    
                    form1.txtDIR_CARD_AMT_NTS.Enable = "true";
                    form1.txtDIR_CARD_AMT.Enable = "true";
                    
                    form1.txtCASH_AMT_NTS.Enable = "true";
                    form1.txtCASH_AMT.Enable = "true";
                    
                    form1.txtMARKET_AMT_NTS.Enable = "true";
                    //form1.txtMARKET_AMT.Enable = "true";
                    
                    form1.txtPUBLIC_AMT_NTS.Enable = "true";
                    form1.txtPUBLIC_AMT.Enable = "true";


                }else{

                    document.getElementById("cmbEDU_TAG").disabled = true;
                    document.getElementById("cmbEDU_TAG").value = "";
                    changeEduTag("");
                                      
                    form1.txtCARD_AMT_NTS.Enable = "false";
                    form1.txtCARD_AMT.Enable = "false";
                    
                    form1.txtDIR_CARD_AMT_NTS.Enable = "false";                    
                    form1.txtDIR_CARD_AMT.Enable = "false";

                    form1.txtCASH_AMT_NTS.Enable = "false";      
                    form1.txtCASH_AMT.Enable = "false"; 
                    
                    form1.txtMARKET_AMT_NTS.Enable = "false";
                    form1.txtMARKET_AMT.Enable = "false";                    
                    
                    form1.txtPUBLIC_AMT_NTS.Enable = "false";
                    form1.txtPUBLIC_AMT.Enable = "false";                    

                    form1.txtCARD_AMT_NTS.text = 0;
                    form1.txtCARD_AMT.text = 0;
                    
                    form1.txtDIR_CARD_AMT_NTS.text = 0;
                    form1.txtDIR_CARD_AMT.text = 0;

                    form1.txtCASH_AMT_NTS.text = 0;
                    form1.txtCASH_AMT.text = 0;
                    
                    form1.txtMARKET_AMT_NTS.text = 0;
                    form1.txtMARKET_AMT.text = 0;                    
                    
                    form1.txtPUBLIC_AMT_NTS.text = 0;
                    form1.txtPUBLIC_AMT.text = 0;
                    
                }
            }

        }

        //출생.입양 클릭시에만
        function fnc_chkInpMan(){

        	var cet_no = document.getElementById("txtCET_NO").value;
        	var year = PIS_YY;

        	if(cet_no != null && cet_no != "" &&
        		(cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4")
        		&& cet_no.substring(0,2) == year.substring(2,4))
        	{

        	}
        	else{
        		alert("출생일이 당해년도가 아닙니다.");
        		document.getElementById("chkINP_MAN").checked = false;
        		return false;
        	}

            if(document.getElementById("chkINP_MAN").checked == true){
               document.getElementById("chkBAS_MAN").checked = true;
               fnc_chkBasMan();
            }
        }


        //장애인공제 클릭시에만
        function fnc_chkTrbMan(){

            fnc_changeTrbManDisabled();

            var rel_cd = document.getElementById("cmbREL_CD").value;
            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //외국인
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //외국인
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

              age = Number(PIS_YY) - Number(bir_yy);//나이


            if(document.getElementById("chkTRB_MAN").checked == true){
                //장애인공제는 무조건 기본공제된다.
                document.getElementById("chkBAS_MAN").checked = true;

                fnc_chkBasMan();

            }else{
                if(rel_cd == "1" && document.getElementById("chkBAS_MAN").checked == true){//소득자의 직계존속

                    if(age >= 60){
                        //document.getElementById("chkBAS_MAN").checked = true;//이미 체크
                    }else{
                        //alert("기본공제 대상자가 아닙니다.");
                        document.getElementById("chkBAS_MAN").checked = false;
                        form1.txtLIN_AMT_NTS.text = 0;
                	    form1.txtLIN_AMT.text = 0;

                	    form1.txtLIN_AMT_NTS.Enable = "false";
            			form1.txtLIN_AMT.Enable = "false";

                        return false;
                    }

                }else if(rel_cd == "2" && document.getElementById("chkBAS_MAN").checked == true){//배우자의 직계존속

                    if(age >= 60){
                        //document.getElementById("chkBAS_MAN").checked = true;//이미 체크
                    }else{
                        //alert("기본공제 대상자가 아닙니다.");
                        document.getElementById("chkBAS_MAN").checked = false;
                        form1.txtLIN_AMT_NTS.text = 0;
                	    form1.txtLIN_AMT.text = 0;

                	    form1.txtLIN_AMT_NTS.Enable = "false";
            			form1.txtLIN_AMT.Enable = "false";
                        return false;
                    }
                }
            }

        }

        //장애인공제 클릭, 조회, 신규
        function fnc_changeTrbManDisabled(){

            if(document.getElementById("chkTRB_MAN").checked == true){
               form1.txtLIH_AMT_NTS.Enable = "true";
               form1.txtLIH_AMT.Enable = "true";
               form1.txtHED_AMT.Enable = "true";

            }else{
               form1.txtLIH_AMT_NTS.Enable = "false";
               form1.txtLIH_AMT.Enable = "false";
               form1.txtHED_AMT_NTS.Enable = "false";
               form1.txtHED_AMT.Enable = "false";

               form1.txtLIH_AMT_NTS.text = "0";
               form1.txtLIH_AMT.text = "0";
               form1.txtHED_AMT_NTS.text = "0";
               form1.txtHED_AMT.text = "0";

            }

        }

        //자녀양육비 클릭시에만
        function fnc_chkRchMan(){//자녀양육비 6세이하만 가능하게

            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //외국인
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //외국인
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy);//나이

            if(document.getElementById("chkRCH_MAN").checked == true){

                if(age > 6){
                    alert("6세 이하의 자녀만 자녀양육비공제가 가능합니다.");
                    document.getElementById("chkRCH_MAN").checked = false;
                    return false;
                }

            }

        }

        //활성화여부
        function changeRelDisabled(selVal) {

            var cet_no = document.getElementById("txtCET_NO").value;

            document.getElementById("cmbEDU_TAG").disabled = false;

            form1.txtCARD_AMT_NTS.Enable = "true";
            form1.txtCARD_AMT.Enable = "true";          
            
            form1.txtDIR_CARD_AMT_NTS.Enable = "true";
            form1.txtDIR_CARD_AMT.Enable = "true";
            
            form1.txtCASH_AMT_NTS.Enable = "true";
            form1.txtCASH_AMT.Enable = "true";
            
            form1.txtMARKET_AMT_NTS.Enable = "true";
            form1.txtMARKET_AMT.Enable = "false";

            form1.txtPUBLIC_AMT_NTS.Enable = "true";
            form1.txtPUBLIC_AMT.Enable = "true";
            
  			document.getElementById("btnPRO_PERSON").disabled = true;
  			document.getElementById("btnPRO_RENT").disabled = true;            
            
            //기본공제 대상자가 아니면 보헝료 입력 못한다.
            if(document.getElementById("chkBAS_MAN").checked == true){
                    form1.txtLIN_AMT_NTS.Enable = "true";
                    form1.txtLIN_AMT.Enable = "true";
            }else{
                    form1.txtLIN_AMT_NTS.Enable = "false";
                    form1.txtLIN_AMT.Enable = "false";

            }

            if(selVal == ""){
                document.getElementById("cmbREL_CD").value = "";
                document.getElementById("txtNAM_KOR").value = "";
                document.getElementById("txtCET_NO").value = "";

                document.getElementById("txtNAM_KOR").className = "input_ReadOnly";
                document.getElementById("txtNAM_KOR").readOnly = true;
                document.getElementById("txtCET_NO").className = "input_ReadOnly";
                document.getElementById("txtCET_NO").readOnly = true;

            }else{
                document.getElementById("txtNAM_KOR").className = "";
                document.getElementById("txtNAM_KOR").readOnly = false;
                document.getElementById("txtCET_NO").className = "";
                document.getElementById("txtCET_NO").readOnly = false;
            }

            if(selVal == ""){
	            document.getElementById("chkBAS_MAN").disabled = true;
	            document.getElementById("chkGOL_70").disabled = true;
	            document.getElementById("chkTRB_MAN").disabled = true;
	            document.getElementById("chkWCT_MAN").disabled = true;
	            document.getElementById("chkRCH_MAN").disabled = true;
	            document.getElementById("chkCHI_MAN").disabled = true;
	            document.getElementById("chkINP_MAN").disabled = true;
	            document.getElementById("chkONE_PARENT").disabled = true;
	            //교육비 비활성
                document.getElementById("cmbEDU_TAG").disabled = true;
                document.getElementById("cmbEDU_TAG").value = "";
                changeEduTag("");


            }else if(selVal == "0"){//본인
                document.getElementById("chkBAS_MAN").disabled = true;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                form1.radHOL_YN.Enable = true;

                form1.txtLH1_AMT.Enable = "true";    // 본인일경우 주택자금 활성화
                form1.txtLH2_AMT04.Enable = "true";
                form1.txtLH2_AMT.Enable = "true";
                form1.txtLH4_AMT.Enable = "true";
                form1.txtLH5_AMT.Enable = "false";
                form1.txtLH6_AMT.Enable = "false";
                form1.txtLH7_AMT.Enable = "true";
                form1.txtLH8_AMT.Enable = "true";                

                form1.txtLH1_AMT_NTS.Enable = "true";
                form1.txtLH2_AMT04_NTS.Enable = "true";
                form1.txtLH2_AMT_NTS.Enable = "true";
                form1.txtLH4_AMT_NTS.Enable = "true";
                form1.txtLH5_AMT_NTS.Enable = "false";
                form1.txtLH6_AMT_NTS.Enable = "false";
                form1.txtLH7_AMT_NTS.Enable = "true";
                form1.txtLH8_AMT_NTS.Enable = "true";

      			document.getElementById("btnPRO_PERSON").disabled = false;
      			document.getElementById("btnPRO_RENT").disabled = false;                   
                
                if( cet_no != null && cet_no != "" &&
                   (cet_no.substring(7,8) == "2" || cet_no.substring(7,8) == "4" || cet_no.substring(7,8) == "6" || cet_no.substring(7,8) == "8") ){
                    document.getElementById("chkWCT_MAN").disabled = false;//활성화한다.
                }else{
                    document.getElementById("chkWCT_MAN").checked = false;//남자인경우 강제로 체크 못하게
                }

                document.getElementById("chkRCH_MAN").disabled = true;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;

            }else if(selVal == "1"){//소득자의 직계존속
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkONE_PARENT").disabled = true;                
                form1.radHOL_YN.Enable = "false";

                //직계존속은 교육비 비활성
                document.getElementById("cmbEDU_TAG").disabled = true;
                document.getElementById("cmbEDU_TAG").value = "";
                changeEduTag("");


            }else if(selVal == "2"){//배우자의 직계존속
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkONE_PARENT").disabled = true;                      
                form1.radHOL_YN.Enable = "false";

                //직계존속은 교육비 비활성
                document.getElementById("cmbEDU_TAG").disabled = true;
                document.getElementById("cmbEDU_TAG").value = "";
                changeEduTag("");


            }else if(selVal == "3"){//배우자
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkONE_PARENT").disabled = true;                      
                form1.radHOL_YN.Enable = "false";

                //배우자 기본공제 관련
                fnc_changeBasManDisabled();

            }else if((selVal == "4") || (selVal == "5")){//직계비속
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = false;
                document.getElementById("chkCHI_MAN").disabled = false;
                document.getElementById("chkINP_MAN").disabled = false;
                document.getElementById("chkONE_PARENT").disabled = true;                      
                form1.radHOL_YN.Enable = "false";

            }else if(selVal == "6"){//형제자매
               
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkONE_PARENT").disabled = true;                      
                form1.radHOL_YN.Enable = "false";
 
                //형제자매는 신용카드 공제 안된다.
                form1.txtCARD_AMT_NTS.Enable = "false";
                form1.txtCARD_AMT.Enable = "false";
                form1.txtDIR_CARD_AMT_NTS.Enable = "false";
                form1.txtDIR_CARD_AMT.Enable = "false";
                form1.txtCASH_AMT_NTS.Enable = "false";
                form1.txtCASH_AMT.Enable = "false";
                form1.txtMARKET_AMT_NTS.Enable = "false";
                form1.txtMARKET_AMT.Enable = "false";      
                form1.txtPUBLIC_AMT_NTS.Enable = "false";
                form1.txtPUBLIC_AMT.Enable = "false";               
                
                form1.txtCARD_AMT_NTS.text = 0;
                form1.txtCARD_AMT.text = 0; 
                form1.txtDIR_CARD_AMT_NTS.text = 0;                
                form1.txtDIR_CARD_AMT.text = 0;
                form1.txtCASH_AMT_NTS.text = 0;
                form1.txtCASH_AMT.text = 0;
                form1.txtMARKET_AMT_NTS.text = 0;       
                form1.txtMARKET_AMT.text = 0;
                form1.txtPUBLIC_AMT_NTS.text = 0;       
                form1.txtPUBLIC_AMT.text = 0;
                
            }else if(selVal == "7"){//수급자
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = false;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkONE_PARENT").disabled = true;                      
                form1.radHOL_YN.Enable = "false";

                // 신용카드 공제 안된다.
                form1.txtCARD_AMT_NTS.Enable = "false";
                form1.txtCARD_AMT.Enable = "false";
                form1.txtDIR_CARD_AMT_NTS.Enable = "false";
                form1.txtDIR_CARD_AMT.Enable = "false";
                form1.txtCASH_AMT_NTS.Enable = "false";
                form1.txtCASH_AMT.Enable = "false";
                form1.txtMARKET_AMT_NTS.Enable = "false";
                form1.txtMARKET_AMT.Enable = "false";      
                form1.txtPUBLIC_AMT_NTS.Enable = "false";
                form1.txtPUBLIC_AMT.Enable = "false";               
                
                form1.txtCARD_AMT_NTS.text = 0;
                form1.txtCARD_AMT.text = 0;
                form1.txtDIR_CARD_AMT_NTS.text = 0;                
                form1.txtDIR_CARD_AMT.text = 0;
                form1.txtCASH_AMT_NTS.text = 0;
                form1.txtCASH_AMT.text = 0;
                form1.txtMARKET_AMT_NTS.text = 0;       
                form1.txtMARKET_AMT.text = 0;
                form1.txtPUBLIC_AMT_NTS.text = 0;       
                form1.txtPUBLIC_AMT.text = 0;
                
            }else if(selVal == "8"){//위탁아동
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = false;
                document.getElementById("chkCHI_MAN").disabled = true;
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkONE_PARENT").disabled = true;                      
                form1.radHOL_YN.Enable = "false";

                // 신용카드 공제 안된다.
                form1.txtCARD_AMT_NTS.Enable = "false";
                form1.txtCARD_AMT.Enable = "false";
                form1.txtDIR_CARD_AMT_NTS.Enable = "false";
                form1.txtDIR_CARD_AMT.Enable = "false";
                form1.txtCASH_AMT_NTS.Enable = "false";
                form1.txtCASH_AMT.Enable = "false";
                form1.txtMARKET_AMT_NTS.Enable = "false";
                form1.txtMARKET_AMT.Enable = "false";      
                form1.txtPUBLIC_AMT_NTS.Enable = "false";
                form1.txtPUBLIC_AMT.Enable = "false";               
                
                form1.txtCARD_AMT_NTS.text = 0;
                form1.txtCARD_AMT.text = 0;
                form1.txtDIR_CARD_AMT_NTS.text = 0;                
                form1.txtDIR_CARD_AMT.text = 0;
                form1.txtCASH_AMT_NTS.text = 0;
                form1.txtCASH_AMT.text = 0;
                form1.txtMARKET_AMT_NTS.text = 0;       
                form1.txtMARKET_AMT.text = 0;
                form1.txtPUBLIC_AMT_NTS.text = 0;       
                form1.txtPUBLIC_AMT.text = 0;
            }

        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_FAMILY)                |
    | 3. 사용되는 Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_FAMILY1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FA"/>
       <jsp:param name="CODE_GUBUN"    value="FA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_FAMILY)                |
    | 3. 사용되는 Table List(T_AC_FAMILY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_FAMILY)                |
    | 3. 사용되는 Table List(T_AC_FAMILY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_FAMILY1" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩

            //checkbox 처리
            if(dsT_AC_FAMILY.NameValue(1, "BAS_MAN") == "O") document.getElementById("chkBAS_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "WCT_MAN") == "O") document.getElementById("chkWCT_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "TRB_MAN") == "O") document.getElementById("chkTRB_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "RCH_MAN") == "O") document.getElementById("chkRCH_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "GOL_70") == "O") document.getElementById("chkGOL_70").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "CHI_MAN") == "O") document.getElementById("chkCHI_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "INP_MAN") == "O") document.getElementById("chkINP_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "ONE_PARENT") == "O") document.getElementById("chkONE_PARENT").checked = true;
            
            changeRelDisabled(dsT_AC_FAMILY.NameValue(1, "REL_CD"));

            //학력 구분 코드
            changeEduTag(dsT_AC_FAMILY.NameValue(1, "EDU_TAG"));

            //장애인공제
            //잘못저장된 데이터 확인할수있게 0으로 처리 안하기 위해 함수에서 따로 뺐음
            //fnc_changeTrbManDisabled();
            if(document.getElementById("chkTRB_MAN").checked == true){
               form1.txtLIH_AMT_NTS.Enable = "true";
               form1.txtLIH_AMT.Enable = "true";
               form1.txtHED_AMT.Enable = "true";

            }else{
               form1.txtLIH_AMT_NTS.Enable = "false";
               form1.txtLIH_AMT.Enable = "false";
               form1.txtHED_AMT_NTS.Enable = "false";
               form1.txtHED_AMT.Enable = "false";

            }

            //기본 데이터 수정못하게 막기
            fnc_ChangeStateElement(false, "cmbREL_CD");
            fnc_ChangeStateElement(false, "txtNAM_KOR");
            fnc_ChangeStateElement(false, "txtCET_NO");
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnSuccess()">
        alert("작업을 완료 하였습니다!");

        //DataSet을 입력상태로 변경, T_AC_RETACC 에 갱신 안되는 케이스가 있어 다시 한 번 호출

        params = "&S_MODE="+"ACC"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&CET_NO="+CET_NO;

        dsT_AC_FAMILY.UseChangeInfo = false;
        dsT_AC_FAMILY.UserStatus(1) = 1;

        trT_AC_FAMILY1.KeyValue = "TR_INS(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
        trT_AC_FAMILY1.action = dataClassName+params;
        trT_AC_FAMILY1.post();

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
        window.close();
    </script>

    <script for=trT_AC_FAMILY1 event="OnSuccess()">

        params = "&S_MODE=SHR"
              + "&PIS_YY="+PIS_YY
              + "&ENO_NO="+ENO_NO;

       	dsT_AC_FAMILY1.dataid = dataClassName+params;
       	dsT_AC_FAMILY1.reset();

		var med_amt = 0;

		if (dsT_AC_FAMILY1.CountRow > 0)    {
			for(var i=1; i<=dsT_AC_FAMILY1.CountRow; i++) {
				med_amt += dsT_AC_FAMILY1.NameValue(i,"MED_AMT");
			}
        }

        window.close();

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY1 event="OnFail()">
        cfErrorMsg(this);
        window.close();
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">부양가족등록</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">부양가족등록</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- 조건 입력 테이블 시작 -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="100"></col>
                        <col width="80"></col>
                        <col width="100"></col>
                        <col width="80"></col>                        
                        <col width="100"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">관&nbsp;&nbsp;&nbsp;계</td>
                        <td class="padding2423" colspan="5">
                            <select id="cmbREL_CD" name="cmbREL_CD" onchange="changeRelTag(this.value)">
                                <option value=""></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">성&nbsp;&nbsp;&nbsp;명</td>
                        <td class="padding2423">
                            <input id="txtNAM_KOR" maxlength="5" style="width:100%">
                        </td>
                        <td class="creamBold" align="center">주민번호</td>
                        <td class="padding2423">
                            <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onchange="changeCetTag()">
                        </td>
                        <td class="creamBold" align="center">장애여부</td>
                        <td class="padding2423">
                            <select id="cmbINV_MAN" name="cmbINV_MAN" onchange="changeTrbTag(this.value)">
                                <option value="0">비장애인</option>
	                            <option value="1">장애인복지법에 따른 장애인</option>
	                            <option value="2">국가유공자등 예우및 지원에 따른 장애인</option>
	                            <option value="3">항시 치료를 요하는 중증환자</option>                                
                            </select>
                        </td>                        
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">공제항목</td>
                        <td class="padding2423" colspan="5">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			                    <colgroup>
			                        <col width="150"></col>
			                        <col width="150"></col>
			                        <col width=""></col>
			                    </colgroup>
                                <tr>
			                        <td class="padding2423" valign="top">
			                            <input type="checkbox" name="chkBAS_MAN" id="chkBAS_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkBasMan()">기본공제
			                            <br>
			                            <input type="checkbox" name="chkGOL_70" id="chkGOL_70" style="border:0" align="absmiddle" value="">경로우대공제
			                            <br>
			                            <input type="checkbox" name="chkTRB_MAN" id="chkTRB_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkTrbMan();">장애인공제
			                        </td>
			                        <td class="padding2423" colspan="2" valign="top">
			                            <input type="checkbox" name="chkWCT_MAN" id="chkWCT_MAN" style="border:0" align="absmiddle" value="">부녀자공제
			                            <br>
			                            <input type="checkbox" name="chkRCH_MAN" id="chkRCH_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkRchMan()">6세이하공제
			                            <br>
			                            <input type="checkbox" name="chkCHI_MAN" id="chkCHI_MAN" style="border:0;DISPLAY:none" align="absmiddle" value=""><!-- 다자녀추가공제 -->
			                            <input type="checkbox" name="chkINP_MAN" id="chkINP_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkInpMan()">출생·입양공제
			                        </td>
			                        <td class="padding2423" align="left">세대주여부
										<object id=radHOL_YN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:20; width:110">
											<param name=AutoMargin		value="false">
											<param name=DataID      		value="dsT_AC_FAMILY">
											<param name=CodeColumn  	value="HOL_YN">
											<param name=Cols				value="2">
											<param name=Format			value="Y^Yes   ,N^No">
										</object>
										<br>
										<br>																			
                       					<input type="checkbox" name="chkONE_PARENT" id="chkONE_PARENT" style="border:0" value="">한부모공제
									</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br>
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="80"></col>
                        <col width="80"></col>
                        <col width="110"></col>                        
                        <col width="130"></col>
                        <col width="100"></col>                        
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center" colspan="4">구&nbsp;&nbsp;&nbsp;분</td>
                        <td class="creamBold" align="center">국세청 자료</td>
                        <td class="creamBold" align="center">그밖의 자료</td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" rowspan="2">
                            보험료
                        </td>
                        <td class="creamBold" align="center" colspan="3">보장성보험료</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIN_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    <tr>
                        <td class="creamBold" align="center" colspan="3">장애인전용보험료</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIH_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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

                    <tr>
                         <td class="creamBold" align="center" rowspan="2">
                            교육비
                        </td>
                        <td class="creamBold" align="center" colspan="3">
                            <table>
                                <tr>
                                    <td class="creamBold" align="center">교육비</td>
                                    <td><select id="cmbEDU_TAG" name="cmbEDU_TAG" style="width:100px" onchange="changeEduTag(this.value)">
	                                        <option value=""></option>
	                                        <option value="1">취학前</option>
	                                        <option value="2">초중고</option>
	                                        <option value="3">대학교</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtEDU_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    <tr>
                        <td class="creamBold" align="center" colspan="3">장애인특수교육비</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtHED_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtHED_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    
                    <tr>
                        <td class="creamBold" align="center" rowspan="5">
                            신용카드<br>
                            사용액
                        </td>
                        <td class="creamBold" align="center" colspan="3">신용카드 총액</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
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
                    <tr>
                        <td class="creamBold" align="center" colspan="3">직불/선불카드 총액</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtDIR_CARD_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtDIR_CARD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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

                    <tr>
                        <td class="creamBold" align="center" colspan="3">현금영수증 총액</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCASH_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCASH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
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
                    
                    <tr>
                        <td class="creamBold" align="center" colspan="3">전통시장사용 총액</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtMARKET_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtMARKET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                                      
                    <tr>
                        <td class="creamBold" align="center" colspan="3">대중교통이용 총액</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtPUBLIC_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtPUBLIC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                  
                     <tr>
                        <td class="creamBold" align="center" rowspan="8">
                            주택자금
                        </td>
                        <td class="creamBold" align="center" rowspan="2">주택임차<br>차입금</td>
                        <td class="creamBold" align="center"  colspan="2">대출기관</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px"  >
                            <comment id="__NSID__">
                            <object id="txtLH1_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                      
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH1_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
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
                    <tr>

                        <td class="creamBold" align="right" colspan="2">개인간&nbsp;&nbsp;
                        	<button id="btnPRO_PERSON"  style="cursor:hand;width:70pt;height:15pt;" onclick="fnc_RegPerson();"><font color="red"><b>입력 Click!</b></font></button>                        
                        </td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">  
                            <comment id="__NSID__">
                            <object id="txtLH5_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH5_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    
					<tr>
                        <td class="creamBold" align="right" colspan="3">월세액&nbsp;&nbsp;
                             <button id="btnPRO_RENT"  style="cursor:hand;width:70pt;height:15pt;" onclick="fnc_RegRent();"><font color="red"><b>입력  Click!</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">   
                            <comment id="__NSID__">
                            <object id="txtLH6_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH6_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                                        
                    <tr>
                        <td class="creamBold" align="center" rowspan="5">장기주택<br>저당차입금</td>
                		<td class="creamBold" align="center" rowspan="3">2011년<br>이전차입분</td>                          
                        <td class="creamBold" align="center">15년 미만</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH2_AMT04_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH2_AMT04" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    <tr>

                        <td class="creamBold" align="center">15 ~ 29년</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH2_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    <tr>
                        <td class="creamBold" align="center">30년 이상</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH4_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH4_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    <tr>
                		<td class="creamBold" align="center" rowspan="2">2012년<br>이후차입분</td>                          
                        <td class="creamBold" align="center">고정금리/비거치</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH7_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH7_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                    <tr>
                        <td class="creamBold" align="center">기타대출</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH8_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH8_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
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

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_AC_FAMILY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_FAMILY">
    <Param Name="BindInfo", Value='
        <C>Col=REL_CD               Ctrl=cmbREL_CD              Param=value     </C>
        <C>Col=NAM_KOR              Ctrl=txtNAM_KOR             Param=value     </C>
        <C>Col=CET_NO               Ctrl=txtCET_NO              Param=value     </C>
        <C>Col=INV_MAN               Ctrl=cmbINV_MAN              Param=value     </C>        
        <C>Col=EDU_TAG              Ctrl=cmbEDU_TAG             Param=value     </C>
        <C>Col=LIN_AMT_NTS          Ctrl=txtLIN_AMT_NTS         Param=text      </C>
        <C>Col=LIH_AMT_NTS          Ctrl=txtLIH_AMT_NTS         Param=text      </C>
        <C>Col=MED_AMT_NTS          Ctrl=txtMED_AMT_NTS         Param=text      </C>
        <C>Col=LEN_AMT_NTS          Ctrl=txtLEN_AMT_NTS         Param=text      </C>
        <C>Col=EDU_AMT_NTS          Ctrl=txtEDU_AMT_NTS         Param=text      </C>
        <C>Col=HED_AMT_NTS          Ctrl=txtHED_AMT_NTS         Param=text      </C>
        <C>Col=CARD_AMT_NTS         Ctrl=txtCARD_AMT_NTS        Param=text      </C>
        <C>Col=DIR_CARD_AMT_NTS     Ctrl=txtDIR_CARD_AMT_NTS        Param=text      </C>
        <C>Col=CASH_AMT_NTS         	Ctrl=txtCASH_AMT_NTS        Param=text      </C>
        <C>Col=MARKET_AMT_NTS         Ctrl=txtMARKET_AMT_NTS        Param=text      </C>    
        <C>Col=PUBLIC_AMT_NTS          Ctrl=txtPUBLIC_AMT_NTS         Param=text      </C>
        <C>Col=LIN_AMT              		Ctrl=txtLIN_AMT             Param=text      </C>
        <C>Col=LIH_AMT              		Ctrl=txtLIH_AMT             Param=text      </C>
        <C>Col=MED_AMT              		Ctrl=txtMED_AMT             Param=text      </C>
        <C>Col=LEN_AMT              		Ctrl=txtLEN_AMT             Param=text      </C>
        <C>Col=EDU_AMT              		Ctrl=txtEDU_AMT             Param=text      </C>
        <C>Col=HED_AMT              		Ctrl=txtHED_AMT             Param=text      </C>
        <C>Col=CARD_AMT             		Ctrl=txtCARD_AMT            Param=text      </C>
        <C>Col=DIR_CARD_AMT         	Ctrl=txtDIR_CARD_AMT        Param=text      </C>
        <C>Col=CASH_AMT             		Ctrl=txtCASH_AMT            Param=text      </C>
        <C>Col=MARKET_AMT             	Ctrl=txtMARKET_AMT            Param=text      </C>
        <C>Col=PUBLIC_AMT              	Ctrl=txtPUBLIC_AMT             	Param=text      </C>
        <C>Col=LC1_AMT              		Ctrl=txtLC1_AMT             		Param=text      </C>
        <C>Col=LC2_AMT              		Ctrl=txtLC2_AMT             		Param=text      </C>
        <C>Col=LC2_AMT_NTS          	Ctrl=txtLC2_AMT_NTS         	Param=text      </C>        
        <C>Col=LC3_AMT              		Ctrl=txtLC3_AMT             		Param=text      </C>
        <C>Col=LC3_AMT_NTS          	Ctrl=txtLC3_AMT_NTS         	Param=text      </C>
        <C>Col=LC4_AMT              		Ctrl=txtLC4_AMT             		Param=text      </C>
        <C>Col=LC4_AMT_NTS          	Ctrl=txtLC4_AMT_NTS         	Param=text      </C>        
        <C>Col=LH2_AMT04            		Ctrl=txtLH2_AMT04           	Param=text      </C>
        <C>Col=LH2_AMT              		Ctrl=txtLH2_AMT             		Param=text      </C>
        <C>Col=LH4_AMT              		Ctrl=txtLH4_AMT             		Param=text      </C>
        <C>Col=LH5_AMT              		Ctrl=txtLH5_AMT             		Param=text      </C>
        <C>Col=LH6_AMT              		Ctrl=txtLH6_AMT             		Param=text      </C>
        <C>Col=LH7_AMT              		Ctrl=txtLH7_AMT             		Param=text      </C>
        <C>Col=LH8_AMT              		Ctrl=txtLH8_AMT             		Param=text      </C>                
        <C>Col=LH1_AMT              		Ctrl=txtLH1_AMT             		Param=text      </C>
        <C>Col=LH2_AMT04_NTS        	Ctrl=txtLH2_AMT04_NTS       	Param=text      </C>
        <C>Col=LH1_AMT_NTS          	Ctrl=txtLH1_AMT_NTS         	Param=text      </C>
        <C>Col=LH2_AMT_NTS          	Ctrl=txtLH2_AMT_NTS         	Param=text      </C>
        <C>Col=LH4_AMT_NTS          	Ctrl=txtLH4_AMT_NTS         	Param=text      </C>
        <C>Col=LH5_AMT_NTS          	Ctrl=txtLH5_AMT_NTS         	Param=text      </C>
        <C>Col=LH6_AMT_NTS          	Ctrl=txtLH6_AMT_NTS         	Param=text      </C>
        <C>Col=LH7_AMT_NTS          	Ctrl=txtLH7_AMT_NTS         	Param=text      </C>
        <C>Col=LH8_AMT_NTS          	Ctrl=txtLH8_AMT_NTS         	Param=text      </C>
        <C>Col=HOL_YN           			Ctrl=radHOL_YN              		Param=CodeValue </C>
    '>
</object>
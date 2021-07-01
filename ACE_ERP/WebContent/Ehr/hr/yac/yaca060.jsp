<!--
***********************************************************************
* @source      : yaca060.jsp
* @description : 연금.저축등 소득공제내역입력 PAGE
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

     double TAX_INCOME   = box.getDouble("TAX_INCOME");
     double HOSPT_AMT    = box.getDouble("HOSPT_AMT");
     double MIN_CARD_AMT = box.getDouble("MIN_CARD_AMT");


     
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
	<title>연금저축등소득공제내역입력(yaca060)</title>
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
        var HOL_YN = "<%=request.getParameter("HOL_YN") %>";

        //넘어온 변수값 처리
        var submit = "<%=request.getParameter("END_YN") %>";
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_PENSION.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_PENSION.reset();

			//다시 reset
            dsT_AC_PENSION.UseChangeInfo = "true";			

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
            dsT_AC_PENSION.UseChangeInfo = "false";
			
			// save
			trT_AC_PENSION.KeyValue = "tr01(I:dsT_AC_PENSION=dsT_AC_PENSION)";
			trT_AC_PENSION.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=SAV";
			trT_AC_PENSION.post();

			fnc_UpdateAcc();

        }

        function fnc_UpdateAcc(){

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_PENSION2.UseChangeInfo = false;

			dsT_AC_PENSION2.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=ACC&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_PENSION2.reset();
        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	if (dsT_AC_PENSION.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }

           	var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            tmpMSG += "금융회사 = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "ABA_NM")+"\n";
            tmpMSG += "계좌번호 = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "ACC_NO")+"\n";
            tmpMSG += "저축유형 = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "PEN_TYPE_NM")+"\n";
            tmpMSG += "저축구분 = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "PEN_GUBUN_NM")+"\n";

	        if( confirm(tmpMSG) ){
		        
			    var status = dsT_AC_PENSION.RowStatus(dsT_AC_PENSION.RowPosition);
			    
				dsT_AC_PENSION.DeleteRow(dsT_AC_PENSION.RowPosition);
			    		    		
			    if(status != 1){
                    trT_AC_PENSION.KeyValue = "tr01(I:dsT_AC_PENSION=dsT_AC_PENSION)";
                    trT_AC_PENSION.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=DEL";
                    trT_AC_PENSION.post();
                }
			}
			//fnc_UpdateAcc();
        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_AC_PENSION.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AC_PENSION.GridToExcel("연금저축등공제내역입력", '', 225);

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_AC_PENSION.CountColumn < 1) {
                //dsT_AC_PENSION.setDataHeader("PIS_YY:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, PIS_YM:STRING, COM_NO:STRING:KEYVALUETYPE, REMARK:STRING, COM_NM:STRING:KEYVALUETYPE, TOT_CNT:NUMBER, SUM_AMT:NUMBER, SEQ_NO:STRING:KEYVALUETYPE");
                alert("반드시 조회후 입력이 가능합니다.");
                return false;
            }

            for( i = 1; i <= dsT_AC_PENSION.CountRow; i++ ) {
                if (dsT_AC_PENSION.RowStatus(i) == 1) {
                	alert("먼저 저장하신 후에 신규 작업하시기 바랍니다..");
                	return;
            	}
            }

            dsT_AC_PENSION.AddRow();
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"SEQ_NO") = "9";

            fnc_enableInput();
            fnc_GetPenGubunList();
            document.getElementById("cmbPEN_TYPE_CD").focus();

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

			document.form1.medAMOUNT.value = 0;
			//document.getElementById("cmbYEAR_SEQ").selectedIndex = 0;

        	dsT_AC_PENSION.ClearData();
            //fnc_disableInput();

            document.getElementById("resultMessage").innerText = ' ';
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_PENSION.IsUpdated)  {
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

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_AC_PENSION.isUpdated ) {
	         //	alert("저장할 자료가 없습니다.");
             //   fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
             //   return false;
			}



			//주민번호 사업자번호 체크
			for(i=0;i<dsT_AC_PENSION.CountRow;i++){
			    //alert(i+"->"+dsT_AC_MEDICAL.RowLevel(i+1));
			    if(dsT_AC_PENSION.RowLevel(i+1) !="9999"){
	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '') {
	                    alert("연금저축유형은  필수 입력 항목입니다.");
	                    form1.cmbPEN_TYPE_CD.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '') {
	                    alert("연금저축구분항목은 필수 입력 항목입니다.");
	                    form1.cmbPEN_GUBUN_CD.focus();
	                    return false;
	                }

					if(dsT_AC_PENSION.NameValue(i+1,"ABA_CD") == '') {
	                    alert("금융회사명은 필수 입력 항목입니다.");
	                    form1.txtABA_NM.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"ABA_NM") == '') {
	                    alert("금융회사명은 필수 입력 항목입니다.");
	                    form1.txtABA_NM.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"ACC_NO") == '') {
	                    alert("계좌번호는 필수항목입니다.");
	                    form1.txtACC_NO.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"NTS_YN") == '') {
	                    alert("자료출처는 필수항목입니다.");
	                    form1.cmbNTS_YN.focus();
	                    return false;
	                }

	                //if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '4' && dsT_AC_PENSION.NameValue(i+1,"YEAR_SEQ") == '') {
	                //    alert("납입연차는 필수항목입니다.");
	                //    form1.cmbYEAR_SEQ.focus();
	                //    return false;
	                //}

	                //if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '4' && dsT_AC_PENSION.NameValue(i+1,"YEAR_SEQ") == '01') {
	                //    alert("2009.12.31까지 가입한 경우에만 공제 가능합니다. 납입연차를 다시 확인하십시요.");
	                //    form1.cmbYEAR_SEQ.focus();
	                //    return false;
	                //}

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '2' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 12000000) {
	                	alert("연금저축공제 불입금액은 1200만원을 초과할 수 없습니다.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                //if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '3' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 0 && HOL_YN != "Y") {
	                //	alert("세대주만 주택마련저축 공제가 가능합니다. 세대주 여부를 확인 바랍니다.");
	                //    form1.medAMOUNT.focus();
	                //    fnc_SearchList();
	                //    return false;
	                //}

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '31' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 1200000) {
	                	alert("청약저축 불입금액은 120만원을 초과할 수 없습니다.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '32' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 1200000) {
	                	alert("주택청약종합저축 불입금액은 120만원을 초과할 수 없습니다.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '33' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 12000000) {
	                	alert("장기주택마련저축 불입금액은 1200만원을 초과할 수 없습니다.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

    			 	if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '33' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 0 && <%=TAX_INCOME%> >= 88000000) {
	                	alert("장기주택마련저축 총급여가 8800만원 이하인자만 공제 가능합니다.");
	                    form1.medAMOUNT.focus();
	                    fnc_SearchList()
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '34' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 1800000) {
	                	alert("근로자주택마련저축 불입금액은 180만원을 초과할 수 없습니다.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '41' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 15000000) {
	                	alert("장기주식형소득공제 불입금액은 1500만원을 초과할 수 없습니다.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }


                }
			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

             var cmbPEN_GUBUN_CD = document.getElementById("cmbPEN_GUBUN_CD");
             //var txtPEN_GUBUN_NM = document.getElementById("txtPEN_GUBUN_NM");     

        	 for (i = cmbPEN_GUBUN_CD.length - 1; i>=0; i--) {

        		 cmbPEN_GUBUN_CD.remove(i);
        		 
        		   }                     

<%
    //관리자가 아닐 경우 타인은 조회가 되지 않게
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "imgEnoNo");
            document.getElementById("imgEnoNo").style.display = "none";
            //document.getElementById("imgPrint").style.display = "none";
<%
    }
%>
		
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

			cfStyleGrid(form1.grdT_AC_PENSION, 15, "false","false");      // Grid Style 적용

			fnc_SearchList();

		    if(submit=='Y' )
            {
        		fnc_disableInput();
                return;
            }
			
        }

        function fnc_GetPenGubunList(){

        
				//document.getElementById("cmbYEAR_SEQ").disabled = true;

				var oSelectT = document.getElementById("cmbPEN_TYPE_CD");
         		var oSelect = document.getElementById("cmbPEN_GUBUN_CD");

         		oSelect = "";

         		var CdList = null;
         		var NmList = null;
     		
         		// 구분 검색 콤보박스 생성
	            oSelect = document.getElementById("cmbPEN_GUBUN_CD");
	            
	            //첫번째 라인을 제외한 모든 option 삭제
	            for(i=oSelect.options.length-1; i>=0; i--) {
	                oSelect.remove(i);
	            }

                if(oSelectT.value == "1"){
/*
                   CdList = new Array(  "11"
                                       ,"12");
                   NmList = new Array(  "퇴직연금"
                                       ,"과학기술인공제회");
*/                }
                else if(oSelectT.value == "2"){
                   CdList = new Array(  "21"
                                       ,"22");
                   NmList = new Array(  "개인연금저축"				//LF1_AMT
                                       ,"연금저축");				//ANN_AMT
                }
                else if(oSelectT.value == "3"){
	               CdList = new Array(  "31"
                                       ,"32"
                                       ,"33"
                                       ,"34");
                   NmList = new Array(  "청약저축"                   //LHO_AMT(NTS)
                                       ,"주택청약종합저축"			 //LHP_AMT(NTS)
                                       ,"장기주택마련저축"			 //LHQ_AMT(NTS)
                                       ,"근로자주택마련저축");		 //LHR_AMT(NTS)
                }
                else if(oSelectT.value == "4"){
                   CdList = new Array(  "41");
                   NmList = new Array(  "장기주식형저축(3년차)");			//STOCK_AMT1, STOCK_AMT2, STOCK_AMT3
                   //document.getElementById("cmbYEAR_SEQ").disabled = false;
                }
                else{
                	return;
                }

                for(var i = 0; i < CdList.length; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = CdList[i];
	                oOption.text  = NmList[i];
	                oSelect.add(oOption);
				}
        }

        function fnc_SetPenType(){

         		// 저축 유형 구분 검색 콤보박스 생성
	            oSelect = document.getElementById("cmbPEN_TYPE_CD");

                if(oSelect.value == "1"){
	                document.form1.txtPEN_TYPE_NM.value = "퇴직연금";
	                document.getElementById("cmbYEAR_SEQ").value = "";
	            }
	            else if(oSelect.value == "2"){
                   document.form1.txtPEN_TYPE_NM.value = "연금저축";
                   document.form1.cmbPEN_TYPE_CD.value = "2";                              
                   document.getElementById("cmbYEAR_SEQ").value = "";
                }
                else if(oSelect.value == "3"){
                   document.form1.txtPEN_TYPE_NM.value = "주택마련저축";
                   document.form1.cmbPEN_TYPE_CD.value = "3";                     
                   document.getElementById("cmbYEAR_SEQ").value = "";
                }
                else if(oSelect.value == "4"){
                   document.form1.txtPEN_TYPE_NM.value = "장기주식형저축";
                   document.form1.cmbPEN_TYPE_CD.value = "4";                     
 	               document.getElementById("cmbYEAR_SEQ").value ="03";
                }

                fnc_SetPenGubun();
         }

         function fnc_SetPenGubun(){

                // 직종 구분 검색 콤보박스 생성
	            oSelectT = document.getElementById("cmbPEN_GUBUN_CD");
                
                if(oSelectT.value == "11"){
	                document.form1.txtPEN_GUBUN_NM.value = "퇴직연금";
 	                document.form1.cmbPEN_GUBUN_CD.value = "11";
                }
	            else if(oSelectT.value == "12"){
                   document.form1.txtPEN_GUBUN_NM.value = "과학기술인공제회";
	               document.form1.cmbPEN_GUBUN_CD.value = "12"; 	
	            }
                else if(oSelectT.value == "21"){
                   document.form1.txtPEN_GUBUN_NM.value = "개인연금저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "21";  
                }
                else if(oSelectT.value == "22"){   
                   document.form1.txtPEN_GUBUN_NM.value = "연금저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "22";  
                }
                else if(oSelectT.value == "31"){
                   document.form1.txtPEN_GUBUN_NM.value = "청약저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "31";  
                }
                else if(oSelectT.value == "32"){
                   document.form1.txtPEN_GUBUN_NM.value = "주택청약종합저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "32";    
                }
                else if(oSelectT.value == "33"){
                   document.form1.txtPEN_GUBUN_NM.value = "장기주택마련저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "33";    
                }
                else if(oSelectT.value == "34"){
                   document.form1.txtPEN_GUBUN_NM.value = "근로자주택마련저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "34";  
                }
                else if(oSelectT.value == "41"){
                   document.form1.txtPEN_GUBUN_NM.value = "장기주식형저축";
                   document.form1.cmbPEN_GUBUN_CD.value = "41"; 
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

            document.getElementById("cmbPEN_TYPE_CD").className = "";
	  		document.getElementById("cmbPEN_TYPE_CD").disabled = false;
	  		document.getElementById("cmbPEN_GUBUN_CD").className = "";
	  		document.getElementById("cmbPEN_GUBUN_CD").disabled = false;
	  		form1.medAMOUNT.Enable = "true";
            document.getElementById("txtABA_CD").className = "";
	  		document.getElementById("txtABA_CD").readOnly = false;
	  		document.getElementById("txtABA_NM").className = "";
	  		document.getElementById("txtABA_NM").readOnly = false;
            document.getElementById("txtACC_NO").className = "";
	  		document.getElementById("txtACC_NO").readOnly = false;
            //document.getElementById("cmbYEAR_SEQ").className = "";
	  		//document.getElementById("cmbYEAR_SEQ").disabled = false;
	  		document.getElementById("cmbNTS_YN").className = "";
	  		document.getElementById("cmbNTS_YN").diabled = false;

  		}

        /********************************************
         * 17. 입력필드 사용 불가능하게(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

            document.getElementById("cmbPEN_TYPE_CD").className = "input_ReadOnly";
	  		document.getElementById("cmbPEN_TYPE_CD").disabled = true;
	  		document.getElementById("cmbPEN_GUBUN_CD").className = "input_ReadOnly";
	  		document.getElementById("cmbPEN_GUBUN_CD").disabled = true;
	  		form1.medAMOUNT.Enable = "false";
            document.getElementById("txtABA_CD").className = "input_ReadOnly";
	  		document.getElementById("txtABA_CD").readOnly = true;
	  		document.getElementById("txtABA_NM").className = "input_ReadOnly";
	  		document.getElementById("txtABA_NM").readOnly = true;
            document.getElementById("txtACC_NO").className = "input_ReadOnly";
	  		document.getElementById("txtACC_NO").readOnly = true;
            //document.getElementById("cmbYEAR_SEQ").className = "input_ReadOnly";
	  		//document.getElementById("cmbYEAR_SEQ").disabled = true;
	  		document.getElementById("cmbNTS_YN").className = "input_ReadOnly";
	  		document.getElementById("cmbNTS_YN").diabled = true;

            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAddnew");
            fnc_HiddenElement("imgDelete");                        
            //fnc_HiddenElement("btnO"        );
            //fnc_HiddenElement("btnR"        );
	  		
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_PENSION)		   |
    | 3. 사용되는 Table List(T_AC_PENSION) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_PENSION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="false">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_PENSION)		   |
    | 3. 사용되는 Table List(T_AC_PENSION) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_PENSION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
        <Param Name="SubsumExpr" 	  		Value="total">
	</Object>


	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 관계구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U6"/>
       <jsp:param name="CODE_GUBUN"    value="U6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_PENSION)		   |
    | 3. 사용되는 Table List(T_AC_PENSION)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_PENSION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AC_PENSION=dsT_AC_PENSION,I:dsT_AC_PENSION=dsT_AC_PENSION)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_PENSION Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_AC_PENSION Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_PENSION Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
		cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_AC_PENSION event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        fnc_UpdateAcc();
        fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_PENSION event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script language=JavaScript for=dsT_AC_PENSION event=OnRowPosChanged(row)>
	          for( var i = 1; i <= dsT_CM_COMMON_U6.CountRow; i++ ) {
              oOption       = document.createElement("OPTION");
              oOption.value = dsT_CM_COMMON_U6.NameValue(i,"CODE");
              oOption.text  = dsT_CM_COMMON_U6.NameValue(i,"CODE_NAME");
              document.getElementById("cmbPEN_GUBUN_CD").add(oOption);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연금저축등공제내역입력</td>
					<td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">연금저축등공제내역입력</font></td>
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
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="imgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
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
                        <col width="171"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">저축유형</td>
                        <td class="padding2423" align="left">
								<select id="cmbPEN_TYPE_CD" style="width:100%;" onChange="fnc_GetPenGubunList();fnc_SetPenType();">
									<!-- <option value="1">퇴직연금</option> -->
									<option value="2">연금저축</option>
									<option value="3">주택마련저축</option>
									<option value="4">장기주식형저축</option>
								</select>
								<input type="hidden" id="txtPEN_TYPE_NM">
						</td>
                        <td align="center" class="creamBold">저축구분</td>
                        <td class="padding2423">
                            <select id="cmbPEN_GUBUN_CD" style="width=100%"  onChange="fnc_SetPenGubun();">
									<option value="21">개인연금저축</option>
									<option value="22">연금저축</option>
									<option value="31">청약저축</option>                            
									<option value="32">주택청약종합저축</option>
									<option value="33">장기주택마련저축</option>
									<option value="34">근로자주택마련저축</option>     
									<option value="41">장기주식형저축(3년차)</option>    									
                            </select>
                            <input type="hidden" id="txtPEN_GUBUN_NM">
                        </td>
                       </tr>
                    </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                    <colgroup>
                        <col width="100"></col>
                        <col width="171"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
						<td align="center" class="creamBold">출처</td>
						<td class="padding2423" align="left">
								<select id="cmbNTS_YN" style="width:100%;">
									<option value=""></option>
									<option value="1">국세청자료</option>
									<option value="2">그밖의자료</option>
								</select>
						</td>   
						                    
                        <td align="center" class="creamBold">금융회사명</td>
	                    <td class="padding2423">
	                        <input id="txtABA_CD" style="width:18%" maxlength="3" onChange="fnc_GetCommNm('BK', 'txtABA_CD','txtABA_NM');"> 
	                        <input id="txtABA_NM" style="width:60%" class="input_ReadOnly"  readonly>
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAbaCd','','/images/button/btn_HelpOver.gif',1)">
	                        <img src="/images/button/btn_HelpOn.gif" id="ImgAbaCd" name="ImgAbaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','금융기관','U7')"></a>
	                    </td>

                    </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="100"></col>
                        <col width="171"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                    
                        <td align="center" class="creamBold">계좌번호</td>
          		        <td class="padding2423">
                	        <input id="txtACC_NO" maxlength="20" style="width:100%">
                    	</td>
                    	                    
                 
                        <td align="center" class="creamBold">불입금액</td>
                        <td class="padding2423">
                            <comment id="__NSID__">
                            <object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
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
							<input type="hidden" id="cmbYEAR_SEQ">                            
                        </td>
                        <!--  
                        <td align="center" class="creamBold">납입연차</td>
                        <td class="padding2423" align="left">
								<select id="cmbYEAR_SEQ" style="width:100%;">
									<option value="03">3년차</option>
								</select>
						</td>
						-->

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
	                &nbsp;-퇴직연금,연금저축,주택마련
	                &nbsp;&nbsp;저축,장기주식형저축 공제를
	                &nbsp;&nbsp;받는 소득자에 대해서는 해
	                &nbsp;&nbsp;당 소득공제에 대한 명세를
	                &nbsp;&nbsp;작성해야 합니다.
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
					<object id="grdT_AC_PENSION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
						<param name="DataID" 						value="dsT_AC_PENSION">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"			value=1>						
						<param name="Format" 						value='
							<C> id={currow}					width=34    name="NO"		                		align=center  SumBgColor=#C3D0DB SumText="합계"  </C>
							<C> id="NTS_YN"					width=80	name="자료출처"		    			align=center Value={decode(NTS_YN, 1,"국세청자료",2,"그밖의 자료")} SumBgColor=#C3D0DB</C>
                            <C> id="PEN_TYPE_CD"			width=30	name="저축유형"		    			align=center  SumBgColor=#C3D0DB show=false</C>
                            <C> id="PEN_TYPE_NM"			width=100	name="저축유형명"		    			align=center  SumBgColor=#C3D0DB </C>
                            <C> id="PEN_GUBUN_CD"		width=30	name="코드"		    				align=center  SumBgColor=#C3D0DB show=false </C>
                            <C> id="PEN_GUBUN_NM"		width=130	name="저축구분명"		   	 			align=center  SumBgColor=#C3D0DB	</C>
                            <C> id="ABA_NM"					width=120	name="금융회사명"		    			align=center  SumBgColor=#C3D0DB </C>
                            <C> id="ACC_NO"					width=120	name="계좌번호"		        		align=center  SumBgColor=#C3D0DB </C>
                          	<C> id="AMOUNT"					width=100	name="불입금액"	            		align=right	  RightMargin="10" SumBgColor=#C3D0DB SumText=@sum</C>
                          	<C> id="YEAR_SEQ"				width=70	name="납입연차"	            		align=center  SumBgColor=#C3D0DB </C>
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

	<!-- form 끝 -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_PENSION 설정 테이블 -->
	<object id="bndT_AC_PENSION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_PENSION">
		<Param Name="BindInfo", Value="
			<C>Col=NTS_YN				Ctrl=cmbNTS_YN				Param=value </C>
			<C>Col=PEN_TYPE_CD		Ctrl=cmbPEN_TYPE_CD		Param=value </C>
			<C>Col=PEN_TYPE_NM		Ctrl=txtPEN_TYPE_NM		Param=value </C>
            <C>Col=PEN_GUBUN_CD		Ctrl=cmbPEN_GUBUN_CD	Param=value  </C>
            <C>Col=PEN_GUBUN_NM	Ctrl=txtPEN_GUBUN_NM		Param=value  </C>
            <C>Col=ABA_CD				Ctrl=txtABA_CD				Param=value </C>
            <C>Col=ABA_NM				Ctrl=txtABA_NM				Param=value </C>
            <C>Col=ACC_NO				Ctrl=txtACC_NO				Param=value </C>
            <C>Col=AMOUNT				Ctrl=medAMOUNT				Param=text </C>
            <C>Col=YEAR_SEQ			Ctrl=cmbYEAR_SEQ			Param=value </C>
       ">
	</object>

<!--
***********************************************************************
* @source      : yaca023_15.jsp
* @description : 종전근무지 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/11/6            이동훈             최초작성       
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>

<%

 	request.setCharacterEncoding("euc-kr"); 

    String PIS_YY       = request.getParameter("PIS_YY");        
    String ENO_NO       = request.getParameter("ENO_NO");
    String ENO_NM       = request.getParameter("ENO_NM");
    String DPT_NM       = request.getParameter("DPT_NM");
    String JOB_NM       = request.getParameter("JOB_NM");


 	boolean itMaster = false;     
 	
	itMaster = true;     
	//관리자인지 아닌지 여부
	//if(gusrid.equals("6060002") ) {
	//	itMaster = true;
	//}
	 
%>

<html>
<head>
	<title>종전근무지내역입력(yaca023_2015년도)</title>
	
    <jsp:include page="/Ehr/common/include/head.jsp"/>  	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">

		var today = getToday();
		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTTTTT';
		
        //넘어온 변수값 처리       
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";        
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";   

        
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca023.cmd.YACA023CMD";
        var params = null;
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy  = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			//dsT_AC_DUTYPLACE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca023.cmd.YACA023CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			//dsT_AC_DUTYPLACE.reset();
			
            //연말정산 조회

            //params = "&S_MODE=SHR_14"
            params = "&S_MODE=SHR_15"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;			

            trT_AC_DUTYPLACE.KeyValue = "tr"
                + "(O:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";      
			trT_AC_DUTYPLACE.action = dataClassName+params;
			trT_AC_DUTYPLACE.post();			

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

            //DataSet을 입력상태로 변경
            //dsT_AC_DUTYPLACE.UseChangeInfo = false;			

            //params = "&S_MODE=SAV_14"
            params = "&S_MODE=SAV_15"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            
            trT_AC_DUTYPLACE_SAV.KeyValue = "tr"
                + "(I:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";
            
            trT_AC_DUTYPLACE_SAV.action = dataClassName+params;
            trT_AC_DUTYPLACE_SAV.post();            

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {


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

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {


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

	    
			document.form1.txtENO_NO_SHR.value = ENO_NO;
		    document.form1.txtENO_NM_SHR.value = ENO_NM;
		    document.form1.txtDPT_NM_SHR.value = DPT_NM;
		    document.form1.txtJOB_NM_SHR.value = JOB_NM;

        	dsT_AC_DUTYPLACE.ClearData();
        	
            fnc_disableInput();

            document.getElementById("resultMessage").innerText = ' ';

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_DUTYPLACE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
         function fnc_SearchItemCheck() {
			
             return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
             
         }

         var chkList = new Array( "chkPLA1"
                                 ,"chkPLA2"
                                 ,"chkPLA3");

         var itemList = new Array("txtJAS_NM"
                                 ,"txtJAO_NO"
                                 ,"txtHIR_YMD"
                                 ,"txtRET_YMD"
                                 ,"txtJAA_AMT"
                                 ,"txtJAC_AMT"
                                 ,"txtJAI_AMT"
                                 ,"txtJAG_AMT"
                                 ,"txtJAQ_AMT"
                                 ,"txtJAR_AMT"
                                 ,"txtJAH_AMT"
                                 ,"txtJAP_AMT"
                                 ,"txtJAL_AMT"
                                 ,"txtJAN_AMT");

         var itemMsgList = new Array("법인명(회사명)"
                                 ,"사업자등록번호"
                                 ,"당해근무시작일"
                                 ,"당해근무종료일"
                                 ,"국내급여총액"
                                 ,"국내상여총액"
                                 ,"인정상여총액"
                                 ,"비과세소득"
                                 ,"국민연금액"
                                 ,"국민연금이외의연금보험료"
                                 ,"건강보험료"
                                 ,"고용보험료"
                                 ,"결정소득세"
                                 ,"결정주민세"
                                 ,"본인세대주여부");


		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

	            for(var i=0; i<chkList.length; i++) {
	                oChkElement = document.getElementById(chkList[i]);

	                if(oChkElement.checked) {
	                    for(var j=0; j<itemList.length; j++) {
	                        chkVal = oChkElement.value;

	                        oElement = document.getElementById(itemList[j]+chkVal);

	                        if(oElement.text == "" || oElement.value == "") {
	                            alert(itemMsgList[j]+"을(를) 입력하세요");
	                            oElement.Enable = true;
	                            oElement.focus();
	                            return false;
	                        }

	                        // 시작일 CHECK
				            if (!fnc_CheckDate(document.getElementById("txtHIR_YMD"+chkVal), '당해근무기간 시작일') &&
				            	 document.getElementById("txtHIR_YMD"+chkVal).value != "") {
				                document.getElementById("txtHIR_YMD"+chkVal).focus();
				                return false;
				            }

				            // 종료일 CHECK
				            if (!fnc_CheckDate(document.getElementById("txtRET_YMD"+chkVal), '당해근무기간 종료일') &&
				            	 document.getElementById("txtRET_YMD"+chkVal).value != "") {
				                document.getElementById("txtRET_YMD"+chkVal).focus();
				                return false;
				            }

				            // 시작일 CHECK
				            if (document.getElementById("txtHIR_YMD"+chkVal).value.length != 10){
				                document.getElementById("txtHIR_YMD"+chkVal).focus();
				                alert("당해근무기간 시작일을 재입력해 주십시요.");
				                return false;
				            }

				            // 종료일 CHECK
				            if (document.getElementById("txtRET_YMD"+chkVal).value.length != 10){
				                document.getElementById("txtRET_YMD"+chkVal).focus();
				                alert("당해근무기간 종료일을 재입력해 주십시요.");
				                return false;
				            }

				            
				            //alert(document.getElementById("txtJAG_AMT"+chkVal).text);
				            // 비과세소득
				            if (document.getElementById("txtJAG_AMT"+chkVal).text != '0'){
				            	
					            if (document.getElementById("cmbJAG_CD"+chkVal).value == ''){
					                alert("비과세소득 코드를 입력해 주십시요.");
					                return false;
					            }	
					            
				            }
				            
	                    }
	                }
	            }			  
			  	  
			return true;

        }

		
		/********************************************
         * 저장 유효성 체크  					*
         ********************************************/       
        function  fnc_JAOConfirm1(){        
			
       	var JAO_NO1 =  document.form1.txtJAO_NO1.value.replace("-", "").replace("-", ""); 
      	
		    if(JAO_NO1.replace("-", "").replace("-", "").length != 10) {
               alert("종전근무지1 사업자번호가 잘못되었습니다.");
               document.getElementById("txtJAO_NO1").value = "";
               form1.txtJAO_NO1.focus();
               return false;
			}    
		    
			 if(bizNo_validate(JAO_NO1) == false){
			            	alert("유효하지 않은 사업자번호입니다.");
			                document.getElementById("txtJAO_NO1").value = "";			            	
			                 form1.txtJAO_NO1.focus();
			            	return false;
			 }			

		}
		
        function  fnc_JAOConfirm2(){        

        	
        	var JAO_NO2 =  document.form1.txtJAO_NO2.value.replace("-", "").replace("-", ""); 

 		    if(JAO_NO2.replace("-", "").replace("-", "").length != 10) {
                alert("종전근무지2 사업자번호가 잘못되었습니다.");
                document.getElementById("txtJAO_NO2").value = "";
                form1.txtJAO_NO2.focus();
                return false;
			}    
 		    
			 if(bizNo_validate(JAO_NO2) == false){
			            	alert("유효하지 않은 사업자번호입니다.");
			                document.getElementById("txtJAO_NO2").value = "";
			                 form1.txtJAO_NO2.focus();
			            	return false;
			 }			

		}
		
        function  fnc_JAOConfirm3(){        

        	var JAO_NO3 =  document.form1.txtJAO_NO3.value.replace("-", "").replace("-", ""); 
        	
 		    if(JAO_NO3.replace("-", "").replace("-", "").length != 10) {
                alert("종전근무지3 사업자번호가 잘못되었습니다.");
                document.getElementById("txtJAO_NO3").value = "";
                form1.txtJAO_NO3.focus();
                return false;
			}    
 		    
			 if(bizNo_validate(JAO_NO3) == false){
			            	alert("유효하지 않은 사업자번호입니다.");
			                document.getElementById("txtJAO_NO3").value = "";
			                 form1.txtJAO_NO3.focus(); 			            	
			            	return false;
			 }			

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
    if(!itMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";

<%
    }
%>

		   
			document.form1.txtPIS_YY_SHR.value = PIS_YY;		    
			document.form1.txtENO_NO_SHR.value = ENO_NO;
		    document.form1.txtENO_NM_SHR.value = ENO_NM;
		    document.form1.txtDPT_NM_SHR.value = DPT_NM;
		    document.form1.txtJOB_NM_SHR.value = JOB_NM;

            //fnc_disableInput();

            fnc_SearchList();

            /*
		    if(submit=='Y' )
            {
        		fnc_disableInput();
                return;
            }
			*/
            
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


         
         /********************************************
          * 입력필드 사용 불가능하게(Disable)    								*
          ********************************************/
   		function fnc_disableInput(param){

 			alert("전산제출한 상태입니다.\n수정은 불가능합니다.");

 			submit_chk = "Y";

 			document.getElementById("chkPLA1").disabled = true;
 			document.getElementById("chkPLA1").className = "input_ReadOnly";
 			document.getElementById("chkPLA2").disabled = true;
 			document.getElementById("chkPLA2").className = "input_ReadOnly";
 			document.getElementById("chkPLA3").disabled = true;
 			document.getElementById("chkPLA3").className = "input_ReadOnly";
	

         }

         /********************************************
          * 입력필드 사용 가능하게(Enable)       								*
          ********************************************/
   		function fnc_enableInput(){

 			document.getElementById("chkPLA1").disabled = false;
 			document.getElementById("chkPLA1").className = "";
 			document.getElementById("chkPLA2").disabled = false;
 			document.getElementById("chkPLA2").className = "";
 			document.getElementById("chkPLA3").disabled = false;
 			document.getElementById("chkPLA3").className = "";

   		}         


        //종전근무지에 관련된 Element List
        var plaList = new Array( "txtJAO_NO"
                                ,"txtJAS_NM"
                                ,"txtHIR_YMD"
                                ,"txtRET_YMD");

        /**
         * 종전근무지 내역 상태 처리 유무 검증
         */
        function checkPlace(oPLA) {
            var seq_no  = oPLA.value;
            var chk_place = oPLA.checked;

            dsT_AC_DUTYPLACE.NameValue(1, "TYPE"+seq_no) = "X";

            //입력창 활성, 비활성을 처리
            if(!chk_place) {
                if(!confirm("체크를 해제하시면 종전근무지"+seq_no+" 자료가 삭제됩니다.")) {
                    oPLA.checked = true
                    return;
                }
                dsT_AC_DUTYPLACE.NameValue(1, "TYPE"+seq_no) = "";
            }

            changePlace(seq_no, chk_place);
        }
        
        /**
         * 종전근무지 내역 조회 상태 변경
         */
        function changePlace(seq_no, checked) {

            document.getElementById("chkPLA"+seq_no).checked = checked;

            for(var i=0; i<plaList.length; i++) {
                fnc_ChangeStateElement(checked, plaList[i]+seq_no);
            }
			eval("form1.txtHIR_YMD"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtRET_YMD"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAA_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAC_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAG_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAI_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAQ_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAR_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAH_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAP_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAL_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAN_AMT"+seq_no+".Enable = '"+checked+"'");


            //저장시 없어지므로 주석처리

            if(checked == false){
	            for(var i=0; i<plaList.length; i++) {
	                document.getElementById(plaList[i]+seq_no).value = "";
	            }

	            eval("form1.txtJAA_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAC_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAG_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAI_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAQ_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAR_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAH_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAP_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAL_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAN_AMT"+seq_no+".text = '0'");
            }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_DUTYPLACE)		   |
    | 3. 사용되는 Table List(T_AC_DUTYPLACE) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_DUTYPLACE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_DUTYPLACE)		   |
    | 3. 사용되는 Table List(T_AC_DUTYPLACE)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_DUTYPLACE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<Object ID="trT_AC_DUTYPLACE_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_DUTYPLACE Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_AC_DUTYPLACE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_DUTYPLACE Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
	    if (this.ErrorCode == 50018) {
	        //alert("해당 필수입력항목[사업자등록번호/진료기관]\n입력 후 다음 작업이 가능합니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_AC_DUTYPLACE_SAV event="OnSuccess()">
       alert("종전근무지를 정상적으로 저장하였습니다.");
       fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_DUTYPLACE_SAV event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onload="fnc_OnLoadProcess();">

	<!-- form 시작 -->
	<form name="form1">
<br>
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">종전근무지</td>
					<td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">종전근무지</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>		
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->


	<!-- power Search테이블 시작 -->
	<table width="800px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="70"></col>
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

                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="6" class="input_ReadOnly" readonly>



							</td>
                            <td align="right" class="searchState">사번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
                                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                <input type="hidden" id="hidEMPL_DPT_CD">
                            </td>
                            <td class="searchState" align="right">소속&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">직위&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="15" class="input_ReadOnly" readonly>
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




	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="../../images/common/arrowGreen.gif" width="8" height="15" align="absmiddle"> 종전근무지자료</td>
						<td>
						-2014년 계속 근무하신 분은 해당되지 않습니다. 중도입사자만 해당됩니다.<br>
						-2014년 과세기간 중에 근무경력이 있는 종전근무지에 대한 자료 입력</td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="100"></col>
						<col width="235"></col>
						<col width="235"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="blueBold" align="center"></td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA1" id="chkPLA1" value="1" style="border:0" onclick="checkPlace(this)">
						&nbsp;종전근무지1
						</td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA2" id="chkPLA2" value="2" style="border:0" onclick="checkPlace(this)">
						&nbsp;종전근무지2
						</td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA3" id="chkPLA3" value="3" style="border:0" onclick="checkPlace(this)">
						&nbsp;종전근무지3
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">법인명(회사명)</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM1"
							id="txtJAS_NM1" size="20" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM2"
							id="txtJAS_NM2" size="20" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM3"
							id="txtJAS_NM3" size="20" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">사업자등록번호</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO1"
							id="txtJAO_NO1" size="15" maxlength="12" 
							style="text-align:right;" style="ime-mode:disabled"  onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" onChange="fnc_JAOConfirm1();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO2"
							id="txtJAO_NO2" size="15" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" onChange="fnc_JAOConfirm2();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO3"
							id="txtJAO_NO3" size="15" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" onChange="fnc_JAOConfirm3();" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">당해근무기간</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD1"
							id="txtHIR_YMD1" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD1"
							id="txtRET_YMD1" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD2"
							id="txtHIR_YMD2" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD2"
							id="txtRET_YMD2" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD3"
							id="txtHIR_YMD3" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD3"
							id="txtRET_YMD3" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">국내급여총액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">국내상여총액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">인정상여총액<br>(우리사주출연금)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">비과세소득</td>
						<td class="padding2423">
						<table>
							<tr>
								<td>
									<select id="cmbJAG_CD1" name="cmbJAG_CD1" style="position:relative;top:-3px;width:90px;">
		                                        <option value=""></option>
		                                        <option value="1">국외근로</option>
		                                        <option value="2">야간근로수당</option>
		                                        <option value="3">출산/보육수당</option>
		                                        <option value="4">연구보조비</option>		                                        
	                                </select>								
								<comment id="__NSID__"> <object
									id="txtJAG_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td>
									<select id="cmbJAG_CD2" name="cmbJAG_CD2" style="position:relative;top:-3px;width:90px;">
		                                        <option value=""></option>
		                                        <option value="1">국외근로</option>
		                                        <option value="2">야간근로수당</option>
		                                        <option value="3">출산/보육수당</option>
		                                        <option value="4">연구보조비</option>		                                        
	                                </select>									
								<comment id="__NSID__"> <object
									id="txtJAG_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td>
									<select id="cmbJAG_CD3" name="cmbJAG_CD3" style="position:relative;top:-3px;width:90px;">
		                                        <option value=""></option>
		                                        <option value="1">국외근로</option>
		                                        <option value="2">야간근로수당</option>
		                                        <option value="3">출산/보육수당</option>
		                                        <option value="4">연구보조비</option>		                                        
	                                </select>									
								<comment id="__NSID__"> <object
									id="txtJAG_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					 </tr>
					<tr>
						<td class="blueBold" align="center">국민연금보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">국민연금이외의<br>
						연금보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">건강보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">고용보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">결정소득세</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">결정주민세</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>원</td>
							</tr>
						</table>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_DUTYPLACE 설정 테이블 -->
<object id="bndT_AC_DUTYPLACE"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_DUTYPLACE">
	<Param Name="BindInfo"
		, Value='
        <C>Col=JAO_NO1          Ctrl=txtJAO_NO1             Param=value     </C>
        <C>Col=JAS_NM1          Ctrl=txtJAS_NM1             Param=value     </C>
        <C>Col=HIR_YMD1         Ctrl=txtHIR_YMD1            Param=value     </C>
        <C>Col=RET_YMD1         Ctrl=txtRET_YMD1            Param=value     </C>
        <C>Col=JAA_AMT1         Ctrl=txtJAA_AMT1            Param=text      </C>
        <C>Col=JAC_AMT1         Ctrl=txtJAC_AMT1            Param=text      </C>
        <C>Col=JAG_AMT1         Ctrl=txtJAG_AMT1            Param=text      </C>
        <C>Col=JAG_CD1         Ctrl=cmbJAG_CD1            Param=value      </C>        
        <C>Col=JAI_AMT1         Ctrl=txtJAI_AMT1            Param=text      </C>
        <C>Col=JAQ_AMT1         Ctrl=txtJAQ_AMT1            Param=text      </C>
        <C>Col=JAR_AMT1         Ctrl=txtJAR_AMT1            Param=text      </C>
        <C>Col=JAH_AMT1         Ctrl=txtJAH_AMT1            Param=text      </C>
        <C>Col=JAP_AMT1         Ctrl=txtJAP_AMT1            Param=text      </C>
        <C>Col=JAL_AMT1         Ctrl=txtJAL_AMT1            Param=text      </C>
        <C>Col=JAN_AMT1         Ctrl=txtJAN_AMT1            Param=text      </C>

        <C>Col=JAO_NO2          Ctrl=txtJAO_NO2             Param=value     </C>
        <C>Col=JAS_NM2          Ctrl=txtJAS_NM2             Param=value     </C>
        <C>Col=HIR_YMD2         Ctrl=txtHIR_YMD2            Param=value     </C>
        <C>Col=RET_YMD2         Ctrl=txtRET_YMD2            Param=value     </C>
        <C>Col=JAA_AMT2         Ctrl=txtJAA_AMT2            Param=text      </C>
        <C>Col=JAC_AMT2         Ctrl=txtJAC_AMT2            Param=text      </C>
        <C>Col=JAG_AMT2         Ctrl=txtJAG_AMT2            Param=text      </C>
        <C>Col=JAG_CD2         Ctrl=cmbJAG_CD2           Param=value      </C>           
        <C>Col=JAI_AMT2         Ctrl=txtJAI_AMT2            Param=text      </C>
        <C>Col=JAQ_AMT2         Ctrl=txtJAQ_AMT2            Param=text      </C>
        <C>Col=JAR_AMT2         Ctrl=txtJAR_AMT2            Param=text      </C>
        <C>Col=JAH_AMT2         Ctrl=txtJAH_AMT2            Param=text      </C>
        <C>Col=JAP_AMT2         Ctrl=txtJAP_AMT2            Param=text      </C>
        <C>Col=JAL_AMT2         Ctrl=txtJAL_AMT2            Param=text      </C>
        <C>Col=JAN_AMT2         Ctrl=txtJAN_AMT2            Param=text      </C>

        <C>Col=JAO_NO3          Ctrl=txtJAO_NO3             Param=value     </C>
        <C>Col=JAS_NM3          Ctrl=txtJAS_NM3             Param=value     </C>
        <C>Col=HIR_YMD3         Ctrl=txtHIR_YMD3            Param=value     </C>
        <C>Col=RET_YMD3         Ctrl=txtRET_YMD3            Param=value     </C>
        <C>Col=JAA_AMT3         Ctrl=txtJAA_AMT3            Param=text      </C>
        <C>Col=JAC_AMT3         Ctrl=txtJAC_AMT3            Param=text      </C>
        <C>Col=JAG_AMT3         Ctrl=txtJAG_AMT3            Param=text      </C>
        <C>Col=JAG_CD3         Ctrl=cmbJAG_CD3           Param=value      </C>           
        <C>Col=JAI_AMT3         Ctrl=txtJAI_AMT3            Param=text      </C>
        <C>Col=JAQ_AMT3         Ctrl=txtJAQ_AMT3            Param=text      </C>
        <C>Col=JAR_AMT3         Ctrl=txtJAR_AMT3            Param=text      </C>
        <C>Col=JAH_AMT3         Ctrl=txtJAH_AMT3            Param=text      </C>
        <C>Col=JAP_AMT3         Ctrl=txtJAP_AMT3            Param=text      </C>
        <C>Col=JAL_AMT3         Ctrl=txtJAL_AMT3            Param=text      </C>
        <C>Col=JAN_AMT3         Ctrl=txtJAN_AMT3            Param=text      </C>
    '>
</object>

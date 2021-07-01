<!--
*****************************************************************************
* @source      : yaca020.jsp                                                     *
* @description : 연말정산자료등록 PAGE                                        *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            조정호             최초작성                                         *
*----------------------------------------------------------------------------
* 2013/12/17            이동훈             수정중                                             *
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%

    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String YAC_AUTHO  = box.getString("SESSION_YAC_AUTHO");
    String ENO_NO    = box.getString("SESSION_ENONO");

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
<title>연말정산자료등록(yaca020)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<link href="/css/general2.css" rel="stylesheet" type="text/css">
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
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "../../servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;

        var dataClassName_01 = "../../servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params_01 = null;

		var submit_chk = "N";
		
        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            //연말정산 조회
            params = "&S_MODE=SHR"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;

            trT_AC_RETACC.KeyValue = "tr"
                                   + "(O:dsT_AC_RETACC=dsT_AC_RETACC"
                                   + ",O:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";
            trT_AC_RETACC.action = dataClassName+params;
            trT_AC_RETACC.post();

            if(dsT_AC_RETACC.CountRow >= 1)
            {

    			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
    				document.getElementById("chkCLS_TAG").checked = true;
    			}else{
    				document.getElementById("chkCLS_TAG").checked = false;
    			}

            fnc_SearchList_01();
       
            document.getElementById("txtSALT_AMT").value  = dsT_AC_RETACC.NameValue(1, "SALT_AMT");
            document.getElementById("txtFREE_INCOME").value = dsT_AC_RETACC.NameValue(1, "FREE_INCOME");
            document.getElementById("txtTAX_INCOME").value = dsT_AC_RETACC.NameValue(1, "TAX_INCOME");
            document.getElementById("txtHOSPT_AMT").value  = dsT_AC_RETACC.NameValue(1, "HOSPT_AMT");
            document.getElementById("txtMIN_CARD_AMT").value  = dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT");

			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == "N"){

				fnc_disableInput();
				
			}else{

				fnc_enableInput();
				
			}

            return;
            
            }
            
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
			document.getElementById("txtADDRESS").disabled = true;
			document.getElementById("txtADDRESS").className = "input_ReadOnly";			
			
	  		//document.getElementById("txtENO_NO_SHR").className = "input_ReadOnly";
	  		//document.getElementById("txtENO_NO_SHR").disabled = true;
	  		//document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";
	  		//document.getElementById("txtENO_NM_SHR").disabled = true;

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

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
                dsT_CM_COMMON_BK.DataID = dataClassName+"&S_MODE=ITM_SHR";
                dsT_CM_COMMON_BK.Reset();
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {

            if(submit_chk == "Y"){

                alert("전산제출하셨습니다.\n담당자에게 문의바랍니다.");
                return;
            } 
            
            if(!fnc_SaveItemCheck()) return;

            //인사기록표 저장
            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SAV_01&ENO_NO="+document.getElementById("txtENO_NO").value+"&HEAD_CD="+document.getElementById("txtHEAD_CD").value+"&DPT_CD="+document.getElementById("txtDPT_CD").value;
            trT_CM_PERSON.post();

            //연말정산 저장
            params = "&S_MODE=SAV"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;

            //DataSet을 입력상태로 변경
            dsT_AC_RETACC.UseChangeInfo = false;
            dsT_AC_DUTYPLACE.UseChangeInfo = false;

            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC"
                                       + ",I:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";
            trT_AC_RETACC_SAV.action = dataClassName+params;
            trT_AC_RETACC_SAV.post();
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
			var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
			var PIS_YYMM = document.getElementById("txtPIS_YY_SHR").value;

			var url = "yaca020_PV.jsp?ENO_NO="+ENO_NO+"&PIS_YYMM=" + PIS_YYMM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("연말정산자료등록", '', 225);
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
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETACC.ClearData();
            dsT_CM_PERSON.ClearData();
            dsT_AC_DUTYPLACE.ClearData();

            dsT_AC_FAMILY.ClearData();    //부양가족사항 clear
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated || dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
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
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

            var oChkElement = null;
            var oElement = null;
            var chkVal   = null;

			if(dsT_AC_RETACC.NameValue(1, "HOL_YN") != "Y" && dsT_AC_RETACC.NameValue(1, "HOL_YN") != "N"){
				    alert("부양가족 화면에서 본인 세대주 여부를 등록 해 주십시요..");
			     	return false;
			}

            if (dsT_AC_RETACC.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                alert("* 저장 할 자료가 없습니다!");
                return false;
            }




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

                    }
                }
            }
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //사번을 로그인한 사번으로 설정한 다음 기본정보를 가져온다.
            document.getElementById("txtENO_NO_SHR").value = "<%=ls_UserId %>";

            if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value =  today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4)-1;
            }

<%
    //관리자가 아닐 경우 타인은 조회가 되지 않게
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";

            fnc_ChangeStateElement(false, "txtADDRESS");
            fnc_ChangeStateElement(false, "ImgZipNo");
            document.getElementById("ImgZipNo").style.display = "none";
			//document.getElementById("imgPrint").style.display = "none";

<%
    }
%>

			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
				document.getElementById("chkCLS_TAG").checked = true;
			}else{
				document.getElementById("chkCLS_TAG").checked = false;
			}
			
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" ){
				alert("전산제출한 상태입니다.\n수정은 불가능합니다.");
			}

			//사원정보를 가져오고 등록한 중간정산 리스트를 가져온다.
            fnc_SearchEmpNo();

            //인적 공제 화면이 제일 먼저 보이게 설정
            fnc_ClickBtn(1);

        	//fnc_SearchList();

            fnc_OnLoadProcess_01();



	            
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
         * 기타 함수              *
         ********************************************/

        //지금 정의되어 있는 항목들
        var oElementList = new Array(    "txtPIS_YY"
                                        ,"cmbBNK_CD");

        //항목들의 메세지
        var oElementMsgList = new Array( "기준연도"
                                        ,"보험회사구분");

        //예외 항목들
        var oExceptionList = new Array(  );

        //Layer ID
        var layerList = new Array(  "layer_1"
                                   ,"layer_2"
                                   ,"layer_3"
                                   ,"layer_4"
                                   ,"layer_5"
                                   ,"layer_6"
                                   ,"layer_7"
                                   ,"layer_9"
                                   ,"layer_10"
                                   ,"layer_11"
                                    );


        /**
         * 선택한 창들을 보여주고 닫는 역활
         */
        function fnc_ClickBtn(selectKey) {
            var indexKey;

            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(layerList, layerList[parseInt(selectKey)-1]);


            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=10; i++) {
                indexKey = lpad(i, 2, "0");
                if(document.getElementById("TabBtn"+indexKey) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft"+indexKey).src         = "/images/common/tabTop.gif";
                document.getElementById("TabBtn"+indexKey).background   = "/images/common/tabMiddle.gif";
                document.getElementById("TabBtn"+indexKey).className    = "tabV";
                document.getElementById("TabRight"+indexKey).src        = "/images/common/tabBottom.gif";
            }

            selectKey = lpad(selectKey, 2, "0");

            document.getElementById("TabLeft"+selectKey).src            = "/images/common/tabTop_over.gif";
            document.getElementById("TabBtn"+selectKey).background      = "/images/common/tabMiddle_over.gif";
            document.getElementById("TabBtn"+selectKey).className       = "tabV_over";
            document.getElementById("TabRight"+selectKey).src           = "/images/common/tabBottom_over.gif";

            fnc_SearchList();
        }


        /**
         * 인적공제 항목 변동 여부
         */
         
        function checkFamily(param) {

            if(dsT_AC_FAMILY.CountRow > 1) {
                alert("등록된 부양가족이 맞는지 확인바랍니다.");
            }			

            var CLS_TAG;
            
            if(document.getElementById("chkCLS_TAG").checked == true) {
            	CLS_TAG = 'Y';
            }else{
            	CLS_TAG = 'N';
            }

            // 인적공제 항목 정보 전년과 동일 체크
     
            //연말정산 저장
            params = "&S_MODE=SAV_CLS"
                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
            		+ "&CLS_TAG="+CLS_TAG;
            
            //DataSet을 입력상태로 변경
            dsT_AC_RETACC.UseChangeInfo = false;

            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
            trT_AC_RETACC_SAV.action = dataClassName+params;
            trT_AC_RETACC_SAV.post();
            
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
            /*
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
            }*/

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
                //document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                //document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                //document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;

            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
                //document.getElementById("txtOCC_NM_SHR").value      = "";
                //document.getElementById("txtDPT_NM_SHR").value      = "";
                //document.getElementById("txtJOB_NM_SHR").value      = "";
            }
        }

        function fnc_UsrpostPopup(zip_no, addr, addr2) {
            var no = document.getElementById(zip_no).value;

            fnc_postPopup(zip_no, addr);

            if (document.getElementById(zip_no).value != "") {
                if (document.getElementById(zip_no).value.substr(3,1) != '-') {
                    document.getElementById(zip_no).value = document.getElementById(zip_no).value.substr(0,3) + '-' + document.getElementById(zip_no).value.substr(3,3);
                }

                if (no != document.getElementById(zip_no).value) {
                    document.getElementById(addr2).value = '';

                    document.getElementById("txtADDRESS").focus();
                }


            }

        }

       function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

       }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }



        /********************************************
         * 									전산제출                         				*
         ********************************************/

        function fnc_Submit() {

        	if(submit_chk == "N"){

	            if(confirm("전산제출 하시면 더이상 수정하실 수 없습니다.\n제출하시겠습니까?")) {
	
	                //연말정산 전산제출
	                params = "&S_MODE=SAV_END"
	                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                   	    + "&SUBMIT_TAG=Y";		                   	
	            
		            //DataSet을 입력상태로 변경
		            dsT_AC_RETACC.UseChangeInfo = false;
		
		            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
		                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
		            trT_AC_RETACC_SAV.action = dataClassName+params;
		            trT_AC_RETACC_SAV.post();
		
		            }
        	}else{

				alert("이미 전산제출하셨습니다.");

<%
//관리자 경우
if(isMaster) {
%>
		            if(confirm("담당자이시군요.\n전산제출을 취소하시겠습니까?")) {

		                //연말정산 전산제출 취소
		                params = "&S_MODE=SAV_END"
		                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
	                   	    + "&SUBMIT_TAG=N";		
                   	                
			            //DataSet을 입력상태로 변경
			            dsT_AC_RETACC.UseChangeInfo = false;
			
			            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
			                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
			            trT_AC_RETACC_SAV.action = dataClassName+params;
			            trT_AC_RETACC_SAV.post();
		            	
					}
		            submit_chk = "N";
		            fnc_SearchList();
			
<%
}
%>
				return;
            }     	
    }
        
        /********************************************
         * 부양가족사항 함수                        *
         ********************************************/

        /* 01. 조회 함수_List 형태의 조회  */
        function fnc_SearchList_01() {
          //  var oPIS_YY = document.getElementById("txtPIS_YY");
          //  var oBNK_CD = document.getElementById("cmbBNK_CD");
           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            params_01 = "&S_MODE=SHR"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO;

            dsT_AC_FAMILY.dataid = dataClassName_01+params_01;
            dsT_AC_FAMILY.reset();
         }


        /* 02. 삭제 함수   */
        function fnc_Delete_01() {


            // 삭제 할 자료가 있는지 체크하고
             if (dsT_AC_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* 삭제 할 자료가 없습니다!");
                return;
              }

             if(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "REL_NM") == "본인"){
                alert("본인 자료는 삭제할 수 없습니다.");
                return false;
             }

             // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
             if (confirm(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "NAM_KOR")+" [" + dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "CET_NO") + "] 자료를 제거하시겠습니까?") == false) return;

             //DataSet을 입력상태로 변경
             dsT_AC_FAMILY.UseChangeInfo = false;

             var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
             var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

             var tmpCnt = dsT_AC_FAMILY.RowPosition-1;

             params_01 = "&S_MODE=DEL"
                     + "&PIS_YY="+PIS_YY
                     + "&ENO_NO="+ENO_NO
                     + "&ROW_ID="+tmpCnt;

             trT_AC_FAMILY.KeyValue = "TR_SAV(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
             trT_AC_FAMILY.Action = dataClassName_01+params_01;
             trT_AC_FAMILY.post();
             fnc_SearchList_01();
         }

         /* 03. 초기화 함수   */
          function fnc_Clear_01() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_FAMILY.ClearData();
          }

          /* 04.  Form Load 시 Default 작업 처리 부분    */
          function fnc_OnLoadProcess_01() {

            cfStyleGrid(form1.grdT_AC_FAMILY,0,"false","false");      // Grid Style 적용

          }

          /* 05.  부양가족사항등록   */
          function fnc_RegFamily() {

              if(submit_chk == "Y"){
                  alert("전산제출하셨습니다.\n담당자에게 문의바랍니다.");
                  return;
              }  

            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            var href_page = "/hr/yac/yaca022.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO;

            window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
           }

           /* 06.  연금저축공제등록   */
          function fnc_RegPension() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca060.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                      
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }


          /* 07.  의료비공제등록   */
          function fnc_RegHospital() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca030.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }
          
          /* 08.  기부금공제등록   */
          function fnc_RegDonation() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca040.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="dsT_CM_PERSON"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_RETACC"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_DUTYPLACE"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)           |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_RETACC"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_CM_PERSON"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_RETACC_SAV"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID ="trT_AC_RETACC_END" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
     <Param Name=KeyName     Value="toinb_dataid4">
     <Param Name=KeyValue    Value="SVL(I:SAV=dsT_AC_RETACC)">
</Object>
<!-----------------------------------------------------+
    | 부양가족 사항                                         |
    1 1. 조회용 DataSet                                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_FAMILY)            |
    | 3. 사용되는 Table List(T_AC_FAMILY)                   |
    +------------------------------------------------------->
<Object ID="dsT_AC_FAMILY_OLD"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_FAMILY"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 부양가족 사항                                        |
    1 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_FAMILY)           |
    | 3. 사용되는 Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_FAMILY"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                  *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            document.getElementById("resultMessage").innerText = "해당 자료가 존재하지 않습니다.";
            dsT_AC_RETACC.ClearData();
            dsT_CM_PERSON.ClearData();
            dsT_AC_DUTYPLACE.ClearData();

            dsT_AC_FAMILY.ClearData();    //부양가족사항 clear

        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            document.getElementById("resultMessage").innerText = "해당 자료를 조회했습니다.";

            //인사기록표 조회
            dsT_CM_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_PERSON.reset();

        }
    </Script>

<Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

        } else {

        }
    </Script>

<Script For=dsT_AC_DUTYPLACE Event="OnLoadCompleted(iCount)">

//        alert(dsT_AC_DUTYPLACE.ColumnID(6)+", "+dsT_AC_DUTYPLACE.ColumnSize(6)+"\n"+
//              dsT_AC_DUTYPLACE.ColumnID(7)+", "+dsT_AC_DUTYPLACE.ColumnSize(7));

        //종전근무지자료를 위해 초기화 시킴
        for(var i=1; i<=3; i++) {
            changePlace(i, false);
        }

        for(var i=1; i<=3; i++) {
            if(dsT_AC_DUTYPLACE.NameString(1, "TYPE"+i) == "X") {
                changePlace(i, true);
            }
        }
    </Script>

<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

<!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnSuccess()">
        //radio 버튼들 선택하기
        fnc_CheckedElement("radHOL_YN", dsT_AC_RETACC.NameValue(1, "HOL_YN"));
        fnc_CheckedElement("radSOU_YN", dsT_AC_RETACC.NameValue(1, "SOU_YN"));
        fnc_CheckedElement("radWCT_YN", dsT_AC_RETACC.NameValue(1, "WCT_YN"));
    </script>

<script for=trT_CM_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

<script for=trT_AC_RETACC_SAV event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
        fnc_SearchList();
    </script>

<script for=trT_AC_RETACC_END event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
        //fnc_SearchList();
    </script>
<!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script>

<script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

<script for=trT_AC_RETACC_SAV event="OnFail()">
        cfErrorMsg(this);
    </script>


<!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_RETACC
	event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_AC_RETACC.CountRow; i++) {
            dsT_AC_RETACC.NameValue(i, "STATUS") = bCheck;
        }

    </script>

<script language=JavaScript for=txtGOV_AMT event=onKillFocus()>

        if(Number(form1.txtGOV_AMT.Text) >= 100000){
            form1.txtGOV_DED.Text = 100000;
        }else{
            form1.txtGOV_DED.Text = Number(form1.txtGOV_AMT.Text);
        }

    </script>

<script language=JavaScript for=txtGOV_NTS event=onKillFocus()>

        if(Number(form1.txtGOV_AMT.Text) >= 100000){
            form1.txtGOV_DED.Text = 100000;
        }else{
            form1.txtGOV_DED.Text = Number(form1.txtGOV_AMT.Text);
        }

    </script>


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
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
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
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");

        fnc_SearchList();
    </script>

<!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
<script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
    </script>


<!-----------------------------------------------------+
    | Grid OnDblClick event 처리                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_FAMILY
	event=OnDblClick(row,colid)>

        var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
        var ENO_NO = document.getElementById("txtENO_NO_SHR").value;


        var href_page = "/hr/yac/yaca022.jsp"
                      + "?TYPE=UPT"
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                      + "&TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      ;

        window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        fnc_SearchList();
    </script>

<!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">
<!-- 파일 전송을 위해 -->
<iframe name="file_down" marginwidth="0" marginheight="0"
	frameborder="0" width="0" height="0" scrolling="no"></iframe>

<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form 시작 -->
<form name="form1"><!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">연말정산자료등록</td>
				<td align="right" class="navigator">HOME/정산세무/연말정산/<font
					color="#000000">연말정산자료등록</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 --> <!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
		
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_submit.gif',1)">
		<img src="/images/button/btn_submit.gif" name="imgSave" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>			

		&nbsp;&nbsp;&nbsp;	
			
		<a href="http://www.yesone.go.kr/index.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNts','','/images/button/btn_NtsOver.gif',1)">
		<img src="/images/button/btn_NtsOn.gif" name="imgNts" width="65" height="20" border="0" align="absmiddle"></a> &nbsp;&nbsp; 
			
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)">
		<img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">
		<img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> 
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">
		<img src="/images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> 
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">
		<img src="/images/button/btn_ExitOn.gif" name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 --> <!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center" class="greenTable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="200"></col>
						<col width="80"></col>
						<col width="140"></col>
						<col width=""></col>
					</colgroup>
					<tr>
						<td align="right" class="searchState">귀속년도&nbsp;</td>
						<td class="padding2423">
						<%
						if (!isMaster) {
						%> <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5"
							class="input_ReadOnly" readonly> <%
 } else {
 %> <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5"> <%
 }
 %>
						</td>

						<td align="right" class="searchState">사번&nbsp;</td>
						<td class="padding2423">
						
						<!--              <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()" style="ime-mode:disabled">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                             --> 
                             <!--  
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}"
							onchange="fnc_GetNm();fnc_SearchList();"onblur="fnc_SearchList();" style="ime-mode:disabled"> 
							
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}"
							onchange="fnc_Getcd();fnc_SearchList();"onblur="fnc_SearchList();"> 
							-->
							
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"> 
							
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}"> 
														
							<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle"
							onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()"
							onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							
							<input type="hidden" id="hidEMPL_DPT_CD">
							</td>
					</tr>
					<!--
                                <tr>
                                    <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
                                    <td class="padding2423">
                                        <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">소&nbsp;&nbsp;&nbsp;속</td>
                                    <td class="padding2423">
                                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;위</td>
                                    <td class="padding2423">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                 -->
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 --> <!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="bottom" class="searchState"><span
					id="resultMessage">&nbsp;</span></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 --> <!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="40"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width="60"></col>
				<col width="55"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width=""></col>
			</colgroup>
			<tr>
				<!--  
				<td align="center" class="creamBold">직종</td>
				<td class="padding2423"><input id="txtOCC_NM"
					style="width:100%;" class="input_ReadOnly" readonly></td>
				-->		
				<td align="center" class="creamBold">소속</td>
				<td class="padding2423">
				<input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="creamBold">직위</td>
				<td class="padding2423">
				<input id="txtJOB_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<!--  
				<td align="center" class="creamBold">주민번호</td>
				<td class="padding2423">
				<input id="txtCET_NO" style="width:100%;" class="input_ReadOnly" readonly></td>
				-->
				<td align="center" class="creamBold">우편번호</td>
				<td class="padding2423">
				<input id="txtZIP_NO" size="7" maxlength="7" class="input_ReadOnly" readonly> 
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','/images/button/btn_HelpOver.gif',1)">
				<img src="/images/button/btn_HelpOn.gif" id="ImgZipNo" name="ImgZipNo" width="21" height="20" border="0" align="absmiddle"
					onClick="fnc_UsrpostPopup('txtZIP_NO','txtADR_CT','txtADDRESS')"></a>
				</td>
				<td align="center" class="creamBold">주소</td>
				<td class="padding2423">
				<input id="txtADR_CT" style="width:45%" class="input_ReadOnly" readonly> 
					<input id="txtADDRESS" maxlength="60" style="width:45%"> 
					<input type=hidden id="txtENO_NO"> 
					<input type=hidden id="txtHEAD_CD"> 
					<input type=hidden id="txtDPT_CD">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 --> 

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->



<table width="800" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="130" valign="top" style="padding:7 0 0 0"><!--tab테이블시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft01"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn01" onclick="fnc_ClickBtn(1)"
							style="cursor:hand;">부양가족사항<font color = "blue">(입력)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight01"></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft10"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn10" onclick="fnc_ClickBtn(10)"
							style="cursor:hand;">종전근무지<font color = "blue">(입력)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight10"></td>
					</tr>
				</table>
				</td>
			</tr>

			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn11" onclick="fnc_RegHospital()"
							style="cursor:hand;">의료비공제<font color = "blue">(입력)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>			
						
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn11" onclick="fnc_RegDonation()"
							style="cursor:hand;">기부금공제<font color = "blue">(입력)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn11" onclick="fnc_RegPension()"
							style="cursor:hand;">연금/주택마련/장기주식형저축<font color = "blue">(입력)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>			
			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30" style="cursor:hand;"></td>
					</tr>
				</table>
				</td>
			</tr>
						
			
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft02"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn02" onclick="fnc_ClickBtn(2)"
							style="cursor:hand;">인적공제</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight02"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft03"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn03" onclick="fnc_ClickBtn(3)"
							style="cursor:hand;">특별공제-보험료</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight03"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft04"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn04" onclick="fnc_ClickBtn(4)"
							style="cursor:hand;">특별공제-의료비</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight04"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft05"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn05" onclick="fnc_ClickBtn(5)"
							style="cursor:hand;">특별공제-교육비</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight05"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft06"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn06" onclick="fnc_ClickBtn(6)"
							style="cursor:hand;">특별공제-주택자금</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight06"></td>
					</tr>
				</table>
				</td>
			</tr>
			
			<!-- 
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="5" style="cursor:hand;"></td>
					</tr>
				</table>
				</td>
			</tr>
			
			 -->
			 
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft07"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn07" onclick="fnc_ClickBtn(7)"
							style="cursor:hand;">특별공제-기부금</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight07"></td>
					</tr>
				</table>
				</td>
			</tr>
	<!-- 		<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft08"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn08" onclick="fnc_ClickBtn(8)"
							style="cursor:hand;">특별공제-기타</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight08"></td>
					</tr>
				</table>
				</td>
			</tr>
	-->
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft08"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn08" onclick="fnc_ClickBtn(8)"
							style="cursor:hand;">기타소득공제</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight08"></td>
					</tr>
				</table>
				</td>
			</tr>
			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30" style="cursor:hand;"></td>
					</tr>
				</table>
				</td>
			</tr>
						
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft09"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn09" onclick="fnc_ClickBtn(9)"
							style="cursor:hand;">세액공제</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight09"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<!--tab테이블 끝 --></td>
		
		
		
		<td valign="top">
		<!-- Layer 들 --> 
		<!--탭의 프레임 시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" height="5"><img
					src="/images/common/arcGray01.gif" width="5" height="5"></td>
				<td background="/images/common/arcGray02.gif"></td>
				<td width="5" background="/images/common/arcGray03.gif"></td>
			</tr>
			<tr>
				<td width="5" background="/images/common/arcGray04.gif"></td>
				<!-- 최소 높이가 350은 되어야합니다.높이 조절할필요 없습니다. 패팅이 먹혀 있기 때문에 -->
				<td height="520" valign="top" bgcolor="#FFFFFF" style="padding:15">


				<!-- 부양가족공제 -->
				<div id="layer_1"
					style="position:absolute; visibility:hidden; display:none; display:none; width:865px; z-index:1;">

				<!-- 버튼 테이블 시작 -->
				<table width="860" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="35" class="paddingTop1" align="left">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFamilyRegistration','','/images/common/btnFamilyRegistration.gif',1)">
						<img src="/images/common/btnFamilyRegistration.gif" name="imgFamilyRegistration" width="130" height="25" border="0" align="absmiddle" 
							onClick="fnc_RegFamily()">
						</a></td>
						<td height="35" class="paddingTop5" align="right">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)">
						<img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle"
							onClick="fnc_SearchList_01()">
						</a> 
					<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)">
						<img src="/images/button/btn_CancelOn.gif" name="ImgClear" width="60" height="20" border="0" align="absmiddle"
							onClick="fnc_Clear_01()">
						</a> 
					-->		
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)">
						<img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle"
							onClick="fnc_Delete_01()">
						</a>
					<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit_01()"></a> -->
						</td>
					</tr>
				</table>
				<!-- 버튼 테이블 끝 --> <!-- 조회 상태 테이블 시작 -->
				<table width="860" border="0" cellspacing="0" cellpadding="0">

							<tr>
								<td align="right" valign="bottom" class="searchState">
									<input type="checkbox" name="chkCLS_TAG" id="chkCLS_TAG" onclick="checkFamily(this)" style="border:0">선택
								</td>
					
								<td align="left" valign="bottom" class="searchState">
								<font color = "blue">
								※인적공제 항목이 전년과 동일한 경우에만 체크
								</font>
								</td>
								<td align="right" valign="bottom" class="searchState">
								※상세내역을 원하시면 해당내역을 더블클릭</td>
							</tr>
				</table>
				<!-- 조회 상태 테이블 끝 --> <!-- 내용 조회 그리드 테이블 시작-->
				<table width="860" border="0" cellspacing="0" cellpadding="0">

							<tr align="center">
								<td>
								<comment id="__NSID__"> 
								<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B"
									style="width:860px;height:435px;">
									<param name="DataID" 				value="dsT_AC_FAMILY">
									<param name="Editable" 			value="false">
									<param name="DragDropEnable" 	value="true">
									<param name="SortView" 			value="Left">
									<param name="Format"
										value='
                                          <FC> id=NO     			width=24        align=center       name=NO                suppress=2  </FC>
                                          <FC> id=REL_NM      	width=107      align=left	       name=관계              	suppress=2  </FC>
                                          <FC> id=NAM_KOR     width=55        align=center       name=성명              	suppress=2  </FC>
                                          <C> id=CET_NO       	width=95        align=center       name=주민번호          	suppress=2  </C>
                                          <C> id=BAS_MAN      	width=40        align=center       name="기본;공제"      suppress=2  </C>
                                          <C> id=GOL_70       	width=40        align=center       name=경로              	suppress=2  </C>
                                          <C> id=TRB_MAN      	width=40        align=center       name=장애인            	suppress=2  </C>
                                          <C> id=WCT_MAN      width=40        align=center       name=부녀자            	suppress=2  </C>
                                          <C> id=RCH_MAN      	width=40        align=center       name="자녀;양육"      suppress=2  </C>
                                          <C> id=CHI_MAN      	width=40        align=center       name=다자녀            	suppress=2  </C>
                                          <C> id=INP_MAN      	width=40        align=center       name="출생;입양"      suppress=2  </C>

                                          <C> id=GBN_NM       		width=70        align=center     name=구분                </C>
                                          <C> id=LIN_AMT      		width=70        align=right        name=보험료              </C>
                                          <C> id=MED_AMT      		width=70        align=right        name=의료비              show=false</C>
                                          <C> id=EDU_AMT      		width=70        align=right        name=교육비              </C>
                                          
                                          <G> name=신용카드등    HeadBgColor=#F7DCBB                                          
                                          <C> id=CARD_AMT     		width=100       align=right        name="신용카드;(전통시장제외)"   </C>
                                          <C> id=DIR_CARD_AMT 	width=100       align=right        name="직불/선불카드;(전통시장제외)"  </C>
                                          <C> id=SCH_AMT      		width=100       align=right        name="학원비;지로납부" </C>
                                          <C> id=CASH_AMT     	width=100       align=right        name="현금영수증;(전통시장제외)"  </C>
                                          <C> id=MARKET_AMT     	width=100       align=right        name=전통시장사용   </C>
                                          </G>
                                                                                    
                                          <G> name=기부금     HeadBgColor=#F7DCBB
                                           <C> id=LC3_AMT      		width=70        align=right       name=법정기부금      show=false</C>
                                           <C> id=LC1_AMT      		width=70        align=right       name=특례기부금      show=false</C>
                                           <C> id=LC2_AMT      		width=70        align=right       name=지정기부금      show=false</C>
                                           <C> id=LC4_AMT      		width=70        align=right       name=종교기부금      show=false</C>
                                          </G>
                                          <G> name=주택자금   HeadBgColor=#F7DCBB 
                                           <C> id=LH1_AMT      		width=120        align=right      name=주택임차원리금상환  show=false</C>
                                           <C> id=LH2_AMT04    	width=120        align=right      name="장기주택차입이자액;(10년~15년)"  show=false</C>
                                           <C> id=LH2_AMT      		width=120        align=right      name="장기주택차입이자액;(15년~30년)"  show=false</C>
                                           <C> id=LH4_AMT      		width=120        align=right      name="장기주택차입이자액;(30년이상)"  show=false</C>
                                          </G>
					                   	'>
								</object> </comment><script> __ShowEmbedObject(__NSID__); </script></td>
							</tr>

				</table>
				<!-- 내용 조회 그리드 데이블 끝-->
				</div>
				
				
				
				
				<!-- 종전근무지자료 -->
				<div id="layer_11"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:10;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 종전근무지자료</td>
						<td>
						-2012년 계속 근무하신 분은 해당되지 않습니다. 중도입사자만 해당됩니다.<br>
						-2012년 과세기간 중에 근무경력이 있는 종전근무지에 대한 자료 입력</td>
					</tr>
					<tr>
						<td colspan="2" height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="120"></col>
						<col width="158"></col>
						<col width="158"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center"></td>
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
						<td class="creamBold" align="center">법인명(회사명)</td>
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
						<td class="creamBold" align="center">사업자등록번호</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO1"
							id="txtJAO_NO1" size="13" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled"  onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO2"
							id="txtJAO_NO2" size="13" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO3"
							id="txtJAO_NO3" size="13" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">당해근무기간</td>
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
						<td class="creamBold" align="center">국내급여총액</td>
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
						<td class="creamBold" align="center">국내상여총액</td>
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
						<td class="creamBold" align="center">인정상여총액</td>
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
						<td class="creamBold" align="center">비과세소득</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
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
								<td><comment id="__NSID__"> <object
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
								<td><comment id="__NSID__"> <object
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
						<td class="creamBold" align="center">국민연금보험료</td>
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
						<td class="creamBold" align="center">국민연금이외의<br>
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
						<td class="creamBold" align="center">건강보험료</td>
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
						<td class="creamBold" align="center">고용보험료</td>
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
						<td class="creamBold" align="center">결정소득세</td>
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
						<td class="creamBold" align="center">결정주민세</td>
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
				</div>
				<!-- 종전근무지자료 -->				
				
				
				
				<!-- 부양가족공제 --> 
				<!-- 인적공제 -->
				<div id="layer_2"
					style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td class="tabTitle" valign="bottom"><img
							src="/images/common/arrowGreen.gif" width="8" height="15"
							align="absmiddle"> 기본공제</td>
						<!-- <td width="110"><img src="/images/common/btnFamily.gif" width="110" height="25" border="0" onclick="fnc_RegFamily()" style="cursor:hand;"></td> -->
					</tr>
					<tr>
						<td colspan="2" height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">본인세대주</td>
						<td class="padding2423">
						<input type="radio" name="radHOL_YN"
							id="radHOL_YN" style="border:0" value='Y' disabled>예
						&nbsp;&nbsp;<input type="radio" name="radHOL_YN" id="radHOL_YN"
							style="border:0" value='N' disabled>아니요</td>
						</td>

						<td class="padding2423">-본인 세대주 여부</td>


					</tr>
					<tr>
						<td class="creamBold" align="center">배우자공제</td>
						<td class="padding2423"><input type="radio" name="radSOU_YN"
							id="radSOU_YN" style="border:0" value="Y" disabled>예
						&nbsp;&nbsp;<input type="radio" name="radSOU_YN" id="radSOU_YN"
							style="border:0" value="N" disabled>아니요</td>
						<td class="padding2423">-연간소득금액이 100만원 이하인자</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">부양가족공제</td>
						<td class="padding2423" valign="top"><input type="text"
							name="txtDFM_CNT" id="txtDFM_CNT" size="3"
							style="text-align:right;" readonly class="input_ReadOnly">
						명</td>
						<td class="padding2423">-근로자와 생계를 같이하는 부양가족으로 연소득 100만원 이하<br>
						-장애인은 연령제한 없으나 연간소득 100만원 이내<br>
						-만 60세이상 (1952.12.31 이전 출생) 본인 또는 <br>&nbsp;배우자 직계존속<br>
						-자녀/입양자 만 20세이하 (1992.1.1 이후 출생)<br>
						-위탁아동의 경우 만 18세 미만 (1995.1.1 이후 출생)<br>
						-만 20세이하 또는 만 60세이상의 형제자매<br>
						</td>
					</tr>
				</table>
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 추가공제</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center" rowspan="1" valign="top"
							style="padding-top:4px">경로우대공제</td>
						<td class="padding2423"><input type="text"
							name="txtGOL_CNT70" id="txtGOL_CNT70" size="3"
							style="text-align:right;" readonly class="input_ReadOnly">
						명</td>
						<td class="padding2423">-기본공제대상자로 만 70세이상 (1942.12.31 이전 출생)</td>
					</tr>
	<!--   				<tr>
	  					<td class="padding2423"><input type="text"
							name="txtGOL_CNT65" id="txtGOL_CNT65" size="3"
							style="text-align:right;" readonly class="input_ReadOnly">
						명</td>
						<td class="padding2423">-65세이상(1943.12.31 이전 출생) 69세이하인 공제대상
						</td>
					</tr>
    -->
     				<tr>
						<td class="creamBold" align="center">장애인공제</td>
						<td class="padding2423"><input type="text" name="txtTRB_CNT"
							id="txtTRB_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> 명</td>
						<td class="padding2423">-기본공제대상자가 장애인인 경우</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">부녀자공제</td>
						<td class="padding2423"><input type="radio" name="radWCT_YN"
							id="radWCT_YN" style="border:0" value="Y" disabled>예
						&nbsp; <input type="radio" name="radWCT_YN" id="radWCT_YN"
							style="border:0" value="N" disabled>아니요</td>
						<td class="padding2423">-부양가족이 있는 부녀자세대주이거나 배우자가 있는 여성</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">자녀양육비공제</td>
						<td class="padding2423"><input type="text" name="txtRCH_CNT"
							id="txtRCH_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> 명</td>
						<td class="padding2423">-만 6세이하 (2006.01.01 이후 출생)의 자녀를 둔 근로소득자
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">다자녀추가공제<br>
						(자녀수)</td>
						<td class="padding2423"><input type="text" name="txtCHI_CNT"
							id="txtCHI_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> 명</td>
						<td class="padding2423">-만 20세이하 (1992.01.01 이후 출생) 자녀가 2인인
						경우 <br>&nbsp;연 100만원, 2인을 초과하는 경우 1인당 연 200만원 추가공제</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">출생·입양공제</td>
						<td class="padding2423"><input type="text" name="txtINP_CNT"
							id="txtINP_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> 명</td>
						<td class="padding2423">-2012년 직계비속 출생 또는 입양신고 입양자 (위탁아동제외)</td>
					</tr>
				</table>
				</div>
				
				
				<!-- 인적공제 --> 
				<!-- 특별공제-보험료 -->
				<div id="layer_3"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:2;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 연금보험료공제</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">국민연금보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtNPEN_AMT"
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
						<!-- <td class="padding2423" rowspan="2"> -->
						<td class="padding2423">-국민연금, 공무원연금, 군인연금 등 근로자 본인부담액</td>
					</tr>
					<!--
                                <tr>
                                    <td class="creamBold" align="center">국민연금이외의<br>연금보험료</td>
                                    <td class="padding2423">
                                        <table><tr>
                                        <td>
                                            <comment id="__NSID__">
                                            <object id="txtEPEN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                                <param name=Alignment               value=2>
                                                <param name=Border                  value=true>
                                                <param name=ClipMode                value=true>
                                                <param name=DisabledBackColor       value="#EEEEEE">
                                                <param name=Enable                  value=true>
                                                <param name=IsComma                 value=true>
                                                <param name=Language                value=0>
                                                <param name=MaxLength               value=8>
                                                <param name=Numeric                 value=true>
                                                <param name=NumericRange            value=-~+:0>
                                                <param name=ShowLiteral             value=false>
                                                <param name=Visible                 value=true>
                                                <param name=SelectAll               value="true">
                                            </object>
                                            </comment>
                                            <script> __ShowEmbedObject(__NSID__); </script>
                                        </td>
                                        <td>원</td>
                                        </tr></table>
                                    </td>
                                </tr>
                                -->
				</table>
				<br>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 특별공제-보험료</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">국민건강보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtHINU_AMT"
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
						<td class="padding2423">-급여에서 원천징수된 국민건강보험료</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">노인장기요양보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtOLD_AMT"
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
						<td class="padding2423">-노인장기요양보험법에 따라 근로자가 부담하는 보험료</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">고용보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtHINS_AMT"
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
						<td class="padding2423">-급여에서 원천징수된 고용보험료</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">보장성보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLIN_AMT"
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
						<td class="padding2423">-보장성 보험이면서 피보험자가 기본공제대상자<br>
						-근로자 본인 또는 소득이 없는 가족이 계약한 보험의 보험료</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">장애인전용보험료</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLIH_AMT"
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
						<td class="padding2423">-기본공제대상자 중 장애인을 피보험자로 장애인 전용 <br>&nbsp;보장성 보험의 보험료</td>
					</tr>
				</table>
				</div>
				
				
				<!-- 특별공제-보험료 --> 
				<!-- 특별공제-의료비 -->
				<div id="layer_4"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:3;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 특별공제-의료비</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="67"></col>
						<col width="98"></col>
						<col width="91"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
					    <td class="creamBold" align="center" rowspan="2">전액공제</td>
						<td class="creamBold" align="center"  colspan="1">본인의료비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtMHEA_AMT"
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
						<td class="padding2423">-공제대상의료비에 포함된 본인을 위해 지출한 의료비</td>
					</tr>
					<!--  
					<tr>
						<td class="creamBold" align="center" colspan="1">본인<br>시력보정의료비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT"
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
						<td class="padding2423">-시력보정용 안경 또는 콘텍트렌즈 구입을 위해
						지출한<br>&nbsp;비용으로 1인당 연 50만원 이내 금액에서 공제<br>
     				</tr>
     				-->
     				<tr>
						<td class="creamBold" align="center" colspan="1">65세이상/<BR>장애의료비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLF2_AMT"
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
						<td class="padding2423">-장애인의 재활이나 65세 이상자를 위해 지급한 의료비</td>
					</tr>


					<tr>
				   		<td class="creamBold" align="center" rowspan="1">한도공제</td>
						<td class="creamBold" align="center" colspan="1">일반의료비<br>(본인外)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtOHEA_AMT"
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
						<td class="padding2423">-공제대상의료비에 포함되며 근로자가 본인 이외의 <br>&nbsp;기본공제대상자를
						위해 지급한 의료비<br>
						</td>
					</tr>
	<!-- 				<tr>
						<td class="creamBold" align="center" colspan="2">노인장기요양비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtOLD_MED_AMT"
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
						<td class="padding2423">-노인장기요양보험법에 따른 장기요양급여 비용중 실제 지출한
						'본인일부 부담금' </td>
					</tr>
          -->
					<!--	-기본공제대상자의 시력보정용 의료비 영수증 금액을 각각의 입력창에 한건씩 입력</td>  -->
			<!--  <tr>
						<td class="creamBold" align="center">시력보정용의료비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT2"
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

						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT3"
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

						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT4"
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

						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT5"
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
					</tr>-->
				</table>
				</div>
				<!-- 특별공제-의료비 --> 
				
				
				<!-- 특별공제-교육비 -->
				<div id="layer_5"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:4;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 특별공제-교육비</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="180"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">본인교육비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGRA_AMT"
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
						<td class="padding2423">-본인을 위해 지출한 교육비(대학/대학원 전액공제)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">가족교육비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><select id="cmbEDU_TAG1" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">취학前</option>
									<option value="2">초중고</option>
									<option value="3">대학교</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT1"
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

						<table>
							<tr>
								<td><select id="cmbEDU_TAG2" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">취학前</option>
									<option value="2">초중고</option>
									<option value="3">대학교</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT2"
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

						<table>
							<tr>
								<td><select id="cmbEDU_TAG3" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">취학前</option>
									<option value="2">초중고</option>
									<option value="3">대학교</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT3"
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

						<table>
							<tr>
								<td><select id="cmbEDU_TAG4" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">취학前</option>
									<option value="2">초중고</option>
									<option value="3">대학교</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT4"
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

						<table>
							<tr>
								<td><select id="cmbEDU_TAG5" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">취학前</option>
									<option value="2">초중고</option>
									<option value="3">대학교</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT5"
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
						<td class="padding2423">-기본공제대상자(소득금액 연100만원 이내, 연령<br>&nbsp;제한 없음)
						 을 위해 지출한 개인별 교육비<br>
						-취학전 자녀를 위해 지출한 영유아시설 보육비<br>
						-유치원 초중고 대학교 및 평생교육법에 의한<br>&nbsp;원격대학 교육비<br>
						-급식비/학교교과서비/보충수업비(교재구입비 제외)<br>
						-중 고등학교 교복구입비(1인당 50만원한도,<br>&nbsp;구입영수증첨부) </td>
					</tr>
					<tr>
						<td class="creamBold" align="center">장애인특수교육비</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtHED_AMT"
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
						<td class="padding2423">-기본공제대상자인 장애인을 위하여 사회복지시설<br>&nbsp;또는 비영리법인에
						지출한 특수교육비</td>
					</tr>
				</table>
				</div>
				<!-- 특별공제-교육비 --> 
				
				
				<!-- 특별공제-주택자금 -->
				<div id="layer_6"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:5;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 특별공제-주택자금</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="75"></col>
						<col width="75"></col>		
						<col width="75"></col>												
						<col width="85"></col>
						<col width="*"></col>
					</colgroup>

					<tr>
						<td class="creamBold" align="center" rowspan="2" colspan="2">주택임차<br>원리금상환</td>				
						<td class="creamBold" align="center">대출기관</td>						
						<td class="padding2423" align="left">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH1_AMT"
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
						-12.31. 현재 무주택 세대주일 것<br>
						&nbsp;국민주택규모의 주택을 임차하기 위한 것일 것<br>
						</td>
					</tr>
					
					<tr>
						<td class="creamBold" align="center" >개인간</td>						
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH5_AMT"
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
						-12.31. 현재 무주택 세대주일 것<br>
						&nbsp;국민주택규모의 주택을 임차하기 위한 것일 것<br>
						&nbsp;2012년 연간 총급여액이 5,000만원 이하인 사람<br>
						&nbsp;연4.0%보다 낮은 이자로 차입한 자금이 아닐 것</td>
					</tr>					
					
					<tr>
						<td class="creamBold" align="center" colspan="3">월세액</td>			
							
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH6_AMT"
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
						<td class="padding2423">-12.31. 현재 무주택 세대주일 것<br>
						&nbsp;2012년 연간 총급여액이 5,000만원 이하인 사람<br> 
						&nbsp;국민주택규모의 주택을 임차하기 위한 것일 것
					</tr>					
					
					<tr>
						<td class="creamBold" align="center" rowspan="5">장기주택<br>저당차입금</td>
						<td class="creamBold" align="center" rowspan="3">2011년<br>이전차입분</td>						
						<td class="creamBold" align="center">15년 미만</td>						
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH2_AMT04"
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
						<td class="padding2423">-상환기간 15년 미만인 차입금 이자상환액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">15년~29년</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH2_AMT"
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
						<td class="padding2423" rowspan="1">-상환기간 15년~29년인 차입금 이자상환액</td>
					</tr>

					<tr>
						<td class="creamBold" align="center">30년 이상</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH4_AMT"
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
						<td class="padding2423" rowspan="1">-상환기간 30년 이상인 차입금 이자상환액</td>
					</tr>


					<tr>
						<td class="creamBold" align="center" rowspan="2">2012년<br>이후차입분</td>									
						<td class="creamBold" align="center">고정금리<br>비거치식</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH7_AMT"
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
						<td class="padding2423" rowspan="1">-장기주택저당차입금의 70%이상을 고정금리로<br>  
						&nbsp;지급하거나  비거치식  분할상환방식으로 <br> 
						&nbsp;지급하는 경우</td>
					</tr>
					
					<tr>
						<td class="creamBold" align="center">기타 대출</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH8_AMT"
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
						<td class="padding2423" rowspan="1">-고정금리/비거치식이 아닌 일반적인 경우</td>
					</tr>					




				</table>
				</div>
				<!-- 특별공제-주택자금 --> 
				
				
				<!-- 특별공제-기부금 -->
				<div id="layer_7"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:6;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 특별공제-기부금</td>
    					</tr>
					<tr>
						<td colspan="2" height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">법정기부금</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC3_AMT"
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
						<td class="padding2423">-국방헌금, 수재의연금, 국가 또는 사립학교의 시설비등에 <br>&nbsp;기부한
						금액, 특별재난지역에 제공한 용역</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">정치자금기부금</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGOV_AMT"
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
						<td class="padding2423">-정치자금기부금액(정당, 후원회, 선거관리위원회)</td>
					</tr>
					
					<!--  
					<tr>
						<td class="creamBold" align="center">특례기부금(50%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC1_AMT"
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
						<td class="padding2423">-문화예술진흥기금, 국립암센터 등에 기부한 금액</td>
					</tr>
					-->
					
					<tr>
						<td class="creamBold" align="center">지정기부금(15%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC2_AMT"
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
						<td class="padding2423">-비영리법인에 기부한 금액(사회복지법인, 문화.예술단체 등)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">종교기부금(10%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC4_AMT"
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
						<td class="padding2423" rowspan="2">-비영리법인에 기부한 금액(교회, 성당,
						사찰)</td>
					</tr>
				</table>

				<br>
<!--
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 국세청 자료</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">전액공제기부금</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC3_NTS"
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
						<td class="padding2423">-국방헌금, 수재의연금, 국가 또는 사립학교의 시설비등에 기부한
						금액, 특별내잔지역에 제공한 용역</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">정치자금기부금</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGOV_NTS"
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
						<td class="padding2423">-정치자금기부금액(정당, 후원회, 선거관리위원회)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">특례기부금(50%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC1_NTS"
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
						<td class="padding2423">-문화예술진흥기금, 구립암센터 등에 기부한 금액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">지정기부금</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC2_NTS"
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
						<td class="padding2423" rowspan="2">-비영리법인에 기부한 금액(교회, 성당,
						사찰)</td>
					</tr>
				</table> -->
				</div>


				<!-- 특별공제-기부금 --> <!-- 특별공제-기타 -->
	<!--  	       <div id="layer_8"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:7;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 특별공제-기타</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">예식비 공제</td>
						<td class="padding2423"><input type="text" name="txtWED_CNT"
							id="txtWED_CNT" size="9" maxlength="1" style="text-align:right;"
							style="ime-mode:disabled" onkeypress="cfCheckNumber();">
						건</td>
						<td class="padding2423">-연간소득이 2500만원 이하인 근로소득자가 지출한 본인 및
						부양가족의 예식비<br>
						(자녀 20세 이하, 각각 60세 55세 이상의 부모)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">이사비 공제</td>
						<td class="padding2423"><input type="text" name="txtMOV_CNT"
							id="txtMOV_CNT" size="9" maxlength="1" style="text-align:right;"
							style="ime-mode:disabled" onkeypress="cfCheckNumber();">
						건</td>
						<td class="padding2423">-연간소득이 2500만원 이하인 근로소득자가 당해 거주지 주소
						이동에 따라 지출한 이사비 -생계를 같이하는 가족이 있는 경우에는 그 가족과 함께 주소를 이동한 것에 한함(단독분가
						공제불가)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">장례비 공제</td>
						<td class="padding2423"><input type="text" name="txtFUN_CNT"
							id="txtFUN_CNT" size="9" maxlength="1" style="text-align:right;"
							style="ime-mode:disabled" onkeypress="cfCheckNumber();">
						건</td>
						<td class="padding2423">-연간소득이 2500만원 이하인 근로소득자가 당해 기본공제대상자의
						장례를 위해 지출한 비용</td>
					</tr>
				</table>
				</div>
         -->

				<!-- 특별공제-기타 --> 
				<!-- 기타소득공제 -->
				<div id="layer_9"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:8;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 기타소득공제</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="70"></col>
						<col width="80"></col>
						<col width="109"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center" colspan="2">개인연금저축액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLF1_AMT"
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
						<td class="padding2423">-2000.12.31 이전 가입자의 개인연금저축액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">연금저축액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtANN_AMT"
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
						<td class="padding2423">-2001.01.01 이후 가입자의 연금저축액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">청약저축</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHO_AMT"
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
						<td class="padding2423">-2009.12.31 이전 가입한 경우 월 납입액이 10만원 이하일 것<br>
									            -2010.1.1 이후 가입한 경우 월 납입액 제한 없음, <br>&nbsp;단 10만원을 초과한 경우
										          그 초과금액은 공제대상에서 제외
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">주택청약종합저축</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHP_AMT"
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
						<td class="padding2423">-과세연도 중 주택을 소유하지 아니한 세대의 세대주가 <br>&nbsp;납입한 주택청약종합저축액<br>
						-월 납입액이 10만원을 초과하는 경우 그 초과금액은 <br>&nbsp;공제대상에서 제외<br>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">장기주택마련저축</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHQ_AMT"
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
						<td class="padding2423">-세대주 또는 단독세대주로서 연간 주택마련저축 불입<br>
						-장기주택마련저축은 09.12.31까지 가입자중 총급여가 <br>&nbsp;8800만원 이하인 자<br>
						-2010.1.1 이후 가입자는 소득공제 불가능
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">근로자주택마련저축</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHR_AMT"
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
						<td class="padding2423">-세대주 또는 단독세대주로서 연간 주택마련저축 불입<br></td>
					</tr>
					
					<!--  
					<tr>
						<td class="creamBold" align="center" colspan="2">투자조합출자액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtVEN2_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=true>
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
						<td class="padding2423">-2009년 이후 출자 또는 투자한 금액</td>
					</tr>
					-->
					
					
					<tr>
						<td class="creamBold" align="center" rowspan="5">신용카드</td>
						<td class="creamBold" align="center" colspan="1">신용카드</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtCARD_AMT"
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
						<td class="padding2423">-신용카드등의 금액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">직(선)불카드</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtDIR_CARD_AMT"
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
						<td class="padding2423">-직불(체크)카드/선불카드</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">지로납부액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGIRO_AMT"
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
						<td class="padding2423">-학원비 지로납부금액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">현금영수증</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtCASH_AMT"
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
						<td class="padding2423">-현금영수증 금액</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">전통시장</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> 
								<object id="txtMARKET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
						<td class="padding2423">-전통시장</td>
					</tr>

					<tr>
						<td class="creamBold" align="center" rowspan="3">장기주식형저축</td>
						
						<!--  
						<td class="creamBold" align="center">1년차불입액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtSTOCK_AMT1"
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
						<td class="padding2423">-펀드자산의 60%이상을 국내주식에 투자하는 주식형펀드<br>
						 -2008.10.20부터 2009.12.31까지 가입자에 한 함<br>
						 -1년차 불입액에 대해 20% 소득공제<br>
						 -모든 금융기관에 가입한 장기주식형저축의 합게액이 분기마다 300만원 초과 불가능
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">2년차불입액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtSTOCK_AMT2"
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
						<td class="padding2423">-2년차 불입액에 대해 10% 소득공제</td>
					</tr>
					<tr>
					-->					
						<td class="creamBold" align="center">3년차불입액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtSTOCK_AMT3"
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
						<td class="padding2423">-3년차 불입액에 대해 5% 소득공제</td>
					</tr>

				</table>
				</div>
				
		
				
				<!-- 기타소득공제 --> 
				<!-- 세액공제 -->
				<div id="layer_10"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:9;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> 세액공제</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">주택차입금이자세액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLST_AMT"
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
						<td class="padding2423">-무주택 또는 1주택만을 소유하는 세대주인 근로자가 1995.11.01-1997.12.31기간
						중 <font color="red"><B>미분양주택</B></font>의 취득과 관련하여 1995.11.01 이후 차입한 대출금의 이자상환액</td>
					</tr>
					
					<!--   을종 근로자만 받을 수 있는 세액공제, 우리는 갑종 근로자만 있으므로 해당사항 없음
					<tr>
						<td class="creamBold" align="center">납세조합세액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtTMP1_AMT"
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
						<td class="padding2423">-납세조합에 의하여 원천징수된 근로소득의 세액공제</td>
					</tr>
					-->					
					<tr>
						<td class="creamBold" align="center">기부정치자금세액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGOV_DED"
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
						<td class="padding2423">-금년 납부한 정치자금기부금 중 10만원 범위</td>
					</tr>
					<!--  
					<tr>
						<td class="creamBold" align="center" rowspan="2">외국납부세액</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtPAYO_SUM"
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
						<td class="padding2423">-국외에서 근로를 제공하고 받은 국외근로소득</td>
					</tr>
					<tr>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLSQ_AMT"
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
						<td class="padding2423">-국외에서 납부하였거나 납부할 소득세액</td>
					</tr>
					-->
				</table>
				</div>
				<!-- 세액공제 --> 

				</td>
				<td width="5" background="/images/common/arcGray05.gif"></td>
			</tr>
			<tr>
				<td height="5" background="/images/common/arcGray06.gif"></td>
				<td background="/images/common/arcGray07.gif"></td>
				<td background="/images/common/arcGray08.gif"></td>
			</tr>
		</table>
		<!--탭의 프레임 끝 --> 
		<!-- Layer 들 -->
		</td>
	</tr>
</table>
<br>    <!--총급여 표시 -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">

                    <tr>
                    <td class="padding2423">- 총근로소득액은&nbsp;
                        <input name=txtSALT_AMT id=txtSALT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원이며 이중 비과세(소득외)소득은 
                        <input name=txtFREE_INCOME id=txtFREE_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원이고 과세대상급여는     
                        <input name=txtTAX_INCOME id=txtTAX_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원입니다.                                     
                    </td>
                    </tr>

                    <tr>
                    <td class="padding2423">- 의료비 공제를 받을 수 있는 최소금액은&nbsp;
                        <input name=txtHOSPT_AMT id=txtHOSPT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원입니다.
                    <!--     
                    <br>&nbsp;&nbsp;<strong>(의료비 공제금액이 200만원 이상인 분들은 반드시 의료비공제내역을 입력해주시기 바랍니다.)</strong><br>
					-->
                    </td>
                    </tr>
                    <tr>
                    <td class="padding2423">- 신용카드 공제를 받을 수 있는 최소 사용금액은&nbsp;
                        <input name=txtMIN_CARD_AMT id=txtMIN_CARD_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원입니다.
                    </td>
                    </tr>
                </table>
       <!--총급여 표시 끝 -->
</form>
<!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_AC_RETACC"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_RETACC">
	<Param Name="BindInfo"
		, Value='
        <C>Col=DFM_CNT          Ctrl=txtDFM_CNT             Param=value     </C>
        <C>Col=GOL_CNT70        Ctrl=txtGOL_CNT70           Param=value     </C>
        <C>Col=GOL_CNT65        Ctrl=txtGOL_CNT65           Param=value     </C>
        <C>Col=TRB_CNT          Ctrl=txtTRB_CNT             Param=value     </C>
        <C>Col=RCH_CNT          Ctrl=txtRCH_CNT             Param=value     </C>
        <C>Col=CHI_CNT          Ctrl=txtCHI_CNT             Param=value     </C>
        <C>Col=INP_CNT          Ctrl=txtINP_CNT             Param=value     </C>

        <C>Col=NPEN_AMT         Ctrl=txtNPEN_AMT            Param=text      </C>
        <C>Col=EPEN_AMT         Ctrl=txtEPEN_AMT            Param=text      </C>
        <C>Col=HINU_AMT         Ctrl=txtHINU_AMT            Param=text      </C>
        <C>Col=HINS_AMT         Ctrl=txtHINS_AMT            Param=text      </C>
        <C>Col=LIN_AMT          Ctrl=txtLIN_AMT             Param=text      </C>
        <C>Col=LIH_AMT          Ctrl=txtLIH_AMT             Param=text      </C>

        <C>Col=MHEA_AMT         Ctrl=txtMHEA_AMT            Param=text      </C>
        <C>Col=OHEA_AMT         Ctrl=txtOHEA_AMT            Param=text      </C>
        <C>Col=LF2_AMT          Ctrl=txtLF2_AMT             Param=text      </C>
        <C>Col=LEN_AMT          Ctrl=txtLEN_AMT             Param=text      </C>
        <C>Col=LEN_AMT2         Ctrl=txtLEN_AMT2            Param=text      </C>
        <C>Col=LEN_AMT3         Ctrl=txtLEN_AMT3            Param=text      </C>
        <C>Col=LEN_AMT4         Ctrl=txtLEN_AMT4            Param=text      </C>
        <C>Col=LEN_AMT5         Ctrl=txtLEN_AMT5            Param=text      </C>

        <C>Col=GRA_AMT          Ctrl=txtGRA_AMT             Param=text      </C>
        <C>Col=EDU_TAG1         Ctrl=cmbEDU_TAG1            Param=value     </C>
        <C>Col=EDU_TAG2         Ctrl=cmbEDU_TAG2            Param=value      </C>
        <C>Col=EDU_TAG3         Ctrl=cmbEDU_TAG3            Param=value      </C>
        <C>Col=EDU_TAG4         Ctrl=cmbEDU_TAG4            Param=value      </C>
        <C>Col=EDU_TAG5         Ctrl=cmbEDU_TAG5            Param=value      </C>
        <C>Col=EDU_AMT1         Ctrl=txtEDU_AMT1            Param=text      </C>
        <C>Col=EDU_AMT2         Ctrl=txtEDU_AMT2            Param=text      </C>
        <C>Col=EDU_AMT3         Ctrl=txtEDU_AMT3            Param=text      </C>
        <C>Col=EDU_AMT4         Ctrl=txtEDU_AMT4            Param=text      </C>
        <C>Col=EDU_AMT5         Ctrl=txtEDU_AMT5            Param=text      </C>
        <C>Col=HED_AMT          Ctrl=txtHED_AMT             Param=text      </C>

        <C>Col=LHO_AMT          Ctrl=txtLHO_AMT             Param=text      </C>
        <C>Col=LHP_AMT          Ctrl=txtLHP_AMT             Param=text      </C>
        <C>Col=LHQ_AMT          Ctrl=txtLHQ_AMT             Param=text      </C>
        <C>Col=LHR_AMT          Ctrl=txtLHR_AMT             Param=text      </C>
        <C>Col=LH1_AMT          Ctrl=txtLH1_AMT             Param=text      </C>
        <C>Col=LH2_AMT          Ctrl=txtLH2_AMT             Param=text      </C>
        <C>Col=LH4_AMT          Ctrl=txtLH4_AMT             Param=text      </C>
        <C>Col=LH5_AMT          Ctrl=txtLH5_AMT             Param=text      </C>
        <C>Col=LH6_AMT          Ctrl=txtLH6_AMT             Param=text      </C>
        <C>Col=LH7_AMT          Ctrl=txtLH7_AMT             Param=text      </C>
        <C>Col=LH8_AMT          Ctrl=txtLH8_AMT             Param=text      </C>        
        <C>Col=LH2_AMT04        Ctrl=txtLH2_AMT04           Param=text      </C>

        <C>Col=LC3_AMT          Ctrl=txtLC3_AMT             Param=text      </C>
        <C>Col=GOV_AMT          Ctrl=txtGOV_AMT             Param=text      </C>
        <C>Col=LC1_AMT          Ctrl=txtLC1_AMT             Param=text      </C>
        <C>Col=LC2_AMT          Ctrl=txtLC2_AMT             Param=text      </C>
        <C>Col=LC3_NTS          Ctrl=txtLC3_NTS             Param=text      </C>
        <C>Col=GOV_NTS          Ctrl=txtGOV_NTS             Param=text      </C>
        <C>Col=LC1_NTS          Ctrl=txtLC1_NTS             Param=text      </C>
        <C>Col=LC2_NTS          Ctrl=txtLC2_NTS             Param=text      </C>
        <C>Col=LC4_AMT          Ctrl=txtLC4_AMT             Param=text      </C>

        <C>Col=WED_CNT          Ctrl=txtWED_CNT             	Param=value     </C>
        <C>Col=MOV_CNT          Ctrl=txtMOV_CNT             	Param=value     </C>
        <C>Col=FUN_CNT          Ctrl=txtFUN_CNT             	Param=value     </C>

        <C>Col=LF1_AMT          	Ctrl=txtLF1_AMT             		Param=text      </C>
        <C>Col=ANN_AMT          	Ctrl=txtANN_AMT             	Param=text      </C>
        <C>Col=VEN2_AMT         	Ctrl=txtVEN2_AMT            	Param=text      </C>
        <C>Col=CARD_AMT         	Ctrl=txtCARD_AMT            	Param=text      </C>
        <C>Col=DIR_CARD_AMT    Ctrl=txtDIR_CARD_AMT        	Param=text      </C>
        <C>Col=GIRO_AMT         	Ctrl=txtGIRO_AMT            	Param=text      </C>
        <C>Col=CASH_AMT         	Ctrl=txtCASH_AMT            	Param=text      </C>
        <C>Col=MARKET_AMT      	Ctrl=txtMARKET_AMT        	Param=text      </C>
        
        <C>Col=LST_AMT          	Ctrl=txtLST_AMT             		Param=text      </C>
        <C>Col=TMP1_AMT         	Ctrl=txtTMP1_AMT            	Param=text      </C>
        <C>Col=GOV_DED          	Ctrl=txtGOV_DED             		Param=text      </C>
        <C>Col=PAYO_SUM         	Ctrl=txtPAYO_SUM            	Param=text      </C>
        <C>Col=LSQ_AMT          	Ctrl=txtLSQ_AMT             		Param=text      </C>
        <C>Col=INP_AMT          	Ctrl=txtINP_AMT             		Param=text      </C>
        <C>Col=WEL_CARD         	Ctrl=txtWEL_CARD            	Param=text      </C>

        <C>Col=CLS_TAG         	Ctrl=chkCLS_TAG            		Param=value     </C>

        <C>Col=STOCK_AMT1       Ctrl=txtSTOCK_AMT1          	Param=text      </C>
        <C>Col=STOCK_AMT2       Ctrl=txtSTOCK_AMT2          	Param=text      </C>
        <C>Col=STOCK_AMT3       Ctrl=txtSTOCK_AMT3          	Param=text      </C>



        <C>Col=txtSALT_AMT        	Ctrl=txttxtSALT_AMT           	Param=text      </C>
        <C>Col=FREE_INCOME       	Ctrl=txtFREE_INCOME          	Param=text      </C>        
        <C>Col=TAX_INCOME       		Ctrl=txtTAX_INCOME          	Param=text      </C>
        <C>Col=HOSPT_AMT        		Ctrl=txtHOSPT_AMT           	Param=text      </C>
        <C>Col=MIN_CARD_AMT     	Ctrl=txtMIN_CARD_AMT        	Param=text      </C>
        <C>Col=OLD_MED_AMT      	Ctrl=txtOLD_MED_AMT         	Param=text      </C>
        <C>Col=OLD_AMT          		Ctrl=txtOLD_AMT             		Param=text      </C>
        '>
</object>

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
        <C>Col=JAI_AMT3         Ctrl=txtJAI_AMT3            Param=text      </C>
        <C>Col=JAQ_AMT3         Ctrl=txtJAQ_AMT3            Param=text      </C>
        <C>Col=JAR_AMT3         Ctrl=txtJAR_AMT3            Param=text      </C>
        <C>Col=JAH_AMT3         Ctrl=txtJAH_AMT3            Param=text      </C>
        <C>Col=JAP_AMT3         Ctrl=txtJAP_AMT3            Param=text      </C>
        <C>Col=JAL_AMT3         Ctrl=txtJAL_AMT3            Param=text      </C>
        <C>Col=JAN_AMT3         Ctrl=txtJAN_AMT3            Param=text      </C>
    '>
</object>

<object id="bndT_CM_PERSON"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_CM_PERSON">
	<Param Name="BindInfo"
		, Value='
        <C>Col=OCC_NM          Ctrl=txtOCC_NM             Param=value     </C>
        <C>Col=DPT_NM          Ctrl=txtDPT_NM             Param=value     </C>
        <C>Col=JOB_NM          Ctrl=txtJOB_NM             Param=value     </C>
        <C>Col=CET_NO          Ctrl=txtCET_NO             Param=value     </C>
        <C>Col=ZIP_NO          Ctrl=txtZIP_NO             Param=value     </C>
        <C>Col=ADDRESS         Ctrl=txtADDRESS            Param=value     </C>
        <C>Col=ADR_CT          Ctrl=txtADR_CT             Param=value     </C>
        <C>Col=ENO_NO          Ctrl=txtENO_NO             Param=value     </C>
        <C>Col=HEAD_CD         Ctrl=txtHEAD_CD            Param=value     </C>
        <C>Col=DPT_CD          Ctrl=txtDPT_CD             Param=value     </C>
    '>
</object>
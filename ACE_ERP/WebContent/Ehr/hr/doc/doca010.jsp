<!--
*****************************************************
* @source      : doca010.jsp
* @description : 등기관리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/11/21      오대성        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String DOC_AUTHO    = box.getString("SESSION_DOC_AUTHO");
    String ROLE_CD      = box.getString("SESSION_ROLE_CD");

    //관리자인지 아닌지 여부
    boolean isMaster = false;

    //수신은 마스터 관리자만 사용함
    // M 마스터, A 모든부서, S 소속부서
    // IT(1001)는 마스터와 동일한 권한 인사(1002)는 고려하지 않음
    if(DOC_AUTHO.equals("M")
            || ROLE_CD.equals("1001")) {
        isMaster = true;
    }
%>
<html>
<head>
<title>등기관리(doca010)</title>
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

		var searchOver    = "MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)";
		var saveOver      = "MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)";
		var cancelOver    = "MM_swapImage('Image3','','/images/button/btn_CancelOver.gif',1)";
		var deleteOver    = "MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)";
		var exitOver      = "MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)";
		var helpOver      = "MM_swapImage('Image7','','/images/button/btn_HelpOver.gif',1)";
		var helpOver2     = "MM_swapImage('Image8','','/images/button/btn_HelpOver.gif',1)";

        var ActiveIndex = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var str_ymd = "";
			var end_ymd = "";
			var dpt_cd = "";
			var ok_yn = "";

			if(ActiveIndex == 4){//수신조회
				str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
				end_ymd = document.getElementById('txtEND_YMD_SHR').value;
				dpt_cd = document.getElementById('txtDPT_CD_SHR').value;
				ok_yn = document.getElementById('cmbOK_YN_SHR').value;
                eno_nm = document.getElementById('txtENO_NM_SHR1').value;

				dsT_DO_DOCUMENT_REC.DataID = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SHR_01&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&DPT_CD="+dpt_cd+"&OK_YN="+ok_yn+"&ENO_NM="+eno_nm;
				dsT_DO_DOCUMENT_REC.Reset();
			} else if(ActiveIndex == 3){//발송조회
				str_ymd = document.getElementById('txtSTR_YMD_SHR2').value;
				end_ymd = document.getElementById('txtEND_YMD_SHR2').value;
				dpt_cd = document.getElementById('txtDPT_CD_SHR2').value;
				ok_yn = document.getElementById('cmbOK_YN_SHR2').value;
                eno_nm = document.getElementById('txtENO_NM_SHR').value;

				dsT_DO_DOCUMENT_DIS.DataID = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SHR_02&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&DPT_CD="+dpt_cd+"&OK_YN="+ok_yn+"&ENO_NM="+eno_nm;
				dsT_DO_DOCUMENT_DIS.Reset();
			}
        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

			if(ActiveIndex == 2){
				dsT_DO_DOCUMENT_ORDNO.DataID = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SHR_03&DOCU_GBN=R&GBN_CD=A";
			} else if(ActiveIndex == 1){
				dsT_DO_DOCUMENT_ORDNO.DataID = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SHR_03&DOCU_GBN=R&GBN_CD=S";
			}
			dsT_DO_DOCUMENT_ORDNO.Reset();

        }

         /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {//


			if(!fnc_SaveItemCheck()) return;

			if(ActiveIndex == 2){//수신

                dsT_DO_DOCUMENT.ClearData();
				dsT_DO_DOCUMENT.AddRow();
				dsT_DO_DOCUMENT.NameValue(1,'COM_NM') = document.getElementById("txtCOM_NM").value;
				dsT_DO_DOCUMENT.NameValue(1,'DOC_SUB') = document.getElementById("txtDOC_SUB").value;
				dsT_DO_DOCUMENT.NameValue(1,'DOC_NO') = document.getElementById("txtDOC_NO").value;
				dsT_DO_DOCUMENT.NameValue(1,'RCV_DPT') = document.getElementById("txtRCV_DPT").value;
				dsT_DO_DOCUMENT.NameValue(1,'ENO_NM') = document.getElementById("txtENO_NM").value;

				trT_DO_DOCUMENT.KeyValue = "SVL(I:dsT_DO_DOCUMENT=dsT_DO_DOCUMENT)";
				trT_DO_DOCUMENT.action = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SAV_01";
				trT_DO_DOCUMENT.post();

			}else if(ActiveIndex == 1){//발송

				var radio = document.form1.rdoSND_KIND;
                dsT_DO_DOCUMENT.ClearData();
				dsT_DO_DOCUMENT.AddRow();
				dsT_DO_DOCUMENT.NameValue(1,'ORD_NO') = document.getElementById("txtORD_NO2").value;
				for(i=0;i<radio.length;i++){
					if(radio[i].checked){
						dsT_DO_DOCUMENT.NameValue(1,'SND_KIND') = radio[i].value;
					}
				}
				dsT_DO_DOCUMENT.NameValue(1,'DOC_SUB') = document.getElementById("txtDOC_SUB2").value;
				dsT_DO_DOCUMENT.NameValue(1,'COM_NM') = document.getElementById("txtCOM_NM2").value;
				dsT_DO_DOCUMENT.NameValue(1,'COM_NAM') = document.getElementById("txtCOM_NAM").value;
				dsT_DO_DOCUMENT.NameValue(1,'SND_DPT') = document.getElementById("txtSND_DPT").value;
				dsT_DO_DOCUMENT.NameValue(1,'ENO_NM') = document.getElementById("txtENO_NM2").value;




				trT_DO_DOCUMENT.KeyValue = "SVL(I:dsT_DO_DOCUMENT=dsT_DO_DOCUMENT)";
				trT_DO_DOCUMENT.action = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SAV_02";
				trT_DO_DOCUMENT.post();

			}else if(ActiveIndex == 4){//수신조회

				trT_DO_DOCUMENT_REC.KeyValue = "SVL(I:dsT_DO_DOCUMENT_REC=dsT_DO_DOCUMENT_REC)";
				trT_DO_DOCUMENT_REC.action = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SAV_03";
				trT_DO_DOCUMENT_REC.post();

			}else if(ActiveIndex == 3){//발송조회

				trT_DO_DOCUMENT_DIS.KeyValue = "SVL(I:dsT_DO_DOCUMENT_DIS=dsT_DO_DOCUMENT_DIS)";
				trT_DO_DOCUMENT_DIS.action = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=SAV_04";
				trT_DO_DOCUMENT_DIS.post();

			}
        }

		/******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {


			if(ActiveIndex == 4){//수신조회
				if(dsT_DO_DOCUMENT_REC.CountRow < 1) {
					alert("삭제할 자료가 없습니다.");
					fnc_Message(document.getElementById("resultMessage3"), "MSG_05");
					return;
				}

				if(dsT_DO_DOCUMENT_REC.NameValue(dsT_DO_DOCUMENT_REC.RowPosition,'OK_YMD') != ''){
					alert("수령확인된 항목은 삭제 할 수 없습니다.");
					document.getElementById("resultMessage3").innerText = '* 삭제 할 수 없습니다.'
					return;
				}

				if(confirm("관리번호 ["+dsT_DO_DOCUMENT_REC.NameValue(dsT_DO_DOCUMENT_REC.RowPosition,'ORD_NO')+"] 정보를 삭제하시겠습니까?")){
					dsT_DO_DOCUMENT_REC.DeleteRow(dsT_DO_DOCUMENT_REC.RowPosition);
					trT_DO_DOCUMENT_REC.KeyValue = "tr01(I:dsT_DO_DOCUMENT_REC=dsT_DO_DOCUMENT_REC)";
					trT_DO_DOCUMENT_REC.action = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=DEL_01";
					trT_DO_DOCUMENT_REC.post();
				}
			} else if(ActiveIndex == 3){//발송조회
				if(dsT_DO_DOCUMENT_DIS.CountRow < 1) {
					alert("삭제할 자료가 없습니다.");
					fnc_Message(document.getElementById("resultMessage4"), "MSG_05");
					return;
				}

				if(dsT_DO_DOCUMENT_DIS.NameValue(dsT_DO_DOCUMENT_DIS.RowPosition,'REC_YMD') != ''){
					alert("접수확인된 항목은 삭제 할 수 없습니다.");
					document.getElementById("resultMessage3").innerText = '* 삭제 할 수 없습니다.'
					return;
				}

				if(confirm("관리번호 ["+dsT_DO_DOCUMENT_DIS.NameValue(dsT_DO_DOCUMENT_DIS.RowPosition,'ORD_NO')+"] 정보를 삭제하시겠습니까?")){
					dsT_DO_DOCUMENT_DIS.DeleteRow(dsT_DO_DOCUMENT_DIS.RowPosition);
					trT_DO_DOCUMENT_DIS.KeyValue = "tr01(I:dsT_DO_DOCUMENT_DIS=dsT_DO_DOCUMENT_DIS)";
					trT_DO_DOCUMENT_DIS.action = "/servlet/GauceChannelSVL?cmd=hr.doc.a.doca010.cmd.DOCA010CMD&S_MODE=DEL_02";
					trT_DO_DOCUMENT_DIS.post();
				}
			}
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
            if(ActiveIndex == 4){            //수신조회
               if (dsT_DO_DOCUMENT_REC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
               }
               form1.grdT_DO_DOCUMENT_REC.GridToExcel("등기_수신관리", '', 225);
            } else if(ActiveIndex == 3){     //발송조회
               if (dsT_DO_DOCUMENT_DIS.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
               }
              form1.grdT_DO_DOCUMENT_DIS.GridToExcel("등기_발신관리", '', 225);
            }
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

			if(ActiveIndex == 2){//수신

				document.getElementById("txtORD_NO").value = "";
				document.getElementById("txtCOM_NM").value = "";
				document.getElementById("txtDOC_SUB").value = "";
				document.getElementById("txtDOC_NO").value = "";
				document.getElementById("txtRCV_DPT").value = "";
				document.getElementById("txtRCV_DPT_NM").value = "";
				document.getElementById("txtENO_NM").value = "";

                document.getElementById("resultMessage1").innerText = ' ';

			}else if(ActiveIndex == 1){//발송

				document.getElementById("txtORD_NO2").value = "";
				document.form1.rdoSND_KIND[0].checked = true;
				document.getElementById("txtDOC_SUB2").value = "";
				document.getElementById("txtCOM_NM2").value = "";
				document.getElementById("txtCOM_NAM").value = "";
				document.getElementById("txtSND_DPT").value = "<%=box.get("SESSION_DPTCD")%>";
	            document.getElementById("txtSND_DPT_NM").value = "<%=box.get("SESSION_DPTNM")%>";
    	        document.getElementById("txtENO_NM2").value = "<%=box.get("SESSION_ENONM")%>";


                document.getElementById("resultMessage2").innerText = ' ';

			}else if(ActiveIndex == 4){//수신조회

                dsT_DO_DOCUMENT_REC.ClearData();
				document.getElementById("cmbOK_YN_SHR").value = "";
				document.getElementById("txtSTR_YMD_SHR").focus();

                document.getElementById("resultMessage3").innerText = ' ';

			}else if(ActiveIndex == 3){//발송조회

                dsT_DO_DOCUMENT_DIS.ClearData();
				document.getElementById("cmbOK_YN_SHR2").value = "";
				document.getElementById("txtSTR_YMD_SHR2").focus();

                document.getElementById("resultMessage4").innerText = ' ';

			}
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DO_DOCUMENT_DIS.IsUpdated || dsT_DO_DOCUMENT_REC.IsUpdated)  {

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

			var f = document.form1;

			if(ActiveIndex == 2){//수신
<%
    if(!isMaster) {
%>
                //권한이 없으면 사용못함
                alert('권한이 없습니다.');
                return false;
<%
    }
%>

				if(form1.txtCOM_NM.value.trim() == ""){
					alert('회사명을 입력하세요.');
					form1.txtCOM_NM.focus();
					return false;
				}
				if(form1.txtDOC_SUB.value.trim() == ""){
					alert('제목을 입력하세요.');
					form1.txtDOC_SUB.focus();
					return false;
				}
                if(form1.txtDOC_NO.value.trim() == ""){
                    alert('등기번호를 입력하세요.');
                    form1.txtDOC_NO.focus();
                    return false;
                }
				if(form1.txtRCV_DPT.value.trim() == ""){
					alert('부서명을 입력하세요.');
					form1.txtRCV_DPT.focus();
					return false;
				}
				if(form1.txtENO_NM.value.trim() == ""){
					alert('담당자를 입력하세요.');
					form1.txtENO_NM.focus();
					return false;
				}

			}else if(ActiveIndex == 1){//발송
				if(form1.txtDOC_SUB2.value.trim() == ""){
					alert('제목을 입력하세요.');
					form1.txtDOC_SUB2.focus();
					return false;
				}
				if(form1.txtCOM_NM2.value.trim() == ""){
					alert('수신처 회사명을 입력하세요.');
					form1.txtCOM_NM2.focus();
					return false;
				}
				if(form1.txtSND_DPT.value.trim() == ""){
					alert('부서명을 입력하세요.');
					form1.txtSND_DPT.focus();
					return false;
				}
				if(form1.txtENO_NM2.value.trim() == ""){
					alert('담당자를 입력하세요.');
					form1.txtENO_NM2.focus();
					return false;
				}

			}else if(ActiveIndex == 4){//발송
				//DataSet의 변경 여부 확인
				if (!dsT_DO_DOCUMENT_REC.IsUpdated ) {
						alert("저장할 자료가 없습니다.");
						fnc_Message(document.getElementById("resultMessage3"), 'MSG_04');
						return false;
				}
			}else if(ActiveIndex == 3){//발송
				//DataSet의 변경 여부 확인
				if (!dsT_DO_DOCUMENT_DIS.IsUpdated ) {
						alert("저장할 자료가 없습니다.");
						fnc_Message(document.getElementById("resultMessage4"), 'MSG_04');
						return false;
				}
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//Grid Style 적용
			cfStyleGrid(form1.grdT_DO_DOCUMENT_REC,15,"true","false");
			cfStyleGrid(form1.grdT_DO_DOCUMENT_DIS,15,"true","false");
			form1.grdT_DO_DOCUMENT_REC.DragDropEnable  = "false";
			form1.grdT_DO_DOCUMENT_DIS.DragDropEnable  = "false";

			dsT_DO_DOCUMENT.setDataHeader("DOCU_GBN:STRING, GBN_CD:STRING, ORD_NO:STRING, SEQ_NO:STRING, DOC_NO:STRING, SND_KIND:STRING, IN_OUT:STRING, DOC_SUB:STRING, COM_NM:STRING, COM_NAM:STRING, SND_DPT:STRING, RCV_DPT:STRING, ENO_NM:STRING, REMARK:STRING, OK_YMD:STRING, OK_HMS:STRING, OK_MAN:STRING, REC_YMD:STRING, REC_HMS:STRING, REC_MAN:STRING");

            //발송관련 부서 및 담당자 셋팅
            document.getElementById("txtSND_DPT").value = "<%=box.get("SESSION_DPTCD")%>";
            document.getElementById("txtSND_DPT_NM").value = "<%=box.get("SESSION_DPTNM")%>";
            document.getElementById("txtENO_NM2").value = "<%=box.get("SESSION_ENONM")%>";

            //발송 조회날짜
			document.getElementById("txtSTR_YMD_SHR2").value = getToday().substr(0,8)+"01";
			document.getElementById("txtEND_YMD_SHR2").value = getToday();

            //수신 조회날짜
			document.getElementById("txtSTR_YMD_SHR").value = getToday().substr(0,8)+"01";
			document.getElementById("txtEND_YMD_SHR").value = getToday();

            document.getElementById('txtDPT_CD_SHR').value = '<%= box.get("SESSION_DPTCD")%>';
            document.getElementById('txtDPT_NM_SHR').value = '<%= box.get("SESSION_DPTNM")%>';

            document.getElementById('txtDPT_CD_SHR2').value = '<%= box.get("SESSION_DPTCD")%>';
            document.getElementById('txtDPT_NM_SHR2').value = '<%= box.get("SESSION_DPTNM")%>';



            //발송관리에서 접수여부를 '미접수'로 하고 자동조회
            ActiveIndex = 3;
            document.getElementById("cmbOK_YN_SHR2").value = "N";
            fnc_SearchList();

            //수신관리에서 수령여부 '미수령'으로 하고 자동조회
            ActiveIndex = 4;
            document.getElementById("cmbOK_YN_SHR").value = "N";
            fnc_SearchList();

            //버튼들 초기화
            TabEvent(0);
<%
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "imgDPT_SHR");
            fnc_ChangeStateElement(false, "imgDPT_SHR2");

            //일반 문서 관리자일경우
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR2");

            fnc_ChangeStateElement(false, "txtSND_DPT");
            fnc_ChangeStateElement(false, "txtENO_NM2");
            fnc_ChangeStateElement(false, "imgSND_DPT");

            document.grdT_DO_DOCUMENT_DIS.ColumnProp("CONFIRM", "Show") = false;
<%
    } else {
%>
            document.grdT_DO_DOCUMENT_DIS.ColumnProp("CONFIRM_NM", "Show") = false;
<%
    }
%>
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {


			if(ActiveIndex == 1 || ActiveIndex == 2){
				btnList = 'FFTTFFFT';
			} else {
				btnList = 'TFTTFFTT';
			}
			fnc_HotKey_Process(btnList, event.keyCode);

		}

        //Layer ID
        var layerList = new Array(  "tabDOCA010_01"
                                   ,"tabDOCA010_02"
                                   ,"tabDOCA010_03"
                                   ,"tabDOCA010_04"
                                    );

        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {
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

            TabEventBtn();
        }

        /**
         * 선택한 탭에 따라 버튼들 보여지고 닫기
         */
        function TabEventBtn() {
            var tabBtns = "";

            if(ActiveIndex == 1 || ActiveIndex == 2) {
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)\">    <img src=\"/images/button/btn_SaveOn.gif\"   name=\"imgSave\"   width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Save()\"></a>        ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)\"><img src=\"/images/button/btn_CancelOn.gif\" name=\"imgCancel\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Clear();\"></a>      ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)\">    <img src=\"/images/button/btn_ExitOn.gif\"   name=\"imgExit\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Exit()\"></a>          ";
            } else if(ActiveIndex == 3) {
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)\"><img src=\"/images/button/btn_SearchOn.gif\" name=\"imgSearch\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_SearchList()\"></a>  ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)\">    <img src=\"/images/button/btn_SaveOn.gif\"   name=\"imgSave\"   width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Save()\"></a>        ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)\"><img src=\"/images/button/btn_CancelOn.gif\" name=\"imgCancel\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Clear();\"></a>      ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)\"><img src=\"/images/button/btn_ExcelOn.gif\" name=\"imgExcel\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_ToExcel();\"></a>      ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)\"><img src=\"/images/button/btn_DeleteOn.gif\" name=\"imgDelete\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Delete()\"></a>      ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)\">    <img src=\"/images/button/btn_ExitOn.gif\"   name=\"imgExit\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Exit()\"></a>          ";
            } else {
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)\"><img src=\"/images/button/btn_SearchOn.gif\" name=\"imgSearch\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_SearchList()\"></a>  ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)\">    <img src=\"/images/button/btn_SaveOn.gif\"   name=\"imgSave\"   width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Save()\"></a>        ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)\"><img src=\"/images/button/btn_CancelOn.gif\" name=\"imgCancel\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Clear();\"></a>      ";
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)\"><img src=\"/images/button/btn_ExcelOn.gif\" name=\"imgExcel\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_ToExcel();\"></a>      ";
<%
    if(DOC_AUTHO.equals("M") || ROLE_CD.equals("1001")) {
%>
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)\"><img src=\"/images/button/btn_DeleteOn.gif\" name=\"imgDelete\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Delete()\"></a>      ";
<%
    }
%>
                tabBtns += "<a href=\"#\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)\">    <img src=\"/images/button/btn_ExitOn.gif\"   name=\"imgExit\" width=\"60\" height=\"20\" border=\"0\" align=\"absmiddle\" onClick=\"fnc_Exit()\"></a>          ";
            }


            document.getElementById('BUTTONS').innerHTML = tabBtns;
        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CM_EMPLIST                      |
    | 3. Table List : T_CM_EMPLIST                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DO_DOCUMENT                     |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID="dsT_DO_DOCUMENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DO_DOCUMENT_REC           |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID="dsT_DO_DOCUMENT_REC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DO_DOCUMENT_DIS                 |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID="dsT_DO_DOCUMENT_DIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DO_DOCUMENT_ORDNO               |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID="dsT_DO_DOCUMENT_ORDNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_DO_DOCUMENT                     |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID ="trT_DO_DOCUMENT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

	<!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_DO_DOCUMENT                     |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID ="trT_DO_DOCUMENT_REC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

	<!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_DO_DOCUMENT                     |
    | 3. Table List : T_DO_DOCUMENT                 |
    +----------------------------------------------->
    <Object ID ="trT_DO_DOCUMENT_DIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

        } else {

        }
    </Script>

    <Script For=dsT_DO_DOCUMENT Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

        } else {

        }
    </Script>

	<Script For=dsT_DO_DOCUMENT_REC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

			//alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage3"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage3"), "MSG_03", iCount);

        }
    </Script>

	<Script For=dsT_DO_DOCUMENT_DIS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

			//alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage4"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage4"), "MSG_03", iCount);

        }
    </Script>

	<Script For=dsT_DO_DOCUMENT_ORDNO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {
			if(ActiveIndex == 2){
				document.getElementById("txtORD_NO").value = dsT_DO_DOCUMENT_ORDNO.NameValue(1, 'ORD_NO');
			}else {
				document.getElementById("txtORD_NO2").value = dsT_DO_DOCUMENT_ORDNO.NameValue(1, 'ORD_NO');
			}

        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_DO_DOCUMENT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_DO_DOCUMENT_REC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_DO_DOCUMENT_DIS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_DO_DOCUMENT_ORDNO Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DO_DOCUMENT event="OnSuccess()">
		fnc_SearchItem();	//관리번호조회

		if(ActiveIndex == 2){
			fnc_Message(document.getElementById("resultMessage1"), "MSG_01");
			alert("등기 수신 등록이 되었습니다.");
			document.getElementById("txtORD_NO").value = "";
			document.getElementById("txtCOM_NM").value = "";
			document.getElementById("txtDOC_SUB").value = "";
			document.getElementById("txtDOC_NO").value = "";
			document.getElementById("txtENO_NM").value = "";
			document.getElementById("txtRCV_DPT").value = "";
			document.getElementById("txtRCV_DPT_NM").value = "";

		}else if(ActiveIndex == 1){
			fnc_Message(document.getElementById("resultMessage2"), "MSG_01");
			alert("등기 발송 등록이 되었습니다.");
			document.getElementById("txtORD_NO2").value = "";
			document.form1.rdoSND_KIND[0].checked = true;
			document.getElementById("txtDOC_SUB2").value = "";
			document.getElementById("txtCOM_NM2").value = "";
			document.getElementById("txtCOM_NAM").value = "";
		}
		dsT_DO_DOCUMENT.DeleteAll();
    </script>

    <script for=trT_DO_DOCUMENT_REC event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage3"), "MSG_01");
    </script>

	<script for=trT_DO_DOCUMENT_DIS event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage4"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DO_DOCUMENT event="OnFail()">
        cfErrorMsg(this);
		dsT_DO_DOCUMENT.DeleteAll();
    </script>

    <script for=trT_DO_DOCUMENT_REC event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script for=trT_DO_DOCUMENT_DIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-------------------------+
    | Grid 의 CheckBox 클릭시  |
    +-------------------------->
	<script language="javascript"  for=grdT_DO_DOCUMENT_REC event=OnClick(row,colid)>
		if(colid == 'CONFIRM' && row != '0'){
            if(!(dsT_DO_DOCUMENT_REC.NameValue(row,colid) == "T"  && dsT_DO_DOCUMENT_REC.RowStatus(row) == "0")) {
    			if(dsT_DO_DOCUMENT_REC.NameValue(row,colid) == "T") {
    				dsT_DO_DOCUMENT_REC.NameValue(row,'OK_YMD') = removeChar(getToday(),'-');
                    dsT_DO_DOCUMENT_REC.NameValue(row,'OK_NM')  = '<%=box.get("SESSION_ENONM")%>';
    	    	} else if(dsT_DO_DOCUMENT_REC.NameValue(row,colid) == "F") {
    				dsT_DO_DOCUMENT_REC.NameValue(row,'OK_YMD') = '';
                    dsT_DO_DOCUMENT_REC.NameValue(row,'OK_NM')  = '';
    	    	}
            }
    	}
	</script>

	<!-------------------------+
    | Grid 의 CheckBox 클릭시  |
    +-------------------------->
	<script language="javascript"  for=grdT_DO_DOCUMENT_DIS event=OnClick(row,colid)>
		if(colid == 'CONFIRM' && row != '0'){
            if(!(dsT_DO_DOCUMENT_DIS.NameValue(row,colid) == "T" && dsT_DO_DOCUMENT_DIS.RowStatus(row) == "0")) {
    			if(dsT_DO_DOCUMENT_DIS.NameValue(row,colid) == "T") {
    				dsT_DO_DOCUMENT_DIS.NameValue(row,'REC_YMD') = removeChar(getToday(),'-');
    	    	} else if(dsT_DO_DOCUMENT_DIS.NameValue(row,colid) == "F") {
    				dsT_DO_DOCUMENT_DIS.NameValue(row,'REC_YMD') = '';
    	    	}
            }
    	}
	</script>

    <!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_DO_DOCUMENT_DIS event=OnHeadCheckClick(Col,Colid,bCheck)>

    	var bCheckValue = "";
    	if(bCheck == 1){
	    	bCheckValue = "T";
    	}else{
    		bCheckValue = "F";
    	}

        for(var i=1; i<=dsT_DO_DOCUMENT_DIS.CountRow; i++) {
            if(!(dsT_DO_DOCUMENT_DIS.NameValue(i, "CONFIRM") == "T"
                    && dsT_DO_DOCUMENT_DIS.RowStatus(i) == "0")) {

                dsT_DO_DOCUMENT_DIS.NameValue(i, "CONFIRM") = bCheckValue;


                if(dsT_DO_DOCUMENT_DIS.NameValue(i, "CONFIRM") == "T") {
                    dsT_DO_DOCUMENT_DIS.NameValue(i,'REC_YMD') = removeChar(getToday(),'-');
                } else if(dsT_DO_DOCUMENT_DIS.NameValue(i,"CONFIRM") == "F") {
                    dsT_DO_DOCUMENT_DIS.NameValue(i,'REC_YMD') = '';
                }
            }
        }

    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_DO_DOCUMENT_REC event=OnRowPosChanged(row)>
        if(row > 0) {
            //수령여부를 선택하고 나면 수정못하게 막음
            if(dsT_DO_DOCUMENT_REC.NameValue(row, "CONFIRM") == "T"
                    && dsT_DO_DOCUMENT_REC.RowStatus(row) == "0") {
                grdT_DO_DOCUMENT_REC.ColumnProp("CONFIRM","edit")  = "none";
            } else {
                grdT_DO_DOCUMENT_REC.ColumnProp("CONFIRM","edit")  = "true";
            }
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_DO_DOCUMENT_DIS event=OnRowPosChanged(row)>
        if(row > 0) {
            //수령여부를 선택하고 나면 수정못하게 막음
            if(dsT_DO_DOCUMENT_DIS.NameValue(row, "CONFIRM") == "T"
                    && dsT_DO_DOCUMENT_DIS.RowStatus(row) == "0") {
                grdT_DO_DOCUMENT_DIS.ColumnProp("CONFIRM","edit")  = "none";
            } else {
                grdT_DO_DOCUMENT_DIS.ColumnProp("CONFIRM","edit")  = "true";
            }
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">등기관리</td>
					<td align="right" class="navigator">HOME/문서관리/문서관리/<font color="#000000">등기관리</font></td>
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
            <span id="BUTTONS">&nbsp;</span>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="120">
                        <!-- 탭오버 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">발&nbsp;&nbsp;송</td>
                                <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
<%
    if(isMaster) {
%>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">수&nbsp;&nbsp;신</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
<%
    }
%>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">발송관리</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">수신관리</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
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
<div class=page id="tabDOCA010_01" style="position:absolute; left:20; top:130; width:800; height:340; z-index:4; visibility:hidden" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  bordercolor="#999999" class="table_cream">
	                <colgroup>
	                    <col width="100"></col>
	                    <col width="*"></col>
	                </colgroup>
	                <tr>
	                    <td align="center" class="creamBold">관리번호</td>
	                    <td class="padding2423"><input id="txtORD_NO2" size="14" class="input_ReadOnly" readonly></td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>발송부서 </strong></td>
		</tr>
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="2" bgcolor="#A4A4A1"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="100"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td align="center" class="creamBold">부서명</td>
						<td class="padding2423">
                            <input id=txtSND_DPT name=txtSND_DPT size="6" maxlength="6" onChange="fnc_GetCommNm('A4', 'txtSND_DPT','txtSND_DPT_NM')">
							<input id=txtSND_DPT_NM name=txtSND_DPT_NM size="14" class="input_ReadOnly" readonly>
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSND_DPT','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSND_DPT" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtSND_DPT','txtSND_DPT_NM','부서','DEPT')"></a>
                        </td>
					</tr>
					<tr>
						<td align="center" class="creamBold">담당자</td>
						<td class="padding2423">
							<input id="txtENO_NM2" name="txtENO_NM2" size="10" onKeyUp="fc_chk_byte(this,20)">
						</td>
					</tr>
					<tr>
						<td align="center" class="creamBold">제 목</td>
						<td class="padding2423">
							<input id="txtDOC_SUB2" name="txtDOC_SUB2" size="50" onKeyUp="fc_chk_byte(this,100)">
						</td>
					</tr>
					<tr>
						<td align="center" class="creamBold">발송구분</td>
						<td class="padding2423">
							<input type="radio" id="radio1" name="rdoSND_KIND" style="border:none" value="0" checked>보통우편
							<input type="radio" id="radio2" name="rdoSND_KIND" style="border:none" value="1">빠른우편
							<input type="radio" id="radio3" name="rdoSND_KIND" style="border:none" value="2">특급우편
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>수신처 </strong></td>
		</tr>
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="2" bgcolor="#A4A4A1"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="100"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td align="center" class="creamBold">회사명</td>
						<td class="padding2423">
							<input id="txtCOM_NM2" name="txtCOM_NM2" size="30" onKeyUp="fc_chk_byte(this,60)">
						</td>
					</tr>
					<tr>
						<td align="center" class="creamBold">담당자</td>
						<td class="padding2423">
							<input id="txtCOM_NAM" name="txtCOM_NAM" size="10" onKeyUp="fc_chk_byte(this,20)">
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
						<td valign="top" class="searchState"><span id="resultMessage2">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!-- 조회 상태 테이블 끝 -->

</div>
<!-- 탭1 조건 입력 테이블 끝 -->

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabDOCA010_02" style="position:absolute; left:20; top:130; width:800; height:340; z-index:3;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  bordercolor="#999999" class="table_cream">
	                <colgroup>
	                    <col width="100"></col>
	                    <col width="*"></col>
	                </colgroup>
	                <tr>
	                    <td align="center" class="creamBold">관리번호</td>
	                    <td class="padding2423"><input id="txtORD_NO" size="14" class="input_ReadOnly" readonly></td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>발송처 </strong></td>
		</tr>
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="2" bgcolor="#A4A4A1"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="100"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td align="center" class="creamBold">회 사 명</td>
						<td class="padding2423">
							<input id="txtCOM_NM" name="txtCOM_NM" size="30" onKeyUp="fc_chk_byte(this,60)">
						</td>
					</tr>
					<tr>
						<td align="center" class="creamBold">제&nbsp;&nbsp;&nbsp;목</td>
						<td class="padding2423">
							<input id="txtDOC_SUB" name="txtDOC_SUB" size="50" onKeyUp="fc_chk_byte(this,100)">
						</td>
					</tr>
					<tr>
						<td align="center" class="creamBold">등기번호</td>
						<td class="padding2423">
							<input id="txtDOC_NO" name="txtDOC_NO" size="20" onKeyUp="fc_chk_byte(this,20)">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>수신부서 </strong></td>
		</tr>
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="2" bgcolor="#A4A4A1"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="100"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td align="center" class="creamBold">부서명</td>
						<td class="padding2423">
                            <input name=txtRCV_DPT size="6" maxlength="6" onChange="fnc_GetCommNm('A4', 'txtRCV_DPT','txtRCV_DPT_NM')">
							<input id=txtRCV_DPT_NM name=txtRCV_DPT_NM size="14" class="input_ReadOnly" readonly>
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtRCV_DPT','txtRCV_DPT_NM','부서','DEPT');"></a>
                        </td>
					</tr>
					<tr>
						<td align="center" class="creamBold">담당자</td>
						<td class="padding2423">
							<input id="txtENO_NM" name="txtENO_NM" size="10" onKeyUp="fc_chk_byte(this,20)">
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
						<td valign="top" class="searchState"><span id="resultMessage1">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!-- 조회 상태 테이블 끝 -->

</div>
<!-- 탭2 조건 입력 테이블 끝 -->

<!-- 탭3 조건 입력 테이블 시작 -->
<div class=page id="tabDOCA010_03" style="position:absolute; left:20; top:100; width:800; height:340; z-index:2; visibility:hidden">
<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" class="greenTable">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="65"></col>
									<col width="220"></col>
									<col width="65"></col>
									<col width="200"></col>
									<col width="65"></col>
									<col width="*"></col>
								</colgroup>
								<tr>
									<td align="right" class="searchState">등록일자&nbsp;</td>
                                    <td class="padding2423" align="left">
                                        <input id="txtSTR_YMD_SHR2" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR2','txtSTR_YMD_SHR2','txtEND_YMD_SHR2'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR2','','10','140');"></a> ~
                                        <input id="txtEND_YMD_SHR2" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR2','txtSTR_YMD_SHR2','txtEND_YMD_SHR2'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR2','','130','140');"></a>
                                    </td>
									<td align="right" class="searchState">발송부서&nbsp;</td>
									<td class="padding2423">
                                        <input id=txtDPT_CD_SHR2 name=txtDPT_CD_SHR2 size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR2','txtDPT_NM_SHR2');">
                                        <input name=txtDPT_NM_SHR2 size="14" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_SHR2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgDPT_SHR2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR2','txtDPT_NM_SHR2','부서','DEPT')"></a>
									</td>

									<td align="right" class="searchState">접수여부&nbsp;</td>
									<td class="padding2423">
										<select id="cmbOK_YN_SHR2" name="cmbOK_YN_SHR2" style="WIDTH: 50%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
											<option value=''>전 체</option>
											<option value='Y'>접 수</option>
											<option value='N'>미접수</option>
										</select>
									</td>
								</tr>
                                <tr>
                                    <td align="right" class="searchState">발송자명&nbsp;</td>
									<td class="padding2423">
                                        <input id="txtENO_NM_SHR" name=txtENO_NM_SHR size="15" maxlength="15" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
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
			<td class="paddingTop15">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage4">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td>

							<comment id="__NSID__">
							<object	id="grdT_DO_DOCUMENT_DIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
	                            <param name="DataID"			value="dsT_DO_DOCUMENT_DIS">
	                            <param name="EdiTABLE"			value="true">
    	                        <param name="DragDropEnable"	value="false">
				                <param name="VIEWSUMMARY"		value=0>
	                            <param name="Format"		    value="
	                                <C> id={currow}   width=30   name='NO'		   align=center  value={String(Currow)}</C>
									<C> id='IPT_YMD'   width=70	 name='등록일자'   align=center  edit=None</C>
									<C> id='ORD_NO'    width=85	 name='관리번호'   align=center  edit=None</C>
									<C> id='SND_GBN'   width=60	 name='발송구분'   align=center  edit=None	Value={Decode(SND_KIND,'0','보통우편','1','빠른우편','2','특급우편')}</C>
									<C> id='SND_DPT'   width=85	 name='발송부서'   align=left  edit=None	Show=false</C>
									<C> id='DPT_NM'    width=85	 name='발송부서'   align=left    edit=None</C>
									<C> id='ENO_NM'    width=55	 name='발송자'     align=center  edit=None</C>
									<C> id='DOC_SUB'   width=115 name='제목'       align=left  edit=None</C>
									<C> id='COM_NM'    width=85	 name='수신처'     align=left  edit=None</C>
									<C> id='COM_NAM'   width=55	 name='수신자'     align=center  edit=None</C>
									<C> id='REC_YMD'   width=70	 name='접수일자'   align=center  edit=None	MASK=XXXX-XX-XX</C>
									<C> id='CONFIRM'   width=54	 name='접수;확인'   align=center		HeadCheckShow=true	EditStyle=CheckBox	Pointer=Hand	</C>
									<C> id='CONFIRM_NM'   width=54	 name='접수;확인'   align=center		edit=None value={decode(CONFIRM, 'T', '접수')}	</C>
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
<!-- 탭3 조건 입력 테이블 끝 -->

<!-- 탭4 조건 입력 테이블 시작 -->
<div class=page id="tabDOCA010_04" style="position:absolute; left:20; top:100; width:800; height:340; z-index:1; visibility:hidden">
<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" class="greenTable">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="65"></col>
									<col width="220"></col>
									<col width="65"></col>
									<col width="200"></col>
									<col width="65"></col>
									<col width="*"></col>
								</colgroup>
								<tr>
									<td align="right" class="searchState">등록일자&nbsp;</td>
									<td class="padding2423" align="left">
                                        <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','140');"></a> ~
                                        <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','130','140');"></a>
                                    </td>
									<td align="right" class="searchState">수신부서&nbsp;</td>
									<td class="padding2423">
                                        <input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgDPT_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
									</td>

									<td align="right" class="searchState">수령여부&nbsp;</td>
									<td class="padding2423">
										<select id="cmbOK_YN_SHR" name="cmbOK_YN_SHR" style="WIDTH: 50%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
											<option value=''>전 체</option>
											<option value='Y'>수 령</option>
											<option value='N'>미수령</option>
										</select>
									</td>
								</tr>
                                <tr>
                                    <td align="right" class="searchState">수신자명&nbsp;</td>
									<td class="padding2423">
                                        <input id="txtENO_NM_SHR1" name=txtENO_NM_SHR1 size="15" maxlength="15" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
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
			<td class="paddingTop15">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage3">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td>

							<comment id="__NSID__">
							<object	id="grdT_DO_DOCUMENT_REC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
	                            <param name="DataID"			value="dsT_DO_DOCUMENT_REC">
	                            <param name="EdiTABLE"			value="true">
    	                        <param name="DragDropEnable"	value="false">
				                <param name="VIEWSUMMARY"		value=0>
	                            <param name="Format"		    value="
	                                <C> id={currow}    width=25   name='NO'		   align=center  value={String(Currow)}</C>
									<C> id='IPT_YMD'   width=65	 name='등록일자'   align=center  edit=None</C>
									<C> id='ORD_NO'    width=85	 name='관리번호'   align=center  edit=None</C>
									<C> id='COM_NM'    width=90	 name='발송처'     align=left    edit=None</C>
									<C> id='DOC_SUB'   width=125	 name='제목'       align=left    edit=None</C>
									<C> id='DOC_NO'    width=80	 name='등기번호'   align=center  edit=None</C>
									<C> id='RCV_DPT'   width=90	 name='수신부서'   align=left    edit=None Show=False</C>
									<C> id='DPT_NM'    width=90	 name='수신부서'   align=left    edit=None</C>
									<C> id='ENO_NM'    width=50	 name='수신자'     align=center  edit=None</C>
									<C> id='OK_YMD'    width=65	 name='수령일자'   align=center  edit=None MASK=XXXX-XX-XX</C>
                                    <C> id='OK_NM'     width=55  name='수령자'     align=center  edit=None</C>
									<C> id='CONFIRM'   width=34	 name='수령;확인'   align=center	edit=None	EditStyle=CheckBox	Pointer=Hand	</C>
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
<!-- 탭3 조건 입력 테이블 끝 -->

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>
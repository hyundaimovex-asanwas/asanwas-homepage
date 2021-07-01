<!--
    ************************************************************************************
    * @source         : saga237.jsp 				                                   												     *
    * @description   : 중식대 회계가전표  PAGE.                                                									 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            										 *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/13  |  한학현   | 최초작성                                               											 *
    * 2009/10/21  |  권혁수   | 연봉제로 변경                                               									 *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>중식대 회계가전표 </title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTTTTT';
        var savObj = new Array();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			//var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 기준년도

			//기준일자가 없으면 조회 못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("급여지급일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("급여지급일자가 잘못되었습니다.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//직위가 없으면 조회 못함.
            /*
			if(JOB_CD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("직위를 입력하세요.");
					document.getElementById("txtJOB_CD_SHR").focus();
					return false;
				}
			}
            */

            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";

            //데이터셋 전송
            dsT_CP_PAYTABLE.UseChangeInfo = true;
            //dsT_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR;
            //dsT_CP_PAYTABLE.Reset();

            trT_CP_PAYTABLE_SHR.KeyValue = "tr02"
                                   + "(O:dsT_CP_PAYTABLE=dsT_CP_PAYTABLE"                   //산정내역
                                   + ",O:dsT_SAP_ACCOUNT=dsT_SAP_ACCOUNT"     //통상임금
                                   + ",O:dsT_SAP_COSTDEPT=dsT_SAP_COSTDEPT"     //통상임금
                                   + ",O:dsT_SAP_VENDOR=dsT_SAP_VENDOR"     //통상임금
                                   + ",O:dsT_SAP_WBS=dsT_SAP_WBS)";     //통상임금

			trT_CP_PAYTABLE_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR;
			trT_CP_PAYTABLE_SHR.post();

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

        	if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") != ''){
            	alert("전송된 자료는 수정할 수 없습니다.");
                return;
            }
        	var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자

        	for(var i=0; i<dsT_CP_PAYTABLE.CountRow; i++){
        		//if(dsT_CP_PAYTABLE.NameValue(i+1, "DC_GBN") != 'C' || dsT_CP_PAYTABLE.NameValue(i+1, "DC_GBN") != 'D'){
        			if( dsT_CP_PAYTABLE.NameValue(i+1, "CR_AMT") > 0)
        				dsT_CP_PAYTABLE.NameValue(i+1, "DC_GBN")="C";
        			else
        				dsT_CP_PAYTABLE.NameValue(i+1, "DC_GBN")="D";
        		//}
        	}


			//트랜잭션 전송
			trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE, O:dsRESULT=dsRESULT)";
			trT_CP_PAYTABLE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=SAV&APY_YMD_SHR="+APY_YMD_SHR;
			trT_CP_PAYTABLE.Post();

        }

		/******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") != ''){
            	alert("전송된 자료는 수정할 수 없습니다.");
                return;
            }
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CP_PAYTABLE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            //if (confirm("[" + dsT_CP_PAYTABLE.ColumnString(dsT_CP_PAYTABLE.RowPosition,4) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CP_PAYTABLE.DeleteRow(dsT_CP_PAYTABLE.RowPosition);
			//trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE)";
			//trT_CP_PAYTABLE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=SAV";
			//trT_CP_PAYTABLE.post();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			//var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분

			//적용일자가 없으면 조회못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("적용일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("적용일자가 잘못되었습니다.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//직위가 없으면 조회 못함.
			if(JOB_CD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("직위를 입력하세요.");
					document.getElementById("txtJOB_CD_SHR").focus();
					return false;
				}
			}

     	    var url = "saga010_PV.jsp?APY_YMD_SHR="+APY_YMD_SHR+"&OCC_CD_SHR=A&JOB_CD_SHR="+JOB_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_CP_PAYTABLE.GridToExcel("중식대 테이블", '', 225);

        }

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			 if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("조회를 먼저 하셔야합니다.");
                return;
            }

            if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") != ''){
            	alert("전송된 자료는 수정할 수 없습니다.");
                return;
            }

            dsT_CP_PAYTABLE.AddRow();

            document.getElementById("txtDR_AMT").value = "0";
			document.getElementById("txtCR_AMT").value = "0";
            enableInput();// 입력필드 활성화
			document.getElementById("txtACC_CD").focus();
        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {
			if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("조회를 먼저 하셔야합니다.");
                return;
            }

            if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") != ''){
            	alert("전송된 자료는 수정할 수 없습니다.");
                return;
            }

            dsT_CP_PAYTABLE.InsertRow(dsT_CP_PAYTABLE.RowPosition);

            document.getElementById("txtDR_AMT").value = "0";
			document.getElementById("txtCR_AMT").value = "0";
            enableInput();// 입력필드 활성화
			document.getElementById("txtACC_CD").focus();
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

			fnc_OnLoadProcess();
			dsT_CP_PAYTABLE.ClearData();

            document.getElementById("txtDR_AMT").value = "";
			document.getElementById("txtCR_AMT").value = "";
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYTABLE.IsUpdated)  {

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

        	if (!dsT_CP_PAYTABLE.isUpdated && dsT_CP_PAYTABLE.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			fnc_ChangeGrid();      //그리드 변경 처리

			//최근 저장한 기준일 조회
			ds01T_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			//값이 없어서 하이픈만 나오는거 방지
			var APY_YMD_SHR = (document.getElementById("txtAPY_YMD_SHR").value).replace("-", "").replace("-", "");
			if(APY_YMD_SHR.trim() == ""){
				document.getElementById("txtAPY_YMD_SHR").value = "";
			}

			disableInput();//입력필드 비활성화

            savObj.type = "";
            //savObj.occ_cd = "";
            savObj.apy_ymd = "";

            fnc_SearchList();
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17. 엑셀파일 업로드 처리  *
         ****************************/
         function fnc_FileUpload() {

        	var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			//var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn < 1) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_CP_PAYTABLE=dsT_CP_PAYTABLE)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR_02&APY_YMD="+APY_YMD_SHR+"&OCC_CD=A&JOB_CD="+JOB_CD_SHR;
                trFILE_UPLOAD.post();

            }

        }
        /**********************************
         * 17-1 중식대 가전표 데이터 생성 *
         **********************************/
        function fnc_proc2() {

            var oPIS_YM     = document.getElementById("txtAPY_YMD_SHR");
            var oOCC_CD     = "A";
            var oPAY_YMD    = document.getElementById("txtAPY_YMD_SHR");
            var oAPY_YMD    = document.getElementById("txtAPY_YMD_SHR");

            if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") != '' && dsT_CP_PAYTABLE.CountRow > 1){
            	alert("전송된 자료는 전송할 수 없습니다.");
                return;
            }

            if (confirm("중식대 회계전표발행을 하시겠습니까? ") == false) return;

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=PROC"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD
                   + "&PAY_YMD="+oPAY_YMD.value.replace(/-/g, '')
                   + "&APY_YMD="+oAPY_YMD.value.replace(/-/g, '');

            dsRESULT.ClearData();

            trT_CP_PAYTABLE.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_PAYTABLE.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=PROC"+params;
            trT_CP_PAYTABLE.post();
        }

        /*****************************
         * 17. 전표 -> 빌즈 전송     *
         ****************************/
        function fnc_proc() {
            //검색유효성 검사
            if(dsT_CP_PAYTABLE.CountRow < 1) {
                alert("조회를 먼저 해주세요.");
                return;
            }
            if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") != ''){
            	alert("전송된 자료는 전송할 수 없습니다.");
                return;
            }

            var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
            if (confirm("전표를 전송하시겠습니까?") == false) return;
			//트랜잭션 전송
			trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE, O:dsRESULT=dsRESULT)";
			trT_CP_PAYTABLE.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga237.cmd.SAGA237CMD&S_MODE=BILL&APY_YMD_SHR="+APY_YMD_SHR;
			trT_CP_PAYTABLE.post();
		}


		/********************************************************************
         * 18. 계정코드팝업
         ********************************************************************/
        function fnc_AccountPopup() {

            var obj = new String();
            var url = "/hr/sag/saga231.jsp?CD="+document.getElementById("txtACC_CD").value;

            // 팝업창 호출
            window.showModalDialog(url, obj, "dialogHeight:470px; dialogWidth:650px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.acc_cd != null){
                document.getElementById("txtACC_CD").value     = obj.acc_cd;
                document.getElementById("txtACC_NM").value  = obj.acc_nm;
			}

                //dsT_CM_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira010.cmd.PIRA010CMD&S_MODE=SHR_02&ENO_NO="+document.getElementById("txtENO_NO").value+"&REG_NO="+document.getElementById("REG_NO").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
                //dsT_CM_PERSON.Reset();


        }
        /********************************************************************
         * 19. 프로젝트 정보조회 팝업
         ********************************************************************/
        function fnc_PrjPopup() {

            var obj = new String();
            var url = "/hr/sag/saga232.jsp";

            // 팝업창 호출
            window.showModalDialog(url, obj, "dialogHeight:470px; dialogWidth:650px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.cctr_cd != null){
                document.getElementById("txtPRJ_CD").value     = obj.cctr_cd;
                document.getElementById("txtPRJ_NM").value  = obj.cctr_nm;
			}

                //dsT_CM_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira010.cmd.PIRA010CMD&S_MODE=SHR_02&ENO_NO="+document.getElementById("txtENO_NO").value+"&REG_NO="+document.getElementById("REG_NO").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
                //dsT_CM_PERSON.Reset();


        }
        /********************************************************************
         * 20. 거래처(매입처)코드 조회 팝업
         ********************************************************************/
        function fnc_VendorPopup() {

            var obj = new String();
            var url = "/hr/sag/saga233.jsp?CD="+document.getElementById("txtCUS_CD").value;

            // 팝업창 호출
            window.showModalDialog(url, obj, "dialogHeight:470px; dialogWidth:650px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.vendor_cd != null){
                document.getElementById("txtCUS_CD").value     = obj.vendor_cd;
                document.getElementById("txtCUS_NM").value  = obj.vendor_nm;
			}

                //dsT_CM_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira010.cmd.PIRA010CMD&S_MODE=SHR_02&ENO_NO="+document.getElementById("txtENO_NO").value+"&REG_NO="+document.getElementById("REG_NO").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
                //dsT_CM_PERSON.Reset();


        }
        /********************************************************************
         * 21. 회계부서코드 조회 팝업
         ********************************************************************/
        function fnc_CostDeptPopup() {

            var obj = new String();
            var url = "/hr/sag/saga234.jsp";

            // 팝업창 호출
            window.showModalDialog(url, obj, "dialogHeight:470px; dialogWidth:650px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.dpt_cd != null){
                document.getElementById("txtDPT_CD").value     = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value  = obj.dpt_nm;
			}

                //dsT_CM_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira010.cmd.PIRA010CMD&S_MODE=SHR_02&ENO_NO="+document.getElementById("txtENO_NO").value+"&REG_NO="+document.getElementById("REG_NO").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
                //dsT_CM_PERSON.Reset();


        }
        /*************************
         * 그리드 변경 처리               *
         ************************/
		function fnc_ChangeGrid() {

			form1.grdT_CP_PAYTABLE.Format = "<C> id='{CUROW}'		width=40		name='NO'						align=center		value={String(Currow)}		BgColor='#EEEEEE'		</C>" +
											"<C> id='ACC_CD'        width=90        name='계정코드'          align=center    SubBgColor='#99FFCC' Edit=none </C>" +
											"<C> id='ACC_NM'		width=110		name='계정과목'	EditStyle=Lookup	ListWidth=150 Data='dsT_SAP_ACCOUNT:ACCOUNT_CD:ACCOUNT_NM' Edit=none  align=center   LeftMargin=10	 SubBgColor='#99FFCC'	 sumtext='합   계'   </C>" +
											"<C> id='CUS_CD'        width=60        name='거래처'      align=center    SubBgColor='#99FFCC' Edit=none show=false </C>" +
											"<C> id='CUS_NM'        width=60        name='거래처명' EditStyle=Lookup  Data='dsT_SAP_VENDOR:VENDOR_CODE:VENDOR_NAME'   align=center    SubBgColor='#99FFCC' Edit=none  show=false</C>" +
											"<C> id='PRJ_CD'        width=75        name='프로젝트'        align=center  SubBgColor='#99FFCC'	  Edit=none  show=false</C>" +
											"<C> id='PRJ_NM'        width=75        name='프로젝트명'  EditStyle=Lookup  Data='dsT_SAP_WBS:CCTR_CD:CCTR_NM'    align=center  SubBgColor='#99FFCC'	  Edit=none  show=false</C>" +
											"<C> id='DPT_CD'       width=75        name='부서코드'      align=center     SubBgColor='#99FFCC'	 Edit=none               </C>" +
											"<C> id='DPT_NM'       width=100        name='부서명'   EditStyle=Lookup Data='dsT_SAP_COSTDEPT:CCTR_CD:CCTR_NM'  align=center   SubBgColor='#99FFCC'	 Edit=none  </C>" +
											"<C> id='DTL_ACC_CD'       width=50        name='세목'    show=false    align=center   SubBgColor='#99FFCC'	 Edit=none                   </C>" +
											"<C> id='WRITEKEY'       width=60        name='전기키'      align=center     SubBgColor='#99FFCC'	 Edit=none               </C>" +
											"<C> id='DR_AMT'      width=95        name='Dr(차변)'      align=right       SubBgColor='#99FFCC'	 Edit=none    SumText=@sum           </C>" +
											"<C> id='CR_AMT'       width=95        name='Cr(대변)'      align=right       SubBgColor='#99FFCC'	  Edit=none    SumText=@sum          </C>" +
											"<C> id='DESP'       width=250       name='적요'        align=left        SubBgColor='#99FFCC'	  Edit=none            </C>" +
											"<C> id='DESP2'       width=75        name='비고'        align=left         SubBgColor='#99FFCC'	     Edit=none         </C>";

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYTABLE,15,"true","true");

		}

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
			document.form1.txtACC_CD.readOnly = false;
			document.form1.txtACC_CD.className = "";

			document.form1.txtCUS_CD.readOnly = false;
			document.form1.txtCUS_CD.className = "";
			document.form1.txtPRJ_CD.readOnly = false;
			document.form1.txtPRJ_CD.className = "";
			document.form1.txtDPT_CD.readOnly = false;
			document.form1.txtDPT_CD.className = "";
			document.form1.txtWRITEKEY.readOnly = false;
			document.form1.txtWRITEKEY.className = "";

			document.form1.txtDR_AMT.readOnly = false;
			document.form1.txtDR_AMT.className = "";
			document.form1.txtCR_AMT.readOnly = false;
			document.form1.txtCR_AMT.className = "";
			document.form1.txtDESP.readOnly = false;
			document.form1.txtDESP.className = "";
			document.form1.txtDESP2.readOnly = false;
			document.form1.txtDESP2.className = "";

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtACC_CD.readOnly = true;
			document.form1.txtACC_CD.className = "input_ReadOnly";

			document.form1.txtCUS_CD.readOnly = true;
			document.form1.txtCUS_CD.className = "input_ReadOnly";
			document.form1.txtPRJ_CD.readOnly = true;
			document.form1.txtPRJ_CD.className = "input_ReadOnly";
			document.form1.txtDPT_CD.readOnly = true;
			document.form1.txtDPT_CD.className = "input_ReadOnly";
			document.form1.txtWRITEKEY.readOnly = true;
			document.form1.txtWRITEKEY.className = "input_ReadOnly";

			document.form1.txtDR_AMT.readOnly = true;
			document.form1.txtDR_AMT.className = "input_ReadOnly";
			document.form1.txtCR_AMT.readOnly = true;
			document.form1.txtCR_AMT.className = "input_ReadOnly";
			document.form1.txtDESP.readOnly = true;
			document.form1.txtDESP.className = "input_ReadOnly";
			document.form1.txtDESP2.readOnly = true;
			document.form1.txtDESP2.className = "input_ReadOnly";

  		}
  		/********************************************
         * 행 상하 이동         		*
         ********************************************/
  		function on_Move(a){
			if(a=='down'){
				if (dsT_CP_PAYTABLE.RowPosition == dsT_CP_PAYTABLE.CountRow) {
					alert("This is Last Row.")
				} else {

					var i = dsT_CP_PAYTABLE.RowPosition;
					dsT_CP_PAYTABLE.InsertRow(i+2);
					for(col=1; col<dsT_CP_PAYTABLE.CountColumn; col++){
						dsT_CP_PAYTABLE.NameValue(i+2,dsT_CP_PAYTABLE.ColumnID(col)) = dsT_CP_PAYTABLE.NameValue(i,dsT_CP_PAYTABLE.ColumnID(col));
					}
					dsT_CP_PAYTABLE.DeleteRow(i);

				}

			}else if(a=='up'){
				if (dsT_CP_PAYTABLE.RowPosition == 1) {
					alert("This is First Row.")
				} else {
					var i = dsT_CP_PAYTABLE.RowPosition;
					dsT_CP_PAYTABLE.InsertRow(i-1);
					for(col=1; col<dsT_CP_PAYTABLE.CountColumn; col++){
						dsT_CP_PAYTABLE.NameValue(i-1,dsT_CP_PAYTABLE.ColumnID(col)) = dsT_CP_PAYTABLE.NameValue(i+1,dsT_CP_PAYTABLE.ColumnID(col));
					}
					dsT_CP_PAYTABLE.DeleteRow(i+1);
				}
			}
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
    | 2. 이름 : dsT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_SAP_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_SAP_COSTDEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_SAP_VENDOR" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_SAP_WBS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>



    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton              |
    | 2. 이름 : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_PAYTABLE                                |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>
    <!----------------------------------------------+
    | 1. 자료 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_PAYTABLE                                |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYTABLE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_CP_PAYTABLE.UserStatus(i) = 1;
            }

            if(dsT_CP_PAYTABLE.NameValue(1, "MNG_NO") == ''){
            	enableInput();
            }

        }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
			document.getElementById("txtAPY_YMD_SHR").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
			document.getElementById("txtAPY_YMD_SHR").focus();
			document.getElementById("txtPAY_YMD_SHR").value = oAPY_YMD.substring(0,4);

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[시작일자/종료일자/직위/사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("적용일자/근로구분/직위/호봉에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_PAYTABLE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();
    </script>
    <script for=trT_CP_PAYTABLE_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <script for=trFILE_UPLOAD event="OnSuccess()">
		document.getElementById("resultMessage").innerText = "파일첨부가 완료되었습니다.";

        //ROW 상태를 다 INSERT 상태로 변경 시켜 놓음 (나중 db 저장을 위해)
        dsT_CP_PAYTABLE.UseChangeInfo = false;

        savObj.type     = "UPLOAD";
        //savObj.occ_cd   = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
        savObj.apy_ymd  = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_PAYTABLE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">중식대 회계가전표</td>
					<td align="right" class="navigator">HOME/보상관리/중식대 관리/<font color="#000000">급여회계가전표</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">기준년도</td>
								<td>
								<input id="txtPAY_YMD_SHR" style="width:83" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								<!--
									<select id="cmbOCC_CD_SHR" style="WIDTH:60%" onChange="fnc_ChangeGrid(this);fnc_SearchList();">
									</select>
								 -->
								</td>
								<td align="center" class="searchState">급여지급일자</td>
								<td>
									<input id="txtAPY_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','535','112');"></a>
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
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="80"></col>
                        <col width="110"></col>
                        <col width="80"></col>
                        <col width="110"></col>
                        <col width="80"></col>
                        <col width="110"></col>
                        <col width="80"></col>
                        <col width=""></col>
                    </colgroup>
                     <tr>
                        <td align="center" class="creamBold">계정코드</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtACC_CD" name="txtACC_CD" size="10" maxlength= "8" class="input_ReadOnly" readonly>
                            <input id="txtACC_NM" name="txtACC_NM" size="20" maxlength= "8" class="input_ReadOnly" readonly>
                            <img src="/images/button/btn_HelpOn.gif" id="ImgAccCd" name="ImgAccCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_AccountPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        </td>
                        <td align="center" class="creamBold">거래처</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtCUS_CD" name="txtCUS_CD" size="10" maxlength= "8" class="input_ReadOnly" readonly>
                            <input id="txtCUS_NM" name="txtCUS_NM" size="20" maxlength= "8" class="input_ReadOnly" readonly>
                            <img src="/images/button/btn_HelpOn.gif" id="ImgCusCd" name="ImgCusCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_VendorPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        </td>
                   </tr>
                   <tr>
                        <td align="center" class="creamBold">프로젝트</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtPRJ_CD" name="txtPRJ_CD" size="10" maxlength= "8" class="input_ReadOnly" readonly>
                            <input id="txtPRJ_NM" name="txtPRJ_NM" size="20" maxlength= "8" class="input_ReadOnly"  readonly>
                            <img src="/images/button/btn_HelpOn.gif" id="ImgPrjCd" name="ImgPrjCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_PrjPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        </td>
                        <td align="center" class="creamBold">부서</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtDPT_CD" name="txtDPT_CD" size="10" maxlength= "8" class="input_ReadOnly" readonly>
                            <input id="txtDPT_NM" name="txtDPT_NM" size="20" maxlength= "8" class="input_ReadOnly"  readonly>
                            <img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CostDeptPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        </td>
                   </tr>
                   <tr>
                        <td align="center" class="creamBold">차변(Dr) </td>
                        <td class="padding2423">
                            <input id="txtDR_AMT" size="14" readonly class="input_ReadOnly" maxlength= "14">
                        </td>
                        <td align="center" class="creamBold"> 대변(Cr)</td>
                        <td class="padding2423">
                            <input id="txtCR_AMT" size="14" readonly class="input_ReadOnly" maxlength= "14">
                        </td>
                        <td align="center" class="creamBold"> 전기키</td>
                        <td class="padding2423">
                            <input id="txtWRITEKEY" size="14" readonly class="input_ReadOnly" maxlength= "14">
                        </td>
                   </tr>
                   <tr>
                        <td align="center" class="creamBold">적 요</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtDESP" name="txtDESP" size="50" class="input_ReadOnly"  maxlength= "8">
                        </td>
                        <td align="center" class="creamBold">비 고</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtDESP2" name="txtDESP2" size="50" class="input_ReadOnly"  	maxlength= "8">
                        </td>
                   </tr>
                </table>
            </td>
        </tr>
    </table>
<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="40" align="left" style="padding-right:5px; padding-bottom:2px;">
                        <input type=button value=" ▲ " style="width:40" onClick="on_Move('up');">
                    </td>
                    <td width="40" align="left" style="padding-right:5px; padding-bottom:2px;">
						<input type=button value=" ▼ " style="width:40" onClick="on_Move('down');">
                    </td>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="360" align="right" style="padding-right:5px; padding-bottom:2px;">
                        <input type="button" id="btnPROC2" style="cursor:hand;width:100pt;height:20pt;" value=" 전표 데이터 생성 " onclick="fnc_proc2()">
                        <input type="button" id="btnPROC1" style="cursor:hand;width:100pt;height:20pt;" value=" 전표 데이터 전송 " onclick="fnc_proc()">
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
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
							<param name="DataID"					value="dsT_CP_PAYTABLE">
							<param name="ViewSummary"				value=1>
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
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
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CP_PAYTABLE">
		<Param Name="BindInfo", Value="
			<C>Col='ACC_CD'		Ctrl='txtACC_CD'		Param=value</C>
			<C>Col='ACC_NM'		Ctrl='txtACC_NM'		Param=text</C>
			<C>Col='CUS_CD'		Ctrl='txtCUS_CD'		Param=value</C>
			<C>Col='CUS_NM'		Ctrl='txtCUS_NM'		Param=value</C>
			<C>Col='PRJ_CD'		Ctrl='txtPRJ_CD'		Param=value</C>
			<C>Col='PRJ_NM'		Ctrl='txtPRJ_NM'		Param=value</C>
			<C>Col='DPT_CD'		Ctrl='txtDPT_CD'		Param=value</C>
			<C>Col='DPT_NM'		Ctrl='txtDPT_NM'		Param=value</C>
			<C>Col='WRITEKEY'	Ctrl='txtWRITEKEY'		Param=value</C>
			<C>Col='CR_AMT'		Ctrl='txtCR_AMT'		Param=value</C>
			<C>Col='DR_AMT'		Ctrl='txtDR_AMT'		Param=value</C>
			<C>Col='DESP'		Ctrl='txtDESP'		Param=value</C>
			<C>Col='DESP2'		Ctrl='txtDESP2'		Param=value</C>
	    ">
	</object>
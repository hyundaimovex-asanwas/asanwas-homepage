<!--
***********************************************************************
* @source      : buta090.jsp
* @description : 해외출장품의서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/15      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>해외출장품의서(buta090)</title>
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
    <script language="javascript" >

		var btnList = 'TFFTTTFT';

        var today = getToday();

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//근태변경신청현황 정보 조회
			var str_ymd      = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd      = document.getElementById("txtEND_YMD_SHR").value;
			var but_city_cd  = document.getElementById("cmbBUT_CITY_CD_SHR").value;
            var but_eno_no   = document.getElementById("txtENO_NO_SHR").value;

            but_eno_no = (but_eno_no == null || but_eno_no == '') ? "%" : but_eno_no;
            dsT_DI_OVERSEASBT_DTL.ClearAll();
			dsT_DI_OVERSEASBT.ClearData();

            dsT_DI_OVERSEASBT.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                                     + "&S_MODE=SHR_01"
                                     + "&STR_YMD="+str_ymd
                                     + "&END_YMD="+end_ymd
                                     + "&BUT_CITY_CD="+but_city_cd
                                     + "&BUT_ENO_NO="+but_eno_no;
			dsT_DI_OVERSEASBT.reset();
            document.getElementById("txtSTR_YMD_SHR").focus();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem(row) {

            trT_DI_OVERSEASBT_DTL.KeyValue = "tr01(O:dsT_DI_OVERSEASBT_DTL=dsT_DI_OVERSEASBT_DTL)";
            trT_DI_OVERSEASBT_DTL.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                                         + "&S_MODE=SHR_02"
                                         + "&BASIC_YMD="+dsT_DI_OVERSEASBT.NameValue(row,"BUT_FR_YMD")
                                         + "&ORD_NO="+dsT_DI_OVERSEASBT.NameValue(row,"ORD_NO");
            trT_DI_OVERSEASBT_DTL.post();

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

            if(!fnc_SaveItemCheck()) return;

 			trT_DI_OVERSEASBT.KeyValue = "tr01(I:dsT_DI_OVERSEASBT=dsT_DI_OVERSEASBT, I:dsT_DI_OVERSEASBT_DTL=dsT_DI_OVERSEASBT_DTL)";
			trT_DI_OVERSEASBT.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD&S_MODE=SAV";
			trT_DI_OVERSEASBT.post();

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_DI_OVERSEASBT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[품의번호:" + dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"ORD_NO") +"] 자료를 제거하시겠습니까?") == false) return;
            dsT_DI_OVERSEASBT.DeleteRow(dsT_DI_OVERSEASBT.RowPosition);

			trT_DI_OVERSEASBT.KeyValue = "SVL(I:dsT_DI_OVERSEASBT=dsT_DI_OVERSEASBT)";
			trT_DI_OVERSEASBT.Action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD&S_MODE=DEL";
			trT_DI_OVERSEASBT.post();

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

           if(!fnc_SearchItemCheck()) return;

			//근태변경신청현황 정보 조회
			var BASIC_YMD = dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"BUT_FR_YMD");
			var ORD_NO = dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"ORD_NO") ;

	        var hnwparm = "[:BASIC_YMD]="+BASIC_YMD+"[:ORD_NO]="+ORD_NO;
			document.form1.rptObject.SetValues(hnwparm);
            document.form1.rptObject.RunButton("Print");

	        //var url = "buta091_PV.jsp?BASIC_YMD="+BASIC_YMD+"&ORD_NO="+ORD_NO;
   			//window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        //return;
         }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_DI_OVERSEASBT.CountRow < 1 && dsT_DI_OVERSEASBT_DTL.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            if(dsT_DI_OVERSEASBT_DTL.CountRow > 0){
				form1.grdT_DI_OVERSEASBT_DTL.GridToExcel("해외출장품의서상세", '', 225);
            }

            if(dsT_DI_OVERSEASBT.CountRow > 0){
                //form1.grdT_DI_OVERSEASBT.GridToExcel("해외출장품의서", '', 225);
                form1.grdT_DI_OVERSEASBT.RunExcelSheetEx("해외출장품의서", 1, 0);
            }



        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_DI_OVERSEASBT.CountColumn < 1) {
                dsT_DI_OVERSEASBT.setDataHeader("ORD_NO:STRING,BUT_FR_YMD:STRING,BUT_TO_YMD:STRING,BUT_CITY_CD:STRING,BUT_CITY_DTL:STRING,BUT_OBJ:STRING,TRANS_NO:STRING,CURRENCY_NM:STRING,EXT_RATE:DECIMAL");
            }

            //dsT_DI_OVERSEASBT.AddRow();
            dsT_DI_OVERSEASBT.InsertRow(1);

            document.getElementById("cmbBUT_CITY_CD").focus();

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

			// 해당 Dataset의 Header가 추가하지 않음
            if (dsT_DI_OVERSEASBT_DTL.CountColumn < 1) {
                return;
            }

            if(dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"ORD_NO") == ""){
                alert("출장품의서를 먼저 저장하신후에 추가가 가능합니다.");
                return;
            }

            dsT_DI_OVERSEASBT_DTL.AddRow();
            dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.RowPosition,"ORD_NO") = dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"ORD_NO");    //품의번호
            if(dsT_DI_OVERSEASBT_DTL.CountRow < 1){
                dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.RowPosition,"SEQ") = 1;  //순번
            }else{
                dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.RowPosition,"SEQ") = (Number(dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.CountRow-1,"SEQ"))+1);  //순번
            }


            //출장일수를 알아오기
            var from_ymd = dsT_DI_OVERSEASBT.NameString(dsT_DI_OVERSEASBT.RowPosition, "BUT_FR_YMD").replace(/-/g, '');
            var to_ymd   = dsT_DI_OVERSEASBT.NameString(dsT_DI_OVERSEASBT.RowPosition, "BUT_TO_YMD").replace(/-/g, '');
            var dateDiff = fnc_covNumber(cfDateDiff(from_ymd, to_ymd));

            dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.RowPosition,"BUT_NIGHT")  = dateDiff;
            dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.RowPosition,"BUT_DAY")    = dateDiff+1;
            dsT_DI_OVERSEASBT_DTL.NameValue(dsT_DI_OVERSEASBT_DTL.RowPosition,"ENO_GBN")    = "P";

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

            dsT_DI_OVERSEASBT_DTL.DeleteRow(dsT_DI_OVERSEASBT_DTL.RowPosition);

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//document.getElementById("txtSTR_YMD_SHR").value = "";
			//document.getElementById("txtEND_YMD_SHR").value = "";
			document.getElementById("cmbBUT_CITY_CD_SHR").value = "";
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_OVERSEASBT.ClearData();
            dsT_DI_OVERSEASBT_DTL.ClearAll();

            document.getElementById("txtSTR_YMD_SHR").focus();

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_OVERSEASBT.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var str_ymd = document.getElementById("txtSTR_YMD_SHR");
			var end_ymd = document.getElementById("txtEND_YMD_SHR");

            if(str_ymd.value == ""){
                alert("조회 시작일을 입력하세요!");
                str_ymd.focus();
                return false;
            }
            if(end_ymd.value == ""){
                alert("조회 종료일을 입력하세요!");
                end_ymd.focus();
                return false;
            }
            return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if (!dsT_DI_OVERSEASBT.IsUpdated && !dsT_DI_OVERSEASBT_DTL.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);
            cfStyleGrid(form1.grdT_DI_OVERSEASBT,15,"false","false");      // Grid Style 적용
            cfStyleGrid(form1.grdT_DI_OVERSEASBT_DTL,15,"true","false");      // Grid Style 적용


            //출장지
            fnc_ConstructCommonCode("dsT_CM_COMMON_L2", "cmbBUT_CITY_CD_SHR");
            fnc_ConstructCommonCode("dsT_CM_COMMON_L2", "cmbBUT_CITY_CD");


            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getEndDate();
            document.getElementById("txtSTR_YMD_SHR").focus();

            //프린트 관련 obj 숨김
            fnc_HiddenElement("rptObject");
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************
         * 16. 단위 입력    *
         *******************/
		function fnc_InputCurrency() {

            if(document.getElementById("cmbBUT_CITY_CD").value == "KR"){
                alert("대한민국은 선택할 수 없습니다!");
                document.getElementById("cmbBUT_CITY_CD").value = "";
                return;
            }

  			var BUT_CITY_CD = document.getElementById("cmbBUT_CITY_CD").value;
			dsT_DI_OVERSEASBT_BASIS_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                                              + "&S_MODE=SHR_04"
                                              + "&BUT_CITY_CD="+BUT_CITY_CD;
			dsT_DI_OVERSEASBT_BASIS_01.reset();

		}



        var elementList = new Array(     "txtBUT_FR_YMD"
                                        ,"txtBUT_TO_YMD"
                                        ,"imgBUT_FR_YMD"
                                        ,"imgBUT_TO_YMD"
                                        ,"cmbBUT_CITY_CD"
                                        ,"txtBUT_CITY_DTL"
                                        ,"txtBUT_OBJ"
                                        ,"txtEXT_RATE");

        var exceptionList = new Array(   "txtBUT_FR_YMD"
                                        ,"txtBUT_TO_YMD"
                                        ,"imgBUT_FR_YMD"
                                        ,"imgBUT_TO_YMD"
                                        ,"cmbBUT_CITY_CD");




        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var Row         = dsT_DI_OVERSEASBT_DTL.RowPosition;
            var obj         = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'ENO_NO') = obj.eno_no;
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'ENO_NM') = obj.eno_nm;
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'DPT_CD') = obj.dpt_cd;
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'DPT_NM') = obj.dpt_nm;
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'JOB_CD') = obj.job_cd;
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'JOB_NM') = obj.job_nm;


                //지급 기준을 조회
                fnc_SearchPayBasis(obj.job_cd);
                //직급 금액 설정
                fnc_BindPayBasis();

            } else {
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'ENO_NO') = "";
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'ENO_NM') = "";
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'DPT_NM') = "";
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'JOB_NM') = "";
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'JOB_CD') = "";

                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'BAS_EXPENSE') = "";
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'BAS_LODGING') = "";
                dsT_DI_OVERSEASBT_DTL.NameValue(Row,'BAS_EXPENSE_OFFER') = "";

            }
        }

        /**
         * 지급기준을 조회해 온다.
         * @param job_cd - 지급기준을 조회해 올 직위 코드
         */
        function fnc_SearchPayBasis(job_cd) {
            var but_fr_ymd  = dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"BUT_FR_YMD");
            var but_city_cd = dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"BUT_CITY_CD");

            //지급기준을 조회
            trT_DI_OVERSEASBT_DTL.KeyValue = "tr01(O:dsT_DI_OVERSEASBT_BASIS=dsT_DI_OVERSEASBT_BASIS)";
            trT_DI_OVERSEASBT_DTL.action   = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                                           + "&S_MODE=SHR_03"
                                           + "&BASIC_YMD="+but_fr_ymd
                                           + "&BUT_CITY_CD="+but_city_cd
                                           + "&JOB_CD="+job_cd;
            trT_DI_OVERSEASBT_DTL.post();

            //지급기준 조회해 오기
            var row = dsT_DI_OVERSEASBT_DTL.RowPosition;

            dsT_DI_OVERSEASBT_DTL.NameValue(row,'BAS_EXPENSE')          = dsT_DI_OVERSEASBT_BASIS.NameValue(1,'BAS_EXPENSE');
            dsT_DI_OVERSEASBT_DTL.NameValue(row,'BAS_EXPENSE_OFFER')    = dsT_DI_OVERSEASBT_BASIS.NameValue(1,'BAS_EXPENSE_OFFER');
            dsT_DI_OVERSEASBT_DTL.NameValue(row,'BAS_LODGING')          = dsT_DI_OVERSEASBT_BASIS.NameValue(1,'BAS_LODGING');
        }

        /**
         * 지급기준으로 금액을 설정하기
         */
        function fnc_BindPayBasis() {
            var row = dsT_DI_OVERSEASBT_DTL.RowPosition;

            var bas_expense         = dsT_DI_OVERSEASBT_DTL.NameValue(row, "BAS_EXPENSE");      //일당
            var bas_expense_offer   = dsT_DI_OVERSEASBT_DTL.NameValue(row, "BAS_EXPENSE_OFFER");//숙박비 제공시 일당
            var bas_lodging         = dsT_DI_OVERSEASBT_DTL.NameValue(row, "BAS_LODGING");      //숙박비

            if(dsT_DI_OVERSEASBT_DTL.NameString(row, "BUT_OFFER") == "T") {
                dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_EXPENSE_FOR") = bas_expense_offer * dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_DAY");
                dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_LODGING_FOR") = 0;
            } else {
                dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_EXPENSE_FOR") = bas_expense * dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_DAY");
                dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_LODGING_FOR") = bas_lodging * dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_NIGHT");
            }

           dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_CNT")             = dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_EXPENSE") + dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_LODGING")
                                                                       + dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_AIRFARE") + dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_ISSUE");
           dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_CNT_FOR")         = dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_EXPENSE_FOR") + dsT_DI_OVERSEASBT_DTL.NameValue(row, "BUT_LODGING_FOR");
        }

        /**
         * 전표처리를 합시다.
         */
        function fnc_Slipconduct(){

            //수정된 건이 있는지 여부를 확인합니다.
            if(dsT_DI_OVERSEASBT.isUpdated
                    || dsT_DI_OVERSEASBT_DTL.isUpdated) {
                if(!confirm("수정된 데이타가 있습니다. 계속하시겠습니까?")) {
                    return;
                }
            }

            if(dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"TRANS_NO") != "") {
                alert("이미 전표 처리가 완료 되었습니다.");
                return;
            }


            var ORD_NO = dsT_DI_OVERSEASBT.NameValue(dsT_DI_OVERSEASBT.RowPosition,"ORD_NO");

            if(!confirm("신청번호:"+ORD_NO+"건의 전표처리를 하시겠습니까?")) {
                return;
            }

            dsSILP.dataid    = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                             + "&S_MODE=CHIT"
                             + "&ORD_NO="+ORD_NO;
            dsSILP.reset();
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_OVERSEASBT)     |
    | 3. 사용되는 Table List(T_DI_OVERSEASBT) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_OVERSEASBT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_OVERSEASBT_DTL) |
    | 3. 사용되는 Table List(T_DI_OVERSEASBT_DTL) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_OVERSEASBT_DTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS             |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 전표처리용 DS -->
    <Object ID="dsSILP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_OVERSEASBT)      |
    | 3. 사용되는 Table List(T_DI_OVERSEASBT)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_OVERSEASBT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_DI_OVERSEASBT_DTL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 출장지 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_L2"/>
       <jsp:param name="CODE_GUBUN"    value="L2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERSEASBT Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩

            fnc_SearchItem(1);//상세조회
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsSILP Event="OnLoadCompleted(iCount)">
        fnc_SearchList();
		fnc_SearchItem(1);
        alert("전표처리가 완료되었습니다.");
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERSEASBT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준일/출장지/직위/환율] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("기준일/출장지/직위에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERSEASBT_DTL Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERSEASBT_DTL Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnLoadCompleted(iCount)">

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERSEASBT_BASIS_01 Event="OnLoadCompleted(iCount)">
        if(dsT_DI_OVERSEASBT_BASIS_01.CountRow == 1)
            document.getElementById("txtCURRENCY_NM").value = dsT_DI_OVERSEASBT_BASIS_01.NameString(1, "CURRENCY_NM");
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT_BASIS_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_OVERSEASBT event="OnSuccess()">
        fnc_SearchList();
		fnc_SearchItem(1)
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_OVERSEASBT event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid의 row를 클릭시 처리  |
    +------ -------------------->
	<script for=grdT_DI_OVERSEASBT event=OnClick(Row,Colid)>
		if(Row > 0) {
            if(dsT_DI_OVERSEASBT.NameValue(Row,"ORD_NO") != ""){
			    fnc_SearchItem(Row);
            }
		}
	</script>

    <!---------------------------+
    | grid의 팝업필드 클릭시 처리|
    +---------------------------->
    <script language="javascript" for=grdT_DI_OVERSEASBT_DTL event=OnPopup(row,colid,data)>

        if(row > 0) {
            // 사번, 성명 조회
            if ( colid == 'POPUP') {
                // '정직원이면 정직원 사원 조회 아니면 직접 사용자 입력'
                if(dsT_DI_OVERSEASBT_DTL.NameValue(row, "ENO_GBN") == "P") {
                    fnc_ClickEmpPopup();
                }
                else {
                    var obj = new String();

                    obj.eno_nm = "";
                    obj.dpt_cd = "";
                    obj.dpt_nm = "";
                    obj.job_cd = "";
                    obj.job_nm = "";

                    window.showModalDialog("buta091.jsp", obj, "dialogWidth:500px; dialogHeight:250px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                    if(obj.eno_nm != "") {
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NM') = obj.eno_nm;
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'DPT_CD') = obj.dpt_cd;
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'DPT_NM') = obj.dpt_nm;
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_CD') = obj.job_cd;
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_NM') = obj.job_nm;

                        //지급기준을 조회
                        fnc_SearchPayBasis(obj.job_cd);
                        //직급 금액 설정
                        fnc_BindPayBasis();
                    }
                }
            }
        }
    </script>

    <!---------------------------+
    | grid의 키버튼 클릭시
    +---------------------------->
    <script language="javascript" for=grdT_DI_OVERSEASBT_DTL event=OnKeyPress(kcode)>
        var row = dsT_DI_OVERSEASBT_DTL.RowPosition;
        var column = grdT_DI_OVERSEASBT_DTL.GetColumn();


        // '정직원이면 정직원 사원 조회 아니면 직접 사용자 입력'
        if(dsT_DI_OVERSEASBT_DTL.NameValue(row, "ENO_GBN") == "P") {

            //필드가 사번, 성명 필드명이고 엔터 버튼을 누를때 발생하는 이벤트
            if ( column == 'ENO_NO' && kcode == "13" ) {
                document.getElementById("txtENO_NO").value = dsT_DI_OVERSEASBT_DTL.NameValue(row, "ENO_NO");
                fnc_SearchEmpNo();

            } else if( column == 'ENO_NM' && kcode == "13" ) {
                document.getElementById("txtENO_NM").value = dsT_DI_OVERSEASBT_DTL.NameValue(row, "ENO_NM");
                fnc_SearchEmpNm();
            }
        }

    </script>

    <!--------------------------------------------------------------------------+
    | GRID에서 사번 또는  성명을 지웠을 때 본부, 소속, 직위도 함께 지워지도록 함|
    +--------------------------------------------------------------------------->
    <script language="javascript"  for=grdT_DI_OVERSEASBT_DTL event=OnExit(row,colid,olddata)>
        if(row > 0) {

            if (colid == 'ENO_NO' || colid == 'ENO_NM') {
                if (dsT_DI_OVERSEASBT_DTL.NameValue(row, colid) == "") {
                    dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NO') = "";
                    dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NM') = "";
                    dsT_DI_OVERSEASBT_DTL.NameValue(row,'DPT_NM') = "";
                    dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_NM') = "";
                    dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_CD') = "";
                }
            }

            //직원 구분
            if(colid == "ENO_GBN") {
                //직원구분이 정직원인데 사번이 비워있으면 나머지 항목들도 비워둠
                if(dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_GBN') == "P") {
                    if (dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NO') != "") {
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NO') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NM') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'DPT_NM') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_NM') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_CD') = "";
                    }
                }
                //직원구분이 기타인데 사번이 있으면 나머지 항목들도 비워둠
                else {
                    if (dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NO') == "") {
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NO') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'ENO_NM') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'DPT_NM') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_NM') = "";
                        dsT_DI_OVERSEASBT_DTL.NameValue(row,'JOB_CD') = "";
                    }
                }
            }

        }
    </script>


    <!-----------------------------------------------------+
    | 다른 Column으로 옮길때 이벤트 |    -- Column이 변경되기 직전에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_DI_OVERSEASBT_DTL event=OnColumnPosChanged(row,colid)>
        if(row>0) {
            if(dsT_DI_OVERSEASBT_DTL.NameValue(row, "ENO_GBN") == "P") {
                grdT_DI_OVERSEASBT_DTL.ColumnProp('ENO_NO', 'Edit') = 'Numeric';
                grdT_DI_OVERSEASBT_DTL.ColumnProp('ENO_NM', 'Edit') = '';
            } else {
                grdT_DI_OVERSEASBT_DTL.ColumnProp('ENO_NO', 'Edit') = 'None';
                grdT_DI_OVERSEASBT_DTL.ColumnProp('ENO_NM', 'Edit') = 'None';
            }

            fnc_BindPayBasis();
        }
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_DI_OVERSEASBT event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

       // 전표생성 후 원화입력해야 함
       // grdT_DI_OVERSEASBT_DTL.Editable = false;

        fnc_ChangeStateElement(false, "ImgAppend");
        fnc_ChangeStateElement(false, "ImgRemove");


        if(row > 0) {
            //신규일 경우
            if(dsT_DI_OVERSEASBT.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }

            if(dsT_DI_OVERSEASBT.NameString(row, "TRANS_NO") == ""){
                grdT_DI_OVERSEASBT_DTL.Editable = true;
                fnc_ChangeStateElement(true, "ImgAppend");
                fnc_ChangeStateElement(true, "ImgRemove");
            }
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_DI_OVERSEASBT event=CanRowPosChange(row)>
        if(row > 0) {

            if(dsT_DI_OVERSEASBT.NameString(row, "BUT_FR_YMD") == "") {
                alert("시작일을 입력하세요.");
                document.getElementById("txtBUT_FR_YMD").focus;
                return false;
            }
            if(dsT_DI_OVERSEASBT.NameString(row, "BUT_TO_YMD") == "") {
                alert("종료일을 입력하세요.");
                document.getElementById("txtBUT_TO_YMD").focus;
                return false;
            }
            if(dsT_DI_OVERSEASBT.NameString(row, "BUT_CITY_CD") == "") {
                alert("출장지를 입력하세요.");
                document.getElementById("cmbBUT_CITY_CD").focus;
                return false;
            }

        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_DI_OVERSEASBT_DTL event=CanRowPosChange(row)>
        if(row > 0) {

            if(dsT_DI_OVERSEASBT_DTL.NameString(row, "ENO_NM") == "") {
                alert("성명을 입력하세요.");
                grdT_DI_OVERSEASBT_DTL.SetColumn("ENO_NM");
                return false;
            }

            if(dsT_DI_OVERSEASBT_DTL.NameString(row, "BUT_NIGHT") == "") {
                alert("박수 를 입력하세요.");
                grdT_DI_OVERSEASBT_DTL.SetColumn("BUT_NIGHT");
                return false;
            }

            if(dsT_DI_OVERSEASBT_DTL.NameString(row, "BUT_DAY") == "") {
                alert("일수 를 입력하세요.");
                grdT_DI_OVERSEASBT_DTL.SetColumn("BUT_DAY");
                return false;
            }

            fnc_BindPayBasis();
        }
    </script>

    <!--------------------------+
    | 데이타 그리드가 포커스를 잃었을때  |
    +--------------------------->
    <script language=JavaScript for=grdT_DI_OVERSEASBT_DTL event=OnKillFocus()>
        fnc_BindPayBasis();
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">해외출장품의서</td>
					<td align="right" class="navigator">HOME/근태관리/출장관리/<font color="#000000">해외출장품의서</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="60"></col>
							<col width="220"></col>
                            <col width="60"></col>
                            <col width="160"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">출장기간&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','113');"></a> ~
							    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','113');"></a>
							</td>
							<td class="searchState" align="right">출장지&nbsp;</td>
							<td class="padding2423" align="left">
								<select id="cmbBUT_CITY_CD_SHR"  style="width='100%';" onChange="fnc_SearchList()">
									<option value="">전 체</option>
								</select>
							</td>
                            <td align="right" class="searchState">사 번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();"></a>
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
                        <col width="100"></col>
                        <col width="170"></col>
                        <col width="100"></col>
                        <col width="170"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">품의번호</td>
						<td class="padding2423">
							<input id="txtORD_NO" style="width:100%" class="input_ReadOnly" readOnly>
						</td>
                        <td align="center" class="creamBold">출장기간</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtBUT_FR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_FR_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);" onkeypress="javascript:cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBUT_FR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBUT_FR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBUT_FR_YMD','','10','185');"></a> ~

                            <input id="txtBUT_TO_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_TO_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);" onkeypress="javascript:cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBUT_TO_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBUT_TO_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBUT_TO_YMD','','125','185');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">출장지</td>
                        <td class="padding2423">
                            <select id="cmbBUT_CITY_CD"  style="width='100%';" onChange="fnc_InputCurrency();"></select>
                        </td>
                        <td align="center" class="creamBold">단 위</td>
                        <td class="padding2423">
                            <input id="txtCURRENCY_NM" size="9" class="input_ReadOnly" readOnly">
                        </td>
                        <td align="center" class="creamBold">환 율</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtEXT_RATE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                                <param name=MaxDecimalPlace         value=3>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">상세출장지</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtBUT_CITY_DTL" style="width:100%" onkeyup="fc_chk_byte(this,100);">
                        </td>
                        <td align="center" class="creamBold">전표번호</td>
                        <td class="padding2423">
                            <input id="txtTRANS_NO" size="9" class="input_ReadOnly" readOnly">
                        </td>
                    </tr>
                    <tr>

                        <td align="center" class="creamBold">출장목적</td>
                        <td class="padding2423" colspan="5">
                            <input id="txtBUT_OBJ" style="width:100%" onkeyup="fc_chk_byte(this,100);">
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
						<td width="360" valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSlipconduct','','/images/button/btn_SlipconductOver.gif',1)"><img src="/images/button/btn_SlipconductOn.gif" name="imgSlipconduct" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Slipconduct()"></a>
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
					<object id="grdT_DI_OVERSEASBT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:144px;">
						<param name="DataID" value="dsT_DI_OVERSEASBT">
						<param name="Format" value='
							<C> id="{CUROW}"		width=39	name="NO"			align=center	value={String(Currow)}	</C>
                            <C> id="ORD_NO"	        width=80	name="품의번호"		align=center    </C>
                            <C> id="BUT_FR_YMD"	    width=90	name="출장시작일"	align=center    </C>
                            <C> id="BUT_TO_YMD"     width=90	name="출장종료일"   align=center    </C>
                            <C> id="BUT_CITY_CD"	width=90	name="출장지"	    align=left      EditStyle=Lookup  Data="dsT_CM_COMMON_L2:CODE:CODE_NAME"</C>
                            <C> id="BUT_CITY_DTL"	width=140	name="상세출장지"	align=left      </C>
                            <C> id="BUT_OBJ"	    width=155	name="출장목적"	    align=left      </C>
                            <C> id="TRANS_NO"	    width=80	name="전표번호"	    align=center    </C>
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

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="right">
                            <span id="rate_msg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <img src="/images/button/btn_AppendOn.gif" name="ImgAppend"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppend','','/images/button/btn_AppendOver.gif',1)">
                            <img src="/images/button/btn_RemoveOn.gif" name="ImgRemove"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRemove','','/images/button/btn_RemoveOver.gif',1)">
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

                    <!-- 사번 검색을 위해 임시 숨김 개체 -->
                    <input type="hidden" name="txtENO_NO">
                    <input type="hidden" name="txtENO_NM">
                    <input type="hidden" name="hidEMPL_DPT_CD">

					<comment id="__NSID__">
					<object id="grdT_DI_OVERSEASBT_DTL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:147px;">
						<param name="DataID" value="dsT_DI_OVERSEASBT_DTL">
						<param name="Format" value='
                            <C> id="ENO_GBN"	    width=80	name="구분"	            align=left      EditStyle=Combo     Data="P:정직원,E:기타"</C>
                            <C> id="DPT_NM"		    width=80	name="소속"	            align=left      Edit=None </C>
                            <C> id="JOB_NM"		    width=65	name="직위"	            align=center    Edit=None </C>
                            <C> id="ENO_NO"	        width=65	name="사번"             align=center    Edit="Numeric"  EditLimit=10 </C>
                            <C> id="ENO_NM"	        width=65	name="성명"	            align=center     				EditLimit=20 </C>
                            <C> id="POPUP"	        width=20	name=""	                align=center     				EditStyle=PopupFIX     EditLimit=20</C>
                            <C> id="BUT_NIGHT"	    width=40	name="박"		        align=center    Edit="Numeric"  EditLimit=3 </C>
                            <C> id="BUT_DAY"	    width=40	name="일"		        align=center    Edit="Numeric"  EditLimit=3 </C>
                            <C> id="BUT_OFFER"	    width=80	name="숙식제공여부"		align=center    EditStyle=CheckBox</C>
                            <C> id="BUT_AIRFARE"	width=100	name="항공료"	        align=right    </C>
                            <C> id="BUT_ISSUE"      width=100	name="비자/여권발급비"  align=right    </C>
                            <G> name="일 비" HeadBgColor="#F7DCBB"
                                <C> id="BUT_EXPENSE"	    width=100	name="원화"	    align=right      </C>
                                <C> id="BUT_EXPENSE_FOR"	width=100	name="외화"	    align=right      Edit=None</C>
                            </G>
                            <G> name="숙박비" HeadBgColor="#F7DCBB"
                                <C> id="BUT_LODGING"	    width=100	name="원화"	    align=right      </C>
                                <C> id="BUT_LODGING_FOR"	width=100	name="외화"	    align=right      Edit=None</C>
                            </G>
                            <G> name="합 계" HeadBgColor="#F7DCBB"
                                <C> id="BUT_CNT"	        width=100	name="원화"	    align=right      Value={BUT_EXPENSE + BUT_LODGING + BUT_AIRFARE + BUT_ISSUE} Edit=None</C>
                                <C> id="BUT_CNT_FOR"	    width=100	name="외화"	    align=right      Value={BUT_EXPENSE_FOR + BUT_LODGING_FOR} Edit=None</C>
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
	<comment id="__HNWID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="buta090.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
	</comment><script> __ShowEmbedObject(__HNWID__); </script>
	<!-- 내용 조회 그리드 데이블 끝-->
	</form>
	<!-- form 끝 -->
</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 해외출장 품의서작성 테이블 -->
<object id="bndT_DI_OVERSEASBT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_OVERSEASBT">
	<Param Name="BindInfo", Value='
        <C>Col=ORD_NO           Ctrl=txtORD_NO      	Param=value 	</C>
		<C>Col=BUT_FR_YMD       Ctrl=txtBUT_FR_YMD     	Param=value 	</C>
        <C>Col=BUT_TO_YMD      	Ctrl=txtBUT_TO_YMD      Param=value 	</C>
		<C>Col=BUT_CITY_CD		Ctrl=cmbBUT_CITY_CD	   	Param=value		</C>
		<C>Col=BUT_CITY_DTL     Ctrl=txtBUT_CITY_DTL   	Param=value		</C>
		<C>Col=BUT_OBJ		    Ctrl=txtBUT_OBJ 	    Param=value		</C>
		<C>Col=TRANS_NO		    Ctrl=txtTRANS_NO		Param=value		</C>
        <C>Col=CURRENCY_NM      Ctrl=txtCURRENCY_NM     Param=value		</C>
        <C>Col=EXT_RATE         Ctrl=txtEXT_RATE        Param=text      </C>
    '>
</object>

<object id="bndT_DI_OVERSEASBT_DTL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_OVERSEASBT_DTL">
	<Param Name="BindInfo", Value='
        <C>Col=ENO_NO           Ctrl=txtENO_NO      	Param=value 	</C>
        <C>Col=ENO_NM           Ctrl=txtENO_NM      	Param=value 	</C>
    '>
</object>
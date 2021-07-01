<!--
    ************************************************************************************
    * @Source              : codb020.jsp                                                                        *
    * @Description        : 부서코드관리                                                                                            *
    * @Font                   :                                                                                        *
    * @Developer Desc :                                                                                            *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                             	*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사																*
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>부서코드관리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >


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
        	
			if(fnc_SaveItemCheck()) {
				
				tr01T_CM_DEPT.KeyValue = "SVL(I:ds01T_CM_DEPT=ds01T_CM_DEPT)";
				tr01T_CM_DEPT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SAV_01";
				tr01T_CM_DEPT.post();
	            dsT_CM_DEPT.Reset();//트리도 재구성한다.
	            
			} else {
				return;
			}
			
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
        	
			// 삭제 할 자료가 있는지 체크하고
            if (ds01T_CM_DEPT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			//하위부서가 있으면 삭제 않된다
			var oDOWNDPT_CD = ds01T_CM_DEPT.NameValue(ds01T_CM_DEPT.RowPosition,"DOWNDPT_CD");
			//alert("row:"+ds01T_CM_DEPT.RowPosition+", down:"+oDOWNDPT_CD);
			if(oDOWNDPT_CD == "2"){
				alert("하위부서가 존재합니다.");
				return false;
			}

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + ds01T_CM_DEPT.ColumnString(ds01T_CM_DEPT.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            
            
            ds01T_CM_DEPT.DeleteRow(ds01T_CM_DEPT.RowPosition);
			tr01T_CM_DEPT.KeyValue = "SVL(I:ds01T_CM_DEPT=ds01T_CM_DEPT)";
			tr01T_CM_DEPT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=DEL";
			tr01T_CM_DEPT.post();
            dsT_CM_DEPT.Reset();//트리도 재구성한다.
            
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

            if(document.tvT_CM_DEPT.ItemText.trim() == ""){
            	alert("트리 아이템을 먼저 선택해주세요.");
	            return false;
            }

			//AddNew
            ds01T_CM_DEPT.AddRow();

            //현재 선택된 트리의 정보를 가져온다.
			var overNm = document.tvT_CM_DEPT.ItemText;
			var Row = dsT_CM_DEPT.NameValueRow("DPT_NM",overNm);
			var oUPCD_GBN = dsT_CM_DEPT.NameValue(Row,"CD_GBN");
			var oUPDPT_CD = dsT_CM_DEPT.NameValue(Row,"DPT_CD");
			var oUPDPT_NM = dsT_CM_DEPT.NameValue(Row,"DPT_NM");

			var oDPT_LBL=	dsT_CM_DEPT.NameValue(Row,"DPT_LBL");
			var oCOUNT_REM=dsT_CM_DEPT.NameValue(Row,"COUNT_REM");
			var dsCnt = ds01T_CM_DEPT.CountRow

			//하위트리로 하기위해 레벨을 올린다.
			oDPT_LBL = parseInt(oDPT_LBL)+1;
			//하위트리의 마지막 seq를 계산하여 뒤에 붙인다.
			oCOUNT_REM = oCOUNT_REM+lpad(parseInt(dsCnt)-1, 3, "0");
			//alert("oDPT_LBL:"+oDPT_LBL+", oCOUNT_REM:"+oCOUNT_REM);

            document.getElementById("txtUPCD_GBN").value = oUPCD_GBN;
            document.getElementById("txtUPDPT_CD").value = oUPDPT_CD;
            document.getElementById("txtUPDPT_NM").value = oUPDPT_NM;
            document.getElementById("txtDPT_LBL").value = oDPT_LBL;
            document.getElementById("txtCOUNT_REM").value = oCOUNT_REM;

			//코드구분은 디폴트 값을 준다.
			if(oUPCD_GBN.trim() == ""){
				document.getElementById("txtCD_GBN").value = "B2";
				enableInput2();
			}else if(oUPCD_GBN == "B2"){
				document.getElementById("txtCD_GBN").value = "A4";
				enableInput();
			}else if(oUPCD_GBN == "A4"){
				document.getElementById("txtCD_GBN").value = "A6";
				//--enableInput2();
				enableInput();

			}

			//입력 테이블로 포커스
			document.getElementById("txtDPT_CD").focus();
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
        	
			dsT_CM_DEPT.ClearData();
			dsT_CM_DEPT.Reset();
			ds01T_CM_DEPT.ClearData();
			
			disableInput();//입력필드 비활성화
			
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
        	
	        //이곳에 해당 코딩을 입력 하세요
	        if (ds01T_CM_DEPT.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

        	window.close();
        	
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

			//DataSet의 변경 여부 확인
			if (!ds01T_CM_DEPT.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oCD_GBN, oDPT_CD, oDPT_NM, oSTR_YMD, oEND_YMD, oCOM_NO;
			var RowCnt = ds01T_CM_DEPT.CountRow;
			
			for(i=1; i<=RowCnt; i++){
				oCD_GBN = ds01T_CM_DEPT.NameValue(i,"CD_GBN");
				if(oCD_GBN.trim() == ""){
					alert("코드구분이 잘못되었습니다." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtCD_GBN").focus();
					return false;
				}

				oDPT_CD = ds01T_CM_DEPT.NameValue(i,"DPT_CD");
				
				if(oDPT_CD.trim() == ""){
					alert("부서코드가 잘못되었습니다." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtDPT_CD").focus();
					return false;
				}

				oDPT_NM = ds01T_CM_DEPT.NameValue(i,"DPT_NM");
				
				if(oDPT_NM.trim() == ""){
					alert("부서명이 잘못되었습니다." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtDPT_NM").focus();
					return false;
				}

				oSTR_YMD = ds01T_CM_DEPT.NameValue(i,"STR_YMD");
				
				if(!cfDateExpr(oSTR_YMD) || oSTR_YMD.trim().length == 0){//등록일이 반드시 들어가야한다.
					alert("등록일이  잘못되었습니다." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtSTR_YMD").focus();
					return false;
				}

				oEND_YMD = ds01T_CM_DEPT.NameValue(i,"END_YMD");
				
				if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){//폐기일은 안들어가도 된다.
					alert("폐기일이  잘못되었습니다." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtEND_YMD").focus();
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
   			cfStyleGrid_New(form1.grd01T_CM_DEPT,15,"false","right");

            // 근무지구분  검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_B7.CountRow; i++ ) {
				
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_B7.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_B7.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGBN_CD").add(oOption);
				
			}

			//form load시 무조건 부서코드 트리형태로 조회
            var f = document.form1;
			//if (!valid(form1)) return;//Validation 수행
			
			try {
				dsT_CM_DEPT.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SHR";
				dsT_CM_DEPT.Reset();

				ds02T_CM_DEPT.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SHR_02";
				ds02T_CM_DEPT.Reset();

				disableInput();//입력필드 비활성화
				
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

		/********************************************
         * 입력필드 사용 가능하게(Enable)  - A4(소속)*
         ********************************************/
  		function enableInput(){

			document.form1.txtCD_GBN.readOnly = false;
  			document.form1.txtCD_GBN.className = "";
			document.form1.txtDPT_CD.readOnly = false;
  			document.form1.txtDPT_CD.className = "";
			document.form1.txtDPT_NM.readOnly = false;
  			document.form1.txtDPT_NM.className = "";
			document.form1.txtSORT_NO.readOnly = false;
  			document.form1.txtSORT_NO.className = "";

			document.form1.txtSTR_YMD.readOnly = false;
  			document.form1.txtSTR_YMD.className = "";
  			document.getElementById("img_HelpOn2").disabled = false;
			document.form1.txtEND_YMD.readOnly = false;
  			document.form1.txtEND_YMD.className = "";
  			document.getElementById("img_HelpOn3").disabled = false;
  			document.getElementById("cmbGBN2_TAG").disabled = false;
  			document.getElementById("cmbGBN_CD").disabled = false;

			document.form1.txtREMARK.readOnly = false;
  			document.form1.txtREMARK.className = "";
			document.form1.txtHEAD_CD.readOnly = false;
  			document.form1.txtHEAD_CD.className = "";
  			document.getElementById("cmbHEAD_TAG").disabled = false;
			document.form1.txtREG_CD.readOnly = false;
  			document.form1.txtREG_CD.className = "";
  			document.getElementById("ImgRegCd").disabled = false;

			document.medCOM_NO.Enable = "true";
			document.form1.txtOFFICE.readOnly = false;
  			document.form1.txtOFFICE.className = "";
			document.form1.txtREMARK2.readOnly = false;
  			document.form1.txtREMARK2.className = "";
			document.form1.txtREMARK3.readOnly = false;
  			document.form1.txtREMARK3.className = "";

  		}

		/********************************************
         * 입력필드 사용 가능하게(Enable)  - B2(본부)*
         ********************************************/
  		function enableInput2(){

			document.form1.txtCD_GBN.readOnly = false;
  			document.form1.txtCD_GBN.className = "";
			document.form1.txtDPT_CD.readOnly = false;
  			document.form1.txtDPT_CD.className = "";
			document.form1.txtDPT_NM.readOnly = false;
  			document.form1.txtDPT_NM.className = "";
			document.form1.txtSORT_NO.readOnly = false;
  			document.form1.txtSORT_NO.className = "";

			document.form1.txtSTR_YMD.readOnly = false;
  			document.form1.txtSTR_YMD.className = "";
  			document.getElementById("img_HelpOn2").disabled = false;
			document.form1.txtEND_YMD.readOnly = false;
  			document.form1.txtEND_YMD.className = "";
  			document.getElementById("img_HelpOn3").disabled = false;
  			document.getElementById("cmbGBN2_TAG").disabled = true;
  			document.getElementById("cmbGBN_CD").disabled = true;

			document.form1.txtREMARK.readOnly = true;
  			document.form1.txtREMARK.className = "inputDisabled";
			document.form1.txtHEAD_CD.readOnly = true;
  			document.form1.txtHEAD_CD.className = "inputDisabled";
  			document.getElementById("cmbHEAD_TAG").disabled = true;
			document.form1.txtREG_CD.readOnly = true;
  			document.form1.txtREG_CD.className = "inputDisabled";
  			document.getElementById("ImgRegCd").disabled = true;

			document.medCOM_NO.Enable = "false";
			document.form1.txtOFFICE.readOnly = true;
  			document.form1.txtOFFICE.className = "inputDisabled";
			document.form1.txtREMARK2.readOnly = true;
  			document.form1.txtREMARK2.className = "inputDisabled";
			document.form1.txtREMARK3.readOnly = true;
  			document.form1.txtREMARK3.className = "inputDisabled";

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtCD_GBN.readOnly = true;
  			document.form1.txtCD_GBN.className = "inputDisabled";
			document.form1.txtDPT_CD.readOnly = true;
  			document.form1.txtDPT_CD.className = "inputDisabled";
			document.form1.txtDPT_NM.readOnly = true;
  			document.form1.txtDPT_NM.className = "inputDisabled";
			document.form1.txtSORT_NO.readOnly = true;
  			document.form1.txtSORT_NO.className = "inputDisabled";

			document.form1.txtSTR_YMD.readOnly = true;
  			document.form1.txtSTR_YMD.className = "inputDisabled";
  			document.getElementById("img_HelpOn2").disabled = true;
			document.form1.txtEND_YMD.readOnly = true;
  			document.form1.txtEND_YMD.className = "inputDisabled";
  			document.getElementById("img_HelpOn3").disabled = true;
  			document.getElementById("cmbGBN2_TAG").disabled = true;
  			document.getElementById("cmbGBN_CD").disabled = true;

			document.form1.txtREMARK.readOnly = true;
  			document.form1.txtREMARK.className = "inputDisabled";
			document.form1.txtHEAD_CD.readOnly = true;
  			document.form1.txtHEAD_CD.className = "inputDisabled";
  			document.getElementById("cmbHEAD_TAG").disabled = true;
			document.form1.txtREG_CD.readOnly = true;
  			document.form1.txtREG_CD.className = "inputDisabled";
  			document.getElementById("ImgRegCd").disabled = true;

			document.medCOM_NO.Enable = "false";
			document.form1.txtOFFICE.readOnly = true;
  			document.form1.txtOFFICE.className = "inputDisabled";
			document.form1.txtREMARK2.readOnly = true;
  			document.form1.txtREMARK2.className = "inputDisabled";
			document.form1.txtREMARK3.readOnly = true;
  			document.form1.txtREMARK3.className = "inputDisabled";

  		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 트리구성용 DataSet                                               |
    | 2. 이름 : dsT_CM_DEPT                                            |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 트리 이미지 DataSet                                              |
    | 2. 이름 : idsT_CM_DEPT                                           |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <!--
	<object id=idsT_CM_DEPT classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
			<param name=SyncLoad	value="true">
	</object>
	 -->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CM_DEPT                                        |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <Object ID="ds01T_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CM_DEPT                                        |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <Object ID="ds02T_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : tr01T_CM_DEPT                                    |
    | 3. Table List : T_CM_DEPT                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_DEPT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     		Value="dataid">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    	value="dsT_CM_COMMON_B7"/>
       <jsp:param name="CODE_GUBUN"    value="B7"/>
       <jsp:param name="SYNCLOAD"      	value="false"/>
       <jsp:param name="USEFILTER"     	value="false"/>
    </jsp:include>
    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {
        	
	        //부서정보가 하나도 없으면 회사정보를 넣는다.
	        dsT_CM_DEPT.AddRow();
			tr01T_CM_DEPT.KeyValue = "SVL(I:dsT_CM_DEPT=dsT_CM_DEPT)";
			tr01T_CM_DEPT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SAV";
			tr01T_CM_DEPT.post();
            dsT_CM_DEPT.Reset();//트리도 재구성한다.
            
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_DEPT.CountRow);
            
        }
        
    </Script>

    <Script For=ds01T_CM_DEPT Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {
            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CM_DEPT.CountRow);
        }
        
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CM_DEPT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_DEPT Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=tr01T_CM_DEPT event="OnSuccess()">
	    fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=tr01T_CM_DEPT event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-------------------------------+
    | treeview에서 item를 클릭했을때      |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CM_DEPT event=OnClick()>
    
		var overId1 = "DPT_CD";
		var overId2 = "COUNT_REM";
		var overNm = tvT_CM_DEPT.ItemText;
		var Row = dsT_CM_DEPT.NameValueRow("DPT_NM",overNm);
		var overValue1 = dsT_CM_DEPT.NameValue(Row,overId1);
		var overValue2 = dsT_CM_DEPT.NameValue(Row,overId2);
		
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1);
		
		try {
			ds01T_CM_DEPT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CM_DEPT.Reset();

			//disable 처리, 지점을 제외한 나머지 본부,팀은 코드구분, 부서코드, 부서명, 정렬순서, 등록일, 폐기일만 사용한다.
			var oUPCD_GBN = document.getElementById("txtUPCD_GBN").value;
			
			//alert("treeview에서 item를 클릭했을때  = "+oUPCD_GBN)

			if(oUPCD_GBN.trim() == "B2" || oUPCD_GBN.trim() == "A4"){//상위코드가 B2이면 지점이다.
				enableInput();
			}else{
				enableInput2();
			}

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<!-- 바인딩을 위한 임시데이터 저장 -->
<input type="hidden" id="txtDPT_LBL">
<input type="hidden" id="txtCOUNT_REM">
<input type="hidden" id="txtDOWNDPT_CD">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
     <!--       <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>   -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>				
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">상위코드구분</td>
					<td class="padding2423"><input id="txtUPCD_GBN" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="blueBold">상위부서코드</td>
					<td class="padding2423"><input id="txtUPDPT_CD" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="blueBold">상위부서명</td>
					<td class="padding2423"><input id="txtUPDPT_NM" style="width:100%" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="150"></col>
					<col width="100"></col>
					<col width="150"></col>
					<col width="100"></col>
					<col width="150"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">코드구분</td>
					<td class="padding2423"><input id="txtCD_GBN" style="width:100%" maxlength="2"></td>
					<td align="center" class="blueBold">부서코드</td>
					<td class="padding2423"><input id="txtDPT_CD" style="width:100%" maxlength="6"></td>
					<td align="center" class="blueBold">부서명</td>
					<td class="padding2423"><input id="txtDPT_NM" style="width:100%" maxlength="30"></td>
					<td align="center" class="blueBold">정렬순서</td>
					<td class="padding2423"><input id="txtSORT_NO" style="width:100%" maxlength="4"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">등록일</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:70" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<!--   
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','65','159');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle"></a>
					    -->
					</td>
					<td align="center" class="blueBold">폐기일</td>
					<td class="padding2423">
						<input id="txtEND_YMD" style="width:70" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<!--
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','265','159');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle"></a>
						-->
					</td>
					
					<td align="center" class="blueBold">근무지구분</td>
					<td class="padding2423">
						<select id="cmbGBN_CD" style="width:100%">
							<option value="" >선택</option>
						</select>
					</td>
					
					<td align="center" class="blueBold">근무지</td>
					<td class="padding2423">
                        <input id="txtREG_CD" style="width:21%" maxlength="3" onChange="fnc_GetCommNm('B3', 'txtREG_CD','txtREG_NM')">
                        <input id="txtREG_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRegCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRegCd" name="ImgRegCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREG_CD','txtREG_NM','지역','B3')"></a>
					</td>					
					
				</tr>
				
				<!--  
				<tr>
					<td align="center" class="blueBold">회계부서코드</td>
					<td class="padding2423"><input id="txtREMARK" style="width:100%" maxlength="20"></td>
					<td align="center" class="blueBold">부문코드</td>
                    <td class="padding2423">
                        <input id="txtPART_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('B1', 'txtPART_CD','txtPART_NM')"> <input id="txtPART_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPartCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPartCd" name="ImgPartCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtPART_CD','txtPART_NM','부문','B1')"></a>
                    </td>
					<td align="center" class="blueBold">사업부</td>
					<td class="padding2423">
					<comment id="__NSID__">
					<object id=cmbHEAD_TAG classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 height=25 width=120>
					<param name=ComboDataID		value=ds02T_CM_DEPT>
					<param name=SearchColumn		value=DPT_NM>
					<param name=Sort					value=True>
					<param name=BindColumn      	value="DPT_CD">
					<param name=ListExprFormat		value = "DPT_CD^0^50,DPT_NM^0^150">
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>

					<td align="center" class="blueBold">현장등급</td>
					<td class="padding2423">
						<select id="cmbGBN2_TAG" style="width:100%">
							<option value="" >선택</option>
							<option value="1" >A</option>
							<option value="2" >B</option>
							<option value="3" >C</option>
							<option value="4" >D</option>
						</select>
					</td>
				</tr>

				<tr>
					<td align="center" class="blueBold">지점사업자번호</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medCOM_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=Format						value="000-00-00000">
							<param name=IsComma					value=false>
							<param name=Language					value=0>
							<param name=Numeric					value=false>
							<param name=PromptChar				value=" ">
							<param name=ShowLiteral	                 value="false">
							<param name=Visible                      value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">관할구청</td>
					<td class="padding2423"><input id="txtOFFICE" style="width:100%" maxlength="20"></td>
                    <td align="center" class="blueBold">전표구분자</td>
                    <td class="padding2423"><input id="txtHEAD_CD" style="width:100%" maxlength="3"></td>
					<td align="center" class="blueBold">영문명</td>
					<td class="padding2423"><input id="txtREMARK3" style="width:100%" maxlength="60"></td>
				</tr>
                <tr>
                    <td align="center" class="blueBold">부서주소</td>
                    <td class="padding2423" colspan="7"><input id="txtREMARK2" style="width:100%" maxlength="150"></td>
                </tr>
                -->
                

			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- 내용 조회 트리 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_DEPT" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:390px;height:370px">
							<param name=DataID				value="dsT_CM_DEPT">
							<param name=TextColumn			value="DPT_NM">
							<param name=LevelColumn		value="DPT_LBL">
							<param name=ExpandLevel			value="0">
							<param name=BorderStyle  		value="2">
							<param name=UseImage      		value="false">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 트리 끝-->
		</td>
		<td>
			<!-- 내용 조회 그리드 테이블 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grd01T_CM_DEPT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:370px">
							<param name="DataID"							value="ds01T_CM_DEPT">
                            <param name="EdiTABLE"						value="false">
                            <param name="DragDropEnable"				value="true">
                            <param name="SortView"						value="Left">
                            <param name="VIEWSUMMARY"				value=0>
                            <param name="Format"							value="
								<C> id='CURROW'		width=50		name='NO'				align=center		value={CurRow}		</C>
								<C> id='CD_GBN'		width=80	    name='코드구분'		sort=true			align=center				</C>
								<C> id='DPT_CD'		width=100	    name='부서코드'		sort=true			align=center				</C>
								<C> id='DPT_NM'		width=150		name='부서명'			sort=true			align=left 					</C>
								<C> id='STR_YMD'	width=90		name='등록일'			sort=true			align=center 			</C>
								<C> id='END_YMD'	width=90		name='폐기일'			sort=true			align=center				</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 그리드 데이블 끝-->
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                                               |
    | 2. 이름 : bndT_CM_DEPT                                   |
    | 3. Table List : T_CM_DEPT                                 |
    +----------------------------------------------->
	<object id="bndT_CM_DEPT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="ds01T_CM_DEPT">
		<Param Name="BindInfo", Value="
			<C>Col='UPCD_GBN'			Ctrl='txtUPCD_GBN'				Param=value</C>
			<C>Col='UPDPT_CD'			Ctrl='txtUPDPT_CD'				Param=value</C>
			<C>Col='UPDPT_NM'			Ctrl='txtUPDPT_NM'				Param=value</C>

			<C>Col='CD_GBN'				Ctrl='txtCD_GBN'					Param=value</C>
			<C>Col='DPT_CD'				Ctrl='txtDPT_CD'					Param=value</C>
			<C>Col='DPT_NM'				Ctrl='txtDPT_NM'					Param=value</C>
			<C>Col='SORT_NO'			Ctrl='txtSORT_NO'				Param=value</C>

			<C>Col='STR_YMD'			Ctrl='txtSTR_YMD'				Param=value</C>
			<C>Col='END_YMD'			Ctrl='txtEND_YMD'				Param=value</C>
			<C>Col='GBN2_TAG'			Ctrl='cmbGBN2_TAG'				Param=value</C>
			<C>Col='GBN_CD'				Ctrl='cmbGBN_CD'				Param=value</C>

			<C>Col='PART_CD'			Ctrl='txtPART_CD'					Param=value</C>
			<C>Col='PART_NM'			Ctrl='txtPART_NM'					Param=value</C>

			<C>Col='REMARK'				Ctrl='txtREMARK'					Param=value</C>
			<C>Col='HEAD_CD'			Ctrl='txtHEAD_CD'					Param=value</C>
			<C>Col='HEAD_TAG'			Ctrl='cmbHEAD_TAG'				Param=BindColVal</C>
			<C>Col='REG_CD'				Ctrl='txtREG_CD'					Param=value</C>
			<C>Col='REG_NM'				Ctrl='txtREG_NM'					Param=value</C>


			<C>Col='COM_NO'				Ctrl='medCOM_NO'				Param=text	</C>
			<C>Col='OFFICE'				Ctrl='txtOFFICE'					Param=value</C>
			<C>Col='REMARK2'			Ctrl='txtREMARK2'					Param=value</C>
			<C>Col='REMARK3'			Ctrl='txtREMARK3'					Param=value</C>

			<C>Col='DPT_LBL'				Ctrl='txtDPT_LBL'					Param=value</C>
			<C>Col='COUNT_REM'		Ctrl='txtCOUNT_REM'				Param=value</C>
			<C>Col='DOWNDPT_CD'		Ctrl='txtDOWNDPT_CD'			Param=value</C>
	    ">
	</object>

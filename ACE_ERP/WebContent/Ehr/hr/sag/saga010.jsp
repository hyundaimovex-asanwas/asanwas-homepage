<!--
    ************************************************************************************
    * @source         : saga010.jsp 				                                   *
    * @description   : 급여테이블 PAGE.                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/13  |  한학현   | 최초작성                                               *
    * 2009/10/21  |  권혁수   | 연봉제로 변경                                          *
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
<title>급여테이블</title>
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
			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 직위구분
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번

			//기준일자가 없으면 조회 못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자가 잘못되었습니다.");
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
            dsT_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CP_PAYTABLE.Reset();

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
			if( !fnc_SaveItemCheck() )	return;

            if(savObj.type == "UPLOAD"
                    && !confirm("연봉정보를 갱신 합니다.\n계속하시겠습니까?")){
                return;
            }

			//트랜잭션 전송
			trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE, O:dsRESULT=dsRESULT)";
			trT_CP_PAYTABLE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SAV&TYPE="+savObj.type;
			trT_CP_PAYTABLE.Post();

        }

		/******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CP_PAYTABLE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_CP_PAYTABLE.ColumnString(dsT_CP_PAYTABLE.RowPosition,4) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CP_PAYTABLE.DeleteRow(dsT_CP_PAYTABLE.RowPosition);
			trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE)";
			trT_CP_PAYTABLE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=DEL";
			trT_CP_PAYTABLE.post();

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

            form1.grdT_CP_PAYTABLE.GridToExcel("급여테이블", '', 225);

        }

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			//var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분
			var JOB_NM_SHR = document.getElementById("txtJOB_NM_SHR").value; // 직위구분
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번
			var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value; // 성명

			if(APY_YMD_SHR.trim().length == 0){
				alert("적용일자를 입력하세요.");
				document.getElementById("txtAPY_YMD_SHR").focus();
				return false;
			}

			if(APY_YMD_SHR.trim().length != 10){
				alert("적용일자가 잘못되었습니다.");
				document.getElementById("txtAPY_YMD_SHR").focus();
				return false;
			}

			if(JOB_CD_SHR.trim().length == 0){
				alert("직위를 입력하세요.");
				document.getElementById("txtJOB_CD_SHR").focus();
				return false;
			}

			if(ENO_NO_SHR.trim().length == 0){
				alert("사번을 입력하세요.");
				document.getElementById("txtENO_NO_SHR").focus();
				return false;
			}

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CP_PAYTABLE.CountColumn == 0) {
                dsT_CP_PAYTABLE.setDataHeader("OCC_CD:STRING:KEYVALUETYPE,JOB_CD:STRING:KEYVALUETYPE,HOB_CD:STRING:KEYVALUETYPE,APY_YMD:STRING:KEYVALUETYPE,BAS_AMT:DECIMAL,DUTY_AMT:DECIMAL,OT_AMT:DECIMAL,WEL_AMT:DECIMAL,OSE_AMT:DECIMAL,RUN_AMT:DECIMAL,MH_AMT:DECIMAL");
            }

            dsT_CP_PAYTABLE.AddRow();

			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"APY_YMD")=APY_YMD_SHR;
			//dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"OCC_CD")=OCC_CD_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"JOB_CD")=JOB_CD_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"JOB_NM")=JOB_NM_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"ENO_NM")=ENO_NM_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"ENO_NO")=ENO_NO_SHR;

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

			fnc_OnLoadProcess();
			dsT_CP_PAYTABLE.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtJOB_CD_SHR").value = "";
			//document.getElementById("cmbOCC_CD_SHR").value = "A"; // 근로구분구분
			document.getElementById("txtJOB_NM_SHR").value = "";
			document.form1.txtAPY_YMD_SHR.focus();

            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";
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
			ds01T_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			//값이 없어서 하이픈만 나오는거 방지
			var APY_YMD_SHR = (document.getElementById("txtAPY_YMD_SHR").value).replace("-", "").replace("-", "");
			if(APY_YMD_SHR.trim() == ""){
				document.getElementById("txtAPY_YMD_SHR").value = "";
			}

			//근로구분
			/*
			if(document.getElementById("cmbOCC_CD_SHR").length == 0){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}
			*/
            savObj.type = "";
            //savObj.occ_cd = "";
            savObj.apy_ymd = "";
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

        /*************************
         * 그리드 변경 처리               *
         ************************/
		function fnc_ChangeGrid(obj) {

			if(obj == undefined || obj.value == "A"){
				form1.grdT_CP_PAYTABLE.Format = "<C> id='{CUROW}'		width=40		name='NO'						align=center		value={String(Currow)}		BgColor='#EEEEEE'		</C>" +
																		"<C> id='ENO_NO'        width=60        name='사번'          align=center    Edit=none  </C>" +
																		"<C> id='ENO_NM'        width=60        name='성명'          align=center    Edit=none  </C>" +
																		"<C> id='JOB_CD'        width=75        name='직위코드'      align=center    Edit=none  </C>" +
																		"<C> id='JOB_NM'        width=65        name='직위명'        align=center    Edit=none  </C>" +
																		"<C> id='HOB_CD'        width=65        name='연봉코드'      align=center    show=false  </C>" +
																		"<C> id='STR_YMD'       width=80        name='시작일자'      align=center    </C>" +
																		"<C> id='END_YMD'       width=80        name='종료일자'      align=center    show=false  </C>" +
																		"<C> id='BAS_AMT'       width=75        name='기본급'        align=right                     </C>" +
																		"<C> id='DUTY_AMT'      width=75        name='직책수당'      align=right                     </C>" +
																		"<C> id='LAW_AMT'       width=75        name='시간외'        align=right                     </C>" +
																		"<C> id='BNS_AMT'       width=75        name='상여금'        align=right                     </C>" +
																		"<C> id='TOTAL_AMT'     width=75        name='합계'          Edit=none  align=right     BgColor='#EEEEEE'       </C>" +
																		"<G> name='기타수당' BgColor='#F7DCBB' " +
																		"<C> id='ETC_AMT'       width=75        name='교통비'        align=right      show=false   </C>" +
																		"<C> id='ETC_AMT3'       width=75        name='식대'        align=right       show=false   </C>" +
																		"</G> "
																		;

            }

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYTABLE,15,"true","true");

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">급여테이블</td>
					<td align="right" class="navigator">HOME/보상관리/급여관리/<font color="#000000">급여테이블</font></td>
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
  <!--           <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
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
								<td align="center" class="searchState">기준일자</td>
								<td>
									<input id="txtAPY_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','535','112');"></a>
								</td>
							</tr>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;위</td>
								<td>
									<input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');">
									<input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="16" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2');"></a>
								</td>
								<td align="center" class="searchState">사원번호</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
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
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('saga010.xls', '<%=FILEURL %>/saga010.xls');"></a>
                    </td>
                    <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
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
						<object	id="grdT_CP_PAYTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_CP_PAYTABLE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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
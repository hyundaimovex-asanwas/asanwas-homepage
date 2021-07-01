	<!--*************************************************************************
	* @source      : welc020.jsp												*
	* @description : 건강검진 결과관리 PAGE										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/05            채갑병          	        최초작성									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
	<title>건강검진 결과관리(welc020)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//건겅검진 결과 정보 조회
			var stdt = document.getElementById("txtPRO_YMD_STDT_SHR").value;
			var endt = document.getElementById("txtPRO_YMD_ENDT_SHR").value;
			var dptCd = document.getElementById("txtDPT_CD_SHR").value.toUpperCase();
			// 소문자 검색시 대문자로 변환
			document.getElementById("txtDPT_CD_SHR").value = dptCd;

            dsT_CM_BODY.UseChangeInfo = true;
			dsT_CM_BODY.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD&S_MODE=SHR&PRO_YMD_STDT_SHR="+stdt+"&PRO_YMD_ENDT_SHR="+endt+"&DPT_CD_SHR="+dptCd;
			dsT_CM_BODY.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_CM_BODY.KeyValue = "tr01(I:dsT_CM_BODY=dsT_CM_BODY)";
			trT_CM_BODY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD&S_MODE=SAV";
			trT_CM_BODY.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CM_BODY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_BODY.GridToExcel("건강검진 결과관리", '', 225)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_CM_BODY.CountColumn == 0) {
				dsT_CM_BODY.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, CET_NO:STRING, PRO_YMD:STRING, EYE_LEF:DECIMAL(2.1), EYE_RHT:DECIMAL(2.1), HEIGHT:STRING, WEIGHT:STRING, AB_HGT:STRING, CBLD_CD:STRING, BLD_TYP:STRING, BLD_PRE:STRING, PH:STRING, XRY_RMK:STRING, EXM_HSP:STRING, DECISION:STRING, SPEC:STRING");
			}

			// 입력필드 사용가능하게
			enableInput();

			// 행 추가
			dsT_CM_BODY.AddRow();

			// 날짜 입력란으로 포커스 이동
			document.form1.cmbCBLD_CD.selectedIndex = 0;
			document.form1.cmbBLD_TYP.selectedIndex = 0;
			document.form1.txtEYE_LEF.value = "";
			document.form1.txtEYE_RHT.value = "";
			document.getElementById("txtPRO_YMD").focus();

            fnc_EnableElementAll(new Array("txtENO_NO", "txtENO_NM"));
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_CM_BODY.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "사번 = "+dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "성명  = "+dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "검진일자  = "+dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "PRO_YMD")+"\n";

	            if( confirm(tmpMSG) ){
					var ENO_NO = dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "ENO_NO");
					var PRO_YMD = dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "PRO_YMD");

					dsT_CM_BODY.DeleteRow(dsT_CM_BODY.RowPosition);
							// 파라미터 추가
					trT_CM_BODY.Parameters = "ENO_NO="+ENO_NO+",PRO_YMD="+PRO_YMD;

					trT_CM_BODY.KeyValue = "tr01(I:dsT_CM_BODY=dsT_CM_BODY)";
					trT_CM_BODY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD&S_MODE=DEL";
					trT_CM_BODY.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
	        document.getElementById("txtDPT_CD_SHR").value = "";
	        document.getElementById("txtDPT_NM_SHR").value = "";

	        document.getElementById("resultMessage").innerText = ' ';

        	disableInput();
        	dsT_CM_BODY.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CM_BODY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
            if ( !dsT_CM_BODY.isUpdated && dsT_CM_BODY.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
			for( var i = 1; i <= dsT_CM_COMMON.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCBLD_CD").add(oOption);
			}

            document.getElementById("txtPRO_YMD_STDT_SHR").value = getStrDate();
            document.getElementById("txtPRO_YMD_ENDT_SHR").value = getEndDate();

			cfStyleGrid(form1.grdT_CM_BODY,15,"true","false");      // Grid Style 적용
			disableInput();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"txtPRO_YMD"
                                    ,"txtEYE_LEF"
                                    ,"txtEYE_RHT"
                                    ,"txtHEIGHT"
                                    ,"txtWEIGHT"
                                    ,"txtAB_HGT"
                                    ,"cmbCBLD_CD"
                                    ,"cmbBLD_TYP"
                                    ,"txtBLD_PRE"
                                    ,"txtPH"
                                    ,"txtXRY_RMK"
                                    ,"txtEXM_HSP"
                                    ,"txtDECISION"
                                    ,"txtSPEC"
                                    ,"FindEmpl"
                                    ,"ImgPRO_YMD"
                                    );

        var exceptionList = new Array(
                                     "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"txtPRO_YMD"
                                    ,"FindEmpl"
                                    ,"ImgPRO_YMD"
                                    );

         /********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  			fnc_EnableElementAll(elementList);
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  			fnc_DisableElementAll(elementList);
  		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");

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
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO");
            fnc_ClearInputFieldAll(new Array("txtENO_NO", "txtENO_NM", "txtCET_NO"));
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
            }
        }



        /**
         * EXCEL 명부 파일을 업로드 시키고 DS에 추가 시켜서 가져오기
         */
        function fnc_FileUpload() {

            //file을 binding 시킨다.
            if(!bindingFile())
                return;

            //업로드 하기 직전 조회한 내역을 초기화 시킨다.
            dsT_CM_BODY.ClearData();

            //ds에서 파일 업로드
            trFILE_UPLOAD.KeyValue = "TR_FILE"
                                   + "(I:dsFILE_UPLOAD=dsFILE_UPLOAD"                   //업로드할 파일
                                   + ",O:dsT_CM_BODY=dsT_CM_BODY"         //명부 리스트
                                   + ",O:dsRESULT=dsRESULT"
                                   + ")";

            trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD"
                                 + "&S_MODE=ULD";
            trFILE_UPLOAD.post();
        }

        /**
         * DataSet 에 FILE 을 바인딩 시킨다.
         */
        function bindingFile() {
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            return true;
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_BODY)			 	   |
    | 3. 사용되는 Table List(T_CM_BODY) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_BODY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 기관구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON"/>
       <jsp:param name="CODE_GUBUN"    value="D4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton                          |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_BODY)                  |
    | 3. 사용되는 Table List(T_CM_BODY)                    |
    +------------------------------------------------------>
    <Object ID="trT_CM_BODY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <Param Name=KeyValue Value="sample_tr01(O:dsT_CM_BODY=dsT_CM_BODY,I:dsT_CM_BODY=dsT_CM_BODY)">
    </Object>

    <!-----------------------------------------------------+
    | 1. FILE UPLOAD용  Data Transacton                       |
    +------------------------------------------------------>
    <Object ID="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CM_BODY Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_BODY.CountRow);

			// 사번,이름,주민번호,검진일자 제외 수정가능
			fnc_EnableElementAll(elementList, exceptionList);
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowPopup("건강검진 관리 파일 등록 결과", dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_BODY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsFILE_UPLOAD Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_BODY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_CM_BODY event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		//fnc_SearchList();
    </script>

    <script for=trFILE_UPLOAD event="OnSuccess()">
        dsT_CM_BODY.UseChangeInfo = "false";
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_CM_BODY event="OnFail()">
        alert(trT_CM_BODY.ErrorMsg);
    </script>

    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_CM_BODY event=CanRowPosChange(row)>
		if ( dsT_CM_BODY.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_CM_BODY.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}else if ( dsT_CM_BODY.NameValue(row,"PRO_YMD") == "" ) {
			alert("[ " + grdT_CM_BODY.GetHdrDispName('-3','PRO_YMD') + " ]는 필수 입력사항입니다");
			return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">건강검진 결과관리</td>
					<td align="right" class="navigator">HOME/복리후생/건강검진/<font color="#000000">건강검진 결과관리</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"     onClick="fnc_ToExcel()"     ><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle"     ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <col width="300"></col>
                            <col width="60"></col>
                            <col width="300"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">검진일자</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtPRO_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPRO_YMD_STDT_SHR','','97','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~
                                <input type="text" id="txtPRO_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPRO_YMD_ENDT_SHR','','212','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td class="searchState" align="right">부서</td>
                            <td class="padding2423"><input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
                                </a>
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
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="25"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="FindEmpl" name="FindEmpl" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                    </td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>
					<td align="center" class="creamBold">주민번호</td>
					<td class="padding2423">
                        <input id="txtCET_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
                    </td>
					<td align="center" class="creamBold">검진일자</td>
					<td class="padding2423" colspan="3">
						<input type="text" id="txtPRO_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPRO_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="ImgPRO_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtPRO_YMD','','570','155');"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">좌시력</td>
					<td class="padding2423"><input id="txtEYE_LEF" size="10" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"></td>
					<td align="center" class="creamBold">우시력</td>
					<td class="padding2423"><input id="txtEYE_RHT" size="10" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"></td>
					<td align="center" class="creamBold">신장</td>
					<td class="padding2423">
                        <input id="txtHEIGHT" size="10" maxLength="5" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"> cm
                    </td>
					<td align="center" class="creamBold">체중</td>
					<td class="padding2423" colspan="3">
                        <input id="txtWEIGHT" size="10" maxLength="5" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"> kg
                    </td>
				</tr>
				<tr>
					<td align="center" class="creamBold">흉위</td>
					<td class="padding2423">
                        <input id="txtAB_HGT" size="10" maxLength="5" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"> cm
                    </td>
					<td align="center" class="creamBold">색맹</td>
					<td class="padding2423">
						<select id="cmbCBLD_CD" style="width:70%"></select>
					</td>
					<td align="center" class="creamBold">혈액형</td>
					<td class="padding2423">
						<select id="cmbBLD_TYP" style="width:70%">
							<option value="A">A형</option>
							<option value="B">B형</option>
							<option value="O">O형</option>
							<option value="AB">AB형</option>
						</select>
					</td>
					<td align="center" class="creamBold">혈압</td>
					<td class="padding2423"><input id="txtBLD_PRE" size="10" maxLength="8" style="ime-mode:disabled" onKeypress="cfCheckNumber4()"></td>
					<td align="center" class="creamBold">pH</td>
					<td class="padding2423"><input id="txtPH" size="10" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">X선소견</td>
					<td class="padding2423"><input id="txtXRY_RMK" size="15" maxLength="5"></td>
					<td align="center" class="creamBold">검사병원</td>
					<td class="padding2423"><input id="txtEXM_HSP" size="15" maxLength="5"></td>
					<td align="center" class="creamBold">판정</td>
					<td class="padding2423">
                        <input id="txtDECISION" size="10" maxLength="3">
                    </td>
					<td align="center" class="creamBold">특기사항</td>
					<td class="padding2423" colspan="3"><input id="txtSPEC" size="30" maxLength="20"></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	<!-- 조회 상태 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td width="80" style="padding-right:5px; padding-top:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('welc020.xls', '<%=FILEURL %>/welc020.xls');"></a>
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
					<object id="grdT_CM_BODY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_CM_BODY">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=40	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="ENO_NO"		width=60	name="사번"			align=center	Edit=none</C>
							<C> id="ENO_NM"		width=60	name="성명"			align=center	Edit=none</C>
							<C> id="CET_NO"		width=95	name="주민번호"		align=center	Edit=none</C>
							<C> id="PRO_YMD"	width=70	name="검진일자"		align=center	Edit=none</C>
							<C> id="EYE_LEF"	width=30	name="좌;시력"		align=center	Edit=none</C>
							<C> id="EYE_RHT"	width=30	name="우;시력"		align=center	Edit=none</C>
							<C> id="HEIGHT"		width=40	name="신장"			align=center	Edit=none</C>
							<C> id="WEIGHT"		width=40	name="체중"			align=center	Edit=none</C>
							<C> id="AB_HGT"		width=40	name="흉위"			align=center	Edit=none</C>
							<C> id="CBLD_CD"	width=55	name="색맹코드"		align=center	Edit=none EditStyle=Lookup  Data="dsT_CM_COMMON:CODE:CODE_NAME" </C>
							<C> id="BLD_TYP"	width=30	name="혈액;형"		align=center	Edit=none</C>
							<C> id="BLD_PRE"	width=55	name="혈압"			align=left		Edit=none</C>
							<C> id="PH"			width=40	name="pH"			align=center	Edit=none	Dec=1</C>
							<C> id="XRY_RMK"	width=50	name="X선;소견"		align=left		Edit=none</C>
							<C> id="EXM_HSP"	width=80	name="검사병원"		align=left		Edit=none</C>
							<C> id="DECISION"	width=50	name="판정"			align=left		Edit=none</C>
							<C> id="SPEC"		width=250	name="특기사항"		align=left		Edit=none</C>
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

	</form>
	<!-- form 끝 -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_CM_BODY 설정 테이블 -->
	<object id="bndT_CM_BODY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CM_BODY">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=CET_NO		Ctrl=txtCET_NO		Param=value</C>
			<C>Col=PRO_YMD		Ctrl=txtPRO_YMD		Param=value</C>
			<C>Col=EYE_LEF		Ctrl=txtEYE_LEF		Param=value</C>
			<C>Col=EYE_RHT		Ctrl=txtEYE_RHT		Param=value</C>
			<C>Col=HEIGHT		Ctrl=txtHEIGHT		Param=value</C>
			<C>Col=WEIGHT		Ctrl=txtWEIGHT		Param=value</C>
			<C>Col=AB_HGT		Ctrl=txtAB_HGT		Param=value</C>
			<C>Col=CBLD_CD		Ctrl=cmbCBLD_CD		Param=value</C>
			<C>Col=BLD_TYP		Ctrl=cmbBLD_TYP		Param=value</C>
			<C>Col=BLD_PRE		Ctrl=txtBLD_PRE		Param=value</C>
			<C>Col=PH			Ctrl=txtPH			Param=value</C>
			<C>Col=XRY_RMK		Ctrl=txtXRY_RMK		Param=value</C>
			<C>Col=EXM_HSP		Ctrl=txtEXM_HSP		Param=value</C>
			<C>Col=DECISION		Ctrl=txtDECISION	Param=value</C>
			<C>Col=SPEC			Ctrl=txtSPEC		Param=value</C>
		">
	</object>
<!--
***********************************************************************
* @source      : sagb060.jsp
* @description : 변동지불공제File전송 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/26      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>변동지불공제File전송</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var today = gcurdate;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

            var pis_ym  = document.getElementById("txtPIS_YM").value;   // 해당년월
            var sal_gbn = document.getElementById("cmbSAL_GBN").value;  // 급/상여구분
            var bon_num = document.getElementById("cmbBON_NUM").value;  // 일련번호
            var ad_tag  = document.getElementById("cmbAD_TAG").value;   // 구분

			trT_CP_CHANGE.KeyValue = "tr01(I:dsT_CP_CHANGE=dsT_CP_CHANGE, O:dsRESULT=dsRESULT)";
			trT_CP_CHANGE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.b.sagb060.cmd.SAGB060CMD&S_MODE=SAV&PIS_YM="+pis_ym+"&SAL_GBN="+sal_gbn+"&BON_NUM="+bon_num;
			trT_CP_CHANGE.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_CP_CHANGE.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_CP_CHANGE.setDataHeader("PIS_YM:STRING, SAL_GBN:STRING, ENO_NO:STRING:KEYVALUETYPE, SAL_CD:STRING, AD_TAG:STRING, AMOUNT:DECIMAL, REMARK:STRING, BON_NUM:STRING");
			}

            var cnt = dsT_CP_CHANGE.CountRow;

			dsT_CP_CHANGE.AddRow();

            fnc_EnableDisable('F');

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			document.getElementById('txtPIS_YM').value = today.substring(0,7);
            document.getElementById('cmbSAL_GBN').value = "0";
            document.getElementById('cmbBON_NUM').value = "1";
            document.getElementById('cmbAD_TAG').value = "A";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_CHANGE.ClearData();

            fnc_EnableDisable('T');

            document.getElementById('txtPIS_YM').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_CHANGE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (dsT_CP_CHANGE.CountRow < 1 ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM').value = today.substring(0,7);

			cfStyleGrid_New(form1.grdT_CP_CHANGE,15,"false","false");      // Grid Style 적용

            document.getElementById('txtPIS_YM').focus();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /******************************
         * 16. 입력 가능/불가능 처리  *
         *****************************/
		function fnc_EnableDisable(sts) {

			//입력
            if(sts == "F"){

                document.getElementById("txtPIS_YM").className = "input_ReadOnly";
                document.getElementById("txtPIS_YM").readOnly = true;
                document.getElementById("cmbSAL_GBN").disabled = true;
                document.getElementById("cmbBON_NUM").disabled = true;
                document.getElementById("cmbAD_TAG").disabled = true;

                document.form1.grdT_CP_CHANGE.Focus();

            }else{

                document.getElementById("txtPIS_YM").className = "";
                document.getElementById("txtPIS_YM").readOnly = false;
                document.getElementById("cmbSAL_GBN").disabled = false;
                document.getElementById("cmbBON_NUM").disabled = false;
                document.getElementById("cmbAD_TAG").disabled = false;

            }

		}

        /*****************************
         * 17. 엑셀파일 업로드 처리  *
         ****************************/
         function fnc_FileUpload() {

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

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_CP_CHANGE=dsT_CP_CHANGE, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.b.sagb060.cmd.SAGB060CMD&S_MODE=SHR";
                trFILE_UPLOAD.post();

            }

        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_CHANGE)   |
    | 3. 사용되는 Table List(T_CP_CHANGE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_CP_CHANGE)	    |
    | 3. 사용되는 Table List(T_CP_CHANGE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CP_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
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

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton              |
    | 2. 이름 : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 급여구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U4"/>
       <jsp:param name="CODE_GUBUN"    value="U4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("첨부한 엑셀파일이 옳바르지 않습니다.\n\n엑셀파일을 확인하시고 다시 첨부하세요.");

        } else {

            //fnc_EnableDisable('F');

            //첨부파일 내용을 저장하기 위해 Status 변경
			for(i=1;i<=iCount;i++){
                dsT_CP_CHANGE.UserStatus(i) = 1;
            }

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

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[사번]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_CHANGE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CP_CHANGE event="OnFail()">
        cfErrorMsg(this);
        fnc_Clear();
    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trFILE_UPLOAD event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
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


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','../../images/button/btn_CancelOver.gif',1)"> <img src="../../images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="70"></col>
					<col width="70"></col>
					<col width="70"></col>
					<col width="50"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
                <tr>
					<td align="center" class="blueBold">해당년월</td>
					<td class="padding2423">
                        <input id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YM','','../../images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM.disabled == true){return;} calendarBtn('datetype2','txtPIS_YM','','5','105');"><img src="../../images/button/btn_HelpOn.gif" name="img_YM" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td align="center" class="blueBold">급상여구분</td>
					<td class="padding2423">
                        <select id="cmbSAL_GBN" style="width:100%">
							<option value="0" >급 여</option>
	                        <option value="1" >상 여</option>
						</select>
                    </td>
                    <td align="center" class="blueBold">일련번호</td>
					<td class="padding2423">
						<select id="cmbBON_NUM" style="width:100%">
							<option value="1" >1</option>
	                        <option value="2" >2</option>
	                        <option value="3" >3</option>
						</select>
					</td>
                    <td align="center" class="blueBold">구분</td>
					<td class="padding2423">
                        <select id="cmbAD_TAG" style="WIDTH: 100%" >
						    <option value="A">지 불</option>
						    <option value="D">공 제</option>
						</select>
                    </td>
				</tr>
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
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','../../images/button/btn_ExcelformOver.gif',1)"><img src="../../images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('sagb060.xls', '<%=FILEURL %>/sagb060.xls');"></a>
                    </td>
                    <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_CP_CHANGE">
							<param name="Format"					value="
								<C> id={currow}		width=59    name='NO'				align=center    BgColor='#EEEEEE' </C>
                                <C> id='ENO_NO'	    width=120	name='사번'	    		align=center    Edit=Numeric EditLimit=8 </C>
								<C> id='AMOUNT'		width=120	name='금액'				align=right     	Edit=Numeric EditLimit=8     RightMargin='10'</C>
								<C> id='SAL_CD'	    width=120	name='급여코드'		align=left 		LeftMargin='10' </C>
								<C> id='AD_TAG'	    width=120	name='구분'				align=left 		LeftMargin='10'  </C>
								<C> id='REMARK'	    width=400	name='내역'				align=left 		LeftMargin='10' </C>
							">
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



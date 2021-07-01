<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ 시스템명 : 일용직 인사관리 - 기본정보
+ 기능정의 : 인사 기본정보를 화면 하단의 3개의 텝을 이용하여 입력,수정,삭제,조회한다.
+ 프로그램ID : aday010.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2013.04.03
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>일용직 인사관리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<!-- 첨부 파일을 위해 -->
    <jsp:include page="/common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
            
			//정보 조회
			var SITE_SHR = document.getElementById("txtSITE_CD_SHR").value;			// 소속
			var USE_STS = document.getElementById("cmbUSE_STS_S").value; 			// 채용구분
			var ENO_NM = document.getElementById("txtENO_NM_SHR").value;				// 성명

			
			dsT_CA_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SHR&SITE_SHR="+SITE_SHR+"&USE_STS="+USE_STS+"&ENO_NM="+ENO_NM;
			dsT_CA_PERSON.reset();
			

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
            
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_CA_PERSON.KeyValue = "tr01(I:dsT_CA_PERSON=dsT_CA_PERSON)";
			trT_CA_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SAV";

			//prompt(this, dsT_CA_PERSON.text);
			
			trT_CA_PERSON.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_Excel() {

            if (dsT_CA_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CA_PERSON.GridToExcel("근로자기본정보", '', 225);

			
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CA_PERSON.CountColumn == 0) {
            	dsT_CA_PERSON.setDataHeader("SITE_CD:STRING, SITE_NM:STRING, USE_STS:STRING, ENO_NM:STRING, CET_NO:STRING, BNK_CD:STRING, BNK_NM:STRING, ADDRESS:STRING, PH_NO:STRING, ACC_NO:STRING, WRK_AMT:STRING, REMARK:STRING, FILE_KEY:STRING");
            }

            if (dsT_CA_PERSON.IsUpdated ) {
                alert("변경사항이 존재합니다.\n해당 작업 종료한 후에 신규 작업을 하시기 바랍니다.");
                document.getElementById("txtENO_NM").focus();
                return;
            }

            dsT_CA_PERSON.AddRow();

            form1.txtENO_NM.focus();

		}

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {

        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
            
	        document.getElementById("resultMessage").innerText = ' ';

			// 콤보박스 기본 선택
			document.form1.cmbAID_STS_SHR.selectedIndex = 0;

			dsT_CA_PERSON.ClearData();

            document.getElementById("txtREQ_YMD_STDT_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";

		}

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_CA_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {

			document.form1.txtCET_NO.value = removeChar( document.form1.txtCET_NO.value, "-" ) ;

			var USE_STS = document.getElementById("cmbUSE_STS").value; 			// 채용구분
			
         	if ( USE_STS != "1" && USE_STS != "3" ) {
         		alert("채용구분을 선택하세요.");
                return false;
			}			
			
         	if ( document.form1.txtPH_NO.value == "") {
         		alert("연락처는 필수입력사항입니다.");
                return false;
			}
			
         	if ( document.form1.txtREMARK.value == "") {
         		alert("직종은 필수입력사항입니다.");
                return false;
			}
         	
         	if ( !dsT_CA_PERSON.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
			
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid_New(form1.grdT_CA_PERSON,0,"false","true");      // Grid Style 적용

            //fnc_SearchList();
   
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}



        /********************************************
         * 첨부파일 처리								*
         ********************************************/
		function fnc_FileUpload() {
			
            if(dsFILE.CountRow == 3) {
                alert("더 이상 첨부파일을 추가하실 수 없습니다.");
                return;
            }

            var key = dsT_CA_PERSON.NameValue(dsT_CA_PERSON.RowPosition, "FILE_KEY");

            if(key == "") {
                key = "aday010"+(new Date().getTime());
                dsT_CA_PERSON.NameValue(dsT_CA_PERSON.RowPosition, "FILE_KEY") = key;
            }

            if(!fnc_AddFileImg(key)) {
                return;
            }

		}

		/********************************************
         * 첨부파일 삭제								*
         ********************************************/
		function fnc_FileDelete() {
            if(dsFILE.CountRow < 1) {
                alert("삭제할 파일이 존재하지 않습니다.");
                return;
            }

            if( confirm("첨부된 파일을 삭제하시겠습니까?") ){
                dsFILE.DeleteRow(dsFILE.RowPosition);
                fnc_DelFile();
            }
		}

		
		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            
            if (obj.value == '') return;
            
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }


        /********************************************
         * 주민등록번호 필드에서 포커스 떠날때 유효한지 검사      *
         ********************************************/
        function checkSSN(){
            // 하이픈 제거
            var ssn = removeChar( document.form1.txtCET_NO.value, "-" ) ;

	            if( document.form1.txtCET_NO.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){

	                alert("잘못된 주민번호입니다.");
	                //document.form1.txtCET_NO.value = "";
	                document.form1.txtCET_NO.focus();
	            }


        }


        /********************************************
         * 주민등록번호 입력시 자동 하이픈(-) 넣기          *
         ********************************************/
        function cfCheckNumber5(){
            if((event.keyCode < 48)||(event.keyCode > 57)){
                if(event.keyCode != 45){
                    event.returnValue=false;
                }
            }
            if( document.form1.txtCET_NO.value.length == 6 ){
                document.form1.txtCET_NO.value += "-";
            }
        }
        		
		/********************************************
         * 주민번호 형식 유효성 체크                           			*
         ********************************************/		
        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("잘못된 주민번호입니다. 확인바랍니다.");
                    return false;
                }
            }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_CA_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDAPP)			       |
    | 3. 사용되는 Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_CA_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CA_PERSON=dsT_CA_PERSON,I:dsT_CA_PERSON=dsT_CA_PERSON)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CA_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CA_PERSON.CountRow);

			var FILE_KEY = dsT_CA_PERSON.NameValue(1, "FILE_KEY");

			dsFILE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SHR_FILE&FILE_KEY="+FILE_KEY;
			dsFILE.reset();

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CA_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CA_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_CA_PERSON event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_CA_PERSON event="OnFail()">
        alert(trT_CA_PERSON.ErrorMsg);
    </script>



    <!--------------------------+
    | grid에서 row를 클릭했을때      |
    +------ -------------------->
	<script for=grdT_CA_PERSON event=OnClick(Row,Colid)>

			var FILE_KEY = dsT_CA_PERSON.NameValue(dsT_CA_PERSON.RowPosition, "FILE_KEY");

			dsFILE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SHR_FILE&FILE_KEY="+FILE_KEY;
			dsFILE.reset();


    </Script>

	<!-- 파일 그리드 클릭시 다운로드 되게 -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
        if(row > 0) {
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");

            // 첨부 파일이 존재하는 경우만 수행하게~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
            }
        }
    </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>


	<!-- form 시작 -->
	<form name="form1" id="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">근로자 기본정보</td>
					<td align="right" class="navigator">HOME/보상관리/일용직관리/<font color="#000000">근로자 기본정보</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"><img src="../../images/button/btn_ExcelOn.gif" name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Excel()"></a>

	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="200"></col>
                            <col width="100"></col>
                            <col width="120"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">소 속 &nbsp;</td>
                            <td class="padding2423">
                                    <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')"> 
									<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','소속','AY');fnc_SearchList();"></a>
                            </td>
                            <td class="searchState" align="right">채&nbsp;&nbsp;용&nbsp;</td>
                            <td class="padding2423" align="left">
                                <select id="cmbUSE_STS_S" style="width:120" onchange="fnc_SearchList();">
                                    <option value="">전체</option>
                                    <option value="1">채용중</option>
                                    <option value="3">미채용</option>
                                </select>
                            </td>
                            <td align="right" class="searchState">성&nbsp;&nbsp;명</td>
                            <td class="padding2423">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_SearchList();">
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

	<tr><td>&nbsp;</td></tr>

	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="65"></col>
			<col width="135"></col>
			<col width="65"></col>
			<col width="135"></col>
			<col width="65"></col>
			<col width="*"></col>
		</colgroup>
		<tr height = "40px">
			<td align="center" class="creamBold">성명</td>
			<td class="padding2423"><input id="txtENO_NM" size="16" maxLength="25"></td>
			<td align="center" class="creamBold">주민번호</td>
			<td class="padding2423">
			<input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onChange="javascript : if (checkSSN(this) == true) {}"></td> 
			<td align="center" class="creamBold">소속</td>
			<td class="padding2423">
			
                        <input id="txtSITE_CD" style="width:10%" 	maxlength="4" class="input_ReadOnly" readonly> 
                        <input id="txtSITE_NM" style="width:70%" 	class="input_ReadOnly" readonly>
                        			
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSITE_NM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSITE_NM" name="ImgSITE_NM"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD','txtSITE_NM','소속','AY')"></a>			
			
			</td>
		</tr>
		<tr height = "40px">
			<td align="center" class="creamBold">채용</td>
			<td class="padding2423">
                        <select id="cmbUSE_STS" style="width:100%" >
                            <option value="1">채용중</option>
                            <option value="3" >미채용</option>
                        </select>	
			</td>
			<td align="center" class="creamBold">노무단가</td>
			<td class="padding2423"><input id="txtWRK_AMT" size="16" maxLength="16"></td>
			<td align="center" class="creamBold">주소</td>
			<td class="padding2423"><input id="txtADDRESS" size="50" maxLength="50"></td>
		</tr>

		<tr height = "40px">
			<td align="center" class="creamBold">연락처</td>
			<td class="padding2423">
				<input id="txtPH_NO" size="16" maxLength="16">
			</td>
			<td align="center" class="creamBold">직종</td>
			<td class="padding2423">
				<input id="txtREMARK" size="16" maxLength="16">
			</td>
			<td align="center" class="creamBold" rowspan="2">제출서류<br>첨부</td>
			<td class="padding2423" colspan="5"  rowspan="2" align="right">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)"><img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:65px;">
                    <param name="DataID" 					value="dsFILE">
                    <param name="Editable" 				value="false">
                    <param name="DragDropEnable" 		value="true">
                    <param name="SortView" 				value="Left">
                    <param name=ViewHeader  			value="false">
                    <param name="Format" 					value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="250"     name="파일명"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>			
        </tr>
		<tr height = "40px">
			<td align="center" class="creamBold">계좌번호</td>
			<td class="padding2423">
				<input id="txtACC_NO" size="16" maxLength="16">
			</td>
			<td align="center" class="creamBold">은행</td>
			<td class="padding2423">
				<input id="txtBNK_CD" size="3" maxLength="3" class="input_ReadOnly" readonly>
				<input id="txtBNK_NM" size="10" maxLength="10" class="input_ReadOnly" readonly>
			<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgBNK_NM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgBNK_NM" name="imgBNK_NM" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtBNK_CD','txtBNK_NM','은행', 'BK')"></a>
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CA_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" 				value="dsT_CA_PERSON">
                        <param name="ColSelect"  		value="true">
						<param name="Editable" 			value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 			value="Left">
						<param name="Format" 				value='
							<C> id="{CUROW}"	width="50"		name="NO"					align="center"	value={String(Currow)}</C>
                            <C> id="SITE_NM"    width="150"    name="소속"              	align="left"    	Edit=none   LeftMargin="10" </C>
							<C> id="ENO_NM"		width="70"		name="성명"				align="center"	Edit=none   </C>
							<C> id="CET_NO"		width="100"		name="주민번호"			align="center"	Edit=none   mask="XXXXXX-XXXXXXX"</C>
							<C> id="WRK_AMT"	width="80"		name="노무단가"			align="right"		Edit=none	RightMargin="10"</C>
							<C> id="ADDRESS"	width="200"		name="주소"		        align="left"		Edit=none	</C>
							<C> id="PH_NO"		width="100"		name="연락처"		        align="center"	Edit=none	</C>	
							<C> id="BNK_NM"		width="90"		name="은행"		        align="center"	Edit=none	</C>		
							<C> id="ACC_NO"		width="120"		name="계좌번호"		    align="center"	Edit=none	</C>																						
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
	<!-- dsT_CA_PERSON 설정 테이블 -->
	<object id="bndT_CA_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CA_PERSON">
		<Param Name="BindInfo", Value="
			<C>Col=CET_NO		Ctrl=txtCET_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=USE_STS		Ctrl=cmbUSE_STS	Param=value</C>			
			<C>Col=WRK_AMT	Ctrl=txtWRK_AMT		Param=value</C>
			<C>Col=SITE_CD		Ctrl=txtSITE_CD		Param=value</C>			
			<C>Col=SITE_NM		Ctrl=txtSITE_NM		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
			<C>Col=PH_NO		Ctrl=txtPH_NO			Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>			
			<C>Col=ACC_NO		Ctrl=txtACC_NO		Param=value</C>
			<C>Col=BNK_CD		Ctrl=txtBNK_CD		Param=value</C>				
			<C>Col=BNK_NM		Ctrl=txtBNK_NM		Param=value</C>			
		">
	</object>

	<!--*************************************************************************
	* @source      : aida020.jsp														*
	* @description : 경공조금지급처리 PAGE	 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/04/28            이동훈            	ERP 이사									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.DateUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>경공조금지급처리</title>
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
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = gcurdate.substring(0,4);

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			//경공조금 지급처리 조회
			var REQ_YMD_STDT_SHR = document.getElementById("txtREQ_YMD_STDT_SHR").value;
			var REQ_YMD_ENDT_SHR = document.getElementById("txtREQ_YMD_ENDT_SHR").value;
			var AID_STS_SHR = document.getElementById("cmbAID_STS_SHR").value;

			dsT_AD_AIDAPP.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida020.cmd.AIDA020CMD&S_MODE=SHR&REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"&AID_STS_SHR="+AID_STS_SHR;
			dsT_AD_AIDAPP.reset();
			
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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
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
            //이곳에 해당 코딩을 입력 하세요
            
            if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AD_AIDAPP.GridToExcel("경공조금지급처리", '', 225);            
            
            
            
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

        	document.form1.cmbAID_STS_SHR.selectedIndex = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_AD_AIDAPP.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

            if (dsT_AD_AIDAPP.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            
        	window.close();

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
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_AD_AIDAPP,0,"true","true");      // Grid Style 적용

            document.getElementById("txtREQ_YMD_STDT_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM-dd") %>";
            document.getElementById("txtREQ_YMD_ENDT_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, 0, 0),"yyyy-MM-dd") %>";

            //결재 상태인 녀석들 조회해 오기
            document.getElementById("cmbAID_STS_SHR").value = "O";
            
            fnc_SearchList();
            
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
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)				   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDAPP)			       |
    | 3. 사용되는 Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP,I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 신청서 진행상태 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R5"/>
       <jsp:param name="CODE_GUBUN"    value="R5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직위 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 소속 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 신청내용 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R1"/>
       <jsp:param name="CODE_GUBUN"    value="R1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자3434료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDAPP.CountRow);
        }
		
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_AD_AIDAPP event="OnDblClick(row,colid)">
	
		if(row < 1) {
			
			return;
			
		} else {
            //var url = "../../hr/aid/aida011.jsp?REQ_NO="+dsT_DI_APPROVAL.NameString(row, "REQ_NO")+"&TYPE=TYPE4";
            var url = "../../hr/aid/aida011.jsp?REQ_NO="+dsT_AD_AIDAPP.NameString(row, "REQ_NO")+"&TYPE=TYPE3";
            
			cfWinOpen(url,"경공조",1050,650);
			
			fnc_SearchList();
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
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="230"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">신청기간</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtREQ_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtREQ_YMD_STDT_SHR','','107','107');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtREQ_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtREQ_YMD_ENDT_SHR','','222','107');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">조회조건</td>
							<td class="padding2423" align="left">
								<select id="cmbAID_STS_SHR" style="WIDTH: 60px" onChange="fnc_SearchList()">
									<option value="">모두</option>
									<option value="O">결재</option>
									<option value="C">반송</option>
									<option value="E">지급</option>
								</select>
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AD_AIDAPP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" value="dsT_AD_AIDAPP">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=40	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="REQ_NO"		width=90	name="신청번호"	align=center	Edit=none</C>
							<C> id="DPT_CD"		width=100	name="부서"		align=left		Edit=none	EditStyle=Lookup  LeftMargin=10</C>
							<C> id="JOB_CD"		width=80	name="직위"		align=left		Edit=none	EditStyle=Lookup  LeftMargin=10</C>
							<C> id="ENO_NM"		width=80	name="성명"		align=center	Edit=none</C>
							<C> id="HLP1_AMT"	width=100	name="공조금"		align=center	Edit=none</C>
							<C> id="HLP2_AMT"	width=100	name="경조금"		align=center	Edit=none</C>														
							<C> id="AID_CD"		width=130	name="신청내용"	align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R1:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="REQ_YMD"	width=90	name="신청일자"	align=center	Edit=none</C>
							<C> id="SPL_YMD"	width=90	name="지급일자"	align=center	Edit=none</C>
							<C> id="AID_STS"	width=80	name="상태"		align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R5:CODE:CODE_NAME"</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


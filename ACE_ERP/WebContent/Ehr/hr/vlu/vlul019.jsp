<!--
*****************************************************
* @source       : vlul019.jsp
* @description  : 업적평가작성현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/07/14     이동훈        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>
<head>
<title>업적평가작성현황</title>
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



	
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {


			trT_EV_HWORKMST.KeyValue = "tr01(O:dsT_EV_HWORKMST=dsT_EV_HWORKMST)";
			
			trT_EV_HWORKMST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_SUB"						                
																						                + "&SUBMIT_SHR="+document.getElementById("cmbSUBMIT_SHR").value;       
			
			trT_EV_HWORKMST.post();
			
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
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {


            form1.grdT_EV_HWORKMST.GridToExcel("업적신고서작성", '', 225);
            
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
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

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			
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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid_New(form1.grdT_EV_HWORKMST,15,"true","false");      // Grid Style 적용

			fnc_SearchList();
			
        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNmSHR() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
    </script>
</head>



    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_EV_HWORKMST event="OnDblClick(row,colid)">

		curRowPosition = dsT_EV_HWORKMST.RowPosition;

		if(row < 1) {
			
			return;
			
		} else {

			if(dsT_EV_HWORKMST.CountRow < 1) {
				
				alert("자료가 없습니다.");
				
				return;
				
			}

			var url = "../../../Ehr/hr/vlu/vlul010.jsp?ENO_NO=" + dsT_EV_HWORKMST.NameValue(row,"ENO_NO");
			
			window.showModalDialog(url, "Modal", "dialogWidth:1100px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            
			fnc_SearchList();

		}
	</script>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_EV_HWORKMST Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>


	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_EV_HWORKMST)			 	   |
    | 3. 사용되는 Table List(dsT_EV_HWORKMST) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_HWORKMST)		       |
    | 3. 사용되는 Table List(T_EV_HWORKMST)			       |
    +------------------------------------------------------>
	<Object ID="trT_EV_HWORKMST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_EV_HWORKMST=dsT_EV_HWORKMST)">
	</Object>


    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>



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
	<form name="form1">
    <input type="hidden" id="hidEMPL_DPT_CD">


	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"><img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" 보ellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0"  cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="100"></col>
							<col width="220"></col>
							<col width="100"></col>
							<col width="170"></col>
							<col width="100"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="center" class="searchState">작성여부</td>
							<td>
								<select id="cmbSUBMIT_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="" >전체</option>
										<option value="Y">작성</option>							
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
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height="20">
						<td width="360" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  class="searchState"><span id="resultMessage">&nbsp;</span></td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->


	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_EV_HWORKMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" 				value="dsT_EV_HWORKMST">
						<param name="Editable" 				value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 			value="Left">
						<param name="Format" 				value='
                            <C> id="{CUROW}"     width=60         align=center          	name="NO"         	 value={String(Currow)}</C>
                            <C> id=DPT_NM        	width=120        align=center          	name="소속"           Edit="None" suppress=1</C>
                            <C> id=TEAM_NM       	width=220        align=left          	name="소속2"             Edit="None" suppress=2</C>                            
                            <C> id=ENO_NO        	width=100        align=center          	name="사번"          Edit="None"</C>
                            <C> id=ENO_NM        	width=120        align=center          	name="이름"          Edit="None"</C>
                            <C> id=JOB_NM        	width=120        align=center          	name="직위"          Edit="None"</C>                            
                            <C> id=END_TAG       	width=130        align=center          	name="작성"          Value={decode(END_TAG, "Y","작성","N","미작성")}</C>
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

	<input type="hidden" id="txtDPT_CD">
	<input type="hidden" id="txtJOB_CD">
	</form>
	<!-- form 끝 -->
</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


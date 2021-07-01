	<!--*************************************************************************
	* @source      : aida010.jsp												*
	* @description : 경공조금신청서관리 PAGE / 공조금신청서상세 PAGE(POP_UP)		    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/04/28            이동훈            	ERP 이사									*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.DateUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>경공조금신청서</title>
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

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			//경공조금신청서  정보 조회
			var REQ_YMD_STDT_SHR = document.getElementById("txtREQ_YMD_STDT_SHR").value;
			var REQ_YMD_ENDT_SHR = document.getElementById("txtREQ_YMD_ENDT_SHR").value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;

    		//관리자가 아니면 사번 검색은 하지 못한다.
			if(gusrid != "6060002" && gusrid != "2030007" && gusrid != "6180001" && gusrid != "6180022" && gusrid != "3200018" && gusrid != "4180009"){ 
            

	            if(ENO_NO_SHR == "") {
	                alert("사번을 선택해 주세요.");
	                document.getElementById("txtENO_NO_SHR").focus();
	                return;
	            }

			}
	            
			var AID_STS_SHR = document.getElementById("cmbAID_STS_SHR").value;

			dsT_AD_AIDAPP.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR&REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"+&AID_STS_SHR="+AID_STS_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_AD_AIDAPP.reset();
            document.form1.print_flag.value = "Y";
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
			trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)";
			trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
			trT_AD_AIDAPP.post();
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
			//경공조금신청서  정보 조회
            if ( document.form1.print_flag.value == "Y" ) {
                var f = document.form1;

                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var s_year  = String(year);
                var s_month = String(month);
                var s_day = String(day);
                var TODAY_VAL = s_year + "년 " + s_month + "월 " + s_day + "일";

                var REQ_YMD_STDT_SHR = document.getElementById("txtREQ_YMD_STDT_SHR").value;
                var REQ_YMD_ENDT_SHR = document.getElementById("txtREQ_YMD_ENDT_SHR").value;

                var WORK_NO1 = document.getElementById("txtWORK_NO1").value;    //관리번호
                var HLP1_AMT = document.form1.medHLP1_AMT.Text;                     //공조금
                var HLP2_AMT = document.form1.medHLP2_AMT.Text;                     //경조금

                var REQ_NO  = document.getElementById("txtREQ_NO").value;           //신청번호
                var AID_YMD = document.getElementById("txtAID_YMD").value;          //발생일자
                var HIR_YMD = document.getElementById("txtHIR_YMD").value;          //입사일
                var DPT_NM  = document.getElementById("txtDPT_NM").value;           //부서
                var JOB_NM  = document.getElementById("txtJOB_NM").value;           //직위
                var ENO_CD  = document.getElementById("txtENO_NO").value;           //신청자
                var ENO_NM  = document.getElementById("txtENO_NM").value;           //신청자
                var AID_CD  = document.form1.cmbAID_CD.options[document.form1.cmbAID_CD.selectedIndex].text;  //신청사유(select)
                var AID_NM  = document.getElementById("txtAID_NM").value;           //대상자
                var LSE_YY  = document.getElementById("txtLSE_YY").value;           //근속년수
                var LSE_MM  = document.getElementById("txtLSE_MM").value;           //근속월수
                var ABA_CD  = document.form1.cmbABA_CD.options[document.form1.cmbABA_CD.selectedIndex].text;  //은행명(select)
                var ACC_NO  = document.getElementById("txtACC_NO").value;           //계좌번호
                var REC_NM  = document.getElementById("txtREC_NM").value;           //예금주

                var param = "REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"&TODAY_VAL="+TODAY_VAL;
                param += "&REQ_NO="+REQ_NO+"&AID_YMD="+AID_YMD+"&HIR_YMD="+HIR_YMD+"&DPT_NM="+DPT_NM+"&JOB_NM="+JOB_NM+"&ENO_CD="+ENO_CD+"&ENO_NM="+ENO_NM;
                param += "&AID_CD="+AID_CD+"&AID_NM="+AID_NM+"&LSE_YY="+LSE_YY+"&LSE_MM="+LSE_MM+"&ABA_CD="+ABA_CD+"&ACC_NO="+ACC_NO+"&REC_NM="+REC_NM;
                param += "&REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"&WORK_NO1="+WORK_NO1+"&HLP1_AMT="+HLP1_AMT+"&HLP2_AMT="+HLP2_AMT;

                var url = "aida010_PV.jsp?" + param;
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
                return;
            } else {
                alert("조회후 인쇄 가능합니다.");
            }
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

            var url = "../../../Ehr/hr/aid/aida011.jsp?REQ_NO=&TYPE=TYPE1";
            //window.showModalDialog(url, dsT_AD_AIDAPP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			cfWinOpen(url,"경공조",1100,650);
			
            fnc_SearchList();
            
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
			
	        if (dsT_AD_AIDAPP.CountRow < 1) {
	        	
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
                
            }else{
            	
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
           		
            	tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "신청사유  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_CD")+"\n";
            	tmpMSG += "대상자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_NM")+"\n";

	            if( confirm(tmpMSG) ){
	            	
					var REQ_NO = dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO");

					dsT_AD_AIDAPP.DeleteRow(dsT_AD_AIDAPP.RowPosition);
					// 파라미터 추가
					trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

					trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)";
					trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=DEL";
					trT_AD_AIDAPP.post();
					
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
			
	        document.getElementById("resultMessage").innerText = ' ';

			// 콤보박스 기본 선택
			document.form1.cmbAID_STS_SHR.selectedIndex = 0;

        	dsT_AD_AIDAPP.ClearData();

            document.getElementById("txtREQ_YMD_STDT_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";

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
			
         	if ( !dsT_AD_AIDAPP.isUpdated ) {
         		
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
			}
         	
			return true;
			
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtREQ_YMD_STDT_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM-dd") %>";
            document.getElementById("txtREQ_YMD_ENDT_SHR").value =  "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, 0, 0),"yyyy-MM-dd") %>";

            cfStyleGrid_New(form1.grdT_AD_AIDAPP,0,"false","false");      // Grid Style 적용


            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;


    		//관리자가 아니면 사번 검색은 하지 못한다.
			if(gusrid != "6060002" && gusrid != "4180009" && gusrid != "6180022" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "3200018" && gusrid != "4180009"){ 

	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNoShr");

    		}


            //시작할때 상신자료 기본으로 조회
            document.getElementById("cmbAID_STS_SHR").value = "S";
            
            fnc_SearchList();
            
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			
			fnc_HotKey_Process(btnList, event.keyCode);
			
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
         * 신청일자에서 포커스 떠날때 신청일자와 비교       		*
         ********************************************/
		function cfCheckDateTermAIDA010(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("발생일자가 신청일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDAPP)			       |
    | 3. 사용되는 Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP,I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 상태  -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R5"/>
       <jsp:param name="CODE_GUBUN"    value="R5"/>
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
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
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
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | 신청 상세 내역을 조회할때                                   |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_AD_AIDAPP event=OnDblClick(row,colid)>

        var url = "../../../Ehr/hr/aid/aida011.jsp?REQ_NO="+dsT_AD_AIDAPP.NameString(row, "REQ_NO")+"&TYPE=TYPE2";
        
		//window.showModalDialog(url, dsT_AD_AIDAPP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		
		cfWinOpen(url,"경공조",1100,650);
		
        //fnc_SearchList();
		
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
	<form name="form1">

	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_NewApplicationOver.gif',1)"><img src="../../images/button/btn_NewApplicationOn.gif" name="imgAddNew" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="240"></col>
							<col width="60"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">신청기간</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtREQ_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtREQ_YMD_STDT_SHR','','97','359');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtREQ_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtREQ_YMD_ENDT_SHR','','212','359');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td align="right" class="searchState">조회조건</td>
							<td class="padding2423" align="left">
								<select id="cmbAID_STS_SHR" style="WIDTH: 60px" onchange="fnc_SearchList()">
									<option value="">모두</option>
									<option value="A">저장</option>
									<option value="S">상신</option>
									<option value="O">결재</option>
									<option value="R">부결</option>
									<option value="C">반송</option>
									<option value="D">전표</option>
									<option value="E">지급</option>
								</select>
							</td>
                            <td align="right" class="searchState">사 번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
							<C> id="{CUROW}"		width="40"		name="NO"			align="center"	value={String(Currow)}</C>
							<C> id="REQ_NO"			width="100"		name="신청번호"		align="center"	Edit=none</C>
							<C> id="AID_CD_NM"		width="200"		name="신청사유"		align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="AID_YMD"		width="120"		name="발생일자"		align="center"	Edit=none</C>
							<C> id="ENO_NM"			width="120"		name="신청인"			align="center"	Edit=none</C>
							<C> id="REQ_YMD"		width="120"		name="신청일자"		align="center"	Edit=none</C>
							<C> id="SPL_YMD"		width="120"		name="지급일자"		align="center"	Edit=none</C>
							<C> id="AID_STS_NM"		width="120"		name="상태"			align="left"	Edit=none	LeftMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <input type="hidden" name="print_flag" value="N">
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

</body>
</html>


<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AD_AIDAPP 설정 테이블 -->
	<object id="bndT_AD_AIDAPP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDAPP">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO			Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO			Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM		Param=value</C>
			<C>Col=AID_YMD			Ctrl=txtAID_YMD		Param=value</C>
			<C>Col=CET_NO			Ctrl=txtCET_NO		Param=value</C>
			<C>Col=HIR_YMD			Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=RET_YMD			Ctrl=txtRET_YMD		Param=value</C>
			<C>Col=OCC_CD			Ctrl=txtOCC_CD		Param=value</C>
			<C>Col=DPT_CD			Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD			Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=LSE_YY			Ctrl=txtLSE_YY		Param=value</C>
			<C>Col=LSE_MM			Ctrl=txtLSE_MM		Param=value</C>
			<C>Col=ABA_CD			Ctrl=cmbABA_CD		Param=value</C>
			<C>Col=ACC_NO			Ctrl=txtACC_NO		Param=value</C>
			<C>Col=REC_NM			Ctrl=txtREC_NM		Param=value</C>
			<C>Col=AID_CD			Ctrl=cmbAID_CD		Param=value</C>
			<C>Col=AID_NM			Ctrl=txtAID_NM		Param=value</C>
			<C>Col=AID_RPT			Ctrl=hidAID_RPT		Param=value</C>
			<C>Col=REQ_YMD			Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=HLP1_AMT			Ctrl=medHLP1_AMT	Param=text</C>
			<C>Col=HLP2_AMT			Ctrl=medHLP2_AMT	Param=text</C>
			<C>Col=SUM_AMT			Ctrl=medSUM_AMT		Param=text</C>
			<C>Col=WORK_NO1			Ctrl=txtWORK_NO1	Param=value</C>
			<C>Col=SPL_YMD			Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=AID_STS			Ctrl=cmbAID_STS		Param=value</C>
			<C>Col=RET_RSN			Ctrl=txtRET_RSN		Param=value</C>
			<C>Col=AID_CET			Ctrl=txtAID_CET		Param=value</C>
			<C>Col=DEC1_NM			Ctrl=txtDEC1_NM		Param=value</C>
			<C>Col=DEC1_YMD			Ctrl=txtDEC1_YMD	Param=value</C>
			<C>Col=DEC2_NM			Ctrl=txtDEC2_NM		Param=value</C>
			<C>Col=DEC2_YMD			Ctrl=txtDEC2_YMD	Param=value</C>
		">
	</object>

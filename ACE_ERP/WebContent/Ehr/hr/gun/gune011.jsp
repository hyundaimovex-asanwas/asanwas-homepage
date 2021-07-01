<!--
***********************************************************************
* @source      : gune011.jsp
* @description : 연장근무결재현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2019/11/18      MOON           최초작성
***********************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>연장근무결재</title>
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
        
        var dsTemp = window.dialogArguments;
        
        var curRowPosition = 0;

        
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {


            var f = document.form1;

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

            var gbn = document.getElementById("cmbGBN_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;

            
            if(!fnc_SearchItemCheck()) return;//검색조건 유효성 검사

            
            //관리자는 모든 조회가 가능
			dsT_DI_OVERTIMEWORK_STATE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune011.cmd.GUNE011CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&GBN="+gbn
												+"&ENO_NO="+eno_no+"&OUR_MAN="+our_man;

			dsT_DI_OVERTIMEWORK_STATE.reset();
			dsT_DI_OVERTIMEWORK_STATE.RowPosition = curRowPosition;

			
        }
		
		
		

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }
		
		
		
		

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요

        }
		
		
		
		

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

			
			
            if(dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
            	
				alert("삭제할 자료가 없습니다.");
				
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				
				return;
				
			}

            
            
            
            //처리상황이 요청이 아닌경우는 삭제 할 수 없음
            if(!(dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,'APP_STATUS') == 'SV')){
            	
                alert("결재 이후의 데이터는 삭제할 수 없습니다!");
                
                return;
                
            }
            
            
            

			if(confirm("[신청번호:"+dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,'REQ_NO')+"]의 정보를 삭제하시겠습니까?")){
				
				dsT_DI_OVERTIMEWORK_STATE.DeleteRow(dsT_DI_OVERTIMEWORK_STATE.RowPosition);
				
				trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMEWORK_STATE=dsT_DI_OVERTIMEWORK_STATE)";
				
				trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune011.cmd.GUNE011CMD&S_MODE=DEL";
				
				trT_DI_BUSINESSTRIP_STATE.post();
				
			}
			

        }

		
		
		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }
		
		

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요
            
            if (dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
            	
                alert("엑셀로 변환할 자료가 없습니다!");
                
                return;
                
            }
            

            form1.grdT_DI_BUSINESSTRIP_STATE.GridToExcel("연장근무", '', 225);            

            
        }

		
		
		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

		
		
		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }
		
		

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }
		
		

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {



        }

		
		
		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			
			if(dsTemp != "Modal"){
				
	            if (dsT_DI_OVERTIMEWORK_STATE.IsUpdated)  {
	            	
	                if (!fnc_ExitQuestion())  return;
	                
	            }

	            
                window.close();

            }else{
            	
                window.close();
                
            }

			
        }
		
		
		
		

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
			
			

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

			
			
 			//시작년월이 없으면 조회못함.
			if(str_ymd.trim().length == 0){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("시작년월을 입력하세요.");
					
					document.getElementById("txtSTR_YMD_SHR").focus();
					
					return false;
					
				}
				
			}
 			
 			
			//시작년월이 잘못되었으면 조회못함.
			if(str_ymd.trim().length != 10){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("시작년월이 잘못되었습니다.");
					
					document.getElementById("txtSTR_YMD_SHR").focus();
					
					return false;
					
				}
				
			}
			
			

			//종료년월이 없으면 조회못함.
			if(end_ymd.trim().length == 0){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("종료년월을 입력하세요.");
					
					document.getElementById("txtEND_YMD_SHR").focus();
					
					return false;
					
				}
				
			}
			
			
			//종료년월이 잘못되었으면 조회못함.
			if(end_ymd.trim().length != 10){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("종료년월이 잘못되었습니다.");
					
					document.getElementById("txtEND_YMD_SHR").focus();
					
					return false;
					
					
				}
				
			}
			
			
			

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
				
				
					alert("종료년월이 시작년월보다 빠릅니다.");
					
					document.getElementById("txtEND_YMD_SHR").focus();
					
					return false;
			}
			

            return true;

        }

		
		
		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//이곳에 해당 코딩을 입력 하세요

        }

		
		
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
        	
        	        dsT_DI_COST_CP.SetDataHeader(
								"GUBUN:STRING(10),"+			// 구분(코스트센터, 프로젝트)
	        					"CCTR_CD:STRING(10),"+			// CCR코드
	                            "CCTR_NM:STRING(20),"+			// CCR명
								"STR_YMD:STRING(20),"+			// 시작일
								"END_YMD:STRING(10)"			// 종료일
								);


            document.getElementById("txtSTR_YMD_SHR").value = addDate("D", today, -5);
            document.getElementById("txtEND_YMD_SHR").value = addDate("D", today, +5);

            
			document.getElementById("txtENO_NO_SHR").value=gusrid;
			document.getElementById("txtENO_NM_SHR").value=gusrnm;               
            
            
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070019" || gusrid == "2070020"){ 
				
				document.getElementById("txtENO_NO_SHR").value="";
				document.getElementById("txtENO_NM_SHR").value="";   				
				
				
			    fnc_ChangeStateElement(true, "imgENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");

	    	}else{

	            fnc_ChangeStateElement(false, "imgENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

			}					
			
			
			
			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_STATE,0,"false","true");      // Grid Style 적용


			fnc_SearchList();

            document.getElementById("txtSTR_YMD_SHR").focus();
            
            

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			
			
			fnc_HotKey_Process(btnList, event.keyCode);
			
			
		}

		
		
        /********************************************
         * 16. 연장근무 결재 팝업					*
         ********************************************/
		function fnc_DeciPop() {

        	
        	
            if(dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
            	
				alert("결재할 자료가 없습니다.");
				
				return;
				
			}


           
            var url = "../../../Ehr/hr/gun/gune015.jsp?REQ_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,"REQ_NO") + "&ENO_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,"ENO_NO") + "&APP_STATUS=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,"APP_STATUS");

			
            window.showModalDialog(url, "Modal", "dialogWidth:1080px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            
            fnc_SearchList();
            
            

		}

        
        
    </script>
    
    
    
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!----------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							        |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_OVERTIMEWORK_STATE)	|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_OVERTIMEWORK_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------------------+
    | 1. 카피용 DataSet							                |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_OVERTIMEWORK_STATE)	|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_OVERTIMEWORK_STATE_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------------------+
    | 1. 카피용 DataSet							                |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_COST_CP)
    | 3. 사용되는 Table List(SAP 귀속정보) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_COST_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			        |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)	|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	        |
    +----------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>



    <!-- 전표처리를 위해 -->
    <object id=dsPROC classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
        <param name=Syncload	value="true">
    </object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERTIMEWORK_STATE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>




	<Script For=dsPROC Event="OnLoadCompleted(iCount)">
	
		alert("전표처리가 완료 되었습니다.");

        //전표처리 후 다시 리스트 조회
        fnc_SearchList();
        
    </Script>



	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsPROC Event="OnLoadError()">
	
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
        
    </Script>



	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERTIMEWORK_STATE Event="OnLoadError()">
	
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
        
    </Script>



    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
    </script>



    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>




    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_DI_BUSINESSTRIP_STATE event="OnDblClick(row,colid)">

		curRowPosition = dsT_DI_OVERTIMEWORK_STATE.RowPosition;
		
		if(row < 1) {
			
			return;
			
		} else {

			
			if(dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
				
				alert("결재할 자료가 없습니다.");
				
				return;
				
			}
			
			
			if(dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_STATUS") == "SV" && dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"PENO_NO") != gusrid && gusrid != '6060002') {
				
				alert("저장상태입니다. 상신 후 결재 할 수있습니다.");
				
				return;
				
			}
			
			
			
			var url = "../../../Ehr/hr/gun/gune015.jsp?REQ_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"REQ_NO") + "&ENO_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"ENO_NO")  + "&APP_YN=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_YN")+ "&APP_STATUS=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_CMT");			
			
			
			window.showModalDialog(url, "Modal", "dialogWidth:1080px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            
			
			fnc_SearchList();

		}
		
		
		
	</script>




	<script language=JavaScript for=dsT_DI_OVERTIMEWORK_STATE event=OnRowPosChanged(row)>

	</script>





<!--**************************************************************************************
    *                                       											 *
	*	BODY START																		 *
    *                                       											 *
    **************************************************************************************-->
    
    
    
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->






	<!-- power Search테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="60"></col>
					<col width="220"></col>
					<col width="80"></col>
					<col width="170"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">근무기간&nbsp;</td>
					<td>
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
					    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
					</td>
					<td class="searchState" align="right">상태구분&nbsp;</td>
					<td>
						<select id="cmbGBN_SHR" style="width:100" onChange="fnc_SearchList();">
							<option value="1" >전체</option>
							<option value="2" >상신</option>
                            <option value="3" >결재완료</option>
						</select>
					</td>
				</tr>
				<tr class="paddingTop5" >
					<td class="searchState" align="right">상신자&nbsp;</td>
					<td >
						<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength="9"  onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
						<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR', 'txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
					</td>
					<td class="searchState" align="right">결재자&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9"        onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR')">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
						<td width="320">※결재를 원하시면 해당 신청서를 더블클릭 하세요.</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->





	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_BUSINESSTRIP_STATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" 			value="dsT_DI_OVERTIMEWORK_STATE">
						<param name="Editable" 			value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 			value="Left">
						<param name="Format" value='
                            <C> id="REQ_NO"			width=120	name="신청번호"		align=center    </C>
                            <C> id="ENO_NM"		width=120	name="상신자"			align=center    </C>
							<C> id="APP_YMD"		width=120	name="상신일"			align=center    </C>
							<C> id="APP_TITLE"		width=500	name="근무내역"	    align=left	    </C>
                            <C> id="APP_STATUS"		width=100	name="결재상태"		align=center    </C>
                            <C> id="APP_YN"		width=100	name="결재여부"		align=center show=false   </C>
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



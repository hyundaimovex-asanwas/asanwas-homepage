	<!--*************************************************************************
	* @source      : taxa180.jsp												
	* @description : 소득증명원출력 - 갑근세원천징수증명서
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									
	*----------------------------------------------------------------------------
	* 2016/08/01      이동훈        ERP 이사
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<html>
<head>
	<title>갑근세원천징수증명서</title>
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
			
			var PIS_YM_FR = document.getElementById("txtPIS_YM_FR_SHR").value;
			var PIS_YM_TO = document.getElementById("txtPIS_YM_TO_SHR").value;			
			
			var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
			var WAGESUM  = 0;			
			var TAXSUM	 = 0;

			
			if(!fnc_SearchItemCheck()) return;//필수 조회조건 체크

			
			dsT_TX_TAXMASTER.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.tax.a.taxa180.cmd.TAXA180CMD"
						        		+"&S_MODE=SHR"
						        		+"&PIS_YM_FR="+PIS_YM_FR			
						        		+"&PIS_YM_TO="+PIS_YM_TO							        		
    									+"&ENO_NO="+ENO_NO;			
			dsT_TX_TAXMASTER.Reset(); 	
			
			dsT_TX_TAXPERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.tax.a.taxa180.cmd.TAXA180CMD"
						        		+"&S_MODE=SHR2"					        		
										+"&ENO_NO="+ENO_NO;			
			dsT_TX_TAXPERSON.Reset(); 				

	        dsT_TX_TAXREPORT.setDataHeader("DATE1:STRING,WAGE1:DECIMAL,TAX1:DECIMAL,PLACE1:STRING,DATE2:STRING,WAGE2:DECIMAL,TAX2:DECIMAL,PLACE2:STRING,DATE3:STRING,WAGE3:DECIMAL,TAX3:DECIMAL,PLACE3:STRING,DATE4:STRING,WAGE4:DECIMAL,TAX4:DECIMAL,PLACE4:STRING,DATE5:STRING,WAGE5:DECIMAL,TAX5:DECIMAL,PLACE5:STRING,DATE6:STRING,WAGE6:DECIMAL,TAX6:DECIMAL,PLACE6:STRING,DATE7:STRING,WAGE7:DECIMAL,TAX7:DECIMAL,PLACE7:STRING,DATE8:STRING,WAGE8:DECIMAL,TAX8:DECIMAL,PLACE8:STRING,DATE9:STRING,WAGE9:DECIMAL,TAX9:DECIMAL,PLACE9:STRING,DATE10:STRING,WAGE10:DECIMAL,TAX10:DECIMAL,PLACE10:STRING,DATE11:STRING,WAGE11:DECIMAL,TAX11:DECIMAL,PLACE11:STRING,DATE12:STRING,WAGE12:DECIMAL,TAX12:DECIMAL,PLACE12:STRING,WAGESUM:DECIMAL,TAXSUM:DECIMAL,ENO_NM:STRING,CET_NO:STRING,ADDRESS:STRING,TODAY:STRING");
            
	        dsT_TX_TAXREPORT.Addrow();    
	                    

	        
			for(i=1;i<=dsT_TX_TAXMASTER.countrow;i++){

				var nm1 = "DATE"+i;
				var nm2 = "WAGE"+i;
				var nm3 = "TAX"+i;
				var nm4 = "PLACE"+i;				

				dsT_TX_TAXREPORT.namevalue(1,nm1) = dsT_TX_TAXMASTER.namevalue(i,"PIS_DATE");
				dsT_TX_TAXREPORT.namevalue(1,nm2) = dsT_TX_TAXMASTER.namevalue(i,"SALT_AMT");				
				dsT_TX_TAXREPORT.namevalue(1,nm3) = dsT_TX_TAXMASTER.namevalue(i,"TAX_AMT");
				dsT_TX_TAXREPORT.namevalue(1,nm4) = dsT_TX_TAXMASTER.namevalue(i,"AMT_DATE");						
			
				WAGESUM = WAGESUM + parseInt(dsT_TX_TAXMASTER.namevalue(i,"SALT_AMT"));
				TAXSUM = TAXSUM + parseInt(dsT_TX_TAXMASTER.namevalue(i,"TAX_AMT"));				

			}	        

	        dsT_TX_TAXREPORT.namevalue(1,"WAGESUM") = WAGESUM;
	        dsT_TX_TAXREPORT.namevalue(1,"TAXSUM") = TAXSUM;	        
	        
	        dsT_TX_TAXREPORT.namevalue(1,"ENO_NM") = dsT_TX_TAXPERSON.namevalue(1,"ENO_NM");
	        dsT_TX_TAXREPORT.namevalue(1,"CET_NO") = dsT_TX_TAXPERSON.namevalue(1,"CET_NO");	
	        dsT_TX_TAXREPORT.namevalue(1,"ADDRESS") = dsT_TX_TAXPERSON.namevalue(1,"ADDRESS");		        
	        dsT_TX_TAXREPORT.namevalue(1,"TODAY") = dsT_TX_TAXPERSON.namevalue(1,"TODAY");
	        
	        gcrp_print.Preview();


        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

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
			
       		if( document.form1.txtPIS_YM_FR_SHR.value=="" || document.form1.txtPIS_YM_TO_SHR.value==""){
       			
       			alert("발급일을 입력하십시오.");
       			
       			document.form1.txtPIS_YM_FR_SHR.focus();
       			
        		return false;
        	}
       		
       		if( document.form1.txtENO_NO_SHR.value=="" ){
       			
       			alert("사원번호를 입력하십시오.");
       			
       			document.form1.txtENO_NO_SHR.focus();
       			
        		return false;
        	}


        	return true;

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

            document.getElementById("txtPIS_YM_FR_SHR").value = gcurdate.substring(0,7);
            
            document.getElementById("txtPIS_YM_TO_SHR").value = gcurdate.substring(0,7);
            
            document.getElementById("txtSTR_YMD_SHR").value = gcurdate;
            
            document.getElementById('txtENO_NO_SHR').focus();

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
    </script>
</head>


    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKDETAIL                   |
    | 3. Table List : T_ED_BOOKDETAIL               |
    +----------------------------------------------->
    <Object ID="dsT_TX_TAXMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_TX_TAXPERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_TX_TAXREPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->



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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="1000" border="1" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="80"></col>
					<col width="100"></col>
					<col width="300"></col>				
					<col width=""></col>
				</colgroup>
                <tr>
                    <td align="right" class="searchState">발급일자&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','100','185');"></a>
                    </td>

                                 <td width="300" style="padding-left:0px; border-style:none">
                                     <input type="text" id="txtPIS_YM_FR_SHR" style="ime-mode:disabled" size="8" maxlength= "7"  onblur= "cfCheckDate(this);"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                                        		부터

                                     <input type="text" id="txtPIS_YM_TO_SHR" style="ime-mode:disabled" size="8" maxlength= "7"  onblur= "cfCheckDate(this);"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                                        		까지

                    </td>
                </tr>
                <tr>
                    <td align="right" class="searchState">사원번호&nbsp;</td>
                    <td class="padding2423" align="left" colspan="3">
                        <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');"></a>
                        <input type="hidden" id="hidEMPL_DPT_CD">
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



	</form>
	<!-- form 끝 -->




<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 갑근세원천징수증명서 ####
------------------------------------------------------------------------------>



	
<object  ID="gcrp_print" CLASSID="CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089" >  
 
	<PARAM NAME="MasterDataID"		VALUE="dsT_TX_TAXREPORT">  
	<PARAM NAME="DetailDataID"		VALUE="dsT_TX_TAXREPORT">
    <param name="PaperSize"         value="A4">
    <param name="Landscape"         value="false">
    <param name="NullRecordFlag"    value="true">
    <param name="PrintSetupDlgFlag" value="true">
    <param name="PreviewZoom"       value="100">
    <param name="Format"            value=" 	
	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2693 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=24 ,top=66 ,right=1945 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='갑종근로소득에 대한 소득세 원천징수증명서' ,left=513 ,top=106 ,right=1437 ,bottom=164 ,face='돋움' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='발급번호' ,left=58 ,top=74 ,right=315 ,bottom=114 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Issuing Number' ,left=58 ,top=116 ,right=315 ,bottom=156 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='No.' ,left=58 ,top=177 ,right=124 ,bottom=235 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=365 ,top=66 ,right=365 ,bottom=246 </L>
	<L> left=24 ,top=249 ,right=1945 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=362 ,top=164 ,right=24 ,bottom=164 </L>
	<L> left=1942 ,top=156 ,right=1603 ,bottom=156 </L>
	<L> left=1603 ,top=69 ,right=1603 ,bottom=249 </L>
	<T>id='처리기간' ,left=1654 ,top=69 ,right=1910 ,bottom=108 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Period Handling' ,left=1656 ,top=111 ,right=1913 ,bottom=151 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='즉시' ,left=1651 ,top=161 ,right=1908 ,bottom=201 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Immediately' ,left=1654 ,top=204 ,right=1910 ,bottom=243 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1945 ,top=331 ,right=270 ,bottom=331 </L>
	<T>id='납세자' ,left=64 ,top=270 ,right=235 ,bottom=328 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Tax Payer' ,left=64 ,top=331 ,right=235 ,bottom=389 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=296 ,top=296 ,right=468 ,bottom=328 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 성    명' ,left=296 ,top=257 ,right=468 ,bottom=296 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 주 민 등 록 번 호' ,left=828 ,top=254 ,right=1278 ,bottom=294 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Resident Registration No.' ,left=828 ,top=296 ,right=1278 ,bottom=328 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1304 ,top=249 ,right=1304 ,bottom=333 </L>
	<C>id='CET_NO', left=1320, top=259, right=1939, bottom=318, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=818 ,top=249 ,right=818 ,bottom=333 </L>
	<L> left=29 ,top=407 ,right=1945 ,bottom=407 </L>
	<L> left=26 ,top=664 ,right=1942 ,bottom=664 </L>
	<L> left=267 ,top=249 ,right=267 ,bottom=664 </L>
	<T>id='Agent' ,left=66 ,top=587 ,right=238 ,bottom=630 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Withholding' ,left=66 ,top=542 ,right=238 ,bottom=585 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의무자' ,left=66 ,top=489 ,right=238 ,bottom=534 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징 수' ,left=66 ,top=447 ,right=238 ,bottom=492 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1307 ,top=410 ,right=1307 ,bottom=495 </L>
	<T>id='⑤ 사 업 자 등 록 번 호' ,left=828 ,top=413 ,right=1281 ,bottom=452 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Taxpayer Identification No.' ,left=828 ,top=458 ,right=1281 ,bottom=489 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2 2 1 - 8 1 - 1 3 8 3 4' ,left=1323 ,top=434 ,right=1934 ,bottom=474 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=564 ,top=434 ,right=807 ,bottom=474 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=558, top=259, right=812, bottom=318, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='③ 주소 또는 거소' ,left=275 ,top=336 ,right=550 ,bottom=376 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=275 ,top=376 ,right=548 ,bottom=407 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='④ 상호 또는 명칭' ,left=275 ,top=413 ,right=548 ,bottom=452 ,align='left' ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name of company' ,left=275 ,top=455 ,right=548 ,bottom=487 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=820 ,top=407 ,right=820 ,bottom=492 </L>
	<C>id='ADDRESS', left=564, top=341, right=1939, bottom=400, align='left', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='⑥ 사업장 소재지' ,left=275 ,top=497 ,right=548 ,bottom=537 ,align='left' ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Business Location' ,left=275 ,top=542 ,right=548 ,bottom=574 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 서울 종로구 연지동 율곡로 194 현대그룹빌딩 동관 3,4층        Tel : 02 - 3669 -3000' ,left=564 ,top=516 ,right=1931 ,bottom=556 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑦ 대   표   자' ,left=275 ,top=582 ,right=548 ,bottom=622 ,align='left' ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Representative' ,left=275 ,top=627 ,right=548 ,bottom=659 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이 백 훈' ,left=572 ,top=601 ,right=815 ,bottom=640 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑧ 주민 (법인) 등록번호' ,left=833 ,top=582 ,right=1286 ,bottom=622 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Resident (Corporation) Reg No.' ,left=833 ,top=627 ,right=1286 ,bottom=659 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1 4 0 1 1 1 - 0 0 1 1 7 1 4' ,left=1326 ,top=601 ,right=1937 ,bottom=640 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=553 ,top=251 ,right=553 ,bottom=746 </L>
	<L> left=24 ,top=746 ,right=1939 ,bottom=746 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='⑨ 증 명 서 의 사 용 목 적' ,left=29 ,top=667 ,right=548 ,bottom=706 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Purpose of This Certificate' ,left=29 ,top=709 ,right=545 ,bottom=741 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1307 ,top=579 ,right=1307 ,bottom=746 </L>
	<L> left=823 ,top=579 ,right=823 ,bottom=746 </L>
	<L> left=1638 ,top=667 ,right=1638 ,bottom=746 </L>
	<T>id='⑪ 소 요 수 량' ,left=1331 ,top=667 ,right=1630 ,bottom=706 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Quantity Of Certificate' ,left=1331 ,top=709 ,right=1630 ,bottom=741 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Copy' ,left=1828 ,top=709 ,right=1934 ,bottom=741 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='통' ,left=1831 ,top=669 ,right=1921 ,bottom=709 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=831 ,right=1947 ,bottom=831 </L>
	<L> left=24 ,top=913 ,right=1945 ,bottom=913 </L>
	<L> left=24 ,top=1000 ,right=1947 ,bottom=1000 </L>
	<L> left=24 ,top=1087 ,right=1947 ,bottom=1087 </L>
	<L> left=24 ,top=1172 ,right=1947 ,bottom=1172 </L>
	<L> left=21 ,top=1426 ,right=1945 ,bottom=1426 </L>
	<L> left=24 ,top=1251 ,right=1947 ,bottom=1251 </L>
	<L> left=191 ,top=749 ,right=191 ,bottom=1339 </L>
	<L> left=24 ,top=1339 ,right=1947 ,bottom=1339 </L>
	<T>id='년 월' ,left=64 ,top=751 ,right=153 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date' ,left=58 ,top=796 ,right=164 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Wage and Salary' ,left=196 ,top=796 ,right=434 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑫ 급 여 액' ,left=201 ,top=751 ,right=429 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=696 ,top=749 ,right=696 ,bottom=1339 </L>
	<T>id='⑬ 세 액' ,left=455 ,top=751 ,right=683 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Tax Amount' ,left=450 ,top=796 ,right=688 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Place Tax Payment' ,left=706 ,top=796 ,right=979 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑭ 납부 년월일' ,left=706 ,top=751 ,right=976 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=437 ,top=749 ,right=437 ,bottom=1339 </L>
	<T>id='Place Tax Payment' ,left=1670 ,top=796 ,right=1942 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑭ 납부 년월일' ,left=1670 ,top=751 ,right=1939 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑬ 세 액' ,left=1429 ,top=751 ,right=1656 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Tax Amount' ,left=1421 ,top=796 ,right=1659 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑫ 급 여 액' ,left=1177 ,top=751 ,right=1405 ,bottom=791 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Wage and Salary' ,left=1169 ,top=796 ,right=1408 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date' ,left=1027 ,top=796 ,right=1132 ,bottom=828 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='년 월' ,left=1035 ,top=754 ,right=1124 ,bottom=794 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=987 ,top=749 ,right=987 ,bottom=1426 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1164 ,top=749 ,right=1164 ,bottom=1426 </L>
	<L> left=1413 ,top=749 ,right=1413 ,bottom=1429 </L>
	<L> left=1662 ,top=749 ,right=1662 ,bottom=1429 </L>
	<T>id='계' ,left=1032 ,top=1344 ,right=1122 ,bottom=1384 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='total' ,left=1024 ,top=1392 ,right=1130 ,bottom=1423 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세법시행규칙 제90조의 규정에 의하여 발급일 현재 위와 같이 원천 징수하였음을 증명하여 주시기 바랍니다.' ,left=40 ,top=1455 ,right=1918 ,bottom=1495 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='I hereby request you to certify that the tax amount described above is duly paid as of this day under the Article 90 of' ,left=40 ,top=1505 ,right=1918 ,bottom=1545 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='the Enforcement Ordinance of the Income Tax law.' ,left=40 ,top=1553 ,right=1918 ,bottom=1593 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=21 ,top=1773 ,right=1942 ,bottom=1773 </L>
	<T>id='신 청 인' ,left=796 ,top=1675 ,right=1037 ,bottom=1715 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Applicant' ,left=796 ,top=1722 ,right=1037 ,bottom=1754 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 서명 또는 인 )' ,left=1511 ,top=1670 ,right=1823 ,bottom=1709 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(Signature or Stamp)' ,left=1511 ,top=1717 ,right=1823 ,bottom=1749 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=21 ,top=2098 ,right=1942 ,bottom=2098 </L>
	<T>id='(Signature or Stamp)' ,left=1527 ,top=2056 ,right=1839 ,bottom=2088 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 서명 또는 인 )' ,left=1527 ,top=2008 ,right=1839 ,bottom=2048 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='증명자(원천징수의무자)' ,left=741 ,top=2008 ,right=1111 ,bottom=2048 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 위와 같이 원천 징수하였음을 증명합니다.' ,left=32 ,top=1781 ,right=1910 ,bottom=1820 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' I hereby certify that the above withholding tax was duly collected' ,left=32 ,top=1826 ,right=1910 ,bottom=1865 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이 백 훈' ,left=1143 ,top=2024 ,right=1513 ,bottom=2064 ,face='돋움' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Certifier(Withholding agent)' ,left=738 ,top=2056 ,right=1114 ,bottom=2088 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' ※ 이 증명서는 다음의 원천징수의무자가 직접 교부할 수 있습니다.' ,left=37 ,top=2109 ,right=1916 ,bottom=2148 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  This certificate can be issued directly by the following withholding agents' ,left=37 ,top=2151 ,right=1916 ,bottom=2191 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 1. 국가·지방자치단체 및 한국은행' ,left=37 ,top=2193 ,right=1916 ,bottom=2233 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 1. National and local goverments and The Bank of Korea' ,left=37 ,top=2236 ,right=1916 ,bottom=2275 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 2. State owned Enterprises' ,left=37 ,top=2320 ,right=1916 ,bottom=2360 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 2. 국가·지방자치단체가 자본금의 전부 또는 일부를 출자한 법인' ,left=37 ,top=2278 ,right=1916 ,bottom=2318 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 3. 주권상장법인' ,left=37 ,top=2363 ,right=1916 ,bottom=2402 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 3. Corperation listed in the Korea Stock Exchange' ,left=37 ,top=2405 ,right=1916 ,bottom=2445 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 4. 미국군' ,left=37 ,top=2447 ,right=1916 ,bottom=2487 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 4. United States Armed Forces' ,left=37 ,top=2490 ,right=1916 ,bottom=2529 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[ 별지 제2호 서식]' ,left=40 ,top=16 ,right=355 ,bottom=61 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Tax Clearance Certifacate Of Class A Wages & Salaries' ,left=423 ,top=175 ,right=1511 ,bottom=233 ,face='돋움' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1148 ,top=664 ,right=1148 ,bottom=743 </L>
	<T>id='⑩ 제 출 처' ,left=828 ,top=669 ,right=1143 ,bottom=709 ,face='돋움' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='President be Submitted' ,left=828 ,top=712 ,right=1143 ,bottom=743 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TODAY', left=677, top=1609, right=1146, bottom=1667, face='돋움', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TODAY', left=683, top=1942, right=1162, bottom=2000, face='돋움', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=270 ,top=492 ,right=1950 ,bottom=492 </L>
	<L> left=267 ,top=577 ,right=1947 ,bottom=577 </L>
	<C>id='ENO_NM', left=1191, top=1683, right=1445, bottom=1741, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE1,0,,WAGE1)}', left=209, top=844, right=426, bottom=902, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE2,0,,WAGE2)}', left=209, top=926, right=426, bottom=984, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE3,0,,WAGE3)}', left=206, top=1013, right=423, bottom=1072, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE4,0,,WAGE4)}', left=209, top=1103, right=426, bottom=1162, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE5,0,,WAGE5)}', left=209, top=1183, right=426, bottom=1241, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE6,0,,WAGE6)}', left=209, top=1265, right=426, bottom=1323, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE7,0,,WAGE7)}', left=1183, top=844, right=1400, bottom=902, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE8,0,,WAGE8)}', left=1185, top=929, right=1402, bottom=987, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE9,0,,WAGE9)}', left=1185, top=1016, right=1402, bottom=1074, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE10,0,,WAGE10)}', left=1185, top=1103, right=1402, bottom=1162, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE11,0,,WAGE11)}', left=1185, top=1183, right=1402, bottom=1241, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(WAGE12,0,,WAGE12)}', left=1185, top=1267, right=1402, bottom=1326, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX1,0,,TAX1)}', left=463, top=841, right=680, bottom=900, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX2,0,,TAX2)}', left=466, top=929, right=683, bottom=987, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX3,0,,TAX3)}', left=466, top=1013, right=683, bottom=1072, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX4,0,,TAX4)}', left=463, top=1101, right=680, bottom=1159, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX5,0,,TAX5)}', left=463, top=1183, right=680, bottom=1241, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX6,0,,TAX6)}', left=460, top=1265, right=677, bottom=1323, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX7,0,,TAX7)}', left=1431, top=841, right=1648, bottom=900, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX8,0,,TAX8)}', left=1431, top=929, right=1648, bottom=987, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX9,0,,TAX9)}', left=1431, top=1013, right=1648, bottom=1072, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX10,0,,TAX10)}', left=1434, top=1101, right=1651, bottom=1159, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX11,0,,TAX11)}', left=1431, top=1183, right=1648, bottom=1241, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(TAX12,0,,TAX12)}', left=1431, top=1267, right=1648, bottom=1326, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE1', left=32, top=844, right=183, bottom=902, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE2', left=32, top=926, right=183, bottom=984, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE3', left=32, top=1013, right=183, bottom=1072, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE4', left=32, top=1103, right=183, bottom=1162, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE5', left=32, top=1183, right=183, bottom=1241, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE6', left=32, top=1265, right=183, bottom=1323, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE7', left=1000, top=844, right=1151, bottom=902, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE8', left=1000, top=926, right=1151, bottom=984, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE9', left=1000, top=1013, right=1151, bottom=1072, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE10', left=1000, top=1101, right=1151, bottom=1159, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE11', left=1000, top=1183, right=1151, bottom=1241, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE12', left=1000, top=1265, right=1151, bottom=1323, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE1', left=709, top=844, right=974, bottom=902, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE2', left=709, top=929, right=974, bottom=987, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE3', left=709, top=1016, right=974, bottom=1074, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE4', left=706, top=1101, right=971, bottom=1159, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE5', left=706, top=1183, right=971, bottom=1241, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE6', left=706, top=1265, right=971, bottom=1323, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE7', left=1672, top=844, right=1937, bottom=902, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE8', left=1672, top=929, right=1937, bottom=987, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE9', left=1672, top=1016, right=1937, bottom=1074, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE10', left=1672, top=1101, right=1937, bottom=1159, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE11', left=1672, top=1183, right=1937, bottom=1241, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE12', left=1675, top=1267, right=1939, bottom=1326, face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WAGESUM', left=1188, top=1355, right=1405, bottom=1413, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXSUM', left=1434, top=1355, right=1651, bottom=1413, align='right', face='돋움', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=24 ,top=2537 ,right=1945 ,bottom=2537 </L>
	<T>id=' ※ 구비서류 : 소득자별 근로소득원천징수부 1부' ,left=37 ,top=2548 ,right=1916 ,bottom=2588 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' ※ Attachment : Copy of the book of Wages & Salaries withheld' ,left=37 ,top=2590 ,right=1916 ,bottom=2630 ,align='left' ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=2641 ,right=1942 ,bottom=2641 </L>
	<T>id='(210mmX297mm 신문용지 54g/m)' ,left=1437 ,top=2651 ,right=1942 ,bottom=2691 ,face='돋움' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=69 ,right=1947 ,bottom=2633 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=24 ,top=69 ,right=24 ,bottom=2633 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>


">
</OBJECT>


</body>
</html>


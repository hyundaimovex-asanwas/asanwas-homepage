	<!--*******************************************************
	* @source      : idtb002.jsp							  *
	* @description : 연봉계약서 작성 리스트 PAGE 		      *
	***********************************************************
	* DATE            AUTHOR        DESCRIPTION				  *
	*----------------------------------------------------------
	* 2019/03/13            이동훈            	         	  *
	*******************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
	<title>연봉계약서 작성 리스트</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>

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

	<script language="javascript">

		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		
        var trTypeMsg = "";

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.form1.txtSTR_YMD_SHR.value;
			var END_YMD_SHR = document.form1.txtEND_YMD_SHR.value;
            var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;

			dsT_CM_CONTRACT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb002.cmd.IDTB002CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&ENO_NM_SHR="+ENO_NM_SHR;
			//prompt(this,dsT_CM_CONTRACT.DataId);
			dsT_CM_CONTRACT.reset();

        }

		
		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요

        }


		/********************************************
         * 03. 저장 함수						    *
         ********************************************/
        function fnc_Save() {

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_CM_CONTRACT.KeyValue = "tr01(I:dsT_CM_CONTRACT=dsT_CM_CONTRACT)";
			
			trT_CM_CONTRACT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb002.cmd.IDTB002CMD&S_MODE=SAV";

			trT_CM_CONTRACT.post();

        }

		

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {
			
			if (dsT_CM_CONTRACT.CountRow < 1) {
				
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
				
                alert("삭제 할 자료가 없습니다!");
                
                return;
                
            }else{
            	
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
           		
            	tmpMSG += "등록번호 = "+dsT_CM_CONTRACT.nameValue(dsT_CM_CONTRACT.RowPosition, "SID")+"\n";
            	tmpMSG += "성명     = "+dsT_CM_CONTRACT.nameValue(dsT_CM_CONTRACT.RowPosition, "ENO_NM")+"\n";


	            if( confirm(tmpMSG) ){
	            	
					var SID = dsT_CM_CONTRACT.nameValue(dsT_CM_CONTRACT.RowPosition, "SID");

					dsT_CM_CONTRACT.DeleteRow(dsT_CM_CONTRACT.RowPosition);

                    //결과 메세지를 뿌리기 위해
                    trTypeMsg = "삭제";

					// 파라미터 추가
					trT_CM_CONTRACT_DEL.Parameters = "SID="+SID;

					trT_CM_CONTRACT_DEL.KeyValue = "tr01(I:dsT_CM_CONTRACT=dsT_CM_CONTRACT)";
					trT_CM_CONTRACT_DEL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb002.cmd.IDTB002CMD&S_MODE=DEL";
					trT_CM_CONTRACT_DEL.post();
					
				}
	            
			}
			
        }


		/********************************************
         * 05. 인쇄 함수  						    *
         ********************************************/
         
         function fnc_Print() {         

 			//A:기본 B:선상 C:현장
   			var doc_kind = dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'CD_GBN');			
			
				var Y01_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P01_AMT')) * 12
				var Y02_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P02_AMT')) * 12
				var Y03_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P03_AMT')) * 12
				var Y04_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P04_AMT')) * 12				
				var Y05_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P05_AMT')) * 12				
				var YSUM_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'SUM_AMT')) * 12				
 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y01_AMT") = Y01_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y02_AMT") = Y02_AMT;
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y03_AMT") = Y03_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y04_AMT") = Y04_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y05_AMT") = Y05_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "YSUM_AMT") = YSUM_AMT; 		
		
				//prompt(this, dsT_CM_CONTRACT.text);
		
  			if(doc_kind == "A"){ 			
 			
 				alert("기본 연봉계약서 화면으로 이동합니다.");
 				

 				
 				//선택된 ROW를 복사하여 dsT_CM_CONTRACT_PRINT 넘겨준다.
 				cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

 				gcrp_print1.Preview();

  			}else if(doc_kind == "B"){
  				
  				alert("선상 연봉계약서 화면으로 이동합니다.");

 				//선택된 ROW를 복사하여 dsT_CM_CONTRACT_PRINT 넘겨준다.
 				cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

 				gcrp_print2.Preview();
  				
  			}else if(doc_kind == "C"){
  				
  				alert("현장 연봉계약서 화면으로 이동합니다.");

 				//선택된 ROW를 복사하여 dsT_CM_CONTRACT_PRINT 넘겨준다.
 				cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

 				gcrp_print3.Preview();
 				
  			}
  			
  			
		}



		/********************************************
         * 06. 엑셀 저장 함수  					    *
         ********************************************/
        function fnc_ToExcel() {


        }

		
		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			// 행 추가
			dsT_CM_CONTRACT.AddRow();


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
			
			
        }

		
		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

        	document.getElementById("resultMessage").innerText = ' ';
        	
        	dsT_CM_CONTRACT.ClearData();

        }

		
		
		/********************************************
         * 11. 화면 종료(닫기)  				    *
         ********************************************/
        function fnc_Exit() {
			
        	window.close();
        	
        }

		
		/********************************************
         * 12. 검색 조건 유효성 검사  			    *
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
	        
        }

		
		/********************************************
         * 13. 저장 유효성 체크  				    *
         ********************************************/
        function fnc_SaveItemCheck() {
			
  			if ( !dsT_CM_CONTRACT.isUpdated ) {
  				
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
			}

			return true;
        }

		
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
        	
            cfStyleGrid_New(form1.grdT_CM_CONTRACT,15,"false","false");      // Grid Style 적용
        	
            document.getElementById("txtSTR_YMD_SHR").value = gcurdate.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = gcurdate;            

			fnc_SearchList();
            
        }
        
        
        
        /**
         * 총연봉을 계산
         */
        function cal_Sum(P01_AMT, P02_AMT, P03_AMT, P04_AMT, P05_AMT){
        	
            var P1_AMT = document.getElementById(P01_AMT);
            var P2_AMT = document.getElementById(P02_AMT);
            var P3_AMT = document.getElementById(P03_AMT);
            var P4_AMT = document.getElementById(P04_AMT);
            var P5_AMT = document.getElementById(P05_AMT);

			var Sum_amt = parseInt(P1_AMT.text) + parseInt(P2_AMT.text) + parseInt(P3_AMT.text) + parseInt(P4_AMT.text) + parseInt(P5_AMT.text);

            document.getElementById("txtSum_amt").text = Sum_amt;

        }
        
    </script>
    
</head>


<!-- 기본수당에서 커서가 날아갈 때 계산 수 -->
<script language=JavaScript for=txtP01_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- 시간외수당에서 커서가 날아갈 때 계산 수 -->
<script language=JavaScript for=txtP02_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- 휴일수당에서 커서가 날아갈 때 계산 수 -->
<script language=JavaScript for=txtP03_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- 특수수당에서 커서가 날아갈 때 계산 수 -->
<script language=JavaScript for=txtP04_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- 조정수당에서 커서가 날아갈 때 계산 수 -->
<script language=JavaScript for=txtP05_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>


<!--**************************************************************************************
   *                                                                                        *
   * Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)  *
   *                                                                                        *
   ***************************************************************************************-->

<!-----------------------------------------------------+
   | 1. 조회용 DataSet									   |
   | 2. 이름은 ds_ + 주요 테이블명(T_CM_CONTRACT)		   |
   | 3. 사용되는 Table List(T_CM_CONTRACT) 			 	   |
   +------------------------------------------------------>
<Object ID="dsT_CM_CONTRACT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" 				Value="True">
	<Param Name="UDOChangeInfo"			Value="True">
	<Param Name="ViewDeletedRow"		Value="False">
</Object>


<Object ID="dsT_CM_CONTRACT_PRINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" 				Value="True">
	<Param Name="UDOChangeInfo"			Value="True">
	<Param Name="ViewDeletedRow"		Value="False">
</Object>



<!-----------------------------------------------------+
   | 1. 자료 저장 및 조회용 Data Transacton			   |
   | 2. 이름은 tr_ + 주요 테이블명(T_CM_CONTRACT)		   |
   | 3. 사용되는 Table List(T_CM_CONTRACT)				   |
   +------------------------------------------------------>
<Object ID="trT_CM_CONTRACT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_CM_CONTRACT_DEL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--**************************************************************************************
   *                                       												 *
   *	Component에서 발생하는 Event 처리부													 *
   *                                       												 *
   ***************************************************************************************-->

<!-----------------------------------------------------+
   | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
   +------------------------------------------------------>
<Script For=dsT_CM_CONTRACT Event="OnLoadCompleted(iCount)">

	if (iCount == 0)    {
		fnc_Message(document.getElementById("resultMessage"),"MSG_02");
	} else {
		// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_CONTRACT.CountRow);
       }
	
</Script>



<!-----------------------------------------------------+
   | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
   +------------------------------------------------------>
<Script For=dsT_CM_CONTRACT Event="OnLoadError()">
       //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
       cfErrorMsg(this);
       // 에러 메세지 처리 후 다음 처리 할 내용 코딩
</Script>

<!-----------------------------------------------------+
   | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때|
   +------------------------------------------------------>
<Script For=dsT_CM_CONTRACT Event="OnDataError()">
       //Dataset관련 Error 처리
       cfErrorMsg(this);
   </Script>

<!-----------------------------------------------------+
   | Transaction Successful 처리     						   |
   +------------------------------------------------------>
<script for=trT_CM_CONTRACT event="OnSuccess()">

       //메세지 뿌리기
       fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

      	alert("정상적으로 저장되었습니다.");
      	
      	fnc_SearchList();
      	
</script>

<script for=trT_CM_CONTRACT_DEL event="OnSuccess()">

       fnc_SearchList();

       //메세지 뿌리기
       fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
       
       alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");
       
</script>

<!-----------------------------------------------------+
   | Transaction Failure 처리    	   					   |
   +------------------------------------------------------>
<script for=trT_CM_CONTRACT event="OnFail()">
       alert(trT_CM_CONTRACT.ErrorMsg);
</script>

<script for=trT_CM_CONTRACT_DEL event="OnFail()">
       alert(trT_CM_CONTRACT.ErrorMsg);
</script>




<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->


<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 캘린더 프레임 -->
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
           	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAVE','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
				<col width="200"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
			<tr>
				<td class="searchState" align="right">입사기간</td>
				<td class="padding2423" align="left">
					<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
					~
					<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
				</td>

                <td align="right" class="searchState">성명</td>
                <td class="padding2423">
                    <input id="txtENO_NM_SHR" size="15" maxlength= "9"  onkeypress="if (event.keyCode == 13) fnc_SearchList();">
                </td>
             </tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->

<br>
	
<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="120"></col>
			<col width="80"></col>
			<col width="150"></col>			
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">성명</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14" >
            </td>
			<td align="center" class="blueBold">문서구분</td>
			<td class="padding2423" align="left">
				<select id="cmbCD_GBN" style="width:90%">
                   <option value="" ></option>
                   <option value="A">기본</option>
                   <option value="B">선상</option>	
                   <option value="C">현장</option>	               
				</select>	
			</td>   
			<td align="center" class="blueBold">근로기간</td>
			<td class="padding2423" align="left" colspan=3>
				<input id="txtFROM_YMD" size="10" maxlength="10" >  ~
				<input id="txtTO_YMD" size="10" maxlength="10" >                
				<input id="txtMONTH" name="txtMONTH" size="5" maxlength= "5" >
			</td>	
			<td align="center" class="blueBold">총연봉</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=false>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>     
            </td>	
		</tr>
		<tr>
			<td align="center" class="blueBold">기본급</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>            
            </td>				
			<td align="center" class="blueBold">시간외수당</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>	
			<td align="center" class="blueBold">휴일근로수당</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>				
			<td align="center" class="blueBold">특수지수당</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>	            
			<td align="center" class="blueBold">조정수당</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>	 
		</tr>

</table>
		
		
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
			<comment id="__NSID__">
			<object id="grdT_CM_CONTRACT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:350px;">
				<param name="DataID" 			value="dsT_CM_CONTRACT">
				<param name="Editable" 			value="false">
				<param name="DragDropEnable" 	value="true">
				<param name="SortView" 			value="Left">
				<param name="Format" 			value='
					<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
					<C> id="SID"		width=100	name="문서번호"		align=center	Edit=none	 show=false</C>
					<C> id="CD_GBN"		width=80	name="문서종류"		align=center	Edit=none	 value={decode(CD_GBN, "A", "기본", "B", "선상", "C", "현장")}</C>					
					<C> id="ENO_NM"		width=80	name="성명"			align=center	Edit=none	 </C>			
					<C> id="FROM_YMD"	width=80	name="시작일"		align=center	Edit=none	 </C>										
					<C> id="TO_YMD"		width=80	name="종료일"		align=center	Edit=none	 </C>
					<C> id="MONTH"		width=50	name="개월수"		align=center	Edit=none	 </C>
					<C> id="P01_AMT"	width=90	name="기본연봉"		align=right		Edit=none	 </C>	
					<C> id="P02_AMT"	width=90	name="시간외수당"	align=right		Edit=none	 </C>					
					<C> id="P03_AMT"	width=90	name="휴일수당"		align=right		Edit=none	 </C>
					<C> id="P04_AMT"	width=90	name="특수지수당"	align=right		Edit=none	 </C>					
					<C> id="P05_AMT"	width=90	name="조정수당"		align=right		Edit=none	 </C>						
					<C> id="SUM_AMT"	width=90	name="총연봉"		align=right		Edit=none	 </C>			
				'>
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 기본 연봉계약서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print1  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='연봉계약서' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='문체부 바탕체' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 갑 )' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회 사 명 :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 자 :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 을 )' ,left=1021 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성    명 :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계약일자 : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='체결한 근로계약서, 취업규칙 및 관련법령에 의한다. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기준에 따른다.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(지급당일이 휴일인 경우 그 전일)에 근로자 본인 명의의 지정 계좌에 입금하는 방식으로 지급한다.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 당월 1일부터 말일까지를 급여산정기간으로 하며, 총 연봉의 12분의 1에 해당하는 금액을 매월 25일' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='따라 적용한다.' ,left=116 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계, 근무지변동 등에 의해 연봉 조정사유가 있을 경우에는 취업규칙 등 회사 인사규정에 ' ,left=116 ,top=1357 ,right=1881 ,bottom=1394 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당이다.' ,left=138 ,top=1164 ,right=1876 ,bottom=1201 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금품으로 평균급여의 포함에서 제외한다. ' ,left=135 ,top=1080 ,right=1876 ,bottom=1117 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='포함하여 산출하는 포괄임금산정제로 하며, 월 급여의 구성은 아래와 같다. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'을\'은 본인의 연봉에 관하여 타인에게 알리거나 타인의 연봉을 알려고 하지 않으며, 연봉과 ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관련한 제반사항에 대한 비밀을 절대로 누설하지 않는다. 만약 연봉과 관련한 사항을 누설하는 경우 ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계 사유가 될 수 있으며, 이로 인한 불이익에 이의를 제기하지 않는다. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제3조【지급방법】' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제5조【적   용】' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① \'을\'은 상기와 같이 책정된 연봉액에 동의하며, 상기에 명시되지 않은 내용은 회사가 정한 별도 ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 본 사항은 상기 연봉 적용기간에 한하여 적용되며, 기타 신분과 관련된 제반사항은 입사 시 ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 계약서는 기 체결한 연봉계약서상의 임금관련 내용을 대체한다. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 기본급은 법정근로시간(209시간/月)에 대한 급여이다.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 시간외수당은 월 52시간의 연장·야간근로에 대한 급여이다.' ,left=95 ,top=953 ,right=1879 ,bottom=990 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 휴일근로수당은 월 18시간의 휴일근로에 대한 급여이다. ' ,left=95 ,top=995 ,right=1879 ,bottom=1032 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 특수지수당은 북측지역에 근무한 경우 발생할 수 있는 추가적 비용을 보전하기 위하여 지급하는 ' ,left=95 ,top=1037 ,right=1879 ,bottom=1074 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5. 조정수당은 급여체계 변동으로 발생할 수 있는 차액을 보전하기 위하여 지급하는 한시적 ' ,left=95 ,top=1122 ,right=1879 ,bottom=1159 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 책정된 임금은 월 만근을 전제로 한 것이며, 근태성적에 따라 일할 공제할 수 있다.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 중도 입·퇴사자의 경우 해당 월의 근무일수에 따라 일할 계산하여 지급한다. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 상기에 포함되지 않은 기타수당(자격수당, 직책수당, 직무수당 등)은 회사가 정한 별도기준에 ' ,left=69 ,top=1220 ,right=1884 ,bottom=1257 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 조의 연봉금액은 제1조의 연봉 적용기간 중이라도 승진, 강격 등 신분상의 변동이나 인사평가,' ,left=69 ,top=1315 ,right=1884 ,bottom=1352 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제4조【비밀유지】' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의하여 지급한다. ' ,left=119 ,top=1262 ,right=1879 ,bottom=1299 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='로 한다.' ,left=1445 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1249, top=452, right=1416, bottom=489 ,mask='(XX개월)', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=886, top=452, right=1212, bottom=489 ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=516, top=452, right=841, bottom=489 ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='연봉에 대한 적용기간은' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연봉제도에 동의하며 자유의사에 따라 다음과 같이 연봉계약을 체결한다.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제1조【연봉 적용기간】' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제2조【연봉금액】' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='구분' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① \'을\'의 연봉은 기본급, 시간외·휴일근로수당, 특수지수당 및 조정수당 등 각종 제 수당을 ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근로수당' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조정수당' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='연봉' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='월급여' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='현대아산(주)(이하 “갑”이라 함)와 근로자' ,left=69 ,top=278 ,right=894 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(이하 “을”이라 함)(은)는 ‘갑’의' ,left=1230 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=955, top=278, right=1204, bottom=315, face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='서울특별시 종로구 율곡로 194' ,left=463 ,top=2418 ,right=992 ,bottom=2455 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배 국 환' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>


">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 선상 연봉계약서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print2  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='연봉계약서' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='문체부 바탕체' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 갑 )' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회 사 명 :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 자 :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=466 ,top=2492 ,right=810 ,bottom=2529 ,align='left' ,face='바탕' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성    명 :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계약일자 : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='체결한 근로계약서, 취업규칙 및 관련법령에 의한다. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기준에 따른다.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(지급당일이 휴일인 경우 그 전일)에 \'을\' 본인 명의의 지정 계좌에 입금하는 방식으로 지급한다.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 당월 1일부터 말일까지를 급여산정기간으로 하며, 총 연봉의 12분의 1에 해당하는 금액을 매월 25일' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='포함하여 산출하는 포괄임금산정제로 하며, 월 급여의 구성은 아래와 같다. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'을\'은 본인의 연봉에 관하여 타인에게 알리거나 타인의 연봉을 알려고 하지 않으며, 연봉과 ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관련한 제반사항에 대한 비밀을 절대로 누설하지 않는다. 만약 연봉과 관련한 사항을 누설하는 경우 ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계 사유가 될 수 있으며, 이로 인한 불이익에 이의를 제기하지 않는다. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제3조【지급방법】' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제5조【적   용】' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 본 사항은 상기 연봉 적용기간에 한하여 적용되며, 기타 신분과 관련된 제반사항은 입사 시 ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 계약서는 기 체결한 연봉계약서상의 임금관련 내용을 대체한다. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 기본급은 법정근로시간(209시간/月)에 대한 급여이다.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 책정된 임금은 월 만근을 전제로 한 것이며, 근태성적에 따라 일할 공제할 수 있다.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 중도 입·퇴사자의 경우 해당 월의 근무일수에 따라 일할 계산하여 지급한다. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제4조【비밀유지】' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='로 한다.' ,left=1418 ,top=452 ,right=1704 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TO_YMD', left=886, top=452, right=1212, bottom=489 ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=516, top=452, right=841, bottom=489 ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='연봉에 대한 적용기간은' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연봉제도에 동의하며 자유의사에 따라 다음과 같이 연봉계약을 체결한다.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제1조【연봉 적용기간】' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제2조【연봉금액】' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='구분' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근로수당' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조정수당' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='연봉' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='월급여' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='현대아산(주)(이하 “갑”이라 함)와 근로자' ,left=69 ,top=278 ,right=826 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=828, top=278, right=1103, bottom=315, face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(이하 “을”이라 함)(은)는 ‘갑’의' ,left=1114 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1222, top=452, right=1405, bottom=489 ,mask='(XXXX개월)', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='3. 특수지수당은 북측지역에 근무한 경우 발생할 수 있는 추가적 비용을 보전하기 위하여 지급하는 ' ,left=95 ,top=1011 ,right=1879 ,bottom=1048 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 시간외수당은 月 약 43시간의 연장, 휴일, 야간근로에 대한 급여이다.' ,left=95 ,top=958 ,right=1879 ,bottom=995 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금품으로 평균급여의 포함에서 제외한다. ' ,left=135 ,top=1056 ,right=1876 ,bottom=1093 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 조정수당은 급여체계 변동으로 발생할 수 있는 차액을 보전하기 위하여 지급하는 한시적 ' ,left=93 ,top=1103 ,right=1876 ,bottom=1140 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당이다.' ,left=138 ,top=1151 ,right=1876 ,bottom=1188 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 상기에 포함되지 않은 기타수당(자격수당, 직책수당, 직무수당 등)은 회사가 정한 별도기준에 ' ,left=66 ,top=1201 ,right=1881 ,bottom=1238 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의하여 지급한다. ' ,left=122 ,top=1246 ,right=1881 ,bottom=1283 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 조의 연봉금액은 제1조의 연봉 적용기간 중이라도 승진, 강격 등 신분상의 변동이나 인사평가,' ,left=61 ,top=1296 ,right=1876 ,bottom=1334 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계, 근무지변동 등에 의해 연봉 조정사유가 있을 경우에는 취업규칙 등 회사 인사규정에 ' ,left=116 ,top=1344 ,right=1881 ,bottom=1381 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='따라 적용한다.' ,left=116 ,top=1389 ,right=1881 ,bottom=1426 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① ‘을’은 상기와 같이 책정된 연봉액에 동의하며, 상기에 명시되지 않은 내용은 ‘갑’이 정한 별도' ,left=66 ,top=2024 ,right=1894 ,bottom=2061 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=1630 ,top=2569 ,right=1701 ,bottom=2617 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2519 ,right=873 ,bottom=2693</I>
	<T>id='서울특별시 종로구 율곡로 194 ' ,left=452 ,top=2416 ,right=1003 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배 국 환' ,left=466 ,top=2569 ,right=693 ,bottom=2606 ,align='left' ,face='바탕' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 을 )' ,left=1066 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① \'을\'의 연봉은 기본급, 시간외·휴일근로수당, 특수지수당 및 조정수당 등 각종 제 수당을 ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


">
</OBJECT>



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 현장 연봉계약서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print3  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='연봉계약서' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='문체부 바탕체' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 갑 )' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회 사 명 :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 자 :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 을 )' ,left=1021 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성    명 :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계약일자 : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='체결한 근로계약서, 취업규칙 및 관련법령에 의한다. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기준에 따른다.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(지급당일이 휴일인 경우 그 전일)에 근로자 본인 명의의 지정 계좌에 입금하는 방식으로 지급한다.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 당월 1일부터 말일까지를 급여산정기간으로 하며, 총 연봉의 12분의 1에 해당하는 금액을 매월 25일' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='따라 적용한다.' ,left=116 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계, 근무지변동 등에 의해 연봉 조정사유가 있을 경우에는 취업규칙 등 회사 인사규정에 ' ,left=116 ,top=1357 ,right=1881 ,bottom=1394 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당이다.' ,left=138 ,top=1164 ,right=1876 ,bottom=1201 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금품으로 평균급여의 포함에서 제외한다. ' ,left=135 ,top=1080 ,right=1876 ,bottom=1117 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='포함하여 산출하는 포괄임금산정제로 하며, 월 급여의 구성은 아래와 같다. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'을\'은 본인의 연봉에 관하여 타인에게 알리거나 타인의 연봉을 알려고 하지 않으며, 연봉과 ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관련한 제반사항에 대한 비밀을 절대로 누설하지 않는다. 만약 연봉과 관련한 사항을 누설하는 경우 ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계 사유가 될 수 있으며, 이로 인한 불이익에 이의를 제기하지 않는다. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제3조【지급방법】' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제5조【적   용】' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① \'을\'은 상기와 같이 책정된 연봉액에 동의하며, 상기에 명시되지 않은 내용은 회사가 정한 별도 ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 본 사항은 상기 연봉 적용기간에 한하여 적용되며, 기타 신분과 관련된 제반사항은 입사 시 ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 계약서는 기 체결한 연봉계약서상의 임금관련 내용을 대체한다. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 기본급은 법정근로시간(209시간/月)에 대한 급여이다.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 시간외수당은 월 52시간의 연장·야간근로에 대한 급여이다.' ,left=95 ,top=953 ,right=1879 ,bottom=990 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 휴일근로수당은 월 27시간의 휴일근로에 대한 급여이다. ' ,left=95 ,top=995 ,right=1879 ,bottom=1032 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 특수지수당은 북측지역에 근무한 경우 발생할 수 있는 추가적 비용을 보전하기 위하여 지급하는 ' ,left=95 ,top=1037 ,right=1879 ,bottom=1074 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5. 조정수당은 급여체계 변동으로 발생할 수 있는 차액을 보전하기 위하여 지급하는 한시적 ' ,left=95 ,top=1122 ,right=1879 ,bottom=1159 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 책정된 임금은 월 만근을 전제로 한 것이며, 근태성적에 따라 일할 공제할 수 있다.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 중도 입·퇴사자의 경우 해당 월의 근무일수에 따라 일할 계산하여 지급한다. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 상기에 포함되지 않은 기타수당(자격수당, 직책수당, 직무수당 등)은 회사가 정한 별도기준에 ' ,left=69 ,top=1220 ,right=1884 ,bottom=1257 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 조의 연봉금액은 제1조의 연봉 적용기간 중이라도 승진, 강격 등 신분상의 변동이나 인사평가,' ,left=69 ,top=1315 ,right=1884 ,bottom=1352 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제4조【비밀유지】' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의하여 지급한다. ' ,left=119 ,top=1262 ,right=1879 ,bottom=1299 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='로 한다.' ,left=1445 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1249, top=452, right=1416, bottom=489 ,mask='(XX개월)', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=886, top=452, right=1212, bottom=489 ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=516, top=452, right=841, bottom=489 ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='연봉에 대한 적용기간은' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연봉제도에 동의하며 자유의사에 따라 다음과 같이 연봉계약을 체결한다.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제1조【연봉 적용기간】' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제2조【연봉금액】' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='구분' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① \'을\'의 연봉은 기본급, 시간외·휴일근로수당, 특수지수당 및 조정수당 등 각종 제 수당을 ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근로수당' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조정수당' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='연봉' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='월급여' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='현대아산(주)(이하 “갑”이라 함)와 근로자' ,left=69 ,top=278 ,right=894 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(이하 “을”이라 함)(은)는 ‘갑’의' ,left=1230 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=955, top=278, right=1204, bottom=315, face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='서울특별시 종로구 율곡로 194' ,left=463 ,top=2418 ,right=992 ,bottom=2455 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배 국 환' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>

">
</OBJECT>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--**************************************************************************************
   *                                       												 *
   *	바인딩 컴포넌트																	 *
   *                                       												 *
   ***************************************************************************************-->
<!-- T_CM_CONTRACT 설정 테이블 -->
<object id="bndT_CM_CONTRACT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_CONTRACT">
	<Param Name="BindInfo", Value="
		<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
		<C>Col=CD_GBN			Ctrl=cmbCD_GBN			Param=value</C>
		<C>Col=FROM_YMD			Ctrl=txtFROM_YMD		Param=value</C>
		<C>Col=TO_YMD			Ctrl=txtTO_YMD			Param=value</C>
		<C>Col=MONTH			Ctrl=txtMONTH			Param=value</C>
		<C>Col=P01_AMT			Ctrl=txtP01_AMT			Param=text</C>
		<C>Col=P02_AMT			Ctrl=txtP02_AMT			Param=text</C>
		<C>Col=P03_AMT			Ctrl=txtP03_AMT			Param=text</C>
		<C>Col=P04_AMT			Ctrl=txtP04_AMT			Param=text</C>
		<C>Col=P05_AMT			Ctrl=txtP05_AMT			Param=text</C>
		<C>Col=SUM_AMT			Ctrl=txtSUM_AMT			Param=text</C>
	">
</object>
	
	
	
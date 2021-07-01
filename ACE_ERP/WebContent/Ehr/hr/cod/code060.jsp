<!--
***********************************************************************
* @source      : code060.jsp
* @description : 구_급상여지급액조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/07/06      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>급여지급액조회(구)</title>
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
		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기


        var ActiveIndex = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	
            var PIS_YYMM = document.getElementById('txtPIS_YYMM_SHR').value;
        	
            if(PIS_YYMM.substring(0,4) > 2015){
            	
            	
            	alert("2015년 이전 자료만 조회 가능합니다.");
            	
            	return false;
            	
            }else{
            
            
            TabEvent(0);
            
            }
            
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

				//이곳에 해당 코딩을 입력 하세요

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

        	var PIS_YYMM = document.getElementById('txtPIS_YYMM_SHR').value;
            var ENO_NO = document.getElementById('txtENO_NO_SHR').value;
            var SAL_GBN = document.getElementById("cmbSAL_GBN_SHR").value; // 급여, 소급구분

            if(!fnc_SearchItemCheck()) return;      //검색조건 유효성 검사

            dsT_RP_REPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code060.cmd.CODE060CMD"
												            		+"&S_MODE=SHR_PRINT"
												                    +"&PIS_YY="+PIS_YYMM.substring(0,4)
												                    +"&PIS_MM="+PIS_YYMM.substring(5,7)
												            		+"&ENO_NO="+ENO_NO
												            		+"&SAL_GBN="+SAL_GBN;

            dsT_RP_REPORT.Reset();

            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code060.cmd.CODE060CMD"
													        		+"&S_MODE=SHR_PRINT2"
													                +"&PIS_YY="+PIS_YYMM.substring(0,4)
													                +"&PIS_MM="+PIS_YYMM.substring(5,7)
													        		+"&ENO_NO="+ENO_NO
													        		+"&SAL_GBN="+SAL_GBN;

			dsT_RP_REPORT2.Reset();            

            dsT_RP_REPORT3.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code060.cmd.CODE060CMD"
													        		+"&S_MODE=SHR_PRINT3"
													                +"&PIS_YY="+PIS_YYMM.substring(0,4)
													                +"&PIS_MM="+PIS_YYMM.substring(5,7)
													        		+"&ENO_NO="+ENO_NO
													        		+"&SAL_GBN="+SAL_GBN;

			dsT_RP_REPORT3.Reset();              
            
            
			//var ls_temp = "CUDATE:STRING,CTITLE:STRING";

			//dsT_RP_REPORT.SetDataHeader(ls_temp);
			//dsT_RP_REPORT.Addrow();
			//dsT_RP_REPORT.namevalue(1,"CUDATE")=gcurdate;


			//var yyyy = PIS_YYMM.substring(0,4);
			//var mm = PIS_YYMM.substring(5,7);

			//dsT_RP_REPORT.namevalue(1,"CTITLE")= " 급여명세서 [" + yyyy + "년" + mm + "월]";            
            
			gcrp_print.Preview();  
			
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

			//이곳에 해당 코딩을 입력 하세요

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


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_yymm = document.getElementById("txtPIS_YYMM_SHR");
            var eno_no = document.getElementById('txtENO_NO_SHR');

            if(pis_yymm.value == "" || pis_yymm.value.length < 7){
                alert("YYYY-MM 형태의 해당년월을 입력하세요!");
                pis_yymm.focus();
                return false;
            }
            
            if(eno_no.value == ""){
                alert("사번을 입력하세요!");
                eno_no.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_ChangeGrid(1);      //그리드 변경 처리

			cfStyleGrid_New(form1.grdT_CP_PAYMASTER_01,0,"false","false");      // Grid Style 적용

			document.getElementById("btn4").style.display = "";
			document.getElementById("btn5").style.display = "none";

            document.getElementById('txtENO_NO_SHR').value = gusrid;
            document.getElementById('txtENO_NM_SHR').value =gusrnm;
            document.getElementById('txtENO_NO').value = gusrid;
            document.getElementById('txtENO_NM').value = gusrnm;
            

		    //관리자 권한일 경우
		    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003" || gusrid == "2140002") {

	            fnc_ShowElement("eno_no");
	            fnc_ShowElement("eno_no_shr");

    		}

            document.getElementById('txtPIS_YYMM_SHR').value = gcurdate.substring(0,7);
            document.getElementById('txtPIS_YYMM_SHR').focus();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid(kind) {

			if(kind == '1'){

				document.getElementById("divCODE060_01").style.display = "";
				document.getElementById("divCODE060_03").style.display = "none";
				document.getElementById("divCODE060_04").style.display = "none";

            }else if(kind == '2'){

					document.getElementById("divCODE060_01").style.display = "none";
					document.getElementById("divCODE060_03").style.display = "";
					document.getElementById("divCODE060_04").style.display = "none";

            }else if(kind == '3'){
         	
					document.getElementById("divCODE060_01").style.display = "none";
					document.getElementById("divCODE060_03").style.display = "none";
					document.getElementById("divCODE060_04").style.display = "";

            }

		}

        /********************************
         * 17. 탭버튼 클릭에 따른 처리  *
         *******************************/
		function fnc_TabOnClick(kind) {

            var pis_yymm = document.getElementById('txtPIS_YYMM_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_gbn = document.getElementById("cmbSAL_GBN_SHR").value; // 급여, 소급구분
            var shr = "";
			

            
            if(kind == 1){
                shr = "SHR_01";
            }else if(kind == 2){
                shr = "SHR_02";
            }else if(kind == 3){
                shr = "SHR_03";
            }

            if(!fnc_SearchItemCheck()) return;      //검색조건 유효성 검사

			//개인정보 조회
   			dsT_CP_PAYMASTER_01.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code060.cmd.CODE060CMD"
				                                       + "&S_MODE=SHR"
				                                       + "&PIS_YY="+pis_yymm.substring(0,4)
				                                       + "&PIS_MM="+pis_yymm.substring(5,7)
				                                       + "&ENO_NO="+eno_no
				                                       + "&SAL_GBN="+sal_gbn;

    		dsT_CP_PAYMASTER_01.reset();

			//그리드 조회
			dsT_CP_PAYMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code060.cmd.CODE060CMD"
					                                    + "&S_MODE="+shr
					                                    + "&PIS_YY="+pis_yymm.substring(0,4)
					                                    + "&PIS_MM="+pis_yymm.substring(5,7)
					                                    + "&ENO_NO="+eno_no
					                                    + "&SAL_GBN="+sal_gbn;
			//prompt(this, dsT_CP_PAYMASTER.dataid);
    		dsT_CP_PAYMASTER.reset();

            if(kind == 1){
                //기타수당이 0 이 아닐때만 보여준다.
                if(parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTH_AMT')) != 0){
                    document.getElementById("btn4").style.display = "";
                }else{
                    document.getElementById("btn4").style.display = "none";
                }

                document.getElementById("btn5").style.display = "none";

            }else if(kind == 2){

                document.getElementById("btn4").style.display = "none";

                //기타공제액이 0 이 아닐때만 보여준다.
                if( parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTH_DED')) != 0){
                    document.getElementById("btn5").style.display = "";
                }else{
                    document.getElementById("btn5").style.display = "none";
                }

            }else if(kind == 3){
                document.getElementById("btn4").style.display = "none";
                document.getElementById("btn5").style.display = "none";
            }

            fnc_ChangeGrid(kind);       //그리드 변경 처리

		}



        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {
        	
            ActiveIndex = idx+1;

            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=3; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "../../images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "../../images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "../../images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "../../images/common/tab25Right.gif";
            
            fnc_TabOnClick(ActiveIndex);
        }





		function fnc_code061Popup(kind){
			
			if(dsT_CP_PAYMASTER.countrow == 0 ){
				alert("조회를 먼저 실행해주세요.");
				return false;
			}

			window.showModalDialog("../../../Ehr/hr/cod/code061.jsp", dsT_CP_PAYMASTER, "dialogWidth:510px; dialogHeight:400px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_PAYMASTER)|
    | 3. 사용되는 Table List(T_CP_PAYMASTER)		 |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_PAYMASTER)|
    | 3. 사용되는 Table List(T_CP_PAYMASTER)		 |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_PAYMASTER)|
    | 3. 사용되는 Table List(T_CP_PAYMASTER)		 |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 레포트용 DataSet                     		|
    | 2. 이름 : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>
    
    <Object ID="dsT_RP_REPORT4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

	        var kind = dsT_CP_PAYMASTER.NameValue(1,'KIND');
	        var tot_amt = 0;

        	if(kind == '1'){
        		
        		tot_amt = parseInt(dsT_CP_PAYMASTER.NameValue(1,'P01_AMT')) + parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTH_AMT'));

				if(tot_amt == 0){
					
					fnc_Message(document.getElementById("resultMessage"), "MSG_02");
					
				}else{
					
					fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
					
				}

        	}else if(kind == '2'){
        		
				tot_amt = parseInt(dsT_CP_PAYMASTER.NameValue(1,'INCM_TAX')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'CITI_TAX')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'DRE_INTX')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'DRE_CTTX')) +
                    parseInt(dsT_CP_PAYMASTER.NameValue(1,'DRE_DFTX'));


				if(tot_amt == 0){
					
					fnc_Message(document.getElementById("resultMessage"), "MSG_02");
					
				}else{
					
					fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
					
				}

        	}else{
        		
				fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
				
        	}

        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {


        } else {

			//누계조회
			var PIS_YY = dsT_CP_PAYMASTER_01.NameValue(1,"PIS_YY");
			var PIS_MM = dsT_CP_PAYMASTER_01.NameValue(1,"PIS_MM");
			var ENO_NO = dsT_CP_PAYMASTER_01.NameValue(1,"ENO_NO");
			var SAL_GBN = dsT_CP_PAYMASTER_01.NameValue(1,"SAL_GBN");


			dsT_CP_PAYMASTER_02.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code060.cmd.CODE060CMD"
				                                       + "&S_MODE=SHR_05"
				                                       + "&PIS_YY="+PIS_YY
				                                       + "&PIS_MM="+PIS_MM
				                                       + "&ENO_NO="+ENO_NO
				                                       + "&SAL_GBN="+SAL_GBN;
			//prompt(this, dsT_CP_PAYMASTER_02.dataid);
    		dsT_CP_PAYMASTER_02.reset();

        }

    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="100"></col>
									<col width="100"></col>
									<col width="100"></col>
									<col width="100"></col>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">해당년월&nbsp;</td>
								<td class="padding2423">
									<input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13){fnc_SearchList();}cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();}">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','10','116');"></a>
								</td>
								<td align="right" class="searchState">구&nbsp;&nbsp;분&nbsp;</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="WIDTH:150" onchange="fnc_SearchList()">
										<option value="0" >급  여</option>
	                                    <option value="2" >소  급</option>
									</select>
								</td>
                             
                                <td align="right" class="searchState"><div id="eno_no" style="display:none">사 번&nbsp;</div></td>
                                <td class="padding2423">
                                <div id="eno_no_shr" style="display:none">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                                </td>                             
                                </div>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="126"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">사 번</td>
                    <td class="padding2423">
                        <input type=hidden id="REG_NO">
                        <input id="txtENO_NO" style="width:100%;border-width:0;" readonly>
                    </td>
                    <td align="center" class="blueBold">성 명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" style="width:100%;border-width:0;" readonly>
                    </td>
                    <td align="center" class="blueBold">직위 </td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%;border-width:0;" readonly>
                    </td>
                    <td align="center" class="blueBold">계좌번호</td>
                    <td class="padding2423">
                        <input id="txtACC_NO" style="width:100%;border-width:0;" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">부양코드</td>
                    <td class="padding2423">
                        <input id="txtSOU_CNT" size="1" readonly>
                        <input id="txtDFM_CNT" size="1" readonly>
                        <input id="txtTRB_CNT" size="1" readonly>
                        <input id="txtGOL_CNT" size="1" readonly>
                        <input id="txtWCT_CNT" size="1" readonly>
                        <input id="txtCHI_CNT" size="1" readonly>
                    </td>
                    <td align="center" class="blueBold">총지급액</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSALT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
							<param name=Enable					value=true>
							<param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="blueBold">공제계</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSUM_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="blueBold">실수령액</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->



<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0" >
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


<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>

        <td align="left">

            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="120">
                        <!-- 탭오버 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../..../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">지급내역</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>                            
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">일반공제내역</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">저축/대출내역</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn4','','../../images/button/btn_EtcSalaryOver.gif',1)"><img src="../../images/button/btn_EtcSalaryOn.gif" name="btn4" border="0" align="absmiddle" onClick="fnc_code031Popup(1)"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn5','','../../images/button/btn_EtcSalaryOver.gif',1)"><img src="../../images/button/btn_EtcSalaryOn.gif" name="btn5" border="0" align="absmiddle" onClick="fnc_code031Popup(2)"></a>
        </td>
    </tr>
    <tr>
        <td colspan="2">

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
            <!-- 탭버튼테이블 끝 -->

        </td>
    </tr>
</table>







<!-- 내용 조회 그리드 테이블 시작-->
<div id="divCODE060_01" style="position:absolute; left:20; top:270; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="190"></col>
                    <col width="190"></col>
                    <col width="190"></col>
                    <col width="190"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">기본급</td>
                    <td align="center" class="blueBold">시간외</td>
                    <td align="center" class="blueBold">휴일근무수당</td>
                    <td align="center" class="blueBold">특수지수당</td>
                    <td align="center" class="blueBold">조정수당</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medP01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medP02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medP03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medP04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medP05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">개인연금</td>
                    <td align="center" class="blueBold">현장직책수당</td>
                    <td align="center" class="blueBold">식대</td>
                    <td align="center" class="blueBold">자격수당</td>
                    <td align="center" class="blueBold">출납수당</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPPEN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDUTY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medMEAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medCET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medCASH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">차량유지비</td>
                    <td align="center" class="blueBold">운전수당</td>
                    <td align="center" class="blueBold">사장단수당</td>
                    <td align="center" class="blueBold">학자금</td>
                    <td align="center" class="blueBold">현지체류비</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medCAR_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDRI_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medBOSS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSCH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSTAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>

                <tr>
                    <td align="center" class="blueBold">기타지불</td>
                    <td align="center" class="blueBold"></td>
                    <td align="center" class="blueBold"></td>
                    <td align="center" class="blueBold"></td>
                    <td align="center" class="blueBold"></td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medOTH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                    </td>
                     <td class="padding2423">
                    </td>
                     <td class="padding2423">
                    </td>
                     <td class="padding2423">
                    </td>
                </tr>


			</table>
		</td>
	</tr>
</table>
</div>


<div id="divCODE060_03" style="position:absolute; left:20; top:270; width:1000; height:240; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="190"></col>
                    <col width="190"></col>
                    <col width="190"></col>
                    <col width="190"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">소득세</td>
                    <td align="center" class="blueBold">주민세</td>
                    <td align="center" class="blueBold">국민연금</td>
                    <td align="center" class="blueBold">건강보험</td>
                    <td align="center" class="blueBold">노인장기요양보험</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medINCM_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medCITI_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medNPEN_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medHINU_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medOLD_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">고용보험</td>
                    <td align="center" class="blueBold">공조회비</td>
                    <td align="center" class="blueBold">개인연금</td>
                    <td align="center" class="blueBold">보증보험</td>
                    <td align="center" class="blueBold">복지카페</td>
                </tr>
                <tr height="28">
                	 <td class="padding2423">
						<comment id="__NSID__"><object id="medHINS_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medDHLP_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPPEN_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medLAB_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medO7_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">정산건강보험</td>
                    <td align="center" class="blueBold">정산고용보험</td>
                    <td align="center" class="blueBold">대출상환금</td>
                    <td align="center" class="blueBold">대출상환이자</td>
                    <td align="center" class="blueBold">통근버스</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHINU_CAL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medHINS_CAL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medLON_RPY" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medLON_INT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                     <td class="padding2423">
                        <comment id="__NSID__"><object id="medBUS_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>


                <tr>
                    <td align="center" class="blueBold">연말정산소득세</td>
                    <td align="center" class="blueBold">연말정산주민세</td>
                    <td align="center" class="blueBold">연말정산농특세</td>
                    <td align="center" class="blueBold">체력단련실</td>
                    <td align="center" class="blueBold">기타공제</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medDRE_INTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDRE_CTTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                     <td class="padding2423">
						<comment id="__NSID__"><object id="medDRE_DFTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                     <td class="padding2423">
						<comment id="__NSID__"><object id="medGIM_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                     <td class="padding2423">
						<comment id="__NSID__"><object id="medOTH_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>

			</table>
		</td>
	</tr>




</table>
</div>

<div id="divCODE060_04" style="position:absolute; left:20; top:270; width:1000; height:170; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:160px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='BNK_NM'	 		width=100	name='저축종류'		align=left </C>
	                            <C> id='SAV_NM'		 	width=150	name='은행'				align=center </C>
	                            <C> id='GUBUN'		 	width=100	name='구분'				align=center </C>
	                            <C> id='DUE_YMD'	 	width=150	name='만기일'			align=center </C>
	                            <C> id='CONM_AMT'	 	width=150	name='당월불입액'		align=right </C>
	                            <C> id='SUMP_CNT'	 	width=100	name='횟수'				align=right </C>
	                            <C> id='SUM_SAV'	 		width=100	name='누계액'			align=right </C>
	                            <C> id='GMK_BAK'	 		width=100	name='대출금잔액'		align=right </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="divCODE060_03" style="position:absolute; left:20; top:550; width:1000; height:170; z-index:1;" >
<table width="1000"  border="0" cellspacing="0" cellpadding="0">
     <tr>
         <td width="120">
             <!-- 탭오버 -->
             <table width="120" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25"  ></td>
                     <td align="center" class="overMenu25"  style="cursor:hand"  >년도누계</td>
                     <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" ></td>
                 </tr>
             </table>
         </td>
     </tr>
	 <tr>
        <td colspan="6">

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
            <!-- 탭버튼테이블 끝 -->

        </td>
    </tr>
 </table>
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="126"></col>
                    <col width="125"></col>
                    <col width="125"></col>
                    <col width="125"></col>
                    <col width="124"></col>
                    <col width="124"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold"  >실수령액</td>
                    <td align="center" class="padding2423"  colspan="5">
                    	<comment id="__NSID__"><object id="medPAY_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma				value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">총소득</td>
                    <td align="center" class="blueBold">소득세</td>
                    <td align="center" class="blueBold">주민세</td>
                    <td align="center" class="blueBold">국민연금</td>
                    <td align="center" class="blueBold">건강보험</td>
                    <td align="center" class="blueBold">고용보험</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSALT_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma				value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medINCM_TAX_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma				value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCITI_TAX_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  	value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  	value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 	value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medNPEN_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode					value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHINU_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  	value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHINS_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    			VALUE="dsT_RP_REPORT2">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="0">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" 						VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=132
	<R>id='급여지급현황.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,MasterDataID='dsT_RP_REPORT'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1929 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='현대아산 주식회사' ,left=688 ,top=93 ,right=1474 ,bottom=212 ,face='굴림' ,size=25 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=29 ,top=500 ,right=29 ,bottom=1011 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=29 ,top=500 ,right=1939 ,bottom=500 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=140 ,top=500 ,right=140 ,bottom=1011 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=439 ,top=500 ,right=439 ,bottom=1011 </L>
			<L> left=738 ,top=500 ,right=738 ,bottom=1011 </L>
			<L> left=1040 ,top=500 ,right=1040 ,bottom=1011 </L>
			<L> left=1339 ,top=500 ,right=1339 ,bottom=1011 </L>
			<L> left=1638 ,top=500 ,right=1638 ,bottom=1011 </L>
			<L> left=1939 ,top=500 ,right=1939 ,bottom=1011 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=29 ,top=439 ,right=1939 ,bottom=439 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=474 ,right=16 ,bottom=1080 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1963 ,top=474 ,right=1963 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=29 ,top=291 ,right=29 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=474 ,right=1963 ,bottom=474 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='소속 :' ,left=56 ,top=368 ,right=198 ,bottom=429 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='사번 :' ,left=56 ,top=296 ,right=198 ,bottom=357 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='지급일 :' ,left=831 ,top=373 ,right=992 ,bottom=434 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='직위 :' ,left=831 ,top=304 ,right=995 ,bottom=362 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='       성명 :' ,left=1349 ,top=302 ,right=1566 ,bottom=362 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=29 ,top=291 ,right=1939 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1939 ,top=291 ,right=1939 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='기 본 급' ,left=164 ,top=511 ,right=421 ,bottom=572 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='시간외수당' ,left=466 ,top=511 ,right=722 ,bottom=572 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='휴일근무수당' ,left=765 ,top=511 ,right=1021 ,bottom=569 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='조정수당' ,left=1363 ,top=511 ,right=1619 ,bottom=569 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='특수지수당' ,left=1064 ,top=511 ,right=1320 ,bottom=572 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='자격수당' ,left=1656 ,top=511 ,right=1913 ,bottom=569 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=140 ,top=579 ,right=1939 ,bottom=579 </L>
			<L> left=143 ,top=667 ,right=1939 ,bottom=667 </L>
			<T>id='차량유지비' ,left=164 ,top=683 ,right=421 ,bottom=741 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='식 대' ,left=460 ,top=683 ,right=717 ,bottom=741 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='현지체류비' ,left=762 ,top=683 ,right=1019 ,bottom=743 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='운전수당' ,left=1061 ,top=683 ,right=1318 ,bottom=743 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='사장단수당' ,left=1365 ,top=683 ,right=1622 ,bottom=743 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='현장직책수당' ,left=1662 ,top=683 ,right=1918 ,bottom=743 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=140 ,top=757 ,right=1939 ,bottom=757 </L>
			<L> left=140 ,top=841 ,right=1939 ,bottom=841 </L>
			<T>id='개인연금' ,left=460 ,top=852 ,right=717 ,bottom=905 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='출납수당' ,left=161 ,top=849 ,right=418 ,bottom=908 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=140 ,top=923 ,right=1934 ,bottom=923 </L>
			<T>id='기타지불' ,left=1069 ,top=855 ,right=1326 ,bottom=908 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='학자금' ,left=762 ,top=852 ,right=1019 ,bottom=915 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=29 ,top=1011 ,right=1937 ,bottom=1011 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='지급총액 : ' ,left=151 ,top=1016 ,right=407 ,bottom=1077 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=16 ,top=1082 ,right=1961 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='지급' ,left=37 ,top=632 ,right=135 ,bottom=693 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='내역' ,left=37 ,top=826 ,right=135 ,bottom=886 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='공제' ,left=37 ,top=1326 ,right=135 ,bottom=1386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='내역' ,left=37 ,top=1614 ,right=135 ,bottom=1675 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=16 ,top=1921 ,right=1963 ,bottom=1921 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='공제금액 : ' ,left=159 ,top=1849 ,right=415 ,bottom=1913 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=29 ,top=1844 ,right=1939 ,bottom=1844 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='복지카페' ,left=167 ,top=1675 ,right=423 ,bottom=1738 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타공제' ,left=466 ,top=1680 ,right=722 ,bottom=1741 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=143 ,top=1749 ,right=1939 ,bottom=1749 </L>
			<L> left=140 ,top=1667 ,right=1937 ,bottom=1667 </L>
			<L> left=140 ,top=1574 ,right=1939 ,bottom=1574 </L>
			<T>id='체력단련실' ,left=1646 ,top=1495 ,right=1937 ,bottom=1561 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='연말정산농특세' ,left=1344 ,top=1495 ,right=1635 ,bottom=1561 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='연말정산주민세' ,left=1045 ,top=1495 ,right=1336 ,bottom=1561 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='대출상환이자' ,left=463 ,top=1495 ,right=720 ,bottom=1558 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='연말정산소득세' ,left=749 ,top=1495 ,right=1035 ,bottom=1561 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='대출상환금' ,left=164 ,top=1495 ,right=421 ,bottom=1556 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=140 ,top=1487 ,right=1939 ,bottom=1487 </L>
			<L> left=140 ,top=1397 ,right=1939 ,bottom=1397 </L>
			<T>id='고용보험정산' ,left=1363 ,top=1320 ,right=1619 ,bottom=1389 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='통근버스' ,left=1667 ,top=1320 ,right=1924 ,bottom=1389 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='건강보험정산' ,left=1064 ,top=1320 ,right=1320 ,bottom=1389 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='보증보험' ,left=765 ,top=1320 ,right=1021 ,bottom=1389 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='개인연금공제' ,left=460 ,top=1320 ,right=717 ,bottom=1386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='공조회비' ,left=159 ,top=1320 ,right=415 ,bottom=1386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=140 ,top=1312 ,right=1939 ,bottom=1312 </L>
			<T>id='고용보험' ,left=1667 ,top=1154 ,right=1924 ,bottom=1217 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='노인요양보험' ,left=1368 ,top=1154 ,right=1625 ,bottom=1217 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='건강보험' ,left=1064 ,top=1154 ,right=1320 ,bottom=1217 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='국민연금' ,left=765 ,top=1154 ,right=1021 ,bottom=1214 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세' ,left=460 ,top=1154 ,right=717 ,bottom=1217 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='소득세' ,left=161 ,top=1154 ,right=418 ,bottom=1217 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=140 ,top=1225 ,right=1937 ,bottom=1225 </L>
			<L> left=16 ,top=1130 ,right=1963 ,bottom=1130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1963 ,top=1130 ,right=1963 ,bottom=1921 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=29 ,top=1148 ,right=1939 ,bottom=1148 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1939 ,top=1148 ,right=1939 ,bottom=1844 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1640 ,top=1148 ,right=1640 ,bottom=1844 </L>
			<L> left=1339 ,top=1148 ,right=1339 ,bottom=1844 </L>
			<L> left=1040 ,top=1148 ,right=1040 ,bottom=1844 </L>
			<L> left=741 ,top=1148 ,right=741 ,bottom=1844 </L>
			<L> left=439 ,top=1148 ,right=439 ,bottom=1844 </L>
			<L> left=140 ,top=1148 ,right=140 ,bottom=1844 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=1132 ,right=16 ,bottom=1921 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=29 ,top=1148 ,right=29 ,bottom=1844 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<I>id='../../images/common/hd_ci_1.jpg' ,left=542 ,top=95 ,right=683 ,bottom=212</I>
			<C>id='ENO_NO', left=206, top=299, right=418, bottom=357, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOB_NM', left=1000, top=304, right=1212, bottom=362, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ENO_NM', left=1572, top=302, right=1783, bottom=360, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PAY_YMD', left=1000, top=373, right=1212, bottom=431, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DPT_NM', left=206, top=370, right=818, bottom=429, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='실수령액 :' ,left=1349 ,top=370 ,right=1566 ,bottom=431 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='PAY_AMT', left=1569, top=370, right=1781, bottom=429, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id=' 급여명세서' ,left=1103 ,top=214 ,right=1400 ,bottom=275 ,face='HY중고딕' ,size=15 bold=true, ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='TITLE', left=648, top=214, right=1098, bottom=275, align='right', face='HY중고딕', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='{decode(P01_AMT,0,,P01_AMT)}', left=180, top=593, right=415, bottom=651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(P03_AMT,0,,P03_AMT)}', left=783, top=595, right=1019, bottom=654, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(P04_AMT,0,,P04_AMT)}', left=1082, top=595, right=1318, bottom=654, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(P02_AMT,0,,P02_AMT)}', left=479, top=595, right=714, bottom=654, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(P05_AMT,0,,P05_AMT)}', left=1381, top=595, right=1617, bottom=654, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(CET_AMT,0,,CET_AMT)}', left=1677, top=595, right=1913, bottom=654, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(CAR_AMT,0,,CAR_AMT)}', left=183, top=770, right=418, bottom=828, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(MEAL_AMT,0,,MEAL_AMT)}', left=479, top=770, right=714, bottom=828, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(STAY_AMT,0,,STAY_AMT)}', left=783, top=770, right=1019, bottom=828, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(DRI_AMT,0,,DRI_AMT)}', left=1082, top=770, right=1318, bottom=828, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(BOSS_AMT,0,,BOSS_AMT)}', left=1386, top=770, right=1622, bottom=828, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(DUTY_AMT,0,,DUTY_AMT)}', left=1685, top=770, right=1921, bottom=828, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(CASH_AMT,0,,CASH_AMT)}', left=177, top=937, right=413, bottom=995, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(SCH_AMT,0,,SCH_AMT)}', left=781, top=939, right=1016, bottom=997, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(PPEN_AMT,0,,PPEN_AMT)}', left=482, top=939, right=717, bottom=997, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(OTH_AMT,0,,OTH_AMT)}', left=1087, top=937, right=1323, bottom=995, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(SALT_AMT,0,,SALT_AMT)}', left=434, top=1016, right=709, bottom=1074, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=177, top=1241, right=413, bottom=1299, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=479, top=1241, right=714, bottom=1299, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(NPEN_DED,0,,NPEN_DED)}', left=778, top=1241, right=1013, bottom=1299, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(HINU_DED,0,,HINU_DED)}', left=1082, top=1241, right=1318, bottom=1299, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(OLD_DED,0,,OLD_DED)}', left=1384, top=1241, right=1619, bottom=1299, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(HINS_DED,0,,HINS_DED)}', left=1683, top=1241, right=1918, bottom=1299, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(DHLP_DED,0,,DHLP_DED)}', left=180, top=1410, right=415, bottom=1468, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(PPEN_DED,0,,PPEN_DED)}', left=482, top=1410, right=717, bottom=1468, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(LAB_DED,0,,LAB_DED)}', left=781, top=1413, right=1016, bottom=1471, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(HINU_CAL,0,,HINU_CAL)}', left=1082, top=1413, right=1318, bottom=1471, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(HINS_CAL,0,,HINS_CAL)}', left=1381, top=1413, right=1617, bottom=1471, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(BUS_DED,0,,BUS_DED)}', left=1685, top=1413, right=1921, bottom=1471, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(LON_RPY,0,,LON_RPY)}', left=180, top=1593, right=415, bottom=1651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(LON_INT,0,,LON_INT)}', left=482, top=1593, right=717, bottom=1651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(DRE_INTX,0,,DRE_INTX)}', left=783, top=1593, right=1019, bottom=1651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(DRE_CTTX,0,,DRE_CTTX)}', left=1082, top=1593, right=1318, bottom=1651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(DRE_DFTX,0,,DRE_DFTX)}', left=1384, top=1593, right=1619, bottom=1651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(GIM_DED,0,,GIM_DED)}', left=1683, top=1593, right=1918, bottom=1651, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(O7_DED,0,,O7_DED)}', left=180, top=1767, right=415, bottom=1826, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(OTH_DED,0,,OTH_DED)}', left=479, top=1767, right=714, bottom=1826, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{decode(SUM_DED,0,,SUM_DED)}', left=431, top=1852, right=667, bottom=1910, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=133
	<R>id='대출저축현황.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='dsT_RP_REPORT2' 
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=161 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='만기일' ,left=857 ,top=82 ,right=1050 ,bottom=146 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='당월불입액' ,left=1106 ,top=82 ,right=1326 ,bottom=146 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1728 ,top=74 ,right=1728 ,bottom=159 </L>
			<T>id='대출금잔액' ,left=1733 ,top=85 ,right=1955 ,bottom=148 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='누계액' ,left=1535 ,top=82 ,right=1701 ,bottom=146 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='횟수' ,left=1352 ,top=85 ,right=1490 ,bottom=148 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='구분' ,left=640 ,top=85 ,right=810 ,bottom=148 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='은 행' ,left=373 ,top=85 ,right=606 ,bottom=148 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='저 축 종 류' ,left=50 ,top=85 ,right=307 ,bottom=148 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=336 ,top=74 ,right=336 ,bottom=159 </L>
			<L> left=16 ,top=74 ,right=1961 ,bottom=74 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='* 저축 / 대출내역' ,left=37 ,top=0 ,right=407 ,bottom=64 ,align='left', face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=16 ,top=159 ,right=1964 ,bottom=159, penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=74 ,right=16 ,bottom=159 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1963 ,top=74 ,right=1963 ,bottom=159 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=630 ,top=74 ,right=630 ,bottom=159 </L>
			<L> left=820 ,top=74 ,right=820 ,bottom=161 </L>
			<L> left=1087 ,top=74 ,right=1087 ,bottom=159 </L>
			<L> left=1339 ,top=74 ,right=1339 ,bottom=159 </L>
			<L> left=1500 ,top=74 ,right=1500 ,bottom=159 </L>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=87 ,face='Tahoma' ,size=10 ,penwidth=1
			<C>id='SUMP_CNT', left=1352, top=13, right=1492, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CONM_AMT', left=1106, top=13, right=1328, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DUE_YMD', left=844, top=13, right=1066, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='GUBUN', left=646, top=16, right=812, bottom=74, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1963 ,top=0 ,right=1963 ,bottom=87 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1500 ,top=0 ,right=1500 ,bottom=87 </L>
			<L> left=1339 ,top=0 ,right=1339 ,bottom=87 </L>
			<L> left=1087 ,top=0 ,right=1087 ,bottom=87 </L>
			<L> left=820 ,top=0 ,right=820 ,bottom=87 </L>
			<L> left=630 ,top=0 ,right=630 ,bottom=87 </L>
			<C>id='BNK_NM', left=37, top=16, right=312, bottom=74, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SAV_NM', left=344, top=16, right=619, bottom=74, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=16 ,top=87 ,right=1961 ,bottom=87 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=0 ,right=16 ,bottom=87 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=336 ,top=0 ,right=336 ,bottom=87 </L>
			<C>id='GMK_BAK', left=1746, top=11, right=1953, bottom=69, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SUM_SAV', left=1513, top=11, right=1720, bottom=69, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1728 ,top=0 ,right=1728 ,bottom=87 </L>
		</B>
	</R>
</A>


<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=141
	<R>id='누계현황.sbt' ,left=0 ,top=8 ,right=2000 ,bottom=140 ,DetailDataID='dsT_RP_REPORT3' 
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=434 ,face='Tahoma' ,size=10 ,penwidth=1
			<L> left=16 ,top=95 ,right=16 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1963 ,top=93 ,right=1963 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=183 ,right=1963 ,bottom=183 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='고용보험 계' ,left=1670 ,top=106 ,right=1961 ,bottom=169 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='건강보험 계' ,left=1349 ,top=106 ,right=1654 ,bottom=169 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='국민연금 계' ,left=1027 ,top=106 ,right=1331 ,bottom=169 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세 계' ,left=699 ,top=106 ,right=1003 ,bottom=169 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='소득세 계' ,left=368 ,top=106 ,right=672 ,bottom=169 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='총소득' ,left=29 ,top=103 ,right=347 ,bottom=167 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1339 ,top=93 ,right=1339 ,bottom=262 </L>
			<L> left=1662 ,top=95 ,right=1662 ,bottom=265 </L>
			<L> left=1016 ,top=93 ,right=1016 ,bottom=262 </L>
			<L> left=357 ,top=93 ,right=357 ,bottom=262 </L>
			<L> left=680 ,top=95 ,right=680 ,bottom=265 </L>
			<L> left=16 ,top=262 ,right=1961 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=16 ,top=95 ,right=1961 ,bottom=95 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='* 누계내역' ,left=37 ,top=16 ,right=407 ,bottom=79 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='SALT_SUM', left=50, top=193, right=339, bottom=251, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='INCM_SUM', left=378, top=193, right=667, bottom=251, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CITI_SUM', left=706, top=193, right=995, bottom=251, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='NPEN_SUM', left=1035, top=193, right=1323, bottom=251, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='HINU_SUM', left=1360, top=193, right=1648, bottom=251, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='HINS_SUM', left=1670, top=193, right=1958, bottom=251, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='귀하의 노고에 감사드리며 한달동안 수고많으셨습니다.' ,left=471 ,top=273 ,right=1482 ,bottom=336 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<I>id='../../../Common/img/icon.jpg' ,left=767 ,top=339 ,right=1180 ,bottom=431</I>
		</B>
	</R>
</A>





">
</OBJECT>







</body>
</html>



<!-- 급여 MASTER 테이블 -->
<object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_PAYMASTER">
    <Param Name="BindInfo", Value='
        <C> Col=P01_AMT      Ctrl=medP01_AMT       Param=text  </C>
        <C> Col=P02_AMT      Ctrl=medP02_AMT       Param=text  </C>
        <C> Col=P03_AMT      Ctrl=medP03_AMT       Param=text  </C>
        <C> Col=P04_AMT      Ctrl=medP04_AMT       Param=text  </C>
        <C> Col=P05_AMT      Ctrl=medP05_AMT       Param=text  </C>
        <C> Col=CET_AMT      Ctrl=medCET_AMT       Param=text  </C>
        <C> Col=CASH_AMT     Ctrl=medCASH_AMT  	   Param=text  </C>
        <C> Col=CAR_AMT      Ctrl=medCAR_AMT   	   Param=text  </C>
        <C> Col=MEAL_AMT     Ctrl=medMEAL_AMT      Param=text  </C>
        <C> Col=STAY_AMT     Ctrl=medSTAY_AMT      Param=text  </C>
        <C> Col=DRI_AMT      Ctrl=medDRI_AMT       Param=text  </C>
        <C> Col=BOSS_AMT     Ctrl=medBOSS_AMT      Param=text  </C>
        <C> Col=DUTY_AMT     Ctrl=medDUTY_AMT      Param=text  </C>
        <C> Col=PPEN_AMT     Ctrl=medPPEN_AMT      Param=text  </C>
        <C> Col=SCH_AMT      Ctrl=medSCH_AMT       Param=text  </C>
        <C> Col=OTH_AMT      Ctrl=medOTH_AMT       Param=text  </C>
        <C> Col=SALT_AMT     Ctrl=medSALT_AMT      Param=text  </C>

        <C> Col=INCM_TAX      Ctrl=medINCM_TAX      Param=text  </C>
        <C> Col=CITI_TAX      Ctrl=medCITI_TAX      Param=text  </C>
        <C> Col=HINU_DED      Ctrl=medHINU_DED      Param=text  </C>
        <C> Col=OLD_DED       Ctrl=medOLD_DED       Param=text  </C>
        <C> Col=NPEN_DED      Ctrl=medNPEN_DED      Param=text  </C>
        <C> Col=HINS_DED      Ctrl=medHINS_DED      Param=text  </C>
        <C> Col=DHLP_DED      Ctrl=medDHLP_DED      Param=text  </C>
        <C> Col=LAB_DED       Ctrl=medLAB_DED       Param=text  </C>
        <C> Col=PPEN_DED      Ctrl=medPPEN_DED      Param=text  </C>
        <C> Col=LON_RPY       Ctrl=medLON_RPY       Param=text  </C>
        <C> Col=LON_INT       Ctrl=medLON_INT       Param=text  </C>
        <C> Col=O7_DED        Ctrl=medO7_DED        Param=text  </C>
        <C> Col=BUS_DED       Ctrl=medBUS_DED       Param=text  </C>
        <C> Col=GIM_DED       Ctrl=medGIM_DED       Param=text  </C>
        <C> Col=OTH_DED       Ctrl=medOTH_DED       Param=text  </C>
        <C> Col=DRE_INTX      Ctrl=medDRE_INTX      Param=text  </C>
        <C> Col=DRE_CTTX      Ctrl=medDRE_CTTX      Param=text  </C>
        <C> Col=DRE_DFTX      Ctrl=medDRE_DFTX      Param=text  </C>
        <C> Col=HINS_CAL      Ctrl=medHINS_CAL      Param=text  </C>
        <C> Col=HINU_CAL      Ctrl=medHINU_CAL      Param=text  </C>

    '>
</object>


<!-- 급여 MASTER 테이블 -->
<object id="bndT_CP_PAYMASTER_01" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_PAYMASTER_01">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C> Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=ACC_NO       Ctrl=txtACC_NO       Param=value </C>
        <C> Col=SOU_CNT      Ctrl=txtSOU_CNT      Param=value </C>
        <C> Col=DFM_CNT      Ctrl=txtDFM_CNT      Param=value </C>
        <C> Col=TRB_CNT      Ctrl=txtTRB_CNT      Param=value </C>
        <C> Col=GOL_CNT      Ctrl=txtGOL_CNT      Param=value </C>
        <C> Col=WCT_CNT      Ctrl=txtWCT_CNT      Param=value </C>
        <C> Col=CHI_CNT      Ctrl=txtCHI_CNT      Param=value </C>
        <C> Col=SALT_AMT     Ctrl=medSALT_AMT     Param=text  </C>
        <C> Col=SUM_DED     Ctrl=medSUM_DED     Param=text  </C>
        <C> Col=PAY_AMT      Ctrl=medPAY_AMT      Param=text  </C>
    '>
</object>

<!-- 급여 MASTER 테이블 -->
<object id="bndT_CP_PAYMASTER_02" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_PAYMASTER_02">
    <Param Name="BindInfo", Value='
		<C> Col=SALT_AMT      Ctrl=medSALT_AMT_02      Param=text  </C>
		<C> Col=INCM_TAX      Ctrl=medINCM_TAX_02      Param=text  </C>
		<C> Col=CITI_TAX      Ctrl=medCITI_TAX_02      Param=text  </C>
		<C> Col=HINU_AMT      Ctrl=medHINU_AMT_02      Param=text  </C>
		<C> Col=NPEN_AMT      Ctrl=medNPEN_AMT_02      Param=text  </C>
		<C> Col=HINS_AMT      Ctrl=medHINS_AMT_02      Param=text  </C>
		<C> Col=PAY_AMT       Ctrl=medPAY_AMT_02       Param=text  </C>
    '>
</object>


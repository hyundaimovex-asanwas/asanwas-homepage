<!--
*****************************************************
* @source       : BOOK030.jsp
* @description : 도서구입신청현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/15      이동훈        최초작성
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>도서 구입 현황</title>
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

		var chkValid  = 'T';


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	//검색조건
			var STR_YMD_SHR   = document.getElementById("txtSTR_YMD_SHR").value;      	//신청월
			var END_YMD_SHR   = document.getElementById("txtEND_YMD_SHR").value;      	//신청월
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value;      	//소속


            //조회 해당년월을 저장한다.

            document.getElementById("hidDPT_CD_ORI").value = DPT_CD_SHR;

			dsT_ED_BOOKMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book030.cmd.BOOK030CMD"
					                                      + "&S_MODE=SHR"
					                                      + "&STR_YMD_SHR="+STR_YMD_SHR
					                                      + "&END_YMD_SHR="+END_YMD_SHR
					                                      + "&DPT_CD_SHR="+DPT_CD_SHR;
			dsT_ED_BOOKMASTER.reset();


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


        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            if(dsT_ED_BOOKMASTER.CountRow == 0) {
                alert("대상 건이 없습니다.");
                return;
            }

            if(dsT_ED_BOOKDETAIL.CountRow == 0) {
                alert("위 신청번호를 먼저 클릭하시기 바랍니다.");
                return;
            }

            if(dsT_ED_BOOKMASTER.RowPosition == "0") return;

        	var REQ_NO = dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition,"RQST_NO");
			var row = 1;

	        
            //dsT_ED_BOOKREPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book030.cmd.BOOK030CMD"
			//				                                      + "&S_MODE=SHR"
			//				                                      + "&STR_YMD_SHR="+STR_YMD_SHR
			//				                                      + "&END_YMD_SHR="+END_YMD_SHR
			//				                                      + "&DPT_CD_SHR="+DPT_CD_SHR;
            //dsT_ED_BOOKREPORT.Reset();    
            //alert(REQ_NO);
                    	//검색조건
                    	/*
			var STR_YMD_SHR   = document.getElementById("txtSTR_YMD_SHR").value;      	//신청월
			var END_YMD_SHR   = document.getElementById("txtEND_YMD_SHR").value;      	//신청월
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value;      	//소속


            //조회 해당년월을 저장한다.

            document.getElementById("hidDPT_CD_ORI").value = DPT_CD_SHR;

			dsT_ED_BOOKMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book030.cmd.BOOK030CMD"
					                                      + "&S_MODE=SHR"
					                                      + "&STR_YMD_SHR="+STR_YMD_SHR
					                                      + "&END_YMD_SHR="+END_YMD_SHR
					                                      + "&DPT_CD_SHR="+DPT_CD_SHR;
			dsT_ED_BOOKMASTER.reset();
			*/
			
			//dsT_ED_BOOKMASTER.namevalue(1,nm1) = dsT_ED_BOOKREPORT2.namevalue(row,"ENO_NM");
			dsT_ED_BOOKMASTER.namevalue(1,"RQST_NO") = dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition,"RQST_NO");
			dsT_ED_BOOKMASTER.namevalue(1,"DPT_NM") = dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition,"DPT_NM");
			dsT_ED_BOOKMASTER.namevalue(1,"JOB_NM") = dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition,"JOB_NM");
			dsT_ED_BOOKMASTER.namevalue(1,"ENO_NM") = dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition,"ENO_NM");
			dsT_ED_BOOKMASTER.namevalue(1,"RQST_REMARK") = dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition,"RQST_REMARK");
            
            
            
            dsT_ED_BOOKREPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book030.cmd.BOOK030CMD"
																        		+"&S_MODE=SHR_PRINT"
																        		+"&REQ_NO="+REQ_NO;
            dsT_ED_BOOKREPORT.Reset();   			

            dsT_ED_BOOKREPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book030.cmd.BOOK030CMD"
																        		+"&S_MODE=SHR_PRINT2"
																        		+"&REQ_NO="+REQ_NO;
            dsT_ED_BOOKREPORT2.Reset();             
            
            
            
            dsT_ED_BOOKREPORT3.setDataHeader("ENO_NM1:STRING,DPT_NM1:STRING,JOB_NM1:STRING,APP_STATUS1:STRING,ENO_NM2:STRING,DPT_NM2:STRING,JOB_NM2:STRING,APP_STATUS2:STRING,ENO_NM3:STRING,DPT_NM3:STRING,JOB_NM3:STRING,APP_STATUS3:STRING,ENO_NM4:STRING,DPT_NM4:STRING,JOB_NM4:STRING,APP_STATUS4:STRING,ENO_NM5:STRING,DPT_NM5:STRING,JOB_NM5:STRING,APP_STATUS5:STRING,ENO_NM6:STRING,DPT_NM6:STRING,JOB_NM6:STRING,APP_STATUS6:STRING,ENO_NM7:STRING,DPT_NM7:STRING,JOB_NM7:STRING,APP_STATUS7:STRING,DATE:STRING");
            
            dsT_ED_BOOKREPORT3.Addrow();            
            
			for(i=1;i<=dsT_ED_BOOKREPORT.countrow;i++){

				var nm1 = "ENO_NM"+i;
				var nm2 = "DPT_NM"+i;
				var nm3 = "JOB_NM"+i;
				var nm4 = "APP_STATUS"+i;				

				dsT_ED_BOOKREPORT3.namevalue(1,nm1) = dsT_ED_BOOKREPORT.namevalue(i,"ENO_NM");
				dsT_ED_BOOKREPORT3.namevalue(1,nm2) = dsT_ED_BOOKREPORT.namevalue(i,"DPT_NM");				
				dsT_ED_BOOKREPORT3.namevalue(1,nm3) = dsT_ED_BOOKREPORT.namevalue(i,"JOB_NM");
				dsT_ED_BOOKREPORT3.namevalue(1,nm4) = dsT_ED_BOOKREPORT.namevalue(i,"APP_STATUS");						
				
			}            
            
            
            
			for(j=4;j-3<=dsT_ED_BOOKREPORT2.countrow;j++){
				
				var nm1 = "ENO_NM"+j;
				var nm2 = "DPT_NM"+j;
				var nm3 = "JOB_NM"+j;
				var nm4 = "APP_STATUS"+j;				
				
				dsT_ED_BOOKREPORT3.namevalue(1,nm1) = dsT_ED_BOOKREPORT2.namevalue(row,"ENO_NM");
				dsT_ED_BOOKREPORT3.namevalue(1,nm2) = dsT_ED_BOOKREPORT2.namevalue(row,"DPT_NM");				
				dsT_ED_BOOKREPORT3.namevalue(1,nm3) = dsT_ED_BOOKREPORT2.namevalue(row,"JOB_NM");
				dsT_ED_BOOKREPORT3.namevalue(1,nm4) = dsT_ED_BOOKREPORT2.namevalue(row,"APP_STATUS");						
				
				row++;
				
			}		            
			
			
            dsT_ED_BOOKREPORT3.namevalue(1,"DATE") = gcurdate;	
			
			//prompt(this, dsT_ED_BOOKREPORT3.text);
			
    		ReportID.Preview();            
            

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {



        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {



        }

        /******************
         * 08. 유효성 검사 *
         ******************/
        function fnc_Valid() {


        }

        /******************
         * 08. 추가 함수  *
         ******************/
		function fnc_Append(){


		}

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {


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
        function fnc_SearchItemCheck(year) {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //사용안하는 것들 막기

            //날짜값들 바인딩
            var svc_ymd= gcurdate;

            svc_ymd     = addDate("M", gcurdate, 1);

			document.getElementById("txtSTR_YMD_SHR").value = gcurdate.substring(0,7);
			document.getElementById("txtEND_YMD_SHR").value = svc_ymd.substring(0,7);
			
			
			//개인정보 불러오기 추가  ( 직위, 소속   때문에 사용함.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();
			
			

			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006"  && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001" && gusrid != "2130002" && gusrid != "4180001"){ 
	
	            document.getElementById("hidDPT_CD_ORI").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// 소속
	            document.getElementById("txtDPT_CD_SHR").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// 소속
	            document.getElementById("txtDPT_NM_SHR").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// 소속
	
	            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
	            fnc_ChangeStateElement(false, "ImgDptCd");
	
			}
		
			cfStyleGrid_New(form1.grdT_ED_BOOKMASTER,15,"false","true");      // Grid Style 적용

			cfStyleGrid_New(form1.grdT_ED_BOOKDETAIL,15,"false","true");      // Grid Style 적용

            //document.getElementById("resultMessage").innerText = '작업순서: 신청월 > 조회버튼 > 조회';

            fnc_SearchList();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3", "1", "1");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            } else {
                document.getElementById("txtENO_NO").value = "";
	            document.getElementById("txtENO_NM").value = "";
	            document.getElementById("txtJOB_CD").value = "";
	            document.getElementById("txtJOB_NM").value = "";
	            document.getElementById("txtDPT_CD").value = "";
	            document.getElementById("txtDPT_NM").value = "";
            }

			fnc_Valid();  //유효성 검사 후 작업

        }

        function fnc_Ymd_Len(){
            if(document.getElementById("txtHOL_YMD_SHR").value.length == 10){
              fnc_SearchList();
            }

        }

        //입력 element
        var elementList = new Array( 	"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_HOL_HOUR"
                                        ,"cmbSTR_HOL_MIN"
                                        ,"cmbEND_HOL_HOUR"
                                        ,"cmbEND_HOL_MIN"
                                        ,"txtREMARK" );

        //예외 항목
        var exceptionList = new Array(   "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");

    </script>
    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKDETAIL                   |
    | 3. Table List : T_ED_BOOKDETAIL               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKDETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_ED_BOOKREPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_ED_BOOKREPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_ED_BOOKREPORT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
	<!-----------------------------------------------------+
	    | 1. 조회용 DataSet(주소)              |
	    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)      |
	    | 3. 사용되는 Table List(VI_T_CM_PERSON)        |
	    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
	  <Param Name="UseChangeInfo"   Value="True">
	  <Param Name="ViewDeletedRow"  Value="False">
	 </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_ED_BOOKMASTER)	|
    | 3. 사용되는 Table List(T_ED_BOOKMASTER)	        |
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_ED_BOOKDETAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    <!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!------------------------------+
    | grid에서 row를     클릭했을때 |
    +------ ------------------------>
	<script for=grdT_ED_BOOKMASTER event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );

		var REQ_NO = dsT_ED_BOOKMASTER.NameValue(Row, "RQST_NO");

		if(Row < 1) {
			
			return;
			
		} else {
			try {
			dsT_ED_BOOKDETAIL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book030.cmd.BOOK030CMD"
                                      + "&S_MODE=SHR_02"
                                      + "&RQST_NO="+REQ_NO;
			dsT_ED_BOOKDETAIL.reset();

			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				
				return;
				
			}
		}

	</script>

	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		var obj = new String();
		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}
  </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">-->

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
		  </font>
		</td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"    ><img src="../../images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                	<col width="100"></col>
                    <col width="200"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                   <td class="searchState" align="right">도서신청월&nbsp;</td>
                   <td class="padding2423" align="left" id="key1"  style="display:">
									<input id="txtSTR_YMD_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','75','112');"></a>-->
									~
									<input id="txtEND_YMD_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YMD_SHR','','190','112');"></a>-->
                   </td>

                    <td align="right" class="searchState">소&nbsp;&nbsp;속&nbsp;</td>

					<td class="padding2423">
                        <input id="hidDPT_CD_ORI" type="hidden">
						<input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
					</td>

                    <!--
                    <td class="padding2423">
                        <input id="hidDPT_CD_ORI" type="hidden">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                    </td>
                -->


                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->



<table border="0">
	<tr>
		<td valign="top">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">
			        	<!-- 마스터 정보 테이블 시작 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_ED_BOOKMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
										<param name="DataID"				value="dsT_ED_BOOKMASTER">
										<param name="SortView"				value="Left">
										<param name="Format"				value="
			            					<C> id='{CUROW}'		width=50	name='NO'		align=center	value={String(Currow)}	</C>
											<C> id='RQST_NO'		width=80	name='신청번호'	align=center	mask='XXXXXX-XXXX'</C>
			            					<C> id='DPT_NM'			width=150	name='부서'		align=center	</C>
											<C> id='JOB_NM'			width=60	name='직위'		align=center	</C>
											<C> id='ENO_NO'			width=100	name='사번'		align=center	</C>
											<C> id='ENO_NM'			width=100	name='성명'		align=center	</C>
											<C> id='RQST_REMARK'	width=313	name='용도'		align=center	</C>
											<C> id='END_TAG'		width=100	name='결재상태'	align=center	value={Decode(END_TAG,'R','저장','A','상신','N','부결','Y','결재완료','진행중')} </C>
										">
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
			                </tr>
			            </table>
			        	<!-- 마스터  정보 테이블 끝 -->
 					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>





<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ED_BOOKDETAIL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:230px;">
							<param name="DataID"				value="dsT_ED_BOOKDETAIL">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=50			name='NO'							align=center	value={String(Currow)}	</C>
								<C> id='RQST_NO'		width=80			name='신청번호'						align=center	mask='XXXXXX-XXXX'								</C>
								<C> id='BOOK_NM'		width=300			name='도서명'						align=center													</C>
								<C> id='BOOK_PUL'		width=120			name='출판사'						align=center													</C>
								<C> id='BOOK_WRT'		width=80			name='저자'							align=center													</C>
								<C> id='BOOK_QTY'		width=70			name='수량'							align=center													</C>
								<C> id='BOOK_AMT'		width=80			name='가격'							align=center													</C>
                                <C> id='END_TAG'	    width=60 	        name='결재상태'       SHOW=FALSE 		        align=center    value={Decode(END_TAG,'R','상신','N','부결','Y','결재완료','저장')} </C>
                                <C> id='BOOK_REMARK'    width=180           name='비고'                         align=left      Edit=none                  </C>
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





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 도서구입신청서 ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_ED_BOOKMASTER">
	<param name="DetailDataID"	    				value="dsT_ED_BOOKDETAIL">
	<PARAM NAME="PaperSize"							VALUE="A4">
	<PARAM NAME="LandScape"							VALUE="0">
  	<PARAM NAME="PrintSetupDlgFlag" 				VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="120">
	<PARAM NAME="Format" 								VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=133
	<R>id='출장내역.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132, DetailDataID='dsT_ED_BOOKDETAIL'	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=973 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=1963 ,top=884 ,right=1963 ,bottom=971 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='* 도서 List' ,left=32 ,top=791 ,right=524 ,bottom=860 ,align='left' ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1611 ,top=886 ,right=1611 ,bottom=974 </L>
	<T>id='가격' ,left=1434 ,top=900 ,right=1598 ,bottom=958 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수량' ,left=1246 ,top=902 ,right=1410 ,bottom=960 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='저자' ,left=1056 ,top=902 ,right=1220 ,bottom=960 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출판사' ,left=691 ,top=902 ,right=897 ,bottom=960 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순' ,left=40 ,top=902 ,right=119 ,bottom=960 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=513 ,top=886 ,right=513 ,bottom=974 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1042 ,top=884 ,right=1042 ,bottom=971 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1233 ,top=886 ,right=1233 ,bottom=974 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1426 ,top=886 ,right=1426 ,bottom=974 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=132 ,top=886 ,right=132 ,bottom=974 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=26 ,top=884 ,right=26 ,bottom=971 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=884 ,right=1963 ,bottom=884 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=971 ,right=1963 ,bottom=971 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<I>id='../../../Common/img/2015slg.jpg' ,left=238 ,top=140 ,right=566 ,bottom=257</I>
	<T>id='도서명' ,left=156 ,top=902 ,right=463 ,bottom=960 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1622 ,top=900 ,right=1955 ,bottom=958 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직 위' ,left=29 ,top=513 ,right=286 ,bottom=572 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소 속' ,left=29 ,top=431 ,right=286 ,bottom=489 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=21 ,top=415 ,right=1942 ,bottom=415 </L>
	<L> left=21 ,top=579 ,right=1942 ,bottom=579 </L>
	<T>id='품의번호' ,left=29 ,top=347 ,right=286 ,bottom=405 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=291 ,top=333 ,right=291 ,bottom=733 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='성명' ,left=29 ,top=593 ,right=286 ,bottom=651 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=21 ,top=331 ,right=1942 ,bottom=331 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=21 ,top=736 ,right=1942 ,bottom=736 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='용도' ,left=26 ,top=672 ,right=283 ,bottom=730 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=21 ,top=661 ,right=1942 ,bottom=661 </L>
	<C>id='DPT_NM', left=302, top=434, right=918, bottom=492, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=302, top=513, right=918, bottom=572, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RQST_NO', left=304, top=347, right=913, bottom=405, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=302, top=593, right=918, bottom=651, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=21 ,top=333 ,right=21 ,bottom=736 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1939 ,top=333 ,right=1939 ,bottom=736 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=21 ,top=500 ,right=1939 ,bottom=500 </L>
	<C>id='RQST_REMARK', left=299, top=669, right=1937, bottom=728, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='도서구입신청서' ,left=569 ,top=138 ,right=1543 ,bottom=267 ,face='Tahoma' ,size=30 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=26 ,top=79 ,right=1963 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=132 ,top=0 ,right=132 ,bottom=79 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=513 ,top=0 ,right=513 ,bottom=79 </L>
	<L> left=1042 ,top=0 ,right=1042 ,bottom=79 </L>
	<L> left=1233 ,top=0 ,right=1233 ,bottom=79 </L>
	<L> left=1426 ,top=0 ,right=1426 ,bottom=79 </L>
	<L> left=1611 ,top=0 ,right=1611 ,bottom=79 </L>
	<C>id='BOOK_PUL', left=521, top=13, right=1035, bottom=71, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1963 ,top=3 ,right=1963 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{CurRow}', left=32, top=11, right=130, bottom=77, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BOOK_WRT', left=1048, top=13, right=1230, bottom=71,  face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BOOK_QTY', left=1238, top=13, right=1423, bottom=71,  face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BOOK_AMT', left=1429, top=13, right=1609, bottom=71,  face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BOOK_REMARK', left=1614, top=13, right=1953, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BOOK_NM', left=140, top=13, right=505, bottom=71, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
	</R>
</A>






<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=133
	<R>id='현황.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='dsT_ED_BOOKREPORT3'
<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=1042 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='현 대 아 산 주 식 회 사' ,left=659 ,top=945 ,right=1643 ,bottom=1029 ,align='left' ,face='Tahoma' ,size=25 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DATE', left=746, top=868, right=1172, bottom=931, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='../../images/common/hd_ci_1.jpg' ,left=516 ,top=915 ,right=656 ,bottom=1032</I>
	<T>id='상기와 같이 도서를 구매하고자 합니다.' ,left=233 ,top=778 ,right=1783 ,bottom=863 ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=312 ,right=26 ,bottom=624 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='APP_STATUS6', left=1511, top=548, right=1937, bottom=611, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS5', left=1511, top=471, right=1937, bottom=534, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS4', left=1511, top=394, right=1937, bottom=458, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM6', left=1352, top=550, right=1500, bottom=614, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM6', left=1183, top=550, right=1341, bottom=614, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM6', left=1045, top=550, right=1169, bottom=614, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM5', left=1352, top=471, right=1500, bottom=534, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM5', left=1183, top=471, right=1341, bottom=534, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM5', left=1045, top=471, right=1169, bottom=534, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM4', left=1352, top=394, right=1500, bottom=458, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM4', left=1183, top=394, right=1341, bottom=458, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM4', left=1045, top=394, right=1169, bottom=458, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM3', left=32, top=553, right=156, bottom=616, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM2', left=32, top=474, right=156, bottom=537, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM1', left=32, top=397, right=156, bottom=460, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM3', left=169, top=553, right=328, bottom=616, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM2', left=167, top=474, right=325, bottom=537, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM1', left=167, top=397, right=325, bottom=460, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM3', left=339, top=553, right=487, bottom=616, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM2', left=339, top=474, right=487, bottom=537, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM1', left=339, top=397, right=487, bottom=460, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS3', left=497, top=553, right=923, bottom=616, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS2', left=497, top=474, right=923, bottom=537, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS1', left=497, top=397, right=923, bottom=460, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1040 ,top=542 ,right=1942 ,bottom=542 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1942 ,top=310 ,right=1942 ,bottom=616 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=310 ,right=1040 ,bottom=616 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='결 재 상 태' ,left=1511 ,top=320 ,right=1937 ,bottom=384 ,face='Tahoma' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 서' ,left=1349 ,top=320 ,right=1503 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직 위' ,left=1180 ,top=320 ,right=1344 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결재자' ,left=1045 ,top=320 ,right=1172 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1505 ,top=312 ,right=1505 ,bottom=619 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1347 ,top=312 ,right=1347 ,bottom=619 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1175 ,top=310 ,right=1175 ,bottom=616 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=619 ,right=1942 ,bottom=619 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=463 ,right=1942 ,bottom=463 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=389 ,right=1942 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1942 ,top=310 ,right=1040 ,bottom=310 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='결 재 상 태' ,left=497 ,top=323 ,right=923 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 서' ,left=336 ,top=323 ,right=489 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직 위' ,left=167 ,top=323 ,right=331 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결재자' ,left=32 ,top=323 ,right=159 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=492 ,top=315 ,right=492 ,bottom=622 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=333 ,top=315 ,right=333 ,bottom=622 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=161 ,top=312 ,right=161 ,bottom=619 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=929 ,top=312 ,right=929 ,bottom=622 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=622 ,right=929 ,bottom=622 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=545 ,right=929 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=466 ,right=929 ,bottom=466 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=926 ,top=392 ,right=24 ,bottom=392 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=929 ,top=312 ,right=26 ,bottom=312 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='* 확인 부서' ,left=1040 ,top=217 ,right=1532 ,bottom=302 ,align='left' ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* 품의 부서' ,left=32 ,top=217 ,right=524 ,bottom=302 ,align='left' ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
	</R>
</A>


">
</OBJECT>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_ED_BOOKMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKMASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			Param=value 	</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>

    '>
</object>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_ED_BOOKDETAIL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKDETAIL">
	<Param Name="BindInfo", Value='
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD				Ctrl=txtJOB_CD	   			Param=value		</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
        <C>Col=STR_HOL_HOUR         Ctrl=cmbSTR_HOL_HOUR        Param=value     </C>
        <C>Col=STR_HOL_MIN          Ctrl=cmbSTR_HOL_MIN         Param=value     </C>
        <C>Col=END_HOL_HOUR         Ctrl=cmbEND_HOL_HOUR        Param=value     </C>
        <C>Col=END_HOL_MIN          Ctrl=cmbEND_HOL_MIN         Param=value     </C>
        <C>Col=REMARK               Ctrl=txtREMARK      		Param=value 	</C>
    '>
</object>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

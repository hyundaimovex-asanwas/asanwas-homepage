<!--
*****************************************************
* @source       : vluk090.jsp
* @description  : 종합점수조정 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/11/26      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>종합점수조정(vluk090)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

          //검색조건 4가지
          var REG_YM_SHR 	= document.form1.txtREG_YM_SHR.value;          //해당년도
          var EMPNOH 		= document.form1.txtENOH_NO_SHR.value;         //고과자
          var GUBUN 		= "";
          var GOGA1 		= document.form1.goga1.value;         			//고과평정
          var JOB_CD_FROM 	= document.form1.cmbJOB_CD_FROM.value;          //직위 시작
          var JOB_CD_TO 	= document.form1.cmbJOB_CD_TO.value;         	//직위 끝

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }


		  	if(GUBUN == "1"){ //정규직
		       	//정보 조회
		       	dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GOGA1="+GOGA1+"&JOB_CD_FROM="+JOB_CD_FROM+"&JOB_CD_TO="+JOB_CD_TO;
		       	dsT_EV_ABLRST.reset();
			}else{ 			//계약직
		       	//정보 조회
		       	dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GOGA1="+GOGA1+"&JOB_CD_FROM="+JOB_CD_FROM+"&JOB_CD_TO="+JOB_CD_TO;
		       	dsT_EV_ABLRST.reset();
			}

        }


        function fnc_SearchList2() {

          //검색조건 4가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //고과자
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }

			if(document.form1.txtREG_YM_SHR.value !="2013-11"){
				alert("2013년 11월만 실행 가능합니다.");
				return false;
			}

            dsT_EV_ABLRST.ClearData();

		  	if(GUBUN == "1"){ //정규직

		       	dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
		       	dsT_EV_ABLRST2.reset();
			}else{ 			//계약직

		       	dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_03&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
		       	dsT_EV_ABLRST2.reset();
			}

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


			if(document.form1.txtREG_YM_SHR.value != "2013-11"){
				alert("2013년 11월만 저장 가능합니다.");
				return false;
			}

			if (dsT_EV_ABLRST.countrow<1){
				alert ("저장할 정보가 없습니다.");
			}else {
				if (confirm("저장하시겠습니까?")) {
		            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
		            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SAV";
		            trT_EV_ABLRST.post();
				}
			}
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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("고과점수조정", '', 225);

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

            var f = document.form1;
            f.txtENOH_NO_SHR.value = '';
            f.txtENOH_NM_SHR.value = '';


            dsT_EV_ABLRST.ClearData();

            document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

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

            if (!dsT_EV_ABLRST.IsUpdated) {
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

			document.getElementById("loctitle").innerText = "HOME/인사평가/고과평가/";

			document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

	        cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","true");      // Grid Style 적용

        	//직위
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM", "", "전 체");
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO", "", "전 체");


        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /********************
         * 16.    실행       *
         *******************/
        function fnc_Execute() {

			alert("개발중");

        	/*
			if (dsT_EV_ABLRST.countrow<1){
				alert ("실행할 정보가 없습니다.");
			}else {

		    	if(document.form1.txtREG_YM_SHR.value==""){
					alert("고과년월을 확인하십시요.");
					return false;
				}

				fnc_SearchList2();
			}
			*/
        }



		/******************************************************************************
			17. 등급생성 --> 등급은 항상 실행 후 totavg(최종조정)이 존재한 후에 적용해야함.
		******************************************************************************/
		function fnc_Grade(){

		  //alert("개발중");

	
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }

		    if(document.form1.txtREG_YM_SHR.value == ""){
				alert("고과년월이 존재하지 않습니다. 확인바랍니다.");
				return;
			}

			if(document.form1.txtREG_YM_SHR.value != "2013-11"){
				alert("2013년 11월만 등급생성 가능합니다.");
				return false;
			}


			//직급별 등급 인원수
		  	if(GUBUN == "1"){ //정규직

			 	dsT_EV_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_04&REG_YM_SHR="+REG_YM_SHR;
			    dsT_EV_GRADE.reset();

			}else{ 			//계약직

		       	dsT_EV_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_05&REG_YM_SHR="+REG_YM_SHR;
		       	dsT_EV_GRADE.reset();
			}


			//직급별 rank
		  	if(GUBUN == "1"){ //정규직

			 	dsT_EV_GRADE2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_06&REG_YM_SHR="+REG_YM_SHR;
			    dsT_EV_GRADE2.reset();

			}else{ 			//계약직

		       	dsT_EV_GRADE2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_07&REG_YM_SHR="+REG_YM_SHR;
		       	dsT_EV_GRADE2.reset();
			}


		    if (confirm(document.form1.txtREG_YM_SHR.value+"의 등급생성을 하시겠습니까?")) {

				fnc_Grade_Update();

	            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_GRADE2=dsT_EV_GRADE2)";
	            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SAV_GRD";
	            trT_EV_ABLRST.post();

			}


		}

		/******************************************************************************
			Description : 등급생성 --> 등급은 항상 실행 후 totavg(최종조정)이 존재한 후에 적용해야함.
		******************************************************************************/
		function fnc_Grade_Update(){

			var intCnt=0;
			var intS=0;
			var intA=0;
			var intB=0;
			var intC=0;
			var intD=0;
			var intStart=1;

			for(i=1;i<=dsT_EV_GRADE.countrow;i++){ //직급별 row

				intCnt=0;                               //직급별 명수 초기화

				intS=dsT_EV_GRADE.namevalue(i,"S");

				intA=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A");

				intB=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A")+dsT_EV_GRADE.namevalue(i,"B");

				intC=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A")+dsT_EV_GRADE.namevalue(i,"B")+dsT_EV_GRADE.namevalue(i,"C");

				intD=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A")+dsT_EV_GRADE.namevalue(i,"B")+dsT_EV_GRADE.namevalue(i,"C")+dsT_EV_GRADE.namevalue(i,"D");

				_loop:

				for(j=intStart;j<=dsT_EV_GRADE2.countrow;j++){ //전체 직급별 rank 순위..

					intCnt +=1;                           //순위

		       		if(dsT_EV_GRADE.namevalue(i,"PAYGRD2")==dsT_EV_GRADE2.namevalue(j,"PAYGRD2")){

						intStart+=1;

						if(intCnt<=intS){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="S";
						}else if(intCnt<=intA){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="A";
						}else if(intCnt<=intB){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="B";
		        		}else if(intCnt<=intC){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="C";
		        		}else if(intCnt<=intD){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="D";
						}

					}else{
						break _loop;
					}

				}//for j

		  }//for i

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_GRADE2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 직위 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <Script For=dsT_EV_ABLRST2 Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {

        	for(var i=1;i<=iCount;i++) {

				if(dsT_EV_ABLRST2.namevalue(i,"DPTAVG")==0){

					dsT_EV_ABLRST2.namevalue(i,"TOTAVG") = dsT_EV_ABLRST2.namevalue(i,"CORAVG");

				}else{

					dsT_EV_ABLRST2.namevalue(i,"TOTAVG") = dsT_EV_ABLRST2.namevalue(i,"CORAVG")*0.9 + dsT_EV_ABLRST2.namevalue(i,"DPTAVG")*0.5 ;

				}
			}

			if (confirm("실행하신 정보를 저장하시겠습니까?")) {

	            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST2=dsT_EV_ABLRST2)";
	            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SAV_EXE";
	            trT_EV_ABLRST.post();

				fnc_SearchList();

			}

        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
            cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">종합점수조정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">종합점수조정</font></td>
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
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_execute.gif',1)"><img src="/images/button/btn_execute.gif"   name="Image1"   border="0" align="absmiddle" onClick="fnc_Execute()"></a>-->
			&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_Grade.gif',1)"><img src="/images/button/btn_Grade.gif"   name="Image2"   border="0" align="absmiddle" onClick="fnc_Grade()"></a>
			&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td align="center" class="greenTable">
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
		               <colgroup>
		                    <col width="70"></col>
		                    <col width="100"></col>
		                    <col width="70"></col>
		                    <col width="140"></col>
		                    <col width="50"></col>
		                    <col width="*"></col>
		               </colgroup>
		               		<tr>
                                <td class="searchState" align="center">고과년월</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                                </td>
								<td class="searchState" align="center">고과자</td>
								<td >
									<input id="txtENOH_NO_SHR" name="txtENOH_NO_SHR" size="7" maxlength="7"  onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENOH_NO_SHR','txtENOH_NM_SHR');">
									<input id="txtENOH_NM_SHR" name="txtENOH_NM_SHR" size="8" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENOH_NO_SHR', 'txtENOH_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENOH_NO_SHR','txtENOH_NM_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENOH_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENOH_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENOH_NO_SHR','txtENOH_NM_SHR');"></a>
								</td>
								<td class="searchState" align="center">구분</td>
                                <td class="padding2423" style="width:150" >
                                    <fieldset>
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" value="0">정규직
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="1">계약직
                                    </fieldset>
                                </td>
				            </tr>
							<tr class="paddingTop5" >
								<td class="searchState" align="center">직종</td>
				                <td class="padding2423" align="left">
									<select id="cmbEVA_SEQ" style="width:100">
										<option value="0">전체</option>
										<option value="1">사무직</option>
										<option value="2">영업직</option>
										<option value="3">기술직</option>
										<option value="4">기타</option>
										<option value="5">안전관리</option>
									</select>
				                </td>
								<td class="searchState" align="center">고과평정</td>
								<td class="padding2423">
									<input type="checkbox" name="goga1" style="border:0" onClick="if(this,this.checked) {goga1.value = 'T'}else{goga1.value = ''}">선택
								</td>							
								<td class="searchState" align="center">직위</td>
								<td colspan="3">
		                        <select id="cmbJOB_CD_FROM" style="width:100px;" onChange="">
		                        </select>
		                        &nbsp;~&nbsp;
		                        <select id="cmbJOB_CD_TO" style="width:100px;" onChange="">
		                        </select>
				                </td>
						</tr>
             	</table>
        	</td>
    	</tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='EMPNO'     width=50   	name='사번'    		align=center    edit=none </FC>
                                    <FC> id='DEPTNM'    width=110   name='소속'   		align=left    	edit=none </FC>
                                    <FC> id='GRDNM'    	width=65   	name='직위'   		align=left    	edit=none </FC>
                                    <FC> id='EMPNMK'   	width=75  	name='피고과자'  	align=left      edit=none </FC>

								<G> Name='상반기' HeadAlign=Center HeadBgColor=#F7DCBB
                                    <C> id='SCR11'   	width=60  	name='1차'      	align=center    dec = 3 edit=none value={IF (SCR11='0','',SCR11)}</C>
                                    <C> id='GOG11'   	width=60  	name='고과자'      	align=center    edit=none</C>

                                    <C> id='SCR12'   	width=60  	name='2차'      	align=center    dec = 3 edit=none value={IF (SCR12='0','',SCR12)}</C>
                                   <C> id='GOG12'   	width=60  	name='고과자'      	align=center    edit=none</C>

                                    <C> id='SCR13'   	width=60  	name='3차'      	align=center    dec = 3 edit=none value={IF (SCR13='0','',SCR13)}</C>                                                                        								
                                   <C> id='GOG13'   	width=60  	name='고과자'      	align=center    edit=none</C>

                                    <C> id='SCR14'   	width=60  	name='부서장'      	align=center    dec = 3 edit=none value={IF (SCR14='0','',SCR14)}</C>                                                                        								
 
                                    <C> id='TOTAVG1'     width=55   	name='최종'      	align=center    edit=none </C>
                                </G>                                    

								<G> Name='하반기' HeadAlign=Center HeadBgColor=#F7DCBB
                                    <C> id='SCR21'   	width=60  	name='1차'      	align=center    dec = 3 edit=none value={IF (SCR21='0','',SCR21)} </C>
                                   <C> id='GOG21'   	width=60  	name='고과자'      	align=center    edit=none</C>

                                    <C> id='SCR22'   	width=60  	name='2차'      	align=center    dec = 3 edit=none value={IF (SCR22='0','',SCR22)} </C>
                                   <C> id='GOG22'   	width=60  	name='고과자'      	align=center    edit=none</C>

                                    <C> id='SCR23'   	width=60  	name='3차'      	align=center    dec = 3 edit=none value={IF (SCR23='0','',SCR23)} </C>     
                                   <C> id='GOG23'   	width=60  	name='고과자'      	align=center    edit=none</C>

                                    <C> id='SCR24'   	width=60  	name='부서장'      	align=center    dec = 3 edit=none value={IF (SCR24='0','',SCR24)} </C>     

                                    <C> id='TOTAVG2'     width=55   	name='최종'      	align=center    edit=none </C>
                                </G>    
                                    <C> id='TOTAVG_FINAL'     width=50   	name='최종;점수'    align=center    edit=none bgcolor='#F5F6CE'</C>
                                    <C> id='GRADE'      width=50   	name='고과;등급'   	align=center    edit=none bgcolor='#F5D0A9'</C>
								<G> Name='최종등급조정' HeadAlign=Center HeadBgColor=#F7DCBB
                                    <C> id='GRADE2'     width=70   	name='본부장'      	align=center    bgcolor='#F7BE81'</C>
                                    <C> id='GRADE3'     width=75   	name='대표이사'   	align=center    bgcolor='#FAAC58'</C>
                                </G>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                     </tr>
					 <tr>
							<td> <P>&nbsp;&nbsp;<BR>
									&nbsp;&nbsp;* 등급생성 : 최종점수 기준으로 고과 등급 생성함.(본부장 및 대표이사 최종등급조정도 최초 고과등급 적용함)<BR>
							        &nbsp;&nbsp;* 등급 생성 버튼을 정규직, 계약직 각각 한 번만 적용하면 됩니다.<BR>
							        &nbsp;&nbsp;* 고과등급, 본부장 및 대표이사 최종등급조정은 임의 변경 후에는 저장 버튼으로 저장하면 수정 됩니다.<BR>
									&nbsp;&nbsp;* 단, 임의 변경한 경우 다시  등급생성 버튼을 누르면 기존 임의 변경된 내용은 적용 안됩니다.
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



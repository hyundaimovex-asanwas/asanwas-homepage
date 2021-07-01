<!--
*****************************************************
* @source       : vlui040.jsp
* @description  : 고과자지정 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //품의자사번
	String eno_nm = box.getString("SESSION_ENONM");         //품의자사번
	String dep_cd = box.getString("SESSION_DPTCD");         //품의자사번

%>
<html>
<head>
<title>고과점수입력(하향)(vlui040)</title>
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
		var cntchk = "N";
		var j=0;
		var GSTR_YYYYMM, GSTR_EMPNO, GSTR_EMPNMK, GSTR_GRPCD, GSTR_JOBGRPH, GSTR_EVASEQ,GSTR_ROWPOSITION,GSTR_PAYGRD;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

          //검색조건 4가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //고과자
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }else {
          		GUBUN = "3";//부서장
          }

          //alert(e);
          
          
		  if(GUBUN !="3"){ //정규직,계약직

			  //본사
		      dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST.reset();
			  fnc_Reset('q');

			  //본사외
		      dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST2.reset();
			  fnc_Reset('q');

		  }else { 		//부서장

			  //본사
		      dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST.reset();
			  fnc_Reset('q');

			  //본사외
		      dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SHR_03&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST2.reset();
			  fnc_Reset('q');
		  }

        }


        function fnc_SearchList2() {

          //검색조건 4가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//해당년도
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        							//고과자
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }else {
          		GUBUN = "3";//부서장
          }

          if(GUBUN !="3"){ 	//정규직,계약직

		      dsT_EV_ABLRST3.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SHR_SCR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&EMPNO="+GSTR_EMPNO+"&EVASEQ="+GSTR_EVASEQ+"&PAYGRD="+GSTR_PAYGRD;
		      dsT_EV_ABLRST3.reset();

		  }else{			//부서장

		      dsT_EV_ABLRST3.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SHR_SCR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&EMPNO="+GSTR_EMPNO+"&EVASEQ="+GSTR_EVASEQ+"&PAYGRD="+GSTR_PAYGRD;
		      dsT_EV_ABLRST3.reset();
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

          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//해당년도
		  var GUBUN;
		  var TOTAL_SCR = 0;

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }else {
          		GUBUN = "3";//부서장
          }

			if (dsT_EV_ABLRST3.countrow<1){
				alert ("저장할 정보가 없습니다.");
			}else {

				if(fnc_Chk()){

					if (confirm("저장하시겠습니까?")) {

							for ( i=1;i<=dsT_EV_ABLRST3.countrow;i++){

								if ((dsT_EV_ABLRST3.SysStatus(i)==2)||(dsT_EV_ABLRST3.SysStatus(i)==3)){
											dsT_EV_ABLRST3.namevalue(i,"EMPNOH")=	document.form1.txtENOH_NO_SHR.value;
											dsT_EV_ABLRST3.namevalue(i,"EMPNO")	=	GSTR_EMPNO;
											dsT_EV_ABLRST3.namevalue(i,"EVASEQ")=	GSTR_EVASEQ;
										}
								TOTAL_SCR = TOTAL_SCR + dsT_EV_ABLRST3.namevalue(i,"SCR");
							}

						if(GUBUN!="3"){ //정규직, 계약직
							trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST3=dsT_EV_ABLRST3)";
            				trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SAV&REG_YM_SHR="+REG_YM_SHR+"&EMPNO="+GSTR_EMPNO+"&GUBUN="+GUBUN+"&TOTAL_SCR="+TOTAL_SCR;
		        		}else{ //부서장
							trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST3=dsT_EV_ABLRST3)";
            				trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SAV_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNO="+GSTR_EMPNO+"&GUBUN="+GUBUN+"&TOTAL_SCR="+TOTAL_SCR;
						}

						trT_EV_ABLRST.post();

						fnc_Reset('r');

						fnc_SearchList();

						fnc_SearchList2();

					}
				}
			}

		}

		/******************************************************************************
			Description : 고과자 지정 Grid 초기화
			parameter - q : query시   r -reset 초기화
		******************************************************************************/
		function fnc_Reset(p){

			if(p=="r"){
				if (dsT_EV_ABLRST3.countrow>=1){
					dsT_EV_ABLRST3.ClearData();
				}else{
					alert("초기화 할 데이터가 존재하지 않습니다.");
				}
			}else if(p=="q"){
				if (dsT_EV_ABLRST3.countrow>=1)
					dsT_EV_ABLRST3.ClearData();
			}
		}

		/******************************************************************************
			Description : Check
		******************************************************************************/
        function fnc_Chk() {

        	for (i=1;i<=dsT_EV_ABLRST3.countrow;i++){

				if (dsT_EV_ABLRST3.namevalue(i,"CHK01") == "F" && dsT_EV_ABLRST3.namevalue(i,"CHK02") == "F"
				 && dsT_EV_ABLRST3.namevalue(i,"CHK03") == "F" && dsT_EV_ABLRST3.namevalue(i,"CHK04") == "F"
				 && dsT_EV_ABLRST3.namevalue(i,"CHK05") == "F"){
							alert("모든 평가요소를 체크하십시요");

				    dsT_EV_ABLRST3.rowposition = i;

				  	return false;

					break;

					}
				}

			return true;

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

            form1.grdT_EV_ABLRST.GridToExcel("고과점수입력(하향)", '', 225);

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
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';

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


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

		document.getElementById("loctitle").innerText = "HOME/인사평가/고과평가/";

		//document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);
		document.getElementById("txtREG_YM_SHR").value = '2012-11';		
		document.getElementById("txtENOH_NO_SHR").value="<%=eno_no%>";
		document.getElementById("txtENOH_NM_SHR").value="<%=eno_nm%>";


        cfStyleGrid(form1.grdT_EV_ABLRST,0,"true","false");      // Grid Style 적용
        cfStyleGrid(form1.grdT_EV_ABLRST2,0,"true","false");      // Grid Style 적용
        cfStyleGrid(form1.grdT_EV_ABLRST3,0,"false","false");      // Grid Style 적용

		<%
		    //관리자가 아니면 사번 검색은 하지 못한다.
		    if(!(box.getString("SESSION_ENONO").equals("6060002") || box.getString("SESSION_ENONO").equals("1990071") || box.getString("SESSION_ENONO").equals("2020008"))) {
		%>
		            fnc_ChangeStateElement(false, "txtENOH_NO_SHR");
		            fnc_ChangeStateElement(false, "txtENOH_NM_SHR");
		            fnc_ChangeStateElement(false, "ImgEnoNo");
		<%
		    }
		%>

		fnc_SearchList();
		
		
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /******************************
         * 16. 초기화                  *
         ******************************/
        function fnc_Init() {

			 dsT_EV_ABLRST3.ClearData();

        }


        /******************************
         * 17. 업적신고서 조회         *
         ******************************/
        function fnc_WorkSearch(){

			var result="";
			var arrResult	= new Array();
			var arrParam	= new Array();
			var strURL;
			var strPos;

			arrParam[0] = document.form1.txtREG_YM_SHR.value; //년월
		  	arrParam[1] = GSTR_EMPNO; //사번
		  	arrParam[2] = GSTR_EMPNMK; //성명

		    strURL = "/hr/vlu/vlui041.jsp";
			strPos = "dialogWidth:880px;dialogHeight:630px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);

        }

        /******************************
         * 18. 보정계산       		   *
         ******************************/
        function fnc_Correct(){

          //검색조건 2가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //고과자
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//정규직
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//계약직
          }else {
          		GUBUN = "3";//부서장
          }

          if(GUBUN =="1"){ 	//정규직
			  if(confirm("정규직 보정계산을 하시겠습니까?")){
			      dsT_EV_CORCAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SAV_COR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}
		  }else if((GUBUN =="2")){	//계약직
			  if(confirm("계약직 보정계산을 하시겠습니까?")){
			      dsT_EV_CORCAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SAV_COR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}
		  }else{	//부서장
			  if(confirm("부서장 보정계산을 하시겠습니까?")){
			      dsT_EV_CORCAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD&S_MODE=SAV_COR_02&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}
		  }

        }


		/******************************************************************************
			Description : 고과점수조회
		******************************************************************************/
		function fnc_Grid_Onclick(gubun,row){

		    GSTR_YYYYMM ="";
			GSTR_EMPNO = "";
			GSTR_GRPCD = "";
			GSTR_JOBGRPH = "";
			GSTR_EVASEQ = "";
			GSTR_PAYGRD = "";

			if(gubun=="1"){
				GSTR_YYYYMM		 = dsT_EV_ABLRST.namevalue(row,"EVAYM");
				GSTR_EMPNO		 = dsT_EV_ABLRST.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST.namevalue(row,"EMPNMK");
				GSTR_GRPCD		 = dsT_EV_ABLRST.namevalue(row,"GRPCD");
				GSTR_JOBGRPH	 = dsT_EV_ABLRST.namevalue(row,"JOBGRPH");
				GSTR_EVASEQ		 = dsT_EV_ABLRST.namevalue(row,"EVASEQ");
				GSTR_PAYGRD		 = dsT_EV_ABLRST.namevalue(row,"PAYGRD");
				GSTR_ROWPOSITION = dsT_EV_ABLRST.rowposition;
			}else if(gubun=="5"){
				GSTR_YYYYMM		 = dsT_EV_ABLRST2.namevalue(row,"EVAYM");
				GSTR_EMPNO		 = dsT_EV_ABLRST2.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST2.namevalue(row,"EMPNMK");
				GSTR_GRPCD		 = dsT_EV_ABLRST2.namevalue(row,"GRPCD");
				GSTR_JOBGRPH	 = dsT_EV_ABLRST2.namevalue(row,"JOBGRPH");
				GSTR_EVASEQ		 = dsT_EV_ABLRST2.namevalue(row,"EVASEQ");
				GSTR_PAYGRD		 = dsT_EV_ABLRST2.namevalue(row,"PAYGRD");
				GSTR_ROWPOSITION = dsT_EV_ABLRST2.rowposition;
			}

			fnc_SearchList2();

		}

       /***********************
       * 사원조회용 팝업 *
       **********************/
        function fnc_EmplPopp() {
			var obj = new String();
            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";
            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
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

    <Object ID="dsT_EV_ABLRST3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_CORCAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

	<script for=rdoGBN_SHR event=OnChange()>
		//txt_code.value=rdoGBN_SHR.CodeValue;
		//txt_data.value=rdoGBN_SHR.DataValue;
		
		alert(rdoGBN_SHR.CodeValue);
		alert(rdoGBN_SHR.DataValue);		
	</script>

    <!-------------------------------------------------+
    | 그리드를 클릭했을때 처리 할 로직                 |
    +-------------------------------------------------->
    <Script For=grdT_EV_ABLRST Event="OnClick(row,col)">
    	fnc_Grid_Onclick('1',row);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnClick(row,col)">
    	fnc_Grid_Onclick('5',row);
    </Script>


    <Script For=grdT_EV_ABLRST3 Event="OnClick(row,col)">
	if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {

		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK01") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK02") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK03") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK04") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK05") = "F";

		if ("CHK01" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK01") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "1";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"ESCR");
		}else if ("CHK02" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK02") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "2";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"GSCR");
		}else if ("CHK03" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK03") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "3";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"MSCR");
		}else if ("CHK04" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK04") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "4";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"LSCR");
		}else if ("CHK05" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK05") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "5";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"PSCR");
		}
	}
    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_CORCAL Event="OnLoadCompleted(iCount)">
		alert("보정계산을 마쳤습니다");
		fnc_SearchList();
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        //fnc_SearchList();
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고과점수입력</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">고과점수입력</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_work.gif',1)"><img src="/images/button/btn_work.gif" name="Image1"  border="0" align="absmiddle" onClick="fnc_WorkSearch()"></a>&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_correct.gif',1)"><img src="/images/button/btn_correct.gif" name="Image2"  border="0" align="absmiddle" onClick="fnc_Correct()"></a>&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
	                            <col width="60"></col>
	                            <col width="50"></col>
	                            <col width="50"></col>
	                            <col width="140"></col>
	                            <col width="60"></col>
	                            <col width="140"></col>
	                            <col width="30"></col>
	                            <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">고과자</td>
                                <td class="padding2423">
                                    <input id=txtENOH_NO_SHR name=txtENOH_NO_SHR size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR');">
                                    <input id=txtENOH_NM_SHR name=txtENOH_NM_SHR size="6" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENOH_NM_SHR', 'txtENOH_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENOH_NM_SHR', 'txtENOH_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENOH_NO_SHR','txtENOH_NM_SHR')"></a>
                                </td>
                                <td align="right" class="searchState">구분</td>
                                <td class="padding2423" >
                                    <fieldset style="width:200px">
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" value="0" onClick="JavaScript: {fnc_SearchList();}" >정규직
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="1" onClick="JavaScript: {fnc_SearchList();}">계약직
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="2" onClick="JavaScript: {fnc_SearchList();}">부서장
                                    </fieldset>
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
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:200px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="false">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=1>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='DEPTNM'    	width=95  	name='본사:소속'   align=left      edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PAYGRDNM'   	width=80  	name='직위'      	align=center    edit=none sumbgcolor=#89add6 SumText='평 균'</FC>
                                    <FC> id='EMPNMK'   		width=80  	name='피고과자'   	align=center    edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='SCR'    			width=60   	name='점수'      	align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(SCR),2)}</FC>
                                    <FC> id='AVGSCR'   		width=60  	name='보정'   		align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(AVGSCR),1)} </FC>
                                    <FC> id='ASSES'    		width=45   	name='평가'      	align=center    edit=none sumbgcolor=#89add6 show=false</FC>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:200px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST2">
                                <param name="EdiTABLE"               value="false">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=1>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='DEPTNM'    	width=95  	name='본사외:소속'  align=left      edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PAYGRDNM'   	width=80  	name='직위'      	align=center    edit=none sumbgcolor=#89add6 SumText='평 균'</FC>
                                    <FC> id='EMPNMK'   		width=80  	name='피고과자'   	align=center    edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='SCR'    			width=60   	name='점수'      	align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(SCR),2)}</FC>
                                    <FC> id='AVGSCR'   		width=60  	name='보정'   		align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(AVGSCR),1)} </FC>
                                    <FC> id='ASSES'    		width=45   	name='평가'      	align=center    edit=none sumbgcolor=#89add6 show=false</FC>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>

            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align=right><nobr>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_Clear.gif',1)"><img src="/images/button/btn_Clear.gif" name="Image4"  border="0" align="absmiddle" onClick="fnc_Init()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
						</td>
					</tr>
                    <tr align="center">
                        <td colspan=4>
                            <comment id="__NSID__">
                            <object id="grdT_EV_ABLRST3" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:385px;">
                                <param name="DataID"                 		value="dsT_EV_ABLRST3">
                                <param name="EdiTABLE"               	value="false">
                                <param name="DragDropEnable"         	value="true">
                                <param name="SortView"              	 	value="Left">
                                <param name="VIEWSUMMARY"          value=1>
                                <param name="AutoReSizing"           	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="Format"                 		value="
                                    <FC> id='DIVNM'     		width=50   	name='구분'    		align=center    sumbgcolor=#89add6</FC>
	                                <FC> id='PRTSEQ'    		width=30   	name='순번'   		align=center    sumbgcolor=#89add6</FC>
	                                <FC> id='ASKITEM'   	width=100  	name='평가요소'  	align=left      sumbgcolor=#89add6 SumText='합 계'</FC>
		                            <FG>name='등급'    	HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <C>id='CHK01'    		width=30  	name='탁월'     	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK02'   		width=30  	name='우수'      	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK03'   		width=30  	name='보통'   		align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK04'    		width=30   	name='부족'      	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK05'    		width=30   	name='문제'      	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
                                    </FG>
	                                <FC> id='SCR'   			width=40  	name='점수'  		align=center    sumbgcolor=#89add6 SumText=@sum</FC>
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



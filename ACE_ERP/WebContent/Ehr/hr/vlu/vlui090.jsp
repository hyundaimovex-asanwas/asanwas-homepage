<!--
*****************************************************
* @source       : vlui090.jsp
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
<title>고과점수입력(상향)(vlui090)</title>
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
          }

	      //본사 정보 조회
	      dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
	      dsT_EV_ABLRST.reset();
		  fnc_Reset('q');

	      //본사외 정보 조회
	      dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
	      dsT_EV_ABLRST2.reset();
		  fnc_Reset('q');


	      dsT_EV_SUBMIT.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR_STS&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
	      dsT_EV_SUBMIT.Reset();

		  if(dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"SUBMITST")=="C"){
      		document.form1.txt_SubmitSt.value="입력완료";
		  }else{
			document.form1.txt_SubmitSt.value="미완료";
		  }

        }


        function fnc_SearchList2() {

          //검색조건 4가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//해당년도
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        							//고과자

	      //정보 조회
	      dsT_EV_ABLRST3.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR_SCR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&EMPNO="+GSTR_EMPNO+"&EVASEQ="+GSTR_EVASEQ+"&PAYGRD="+GSTR_PAYGRD;
	      dsT_EV_ABLRST3.reset();

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


						trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST3=dsT_EV_ABLRST3)";
            			trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SAV&REG_YM_SHR="+REG_YM_SHR+"&EMPNO="+GSTR_EMPNO+"&GUBUN="+GUBUN+"&TOTAL_SCR="+TOTAL_SCR;
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

            form1.grdT_EV_ABLRST.GridToExcel("고과점수입력(상향)", '', 225);

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
		document.getElementById("txtENOH_NO_SHR").value="<%=eno_no%>";
		document.getElementById("txtENOH_NM_SHR").value="<%=eno_nm%>";



        cfStyleGrid(form1.grdT_EV_ABLRST,0,"true","false");      // Grid Style 적용
        cfStyleGrid(form1.grdT_EV_ABLRST2,0,"true","false");      // Grid Style 적용
        cfStyleGrid(form1.grdT_EV_ABLRST3,0,"false","false");      // Grid Style 적용

		<%
		    //관리자가 아니면 사번 검색은 하지 못한다.
		    if(!(box.getString("SESSION_ENONO").equals("6060002") || box.getString("SESSION_ENONO").equals("1990071") || box.getString("SESSION_ENONO").equals("2020008")) ) {
		%>
		            fnc_ChangeStateElement(false, "txtENOH_NO_SHR");
		            fnc_ChangeStateElement(false, "txtENOH_NM_SHR");
		            fnc_ChangeStateElement(false, "ImgEnoNo");
		<%
		    }
		%>

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



		/******************************************************************************
			Description : 최종 제출
			              최출시 고과자 사번 9999999 로 update
										고과차수 임의 변경 함.
		******************************************************************************/
		function fnc_Submit(){


	        var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          	var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //고과자
	      	var txt_SubmitSt = document.form1.txt_SubmitSt.value;

			if(REG_YM_SHR<'201011'){
					alert("해당 고과는 제출할 수 없습니다.");
					return;
			}

			 //기존에 입력완료 된 건은 더이상 입력완료 못하게함.
			 if(txt_SubmitSt.value=="입력완료"){
					alert("이미 입력완료 되었습니다.");
					return;
			 }


			 if(dsT_EV_ABLRST.countrow==0 && dsT_EV_ABLRST2.countrow==0){
				  	alert("피고과자가 존재하지 않습니다.");
					return;
			 }

			//피고과자를 하나라도 입력하지 않을 경우 입력완료 못하게 체크함.
			for(i=1;i<=dsT_EV_ABLRST.countrow;i++){
				if(dsT_EV_ABLRST.namevalue(i,"SCR")==0){
						alert("본사소속 고과점수 입력이 완료 되지 않았습니다.");
						return;
				}
			}

			for(j=1;j<=dsT_EV_ABLRST2.countrow;j++){
				if(dsT_EV_ABLRST2.namevalue(j,"SCR")==0){
						alert("본사외소속 고과점수 입력이 완료 되지 않았습니다.");
						return;
				}
			}

			//메세지로 한 번 더 체크  한 번 제출하면 더 이상 수정 불가 함.
			if(confirm("입력완료 후 수정은 불가합니다. 입력완료 하시겠습니까?")){

				    fnc_SetDataHeader();

			     	dsT_EV_SUBMIT.Addrow();

					dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"EVAYM") = REG_YM_SHR.replace("-","");
			     	dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"EMPNOH")= EMPNOH;
					dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"EMPNO") = '<%=box.get("SESSION_ENONO")%>';


					trT_EV_SUTMIT.KeyValue = "tr01(I:dsT_EV_SUBMIT=dsT_EV_SUBMIT)";
            		trT_EV_SUTMIT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SUBMIT";
					trT_EV_SUTMIT.post();

			}else{
					return;
			}

		//저장 update (넘기는 데이터 - 고과년월, 피고과자만을 키로 해서 모든 고과자를 9999999, 차수는 임의로 변경)

		}



		/******************************************************************************
			Description : 최종 제출
			              최출시 고과자 사번 9999999 로 update
										고과차수 임의 변경 함.
		******************************************************************************/
		function fnc_SetDataHeader(){

		  dsT_EV_SUBMIT.clearAll();

			if (dsT_EV_SUBMIT.countrow<1){

				var s_temp = " EVAYM:STRING(6),EMPNOH:STRING(7),EMPNO:STRING(7)";   //고과년월, 고과자, 로그인 사용자 ( 피고과자 아님)

			  	dsT_EV_SUBMIT.SetDataHeader(s_temp);

			}
		}


		function fnc_ASSES(){

			for (i=1;i<=dsT_EV_ABLRST.countrow;i++){

				if(dsT_EV_ABLRST.NameValue(i,"SCR")>=85){
				  	dsT_EV_ABLRST.NameValue(i,"ASSES")="상";
				}else if(dsT_EV_ABLRST.namevalue(i,"SCR")>=75&&dsT_EV_ABLRST.namevalue(i,"SCR")<85){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="중상";
				}else if(dsT_EV_ABLRST.namevalue(i,"SCR")>=65&&dsT_EV_ABLRST.namevalue(i,"SCR")<75){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="중";
				}else if(dsT_EV_ABLRST.namevalue(i,"SCR")>=55&&dsT_EV_ABLRST.namevalue(i,"SCR")<65){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="중하";
				}else if (dsT_EV_ABLRST.namevalue(i,"SCR")>=0&&dsT_EV_ABLRST.namevalue(i,"SCR")<55){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="하";
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

    <Object ID="dsT_EV_SUBMIT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <Object ID ="trT_EV_SUTMIT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

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



	<script language=JavaScript  for=dsT_EV_ABLRST event=OnLoadCompleted(rowcount)>
	  	fnc_ASSES(); //평가
	</script>


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
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <script for=trT_EV_SUBMIT event="OnSuccess()">
            alert("입력완료 하였습니다.");
            fnc_Submit_St();
    </script>
    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
            cfErrorMsg(this);
    </script>

    <script for=trT_EV_SUBMIT event="OnFail()">
            alert("입력완료 하지 못했습니다.");
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고과점수입력(상향)</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">고과점수입력(상향)</font></td>
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
        	<FONT SIZE="2" COLOR="#3300FF" style="position:relative;top:0px">고과점수 입력 후 최종 [입력완료]하셔야 합니다.</FONT>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_InputcompleteOver.gif',1)"><img src="/images/button/btn_InputcompleteOn.gif" name="Image1" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>
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
	                            <col width="100"></col>
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
                                    <fieldset style="width:150px">
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" value="0">정규직
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="1">계약직
                                    </fieldset>
                                </td>
                                <td align="right" class="searchState">제출상태</td>
                                <td class="padding2423">
                                    <input id=txt_SubmitSt name=id=txt_SubmitSt type="text" size="7"  maxlength="7" disabled>
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
                                    <FC> id='DEPTNM'    	width=110  	name='본사:소속'    align=left      edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PAYGRDNM'   	width=70  	name='직위'      	align=center    edit=none sumbgcolor=#89add6 SumText='평 균'</FC>
                                    <FC> id='EMPNMK'   		width=70  	name='피고과자'   	align=center    edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='SCR'    		width=60   	name='점수'      	align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(SCR),2)}</FC>
                                    <FC> id='ASSES'    		width=60   	name='평가'      	align=center    edit=none sumbgcolor=#89add6</FC>
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
                                    <FC> id='DEPTNM'    	width=110  	name='본사외:소속'  align=left      edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PAYGRDNM'   	width=70  	name='직위'      	align=center    edit=none sumbgcolor=#89add6 SumText='평 균'</FC>
                                    <FC> id='EMPNMK'   		width=70  	name='피고과자'   	align=center    edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='SCR'    		width=60   	name='점수'      	align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(SCR),2)}</FC>
                                    <FC> id='ASSES'    		width=60   	name='평가'      	align=center    edit=none sumbgcolor=#89add6</FC>
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
					</tr>
                    <tr align="center">
                        <td colspan=4>
                            <comment id="__NSID__">
                            <object id="grdT_EV_ABLRST3" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:385px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST3">
                                <param name="EdiTABLE"               value="false">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=1>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='DIVNM'     		width=50   	name='구분'    		align=center    sumbgcolor=#89add6</FC>
	                                <FC> id='PRTSEQ'    		width=30   	name='순번'   		align=center    sumbgcolor=#89add6</FC>
	                                <FC> id='ASKITEM'   		width=100  	name='평가요소'  	align=left      sumbgcolor=#89add6 SumText='합 계'</FC>
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



<!--
*****************************************************
* @source       : vlul021.jsp
* @description  : 고과점수 입력 팝업 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/05/07      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>고과점수 입력</title>
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


        var GUBUN   = "";

		var strParam = new Array();

		strParam=window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = strParam[0];        //해당년도
			var ENO_NO = strParam[1];			 //
			var ENO_NM = strParam[2];
			var ENOH_NO = strParam[3];
			var ENOH_NM = strParam[4];
			var HEAD_CD = strParam[5];
		    var JOB_CD = strParam[6];
	  		var GUBUN =  strParam[7];
	  		var EVASEQ =  strParam[8];

			if(GUBUN!="3"){ //정규직, 계약직
			    dsT_EV_RQSCORE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul020.cmd.VLUL020CMD"
												     + "&S_MODE=SHR_ITEM"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
												     + "&ENOH_NO="+ENOH_NO
												     + "&HEAD_CD="+HEAD_CD
												     + "&JOB_CD="+JOB_CD
												     + "&EVASEQ="+EVASEQ;
			    dsT_EV_RQSCORE.reset();

  	  		}

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요
        	return false;
        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

           var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//해당년도
  		   var GUBUN =  strParam[7];
  		   var GSTR_EVASEQ =  strParam[8];
		   var ENOH_NO = strParam[3];
  		   var GSTR_EMPNO =  document.form1.txtENO_NO_SHR.value;
  		   var TOTAL_SCR = 0;


  			if (dsT_EV_RQSCORE.countrow<1){
  				alert ("저장할 정보가 없습니다.");
  			}else {

  				if(fnc_Chk()){

  					if (confirm("저장하시겠습니까?")) {

  							for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){

  								if ((dsT_EV_RQSCORE.SysStatus(i)==2)||(dsT_EV_RQSCORE.SysStatus(i)==3)){
	  									dsT_EV_RQSCORE.namevalue(i,"EMPNOH")=	document.form1.txtENOH_NO_SHR.value;
	  									dsT_EV_RQSCORE.namevalue(i,"EMPNO")	=	document.form1.txtENO_NO_SHR.value;
	  									dsT_EV_RQSCORE.namevalue(i,"EVASEQ")=	GSTR_EVASEQ;
  										}

  								TOTAL_SCR = TOTAL_SCR + dsT_EV_RQSCORE.namevalue(i,"DPT_CH_SCR");
  							}

  						if(GUBUN!="3"){ //정규직, 계약직

  							trT_EV_RQSCORE.KeyValue = "tr01(I:dsT_EV_RQSCORE=dsT_EV_RQSCORE)";

  							trT_EV_RQSCORE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul020.cmd.VLUL020CMD"
								  	  							+ "&S_MODE=SAV"
								  	  							+ "&REG_YM_SHR="+REG_YM_SHR
								  	  							+ "&ENOH_NO="+ENOH_NO
								  	  							+ "&EMPNO="+GSTR_EMPNO
								  	  							+ "&GUBUN="+GUBUN
								  	  							+ "&TOTAL_SCR="+TOTAL_SCR
								  	  							+ "&EVASEQ="+GSTR_EVASEQ;

						   // prompt(this,trT_EV_RQSCORE.action);
						  // prompt(this,dsT_EV_RQSCORE.dataID);
							//prompt(this,dsT_EV_RQSCORE.text);
							//alert(REG_YM_SHR);

  	  	  	  		    }
					//	prompt(this,dsT_EV_RQSCORE.dataID);
					//	prompt(this,dsT_EV_RQSCORE.text);

  						trT_EV_RQSCORE.post();

  						fnc_SearchList();

  				}
  			}

        }
       }

		/**************************************************************************fnc_SetDataHeader****
				Description : 데이타 셋 헤드 설정
			******************************************************************************/
			function fnc_SetDataHeader(){


					if (dsT_EV_RQSCORE.countrow<1){
						var s_temp = " EVAYM:STRING(7),SEQ2:DECIMAL(2),WORKGB:STRING(50),WKCONT:STRING(2048),"
											 + " IMPORT:DECIMAL(3),SCORE:DECIMAL(2),CH_SCORE:DECIMAL(3.1),"
											 + " HEAD_CD:STRING(6),DPT_CD:STRING(6),TEAM_CD:STRING(6),JOB_CD:STRING(3)";
											 + " DPT_IMPORT:DECIMAL(3),SCR:DECIMAL(3.1),"
											 + " SCRGBN:STRING(1),DPT_CH_SCR:DECIMAL(5.3),DPT_CH_SCR:DECIMAL(5.3),EMPNOH:STRING(7),EMPNO:STRING(7),EVQSEQ:STRING(1)";
						dsT_EV_RQSCORE.SetDataHeader(s_temp);
					}


			}



		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk() {

	    	for (i=1;i<=dsT_EV_RQSCORE.countrow;i++){
	    		
					if (dsT_EV_RQSCORE.namevalue(i,"CHK01") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK02") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK03") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK04") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK05") == "F"){

								alert("평가의견을 포함한 모든 평가요소를 체크하십시요");

								dsT_EV_RQSCORE.rowposition = i;

					  			return false;

								break;

						}

			}
	    	

	    	for (i=1;i<=dsT_EV_RQSCORE.countrow;i++){
	    		
				if (dsT_EV_RQSCORE.namevalue(i,"FEEDBACK") == "" || dsT_EV_RQSCORE.namevalue(i,"FEEDBACK") == null ){

							alert(i+"번째 항목의 평가의견을 입력하십시요");

							dsT_EV_RQSCORE.rowposition = i;

				  			return false;

							break;

					}

		}


    		
    		

		  //숫자체크
			var str="";
			var dbltemp=0;

		  	for(i=1;i<=dsT_EV_RQSCORE.countrow;i++){
				dbltemp=dbltemp+dsT_EV_RQSCORE.namevalue(i,"DPT_IMPORT");

		  	}

			if(dbltemp!=100) {
				alert("가중치 합계가 100 이 아닙니다. 확인 바랍니다.");
				return false;
			}

			return true;

	    }

		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk2(row) {


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

			for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){

				dsT_EV_RQSCORE.namevalue(i,"CHK01") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK02") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK03") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK04") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK05") = "F";

			}

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

        	/*
            if (dsT_EV_RQSCORE.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
			*/
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

        fnc_SetDataHeader();

		document.getElementById("txtREG_YM_SHR").value = strParam[0];
		document.getElementById("txtENO_NO_SHR").value = strParam[1];
		document.getElementById("txtENO_NM_SHR").value = strParam[2];

		document.getElementById("txtENOH_NO_SHR").value = strParam[3];
		document.getElementById("txtENOH_NM_SHR").value = strParam[4];

		fnc_SearchList();

		cfStyleGrid6(form1.grdT_EV_RQSCORE);

	    for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){
	   	  if(dsT_EV_RQSCORE.namevalue(i,"DPT_IMPORT") == "0")
    	  {
    	  	dsT_EV_RQSCORE.namevalue(i,"DPT_IMPORT")=dsT_EV_RQSCORE.namevalue(i,"IMPORT");
    	  	}//dsT_EV_RQSCORE.namevalue(i,"CH_SCR") = dsT_EV_RQSCORE.namevalue(i,"CH_SCR")  ;
	      }
        }



        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>


    <Script For=grdT_EV_RQSCORE Event="OnClick(row,col)">


		if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {

			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "F";

			if ("CHK01" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "1";
                dsT_EV_RQSCORE.namevalue(row,"SCR") = "10" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
				//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK02" == col) {
				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "2";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "8.5" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
			//	dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK03" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "3";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "7" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
			//	dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK04" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "4";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "5.5" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
		//		dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK05" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "5";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "4" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
			//	dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}

		} dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
		//	dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;



    </Script>

	 <Script For=grdT_EV_RQSCORE Event="OnExit(row,colid,olddata)" >

	 dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;
	// dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR2") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;


	</Script>





    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_RQSCORE)                       |
    | 3. 사용되는 Table List(T_EV_RQSCORE)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_RQSCORE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_RQSCORE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_RQSCORE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_RQSCORE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_RQSCORE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_RQSCORE event="OnFail()">
        if (trT_EV_RQSCORE.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1150" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1150" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="200"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly"  readOnly>
                               </td>
                                <td align="right" class="searchState">피고과자</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                </td>
                                <td align="right" class="searchState">고과자</td>
                                <td class="padding2423">
                                    <input id=txtENOH_NO_SHR name=txtENOH_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENOH_NM_SHR name=txtENOH_NM_SHR size="12" class="input_ReadOnly"  readOnly>
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
<table width="1150" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" width="600" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->


<!-- 내용 조회 그리드 테이블 시작-->
<table width="1150" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_RQSCORE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1160px;height:640px;">
                                <param name="DataID"                 		value="dsT_EV_RQSCORE">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="AutoReSizing"           	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="RowHeight"   				value='20'>
								<param name=TitleHeight 					value="20">
								<param name="VIEWSUMMARY"          value=1>
    							<Param Name="SummaryHeight"  		value="40">								
                                <param name="Format"                 		value="
                                <C> id='TEAM_CD'     		width=20   	name='team'    				align=center   edit=none show=false</C>
                                <C> id='DPT_CD'     		width=20   	name='DEPT'    				align=center   edit=none show=false</C>
                                <C> id='HEAD_CD'     		width=20   	name='DEPT'    				align=center   edit=none show=false</C>
                                    <C> id='SEQ2'     		width=30   	name='No'    				align=center   edit=none  sumbgcolor=#dae0ee   </C>
                                    <C> id='WORKGB'    		width=90  	name='항 목'   				align=left     wordwrap=wordex Multiline=true scroll=vert edit=none sumbgcolor=#dae0ee </C>
                                    <C> id='WKCONT'    		width=400  name='주 요 내 용'   			align=left     wordwrap=wordex Multiline=true scroll=both sumbgcolor=#dae0ee SumText='합 계'</C>
                                <G> Name='본 인 평 가' HeadAlign=Center HeadBgColor=#dae0ee 
                                    <C> id='IMPORT'    		width=50  	name='가중치'   			align=center  edit=none  sumbgcolor=#dae0ee SumText={(sum(IMPORT))} </C>
									<C> id='SCORE'    		width=35  	name='점수'   				align=center  edit=none value={IF(SCORE='0','',SCORE)} dec=0  sumbgcolor=#dae0ee  </C>
									<C> id='CH_SCORE'    	width=60  	name='환산점수'   			align=center  value={Round((CH_SCORE),3)} dec=3  sumbgcolor=#dae0ee SumText={Round(sum(CH_SCORE),3)}  edit=none  show=false </C>
									<C> id='CH_SCORE2'    	width=60  	name='환산점수'				align=center value={Round((CH_SCORE),2)} dec=1  sumbgcolor=#dae0ee SumText={Round(sum(CH_SCORE),2)}  edit=none  </C>
							    </G>
								<G> Name='평가자 평가' HeadAlign=Center HeadBgColor=#dae0ee
										<C>id='DPT_IMPORT'    	width=50  	name='가중치'  		align=center sumbgcolor=#dae0ee SumText={(sum(DPT_IMPORT))} BodyFontStyle=bold  </C>
	                                    <C>id='CHK01'    			width=35  	name='S'     		align=center  EditStyle=CheckBox  BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK02'   			width=35  	name='A'      		align=center  EditStyle=CheckBox  BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK03'   			width=35  	name='B'   			align=center  EditStyle=CheckBox  BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK04'    			width=35   	name='C'      		align=center  EditStyle=CheckBox BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK05'    			width=35   	name='D'      		align=center  EditStyle=CheckBox BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C> id='SCR'       			width=35   	name='결과' 			align=center  edit=none value={IF(SCR='0','',SCR)} dec=1  sumbgcolor=#dae0ee </C>
										<C> id='DPT_CH_SCR'       	width=60   	name='환산점수' 		align=center  value={Round((DPT_CH_SCR),3)} dec=3  SumText={Round(sum(DPT_CH_SCR),3)} sumbgcolor=#dae0ee edit=none show=false </C>
										<C> id='DPT_CH_SCR2'       	width=60   	name='환산점수'  		align=center  value={Round((DPT_CH_SCR),2)} dec=1  SumText={Round(sum(DPT_CH_SCR),2)} sumbgcolor=#dae0ee edit=none BodyFontStyle=bold BgColor=#E3E3FF SumFontStyle=bold</C>
										<C> id='FEEDBACK'       	width=140   name='평가의견'  		align=center  wordwrap=wordex Multiline=true scroll=both sumbgcolor=#dae0ee</C>

								</G>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
				</table>
		</td>
		</tr>
		<tr>
			<td align="left" class="blueBold" ;><font color="red" size="2" bold="5">※ 가중치 조정 가능: 항목별 가중치 선택후 변경 가중치 입력.
												<br>※ 주요 업적내용이 칸 부족으로 보이지 않을경우 해당항목을 더블클릭 하시면 보여집니다. </font>
			</td>
		</tr>
</table>


<!-- 내용 조회 그리드 데이블 끝-->
</form>
<!-- form 끝 -->
</body>
</html>


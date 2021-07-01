<!--*************************************************************************
* @source      : taxa030.jsp                                                *
* @description : 정산계산처리 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>정산계산처리(taxa030)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTFFFT';

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            var vPIS_YM     = document.getElementById("txtPIS_YM").value;
            var vOCC_CD     = document.getElementById("cmbOCC_CD").value;
            var vSAL_GBN    = document.getElementById("cmbSAL_GBN").value;


			//해당년월이 없으면 조회못함.
			if(vPIS_YM.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월을 입력하세요.");
					document.getElementById("txtPIS_YM").focus();
					return false;
				}
			}

			//해당년월이 잘못되었으면 조회못함.
			if(vPIS_YM.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YM").focus();
					return false;
				}
			}

            //날짜 가져오기
            var dayArray = vPIS_YM.split("-");

            var params = "&S_MODE=SHR"
                       + "&PIS_YY="+dayArray[0]
                       + "&PIS_MM="+dayArray[1]
                       + "&OCC_CD="+vOCC_CD
                       + "&SAL_GBN="+vSAL_GBN;

            dsT_CP_WORKLOG.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD"+params;
            dsT_CP_WORKLOG.Reset();


            //퇴직자 정산일때 정산 대상자 리스트를 조회한다.
            document.getElementById("resultMessage").innerText = " ";
            if(vSAL_GBN == "9") {

                params = "&S_MODE=SHR_RET"
                       + "&PIS_YM="+dayArray[0]+dayArray[1]
                       + "&OCC_CD="+vOCC_CD

                dsT_AC_RETTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD"+params;
                dsT_AC_RETTABLE.Reset();


                fnc_ShowElement  ("layLIST");
            } else {
                fnc_HiddenElement("layLIST");
            }

        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {

        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {

            //fnc_OnLoadProcess();
            disableInput();//입력필드 비활성화

            dsT_CP_WORKLOG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';
   			document.getElementById("txtPRO_STS_MSG").value   = ""; // 작업메세지
   			document.getElementById("cmbOCC_CD").value        = "A"; // 근로구분구분
   	//		document.getElementById("cmbSAL_GBN").value       = "9"; // 정산구분
			document.form1.txtPIS_YM.focus();

            fnc_HiddenElement("layLIST");

        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_WORKLOG_01.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //첫번째 인수 : 그리드명                                                     두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"false","false");

            //년도 초기화
            //document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM").value = '2014-12';

			//근로구분
			document.getElementById("cmbOCC_CD").value        = "A";
			if(document.getElementById("cmbOCC_CD").length == 0){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD").add(oOption);
				}
			}

			disableInput();//입력필드 비활성화

			fnc_SearchList();

        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /**
         * 1:대상자 선정
         */
        function fnc_proc1() {

            var oPIS_YM     = document.getElementById("txtPIS_YM").value; // 해당년월
            var oOCC_CD     = document.getElementById("cmbOCC_CD").value; // 근로구분구분
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN").value;//정산구분
			var i = 1;

            if (confirm("대상자 선정을 하시겠습니까? ") == false) return;

            //날짜 가져오기
            var dayArray = oPIS_YM.split("-");

            dsT_CP_WORKLOG.NameValue(i,"PIS_YY")=dayArray[0];
			dsT_CP_WORKLOG.NameValue(i,"PIS_MM")=dayArray[1];
			dsT_CP_WORKLOG.NameValue(i,"OCC_CD")=oOCC_CD;
			dsT_CP_WORKLOG.NameValue(i,"SAL_GBN")=oSAL_GBN;

			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC1";
            trT_CP_WORKLOG.post();
        }

        /**
         * 2:대상자선정추가
         */
        function fnc_proc2() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("대상자 추가를 하시겠습니까? ") == false) return;

			PRO_STS = "7";//대상자선정추가으로 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;
			dsT_CP_WORKLOG.UserStatus(i) = 1;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC2";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 3:년말정산계산
         */
        function fnc_proc3() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("정산계산작업을 하시겠습니까? ") == false) return;

			PRO_STS = "2";//년말정산계산으로 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC3";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 4:작업종료
         */
        function fnc_proc4() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("작업종료를 하시겠습니까? ") == false) return;

			PRO_STS = "3";//작업종료 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC4";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 5:재작업 (대상자선정)
         */
        function fnc_proc5() {

        	var oSAL_GBN    = document.getElementById("cmbSAL_GBN").value;//정산구분
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("대상자 초기화를 하시겠습니까? ") == false) return;

			PRO_STS = "0";//대상자선정 이전으로 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC5";
			trT_CP_WORKLOG.Post();

         }

        /**
         * 6:재작업(정산계산)
         */
        function fnc_proc6() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("정산계산작업 초기화를 하시겠습니까? ") == false) return;

			PRO_STS = "1";//대상자선정으로 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC6";
			trT_CP_WORKLOG.Post();
        }

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(state){

			//조회필드는 사용 불가능하게
			document.form1.txtPIS_YM.readOnly = true;
  			document.form1.txtPIS_YM.className = "input_ReadOnly";
  			document.getElementById("imgPIS_YM").disabled = true;
  			document.getElementById("cmbOCC_CD").disabled = true;
  			document.getElementById("cmbSAL_GBN").disabled = true;

  			if(state == "0"){//대상자선정 가능
	  			document.getElementById("btnPROC1").disabled = false;
				document.getElementById("btnPROC1").className="";//대상자선정
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정추가
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//재작업(대상자선정)
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//재작업(정산계산)

  			}

  			else if(state == "1" || state == "7"){//대상자선정 완료
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="";//대상자선정추가
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//재작업(대상자선정)
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//재작업(정산계산)

  			}

  			else if(state == "2" ){//년말정산계산 완료
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정추가
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = false;
				document.getElementById("btnPROC4").className="";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//재작업(대상자선정)
	  			document.getElementById("btnPROC6").disabled = false;
				document.getElementById("btnPROC6").className="";//재작업(정산계산)

  			}

  			else if(state == "3" || state == "4"){//작업종료,자료반영
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정추가
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//재작업(대상자선정)
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//재작업(정산계산)

  			}

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			//조회필드는 사용 가능하게
			document.form1.txtPIS_YM.readOnly = false;
  			document.form1.txtPIS_YM.className = "";
  			document.getElementById("imgPIS_YM").disabled = false;
  			document.getElementById("cmbOCC_CD").disabled = false;
  			document.getElementById("cmbSAL_GBN").disabled = false;

  			document.getElementById("btnPROC1").disabled = true;
			document.getElementById("btnPROC1").className="inputDisabled";//대상자선정
  			document.getElementById("btnPROC2").disabled = true;
			document.getElementById("btnPROC2").className="inputDisabled";//대상자선정추가
  			document.getElementById("btnPROC3").disabled = true;
			document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
  			document.getElementById("btnPROC4").disabled = true;
			document.getElementById("btnPROC4").className="inputDisabled";//작업종료
  			document.getElementById("btnPROC5").disabled = true;
			document.getElementById("btnPROC5").className="inputDisabled";//재작업(대상자선정)
  			document.getElementById("btnPROC6").disabled = true;
			document.getElementById("btnPROC6").className="inputDisabled";//재작업(정산계산)

  		}

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)                |
    | 3. 사용되는 Table List(T_CP_WORKLOG)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=200000>
    </Object>

    <Object ID="dsT_CP_WORKLOG_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=200000>
    </Object>

    <Object ID="dsT_AC_RETTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=200000>
    </Object>


   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_WORKLOG)                |
    | 3. 사용되는 Table List(T_CP_WORKLOG)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        if(iCount == 0) {
			document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 할 수 있습니다.";

	        dsT_CP_WORKLOG.AddRow();

			enableInput("0");

        } else {
            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 완료하였습니다.";
				enableInput("1");
            }else if(PRO_STS == "7"){
                document.getElementById("txtPRO_STS_MSG").value = "대상자 추가를 완료하였습니다.";
				enableInput("7");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "정산계산을 완료하였습니다.";
				enableInput("2");
            }else if(PRO_STS == "3"){
               	//document.getElementById("txtPRO_STS_MSG").value = "작업을 종료하였습니다. 연말정산자료 급여반영이 가능합니다.";
               	document.getElementById("txtPRO_STS_MSG").value = "작업을 종료하였습니다.";
               	enableInput("3");
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "자료를 반영하였습니다.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	//document.getElementById("txtPRO_STS_MSG").value = "재작업(대상자선정)을 완료하였습니다.";
            }else if(PRO_STS == "6"){
               	//document.getElementById("txtPRO_STS_MSG").value = "재작업(정산계산)을 완료하였습니다.";
            }

        }

        var vPIS_YM     = document.getElementById("txtPIS_YM").value;
        var vOCC_CD     = document.getElementById("cmbOCC_CD").value;
        var vSAL_GBN    = document.getElementById("cmbSAL_GBN").value;

        //날짜 가져오기
        var dayArray = vPIS_YM.split("-");

        var params = "&S_MODE=SHR_01"
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+vOCC_CD
                   + "&SAL_GBN="+vSAL_GBN;

        //미처리인원 조회
        dsT_CP_WORKLOG_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD"+params;
        dsT_CP_WORKLOG_01.Reset();

    </Script>

    <Script For=dsT_CP_WORKLOG_01 Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            if(dsT_CP_WORKLOG_01.NameValue(1,"CNT") != "0"){
                dsT_CP_WORKLOG.NameValue(1,"ERR_CNT") = dsT_CP_WORKLOG_01.NameValue(1,"CNT");
            }
        }
    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_WORKLOG_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_WORKLOG_01 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
		fnc_SearchList();//재조회
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">정산계산처리</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">정산계산처리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="100"></col>
					<col width="160"></col>
					<col width="80"></col>
					<col width="160"></col>
                    <col width="80"></col>
                    <col width="160"></col>
					<col width="10"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">해당년월</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YM" name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','80','108');"></a>
					</td>
                    <td class="searchState" align="right">대&nbsp;&nbsp;&nbsp;상</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD" id="cmbOCC_CD">
                        	<option value="A">전체</option>
                        </select>
                    </td>
                    <td class="searchState" align="right">정산구분</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN" id="cmbSAL_GBN">
                            <option value="8">연말정산</option>
                            <!--  <option value="9">퇴직자정산</option> -->
                        </select>
                    </td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->


    <!-- 조건 입력 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    	<tr>
            <td class="paddingTop8">
    			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    				<colgroup>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    	        		<td align="center" class="creamBold">대상인원</td>
    	        		<td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <colgroup>
                                    <col width="200"></col>
                                    <col width="200"></col>
                                    <col width="100"></col>
                                    <col width=""></col>
                                </colgroup>
                                <tr>
                                    <td align="right">처리인원&nbsp;</td>
    	        		            <td ><input id="txtPRO_CNT" name="txtPRO_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
    	        		            <td align="right">미처리인원&nbsp;</td>
    	        		            <td ><input id="txtERR_CNT" name="txtERR_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
    	        		        <tr>
    	        		    </table>
    	        		</td>
    				</tr>
    				<tr>
    	        		<td align="center" class="creamBold">작업상황</td>
    	        		<td  class="padding2423">
    	        			<input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
    	        			<input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
    	        		</td>
    	            </tr>
                    <tr>
                        <td align="center" class="creamBold">작업선택</td>
                        <td  class="padding2423">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" 작업시작">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" 대상자선정 " onclick="fnc_proc1()">
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" 정산계산작업 " onclick="fnc_proc3()">
                                    </td>
                                </tr>
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" 작업종료 " onclick="fnc_proc4()">
                                        <input type="button" id="btnPROC5" style="cursor:hand;width:140pt;height:25pt;" value=" 대상자선정 초기화 " onclick="fnc_proc5()">
                                        <input type="button" id="btnPROC6" style="cursor:hand;width:140pt;height:25pt;" value=" 정산계산작업 초기화 " onclick="fnc_proc6()">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- 조건 입력 테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
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
    <div id="layLIST" style={display:none;position:absolute;}>
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr align="center">
                <td>
                    <comment id="__NSID__">
                    <object id="grdT_AC_RETTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:160px;">
                        <param name="DataID"                    value="dsT_AC_RETTABLE">
                        <param name="EdiTABLE"                  value="false">
                        <param name="DragDropEnable"            value="true">
                        <param name="SortView"                  value="Left">
                        <param name="VIEWSUMMARY"               value=0>
                        <param name="Format"                value="
                            <C> id='{CUROW}'        width=40            name='NO'               align=center        value={String(Currow)}      </C>
                            <C> id='DPT_NM'         width=95            name='소속'             align=center                                    </C>
                            <C> id='JOB_NM'         width=95            name='직위'             align=center                                    </C>
                            <C> id='ENO_NO'         width=95            name='사번'             align=center                                    </C>
                            <C> id='ENO_NM'         width=95            name='성명'             align=center                                    </C>
                            <C> id='HIR_YMD'        width=90            name='입사일'          align=center                                    </C>
                            <C> id='RET_YMD'        width=90            name='퇴직정산일'       align=center                                    </C>
                            <C> id='LSE_MM'         width=90            name='근무월수'         align=center                                    </C>
                            <C> id='RET_AMT'        width=90            name='퇴직금액'         align=right                                    </C>
                            <C> id='ICM_TAX'        width=90            name='소득세'         align=right                                    </C>
                            <C> id='DJM_TAX'        width=90            name='주민세'         align=right                                    </C>
                            <C> id='RET_AMT2'        width=90            name='정산금액'         align=right         value={(RET_AMT-ICM_TAX-DJM_TAX)}	                           </C>
                        ">
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                </td>
            </tr>
        </table>
    </div>
    <!-- 내용 조회 그리드 데이블 끝-->


    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

<object id="bndT_CP_WORKLOG" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_WORKLOG">
	<Param Name="BindInfo", Value='
		<C>Col=PRO_STS     		 	Ctrl=txtPRO_STS     		 	Param=value 		</C>
		<C>Col=PRO_CNT     		 	Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		     	Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>
<!--*************************************************
* @source      : yaca090_14.jsp                                                 *
* @description : 연말정산계산처리 PAGE                                         *
****************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*-----------------------------------------------------------------
* 2015/01/27            이동훈             최초작성                                         *
****************************************************-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

    <title>연말정산계산처리(yaca090_14)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

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


            //날짜 가져오기
            var dayArray = vPIS_YM.split("-");

            var params = "&S_MODE=SHR"
                       + "&PIS_YY="+dayArray[0]
                       + "&PIS_MM="+dayArray[1];

            dsT_CP_WORKLOG.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD"+params;
            dsT_CP_WORKLOG.Reset();


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

            disableInput();//입력필드 비활성화

            dsT_CP_WORKLOG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtPIS_YM.focus();

        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
        	
			window.close();
			
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

            //년도 초기화
            document.getElementById("txtPIS_YM").value = '2014-12';

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
         * 2:대상자 선정
         */
        function fnc_proc2() {

            var oPIS_YM     = document.getElementById("txtPIS_YM").value; // 해당년월

			var i = 1;

            if (confirm("대상자 선정을 하시겠습니까? ") == false) return;

			PRO_STS = "2";//년말정산계산으로 변경            

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;			

			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC2";
            trT_CP_WORKLOG.post();
        }


        /**
         * 3:년말정산계산
         */
        function fnc_proc3() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("정산계산작업을 하시겠습니까? ") == false) return;

			PRO_STS = "3";//년말정산계산으로 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC3";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 4:작업종료
         */
        function fnc_proc4() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("작업종료를 하시겠습니까? ") == false) return;

			PRO_STS = "4";//작업종료 변경

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC4";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 5:대상자선정 초기화
         */
        function fnc_proc5() {

			var i = 1;
			
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("대상자 초기화를 하시겠습니까? ") == false) return;

			PRO_STS = "5";//대상자선정 초기화

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC5";
			trT_CP_WORKLOG.Post();

         }

        /**
         * 6:정산계산작업 초기화
         */
        function fnc_proc6() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("정산계산작업 초기화를 하시겠습니까? ") == false) return;

			PRO_STS = "6";//정산계산작업 초기화

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC6";
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


  			if(state == "1"){//작업시작
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//작업시작
	  			document.getElementById("btnPROC2").disabled = false;
				document.getElementById("btnPROC2").className="";//대상자선정
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//대상자선정 초기화
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//년말정산계산 초기화

  			}else if(state == "2" ){//대상자선정 완료
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//작업시작
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//대상자선정 초기화
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//년말정산계산 초기화				
				
  			}else if(state == "3" ){//년말정산계산 완료
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//작업시작
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = false;
				document.getElementById("btnPROC4").className="";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//대상자선정 초기화
	  			document.getElementById("btnPROC6").disabled = false;
				document.getElementById("btnPROC6").className="";//년말정산계산 초기화

  			}else if(state == "4"){//작업종료
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//작업시작
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//대상자선정 초기화
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//년말정산계산 초기화

  			}else if(state == "5"){//대상자선정 초기화
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//작업시작
	  			document.getElementById("btnPROC2").disabled = false;
				document.getElementById("btnPROC2").className="";//대상자선정
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//대상자선정 초기화
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//년말정산계산 초기화				
				
  			}else if(state == "6"){//정산계산작업 초기화
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//작업시작
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//년말정산계산
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//작업종료
	  			document.getElementById("btnPROC5").disabled = false;
				document.getElementById("btnPROC5").className="";//대상자선정 초기화
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//년말정산계산 초기화						
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

  			document.getElementById("btnPROC1").disabled = true;
			document.getElementById("btnPROC1").className="inputDisabled";//작업시작
  			document.getElementById("btnPROC2").disabled = true;
			document.getElementById("btnPROC2").className="inputDisabled";//대상자선정
  			document.getElementById("btnPROC3").disabled = true;
			document.getElementById("btnPROC3").className="inputDisabled";//년말정산계산
  			document.getElementById("btnPROC4").disabled = true;
			document.getElementById("btnPROC4").className="inputDisabled";//작업종료
  			document.getElementById("btnPROC5").disabled = true;
			document.getElementById("btnPROC5").className="inputDisabled";//대상자선정 초기화
  			document.getElementById("btnPROC6").disabled = true;
			document.getElementById("btnPROC6").className="inputDisabled";//년말정산계산 초기화

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

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "작업을 시작하였습니다.";
				enableInput("1");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 완료하였습니다.";
				enableInput("2");				
            }else if(PRO_STS == "3"){
               	document.getElementById("txtPRO_STS_MSG").value = "정산계산을 완료하였습니다.";
				enableInput("3");
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "작업을 종료하였습니다.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	document.getElementById("txtPRO_STS_MSG").value = "대상자선정 초기화를 완료하였습니다.";
               	enableInput("5");
            }else if(PRO_STS == "6"){
               	document.getElementById("txtPRO_STS_MSG").value = "정산계산작업 초기화를 완료하였습니다.";
               	enableInput("6");               	
            }

    </Script>

    <Script For=dsT_CP_WORKLOG_01 Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
        	
        } else {

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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">연말정산계산처리</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">연말정산계산처리</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
	<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="10"></col>
					<col width="160"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="center">해당년월</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YM" name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','80','108');"></a>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->


    <!-- 조건 입력 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
    	<tr>
            <td class="paddingTop8">
    			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    				<colgroup>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    	        		<td align="center" class="blueBold">대상인원</td>
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
    	        		<td align="center" class="blueBold">작업상황</td>
    	        		<td  class="padding2423">
    	        			<input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
    	        			<input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
    	        		</td>
    	            </tr>
                    <tr>
                        <td align="center" class="blueBold">작업선택</td>
                        <td  class="padding2423">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" 작업시작">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" 대상자선정 " onclick="fnc_proc2()">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" 정산계산작업 " onclick="fnc_proc3()">
                                    </td>
                                </tr>
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" 작업종료 " onclick="fnc_proc4()">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type="button" id="btnPROC5" style="cursor:hand;width:140pt;height:25pt;" value=" 대상자선정 초기화 " onclick="fnc_proc5()">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		<C>Col=PRO_CNT     		Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		     	Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>
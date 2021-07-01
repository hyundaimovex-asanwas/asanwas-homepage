	<!--*************************************************************************
	* @source      : guna015.jsp												*
	* @description : GROUPWARE 로그인 체크 PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/11/12            권혁수                      로그인 근태신청최초작성
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	String ENO_NO = request.getParameter("ENO_NO").substring(3);
	String LOGIN_IP = request.getRequestURL().toString();
	//System.out.println("LOGIN_IP [" + LOGIN_IP + "]");
%>


<html>
<head>
	<title>로그인 체크(guna015)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TTTTFFTT';

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
			var ENO_NO = "<%=ENO_NO%>";
			var GUN_YMD = getToday();
			//GUN_YMD = "20110105";
			// save
			if(ENO_NO == null || ENO_NO == ""){

			}else{

				//등록시간 체크
				if( new Date().getHours() >= "9"){
					//return false;
				}

				fnc_AddNew();

				trT_DI_GROUPWARE.KeyValue = "tr01(I:dsT_DI_GROUPWARE=dsT_DI_GROUPWARE)";
				trT_DI_GROUPWARE.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=GROUPWARE_SAV&ENO_NO="+ENO_NO+"&GUN_YMD="+GUN_YMD;
				trT_DI_GROUPWARE.post();

			}
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			dsT_DI_GROUPWARE.AddRow();
			dsT_DI_GROUPWARE.NameValue(1, "ENO_NO") = "<%=ENO_NO%>";
        }



		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {

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

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	        dsT_DI_GROUPWARE.SetDataHeader(
								"ENO_NO:STRING(10),"+			// 사번
								"LOGIN_IP:STRING(20)"			// LOGIN_IP
								);
			fnc_Save();
        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_GROUPWARE)			 	   |
    | 3. 사용되는 Table List(T_DI_GROUPWARE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_GROUPWARE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_GROUPWARE)		       |
    | 3. 사용되는 Table List(T_DI_GROUPWARE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_GROUPWARE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_GROUPWARE=dsT_DI_GROUPWARE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_GROUPWARE Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_GROUPWARE Event="OnLoadError()">
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_GROUPWARE event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_GROUPWARE event="OnFail()">
    </script>

  </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onload="fnc_OnLoadProcess();">

	<!-- form 시작 -->
	<form name="form1">
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">Group Ware 로그인 체크</td>
					<td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">Group Ware 로그인 체크</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	</form>
	<!-- form 끝 -->
</body>
</html>

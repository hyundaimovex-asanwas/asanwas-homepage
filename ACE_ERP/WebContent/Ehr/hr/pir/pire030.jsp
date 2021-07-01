<!--
***********************************************************************
* @source      : pire030.jsp
* @description : 자격증/전공현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2008/08/18      김경주        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>자격증/전공현황(pire030)</title>
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

		var btnList = 'TFFTTTFT';
		var today = getToday();

        var ActiveIndex = 0;


		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            var QUA_SHR = document.getElementById("txtQUA_SHR").value;
            var MAJ_SHR = document.getElementById("txtMAJ_SHR").value;

            var COMM_CNT = dsT_CM_COMMON.CountRow;
            var COMM_CD = '';
            var COMM_CNT_01 = dsT_CM_COMMON_01.CountRow;
            var COMM_CD_01 = '';

            if (dsT_CM_COMMON.CountRow > 0) {
                for (var i = 0; i < dsT_CM_COMMON.CountRow; i++) {
                    COMM_CD = COMM_CD + dsT_CM_COMMON.NameValue(i + 1, "COMM_CD") + ",";
                }
            }

            if (dsT_CM_COMMON_01.CountRow > 0) {
                for (var i = 0; i < dsT_CM_COMMON_01.CountRow; i++) {
                    COMM_CD_01 = COMM_CD_01 + dsT_CM_COMMON_01.NameValue(i + 1, "COMM_CD") + ",";
                }
            }

			if(ActiveIndex==1){   //자격증 조회
			   	dsT_CM_QUALIFICATION.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire030.cmd.PIRE030CMD&S_MODE=SHR_01&QUA_SHR="+QUA_SHR+"&COMM_CNT="+COMM_CNT+"&COMM_CD="+COMM_CD;
			    dsT_CM_QUALIFICATION.reset();
			}else{               // 전공 조회
				dsT_CM_SCHOOL.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire030.cmd.PIRE030CMD&S_MODE=SHR_02&MAJ_SHR="+MAJ_SHR+"&COMM_CNT_01="+COMM_CNT_01+"&COMM_CD_01="+COMM_CD_01;
			    dsT_CM_SCHOOL.reset();
			}

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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
        	alert("서비스 준비중입니다.");
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

	        if(ActiveIndex==1){
				if (dsT_CM_QUALIFICATION.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CM_QUALIFICATION.GridToExcel("자격증현황", '', 225)

			}else{
				if (dsT_CM_SCHOOL.CountRow < 1) {
					alert("엑셀로 변환할 자료가 없습니다!");
					return;
				}
	            form1.grdT_CM_SCHOOL.GridToExcel("전공현황", '', 225)
			}
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  					    *
         ********************************************/
        function fnc_Clear() {

            document.getElementById("cmbRCV_DPT").length  = 0;
            document.getElementById("cmbRCV_DPT1").length = 0;

        	document.getElementById("resultMessage").innerText = '';

        	document.getElementById("txtQUA_SHR").value = '';
        	document.getElementById("txtMAJ_SHR").value = '';

        	dsT_CM_QUALIFICATION.ClearData();
        	dsT_CM_SCHOOL.ClearData();
        	dsT_CM_COMMON.ClearData();
        	dsT_CM_COMMON_01.ClearData();

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  			    *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   *
         ********************************************/
        function fnc_OnLoadProcess() {
            //버튼들 초기화
            TabEvent(0);


			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CM_QUALIFICATION,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_CM_SCHOOL,0,"false","false");      // Grid Style 적용


        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //Layer ID
        var layerList = new Array(  "tabPIRE030_01"
                                   ,"tabPIRE030_02" );

        //검색조건
        var searchList = new Array( "changeDate_01"
                                   ,"changeDate_02" );

        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {

            ActiveIndex = idx+1;

            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            fnc_ShowHiddenLayer(searchList, searchList[idx]);


            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";

        }

       /********************************************************
        * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
        *******************************************************/

       function fnc_selectDPT_01(ctrl_01) {

            var cd_gbn ='H1';
			var url = "./pire031.jsp?CD_GBN="+cd_gbn;
			window.showModalDialog(url, ctrl_01,  "dialogHeight:500px; dialogWidth:750px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			return ctrl_01;
		}


		function fnc_selectDPT_02(ctrl_01) {

            var cd_gbn ='E6';
			var url = "./pire031.jsp?CD_GBN="+cd_gbn;
			window.showModalDialog(url, ctrl_01,  "dialogHeight:500px; dialogWidth:750px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			return ctrl_01;
		}

       function find_Qua(){

            var tempDS = fnc_selectDPT_01(dsT_CM_COMMON);
			document.getElementById('cmbRCV_DPT').length = 0;

			var oOption;
			for(var i=0 ; i<tempDS.CountRow ; i++) {

				oOption = document.createElement("OPTION");
				oOption.text = tempDS.NameValue(i+1, 'COMM_CD')+" "+tempDS.NameValue(i+1, 'COMM_NM');
				oOption.value = tempDS.NameValue(i+1, 'COMM_CD');

				document.getElementById('cmbRCV_DPT').add(oOption);
			}
     	}

       function find_Maj(){

            var tempDS = fnc_selectDPT_02(dsT_CM_COMMON_01);
			document.getElementById('cmbRCV_DPT1').length = 0;

			var oOption;
			for(var i=0 ; i<tempDS.CountRow ; i++) {

				oOption = document.createElement("OPTION");
				oOption.text = tempDS.NameValue(i+1, 'COMM_CD')+" "+tempDS.NameValue(i+1, 'COMM_NM');
				oOption.value = tempDS.NameValue(i+1, 'COMM_CD');

				document.getElementById('cmbRCV_DPT1').add(oOption);
			}
       }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_QUALIFICATION)	   |
    | 3. 사용되는 Table List(T_CM_QUALIFICATION) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_SCHOOL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON)		   |
    | 3. 사용되는 Table List(dsT_CM_COMMON) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON_01)	   |
    | 3. 사용되는 Table List(dsT_CM_COMMON_01) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_COMMON_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_QUALIFICATION Event="OnLoadCompleted(iCount)">
  		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsT_CM_SCHOOL Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_CM_QUALIFICATION Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
	<Script For=dsT_CM_SCHOOL Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 |
    +----------------------------------------------------------------->
	<Script For=dsT_CM_QUALIFICATION Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_CM_SCHOOL Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>




	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">자격증/전공현황</td>
					<td align="right" class="navigator">HOME/인사관리/인사현황데이터<font color="#000000">자격증/전공현황</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    		     <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
                                <col width="80"></col>
                                <col width="500"></col>
                                <col width="*"></col>
                    </colgroup>
    				<tr>
    				    <td>&nbsp;</td>
    				    <td>
	                        <div id="changeDate_01" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:2;" >
                                <table width="100%" >
                                <col width="15%"></col>
                                <col width="20%"></col>
                                <col width="5%"></col>
                                <col width="*"></col>
                                <tr>
                                <td class="searchState" align="right">자격증</td>
                                <td class="padding2423" align="left">
                                     <input type="text" id="txtQUA_SHR" name="txtQUA_SHR" size="10" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                </td>
                                <td> <select id="cmbRCV_DPT" name="cmbRCV_DPT"> </select> </td>
								<td>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgQualification" name="ImgQualification" width="21" height="20" border="0" align="absmiddle" onClick="find_Qua();"></a>
								</td>
                                </tr>
                                </table>
	       				    </div>
	                        <div id="changeDate_02" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:1; visibility:hidden" >
                                <table width="100%" >
                                <col width="15%"></col>
                                <col width="20%"></col>
                                <col width="5%"></col>
                                <col width="*"></col>
                               <tr>
                                <td class="searchState" align="right">전공&nbsp;</td>
                                <td class="padding2423" align="left">
                                     <input type="text" id="txtMAJ_SHR" name="txtMAJ_SHR" size="10" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                </td>
                                <td> <select id="cmbRCV_DPT1" name="cmbRCV_DPT1"> </select> </td>
                                <td>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgQualification" name="ImgQualification" width="21" height="20" border="0" align="absmiddle" onClick="find_Maj();"></a>
								</td>
                                </tr>
                                </table>
	                        </div>
                          </td>
                          <td>&nbsp;</td>
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
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8" align="left">

                <!-- 탭버튼데이블 시작 -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="120">
                            <!-- 탭오버 -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">자격증현황</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <!-- 탭히든 -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">전공현황</td>
                                    <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="2" bgcolor="#A4A4A1"></td>
                    </tr>
                </table>
                <!-- 탭버튼테이블 끝 -->
            </td>
        </tr>
    </table>


	<!-- 탭1 조건 입력 테이블 시작 -->
	<div class=page id="tabPIRE030_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_QUALIFICATION">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value= '
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}   </C>
							<C> id="QUA_NM"     width=250   name="자격증"       align=center    suppress = "1"</C>
							<C> id="DPT_NM"		width=135	name="소속"		    align=left      leftMargin="10" </C>
							<C> id="JOB_NM"		width=125	name="직위"		    align=center	</C>
							<C> id="ENO_NO"		width=115	name="사번"		    align=center	</C>
							<C> id="ENO_NM"		width=115	name="성명"		    align=center	</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</div>
	<!-- 탭1 조건 입력 테이블 끝 -->

	<!-- 탭2 조건 입력 테이블 시작 -->
	<div class=page id="tabPIRE030_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_SCHOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_SCHOOL">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}  </C>
                            <C> id="MAJ_NM"     width=170   name="전공"     align=center    suppress = "1"  </C>
							<C> id="DPT_NM"		width=135	name="소속"		align=left		leftMargin="10" </C>
							<C> id="JOB_NM"		width=90	name="직위"		align=center	                </C>
							<C> id="ENO_NO"		width=90	name="사번"		align=center	                </C>
							<C> id="ENO_NM"		width=90	name="성명"		align=center	                </C>
							<C> id="SCH_NAM"    width=165   name="학교"     align=left      leftMargin="10" </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</div>
	<!-- 탭2 조건 입력 테이블 끝 -->

	</form>
	<!-- form 끝 -->
</body>
</html>


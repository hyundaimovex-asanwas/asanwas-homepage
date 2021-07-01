<!--
***********************************************************************
* @source      : pire040.jsp
* @description : 보훈/장애인현현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/08/27      장문열        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>보훈/장애인현황(pire040)</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTTTFT';
		var today = getToday();

        var ActiveIndex = 0;


		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            var	bas_ymd_shr1 = document.getElementById("txtBAS_YMD_SHR1").value;
            var	bas_ymd_shr = document.getElementById("txtBAS_YMD_SHR").value;

			if(ActiveIndex==1){   //보훈대상자 조회
	        	document.getElementById("imgPrint").style.display = "none";
	        	document.getElementById("imgPrint").disabled = true;
			   	dsT_CM_PERSON1.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire040.cmd.PIRE040CMD&S_MODE=SHR_01&BAS_YMD_SHR1="+bas_ymd_shr1;
			    dsT_CM_PERSON1.reset();
			}else{               //장애인근로자 조회
	        	document.getElementById("imgPrint").style.display = "";
		       	document.getElementById("imgPrint").disabled = false;
				dsT_CM_PERSON2.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire040.cmd.PIRE040CMD&S_MODE=SHR_02&BAS_YMD_SHR="+bas_ymd_shr;
			    dsT_CM_PERSON2.reset();
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
            var	bas_ymd_shr = document.getElementById("txtBAS_YMD_SHR").value;

    	    var url = "pire040_PV.jsp?BAS_YMD_SHR="+bas_ymd_shr;
	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

	        if(ActiveIndex==1){
				if (dsT_CM_PERSON1.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CM_PERSON1.GridToExcel("보훈대상자현황", '', 225)

			}else{
				if (dsT_CM_PERSON2.CountRow < 1) {
					alert("엑셀로 변환할 자료가 없습니다!");
					return;
				}
	            form1.grdT_CM_PERSON2.GridToExcel("장애인근로자현황", '', 225)
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

        	document.getElementById("resultMessage").innerText = '';

        	document.getElementById("txtBAS_YMD_SHR1").value = '';
        	document.getElementById("txtBAS_YMD_SHR").value = '';

        	dsT_CM_PERSON1.ClearData();
        	dsT_CM_PERSON2.ClearData();
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
			cfStyleGrid(form1.grdT_CM_PERSON1,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_CM_PERSON2,0,"false","false");      // Grid Style 적용

			//조회란의 날짜 기본 세팅
		    document.getElementById('txtBAS_YMD_SHR1').value = getToday().substring(0,4);
		    document.getElementById('txtBAS_YMD_SHR').value = getToday().substring(0,4);


        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //Layer ID
        var layerList = new Array(  "tabpire040_01"
                                   ,"tabpire040_02" );

        //검색조건
        var searchList = new Array( "changeDate_01"
                                   ,"changeDate_02" );

        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {

            ActiveIndex = idx+1;

			if(ActiveIndex==1){   //보훈대상자 인쇄 버튼 삭제
	        	document.getElementById("imgPrint").style.display = "none";
	        	document.getElementById("imgPrint").disabled = true;
			}else{               //장애인근로자 인쇄 버튼 생성
	        	document.getElementById("imgPrint").style.display = "";
		       	document.getElementById("imgPrint").disabled = false;
			}

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
	    /********************************************
    	* 날짜 형식 유효성 체크                     *
	    ********************************************/
        function fnc_CheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON1)	   |
    | 3. 사용되는 Table List(T_CM_PERSON1) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
	<Script For=dsT_CM_PERSON1 Event="OnLoadCompleted(iCount)">
  		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsT_CM_PERSON2 Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_CM_PERSON1 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
	<Script For=dsT_CM_PERSON2 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 |
    +----------------------------------------------------------------->
	<Script For=dsT_CM_PERSON1 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_CM_PERSON2 Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">보훈/장애인현황</td>
					<td align="right" class="navigator">HOME/인사관리/인사현황데이터<font color="#000000">보훈/장애인현황</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
    				<tr>
    				    <td>&nbsp;</td>
    				    <td>
	                        <div id="changeDate_01" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:2;" >
                                <table width="100%">
                                <col width="10%"></col>
                                <col width="*"></col>
                                <tr>
                                <td class="searchState" align="right">기준년도</td>
		                        <td class="padding2423" align="left">
			                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
			                            <tr>
			                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
			                                    <input type="text" id="txtBAS_YMD_SHR1" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
			                                </td>
			                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR1', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
			                            </tr>
			                            <tr>
			                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR1', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
			                            </tr>
			                        </table>
								</td>
								</td>
                                </tr>
                                </table>
	       				    </div>
							<div id="changeDate_02" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:1; visibility:hidden" >
                                <table width="100%">
                                <col width="10%"></col>
                                <col width="*"></col>
								<tr>
									<td class="searchState" align="right">기준년도&nbsp;</td>
									<td class="padding2423" align="left">
				                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
				                            <tr>
				                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
				                                    <input type="text" id="txtBAS_YMD_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
				                                </td>
				                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
				                            </tr>
				                            <tr>
				                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
				                            </tr>
				                        </table>

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
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)"  style="cursor:hand" id="TabBtn01">보훈대상자현황</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <!-- 탭히든 -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">장애인근로자현황</td>
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
	<div class=page id="tabpire040_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_PERSON1" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_PERSON1">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value= '
							<FC> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}  </FC>
							<FC> id="ENO_NO"		width=60	name="사번"		align=center					</FC>
							<FC> id="ENO_NM"		width=60	name="성명"		align=center					</FC>
							<C> id="AGE"		width=39	name="나이"		align=center 					</C>
							<G> name="학력사항" align=center HeadBgColor="#F7DCBB"
								<C> id="SCH_NAM"    width=120   name="학교"     align=left      leftMargin="10" </C>
    	                        <C> id="MAJ_NM"     width=120   name="전공"     align=left    	leftMargin="10"  </C>
        	                    <C> id="GRD_YY"		width=50	name="졸업년도" align=center					</C>
                            </G>
							<C> id="DPT_NM"		width=90	name="소속"		align=left		leftMargin="10" </C>
							<C> id="HIR_YMD"	width=80	name="입사일"	align=center					</C>
							<C> id="RET_YMD"	width=80	name="퇴직일"	align=center					</C>
							<C> id="OCC_NM"		width=60	name="근로구분"		align=center					</C>
							<C> id="JOB_NM"		width=40	name="직위"		align=center	                </C>
							<C> id="MPVA_NM"	width=80	name="비고"		align=left		leftMargin="10" </C>
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
	<div class=page id="tabpire040_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_PERSON2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_PERSON2">
						<param name="Format" value='
							<FC> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}  </FC>
							<FC> id="ENO_NO"	width=60	name="사번"		align=center						</FC>
							<FC> id="ENO_NM"	width=60	name="성명"		align=center						</FC>
							<C> id="CET_NO"     width=100   name="주민등록번호"  align=left      leftMargin="10" </C>
                            <C> id="EM_PHN_NO"  width=100   name="장애인연락처"  align=left      leftMargin="10" </C>
                            <C> id="TRG_NM"		width=100	name="장애인정구분" align=center					</C>
							<C> id="JHDC_NM"	width=80	name="장애유형"		align=center					</C>
							<C> id="JHDC_GRA"	width=60	name="장애등급	"	align=center					</C>
							<C> id="SER_STS"	width=60	name="중증여부"		align=center					</C>
							<C> id="JAN_YMD"	width=80	name="장애인정일"	align=center					</C>
							<C> id="HIR_YMD"	width=80	name="입사일"		align=center					</C>
							<C> id="RET_YMD"	width=80	name="퇴사일"		align=center					</C>
							<C> id="JOB_ONM"	width=80	name="근로직종"		align=center					</C>
							<C> id="SAL_GBN"	width=80	name="임금형태"		align=center					</C>
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


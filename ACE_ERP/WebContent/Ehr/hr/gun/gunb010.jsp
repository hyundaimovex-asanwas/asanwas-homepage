<!--
***********************************************************************
* @source      : gunb010.jsp
* @description : 기념일/Refresh휴가현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/28      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>기념일/Refresh휴가현황(gunb010)</title>
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 해당년도
			
			var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var use = document.getElementById("cmb_USE_SHR").value; // 사용구분

            if(!fnc_SearchItemCheck()) return;//검색조건 유효성 검사

			if(ActiveIndex==1){
				dsT_DI_DILIGENCE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb010.cmd.GUNB010CMD&S_MODE=SHR_01&PIS_YYMM="+PIS_YYMM_SHR+"&DPT_CD="+dpt_cd+"&USE="+use;
			    dsT_DI_DILIGENCE_01.reset();
			}else{
				dsT_DI_DILIGENCE_02.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb010.cmd.GUNB010CMD&S_MODE=SHR_02&PIS_YYMM="+PIS_YY_SHR+"&DPT_CD="+dpt_cd+"&USE="+use;
			    dsT_DI_DILIGENCE_02.reset();
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
				if (dsT_DI_DILIGENCE_01.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_DI_DILIGENCE_01.GridToExcel("기념일휴가현황", '', 225)

			}else{
				if (dsT_DI_DILIGENCE_02.CountRow < 1) {
					alert("엑셀로 변환할 자료가 없습니다!");
					return;
				}
	            form1.grdT_DI_DILIGENCE_02.GridToExcel("Refresh휴가현황", '', 225)

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
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

			document.getElementById("cmb_USE_SHR").value = "";
        	document.getElementById("resultMessage").innerText = ' ';
        	dsT_DI_DILIGENCE_01.ClearData();
        	dsT_DI_DILIGENCE_02.ClearData();

            TabEvent(0);
                    	
        	document.form1.txtPIS_YYMM_SHR.focus();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {

            var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value;
            var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value;

            if(ActiveIndex == 0){
	            //해당년월이 없으면 조회못함.
				if(PIS_YYMM_SHR.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("해당년월을 입력하세요.");
						document.getElementById("txtPIS_YYMM_SHR").focus();
						return false;
					}
				}
	
				//해당년월이 잘못되었으면 조회못함.
				if(PIS_YYMM_SHR.trim().length != 7){
					if(event.type == "change"){
						return false;
					}else{
						alert("해당년월이 잘못되었습니다.");
						document.getElementById("txtPIS_YYMM_SHR").focus();
						return false;
					}
				}
				
			} else {
                //해당년도가 없으면 조회못함.
                if(PIS_YY_SHR.trim().length == 0){
                    if(event.type == "change"){
                        return false;
                    }else{
                        alert("해당년도를 입력하세요.");
                        document.getElementById("txtPIS_YY_SHR").focus();
                        return false;
                    }
                }

                //해당년도가 잘못되었으면 조회못함.
                if(PIS_YY_SHR.trim().length != 4){
                    if(event.type == "change"){
                        return false;
                    }else{
                        alert("해당년도가 잘못되었습니다.");
                        document.getElementById("txtPIS_YY_SHR").focus();
                        return false;
                    }
                }
            }			

            return true;

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


			document.form1.txtPIS_YYMM_SHR.value = getToday().substring(0,7); // 해당년월
			document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4); // 해당년도


			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_DI_DILIGENCE_01,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_DI_DILIGENCE_02,0,"false","false");      // Grid Style 적용



            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       
<%
    }
%>
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //Layer ID
        var layerList = new Array(  "tabGUNB010_01"
                                   ,"tabGUNB010_02" );

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
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
	<Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsT_DI_DILIGENCE_02 Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
	<Script For=dsT_DI_DILIGENCE_02 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 |
    +----------------------------------------------------------------->
	<Script For=dsT_DI_DILIGENCE_01 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_DI_DILIGENCE_02 Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기념일/Refresh휴가현황</td>
					<td align="right" class="navigator">HOME/근태관리/휴가계획관리/<font color="#000000">기념일/Refresh휴가현황</font></td>
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
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="50"></col>
    					<col width="180"></col>
    					<col width="80"></col>
                        <col width="205"></col>
    					<col width="80"></col>
                        <col width="150"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    				    <td>&nbsp;</td>
    				    <td>
	                        <div id="changeDate_01" style="position:absolute; left:132; top:86; width:180; height:20; z-index:2;" >
                                <table>
                                <tr>                 
                                                
                                <td class="searchState" align="right">해당년월&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>                  
                                </td>
                                
                                </tr>
                                </table>          
	       				    </div>
	                        <div id="changeDate_02" style="position:absolute; left:132; top:86; width:180; height:20; z-index:1; visibility:hidden" >
                               <table>
                               <tr>                 
                                <td class="searchState" align="right">해당년도&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>            
                                </td>
                                </tr>
                                </table>	                        
	                        </div>
                        </td>
    					<td class="searchState" align="right">소&nbsp;&nbsp;&nbsp;속&nbsp;</td>
    					<td class="padding2423" align="left">
    						<input id="txtDPT_CD_SHR" size="3" maxlength="2"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="16" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
    					</td>
    					<td align="right" class="searchState">사용구분&nbsp;</td>
    					<td>
    						<select id="cmb_USE_SHR" style="width:100" onChange="fnc_SearchList();">
    							<option value="" >전체</option>
    							<option value="1" >사용</option>
                                <option value="2" >미사용</option>
    						</select>
    					</td>
                        <td>&nbsp;</td>
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
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">기념일휴가</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td> 
                            <!-- 탭히든 -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">Refresh휴가</td>
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
	<div class=page id="tabGUNB010_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_DI_DILIGENCE_01">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}   </C>
							<C> id="DPT_NM"		width=110	name="소속"		    align=center    </C>
							<C> id="JOB_NM"		width=60	name="직위"		    align=center	</C>
							<C> id="ENO_NO"		width=70	name="사번"		    align=center	</C>
							<C> id="ENO_NM"		width=70	name="성명"		    align=center	</C>
                            <G> name="본인생일휴가" HeadBgColor="#F7DCBB"
								<C> id="BIR_YMD"	width=95	name="생년월일"		align=center	</C>
                                <C> id="TBIR_YMD"     width=80  name="생일"         align=center    </C>								
								<C> id="UBIR_YMD"	width=80	name="사용일"		align=center	</C>
                            </G>
                            <G> name="결혼기념휴가" HeadBgColor="#F7DCBB"
								<C> id="WED_YMD"	width=95	name="결혼기념일"	align=center	</C>
								<C> id="UWED_YMD"	width=80	name="사용일"		align=center	</C>
                            </G>
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
	<div class=page id="tabGUNB010_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_DI_DILIGENCE_02">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}   </C>
							<C> id="DPT_NM"		width=100	name="소속"		align=left		leftMargin="10" </C>
							<C> id="JOB_NM"		width=60	name="직위"		align=center	</C>
							<C> id="ENO_NO"		width=60	name="사번"		align=center	</C>
							<C> id="ENO_NM"		width=60	name="성명"		align=center	</C>
							<C> id="HIRG_YMD"	width=80	name="그룹입사일"	align=center	</C>
							<C> id="LSE_YY"		width=70	name="근속년수"	align=center	</C>
                            <C> id="ATT_Z"		width=90	name="Refresh휴가"	align=center	</C>
                            <C> id="ATT_S"		width=70	name="유급휴가"	align=center	</C>
							<C> id="PERIOD"	    width=150	name="사용기간"	align=left		</C>
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


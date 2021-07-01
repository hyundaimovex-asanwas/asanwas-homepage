<!--
***********************************************************************
* @source      : vlul090.jsp
* @description : 목표승인 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/04/13      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>목표승인</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style_new.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var year    = getToday().substring(0,4);

        var dsTemp = window.dialogArguments;

        var EVL_ENO_NO = "";
        var EVL_ENO_NM = "";

        if(dsTemp != "Modal") {
        	EVL_ENO_NO = "<%=box.get("SESSION_ENONO")%>";
        	EVL_ENO_NM = "<%=box.get("SESSION_ENONM")%>";
		} else {
			EVL_ENO_NO = "<%=request.getParameter("ENO_NO")%>";
			EVL_ENO_NM = "<%=request.getParameter("ENO_NM")%>";
		}        
        
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var STATUS  = document.getElementById("selSTATUS").value;

			dsT_EVL_APPROVAL.ClearAll();
            dsT_EVL_APPROVAL.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul090.cmd.VLUL090CMD&S_MODE=SHR&STATUS=" + STATUS
            										+"&ENO_NM="+document.getElementById("txtEVL_ENO_NM").value+"&EVL_ENO_NO=" + document.getElementById("txtEVL_ENO_NO").value;
            dsT_EVL_APPROVAL.Reset();
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {


        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {



        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {


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

            if (dsT_EVL_APPROVAL.CountRow < 1) {
                alert(fnc_GetMSG("MSG_09"));
                return;
            }

            grdT_EVL_APPROVAL.GridToExcel("목표승인", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {


        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {


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

			/*document.getElementById("txtENO_NO_SHR").value     = '';
            document.getElementById("txtENO_NM_SHR").value     = '';
            document.getElementById("txtDPT_CD_SHR").value     = '';
            document.getElementById("txtDPT_NM_SHR").value     = '';
            document.getElementById("txtKIJUN_YMD_SHR").value  = '';*/


            document.getElementById("resultMessage").innerText = ' ';


            // DataSet Clear
            dsT_EVL_APPROVAL.ClearData();
        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
	            frame = window.external.GetFrame(window);
	            frame.CloseFrame();
            }else{
                window.close();
            }

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  			*
         *******************************************/
        function fnc_OnLoadProcess() {

			// DATASET 초기화
            fnc_Clear();

			cfStyleGrid_New(grdT_EVL_APPROVAL, 0, "false", "false");  // Grid Style 적용
			
            document.getElementById("txtEVL_ENO_NO").value = EVL_ENO_NO;
            document.getElementById("txtEVL_ENO_NM").value = EVL_ENO_NM;

<%
    //관리자의 경우 년도, 사번 검색 활성화
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>

			document.getElementById("txtEVL_ENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_ENO_NO").readOnly = true;	  		
			document.getElementById("txtEVL_ENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_ENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";
<%
	}else{
%>
			document.getElementById("txtEVL_ENO_NO").className = "";
	  		document.getElementById("txtEVL_ENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtEVL_ENO_NM").className = "";
	  		document.getElementById("txtEVL_ENO_NM").readOnly = false;

<%
    }%>

    		fnc_SearchList();
        }


        
        function fnc_GetNm() {
            fnc_GetEnoNm('txtEVL_ENO_NO', 'txtEVL_ENO_NM','0','0');
            fnc_SearchList()

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtEVL_ENO_NM','txtEVL_ENO_NO');
	            fnc_SearchList()
	    }        
        

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_15");

        } else {

            document.getElementById("resultMessage").innerText = iCount + fnc_GetMSG("MSG_16");
        }

    </Script>

    <Script For=dsT_EVL_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EVL_APPROVAL Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | grdT_EVL_APPROVAL OnClick 처리							        |
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_EVL_APPROVAL event=OnDblClick(row,colid)>

		if(row > 0) {	// header는 더블클릭 적용안함

			if(dsT_EVL_APPROVAL.NameValue(row,"STATUS") != "") {	// 미상신건은 볼 수 없음
				var url = "/hr/vlu/vlul080.jsp?ENO_NO=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NO") + "&ENO_NM=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NM") + "&STATUS=" + dsT_EVL_APPROVAL.NameValue(row,"STATUS");
				window.showModalDialog(url, "Modal", "dialogWidth:960px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
				fnc_SearchList();
				dsT_EVL_APPROVAL.RowPosition = row;
			} else {
				alert("목표 상신 전입니다. 목표상신 이후 열람이 가능합니다.");
			}
		}

	</script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar2.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<div class="evl_container"><!-- evl_container 시작-->

	<div class="info_title"><!-- info_title 시작-->
		<h3 class="info_title_h3">목표승인</h3>
		<p class="info">HOME &gt; 인사평가  &gt; KPI 목표설정 &gt; <strong>목표승인</strong></p>
	</div><!-- //info_title 끝-->

	<div class="btn_group_right" ><!-- btn_group 시작-->
		<ul class="list">
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a></li>
		</ul>
	</div><!-- //btn_group 끝-->
   <br><br>
	<div class="inquiry"><!-- inquiry 시작-->
		<form action="" method="post" >
			<fieldset>
				<legend>목표승인</legend>
					<p>상태 :
					<span>
						<select id="selSTATUS" name="selSTATUS" onchange="fnc_SearchList();">
							<option value="A">전체</option>
							<option value="R">미결</option>
							<option value="N">부결</option>
							<option value="Y">결재완료</option>
						</select>
					</span>
					&nbsp;&nbsp;성명 :
					<span>
						<input type="text" id="txtEVL_ENO_NO" name="txtEVL_ENO_NO" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" /><input type="text" style="display:none" />
						<input type="text" id="txtEVL_ENO_NM" name="txtEVL_ENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()" /><input type="text" style="display:none" />
						<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtEVL_ENO_NO','txtEVL_ENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
						<input type="hidden" id="hidEMPL_DPT_CD">					
					</span>
					</p>
			</fieldset>
		</form>
	</div><!-- // inquiry 끝-->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table summary="목표승인" class="grid_table"><!-- evl_table 시작-->
	    <tr align="center">
	        <td>
	            <comment id="__NSID__">
	            <object id="grdT_EVL_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:900px;height:340px;" >
	                <param name="DataID"                  value="dsT_EVL_APPROVAL">
	                <param name="HiddenHScroll"		 value="true">
	                <param name="Format"                  value="
                        <C> id=HEAD_NM         width=200   	name='본부'        			align=center Edit=None </C>
                        <C> id=DPT_NM          	width=200   	name='소속'        			align=center Edit=None </C>
                        <C> id=JOB_NM          	width=100   	name='직위'		   			align=center Edit=None </C>
                        <C> id=ENO_NO          	width=100   	name='사번'        			align=center Edit=None </C>
                        <C> id=ENO_NM          	width=100   	name='성명'        			align=center Edit=None </C>
                        <C> id=STATUS_NM    	width=200   	name='상태'       			align=center Edit=None </C>
	                ">
	            </object>
	            </comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

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
	<!-- 조회 상태 테이블 시작 -->


</div><!-- //evl_container 끝 -->



</body>
</html>

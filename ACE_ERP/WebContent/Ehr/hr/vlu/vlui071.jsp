<!--
*****************************************************
* @source       : vlui071.jsp
* @description  : 피고과자선정 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>피고과자선정(vlui071)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var today = getToday();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var REG_YM_SHR = document.form1.txtREG_YM_SHR.text;        //해당년도

	        dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui070.cmd.VLUI070CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR;
	        dsT_EV_ABLRST.reset();

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



        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

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

		document.form1.txtREG_YM_SHR.text = getToday().substring(0,7);
		document.form1.txtREG_YMD_SHR.text = getToday();
		document.form1.txtHIR_YMD_SHR.text = getToday();

        cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","true");      // Grid Style 적용

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {


        }


        /********************
         * 16. 생성했을 경우 *
         *******************/
        function fnc_Append() {

          var REG_YM_SHR = document.form1.txtREG_YM_SHR.text;        //해당년도

	        dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui070.cmd.VLUI070CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR;
	        dsT_EV_ABLRST.reset();


			if (dsT_EV_ABLRST.countrow>0) {
				if (confirm( "현재월에 기생성된 피고과자가 존재합니다. 기생성 피고과자를 삭제 후 다시 생성하겠습니까?")) {

					//기생성 피고과자 삭제
		      		dsT_EV_ABLRST.DeleteAll();

		            trT_EV_ABLRST.KeyValue = "tr(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
		            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui070.cmd.VLUI070CMD&S_MODE=DEL_01&REG_YM_SHR="+REG_YM_SHR;
		            trT_EV_ABLRST.post();

					//피고과자 생성
		       		fnc_Create();
				}
			}else{
					//일반 피고과자 신규생성
					if (confirm("피고과자를 생성 하시겠습니까?")){
						fnc_Create();
					}
			}
        }


		function fnc_Create(){

            var REG_YM_SHR = document.form1.txtREG_YM_SHR.text;        //해당년도

			dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui070.cmd.VLUI070CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR;
			dsT_EV_ABLRST.Reset();

			fnc_Confirm();

		}


		function fnc_Confirm(){

				if (confirm("대상자를 조회하였습니다. 저장하시겠습니까?")) {

					for(i=1;i<=dsT_EV_ABLRST.countrow;i++){
						dsT_EV_ABLRST.UserStatus(i) = 1;
					}
			            trT_EV_ABLRST.KeyValue = "tr(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui070.cmd.VLUI070CMD&S_MODE=SAV_01";
			            trT_EV_ABLRST.post();
				}
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
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">피고과자기생성자</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">피고과자선정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','/images/button/btn_CreateOver.gif',1)"><img src="/images/button/btn_CreateOn.gif"   name="imgCreate"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

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
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:320px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <C> id='EMPNO'     	width=80   	name='사번'    		align=center    edit=none </C>
                                    <C> id='DEPTNM'    	width=180   name='소속'   		align=left    	edit=none </C>
                                    <C> id='GRDNM'    	width=90   	name='직위'   		align=left    	edit=none </C>
                                    <C> id='ENO_NM'   	width=80  	name='성명'  		align=left      edit=none </C>
                                    <C> id='WRDT'       width=80   	name='생성년월' 	align=center    edit=none mask='XXXX-XX'</C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        	</td>
					  		<td valign="top">
							<table border= "0" cellpadding=0 cellspacing=0  border=3 style='width:200px;height:160px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="creamBold"><nobr>&nbsp;고과년월</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
									<comment id="__NSID__">
									<object id=txtREG_YM_SHR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="YYYY/MM">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;고과기준일</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
									<comment id="__NSID__">
									<object id=txtREG_YMD_SHR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;사번</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
									<comment id="__NSID__">
									<object id=txtENO_NOFR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:53px; height:20px; font-family:굴림; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="0000000">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>~
									<comment id="__NSID__">
									<object id=txtENO_NOTO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:53px; height:20px; font-family:굴림; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="0000000">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;입사일자</td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
									<comment id="__NSID__">
									<object id=txtHIR_YMD_SHR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;이전</nobr>
									</td>
								</tr>
							</table>
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



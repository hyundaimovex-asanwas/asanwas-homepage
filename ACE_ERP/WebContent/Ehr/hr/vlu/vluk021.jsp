<!--
*****************************************************
* @source       : vluk021.jsp
* @description  : 부서장 고과표입력 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/05/07     정하나       최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>부서장 고과표입력(vluk021)</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도

            //정보 조회
            dsT_EV_RQSHEET.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=SHR_DPT&REG_YM_SHR="+REG_YM_SHR;
            dsT_EV_RQSHEET.reset();

			// 엔터키변환
			for (var i = 1; i <= dsT_EV_RQSHEET.CountRow; i++) {
		
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r","");				
			}
			
			dsT_EV_RQSHEET.ResetStatus();	            
            
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

            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=SAV_DPT";

          //  prompt(this, dsT_EV_RQSHEET.text);

            trT_EV_ABLRST.post();
        	fnc_SearchList();


        }



        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요
			if (dsT_EV_RQSHEET.countrow<1){
				alert ("삭제할 정보가 없습니다.");
			}else {

				if (confirm("선택한 정보를 삭제하시겠습니까?")){
					dsT_EV_RQSHEET.deleterow(dsT_EV_RQSHEET.rowposition);
			        trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)";
			        trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=DEL_DPT";
			        trT_EV_ABLRST.post();
					fnc_SearchList();
				}
			}
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

            if (dsT_EV_RQSHEET.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("고과표입력", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			if(dsT_EV_RQSHEET.CountColumn < 1 ){

                alert("반드시 조회후 입력이 가능합니다.");
                return false;

			}

            //이곳에 해당 코딩을 입력 하세요
			dsT_EV_RQSHEET.AddRow();

			dsT_EV_RQSHEET.nameValue(dsT_EV_RQSHEET.RowPosition, "EVAYM") = document.form1.txtREG_YM_SHR.value.replace("-","");        //해당년도

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

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {


            if (dsT_EV_RQSHEET.IsUpdated)  {

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

            if (!dsT_EV_RQSHEET.IsUpdated) {
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

			document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

		/*	document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);*/

			document.getElementById("txtREG_YM_SHR").value = '9999-99';

            fnc_ChangeStateElement(false, "txtREG_YM_SHR");
			
	        cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");      // Grid Style 적용

	        fnc_SearchList();

        }


        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

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
    <Object ID="dsT_EV_RQSHEET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
            <Param Name=KeyValue    Value="sample_tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->



    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_RQSHEET Event="OnLoadCompleted(iCount)">
     //  fnc_SearchList();
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
    <Script For=dsT_EV_RQSHEET Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">부서장 고과표입력</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">부서장 고과표입력</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                       <col width="60"></col>                
                       <col width="*"></col>
                       </colgroup>
                   <tr>
                       <td class="searchState" align="right">고과년월&nbsp;</td>
                       <td class="padding2423" align="left" id="key1"  style="display:">
                           <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR"  size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13)fnc_SearchList(); cfDateHyphen(this);  cfNumberCheck()">
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
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:420px;">
                            <param name="DataID"                	value="dsT_EV_RQSHEET">
                            <param name="EdiTABLE"                	value="true">
                            <param name="DragDropEnable"        	value="true">
                            <param name="SortView"                	value="Left">
                            <param name="VIEWSUMMARY"            	value=0>
                            <param name="Format"                	value="
                                <C> id='EVAYM'       		width=60    name='고과년월'     	align=left   		Edit=None show=false</C>
                                <C> id='GB_MST'        	width=80    name='구분'         	align=center   	Edit=None value={IF (GB_MST='11','부서장', '')} suppress=1</C>
                                <C> id='GB_DTL'       	 width=80    name='항목'         	align=left   		Edit=None </C>
                                <C> id='ACT_ITEM'       width=300  name='행동지표'     	align=left 		Edit=none</C>
                                <C> id='T_SCR'        	width=50  	name='배점'     		align=center 	Edit=none</C>                                
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

		  		<td >
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=3
					style='width:243px;height:422px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="creamBold"><nobr>&nbsp;고과년월</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gcem_yymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; " >
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
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold" align="left"><nobr>&nbsp;구분</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
								<comment id="__NSID__">
								<object id=gclx_gbmst  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
											<param name="CBData" 				value="11^부서장" />
											<param name="CBDataColumns" 		value="COM_CODE,COM_SNAME" />
											<param name="Index" 					value="0" />
											<param name="SearchColumn" 		value="COM_SNAME" />
											<param name="ListExprFormat" 		value="COM_SNAME^0^70" />
											<param name="BindColumn" 			value="COM_CODE" />
											<param name="Enable" 					value="true" />
								</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>	&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;항목</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_gbdtl" name="txt_gbdtl" type="text"  class="txt21" style="position:relative; left:0px;width:180px;"  >&nbsp;</nobr>
								</td>
							</tr>

							<tr>
								<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;배점</td>
								<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
									<input id="txt_t_scr" name="txt_t_scr" type="text"  class="txt21" style="position:relative; left:0px;width:100px;" maxlength=34 >&nbsp;</nobr>
								</td>
							</tr>							
							
							<tr>
								<td style="height:300px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"  class="creamBold">&nbsp;행동지표</td>
								<td Style="height:300px;border:0 solid #708090;border-bottom-width:0px">&nbsp;
                              		<textarea id=txt_actitem name=txt_actitem rows="22" cols="25" valid='maxlength=1000' field='내용'></textarea>									
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_EV_ABLRST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_RQSHEET">
	<Param Name="BindInfo", Value='
    	<C>Col=EVAYM           	Ctrl=gcem_yymm2        		Param=text</C>
    	<C>Col=GB_MST          Ctrl=gclx_gbmst        			Param=BindColVal</C>
		<C>Col=GB_DTL       	Ctrl=txt_gbdtl           			Param=value</C>
		<C>Col=ACT_ITEM       	Ctrl=txt_actitem           		Param=value</C>
		<C>Col=T_SCR   		 	Ctrl=txt_t_scr    		 			Param=value</C>
    '>
</object>

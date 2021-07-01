<!--
***********************************************************************
* @source      : world_city.jsp
* @description : 세계도시정보조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/03/12     권혁수        최초작성.
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="common.util.JSPUtil" %>
<%

%>

<html>

    <head>
    <title>세계도시정보조회(world_city)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
		var paramDataSet  = window.dialogArguments;
        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';


        /************************
         * 11. 조회  *
         ***********************/
        function fnc_SearchList() {
			var SEARCH_GBN = document.getElementById("cmbSEARCH_GBN").value;
			var TEXT_SHR = document.getElementById("txtTEXT_SHR").value;

            //데이터셋 전송
            dsT_CM_NAT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=NAT_SHR&SEARCH_GBN="+SEARCH_GBN+"&TEXT_SHR="+TEXT_SHR;
            dsT_CM_NAT.reset();

        }
        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            window.close();

        }
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_CM_NAT,0,"false","false");      // Grid Style 적용
            cfStyleGrid(form1.grdT_CM_CITY,0,"false","false");      // Grid Style 적용

            //데이터셋 전송
            dsT_CM_NAT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=NAT_SHR";
            dsT_CM_NAT.reset();
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /**
         * 결재자를 선정한 후 확인을 누르면 결재자정보가 넘어감
         * (결재자가 없으면 신청자가 결재자로 넘어감)
         */
        function fnc_Confirm() {
			paramDataSet.nat_cd = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "NAT_CD");
			paramDataSet.nat_nm = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "NAT_NM");
			paramDataSet.city_cd = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "CITY_CD");
			paramDataSet.city_nm = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "CITY_NM");
            window.close();
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
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_NAT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_CITY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_NAT Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            //데이터셋 전송
			var NAT_CD = dsT_CM_NAT.NameValue(dsT_CM_NAT.RowPosition, "NAT_CD");
            dsT_CM_CITY.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=CITY_SHR&NAT_CD="+NAT_CD;
            dsT_CM_CITY.reset();
        }
    </Script>

    <Script For=dsT_CM_CITY Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
        } else {
        }

    </Script>
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_NAT Event="OnLoadError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CM_CITY Event="OnLoadError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_NAT Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CM_CITY Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_NAT event=OnDblClick(row,colid)>
			var NAT_CD = dsT_CM_NAT.NameValue(row, "NAT_CD");
            dsT_CM_CITY.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=CITY_SHR&NAT_CD="+NAT_CD;
            dsT_CM_CITY.reset();
    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_NAT event=OnReturn(row,colid)>
			var NAT_CD = dsT_CM_NAT.NameValue(dsT_CM_NAT.RowPosition, "NAT_CD");
            dsT_CM_CITY.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=CITY_SHR&NAT_CD="+NAT_CD;
            dsT_CM_CITY.reset();

    </script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_CITY event=OnDblClick(row,colid)>
		fnc_Confirm();
    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_CITY event=OnReturn(row,colid)>
		fnc_Confirm();
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">세계각국 도시정보조회</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
				<!--
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				-->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->


    <!-- power Search테이블 시작 
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">
										<select id="cmbSEARCH_GBN" style="width:85">
											<option value="1">국가</option>
											<option value="2">도시</option>
										</select>
									</td>
                                    <td align="center" class="searchState">국가/도시&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtTEXT_SHR" id="txtTEXT_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()"><input type="text" style="display:none">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_NAT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:200px;height:400px;">
                                <param name="DataID"            value="dsT_CM_NAT">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=NAT_CD           width=50  name=코드      align=center   </C>
                                    <C> id=NAT_NM           width=130  name=국가명   align=left   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_CITY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:250px;height:400px;">
                                <param name="DataID"            value="dsT_CM_CITY">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll       value="true">
                                <param name="Format"            value='
                                    <C> id=CITY_CD           width=50   name=코드      align=center   </C>
                                    <C> id=CITY_NM           width=180   name=도시명   align=left   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->
    </form>
    <!-- form 끝 -->
</body>
</html>
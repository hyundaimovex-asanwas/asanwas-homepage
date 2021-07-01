<!--
***********************************************************************
* @source      : pirc040.jsp
* @description : 개인별휴가사용현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/21      오대성        최초작성.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인별휴가사용현황(pirc040)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            
            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var pis_yy = document.getElementById('txtPIS_YY_SHR').value;

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_DI_YEARLY.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc040.cmd.PIRC040CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PIS_YY="+pis_yy;
    		dsT_DI_YEARLY.reset();

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

				//이곳에 해당 코딩을 입력 하세요

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

			//이곳에 해당 코딩을 입력 하세요

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

			document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_YEARLY.ClearData();
			
<%
    //관리자만 아이디 사번 초기화
    if(box.getString("SESSION_ROLE_CD").equals("1002")
            || box.getString("SESSION_ROLE_CD").equals("1001")) {
%>

            document.getElementById('txtENO_NO_SHR').value = '';
            document.getElementById('txtENO_NM_SHR').value = '';
<%
    }
%>

            document.getElementById('txtPIS_YY_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_yy = document.getElementById("txtPIS_YY_SHR");
            var eno_no = document.getElementById("txtENO_NO_SHR");
            
            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("해당년도를 입력하세요!");
                pis_yy.focus();
                return false;
            }

            if(eno_no.value == ""){
                alert("사번을 입력하세요!");
                eno_no.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
			
            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YY_SHR').value = getTodayArray()[0];            
            document.getElementById('txtPIS_YY_SHR').focus();
            
<%
    //관리자나 총무 관리자 이면 사번으로 검색하고 일반유저이면 사번으로 검색못하게 막기
    if(!box.getString("SESSION_ROLE_CD").equals("1002")
            && !box.getString("SESSION_ROLE_CD").equals("1001")) {
%>
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            
            document.getElementById('ImgEnoNoShr').style.display = "none";
            document.getElementById('txtENO_NO_SHR').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM_SHR').value = '<%=box.get("SESSION_ENONM")%>';
<%
    }
%>

            document.getElementById('txtPIS_YY_SHR').focus();       

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

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_YEARLY)   |
    | 3. 사용되는 Table List(T_DI_YEARLY)		     |
    +------------------------------------------------>
    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_YEARLY Event="OnLoadCompleted(iCount)">
		
        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
			document.getElementById("resultMessage").innerText = "* 자료가 조회되었습니다.";

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_YEARLY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별휴가사용현황</td>
					<td align="right" class="navigator">HOME/기초정보/개인정보/<font color="#000000">개인별휴가사용현황</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="80"></col>
									<col width="120"></col>
                                    <col width="80"></col>
									<col width=""></col>
								</colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">
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
                                <td align="right" class="searchState">사&nbsp;&nbsp;번&nbsp;</td>
                                <td class="padding2423" colspan="5">
                                    <input id="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '');">
                                    <input id="txtENO_NM_SHR" size="12" maxlength= "12"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>개인정보</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;종</td>
                    <td class="padding2423">
                        <input id=txtOCC_NM name=txtOCC_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id=txtDPT_NM name=txtDPT_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">입사일자</td>
                    <td class="padding2423">
                        <input id=txtHIRG_YMD name=txtHIRG_YMD size="16" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>연차발생</strong>
        </td>
    </tr>
    <tr>
		<td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="160"></col>
                    <col width="100"></col>
                    <col width="160"></col>
                    <col width="100"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">연차발생일수</td>
                    <td class="padding2423">
                        <input id="txtYRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="creamBold">연차사용일수</td>
                    <td class="padding2423">
                        <input id="txtATT_H" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="creamBold">미사용연차</td>
                    <td class="padding2423">
                        <input id="txtREM_YRP" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
        
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>연차사용</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">1 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H1" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="creamBold">4 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H4" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="creamBold">7 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H7" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                    <td align="center" class="creamBold">10 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H10" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">2 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H2" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="creamBold">5 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H5" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="creamBold">8 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H8" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                    <td align="center" class="creamBold">11 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H11" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">3 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H3" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                    <td align="center" class="creamBold">6 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H6" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                    <td align="center" class="creamBold">9 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H9" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                    <td align="center" class="creamBold">12 월</td>
                    <td class="padding2423">
                        <input id="txtATT_H12" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
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

</form>
<!-- form 끝 -->

</body>
</html>

<!-- 급/상여 MASTER 테이블 -->
<object id="bndT_DI_YEARLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_YEARLY">
    <Param Name="BindInfo", Value='
        <C> Col=OCC_CD       Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=OCC_NM       Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=HIRG_YMD     Ctrl=txtHIRG_YMD     Param=value </C>
        <C> Col=YRP_CNT      Ctrl=txtYRP_CNT      Param=value </C>
        <C> Col=ATT_H        Ctrl=txtATT_H        Param=value </C>
        <C> Col=REM_YRP      Ctrl=txtREM_YRP      Param=value </C>
        <C> Col=ATT_H1       Ctrl=txtATT_H1       Param=value </C>
        <C> Col=ATT_H2       Ctrl=txtATT_H2       Param=value </C>
        <C> Col=ATT_H3       Ctrl=txtATT_H3       Param=value </C>
        <C> Col=ATT_H4       Ctrl=txtATT_H4       Param=value </C>
        <C> Col=ATT_H5       Ctrl=txtATT_H5       Param=value </C>
        <C> Col=ATT_H6       Ctrl=txtATT_H6       Param=value </C>
        <C> Col=ATT_H7       Ctrl=txtATT_H7       Param=value </C>
        <C> Col=ATT_H8       Ctrl=txtATT_H8       Param=value </C>
        <C> Col=ATT_H9       Ctrl=txtATT_H9       Param=value </C>
        <C> Col=ATT_H10      Ctrl=txtATT_H10      Param=value </C>
        <C> Col=ATT_H11      Ctrl=txtATT_H11      Param=value </C>
        <C> Col=ATT_H12      Ctrl=txtATT_H12      Param=value </C>
    '>
</object>
<!--
***********************************************************************
* @source      : gunc041.jsp
* @description : 개인별휴일근무현황상세 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/07      오대성        최초작성.
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
	<title>개인별휴일근무현황상세(gunc041)</title>
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

		var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            dsT_DI_DILIGENCE.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc041.cmd.GUNC041CMD&S_MODE=SHR&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&STR_YMD="+dsTemp.NameValue(1,"STR_YMD")+"&END_YMD="+dsTemp.NameValue(1,"END_YMD");
            dsT_DI_DILIGENCE.reset();

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

            // 엑셀로 변환 할 자료가 있는지 체크하고

            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)

            // 삭제 후 해당 그리드로 Focus 이동

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

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
        function fnc_SearchItemCheck() {

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

			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style 적용

            document.getElementById("txtDPT_NM").value = dsTemp.NameValue(1,"DPT_NM");
            document.getElementById("txtJOB_NM").value = dsTemp.NameValue(1,"JOB_NM");
            document.getElementById("txtENO_NO").value = dsTemp.NameValue(1,"ENO_NO");
            document.getElementById("txtENO_NM").value = dsTemp.NameValue(1,"ENO_NM");

            fnc_SearchList();

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
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_DILIGENCE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>



<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별휴일근무현황상세</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/<font color="#000000">개인별휴일근무현황상세</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- 조건 입력 테이블 시작 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="85"></col>
					<col width="100"></col>
					<col width="85"></col>
                    <col width="100"></col>
					<col width="85"></col>
                    <col width="100"></col>
					<col width="85"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">소 속</td>
					<td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">직 위</td>
					<td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">사 번</td>
					<td class="padding2423">
                        <input id="txtENO_NO" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">성 명</td>
					<td class="padding2423">
                        <input id="txtENO_NM" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
				</tr>
            </table>
            </td>
	</table>
	<!-- 조건 입력 테이블 끝 -->
</tr>
</table>

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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr align="center">
	                    <td>
	                        <comment id="__NSID__">
	                        <object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
	                            <param name="DataID"            value="dsT_DI_DILIGENCE">
	                            <param Name="Editable"          value="false">
								<param name=HiddenHScroll    value="true">
	                            <param name="Format"            value='
                                    <C> id={currow}		width=59    	name="NO"				align=center					 	</C>
	                                <C> id=REP_APP		width=144 	  	name=신청구분       	align=center 	value={Decode(REP_APP,"1","대체휴가","2","대체반차","3","휴일근무수당"," ")}	</C>
	                                <C> id=HOL_YMD		width=144  	 	name=휴일근무일     	align=center 	Mask="XXXX-XX-XX"	</C>
									<C> id=HOL_TIME		width=144		name=휴일근무시간		align=center						</C>
	                            	<C> id=HOW_YMD		width=144		name=대체휴가사용일	  	align=center 	Mask="XXXX-XX-XX"	</C>
									<C> id=HOL_AMT		width=144		name=휴일근무수당		align=right		value={Decode(HOL_AMT,0,"",HOL_AMT)}	</C>
	                            '>
	                        </object>
	                        </comment><script> __ShowEmbedObject(__NSID__); </script>
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
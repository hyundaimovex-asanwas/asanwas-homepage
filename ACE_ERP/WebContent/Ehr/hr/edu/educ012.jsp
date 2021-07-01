<!--
***********************************************************************
* @source      : educ012.jsp
* @description : 교육이력 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/08/08      한학현        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>교육이력(educ012)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var opener = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_EDUCATION_01=dsT_CM_EDUCATION_01, "+
        	                                "O:dsT_CM_EDUCATION_02=dsT_CM_EDUCATION_02, "+
        	                                "O:dsT_ED_LCTRHIST_03=dsT_ED_LCTRHIST_03, "+
        	                                "O:dsT_CM_EDUCATION_04=dsT_CM_EDUCATION_04, "+
        	                                "O:dsT_ED_EXCEPTER_05=dsT_ED_EXCEPTER_05)";

			trT_CM_EDUCATION.Action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ012.cmd.EDUC012CMD"
                                    + "&S_MODE=SHR"
                                    + "&PIS_YY="+opener.edu_yy  //년도
                                    + "&ENO_NO="+opener.eno_no; //학습자 사번
			trT_CM_EDUCATION.Post();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CM_EDUCATION_01.CountRow < 1 &&
                dsT_CM_EDUCATION_02.CountRow < 1 &&
                dsT_ED_LCTRHIST_03.CountRow < 1 &&
                dsT_CM_EDUCATION_04.CountRow < 1 &&
                dsT_ED_EXCEPTER_05.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }


             if(dsT_ED_EXCEPTER_05.CountRow > 0){
				form1.grdT_ED_EXCEPTER_05.GridToExcel("예외자이력", '', 225);
            }

            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.RunExcelSheetEx("사외교육이력", 1, 0);
            }

            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.RunExcelSheetEx("사내강의이력", 1, 0);
            }

            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.RunExcelSheetEx("사내교육이력", 1, 0);
            }

            if(dsT_CM_EDUCATION_01.CountRow > 0){
                form1.grdT_CM_EDUCATION_01.RunExcelSheetEx("교육점수현황", 1, 0);
            }

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_CM_EDUCATION_01,0,"false","false");      // Grid Style 적용
			form1.grdT_CM_EDUCATION_01.HiddenHScroll  = true;
			form1.grdT_CM_EDUCATION_01.HiddenVScroll  = true;
			form1.grdT_CM_EDUCATION_01.DisableNoHScroll = false;
			form1.grdT_CM_EDUCATION_01.DisableNoVScroll = false;

			cfStyleGrid(form1.grdT_CM_EDUCATION_02,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_ED_LCTRHIST_03,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_CM_EDUCATION_04,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_ED_EXCEPTER_05,0,"false","false");      // Grid Style 적용

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EDUCATION)		   |
    | 3. 사용되는 Table List(T_CM_EDUCATION) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_EDUCATION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_LCTRHIST_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_EXCEPTER_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

  	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadCompleted(iCount)">
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnFail()">
        cfErrorMsg(this);
    </script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">교육이력</td>
					<td align="right" class="navigator">HOME/교육관리/나의학습정보/과정참여현황/<font color="#000000">교육이력</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>교육점수현황</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:86px;">
						<param name="DataID" value="dsT_CM_EDUCATION_01">
						<param name="Format"				value="
							<G> name='학점합계'  HeadBgColor='#F7DCBB'
								<C> id='CPT_PNT_TOT'		width='100'		name='취득'			align='right'	Edit=none</C>
								<C> id='APP_POINT'			width='100'		name='인정'			align='right'	Edit=none</C>
							</G>
							<G> name='사내교육'  HeadBgColor='#F7DCBB'
								<C> id='CPT_PNT_AA1'		width='100'		name='필수'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB1'		width='100'		name='선택'			align='right'	Edit=none</C>
							</G>
                            <C> id='CPT_PNT_LCT'            width='99'      name='사내강의'           align='right'   Edit=none</C>
							<G> name='사외교육'  HeadBgColor='#F7DCBB'
								<C> id='CPT_PNT_AA2'		width='99'		name='필수'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB2'		width='99'		name='선택'			align='right'	Edit=none</C>
							</G>
							<C> id='CPT_PNT_EXP'			width='99'		name='예외학점'			align='right'	Edit=none</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사내교육이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_02">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='150'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='90'		name='차수'			align='center'		Edit=none				</C>
								<C> id='LCT_TIME'		width='85'		name='교육시간'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='형태'			align='center'		Edit=none				</C>
								<C> id='EDU_TAG'		width='90'		name='결과'			align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='85'		name='학점'			align='right'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사내강의이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_LCTRHIST_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_LCTRHIST_03">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='LCT_TAG'		width='150'		name='강의명'		align='left'		Edit=none				</C>
								<C> id='LCT_TIME'		width='70'		name='강의시간'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='강의일정'		align='center'		Edit=none				</C>
								<C> id='EDU_NM'			width='150'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='75'		name='차수'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='75'		name='형태'			align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='70'		name='학점'			align='right'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사외교육이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_04">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='150'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='LCT_TIME'		width='85'		name='교육시간'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='형태'			align='center'		Edit=none				</C>
								<C> id='INT_NAM'		width='90'		name='교육기관'		align='left'		Edit=none				</C>
								<C> id='PLACE_NM'		width='90'		name='교육장소'		align='left'		Edit=none				</C>
								<C> id='CPT_PNT'		width='85'		name='학점'			align='right'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>예외자이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_EXCEPTER_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_EXCEPTER_05">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EXC_NM'			width='540'		name='예외구분'		align='left'		Edit=none				</C>
								<C> id='CPT_PNT'		width='200'		name='학점'			align='right'		Edit=none				</C>
						">
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
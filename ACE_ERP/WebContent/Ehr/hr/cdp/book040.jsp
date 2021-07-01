<!--
*****************************************************
* @source       : BOOK040.jsp
* @description : 도서구입신청현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/03/15      이동훈        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>도서 구입 현황</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTTFTT';
		var chkValid  = 'T';


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	//검색조건
			var STR_YMD_SHR   = document.getElementById("txtSTR_YMD_SHR").value;      	//신청월
			var END_YMD_SHR   = document.getElementById("txtEND_YMD_SHR").value;      	//신청월
			var BOOK_NM_SHR   = document.getElementById("txtBOOK_NM_SHR").value;      	//도서


            //조회 해당년월을 저장한다.
			dsT_ED_BOOKMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.cdp.a.book030.cmd.BOOK030CMD"
                                      + "&S_MODE=SHR_40"
                                      + "&STR_YMD_SHR="+STR_YMD_SHR
                                      + "&END_YMD_SHR="+END_YMD_SHR
                                      + "&BOOK_NM_SHR="+BOOK_NM_SHR;
			dsT_ED_BOOKMASTER.reset();


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

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {


        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_ED_BOOKMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_ED_BOOKMASTER.GridToExcel("도서현황조회", '', 225);
        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {



        }

        /******************
         * 08. 유효성 검사 *
         ******************/
        function fnc_Valid() {


        }

        /******************
         * 08. 추가 함수  *
         ******************/
		function fnc_Append(){


		}

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {


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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //사용안하는 것들 막기

            //날짜값들 바인딩
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 1);

			document.getElementById("txtSTR_YMD_SHR").value = getToday().substring(0,7);
			document.getElementById("txtEND_YMD_SHR").value = svc_ymd.substring(0,7);


        	cfStyleGrid(form1.grdT_ED_BOOKMASTER,15,"false","true")      // Grid Style 적용

            //document.getElementById("resultMessage").innerText = '작업순서: 신청월 > 조회버튼 > 조회';

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

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_ED_BOOKMASTER)	|
    | 3. 사용되는 Table List(T_ED_BOOKMASTER)	        |
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-----------------------------+
    | grid에서 row를     클릭했을때 |
    +------ ------------------------>
	<script for=grdT_ED_BOOKMASTER event=OnClick(Row,Colid)>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">도서구입신청현황</td>
					<td align="right" class="navigator">HOME/교육관리/도서구입/<font color="#000000">도서구입신청현황</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
		  </font>
		</td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                	<col width="100"></col>
                    <col width="200"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                   <td class="searchState" align="right">도서신청월&nbsp;</td>
                   <td class="padding2423" align="left" id="key1"  style="display:">
									<input id="txtSTR_YMD_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','75','112');"></a>
									~
									<input id="txtEND_YMD_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YMD_SHR','','190','112');"></a>
                   </td>
                    <td align="right" class="searchState">도&nbsp;&nbsp;서&nbsp;</td>
					<td class="padding2423">
						<input id=txtBOOK_NM_SHR name=txtBOOK_NM_SHR size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
					</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->



<table border="0">
	<tr>
		<td valign="top">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">
			        	<!-- 마스터 정보 테이블 시작 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_ED_BOOKMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
										<param name="DataID"				value="dsT_ED_BOOKMASTER">
										<param name="SortView"				value="Left">
										<param name="Format"				value="
			            					<C> id='{CUROW}'		width=40	name='NO'			align=center	value={String(Currow)}	</C>
											<C> id='RQST_NO'		width=80	name='신청번호'		align=center	mask='XXXXXX-XXXX' suppress = '2' </C>
			            					<C> id='DPT_NM'			width=80	name='신청부서'		align=center	suppress = '1' </C>
											<C> id='JOB_NM'			width=60	name='직위'			align=center	show=false	suppress = '1' </C>
											<C> id='ENO_NO'			width=100	name='사번'			align=center	show=false	suppress = '1' </C>
											<C> id='ENO_NM'			width=80	name='신청자'		align=center	suppress = '1' </C>
											<C> id='BOOK_NM'		width=250	name='도서명'		align=left		</C>
											<C> id='BOOK_PUL'		width=100	name='출판사'		align=left		</C>
											<C> id='BOOK_WRT'		width=100	name='저자'			align=center	</C>
											<C> id='BOOK_QTY'		width=60	name='수량'			align=center	</C>
											<C> id='BOOK_AMT'		width=80	name='가격'			align=center	</C>
											<C> id='RQST_REMARK'	width=120	name='용도'			align=left		suppress = '1' </C>
											<C> id='BOOK_REMARK'	width=100	name='비고'			align=left		</C>
											<C> id='END_TAG'		width=100	name='결재상태'		align=center	suppress = '1' value={Decode(END_TAG,'R','저장','A','상신','N','부결','Y','결재완료','진행중')} </C>
										">
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
			                </tr>
			            </table>
			        	<!-- 마스터  정보 테이블 끝 -->
 					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>



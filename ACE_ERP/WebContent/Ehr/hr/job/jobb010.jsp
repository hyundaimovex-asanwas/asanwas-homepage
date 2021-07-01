<!--
    ************************************************************************************
    * @Source         : jobb010.jsp 					                                 *
    * @Description    : 직무이동희망자현황.           *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/30  |  안준성   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>직무이동희망자현황(jobb010)</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
		var btnList = 'T' + 'F' + 'T' + 'T' + 'T' + 'F' + 'F' + 'T';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			if( !fnc_SearchItemCheck() ) return;

			//소속
			if( document.getElementById("searchDiv").value == '1' ) {
	            //데이터셋 전송(직무이동희망자현황 조회)
	            dsT_EV_JOBCHG.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb010.cmd.JOBB010CMD&S_MODE=SHR&txtPIS_YYMM_SHR="+document.getElementById("txtPIS_YYMM_SHR").value+"&cmbOCC_CD_SHR="+document.getElementById("cmbOCC_CD_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtCODE_SHR").value;
	            dsT_EV_JOBCHG.Reset();
            }
			//직위
			if( document.getElementById("searchDiv").value == '2' ) {
	            //데이터셋 전송(직무이동희망자현황 조회)
	            dsT_EV_JOBCHG.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb010.cmd.JOBB010CMD&S_MODE=SHR&txtPIS_YYMM_SHR="+document.getElementById("txtPIS_YYMM_SHR").value+"&cmbOCC_CD_SHR="+document.getElementById("cmbOCC_CD_SHR").value+"&txtJOB_CD_SHR="+document.getElementById("txtCODE_SHR").value;
	            dsT_EV_JOBCHG.Reset();
            }


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

			if( !fnc_SaveItemCheck() )	return;

			//트랜잭션 전송
			trT_EV_JOBCHG.Action = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb010.cmd.JOBB010CMD&S_MODE=SAV";
			trT_EV_JOBCHG.Post();

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

            if (dsT_EV_JOBCHG.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_JOBCHG.GridToExcel("재직인원현황", '', 225)

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

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);
			document.getElementById("cmbOCC_CD_SHR").value = '';
			document.getElementById("searchDiv").value = '1';
			document.getElementById("txtCODE_SHR").value = '';
			document.getElementById("txtCODE_NM_SHR").value = '';

			document.getElementById("resultMessage").innerText = '';
			dsT_EV_JOBCHG.ClearAll();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_EV_JOBCHG.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			if( document.getElementById("txtPIS_YYMM_SHR").value == '' ) {
				alert("조사년월은 필수입력사항입니다.");
                document.getElementById("txtPIS_YYMM_SHR").focus();
				return false;
			}

			if( document.getElementById("txtPIS_YYMM_SHR").value != '' && cfDateExpr(document.getElementById("txtPIS_YYMM_SHR").value) == false ) {
				alert("조사년월이 날짜형식에 맞지않습니다.");
                document.getElementById("txtPIS_YYMM_SHR").focus();
				return false;
			}
			return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if ( dsT_EV_JOBCHG.isUpdated ) {

			} else {
				fnc_Message(document.getElementById("resultMessage"),"MSG_04");
				alert("저장 할 자료가 없습니다!");
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_JOBCHG, 15, "true", "false");

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);
            form1.grdT_EV_JOBCHG.RowHeight = "30";


        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************
         * 15. 조건에 따른 공통팝업창 분기  *
         *******************/
		function fnc_codePopup() {

			//소속
			if( document.getElementById("searchDiv").value == '1' )
				fnc_commnmPopup('txtCODE_SHR','txtCODE_NM_SHR','소속','DEPT')
			//직위
			if( document.getElementById("searchDiv").value == '2' )
				fnc_commonCodePopup('txtCODE_SHR','txtCODE_NM_SHR','직위','A2');


		}

        /********************
         * 16. 단축키 처리  *
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->

    <Object ID="dsT_EV_JOBCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_JOBCHG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_JOBCHG)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-- 그리드의 팝업필드 클릭시 -->
    <script language="javascript" for=grdT_EV_JOBCHG event=OnPopup(Row,Colid,data)>

		var obj = new String();

		obj.title = '소속';
		obj.gbn = 'DEPT';

		window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		if(obj.comm_cd != '' && obj.comm_nm != ''){
			dsT_EV_JOBCHG.NameValue(Row,"ACCEPT_DPTCD") = obj.comm_cd;
			dsT_EV_JOBCHG.NameValue(Row,"ACCEPT_DPTNM") = obj.comm_nm;
		}

    </script>

	<script language=JavaScript for=grdT_EV_JOBCHG event=OnExit(row,colid,olddata)>

		//소속정보 삭제
		if( colid == 'ACCEPT_DPTNM' ) {
			if( dsT_EV_JOBCHG.NameValue(row,colid) == '' )
				dsT_EV_JOBCHG.NameValue(row,'ACCEPT_DPTCD') = '';
		}

	</script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBCHG Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");

        } else {

			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_JOBCHG.CountRow);

        }

  	 	form1.txtPIS_YYMM_SHR.focus();//set focus

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_JOBCHG Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_JOBCHG Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_JOBCHG event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"),"MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_JOBCHG event="OnFail()">
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
	                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직무이동희망자현황</td>
	                    <td align="right" class="navigator">HOME/인사평가/직무관리/직무이동/<font color="#000000">직무이동희망자현황</font></td>
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
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',2)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
    				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',3)">  <img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<!-- 조건 입력 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td align="center" class="greenTable">
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <colgroup>
	                                <col width="50"></col>
	                                <col width="50"></col>
	                                <col width="50"></col>
	                                <col width="50"></col>
	                                <col width="70"></col>
	                                <col width="50"></col>
	                                <col width="200"></col>
	                            </colgroup>
	                            <tr>
	                                <td align="right" class="searchState">조사년월&nbsp;</td>
	                                <td class="padding2423">
									<input id="txtPIS_YYMM_SHR" style="ime-mode:disabled;text-align:center;" size="7" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();javascript:if(event.keyCode==13) fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','155','125');"><img src="/images/button/btn_HelpOn.gif" name="Image5" width="21" height="20" border="0" align="absmiddle"></a>
			                        </td>
	                                <td align="right" class="searchState">근로구분&nbsp;</td>
	                                <td class="">
										<select id="cmbOCC_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
											<option value='' selected>전체</option>
											<option value='A'>사무직</option>
											<option value='M'>택배직</option>
										</select>
									</td>
	                                <td align="right" class="searchState">조회구분&nbsp;</td>
	                                <td class="">
										<select id="searchDiv" style="WIDTH: 80%;" onChange="javascript:document.getElementById('txtCODE_SHR').value='';document.getElementById('txtCODE_NM_SHR').value='';">
											<option value='1' selected>소속</option>
											<option value='2'>직위</option>
										</select>
									</td>
									<td align="left">
										<input id="txtCODE_SHR" size="8" style="text-align:center;" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">&nbsp;<input id="txtCODE_NM_SHR" size="8" class="input_ReadOnly" readOnly>
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)" onClick="fnc_codePopup();"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle"></a>
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
		<table width="800" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="paddingTop8">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							<td align="right">&nbsp;</td>
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
	                        <object    id="grdT_EV_JOBCHG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
	                            <param name="DataID"                  value="dsT_EV_JOBCHG">
	                            <param name="EdiTABLE"                value="true">
	                            <param name="DragDropEnable"          value="true">
	                            <param name="SortView"                value="Left">
	                            <param name="VIEWSUMMARY"             value=0>
								<param name=UsingOneClick  value="1">
							    <param name="AutoReSizing"              value="true">
                            	<param name=ColSizing  value="true">

                                <param name="Format"                  value="
	                                <FC> id='PIS_YY'     width=80   name='해당년도'      align=center	edit=none	show=false </FC>
	                                <FC> id='PIS_MM'     width=80   name='해당월'        align=center 	edit=none	show=false </FC>
	                                <FC> id='HEAD_NM'    width=100   name='본부'          align=center   edit=none   suppress =1 </FC>
	                                <FC> id='DPT_NM'     width=100  name='소속'          align=center	edit=none   suppress =2 </FC>
	                                <FC> id='JOB_NM'     width=50   name='직위'          align=center   edit=none </FC>
	                                <FC> id='ENO_NO'     width=70   name='사번'          align=center 	 edit=none </FC>
	                                <FC> id='ENO_NM'     width=70   name='성명'          align=center   edit=none </FC>
	                                <C> id='HIR_YMD'     width=70   name='입사일'        align=center	edit=none </C>
	                                <C> id='BIR_YMD'     width=70   name='생년월일'      align=center	edit=none </C>
	                                <C> id='JPR_YMD'     width=70   name='승진일'        align=center	edit=none </C>
	                                <C> id='DPA_YMD'     width=70   name='현소속;발령일' align=center 	edit=none </C>
	                                <C> id='DHO_YMD'     width=70   name='소속;재직기간' align=center 	edit=none		value={String(DHO_YMD)} </C>
	                                <C> id='EXM_PNT'     width=50   name='TOEIC'         align=center 	edit=none </C>
                                    <C> id='ANS_YN'      width=50   name='설문;여부'      align=center   edit=none </C>

                                    <G> name='희망소속' HeadBgColor='#F7DCBB'
	                                    <C> id='HOPE_DEP1'     width=100    name='1지망'        align=center 	edit=none </C>
	                                    <C> id='HOPE_DEP2'     width=100    name='2지망'        align=center 	edit=none </C>
	                                    <C> id='HOPE_DEP3'     width=100    name='3지망'        align=center 	edit=none </C>
	                                </G>

                                    <G> name='이동희망자' HeadBgColor='#F7DCBB'
                                        <C> id='CHANGE_GBN'  width=150   name='이동사유'        align=center   edit=none </C>
                                        <C> id='CHANGE_DEC'  width=250   name='기타사유'        align=left     edit=none Multiline=true </C>
                                        <C> id='CHANGE_TIME' width=100   name='이동시기'        align=center   edit=none </C>
                                    </G>

                                    <G> name='확정' HeadBgColor='#F7DCBB'
	                                    <C> id='ACCEPT_GBN'    width=30    name='가부'         align=center		editstyle=checkbox </C>
	                                    <C> id='ACCEPT_DPTCD'  width=80    name='소속'         align=center		show=false </C>
	                                    <C> id='ACCEPT_DPTNM'  width=80    name='소속명'       align=center		editstyle=popup </C>
	                                </G>
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
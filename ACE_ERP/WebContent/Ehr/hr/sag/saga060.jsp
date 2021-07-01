<!--
    ************************************************************************************
    * @source         : saga060.jsp 				                                   					*
    * @description   : 급여지급현황 PAGE.                                            				*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            			*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/01/14      이동훈        ERP 이사
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>급여지급현황</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; 	// 시작년월
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; 	// 종료년월


			//시작년월이 없으면 조회못함.
			if(STR_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//시작년월이 잘못되었으면 조회못함.
			if(STR_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(END_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(END_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 안된다.
			if(parseInt(END_YYMM_SHR.replaceStr("-","")) < parseInt(STR_YYMM_SHR.replaceStr("-",""))){
					alert("종료년월이 시작년월보다 빠릅니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}


            //데이터셋 전송
            dsT_CP_PAYMASTER.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR&STR_YYMM_SHR="+STR_YYMM_SHR
																								            +"&END_YYMM_SHR="+END_YYMM_SHR;

            dsT_CP_PAYMASTER.Reset();

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

			fnc_Report_4_1();	 		//총인원

			//fnc_Report_4_2();  			//임원

			fnc_Report_4_3();  			//임원외 상세

			gcrp_print.Preview();



        }


		/******************************************************************************
			Description : 급여지급현황 총인원보고서(Fheader 부분)
		******************************************************************************/
		function fnc_Report_4_1(){

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // 적용일자
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // 직위구분

			dsT_RP_REPORT.ClearAll();

            dsT_RP_REPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR_PRINT&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR;
            dsT_RP_REPORT.Reset();

		}

		/******************************************************************************
			Description : 급여지급현황 임원 지급 현황
		******************************************************************************/
		function fnc_Report_4_2(){

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // 적용일자
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // 직위구분

			dsT_RP_REPORT2.ClearAll();

            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR_PRINT_02&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR;
            dsT_RP_REPORT2.Reset();

		}

		/******************************************************************************
			Description : 급여지급현황 임원 지급 현황
		******************************************************************************/
		function fnc_Report_4_3(){

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // 적용일자
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // 직위구분

			dsT_RP_REPORT3.ClearAll();

            dsT_RP_REPORT3.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR_PRINT_03&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR;
            dsT_RP_REPORT3.Reset();

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

			fnc_ChangeGrid();      //그리드 변경 처리

            //날짜값들 바인딩
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, -1);
            document.getElementById("txtSTR_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월 From
            svc_ymd     = addDate("M", gcurdate, 0);
            document.getElementById("txtEND_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월 To


			//값이 없어서 하이픈만 나오는거 방지
			var STR_YYMM_SHR = (document.getElementById("txtSTR_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(STR_YYMM_SHR.trim() == ""){
				document.getElementById("txtSTR_YYMM_SHR").value = "";
			}

			var END_YYMM_SHR = (document.getElementById("txtEND_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(END_YYMM_SHR.trim() == ""){
				document.getElementById("txtEND_YYMM_SHR").value = "";
			}

			fnc_SearchList();
			
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*************************
         * 그리드 변경 처리               *
         ************************/
		function fnc_ChangeGrid(obj) {

			if(obj == undefined || obj.value == "A"){
				form1.grdT_CP_PAYMASTER.Format = "<FC> id='{CUROW}'				width=40		name='NO'						align=center		value={String(Currow)}				</FC>" +
												"<FC> id='DPT_NM'				width=85		name='소속'						align=center					</FC>" +
												"<C> id='ENO_NO'        		width=55        name='사번'          			align=center    Edit=none  </C>" +
												"<C> id='ENO_NM'        		width=70        name='성명'          			align=center    Edit=none  </C>" +
												"<C> id='JOB_NM'        		width=80       	name='직위'        				align=center    Edit=none  </C>" +
												"<C> id='P01_AMT'       		width=80        name='기본급'        				align=right                     </C>" +
												"<C> id='P02_AMT'       		width=80        name='시간외'        				align=right                     </C>" +
												"<C> id='P03_AMT'       		width=80        name='휴일근무'       			align=right                     </C>" +
												"<C> id='P04_AMT'       		width=80        name='특수지'     				align=right                     </C>" +
												"<C> id='P05_AMT'       		width=80        name='조정'       				align=right                     </C>" +
												"<C> id='SALT_AMT'				width=80		name='합계'						align=right						</C>" +
												"<C> id='SUM_DED'			    width=80		name='공제계'						align=right						</C>" +
												"<C> id='PAY_AMT'				width=80		name='실수령액'					align=right						</C>";

            }

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_CP_PAYMASTER,0,"false","false");
			

		}



</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CP_PAYMASTER                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!----------------------------------------------+
    | 1. 레포트용 DataSet                     		|
    | 2. 이름 : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtSTR_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // 시작년월
			document.getElementById("txtEND_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // 종료년월

			document.getElementById("txtSTR_YYMM_SHR").focus();
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="30"></col>
								<col width="200"></col>
								<col width="100"></col>
								<col width="200"></col>
								<col width="100"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">기&nbsp;&nbsp;&nbsp;간</td>
								<td align="left" >
									<input id="txtSTR_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									&nbsp;~&nbsp;
									<input id="txtEND_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:450px;">
							<param name="DataID"							value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"						value="false">
							<param name="DragDropEnable"				value="true">
							<param name="SortView"						value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    			value="dsT_RP_REPORT3">
	<PARAM NAME="PaperSize"						VALUE="A4">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format" 						VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='dsT_RP_REPORT'
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=558 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=894 ,top=5 ,right=1918 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<L> left=32 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='구  분' ,left=45 ,top=241 ,right=246 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=360 ,right=2781 ,bottom=360 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=550 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='월' ,left=201 ,top=373 ,right=246 ,bottom=421 ,face='굴림' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='.' ,left=138 ,top=373 ,right=164 ,bottom=421 ,face='굴림' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='월' ,left=201 ,top=431 ,right=246 ,bottom=482 ,face='굴림' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='.' ,left=138 ,top=431 ,right=164 ,bottom=482 ,face='굴림' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='전월대비증감' ,left=77 ,top=492 ,right=246 ,bottom=540 ,align='right' ,face='굴림' ,size=8 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=230 ,right=32 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=230 ,right=257 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=230 ,right=352 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1680 ,top=294 ,right=1680 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=590 ,top=230 ,right=590 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2474 ,top=230 ,right=2474 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=230 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='Print Date:' ,left=2250 ,top=132 ,right=2500 ,bottom=180 ,align='right' ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1   총인원' ,left=32 ,top=180 ,right=241 ,bottom=222 ,align='left' ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=1685 ,top=299 ,right=1894 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=69 ,top=484 ,right=2781 ,bottom=484 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='소득세' ,left=598 ,top=299 ,right=767 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='국민연금' ,left=1132 ,top=299 ,right=1302 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='건강보험' ,left=955 ,top=299 ,right=1124 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='단위 : 원' ,left=2580 ,top=180 ,right=2783 ,bottom=222 ,align='right' ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=71 ,top=484 ,right=71 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=590 ,top=294 ,right=1680 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1677 ,top=294 ,right=1900 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='인원' ,left=270 ,top=241 ,right=347 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='실지급액' ,left=2487 ,top=241 ,right=2773 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>

			<T>id='월' ,left=1312 ,top=1 ,right=1384 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='급여 지급 현황' ,left=1390 ,top=1 ,right=1868 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='년' ,left=1138 ,top=1 ,right=1220 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>

			<L> left=773 ,top=296 ,right=773 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=426 ,right=2781 ,bottom=426 </L>
			<L> left=953 ,top=296 ,right=953 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1127 ,top=296 ,right=1127 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1307 ,top=296 ,right=1307 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1487 ,top=296 ,right=1487 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='회사지원' ,left=1905 ,top=238 ,right=2461 ,bottom=288 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1900 ,top=230 ,right=1900 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2265 ,top=294 ,right=2265 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='계' ,left=2270 ,top=299 ,right=2466 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1902 ,top=294 ,right=2294 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2270 ,top=294 ,right=2471 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='고용보험' ,left=1910 ,top=299 ,right=2080 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='산재보험' ,left=2090 ,top=299 ,right=2260 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='지급계' ,left=381 ,top=241 ,right=561 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='공제내역' ,left=601 ,top=238 ,right=1886 ,bottom=288 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세' ,left=778 ,top=299 ,right=947 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=1492 ,top=299 ,right=1672 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='고용보험' ,left=1312 ,top=299 ,right=1482 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2082 ,top=296 ,right=2082 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>

			<C>id='CYYYY', left=963, top=13, right=1135, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<C>id='CMM', left=1222, top=13, right=1310, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<C>id='CTITLE', left=1416, top=13, right=1553, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<C>id='TODATEE', left=2500, top=132, right=2783, bottom=180, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CYYYYO', left=45, top=373, right=140, bottom=421, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CMMO', left=153, top=373, right=204, bottom=421, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COUNTP', left=273, top=373, right=349, bottom=421, align='right'</C>
			<C>id='CYYYY', left=45, top=431, right=140, bottom=482, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CMM', left=153, top=431, right=204, bottom=482, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COUNTR', left=270, top=431, right=347, bottom=482, align='right'</C>
			<C>id='{COUNTR-COUNTP}', left=270, top=492, right=347, bottom=540, align='right', Dec=0</C>
			<C>id='S91000', left=360, top=373, right=582, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S91000R-S91000}', left=360, top=492, right=582, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S91000R', left=360, top=431, right=582, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='T11000', left=598, top=373, right=773, bottom=421, align='right'</C>
			<C>id='T11000R', left=598, top=429, right=773, bottom=479, align='right'</C>
			<C>id='{T11000R-T11000}', left=598, top=489, right=773, bottom=537, align='right', Dec=0</C>
			<C>id='T12000', left=778, top=373, right=953, bottom=421, align='right'</C>
			<C>id='T12000R', left=778, top=431, right=953, bottom=482, align='right'</C>
			<C>id='{T12000R-T12000}', left=778, top=492, right=953, bottom=540, align='right', Dec=0</C>
			<C>id='B11000', left=955, top=373, right=1124, bottom=421, align='right'</C>
			<C>id='B11000R', left=955, top=431, right=1124, bottom=482, align='right'</C>
			<C>id='{B11000R-B11000}', left=955, top=492, right=1124, bottom=540, align='right', Dec=0</C>
			<C>id='B12000', left=1132, top=373, right=1307, bottom=421, align='right'</C>
			<C>id='B12000R', left=1132, top=431, right=1307, bottom=482, align='right'</C>
			<C>id='{B12000R-B12000}', left=1132, top=492, right=1307, bottom=540, align='right', Dec=0</C>
			<C>id='B13000', left=1310, top=373, right=1484, bottom=421, align='right'</C>
			<C>id='B13000R', left=1310, top=431, right=1484, bottom=482, align='right'</C>
			<C>id='{B13000R-B13000}', left=1310, top=492, right=1484, bottom=540, align='right', Dec=0</C>
			<C>id='BXTOTAL', left=1490, top=376, right=1677, bottom=423, align='right'</C>
			<C>id='BXTOTALR', left=1490, top=434, right=1677, bottom=484, align='right'</C>
			<C>id='{BXTOTALR-BXTOTAL}', left=1490, top=495, right=1677, bottom=542, align='right', Dec=0</C>
			<C>id='S93000', left=1685, top=373, right=1894, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S93000R', left=1685, top=431, right=1894, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S93000R-S93000}', left=1685, top=492, right=1894, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='B23000', left=1910, top=373, right=2080, bottom=421, align='right'</C>
			<C>id='B23000R', left=1910, top=431, right=2080, bottom=482, align='right'</C>
			<C>id='{B23000R-B23000}', left=1910, top=492, right=2080, bottom=540, align='right', Dec=0</C>
			<C>id='B17000', left=2090, top=373, right=2260, bottom=421, align='right'</C>
			<C>id='B17000R', left=2090, top=431, right=2260, bottom=482, align='right'</C>
			<C>id='{B17000R-B17000}', left=2090, top=492, right=2260, bottom=540, align='right', Dec=0</C>
			<C>id='B23170', left=2270, top=373, right=2466, bottom=421, align='right'</C>
			<C>id='B23170R', left=2270, top=431, right=2466, bottom=482, align='right'</C>
			<C>id='{B23170R-B23170}', left=2270, top=492, right=2466, bottom=540, align='right', Dec=0</C>
			<C>id='S94000', left=2487, top=373, right=2773, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S94000R', left=2487, top=431, right=2773, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S94000R-S94000}', left=2487, top=492, right=2773, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>

		</B>
	</R>
</A>




<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='dsT_RP_REPORT3'
		<B>id=default ,left=0,top=0 ,right=2871 ,bottom=415 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=32 ,top=77 ,right=2781 ,bottom=77 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='구  분' ,left=45 ,top=87 ,right=246 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='TAX_DPTNM', left=146, top=21, right=860, bottom=66, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=32 ,top=206 ,right=2781 ,bottom=206 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='월' ,left=201 ,top=220 ,right=246 ,bottom=267 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=220, right=204, bottom=267, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=220 ,right=164 ,bottom=267 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYYO', left=45, top=220, right=140, bottom=267, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CYYYY', left=45, top=278, right=140, bottom=328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=32 ,top=273 ,right=2781 ,bottom=273 </L>
			<T>id='월' ,left=201 ,top=278 ,right=246 ,bottom=328 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=278, right=204, bottom=328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=278 ,right=164 ,bottom=328 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='인원' ,left=270 ,top=87 ,right=347 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=71 ,top=331 ,right=2781 ,bottom=331 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='{COUNTR-COUNTP}', left=270, top=339, right=347, bottom=386, align='right', Dec=0</C>
			<C>id='COUNTR', left=270, top=278, right=347, bottom=328, align='right'</C>
			<C>id='COUNTP', left=270, top=220, right=347, bottom=267, align='right'</C>
			<L> left=257 ,top=79 ,right=257 ,bottom=392 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=32 ,top=397 ,right=2781 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='전월대비증감' ,left=77 ,top=339 ,right=246 ,bottom=386 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=79 ,right=32 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=593 ,top=79 ,right=593 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='주민세' ,left=778 ,top=148 ,right=945 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='소득세' ,left=598 ,top=148 ,right=767 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='건강보험' ,left=955 ,top=148 ,right=1124 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='국민연금' ,left=1132 ,top=148 ,right=1302 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=947 ,top=140 ,right=947 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S93000', left=1683, top=220, right=1892, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1675 ,top=140 ,right=1675 ,bottom=397 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2474 ,top=79 ,right=2474 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='실지급액' ,left=2487 ,top=87 ,right=2773 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='{S94000R-S94000}', left=2487, top=339, right=2773, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2487, top=278, right=2773, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S94000', left=2487, top=220, right=2773, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2781 ,top=79 ,right=2781 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='{S91000R-S91000}', left=357, top=339, right=579, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S91000R', left=357, top=278, right=579, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000', left=357, top=220, right=579, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=352 ,top=77 ,right=352 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=773 ,top=140 ,right=773 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=71 ,top=333 ,right=71 ,bottom=400 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='{currow+1}', left=32, top=21, right=135, bottom=66, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S93000R', left=1683, top=278, right=1892, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S93000R-S93000}', left=1683, top=339, right=1892, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='계' ,left=1683 ,top=148 ,right=1892 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=1487 ,top=148 ,right=1672 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='지급계' ,left=360 ,top=87 ,right=582 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1127 ,top=140 ,right=1127 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1304 ,top=143 ,right=1304 ,bottom=400 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='고용보험' ,left=1310 ,top=148 ,right=1479 ,bottom=198 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T11000', left=598, top=220, right=767, bottom=267, align='right'</C>
			<C>id='T11000R', left=598, top=278, right=767, bottom=328, align='right'</C>
			<C>id='{T11000R-T11000}', left=598, top=339, right=767, bottom=386, align='right', Dec=0</C>
			<L> left=1482 ,top=143 ,right=1482 ,bottom=400 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1900 ,top=77 ,right=1900 ,bottom=394 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1675 ,top=140 ,right=1897 ,bottom=140 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='공제내역' ,left=598 ,top=87 ,right=1889 ,bottom=138 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='고용보험' ,left=1908 ,top=143 ,right=2077 ,bottom=193 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2080 ,top=140 ,right=2080 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='회사지원' ,left=1910 ,top=85 ,right=2455 ,bottom=135 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2260 ,top=140 ,right=2260 ,bottom=397 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='산재보험' ,left=2085 ,top=143 ,right=2254 ,bottom=193 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=2262 ,top=143 ,right=2466 ,bottom=193 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T12000', left=775, top=220, right=942, bottom=267, align='right'</C>
			<C>id='B11000', left=953, top=220, right=1122, bottom=267, align='right'</C>
			<C>id='B12000', left=1132, top=220, right=1302, bottom=267, align='right'</C>
			<C>id='B13000', left=1310, top=220, right=1479, bottom=267, align='right'</C>
			<C>id='BXTOTAL', left=1487, top=220, right=1672, bottom=267, align='right'</C>
			<C>id='T12000R', left=775, top=278, right=942, bottom=328, align='right'</C>
			<C>id='B11000R', left=953, top=278, right=1122, bottom=328, align='right'</C>
			<C>id='B12000R', left=1132, top=278, right=1302, bottom=328, align='right'</C>
			<C>id='B13000R', left=1310, top=278, right=1479, bottom=328, align='right'</C>
			<C>id='BXTOTALR', left=1487, top=278, right=1672, bottom=328, align='right'</C>
			<C>id='{T12000R-T12000}', left=775, top=339, right=942, bottom=386, align='right', Dec=0</C>
			<C>id='{B11000R-B11000}', left=953, top=339, right=1122, bottom=386, align='right', Dec=0</C>
			<C>id='{B12000R-B12000}', left=1132, top=339, right=1302, bottom=386, align='right', Dec=0</C>
			<C>id='{B13000R-B13000}', left=1310, top=339, right=1479, bottom=386, align='right', Dec=0</C>
			<C>id='{BXTOTALR-BXTOTAL}', left=1487, top=339, right=1672, bottom=386, align='right', Dec=0</C>
			<L> left=595 ,top=140 ,right=1672 ,bottom=140 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='B23000', left=1905, top=220, right=2074, bottom=267, align='right'</C>
			<C>id='B17000', left=2088, top=220, right=2257, bottom=267, align='right'</C>
			<C>id='B23170', left=2265, top=220, right=2466, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='B23000R', left=1905, top=278, right=2074, bottom=328, align='right'</C>
			<C>id='B17000R', left=2088, top=278, right=2257, bottom=328, align='right'</C>
			<C>id='{B23000R-B23000}', left=1905, top=339, right=2074, bottom=386, align='right', Dec=0</C>
			<C>id='{B17000R-B17000}', left=2088, top=339, right=2257, bottom=386, align='right', Dec=0</C>
			<C>id='{B23170R-B23170}', left=2265, top=339, right=2466, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='B23170R', left=2265, top=278, right=2466, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1902 ,top=140 ,right=2262 ,bottom=140 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2257 ,top=140 ,right=2471 ,bottom=140 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		</B>



	</R>
</A>



<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../images/common/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>



">
</OBJECT>






</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


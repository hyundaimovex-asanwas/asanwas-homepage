<!--
*****************************************************
* @source       : gunf041.jsp
* @description : 근무형태 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/01/23      이동훈        최초 작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
    String prmENO_NO   = request.getParameter("ENO_NO");
	String prmYYYY     = request.getParameter("YYYY");
	String prmMONTH    = request.getParameter("MONTH");
%>

<html>
<head>
<title>근무 확인</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var prmENO_NO   = "<%=prmENO_NO %>";    //사번

        var prmYYYY     = "<%=prmYYYY %>";      //연도
        
        var prmMONTH    = "<%=prmMONTH %>";     //월        
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
			var eno_no = prmENO_NO;		//사번
			var yyyy   = prmYYYY;		//연도
			var mm     = prmMONTH;		//월
			
			//alert("eno_no: "+eno_no);
			//alert("yyyy: "+yyyy);
			//alert("mm: "+mm);			
			
			//dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf070.cmd.GUNF070CMD&S_MODE=SHR_DTL&ENO_NO="+eno_no;
			
			dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf040.cmd.GUNF040CMD&S_MODE=SHR_DTL&ENO_NO="+eno_no+"&PIS_YM="+yyyy+mm;			
			
			dsT_DI_WORKSTYLE.reset();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
            if (dsT_DI_WORKSTYLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_MONTHLY.GridToExcel("월차확인", '', 225);

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

			cfStyleGrid_New(form1.grdT_DI_MONTHLY,15,"false","false");      // Grid Style 적용

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
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_WORKSTYLE                      |
    | 3. Table List : T_DI_MONTHLY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_WORKSTYLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
		<PARAM NAME="SubsumExpr"	  VALUE="total,1:WEEK_NO">          
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut           value=2000000>
 
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_WORKSTYLE)		|
    | 3. 사용되는 Table List(T_DI_MONTHLY)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_MONTHLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_MONTHLY.focus();
        }

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>



    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_MONTHLY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_MONTHLY event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>



<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> 
	        <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->



<!-- 내용 조회 그리드 테이블 시작-->
<table width="950" border="0" cellspacing="0" cellpadding="0">
		<tr align="center">
			<td>
				<comment id="__NSID__">
				<object	id="grdT_DI_MONTHLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:400px;">
					<param name="DataID"				value="dsT_DI_WORKSTYLE">
					<param name="EdiTABLE"				value="false">
					<param name="DragDropEnable"		value="true">
					<param name="SortView"				value="Left">
					<param name="VIEWSUMMARY"			value=0>
					<param name="Format"				value="
								<C> id='WEEK_NO'		width=50			name='주차'					align=center			suppress=1 Value={Decode(CurLevel,1,'소계',WEEK_NO)}</C> 								
								<C> id='DPT_NM'			width=120			name='소속'					align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='ENO_NM'			width=80			name='성명'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='HOL_YN'			width=50			name='휴일'					align=center			show=false</C>
								<C> id='REG_YMD'		width=100			name='일자'					align=center			MASK='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='YOIL'			width=50			name='요일'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='GUBUN'			width=80			name='구분'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='STR_TIME'		width=100			name='근무시작'				align=center			</C>
								<C> id='END_TIME'		width=100			name='근무종료'				align=center			</C>		
								<C> id='WRK_TIME'		width=100			name='근무시간'				align=center			DEC=1</C>			
								<C> id='WEEK_TOT_TIME'	width=100			name='연장\\근로시간'			align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='REMARK'			width=300			name='사유'					align=left			</C>
							">
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>
		</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

